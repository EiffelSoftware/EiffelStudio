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

