#include "kernel/types.h"
#include "user/user.h"

#define MAX_MASK 2147483647
#define MIN_MASK 2

int main(int argc, char* argv[]) {
    if (argc < 3) {
        printf("Error: not the right amount of arguments\n");
        return 1;
    }

    // extract integer "mask"
    int mask = atoi(argv[1]);
    if (mask < MIN_MASK || mask > MAX_MASK) {
        printf("Error: masked integer\n");
        return 1;
    }

    if (trace(mask) != 0) {
        printf("Error: starting trace\n");
        return 1;
    }

    // Itereate through argv and put relavant arguments from argv into args,
    // then call exec() starting after "trace mask"
    uint8 arr_size = argc - 1;
    char* args[arr_size];
    for (int i=0; i < argc-2; i++) {
        args[i] = argv[i + 2];
    }
    args[arr_size - 1] = 0;
    exec(args[0], args);

    return 0;
}