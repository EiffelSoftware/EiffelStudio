/*

 #    #     #     ####    ####            ####
 ##  ##     #    #       #    #          #    #
 # ## #     #     ####   #               #
 #    #     #         #  #        ###    #
 #    #     #    #    #  #    #   ###    #    #
 #    #     #     ####    ####    ###     ####

	Miscellenaous Eiffel externals

*/

#include "eif_config.h"
#include "eif_portable.h"	/* must come before <stdlib.h> for VMS */

#ifdef EIF_WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <eif_file.h>
#endif

#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include "eif_misc.h"
#include "eif_malloc.h"
#include "eif_lmalloc.h"		/* for eif_malloc() */
#include "eif_macros.h"

#include <ctype.h>			/* For toupper(), is_alpha(), ... */
#include <stdio.h>


#if defined EIF_VMS && defined WORKBENCH
    /* force VMS linker to pull in DLE module */
#include "eif_dle.h"
static void dunsel()	/* this will never be called */
{   dle_reclaim();  }
#endif  /* EIF_VMS && WORKBENCH  */

/*
 * Various casts.
 */

rt_public EIF_CHARACTER chconv(EIF_INTEGER i)
{
	return (EIF_CHARACTER) i;	/* (EIF_INTEGER) -> (EIF_CHARACTER) */
}

rt_public EIF_INTEGER chcode(EIF_CHARACTER c)
{
	return (EIF_INTEGER) c;	/* (EIF_CHARACTER) -> (EIF_INTEGER) */
}

rt_public EIF_POINTER conv_pp(EIF_POINTER p)
{
	return p;	/* (EIF_POINTER) -> (EIF_POINTER) */
}

rt_public EIF_INTEGER conv_pi(EIF_POINTER p)
{
	return (EIF_INTEGER) p;	/* (EIF_POINTER) -> (EIF_INTEGER) */
}

rt_public EIF_REAL conv_ir(EIF_INTEGER v)
{
	return (EIF_REAL) v;	/* (EIF_INTEGER) -> (EIF_REAL) */
}

rt_public EIF_INTEGER conv_ri(EIF_REAL v)
{
	return (EIF_INTEGER) v;	/* (EIF_REAL) -> (EIF_INTEGER) */
}

rt_public EIF_REAL conv_dr (EIF_DOUBLE d)
{
	return (EIF_REAL) d;	/* (EIF_DOUBLE) -> (EIF_REAL) */
}

rt_public EIF_INTEGER conv_di(EIF_DOUBLE d)
{
	return (EIF_INTEGER) d;		/* (EIF_DOUBLE) -> (EIF_INTEGER) */
}

rt_public EIF_INTEGER bointdiv(EIF_INTEGER n1, EIF_INTEGER n2)
{
	/* Return the greatest integer less or equal to the
	 * integer division of `n1' by `n2'
	 */

	return ((n1 >= 0) ^ (n2 > 0))  ? (n1 % n2 ? n1 / n2 - 1: n1 / n2) : n1 / n2;
}

rt_public EIF_INTEGER upintdiv(EIF_INTEGER n1, EIF_INTEGER n2)
{
	/* Return the smallest integer greater or equal to the
	 * integer division of `n1' by `n2'
	 */

	return ((n1 >= 0) ^ (n2 > 0)) ? n1 / n2: ((n1 % n2) ? n1 / n2 + 1: n1 / n2);
}

/*
 * Character conversions
 */


rt_public EIF_CHARACTER chupper(EIF_CHARACTER c)
{
	return (EIF_CHARACTER)toupper(c);
}

rt_public EIF_CHARACTER chlower(EIF_CHARACTER c)
{
	return (EIF_CHARACTER)tolower(c);
}

rt_public EIF_BOOLEAN chis_upper(EIF_CHARACTER c)
{
	return EIF_TEST(isupper(c));
}

rt_public EIF_BOOLEAN chis_lower(EIF_CHARACTER c)
{
	return EIF_TEST(islower(c));
}

rt_public EIF_BOOLEAN chis_digit(EIF_CHARACTER c)
{
	return EIF_TEST(isdigit(c));
}

