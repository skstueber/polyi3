# C

## Standard and Compiler
- Target C11 or C17 unless embedded constraints require otherwise
- Always compile with: -Wall -Wextra -Wpedantic -Wstrict-prototypes -Wshadow -Wconversion
- Debug builds: -g -fsanitize=address,undefined
- Release builds: -O2 -DNDEBUG
- Use make or cmake, never ad-hoc shell scripts for multi-file projects

## Code Style
- 4 spaces for indentation, no tabs
- Opening brace on the same line for functions and control flow
- snake_case for all identifiers: variables, functions, types
- UPPER_SNAKE_CASE for macros and constants
- Prefix all public API functions with the module name: parser_init(), parser_free()
- Keep functions under 50 lines, split into helpers if longer
- One statement per line

## Types
- Use stdint.h fixed-width types: uint8_t, int32_t, size_t
- Never use int for sizes or counts, use size_t
- Use bool from stdbool.h, never raw int for booleans
- Typedef structs: typedef struct Parser Parser
- Never typedef pointers, Parser * is clearer than ParserPtr

## Memory Management
- Every malloc/calloc return value must be NULL-checked before use
- Every allocation has a matching free, consistent ownership model
- Prefer calloc over malloc for zero-initialized memory
- Free pointers and set to NULL immediately to catch use-after-free
- Document ownership in comments: who allocates, who frees

## Error Handling
- Functions that can fail return an error code (int or enum), not a bare pointer
- Use a consistent error enum, not magic numbers
- Always check return values from: fopen, malloc, snprintf, etc.
- Log errors with __FILE__ and __LINE__

## Strings and Buffers
- Never use strcpy or sprintf, use strncpy/snprintf with explicit size limits
- Always null-terminate manually when using strncpy
- Use memcpy/memset for raw byte operations

## Headers
- Every header has an include guard or pragma once
- Headers declare interfaces only, no definitions except static inline
- Include only what is actually used

## Common Patterns

Checked allocation:
    void *ptr = malloc(size);
    if (ptr == NULL) { return ERR_OOM; }

Cleanup with goto:
    int result = ERR_OK;
    FILE *f = fopen(path, "r");
    if (!f) { result = ERR_IO; goto cleanup; }
    char *buf = malloc(BUF_SIZE);
    if (!buf) { result = ERR_OOM; goto cleanup; }
    cleanup:
        free(buf);
        if (f) fclose(f);
        return result;

Safe string copy:
    strncpy(dst, src, sizeof(dst) - 1);
    dst[sizeof(dst) - 1] = 0;

Fixed-width struct:
    typedef struct {
        uint32_t id;
        size_t   length;
        bool     active;
    } Record;
