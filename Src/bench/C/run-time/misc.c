/*

 #    #     #     ####    ####            ####
 ##  ##     #    #       #    #          #    #
 # ## #     #     ####   #               #
 #    #     #         #  #        ###    #
 #    #     #    #    #  #    #   ###    #    #
 #    #     #     ####    ####    ###     ####

	Miscellenaous Eiffel externals

*/

#include "portable.h"
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include "misc.h"
#include "malloc.h"
#include "macros.h"
#include "cecil.h"

#include <ctype.h>			/* For toupper(), is_alpha(), ... */

#ifdef __WINDOWS_386__
#include <windows.h>
#endif

/*
 * Various casts.
 */

public EIF_CHARACTER chconv(i)
EIF_INTEGER i;
{
	return (EIF_CHARACTER) i;	/* (EIF_INTEGER) -> (EIF_CHARACTER) */
}

public EIF_INTEGER chcode(c)
EIF_CHARACTER c;
{
	return (EIF_INTEGER) c;	/* (EIF_CHARACTER) -> (EIF_INTEGER) */
}

public EIF_POINTER conv_pp(p)
EIF_POINTER p;
{
	return p;	/* (EIF_POINTER) -> (EIF_POINTER) */
}

public EIF_INTEGER conv_pi(p)
EIF_POINTER p;
{
	return (EIF_INTEGER) p;	/* (EIF_POINTER) -> (EIF_INTEGER) */
}

public EIF_REAL conv_ir(v)
EIF_INTEGER v;
{
	return (EIF_REAL) v;	/* (EIF_INTEGER) -> (EIF_REAL) */
}

public EIF_INTEGER conv_ri(v)
EIF_REAL v;
{
	return (EIF_INTEGER) v;	/* (EIF_REAL) -> (EIF_INTEGER) */
}

public EIF_REAL conv_dr (d)
EIF_DOUBLE d;
{
	return (EIF_REAL) d;	/* (EIF_DOUBLE) -> (EIF_REAL) */
}

public EIF_INTEGER conv_di(d)
EIF_DOUBLE d;
{
	return (EIF_INTEGER) d;		/* (EIF_DOUBLE) -> (EIF_INTEGER) */
}

public EIF_INTEGER bointdiv(n1, n2)
EIF_INTEGER n1, n2;
{
	/* Return the greatest integer less or equal to the
	 * integer division of `n1' by `n2'
	 */

	return ((n1 >= 0) ^ (n2 > 0))  ? (n1 % n2 ? n1 / n2 - 1: n1 / n2) : n1 / n2;
}

public EIF_INTEGER upintdiv(n1,n2)
EIF_INTEGER n1, n2;
{
	/* Return the smallest integer greater or equal to the
	 * integer division of `n1' by `n2'
	 */

	return ((n1 >= 0) ^ (n2 > 0)) ? n1 / n2: ((n1 % n2) ? n1 / n2 + 1: n1 / n2);
}

/*
 * Character conversions
 */


public EIF_CHARACTER chupper(c)
EIF_CHARACTER c;
{
	return (EIF_CHARACTER)toupper(c);
}

public EIF_CHARACTER chlower(c)
EIF_CHARACTER c;
{
	return (EIF_CHARACTER)tolower(c);
}

public EIF_BOOLEAN chis_upper(c)
EIF_CHARACTER c;
{
	return (EIF_BOOLEAN)isupper(c);
}

public EIF_BOOLEAN chis_lower(c)
EIF_CHARACTER c;
{
	return (EIF_BOOLEAN)islower(c);
}

public EIF_BOOLEAN chis_digit(c)
EIF_CHARACTER c;
{
	return (EIF_BOOLEAN)isdigit(c);
}

public EIF_BOOLEAN chis_alpha(c)
EIF_CHARACTER c;
{
	return (EIF_BOOLEAN)isalpha(c);
}

public EIF_INTEGER eschar_size()
{
	return ALIGN*CHRSIZ;
}

public EIF_INTEGER esreal_size()
{
	return ALIGN*FLTSIZ;
}

public EIF_INTEGER esint_size()
{
	return ALIGN*LNGSIZ;
}

public EIF_INTEGER esdouble_size()
{
	return ALIGN*DBLSIZ;
}

/*
 * Protected call to system
 */

public EIF_INTEGER eif_system (s)
char *s;
{
	EIF_INTEGER result;

#ifdef __WINDOWS_386__
	extern void wmhandler_yield();
#endif

	Signal_t (*old_signal_hdlr)();

#ifdef SIGCLD
	old_signal_hdlr = signal (SIGCLD, SIG_IGN);
#endif
#ifdef __WINDOWS_386__
	result = WinExec (s, SW_SHOWNORMAL);
	if (result > 32){
		while (GetModuleUsage(result))
			wmhandler_yield();
		result = 0;
		}
#else
	result = (EIF_INTEGER) system (s);
#endif
#ifdef SIGCLD
	(void)signal (SIGCLD, old_signal_hdlr);
#endif

	return result;
}

