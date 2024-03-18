# Sample VB Clang Project

A simple project showing how to build a Virtual Boy ROM with clang.

## Setup

1. Download the compiler from the [v810-llvm GitHub releases page](https://github.com/SupernaviX/v810-llvm/releases).
    * For Windows, use [llvm-v810-windows-main.7z](https://github.com/SupernaviX/v810-llvm/releases/download/llvm-v810-windows-main/llvm-v810-windows-main.7z).
    * For OSX, use [llvm-v810-darwin-main.tar.xz](https://github.com/SupernaviX/v810-llvm/releases/download/llvm-v810-darwin-main/llvm-v810-darwin-main.tar.xz).
    * For Linux, use [llvm-v810-linux-main.tar.xz](https://github.com/SupernaviX/v810-llvm/releases/download/llvm-v810-linux-main/llvm-v810-linux-main.tar.xz).
2. Extract the `llvm-v810` directory from that file.
3. Update the `Makefile`.
    * Set `TOOLCHAIN_DIR` to the location of `llvm-v810`.
    * Set `NAME` to the name of the ROM.

Now you can build your ROM by running `make`. You'll find it in the `output` dir with a `.vb` file extension.