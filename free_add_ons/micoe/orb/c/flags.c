#include "eiffel.h"
#include "flags.h"

#ifdef __STDC__

EIF_INTEGER int_and (EIF_INTEGER i1, EIF_INTEGER i2)

#else

EIF_INTEGER int_and (i1, i2)

EIF_INTEGER i1;
EIF_INTEGER i2;

#endif

{
    return (EIF_INTEGER) (((unsigned)i1) & ((unsigned)i2));
}
/*---------------------------------------------------------*/

#ifdef __STDC__

EIF_INTEGER int_or (EIF_INTEGER i1, EIF_INTEGER i2)

#else

EIF_INTEGER int_or (i1, i2)

EIF_INTEGER i1;
EIF_INTEGER i2;

#endif

{
    return (EIF_INTEGER) (((unsigned)i1) | ((unsigned)i2));
}
/*---------------------------------------------------------*/

#ifdef __STDC__

EIF_INTEGER int_xor (EIF_INTEGER i1, EIF_INTEGER i2)

#else

EIF_INTEGER int_xor (i1, i2)

EIF_INTEGER i1;
EIF_INTEGER i2;

#endif

{
    return (EIF_INTEGER) (((unsigned)i1) ^ ((unsigned)i2));
}
/*---------------------------------------------------------*/

#ifdef __STDC__xx

EIF_INTEGER int_not (EIF_INTEGER i, EIF_INTEGER sz)

#else

EIF_INTEGER int_not (i, sz)

EIF_INTEGER i;
EIF_INTEGER sz;

#endif

{
    unsigned mask = (1 << (unsigned)sz) - 1;

    return (EIF_INTEGER) (mask & (~((unsigned)i)));
}

