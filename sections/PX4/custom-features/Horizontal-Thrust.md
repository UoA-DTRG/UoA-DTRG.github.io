# Description
![Horizontal Thrust Cover](/resources/images/horizontal-thrust-cover.png)

This document contains a simple how to style guide for using the horizonal thrust feature implemented in the DTRG fork of the PX4 firmware as well as outlining implementation steps and relevant documentation of modules.

# How to Use

This section outlines how to configure and use the DTRG HT feature. 

> [!WARNING]
> This guide demonstrates the recommended configuration however it should be noted that with the use of parameters this behaviour can be customized. Please make sure that you check the parameters of any **UAV and transmitter** before you attempt to use this feature.

### Step 1 - Firmware 

Ensure that the flight controller is running the most up to date version of the DTRG PX4 firmware. If any of the following parameters are missing this likely indicates that the firmware is out of date.

> [!IMPORTANT]
> This feature was introduced in Custom FW. Ver. 1.1.0. To use this feature please ensure the firmware on the flight controller is  1.1.0 or above.
<img src="/resources/images/custom-firmware-example.png" width="200"/>



The required firmware binary can be found at https://github.com/UoA-DTRG/PX4-Autopilot under releases or by building from the source code for your required build. Build instructions are available in the DTRG documentation along with official guides on the PX4 Wiki.
### Step 2 - Configuration
Enabling the feature in QGC, to enable the horizontal thrust via manual control enable the parameter under the parameters tab of QGC.

The DTRG branch of PX4 has many parameters for configuring the behaviour of the Horizontal Thrust feature.

DTRG_HT_EN - enabled horizontal flight, NO Restart needed can and should be bound to a switch
DTRG_HT_CH - What channel to use for the switch to enable / disable the feature
DTRG_HT_R - Channel to use for roll setpoint when flying in HT mode
DTRG_HT_P - Channel to use for pitch setpoint when flying in HT mode
DTRG_HT_MAX - Limits for the level of horizontal thrust to demand before to avoid rotor saturation. 
DTRG_R_MAX - Limit for the maximum roll angle setpoint when using HT in a position based mode
DTRG_P_MAX - Limit for the maximum pitch angle setpoint when using HT in a position based mode

> [!NOTE]
> Receivers such as the TGY-iA10 that only work with PPM only have 8 channels available, PX4 will be unable to receive any inputs on channels 9 and above. The recommended configuration requires use of a SBUS, IBUS, or CRSF receiver that allows 10 or more channels

The recommended channel configuration is as follows:
Channel 1 - Roll / HT_Y
Channel 2 - Pitch / HT_X
Channel 3 - Thrust
Channel 4 - Yaw
Channel 5 - Flight Mode
Channel 6 - Arm
Channel 7 - Offboard
Channel 8 - HT Enable / Disable
Channel 9 - Kill switch
Channel 10 - HT Roll
Channel 11 - HT Pitch
### Step 4 - Transmitter

Setup the radio transmitter. Setup the transmitter how you would like ensuring that the channels selected in QGC correspond to the desired input method. This documentation demonstrates configuring a RadioMaster Boxer transmitter. 

The recommended configuration is two flight modes in the EdgeTX model one for attitude and one for horizontal thrust flying. The flight mode switch is then bound to the same switch as the channel for PX4 (DTRG_HT_CH). This should be bound to SB

The figure below indicates some common labels for the controls. 
![Radiomaster Boxer Example Setup](/resources/images/horizontal-thrust-radiomaster.png)

In mode 1 we configure the channel outputs as normal. This is done in the mixer tab by selecting the modes which are valid for the specific mode, in this case roll and pitch channels are valid for both 1 and 2 because in mode 2 they become the HT_X and HT_Y. The roll and pitch channels however are disabled for mode 1 and only enabled in mode 2. We can also map the enable channel to either a MAX channel only enabled in flight mode 2 or the enable switch.

> [!TIP] 
> **Struggling with EdgeTX?**\
> Useful resource for learning how to use EdgeTX: https://youtube.com/playlist?list=PLwoDb7WF6c8lhlzE6_iA2X50bk3pIYcbb&si=ERgE0TcfTNCug-gc
### Flight Modes

The HT feature works across manual and position based modes including but not limited to position, altitude and offboard. It should be noted that currently 6DOF offboard control is not possible (i.e. publishing roll and pitch setpoints in HT Offboard mode). 

