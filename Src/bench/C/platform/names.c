#ifdef EIF_WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

#include "eif_eiffel.h"

rt_public EIF_REFERENCE eif_dot_e (void)
{
#if defined EIF_WIN32 || __VMS || defined EIF_OS2
	return RTMS (".E");
#else
	return RTMS (".e");
#endif
}

rt_public EIF_REFERENCE eif_dot_o (void)
{
#if defined EIF_WIN32 || __VMS || defined EIF_OS2
	return RTMS (".obj");
#else
	return RTMS (".o");
#endif
}

rt_public EIF_REFERENCE eif_driver (void)
{
#if defined EIF_WIN32 || __VMS || defined EIF_OS2
	char driver [20] = "\0";

	strcat (driver, (char *) eif_getenv ("COMPILER"));
	strcat (driver, "\\driver.exe");

	return RTMS (driver);
#else
	return RTMS ("driver");
#endif
}

rt_public EIF_REFERENCE eif_exec_suffix (void)
{
#if defined EIF_WIN32 || __VMS || defined EIF_OS2
	return RTMS (".exe");
#else
	return RTMS ("");
#endif
}

rt_public EIF_REFERENCE eif_finish_freezing (void)
{
	return RTMS ("finish_freezing");
}

rt_public EIF_REFERENCE eif_preobj (void)
{
#if defined EIF_WIN32 || defined EIF_OS2
	return RTMS ("preobj.obj");
#elif defined __VMS
	return RTMS ("preobj.olb");
#else
	return RTMS ("preobj.o");
#endif
}

rt_public EIF_REFERENCE eif_copy_cmd (void)
{
#ifdef EIF_WIN32
	return RTMS ("\\command.com /c copy");
#elif defined EIF_OS2
    return RTMS ("copy");
#elif defined __VMS
	return RTMS ("copy");
#else
	return RTMS ("cp");
#endif
}

rt_public EIF_BOOLEAN eif_valid_class_file_extension (EIF_CHARACTER c)
{
#if defined EIF_WIN32 || defined EIF_OS2
	return (EIF_TEST(tolower(c)=='e'));
#elif defined __VMS
	return (EIF_TEST(c=='E'));
#else
	return (EIF_TEST(c=='e'));
#endif
}

rt_public EIF_REFERENCE eif_timeout_msg (void)
{
	/* Message displayed when ebench is unable to launch
	 * the system (because of a timeout).
	 */

	char *eif_timeout;
	extern char *getenv(const char *);				/* Get environment variable value */

	char s[512];

	strcpy(s, "Could not launch system in allotted time.\n");
	strcat(s, "Try restarting ebench after setting ");
#ifdef __VMS
	strcat(s, " the logical\n");
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
	strcat(s, " seconds.\n");
	return RTMS (s);
}
