#include <eif_eiffel.h>
#include <stdio.h>
#include <time.h>
#include <locale.h>
#include <mbctype.h>
#include <tchar.h>
#include <windows.h>

#include "eiflocale.h"

EIF_POINTER cwel_set_locale(EIF_INTEGER category, EIF_POINTER locale);
EIF_INTEGER cwel_set_multb_char_codepage(EIF_INTEGER codepage);
EIF_POINTER test_string(void);

wchar_t test_wide[5];
char test_multi[28];

EIF_POINTER cwel_set_locale(EIF_INTEGER category, EIF_POINTER locl)
{
		time_t ltime;
		struct tm *thetime;
		unsigned char str[100];
	
	       
	       time (&ltime);
	       thetime = gmtime(&ltime);

	 
	 	//SetThreadLocale(MAKELCID(0x040d, SORT_DEFAULT));
		_tsetlocale(LC_ALL, "Hebrew");


	       if (!strftime((char *)str, 100, "%#x", 
	                     (const struct tm *)thetime))
	               printf("strftime failed!\n");
	       else
	               printf("In Chinese locale, strftime returns '%s'\n", 
	                      str);
	
	       //Set the locale back to the default environment 

			return (EIF_POINTER)_tsetlocale(LC_ALL, "Hebrew");

};

EIF_INTEGER cwel_set_multb_char_codepage(EIF_INTEGER codepage)
{
	return (EIF_INTEGER)_setmbcp((int)codepage);
};


EIF_POINTER test_string(void)
{
	int mbcp, tmpint;

	test_wide[0] = 12449;
	test_wide[1] = 41;
	test_wide[2] = 97;
	
	tmpint = WideCharToMultiByte(
	  CP_UTF8,            // code page
	  0,            // performance and mapping flags
	  test_wide,    // wide-character string
	  12,          // number of chars in string
	  test_multi,     // buffer for new string
	  28,          // size of buffer
	  NULL,     // default for unmappable chars
	  NULL  // set when default char used
	);

	test_wide[0] = 0;
	test_wide[1] = 0;
	test_wide[2] = 0;

	tmpint = MultiByteToWideChar(
  	CP_UTF8,            // code page
  	  0,            // performance and mapping flags
  	  test_multi,    // wide-character string
  	  12,          // number of chars in string
  	  test_wide,     // buffer for new string
  	  5          // size of buffer
	);
	
	mbcp = _getmbcp();

	return (EIF_POINTER)test_wide;

};
