#ifndef _EIF_COMMANDS_H_
#define _EIF_COMMANDS_H_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Platform definition */
/* Windows definition */
#ifdef EIF_WINDOWS
#define EIF_IS_WINDOWS EIF_TRUE
#else
#define EIF_IS_WINDOWS EIF_FALSE
#endif

/* VMS definition */
#ifdef EIF_VMS
#define EIF_IS_VMS EIF_TRUE
#else
#define EIF_IS_VMS EIF_FALSE
#endif


#ifdef __cplusplus
}
#endif

#endif /* _EIF_COMMANDS_H_ */