rt_public EIF_BOOLEAN chis_alpha(EIF_CHARACTER c)
{
	return EIF_TEST(isalpha(c));
}

rt_public EIF_INTEGER eschar_size(void)
{
	return BYTSIZ*CHRSIZ;
}

rt_public EIF_INTEGER esreal_size(void)
{
	return BYTSIZ*FLTSIZ;
}

rt_public EIF_INTEGER esint_size(void)
{
	return BYTSIZ*LNGSIZ;
}

rt_public EIF_INTEGER esdouble_size(void)
{
	return BYTSIZ*DBLSIZ;
}

/*
 * Protected call to system
 */

rt_public EIF_INTEGER eif_system (char *s)
{
	EIF_INTEGER result;

#ifdef SIGCLD
	Signal_t (*old_signal_hdlr)();
	old_signal_hdlr = signal (SIGCLD, SIG_IGN);
#endif

#ifdef EIF_VMS	/* if s contains '[', prepend 'run ' */
	{   /* if it contains a '[' before a space (ie. no verb), prepend "run " */
	    char *p = strchr (s, '[');
	    if ( (p) && p < strchr (s, ' ') ) {
		    char * run_cmd = eif_malloc (10 + strlen(s));
		    if ( (run_cmd) ) {
			strcat (strcpy (run_cmd, "run "), s);
			result = (EIF_INTEGER) system (run_cmd);
			eif_free (run_cmd);
		    } else result = -1;
	    }
	    else result = (EIF_INTEGER) system (s);
	}

#else   /* (not) EIF_VMS */
	result = (EIF_INTEGER) system (s);
#endif  /* EIF_VMS */

#ifdef SIGCLD
	(void)signal (SIGCLD, old_signal_hdlr);
#endif

	return result;
}

rt_public EIF_INTEGER eif_putenv (char *v, char *k)
{
		/* We need a copy of the string because the string will be
			referenced in the environment and the eiffel string can
			be garbage collected ... */

	/* char *s1; */ /* %%ss removed */

#ifdef EIF_WIN32
	char *key, *lower_k; /* %%ss removed *value, buf[1024] */
	int appl_len, key_len;
	char modulename [MAX_PATH];
	HKEY hkey;
	DWORD disp;

	GetModuleFileName (NULL, modulename, MAX_PATH);
	appl_len = rindex (modulename, '.') - rindex (modulename, '\\') -1;
	key_len = strlen (k);
	if ((key = (char *) eif_calloc (appl_len + 46 + key_len, 1)) == NULL)
		return (EIF_INTEGER) -1;

	if ((lower_k = (char *) eif_calloc (key_len + 1, 1)) == NULL) {
		eif_free (key);
		return (EIF_INTEGER) -1;
	}

	strcpy (lower_k, k);
	CharLowerBuff (lower_k, key_len);

	strcpy (key, "Software\\ISE\\Eiffel43\\");
	strncat (key, rindex(modulename, '\\') + 1, appl_len);

	if (RegCreateKeyEx (HKEY_CURRENT_USER, key, 0, "REG_SZ", REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, NULL, &hkey, &disp) != ERROR_SUCCESS) {
		eif_free (key);
		eif_free (lower_k);
		return (EIF_INTEGER) -1;
	}
	if (RegSetValueEx (hkey, lower_k, 0, REG_SZ, v, strlen(v)+1) != ERROR_SUCCESS) {
		eif_free (key);
		eif_free (lower_k);
		RegCloseKey (hkey);
		return (EIF_INTEGER) -1;
	}

	eif_free (key);
	eif_free (lower_k);
	if ((disp = RegFlushKey (hkey)) != ERROR_SUCCESS)
		return 0;
	if ((disp = RegCloseKey (hkey)) != ERROR_SUCCESS)
		return 0;;
	return (EIF_INTEGER) 0;

#else

	return eif_safe_putenv (v, k);	/* Use a safe Eiffel putenv using environment variables */
#endif
}

