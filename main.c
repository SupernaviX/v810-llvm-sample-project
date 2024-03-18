// Interrupts
extern void(*video_isr)();

const extern unsigned char _binary_hello_bin_start;
volatile unsigned char* const target = (unsigned char*)0x05690000;

__attribute__((interrupt))
void video_interrupt() {
    *(unsigned char*)0x01000580 = 1;
}

int main() {
    // Register a handler for VIP interrupts
    video_isr = video_interrupt;

    while (1) {
        // Game logic goes here.
        const unsigned char *hello_bin = &_binary_hello_bin_start;
        *target = hello_bin[4];
    }
}
