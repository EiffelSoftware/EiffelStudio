#include "nls_locale.h"



EIF_BOOLEAN get_locale_ilzero(LCID locale) {
	BOOL temp; //this is a #typedef for an int, but let's pretend it's a _useful_ abstraction.
	GetLocaleInfo(locale, (LOCALE_ITIME | LOCALE_RETURN_NUMBER), &temp, sizeof(BOOL));
	return bool_to_eif_boolean(temp); //... and EIF_BOOLEAN is of course a #typedef for a char. What fun.
}









//helper functions

EIF_BOOLEAN bool_to_eif_boolean(BOOL b) {

	EIF_BOOLEAN result;
	result = (b == 0) ? EIF_FALSE : EIF_TRUE;
	//Note: above assumes that a BOOL can have as values only 0 and 1. Let us trust the caller (me).
	return result;
}

TCHAR * extract_locale_string(LCID locale, LCTYPE info, int buflength) {

	TCHAR *string;
	string = malloc(sizeof(TCHAR)*buflength);
	GetLocaleInfo(locale, info, string, buflength);
	return string;
}

int extract_locale_int(LCID locale, LCTYPE info) {

	int temp;
	GetLocaleInfo(locale, (info|LOCALE_RETURN_NUMBER),&temp, 2);
	return temp;
}