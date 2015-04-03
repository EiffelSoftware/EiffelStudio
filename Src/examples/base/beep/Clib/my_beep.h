#include "eif_macros.h"

#define warning_beep_kind 0
#define error_beep_kind   1

#define beep_error my_beep (int error_beep_kind)
#define beep_warning my_beep (int warning_beep_kind)

extern EIF_BOOLEAN my_beep (EIF_INTEGER kind);
