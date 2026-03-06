CC := gcc
AR := ar
CFLAGS := -Wall -Wextra -Werror -std=c11

PULSEFMT_VERSION := 1.0

DEPS_DIR := deps/pulsefmt-$(PULSEFMT_VERSION)
INCLUDES := -I$(DEPS_DIR)/include
OBJ_DIR := build/obj
LIB_DIR := build/lib
BIN_DIR := build/bin

APP_OBJ := $(OBJ_DIR)/main.o
LIB_OBJ := $(OBJ_DIR)/pulsefmt.o
LIB_FILE := $(LIB_DIR)/libpulsefmt.a
BIN_FILE := $(BIN_DIR)/cache_audit

.PHONY: all clean show-config

all: $(BIN_FILE)

$(OBJ_DIR) $(LIB_DIR) $(BIN_DIR):
	mkdir -p $@

$(APP_OBJ): src/main.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(LIB_OBJ): $(DEPS_DIR)/pulsefmt.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(LIB_FILE): $(LIB_OBJ) | $(LIB_DIR)
	$(AR) rcs $@ $^

$(BIN_FILE): $(APP_OBJ) $(LIB_FILE) | $(BIN_DIR)
	$(CC) $(CFLAGS) $(APP_OBJ) $(LIB_FILE) -o $@

show-config:
	@echo "pulsefmt_version=$(PULSEFMT_VERSION)"
	@echo "deps_dir=$(DEPS_DIR)"

clean:
	rm -rf build
