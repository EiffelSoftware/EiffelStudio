#include <eiffel.h>
#include <stdio.h>

EIF_INTEGER MICO_hexstring2int (EIF_POINTER sp)
{
    int n;

    sscanf((char*)sp, "%x", &n);
    return (EIF_INTEGER) n;
}
