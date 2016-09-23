SRCS=src/AHBLite2AvalonMemoryMapped_tb.v src/AHBLite2AvalonMemoryMapped.v
INCLUDES=include
BIN=bin/AHBLibe2AvalonMemoryMapped_tb

$(BIN): $(SRCS)
	mkdir -p bin
	iverilog $(SRCS) -I$(INCLUDES) -o $(BIN)

clean:
	rm -f $(BIN)