> [!CAUTION] 
> **Ensure channels are receiving properly!**\
> In some cases px4 defaults to an extreme value for the radio channel if no signal is found leading to a max control setpoint. i.e. when setting channel 9 for a PPM receiver. Please test using MAVLINK console in QGC to ensure radio signal is being received on the channel before flying.
### Tuning and Safety

As always it is important to have a kill switch properly configured before flying any UAVs. In the DTRG this is typically done on channel 9.

There are two? parameters available for tuning the response of the UAV in HT mode DTRG_MHT_GAIN and DTRG_PHT_GAIN for manual and position based flight respectively. These gains start at recommended values however may need adjusting based on saturation and the airframe configuration. It is recommended to use small increments when tuning these gains to avoid a potentially unstable response.
# Implementation Details

This section covers the implementation of this feature in PX4 release/1.14. Several changes had been made throughout the mc_attitude and mc_position control modules.
## Parameters

Parameters are declared in `mc_pos_control_params.c` and `mc_att_control_params.c` 
### Default Parameter Values


| *mc_att_control_params* |                             |                  |
| ----------------------- | --------------------------- | ---------------- |
| **DTRG_HT_EN**          | **DTRG_HT_RC_EN** (channel) | **DTRG_HT_MAX**  |
| false                   | 8                           | 0.5f             |
| *mc_pos_control_params* |                             |                  |
| **DTRG_HT_R**           | **DTRG_HT_P**               | **DTRG_HT_MASK** |
| 10                      | 11                          | 0                |
| **DTRG_R_MAX** (deg)    | **DTRG_P_MAX** (deg)        |                  |
| 10                      | 10                          |                  |
## Data Flow for Setpoints

The below figure indicates the data flow for setpoints from a pilot in both manual and position based flight modes (not including acro manual). Blocks indicate modules with the associated uORB topic or protected variable (blue) used to pass the values between modules.

![[PX4 Control Call Stack(1).png]]
## Getting the RC Channels
The RC input is obainted through the RC_Channels topic. This topic is designed for 27 channels laid out in the following order:

| Function Name       | Address | Function Name              | Address |     |
| ------------------- | ------- | -------------------------- | ------- | --- |
| FUNCTION_THROTTLE   | 0       | FUNCTION_PARAM_1           | 14      |     |
| FUNCTION_ROLL       | 1       | FUNCTION_PARAM_2           | 15      |     |
| FUNCTION_PITCH      | 2       | FUNCTION_PARAM_3_5         | 16      |     |
| FUNCTION_YAW        | 3       | FUNCTION_KILLSWITCH        | 17      |     |
| FUNCTION_RETURN     | 4       | FUNCTION_TRANSITION        | 18      |     |
| FUNCTION_LOITER<br> | 5       | FUNCTION_ARMSWTICH         | 19      |     |
| FUNCTION_OFFBOARD   | 6       | FUNCTION_FLTBTN_SLOT_1     | 20      |     |
| FUNCTION_FLAPS      | 7       | FUNCTION_FLTBTN_SLOT_2     | 21      |     |
| FUNCTION_AUX_1<br>  | 8       | FUNCTION_FLTBTN_SLOT_3     | 22      |     |
| FUNCTION_AUX_2      | 9       | FUNCTION_FLTBTN_SLOT_4     | 23      |     |
| FUNCTION_AUX_3      | 10      | FUNCTION_FLTBTN_SLOT_5     | 24      |     |
| FUNCTION_AUX_4<br>  | 11      | FUNCTION_FLTBTN_SLOT_6     | 25      |     |
| FUNCTION_AUX_5      | 12      | FUNCTION_ENGAGE_MAIN_MOTOR | 26      |     |
| FUNCTION_AUX_6      | 13      |                            |         |     |

Notice the address is shifted down by 1 from the channel number. I.e. channel 5 is mapped to ``rc_channels[4]``. Input address is obtained by grabbing the parameter set in QGC and shifting it down by 1. This address is then used in the rc_channels topic to get the current control value on the channel.

RC Channels are used to inject the roll and pitch commands in HT mode when flying.
## HT Manual Flight Mode Changes

