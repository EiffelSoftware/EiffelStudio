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
#include "eif_macros.h"

#include <ctype.h>			/* For toupper(), is_alpha(), ... */
#include <stdio.h>

#ifdef __VMS
rt_public int	putenv (char *);
#endif

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

#ifdef __VMS
	char * run_command;
#endif
#ifdef SIGCLD
	Signal_t (*old_signal_hdlr)();

	old_signal_hdlr = signal (SIGCLD, SIG_IGN);
#endif
#ifdef __VMS	/* if s starts with '[', prepend 'run ' */
	if (s[0]=='[') {
		run_command = cmalloc( 4 + strlen(s) );
		sprintf(run_command,"run %s",s);
		result = (EIF_INTEGER) system (run_command);
		}
	else
		result = (EIF_INTEGER) system (s);
#else
	result = (EIF_INTEGER) system (s);
#endif
#ifdef SIGCLD
	(void)signal (SIGCLD, old_signal_hdlr);
#endif

	return result;
}

rt_public EIF_INTEGER eif_putenv (EIF_OBJ v, EIF_OBJ k)
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
	key_len = strlen (eif_access(k));
	if ((key = (char *) eiffel_calloc (appl_len + 46+key_len, 1)) == NULL)
		return (EIF_INTEGER) -1;

	if ((lower_k = (char *) eiffel_calloc (key_len+1, 1)) == NULL) {
		eiffel_free (key);
		return (EIF_INTEGER) -1;
	}

	strcpy (lower_k, eif_access(k));
	CharLowerBuff (lower_k, key_len);

	strcpy (key, "Software\\ISE\\Eiffel42\\");
	strncat (key, rindex(modulename, '\\')+1, appl_len);

	if (RegCreateKeyEx (HKEY_CURRENT_USER, key, 0, "REG_SZ", REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, NULL, &hkey, &disp) != ERROR_SUCCESS) {
		eiffel_free (key);
		eiffel_free (lower_k);
		return (EIF_INTEGER) -1;
	}
	if (RegSetValueEx (hkey, lower_k, 0, REG_SZ, eif_access(v), strlen(eif_access(v))+1) != ERROR_SUCCESS) {
		eiffel_free (key);
		eiffel_free (lower_k);
		RegCloseKey (hkey);
		return (EIF_INTEGER) -1;
	}

	eiffel_free (key);
	eiffel_free (lower_k);
	if ((disp = RegFlushKey (hkey)) != ERROR_SUCCESS)
		return 0;
	if ((disp = RegCloseKey (hkey)) != ERROR_SUCCESS)
		return 0;;
	return (EIF_INTEGER) 0;

#else
	char *new_string; /* %%ss moved from above */
	int l1, l2; /* %%ss moved from above */

	l1 = strlen(eif_access(k));
	l2 = strlen(eif_access(v));

	if ((new_string = (char*)eiffel_malloc (l1+l2+2)) == (char*)0)
		return (EIF_INTEGER)-1;

	strcpy (new_string, eif_access(k));
	strcat (new_string, "=");
	strcat (new_string, eif_access(v));

	return (EIF_INTEGER) putenv (new_string);
#endif
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
	if ((key = (char *) eiffel_calloc (appl_len + 46 +key_len, 1)) == NULL)
		return (EIF_OBJ) 0;

	if ((lower_k = (char *) eiffel_calloc (key_len+1, 1)) == NULL) {
		eiffel_free (key);
		return (EIF_OBJ) 0;
	}

	strcpy (lower_k, k);
	CharLowerBuff (lower_k, key_len);

	strcpy (key, "Software\\ISE\\Eiffel42\\");
	strncat (key, rindex(modulename, '\\')+1, appl_len);

	if (RegOpenKeyEx (HKEY_CURRENT_USER, key, 0, KEY_READ, &hkey) != ERROR_SUCCESS) {
		eiffel_free (key);
		eiffel_free (lower_k);
		return (EIF_OBJ) 0;
	}

	bsize = 1024;
	if (RegQueryValueEx (hkey, lower_k, NULL, NULL, buf, &bsize) != ERROR_SUCCESS) {
		eiffel_free (key);
		eiffel_free (lower_k);
		RegCloseKey (hkey);
		return (EIF_OBJ) getenv (k);
	}

	eiffel_free (key);
	eiffel_free (lower_k);
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
	char *(*init)();		/* Initialization routine for expanded objects */
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
	init = XCreate(dtype);

