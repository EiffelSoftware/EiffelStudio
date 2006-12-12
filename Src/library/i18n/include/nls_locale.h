#define UNICODE
#define _UNICODE

#include<windows.h>
#include<winnls.h>
#include<tchar.h>
#include<string.h>
#include "eif_macros.h" //includes all the eiffel stuff



//TCHAR* get_locale_name(LCID locale);


EIF_BOOLEAN get_locale_ilzero(LCID locale); //leading zeros before decimal (.9 or 0.9?) returns 0 or 1.



//Helpers


EIF_BOOLEAN bool_to_eif_boolean(BOOL b);
TCHAR * extract_locale_string(LCID locale, LCTYPE info, int buflength);
int extract_locale_int(LCID locale, LCTYPE info);


