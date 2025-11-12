Person---
title: Project Template README
layout: default
parent: Guides
nav_order: 6
---

# Project Template README

All DTRG projects should be well-documented and organized. Use this template as a starting point for your project README files.

## GitHub Repository README Template

Copy the markdown below and customize it for your project:

```markdown
# [Project Name]

[Brief one-paragraph description of what this project does and its purpose within DTRG]

## Project Information

- **Student(s)**: [Name(s)]
- **Supervisor**: [Name]
- **Year**: [Year]
- **Type**: [Part IV / Masters / PhD / Research Project]
- **Status**: [Active / Completed / On Hold]

## Overview

### Objectives
- [Main objective 1]
- [Main objective 2]
- [Main objective 3]

### Key Features
- [Feature 1]
- [Feature 2]
- [Feature 3]

## Repository Structure

```
project-name/
├── README.md           # This file
├── docs/              # Documentation
│   ├── design/        # Design documents and CAD files
│   ├── testing/       # Test procedures and results
│   └── meetings/      # Meeting notes
├── src/               # Source code
│   ├── firmware/      # Embedded code (PX4 modifications, etc.)
│   ├── scripts/       # Helper scripts
│   └── simulation/    # Simulation files
├── hardware/          # Hardware designs
│   ├── cad/          # CAD files
│   ├── pcb/          # Circuit designs
│   └── bom/          # Bills of materials
├── data/             # Experimental data (if not too large)
└── LICENSE           # License file
```

## Getting Started

### Prerequisites
- [Required software/tools]
- [Required hardware]
- [Required skills/knowledge]
- [Links to relevant DTRG documentation]

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/UoA-DTRG/[project-name].git
   cd [project-name]
   ```

2. [Additional setup steps]

3. [Build/compile instructions if applicable]

### Quick Start

[Brief instructions to get someone running the basic functionality]

## Usage

### [Main Use Case 1]
[Instructions and examples]

### [Main Use Case 2]
[Instructions and examples]

## Hardware

### Components Used
| Component | Part Number | Quantity | Notes |
|-----------|-------------|----------|-------|
| [Component 1] | [P/N] | [Qty] | [Any notes] |
| [Component 2] | [P/N] | [Qty] | [Any notes] |

### Assembly Instructions
[Link to assembly documentation or brief instructions]

### Wiring Diagram
[Include or link to wiring diagrams]

## Software

### Dependencies
- [List all software dependencies with versions]

### Configuration
[Explain any configuration files or parameters]

### Custom Modifications
[Document any modifications to PX4 or other existing code]

## Testing

### Simulation Testing
[How to test in simulation]

### Hardware Testing
[Testing procedures and safety considerations]

### Results
[Link to test results or summary of findings]

## Safety

### Risk Assessment
- Risk assessment completed: [Date]
- Approved by: [Supervisor name]
- Document location: [Link or file path]

### Safety Considerations
- [Key safety point 1]
- [Key safety point 2]
- [Emergency procedures]

### Operating Limitations
- [Weight limits, speed limits, etc.]
- [Environmental conditions]
- [Required supervision level]

## Documentation

### Design Documents
- [Link to detailed design documentation]
- [Link to CAD files]
- [Link to calculations/analysis]

### User Manual
[Link to user manual if applicable]

### Maintenance
[Maintenance procedures and schedules]

## Results and Publications

### Key Findings
[Summary of main results or outcomes]

### Publications
- [Any papers, reports, or presentations]

### Future Work
- [Recommendations for future development]
- [Known issues or limitations]

## Contributing

### For DTRG Members
If you're working on this project:
1. Create a feature branch from `main`
2. Make your changes
3. Test thoroughly
4. Create a pull request with clear description
5. Request review from [project lead/supervisor]

### Branch Naming
- `feature/description` - New features
- `fix/description` - Bug fixes
- `test/description` - Testing additions
- `docs/description` - Documentation updates