For HT in manual flight changes have been made exclusively in the mc_att_control module. These include:
```c++
// mc_att_control_main : 97
	_ht_en = _param_dtrg_ht_en.get();
	if (_ht_en){
		_ht_rc_en_add = _param_dtrg_ht_rc_en.get();
		_ht_limit = _param_dtrg_ht_max.get();
		_ht_r_add = _param_dtrg_h_t_R.get()-1;
		_ht_p_add = _param_dtrg_h_t_P.get()-1;
		_dtrg_ht_mask = _param_dtrg_ht_mask.get();
	}
```
store parameters in private variables to prevent constant parameter checking
```c++
//mc_att_control_main.cpp : 127
if (_ht_en) _rc_channels_sub.update(&_rc_channels);
```
RC channels are only used by the HT hence only update if the feature is enabled
```c++
//mc_att_control_main.cpp : 156
	Vector2f v = Vector2f();
	if (_ht_en && (_rc_channels.channels[_ht_rc_en_add -1] > 0.5f)){
		v = Vector2f(_man_roll_input_filter.update(_rc_channels.channels[_ht_r_add] * _man_tilt_max),
		-_man_pitch_input_filter.update(_rc_channels.channels[_ht_p_add] * _man_tilt_max));
	}else{
		v = Vector2f(_man_roll_input_filter.update(_manual_control_setpoint.roll * _man_tilt_max),
				      -_man_pitch_input_filter.update(_manual_control_setpoint.pitch * _man_tilt_max));
	}
```

```c++
// mc_att_control_main.cpp : 190
	if(_ht_en && (_rc_channels.channels[_ht_rc_en_add -1] > 0.5f))
	{
		// DTRG horizontal thrust saturation topic
		horizontal_thrust_limit_s hzlim_msg{};
		hzlim_msg.timestamp = hrt_absolute_time();
		hzlim_msg.x_sat = 0;
		hzlim_msg.y_sat = 0;

		// Constrain thrust and check for saturation
		// Pick and Choose the horizontal thrust stuff using parameter
		if (_dtrg_ht_mask == 1) { //roll for y
			attitude_setpoint.roll_body = _manual_control_setpoint.roll * _man_tilt_max;
			attitude_setpoint.thrust_body[0] = math::constrain(_manual_control_setpoint.pitch * _ht_limit, -_ht_limit, _ht_limit);
		} else if (_dtrg_ht_mask == 2) { //pitch for x
			attitude_setpoint.pitch_body = _manual_control_setpoint.pitch * _man_tilt_max;
			attitude_setpoint.roll_body = _rc_channels.channels[_ht_r_add] * _man_tilt_max;
			attitude_setpoint.thrust_body[1] = math::constrain(_manual_control_setpoint.roll * _ht_limit, -_ht_limit, _ht_limit);
		} else if (_dtrg_ht_mask == 3) { //ROLL AND PITCH AND HT THRUST (WARNING Might be unstable)
			attitude_setpoint.roll_body = _manual_control_setpoint.pitch * _man_tilt_max;
			attitude_setpoint.pitch_body = _manual_control_setpoint.roll * _man_tilt_max;
			attitude_setpoint.thrust_body[0] = math::constrain(_manual_control_setpoint.pitch * _ht_limit, -_ht_limit, _ht_limit);
			attitude_setpoint.thrust_body[1] = math::constrain(_manual_control_setpoint.roll * _ht_limit, -_ht_limit, _ht_limit);
		} else { //standard HT
			attitude_setpoint.roll_body = _rc_channels.channels[_ht_r_add] * _man_tilt_max;
			attitude_setpoint.pitch_body = _rc_channels.channels[_ht_p_add] * _man_tilt_max;
			attitude_setpoint.thrust_body[0] = math::constrain(_manual_control_setpoint.pitch * _ht_limit, -_ht_limit, _ht_limit);
			attitude_setpoint.thrust_body[1] = math::constrain(_manual_control_setpoint.roll * _ht_limit, -_ht_limit, _ht_limit);
		}

		hzlim_msg.x_sat = (fabsf(attitude_setpoint.thrust_body[0]) >= _ht_limit);
		hzlim_msg.y_sat = (fabsf(attitude_setpoint.thrust_body[1]) >= _ht_limit);
		// Publish horizontal thrust saturation
		_horizontal_thrust_limit_pub.publish(hzlim_msg);
	}
```
MulticopterAttitudeControl::generate_attitude_setpoint only called from line 317 in mc attitude control under the condition that the current flight mode is attititude mode / manual flight mode not position altitude etc so these changes do not apply to position based modes
## Position Based Flight Implementation

Changes required for position based flight including position, altitude and offboard position are made in mc position control module

```c++
// MulticopterPositionControl.cpp : 265
	_ht_en = _param_dtrg_ht_en.get();
	if (_ht_en){
		_ht_rc_en_add = _param_dtrg_ht_rc_en.get()-1;
		_ht_r_add = _param_dtrg_ht_R.get()-1;
		_ht_p_add = _param_dtrg_ht_P.get()-1;
		_dtrg_ht_mask = _param_dtrg_ht_mask.get();
		_ht_limit = _param_dtrg_ht_max.get();
		_ht_r_limit = math::radians(_param_dtrg_ht_r_max.get());
		_ht_p_limit = math::radians(_param_dtrg_ht_p_max.get());
	}
```

