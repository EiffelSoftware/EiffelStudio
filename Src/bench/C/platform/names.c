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

public EIF_REFERENCE eif_dot_workbench ()
{
#ifdef __WATCOMC__
	return RTMS ("workb.eif");
#else
	return RTMS (".workbench");
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

public EIF_REFERENCE eif_eiffelgen ()
{
#ifdef __WATCOMC__
	return RTMS ("EIFFELGN");
#else
	return RTMS ("EIFFELGEN");
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

public EIF_REFERENCE eif_updt ()
{
#ifdef __WATCOMC__
	return RTMS ("MELTED.EIF");
#else
	return RTMS (".UPDT");
#endif
}

public EIF_REFERENCE eif_default_ace ()
{
#ifdef __WATCOMC__
	return RTMS ("Ace.def");
#else
	return RTMS ("Ace.default");
#endif
}

public EIF_REFERENCE eif_precompiled ()
{
#ifdef __WATCOMC__
	return RTMS ("precomp");
#else
	return RTMS ("precompiled");
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