### Commit Messages
Follow conventional commits format:
- `feat: add new feature`
- `fix: correct issue with...`
- `docs: update README with...`
- `test: add tests for...`

## License

[Specify license - check with supervisor. Common options: MIT, GPL, or proprietary]

## Contact

- **Project Lead**: [Name] - [email]
- **Supervisor**: [Name] - [email]
- **DTRG**: [General contact information]

## Acknowledgments

- [DTRG members who helped]
- [Any external support or funding]
- [Resources or references used]

## Project Timeline

### Milestones
- [Date]: [Milestone 1]
- [Date]: [Milestone 2]
- [Date]: [Milestone 3]

### Current Status
[Brief update on current progress and next steps]

---

**Last Updated**: [Date]
**Version**: [Version number]
```

## Teams Drive Organization

Alongside your Git repository, organize your Teams Drive folder as follows:

### Folder Structure

```
Project Name/
├── 00_Admin/
│   ├── Risk_Assessment.pdf
│   ├── Project_Proposal.pdf
│   ├── Budget.xlsx
│   └── Approvals/
├── 01_Design/
│   ├── CAD_Files/ (or link to Git)
│   ├── Calculations/
│   ├── Design_Reviews/
│   └── Drawings/
├── 02_Documentation/
│   ├── Meeting_Notes/
│   ├── Technical_Specs/
│   ├── User_Manuals/
│   └── Literature_Review/
├── 03_Testing/
│   ├── Test_Plans/
│   ├── Test_Results/
│   ├── Data/ (large datasets)
│   └── Videos/
├── 04_Reports/
│   ├── Progress_Reports/
│   ├── Final_Report/
│   └── Presentations/
└── 05_Resources/
    ├── Datasheets/
    ├── References/
    └── Tutorials/
```

### File Naming Conventions

**Documents**:
- `YYYY-MM-DD_Document-Name_vX.ext`
- Example: `2025-10-24_Test-Results_v2.pdf`

**CAD Files**:
- `PartName_vX.ext`
- Example: `Motor_Mount_v3.step`

**Meeting Notes**:
- `YYYY-MM-DD_Meeting-Notes.md`
- Example: `2025-10-24_Meeting-Notes.md`

## Version Control Best Practices

### What to Put in Git
- All source code
- Small configuration files
- Documentation (markdown)
- CAD files (if reasonable size)
- Scripts and automation
- Test procedures
- README and other markdown files

### What to Put in Teams Drive (Not Git)
- Large data files (>50 MB)
- Video recordings
- Large binary files
- Administrative documents requiring signatures
- Weekly reports and presentations
- Reference materials and datasheets

### Keeping Them Synchronized
- Add links in README to Teams Drive folders
- Add link to Git repository in Teams Drive
- Keep documentation consistent between both
- Reference file locations clearly

## Checklist for New Projects

### Initial Setup
- [ ] Create repository under UoA-DTRG organization
- [ ] Use this README template
- [ ] Create folder structure in Teams Drive
- [ ] Add link to repository in Teams Drive
- [ ] Add link to Teams Drive in repository README
- [ ] Set up appropriate branch protection rules
- [ ] Add supervisor and relevant members as collaborators

### Documentation
- [ ] Complete project information section
- [ ] Document all dependencies
- [ ] Create initial setup instructions
- [ ] Add safety and risk assessment information
- [ ] Document hardware components
- [ ] Explain software configuration

### Throughout Project
- [ ] Update README regularly
- [ ] Document major decisions
- [ ] Keep meeting notes
- [ ] Track testing results
- [ ] Update status and milestones
- [ ] Back up data regularly

### Before Completion
- [ ] Final documentation review
- [ ] Complete user manual
- [ ] Archive final data
- [ ] Update future work section
- [ ] Ensure all files are committed
- [ ] Tag final version/release

## Related Pages
- [Getting Started](Getting-Started)
- [Design Guidelines](Design-Guidelines)
- [Safety Guidelines](Safety-Guidelines)