```c++
// MulticopterPositionControl.cpp : 580
			// Publish attitude setpoint output
			vehicle_attitude_setpoint_s attitude_setpoint{};
			if(_ht_en && (_rc_channels.channels[_ht_rc_en_add] > 0.5f)){

				if(!_vehicle_control_mode.flag_control_offboard_enabled){
					// if offboard is not enabled, use the RC channels to get roll and pitch setpoints
					// setpoints are constrained to the limits set by the with 0.01f deadzone
					roll_setpoint = math::constrain(
						fabsf(_rc_channels.channels[_ht_r_add]) > 0.02f ?
						_rc_channels.channels[_ht_r_add] * _ht_r_limit : 0.f,
						-_ht_r_limit, _ht_r_limit);

					pitch_setpoint = math::constrain(
						fabsf(_rc_channels.channels[_ht_p_add]) > 0.02f ?
						_rc_channels.channels[_ht_p_add] * _ht_p_limit : 0.f,
						-_ht_p_limit, _ht_p_limit);
				}else{
					if (_debug_array_sub.update(&_debug_array)){

						// if offboard is enabled, use the roll and pitch setpoints from the debug array
						roll_setpoint = _debug_array.data[0]; //first index is roll setpoint
						pitch_setpoint = _debug_array.data[1]; //second index is pitch setpoint
					}
				}

				// dummy attitude setpoints for mixed actuation
				vehicle_attitude_setpoint_s attitude_RP{};

				// //Standard attitude setpoint generation
				_control.getAttitudeSetpoint(attitude_RP);

				// Pick and Choose the attitude stuff using parameter
				if (_dtrg_ht_mask == 1) {// Roll for y axis
					attitude_setpoint.roll_body = attitude_RP.roll_body;
					attitude_setpoint.pitch_body = pitch_setpoint;
				} else if (_dtrg_ht_mask == 2) { //Pitch for x axis
					attitude_setpoint.pitch_body = attitude_RP.pitch_body;
					attitude_setpoint.roll_body = roll_setpoint;
				} else if (_dtrg_ht_mask == 3) { //ROLL AND PITCH AND HT THRUST (WARNING Might be unstable)
					attitude_setpoint.roll_body = attitude_RP.roll_body;
					attitude_setpoint.pitch_body = attitude_RP.pitch_body;
				} else {
					attitude_setpoint.roll_body = roll_setpoint;
					attitude_setpoint.pitch_body = pitch_setpoint;
				}

				// set the yaw setpoint and complete the qd quaternion
				attitude_setpoint.yaw_sp_move_rate = local_pos_sp.yawspeed;
				Quatf q_sp = Eulerf(attitude_setpoint.roll_body, attitude_setpoint.pitch_body, local_pos_sp.yaw);
				q_sp.copyTo(attitude_setpoint.q_d);
				// convert thrusts from inertial to body frame
				Vector3f thrust_frd = q_sp.rotateVectorInverse(Vector3f(local_pos_sp.thrust[0],
					local_pos_sp.thrust[1], local_pos_sp.thrust[2]));
				// Pick and Choose the horizontal thrust stuff using parameter
				if (_dtrg_ht_mask == 1) { //roll for y
					attitude_setpoint.thrust_body[0] =  thrust_frd(0); //thrust for x
				} else if (_dtrg_ht_mask == 2) { //pitch for x
					attitude_setpoint.thrust_body[1] =  thrust_frd(1); //thrust for y
				} else if (_dtrg_ht_mask == 3) { //ROLL AND PITCH AND HT THRUST (WARNING Might be unstable)
					attitude_setpoint.thrust_body[0] =  thrust_frd(0);
					attitude_setpoint.thrust_body[1] =  thrust_frd(1);
				} else {
					attitude_setpoint.thrust_body[0] =  thrust_frd(0);
					attitude_setpoint.thrust_body[1] =  thrust_frd(1);
				}

				// check for saturation
				horizontal_thrust_limit_s hzlim_msg{};
				hzlim_msg.timestamp = hrt_absolute_time();
				attitude_setpoint.thrust_body[0] = math::constrain(attitude_setpoint.thrust_body[0], -_ht_limit, _ht_limit);
				hzlim_msg.x_sat = (fabsf(fabsf(attitude_setpoint.thrust_body[0]) - _ht_limit) < FLT_EPSILON);
				attitude_setpoint.thrust_body[1] = math::constrain(attitude_setpoint.thrust_body[1], -_ht_limit, _ht_limit);
				hzlim_msg.y_sat = (fabsf(fabsf(attitude_setpoint.thrust_body[1]) - _ht_limit) < FLT_EPSILON);
				_horizontal_thrust_limit_pub.publish(hzlim_msg);

				//vertical thrust
				attitude_setpoint.thrust_body[2] = thrust_frd(2);
			}else{
				//Standard attitude setpoint
				_control.getAttitudeSetpoint(attitude_setpoint);
			}
			attitude_setpoint.timestamp = hrt_absolute_time();
			_vehicle_attitude_setpoint_pub.publish(attitude_setpoint);


		} else {
			// an update is necessary here because otherwise the takeoff state doesn't get skipped with non-altitude-controlled modes
			_takeoff.updateTakeoffState(_vehicle_control_mode.flag_armed, _vehicle_land_detected.landed, false, 10.f, true,
						    vehicle_local_position.timestamp_sample);
		}
```