rt_public EIF_INTEGER eif_safe_putenv (EIF_OBJ v, EIF_OBJ k) 
{
	/* Safe Eiffel putenv using environment variables. This has been added
	 * for EiffelWeb, because on windows we needed to deal with environment
	 * variables and not registry keys which was done with eif_putenv.
	 * We make a copy of the string with malloc, so that the it will not
     * be collected by the GC.
	 */

	char *new_string; 
	int l1, l2;

	l1 = strlen(k);
	l2 = strlen(v);

	if ((new_string = (char*)eif_malloc (l1+l2+2)) == (char*)0)
		return (EIF_INTEGER) -1;

	strcpy (new_string, k);
	strcat (new_string, "=");
	strcat (new_string, v);

	return (EIF_INTEGER) putenv (new_string);
}

rt_public EIF_OBJ eif_getenv (EIF_OBJ k)
{
#ifdef EIF_WIN32
	char *key, *lower_k; /* %%ss removed *value */
	static char buf[1024];
	int appl_len, key_len;
	char modulename [MAX_PATH];
	HKEY hkey;
	DWORD bsize;


	GetModuleFileName (NULL, modulename, MAX_PATH);
	appl_len = rindex (modulename, '.') - rindex (modulename, '\\') -1;
	key_len = strlen (k);
	if ((key = (char *) eif_calloc (appl_len + 46 +key_len, 1)) == NULL)
		return (EIF_OBJ) 0;

	if ((lower_k = (char *) eif_calloc (key_len+1, 1)) == NULL) {
		eif_free (key);
		return (EIF_OBJ) 0;
	}

	strcpy (lower_k, k);
	CharLowerBuff (lower_k, key_len);

	strcpy (key, "Software\\ISE\\Eiffel43\\");
	strncat (key, rindex(modulename, '\\')+1, appl_len);

	if (RegOpenKeyEx (HKEY_CURRENT_USER, key, 0, KEY_READ, &hkey) != ERROR_SUCCESS) {
		eif_free (key);
		eif_free (lower_k);
		return (EIF_OBJ) 0;
	}

	bsize = 1024;
	if (RegQueryValueEx (hkey, lower_k, NULL, NULL, buf, &bsize) != ERROR_SUCCESS) {
		eif_free (key);
		eif_free (lower_k);
		RegCloseKey (hkey);
		return (EIF_OBJ) getenv (k);
	}

	eif_free (key);
	eif_free (lower_k);
	RegCloseKey (hkey);
	return (EIF_OBJ) buf;
#else
	return (EIF_OBJ) getenv (k);
#endif
}

/***************************************/

