#ifndef __MATISSE_EIF_H__
#define __MATISSE_EIF_H__
/** All c files related to Eiffel MATISSE interface should
    include this header file **/

#include <matisse.h>
#include <eif_eiffel.h>
#include "mt_exceptions.h"

void eifmts_trace (char* );

/* debug */
#ifdef EIF_MT_LOGGING
#define EIF_MT_LOG(msg) \
		{char trace[512];  sprintf(trace, "\n%s:%d: ", __FILE__, __LINE__); eifmts_trace(trace);\
		eifmts_trace(msg);}
#define EIF_MT_LOG1(format, arg1) \
		{char trace[512];  sprintf(trace, "\n%s:%d: ", __FILE__, __LINE__); eifmts_trace(trace);\
		sprintf(trace, format, arg1); eifmts_trace(trace);}
#define EIF_MT_LOG2(format, arg1, arg2) \
		{char trace[512];  sprintf(trace, "\n%s:%d: ", __FILE__, __LINE__); eifmts_trace(trace);\
		sprintf(trace, format, arg1, arg2); eifmts_trace(trace);}
#define EIF_MT_LOG3(format, arg1, arg2, arg3) \
		{char trace[512];  sprintf(trace, "\n%s:%d: ", __FILE__, __LINE__); eifmts_trace(trace);\
		sprintf(trace, format, arg1, arg2, arg3); eifmts_trace(trace);}
#else
#define EIF_MT_LOG(msg) {}
#define EIF_MT_LOG1(format, arg1) {}
#define EIF_MT_LOG2(format, arg1, arg2) {}
#define EIF_MT_LOG3(format, arg1, arg2, arg3) {}
#endif

/*void EIF_MT_LOG(char* msg);*/

#define MTEIF_OPAQUE_TYPE  EIF_INTEGER

#endif