#include "eiffel.h"
#ifdef __WINDOWS_386__
#include <windows.h>
#endif

public EIF_REFERENCE eif_dot_e ()
{
#ifdef __WINDOWS_386__
	return RTMS (".E");
#else
	return RTMS (".e");
#endif
}

public EIF_REFERENCE eif_dot_o ()
{
#ifdef __WINDOWS_386__
	return RTMS (".obj");
#else
	return RTMS (".o");
#endif
}

public EIF_REFERENCE eif_driver ()
{
#ifdef __WINDOWS_386__
	return RTMS ("driver.exe");
#else
	return RTMS ("driver");
#endif
}

public EIF_CHARACTER eif_eiffel_suffix ()
{
#ifdef __WINDOWS_386__
	return 'E';
#else
	return 'e';
#endif
}

public EIF_REFERENCE eif_exec_suffix ()
{
#ifdef __WINDOWS_386__
	return RTMS (".exe");
#else
	return RTMS ("");
#endif
}

public EIF_REFERENCE eif_finish_freezing ()
{
#ifdef __WINDOWS_386__
	return RTMS ("es3sh");
#else
	return RTMS ("finish_freezing");
#endif
}

public EIF_REFERENCE eif_preobj ()
{
#ifdef __WINDOWS_386__
	return RTMS ("preobj.obj");
#else
	return RTMS ("preobj.o");
#endif
}

public EIF_REFERENCE eif_copy_cmd ()
{
#ifdef __WINDOWS_386__
	return RTMS ("\command.com /c copy");
#else
	return RTMS ("cp");
#endif
}

public EIF_REFERENCE eif_timeout_msg ()
{
	/* Message displayed when ebench is unable to launch
	 * the system (because of a timeout).
	 */

#ifdef __WINDOWS_386__
	extern char *appl_ini_file ();
	char eif_timeout[10];
#else
	char *eif_timeout;
#endif
	extern char *getenv();				/* Get environment variable value */

	char s[512];

	strcpy(s, "Could not launch system in allotted time.\n");
	strcat(s, "Try restarting ebench after setting ");
#ifdef __WINDOWS_386__
	strcat(s, "variable\n");
#else
	strcat(s, "environment\nvariable ");
#endif
	strcat(s, "EIF_TIMEOUT to a value larger than\n");
#ifdef __WINDOWS_386__
	GetPrivateProfileString ("Communications", "EIF_TIMEOUT", "15000", eif_timeout, 10 ,appl_ini_file());
	strcat(s, eif_timeout);
	strcat(s, " in the [Communications] section\nof the file ");
	strcat(s, appl_ini_file());
	strcat(s, "\n");
#else
	eif_timeout = getenv("EIF_TIMEOUT");
	if (eif_timeout != (char *) 0) {	/* Environment variable set */
		strcat(s, "current value ");
		strcat(s, eif_timeout);
	} else {
		strcat(s, "the default 120");
	}
	strcat(s, ".\n");
#endif
	return RTMS (s);
}
