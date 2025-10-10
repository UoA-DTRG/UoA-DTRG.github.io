# Cross-platform Makefile for Just-the-Docs local setup and dev

SHELL := /bin/bash
.DEFAULT_GOAL := help

# Detect platform
ifeq ($(OS),Windows_NT)
	# Check if we're actually in WSL
	ifneq (,$(shell grep -i microsoft /proc/version 2>/dev/null))
		OSFLAG := unix
	else ifneq (,$(WSL_DISTRO_NAME))
		OSFLAG := unix
	else
		OSFLAG := windows
	endif
else
	OSFLAG := unix
endif

help:
	@echo ""
	@echo "📘 Just-the-Docs helper commands"
	@echo "--------------------------------"
	@echo "make setup     - Install Ruby, Bundler, and dependencies"
	@echo "make serve     - Run local Jekyll server with live reload"
	@echo "make clean     - Remove generated _site folder"
	@echo "make update    - Update Ruby gems (bundle update)"
	@echo ""

setup:
ifeq ($(OSFLAG),windows)
	@echo "==> Running Windows setup script..."
	powershell -ExecutionPolicy Bypass -File Tools/setup.ps1
else
	@echo "==> Running Unix/macOS/WSL setup script..."
	bash Tools/setup.sh
endif

serve:
ifeq ($(OSFLAG),windows)
	@echo "==> Starting Windows Jekyll server..."
	powershell -ExecutionPolicy Bypass -File serve.ps1
else
	@echo "==> Starting Unix/macOS/WSL Jekyll server..."
	bash Tools/serve.sh
endif

clean:
	@echo "==> Cleaning build artifacts..."
	rm -rf _site

update:
	@echo "==> Updating Ruby gems..."
	bundle update
	@echo "==> Update complete. You may want to run 'make clean' and 'make serve' to see changes."

