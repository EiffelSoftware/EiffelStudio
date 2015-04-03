#include "my_beep.h"

#ifdef EIF_WINDOWS
#	include <windows.h>
#else
#	include <stdio.h>
#endif

EIF_BOOLEAN my_beep (EIF_INTEGER kind)
{
#ifdef EIF_WINDOWS
	static UINT messageType [] =
		{MB_ICONWARNING, MB_ICONERROR};
	
	return MessageBeep (messageType [kind])?
		EIF_TRUE: EIF_FALSE;
#else
	return (printf ("\a") >= 0)?
		EIF_TRUE: EIF_FALSE;
#endif
}