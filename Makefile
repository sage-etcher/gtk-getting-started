#
#  Makefile
#  Simple GNU Makefile to build and install the project
#
#  Copyright 2023 Sage I. Hendricks
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

PROJECT_NAME := Learning GTK with C
PROJECT_VERSION := 0.1.0.1-dev
# VERSION in the form MAJOR.MINOR.PATCH.BUILD-AUDIENCE
# Example for Developer Build, version 2.14 patch 3
# 2.14.3.841-dev
# Example for Stable Release, version 2.15 patch 0
# 2.15.0.857


# Important Directories
BUILD_DIR  := ./build
SOURCE_DIR := ./source
DESTDIR    := ./local_install

INCLUDE_DIR := $(SOURCE_DIR)/include
LIBRARY_DIR := $(SOURCE_DIR)/lib

# Important Files
GTK_C_FLAGS := `pkg-config --cflags gtk4`
GTK_L_FLAGS := `pkg-config --libs gtk4`

HELLO_EXEC := hello-world-gtk.exe
HELLO_SOURCE_FILENAMES := hello/hello-world-gtk.c
HELLO_SOURCE_FILES := $(foreach filename,$(HELLO_SOURCE_FILENAMES),$(SOURCE_DIR)/$(filename))
HELLO_OBJECT_FILES := $(foreach filename,$(HELLO_SOURCE_FILES),$(BUILD_DIR)/$(filename).o)
HELLO_C_FLAGS := $(GTK_C_FLAGS)
HELLO_L_FLAGS := $(GTK_L_FLAGS)


# Compiler and Linker Options
#CC := /c/mingw/bin/gcc 
#LD := /c/mingw/bin/gcc
CC := clang
LD := clang

INCLUDE_FLAGS := -I$(INCLUDE_DIR) -I$(SOURCE_DIR)
LIBRARY_FLAGS := -L$(LIBRARY_DIR)


GENERIC_C_FLAGS := $(INCLUDE_FLAGS)
#GENERIC_C_FLAGS += -O3
#GENERIC_C_FLAGS += -ansi -pedantic -Wpedantic
#GENERIC_C_FLAGS += -Wall -Werror

GENERIC_L_FLAGS := $(LIBRARY_FLAGS)


# Build
.PHONY: build
build: $(BUILD_DIR)/$(HELLO_EXEC)

$(BUILD_DIR)/$(HELLO_EXEC): $(HELLO_OBJECT_FILES)
	mkdir -pv $(dir $@)
	$(LD) -o $@ $(GENERIC_L_FLAGS) $(HELLO_L_FLAGS) $(HELLO_OBJECT_FILES)


$(BUILD_DIR)/$(SOURCE_DIR)/%.c.o: $(SOURCE_DIR)/%.c
	mkdir -pv $(dir $@)
	$(CC) -c -o $@ $(GENERIC_C_FLAGS) $(HELLO_C_FLAGS) $<


# Clean
.PHONY: clean
clean:
	rm -rfv $(BUILD_DIR)


# Install
.PHONY: install
install: $(DESTDIR)/bin/$(HELLO_EXEC)


$(DESTDIR)/bin/$(HELLO_EXEC): $(BUILD_DIR)/$(HELLO_EXEC)
	mkdir -pv $(dir $@)
	cp -fv $< $@


# Uninstall
.PHONY: uninstall
uninstall:
	rm -fv $(DESTDIR)/bin/$(HELLO_EXEC)