public EIF_INTEGER eif_putenv (v,k)
EIF_OBJ v,k;
{
		/* We need a copy of the string because the string will be
			referenced in the environment and the eiffel string can
			be garbage collected ... */

	char *new_string;
	int l1, l2;
	char *s1;

#ifdef __WINDOWS_386__
	EIF_INTEGER result;
	char *ini;
	extern char **_argv;

	if ((ini = (char *) calloc (strlen(_argv[0])+1,1)) == (char *)0)
		return (EIF_INTEGER) -1;

	strncpy (ini,_argv[0], rindex(_argv[0],'.')-_argv[0]);
	strcat (ini, ".INI");
	result = WritePrivateProfileString("Environment", eif_access (k), eif_access (v), ini);
	free (ini);
	return (result ? 0 : -1);  /* Non zero indicate ok - yuk */
#else
	l1 = strlen(eif_access(k));
	l2 = strlen(eif_access(v));

	if ((new_string = (char*)malloc (l1+l2+2)) == (char*)0)
		return (EIF_INTEGER)-1;

	strcpy (new_string, eif_access(k));
	strcat (new_string, "=");
	strcat (new_string, eif_access(v));

	return (EIF_INTEGER) putenv (new_string);
#endif
}

public EIF_OBJ eif_getenv (k)
EIF_OBJ k;
{
#ifdef __WINDOWS_386__
	char *ini;
	static char buf[128];
	extern char **_argv;

	if ((ini = (char *) calloc (strlen(_argv[0])+1,1)) == (char *)0)
		return (EIF_INTEGER) 0;

	strncpy (ini, _argv[0], rindex(_argv[0],'.')-_argv[0]);
	strcat (ini, ".INI");
	GetPrivateProfileString ("Environment", k, "", buf, 128, ini);
	free (ini);
	return buf;
#else
	return (EIF_OBJ) getenv (k);
#endif
}

/***************************************/

public char *arycpy(area, i, j, k)
char *area;
EIF_INTEGER i, j, k;
{
	/* Reallocation of memory for an array's `area' for new count `i', keeping
	 * the old content.(starts at `j' and is `k' long).
	 */

	union overhead *zone;
	char *new_area, *ref;
	long elem_size;			/* Size of each item within area */
	char *(*init)();		/* Initialization routine for expanded objects */
	int dtype;				/* Dynamic type of the first expanded object */
	int n;					/* Counter for initialization of expanded */

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
	init = Create(dtype);

#ifdef MAY_PANIC
	if ((char *(*)()) 0 == init)		/* There MUST be a routine */
		panic("init routine lost");
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


#ifdef __WINDOWS_386__

/* DLL Stuff */

#define EIF_DLL_CHUNK 20

struct eif_dll_info {
	char *dll_name;
	HANDLE dll_module_ptr;
};

struct eif_dll_info *eif_dll_table = (struct eif_dll_info *) 0;

int eif_dll_capacity = EIF_DLL_CHUNK;
int eif_dll_count = 0;

HANDLE eif_load_dll(module_name)
char *module_name;
{
	HANDLE a_result;
	char *m_name;
	int i;

	if (eif_dll_table == (struct eif_dll_info *) 0) {
		eif_dll_table = malloc(sizeof(struct eif_dll_info) * eif_dll_capacity);
		if (eif_dll_table == (struct eif_dll_info *) 0)
			enomem();
	}

	for (i=0; i < eif_dll_count; i++) {
		if (strcasecmp(eif_dll_table[i].dll_name, module_name) == 0)
			return eif_dll_table[i].dll_module_ptr;
	}

	if (eif_dll_count == eif_dll_capacity) {
		eif_dll_capacity += EIF_DLL_CHUNK;
		eif_dll_table = realloc(eif_dll_table, sizeof(struct eif_dll_info) * eif_dll_capacity);

		if (eif_dll_table == (struct eif_dll_info *) 0)
			enomem();
	}

	if ((m_name = (char *) malloc(strlen(module_name)+1)) == (char *) 0)
		enomem();
	strcpy (m_name, module_name);

	a_result = LoadLibrary(module_name);

	eif_dll_table[eif_dll_count].dll_name = m_name;
	eif_dll_table[eif_dll_count].dll_module_ptr = a_result;

	eif_dll_count++;

	return a_result;
}

void eif_free_dlls()
{
	int i;
	HANDLE module_ptr;

	if (eif_dll_table) {
		for (i=0; i< eif_dll_count; i++) {
			free(eif_dll_table[i].dll_name);

			module_ptr = eif_dll_table[i].dll_module_ptr;
			if (module_ptr > 32)
				FreeLibrary(module_ptr);
		}
		free(eif_dll_table);
	}
}

#endif