## HT Saturation Message
Included in both the manual and position implementations is saturation limits for the horizontal thrust demands. These are set by the **DTRG_HT_MAX** parameter and are intended to prevent the UAV from saturating individual rotors and thus is dependent on the airframe geometry and components.

To track the saturation a new uORB topic is created `HorizontalThrustLimit.msg` which is added to the `msg/CMakeLists.txt` along with the definition `msg/HorizontalThrustLimit.msg` 
```c
##This messgae HorizontalThrustLimit.msg publishes the state of the horizontal thrust limit
#implemention: 	UoA DTRG

uint64 	timestamp		# time since system start (microseconds)

# horizontal thrust limit flags
uint8 x_sat
uint8 y_sat

```

## Logging


```c
	#SYS_STATUS.hpp : 126
	sequential_desaturation_s sequential_desaturation{};
	_sequential_desaturation_sub.copy(&sequential_desaturation);

	actuator_motors_s actuator_motors{};
	_actuator_motors_sub.copy(&actuator_motors);

	horizontal_thrust_limit_s horizontal_thrust_limit{};
	_horizontal_thrust_limit_sub.copy(&horizontal_thrust_limit);

```

```c
# logged_topics.cpp : 305
 void LoggedTopics::add_high_rate_topics()
{
	// maximum rate to analyze fast maneuvers (e.g. for racing)
	add_topic("manual_control_setpoint");
	add_topic("rate_ctrl_status", 20);
	add_topic("sensor_combined");
	add_topic("vehicle_angular_velocity");
	add_topic("vehicle_attitude");
	add_topic("vehicle_attitude_setpoint");
	add_topic("vehicle_rates_setpoint");

	# Added new high rate topics
	add_topic("actuator_motors");
	add_topic("vehicle_thrust_setpoint");
	add_topic("vehicle_torque_setpoint");
}
```
## Sequential Desaturation

```c
# ControlAllocationSequentialDesaturation.cpp : 180
	// Mix without yaw
	ActuatorVector thrust_x;
	ActuatorVector thrust_y;
	ActuatorVector thrust_z;
	
	# : 210
	
	// Mix yaw independently
	float yaw_sat = mixYaw();
	...
	sqmsg.yaw_sat = yaw_sat;
	
	
	# : 134 Adjusted this method to return the gain for logging
	float
ControlAllocationSequentialDesaturation::mixYaw()
{
	// Add yaw to outputs
	ActuatorVector yaw;
	ActuatorVector thrust_z;

	for (int i = 0; i < _num_actuators; i++) {
		_actuator_sp(i) += _mix(i, ControlAxis::YAW) * (_control_sp(ControlAxis::YAW) - _control_trim(ControlAxis::YAW));
		yaw(i) = _mix(i, ControlAxis::YAW);
		thrust_z(i) = _mix(i, ControlAxis::THRUST_Z);
	}

	// Change yaw acceleration to unsaturate the outputs if needed (do not change roll/pitch),
	// and allow some yaw response at maximum thrust
	ActuatorVector max_prev = _actuator_max;
	_actuator_max += (_actuator_max - _actuator_min) * 0.15f;
	float gain = desaturateActuators(_actuator_sp, yaw);
	_actuator_max = max_prev;

	// reduce thrust only
	desaturateActuators(_actuator_sp, thrust_z, true);

	return gain;
}
```


For more implementation details see PR https://github.com/UoA-DTRG/PX4-Autopilot/pull/7#issue-3250736566