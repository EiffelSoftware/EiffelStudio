#include "config.h"

#ifdef HAVE_BYTEORDER_LE
#define C_LITTLE_ENDIAN 1
#else
#undef C_LITTLE_ENDIAN
#endif

extern EIF_INTEGER MICO_uni_fromUTF8 (EIF_POINTER,
                                      EIF_POINTER,
                                      EIF_INTEGER,
                                      EIF_INTEGER,
                                      EIF_INTEGER,
                                      EIF_INTEGER);
extern EIF_INTEGER MICO_uni_toUTF8 (EIF_POINTER,
                                    EIF_POINTER,
                                    EIF_INTEGER,
                                    EIF_INTEGER,
                                    EIF_INTEGER,
                                    EIF_INTEGER);
