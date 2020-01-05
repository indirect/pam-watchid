PREFIX ?= /usr/local
LIBRARY_PREFIX = pam_watchid
LIBRARY_NAME = $(LIBRARY_PREFIX).so
DESTINATION = $(addprefix $(PREFIX), /lib/pam)
TARGET = apple-darwin20.1.0

all:
	swiftc watchid-pam-extension.swift -o $(LIBRARY_PREFIX)_x86_64.so -target x86_64-$(TARGET) -emit-library
	swiftc watchid-pam-extension.swift -o $(LIBRARY_PREFIX)_arm64.so -target arm64-$(TARGET) -emit-library
	lipo -create $(LIBRARY_PREFIX)_arm64.so $(LIBRARY_PREFIX)_x86_64.so -output $(LIBRARY_NAME)

install: all
	mkdir -p $(DESTINATION)
	cp $(LIBRARY_NAME) $(DESTINATION)/$(LIBRARY_NAME)