#ifdef MAY_PANIC
	if ((char *(*)()) 0 == init)		/* There MUST be a routine */
		eiffel_panic("init routine lost");
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


#ifdef __VMS
/* vms putenv
 * 941230/Tom Hoffman
 *	Needed equivalent of putenv routine commonly found on Unix systems.
 *	Note putenv is not part of the ANSI standard.
 *	Uses the lib$set_logical routine.
 */
/* have to define these to upper case because compiling with /names=as_is */
#define lib$set_logical LIB$SET_LOGICAL
#define lib$stop	LIB$STOP
#define sys$getmsg	SYS$GETMSG

#include <lib$routines.h>	/* needed for lib$set_logical() */
#include <descrip.h>


int	putenv (char *string)
	/* string should point to a character string of the form name=value
	** Then the string is parsed into its separate components.
	** lib$set_logical returns an unsigned int.
	*/
{
	char	*	name;
	char	*	value;
	struct	dsc$descriptor_s	dname;
	struct	dsc$descriptor_s	dvalue;
	int	cond_value;
	name = strtok(string,"=");
	dname.dsc$w_length = strlen(name);
	dname.dsc$a_pointer= name;
	dname.dsc$b_class = DSC$K_CLASS_S;
	dname.dsc$b_dtype = DSC$K_DTYPE_T;
	value = strtok(NULL,"=");
	dvalue.dsc$w_length = strlen(value);
	dvalue.dsc$a_pointer= value;
	dvalue.dsc$b_class = DSC$K_CLASS_S;
	dvalue.dsc$b_dtype = DSC$K_DTYPE_T;
	cond_value = lib$set_logical(&dname,&dvalue);
	return (int) cond_value;
}	/* putenv */

#ifdef TEST
#include <stdio.h>
#include <ssdef.h>
#include <errno.h>
#include <starlet.h>		/* for sys$getmsg() */

main ()
{
	char			buff[256];
	int			cond;
	int			flags = 0xf;
	char			mesg[133];
	$DESCRIPTOR(message_text,mesg);
	int			mesglen;
	register		status;


	printf("\n\nEnter putenv string as   name=value :  ");
	(void)fflush(stdout);
	(void)gets(buff);
	if (buff[0] != '\0') {
		cond = putenv(buff);		
		printf("Return value is %d.\n",(int)cond);
		status = SYS$GETMSG(cond,&mesglen,&message_text,flags,0);
		printf("\n<%d> %s\n",status,mesg);
/*		lib$stop(cond); */
	}
}
#endif	/* TEST */
#endif	/* VMS */

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
		eif_dll_table = eiffel_malloc(sizeof(struct eif_dll_info) * eif_dll_capacity);
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
		eif_dll_table = eiffel_realloc(eif_dll_table, sizeof(struct eif_dll_info) * eif_dll_capacity);

		if (eif_dll_table == (struct eif_dll_info *) 0)
			enomem(MTC_NOARG);
	}

	if ((m_name = (char *) eiffel_malloc(strlen(module_name)+1)) == (char *) 0)
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
			eiffel_free(eif_dll_table[i].dll_name);

			module_ptr = eif_dll_table[i].dll_module_ptr;
			if (module_ptr != NULL)
				(void) FreeLibrary(module_ptr);
		}
		eiffel_free(eif_dll_table);
	}
}

#endif
