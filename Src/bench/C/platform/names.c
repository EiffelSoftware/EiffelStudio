#include "eiffel.h"

public EIF_REFERENCE eif_dot_e ()
{
#ifdef __WATCOMC__
	return RTMS (".E");
#else
	return RTMS (".e");
#endif
}

public EIF_REFERENCE eif_dot_o ()
{
#ifdef __WATCOMC__
	return RTMS (".obj");
#else
	return RTMS (".o");
#endif
}

public EIF_REFERENCE eif_driver ()
{
#ifdef __WATCOMC__
	return RTMS ("driver.exe");
#else
	return RTMS ("driver");
#endif
}

public EIF_CHARACTER eif_eiffel_suffix ()
{
#ifdef __WATCOMC__
	return 'E';
#else
	return 'e';
#endif
}

public EIF_REFERENCE eif_exec_suffix ()
{
#ifdef __WATCOMC__
	return RTMS (".exe");
#else
	return RTMS ("");
#endif
}

public EIF_REFERENCE eif_preobj ()
{
#ifdef __WATCOMC__
	return RTMS ("preobj.obj");
#else
	return RTMS ("preobj.o");
#endif
}

public EIF_REFERENCE eif_copy_cmd ()
{
#ifdef __WATCOMC__
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

#ifdef __WATCOMC__
	extern *appl_ini_file ();
#endif
	extern char *getenv();				/* Get environment variable value */

	char s[512];
	char *eif_timeout;

	strcpy(s, "Couldn't launch system in allotted time.\n");
	strcat(s, "Try restarting ebench after setting ");
#ifdef __WATCOMC__
	strcat(s, "variable\n");
#else
	strcat(s, "environment\nvariable ");
#endif
	strcat(s, "EIF_TIMEOUT to a value larger than\n");
	eif_timeout = getenv("EIF_TIMEOUT");
	if (eif_timeout != (char *) 0) {	/* Environment variable set */
		strcat(s, "current value ");
		strcat(s, eif_timeout);
	} else {
		strcat(s, "the default 120");
	}
#ifdef __WATCOMC__
	strcat(s, " in the [Environment] section\nof the file ");
	strcat(s, appl_ini_file());
	strcat(s, "\n");
#else
	strcat(s, ".\n");
#endif
	return RTMS (s);
}