rt_public char *arycpy(char *area, EIF_INTEGER i, EIF_INTEGER j, EIF_INTEGER k)
{
	/* Reallocation of memory for an array's `area' for new count `i', keeping
	 * the old content.(starts at `j' and is `k' long).
	 */

	union overhead *zone;
	char *new_area, *ref;
	long elem_size;			/* Size of each item within area */
	char *(*init)(char *);		/* Initialization routine for expanded objects */
	int dtype;				/* Dynamic type of the first expanded object */
	int n;					/* Counter for initialization of expanded */

/* FIXME: check efficiency

	request from Philippe Stephan CALFP

*/

	zone = HEADER(area);
	ref = area + (zone->ov_size & B_SIZE) - LNGPAD(2);
	ref += sizeof(long);
	elem_size = *(long *) ref;			/* Extract the element size */

	new_area = sprealloc(area, i);		/* Reallocation of special object */

	/* Move old contents to the right position and fill in empty parts with
	 * zeros.
	 */

	safe_bcopy(new_area, new_area + j * elem_size, k * elem_size);
	bzero(new_area, j * elem_size);		/* Fill empty parts of area with 0 */
	bzero(new_area + (j + k) * elem_size, (i - j - k) * elem_size);

	if (!(HEADER(new_area)->ov_flags & EO_COMP))
		return new_area;				/* No expanded objects */

	/* If there are some expanded objects, then we must initialize them by
	 * calling the initialization routine (which will set up intra references).
	 * The dynamic type of all the expanded object is the same, so we only
	 * compute the one of the first element. Note that the Dtype() macro needs
	 * a pointer to the object and not to the zone, hence the shifting by
	 * OVERHEAD bytes in the computation of 'dtype'--RAM.
	 */

	ref = (new_area + j * elem_size) + OVERHEAD;	/* Needed for stupid gcc */
	dtype = Dtype(ref);					/* Gcc won't let me expand that!! */
	init = (char *(*)(char *)) XCreate(dtype);

#ifdef MAY_PANIC
	if ((char *(*)()) 0 == init)		/* There MUST be a routine */
		eif_panic("init routine lost");
#endif
	
	/* Initialize expanded objects from 0 to (j - 1) */
	for (
		n = 0, ref = new_area + OVERHEAD;
		n < j;
		n++, ref += elem_size
	) {
		zone = HEADER(ref);
		zone->ov_size = ref - new_area;		/* For GC: offset within area */
		zone->ov_flags = dtype;				/* Expanded type */
		(init)(ref);						/* Call initialization routine */

/*FIXME two arguments ... Xavier*/
	}

	/* Update offsets for k objects starting at j */
	for (
		n = j + k - 1, ref = new_area + (n * elem_size);
		n >= j;
		n--, ref -= elem_size
	)
		((union overhead *) ref)->ov_size = ref - new_area + OVERHEAD;
	
	/* Intialize remaining objects from (j + k) to (i - 1) */
	for (
		n = j + k, ref = new_area + (n * elem_size) + OVERHEAD;
		n < i;
		n++, ref += elem_size
	) {
		zone = HEADER(ref);
		zone->ov_size = ref - new_area;		/* For GC: offset within area */
		zone->ov_flags = dtype;				/* Expanded type */
		(init)(ref);						/* Call initialization routine */
/*FIXME two arguments ... Xavier*/

	}

	return new_area;
}



#ifdef EIF_WINDOWS

/* DLL declarations */

#define EIF_DLL_CHUNK 20

struct eif_dll_info {
	char *dll_name;
	HANDLE dll_module_ptr;
};

struct eif_dll_info *eif_dll_table = (struct eif_dll_info *) 0;

int eif_dll_capacity = EIF_DLL_CHUNK;
int eif_dll_count = 0;

HANDLE eif_load_dll(char *module_name)
{
	HANDLE a_result;
	char *m_name;
	int i;

	if (eif_dll_table == (struct eif_dll_info *) 0) {
		eif_dll_table = eif_malloc(sizeof(struct eif_dll_info) * eif_dll_capacity);
		if (eif_dll_table == (struct eif_dll_info *) 0)
			enomem(MTC_NOARG);
	}

	for (i=0; i < eif_dll_count; i++) {
			/* Case insensitive comparison */
		if (strcmpi(eif_dll_table[i].dll_name, module_name) == 0)
			return eif_dll_table[i].dll_module_ptr;
	}

	if (eif_dll_count == eif_dll_capacity) {
		eif_dll_capacity += EIF_DLL_CHUNK;
		eif_dll_table = eif_realloc(eif_dll_table, sizeof(struct eif_dll_info) * eif_dll_capacity);

		if (eif_dll_table == (struct eif_dll_info *) 0)
			enomem(MTC_NOARG);
	}

	if ((m_name = (char *) eif_malloc(strlen(module_name)+1)) == (char *) 0)
		enomem(MTC_NOARG);
	strcpy (m_name, module_name);

	a_result = LoadLibrary(module_name);

	eif_dll_table[eif_dll_count].dll_name = m_name;
	eif_dll_table[eif_dll_count].dll_module_ptr = a_result;

	eif_dll_count++;

	return a_result;
}

void eif_free_dlls(void)
{
	int i;
	HINSTANCE module_ptr;

	if (eif_dll_table) {
		for (i=0; i< eif_dll_count; i++) {
			eif_free(eif_dll_table[i].dll_name);

			module_ptr = eif_dll_table[i].dll_module_ptr;
			if (module_ptr != NULL)
				(void) FreeLibrary(module_ptr);
		}
		eif_free(eif_dll_table);
	}
}

#endif  /* EIF_WINDOWS */
