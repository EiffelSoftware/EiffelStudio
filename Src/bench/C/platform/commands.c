/*
	Commands used by the compiler to link the precompilation driver,
	to execute `finish_freezing' and other platform dependent actions.

	$Id$
*/

#include "eif_config.h"
#include "eif_portable.h"

#include <sys/types.h>
#include <time.h>
#include <sys/stat.h>

#if defined EIF_WINDOWS || defined EIF_OS2
#else
#include <unistd.h>
#endif

#include <stdlib.h>
#include <stdio.h>

#include "eif_dir.h"
#include "eif_file.h"	/* for PATH_MAX */
#include "eif_error.h"
#include "eif_path_name.h"  /* for eifrt_vms_filespec() */
#include "eif_commands.h"

#ifdef EIF_WIN32
#include <windows.h>
#include "..\ipc\shared\stream.h"
#endif

#ifdef EIF_VMS
#include <assert.h>
#endif

rt_private fnptr set_proc;
rt_private fnptr send_proc;

extern EIF_INTEGER eif_system(char *);

#ifdef EIF_WIN32
extern char *eif_getenv (char *);
#endif

void eif_beep (void)
{
#ifdef EIF_WIN32
	MessageBeep (MB_ICONEXCLAMATION);
#else
	fprintf (stderr, "\07");
#endif
}

void async_shell_pass_address(fnptr send_address, fnptr set_address)
{
		/* Rescord the `set_command_name' and `send' function pointers */
	set_proc = set_address;
	send_proc = send_address;
}

void eif_link_driver (EIF_OBJECT c_code_dir, EIF_OBJECT system_name, EIF_OBJECT prelink_command_name, EIF_OBJECT driver_name)
{
#if defined EIF_WIN32 || defined EIF_OS2
	char *source_exe, *target_exe;
	FILE *fi, *fo;
	char buffer[4096];
	size_t amount;

		/* Link */
	amount = strlen (eif_access(driver_name));
	source_exe = (char *) malloc(amount + 1);
	if (source_exe == (char *)0)
		enomem();
	strncpy (source_exe, eif_access (driver_name), amount);
	source_exe [amount] = '\0';
	fi = fopen (source_exe, "rb");
	target_exe = malloc (strlen (eif_access (system_name)) + strlen (eif_access (c_code_dir)) + 6);
	sprintf (target_exe, "%s\\%s.exe", eif_access (c_code_dir), eif_access (system_name));
	fo = fopen (target_exe, "wb");

	amount = 4096;
	while (amount == 4096) {
		amount = fread (buffer, sizeof(char), amount, fi);
		if (amount != fwrite (buffer, sizeof(char), amount, fo))
			eio();
	}

	fclose (fi);
	fclose (fo);
	free (source_exe);
	free (target_exe);

#elif defined EIF_VMS
	char *cmd; size_t cmd_len; 
	const char *c_code_dir_cstr  = eif_access (c_code_dir);
	const char *system_name_cstr = eif_access (system_name);
	const char *prelink_cmd_cstr = eif_access (prelink_command_name);	    /* what is this for? */
	const char *driver_name_cstr = eif_access (driver_name);
	char driver_name_vms[PATH_MAX +1], c_code_dir_vms[PATH_MAX +1];
	int res;

	/* translate driver name and c code directory to VMS filespec syntax */
	eifrt_vms_filespec (driver_name_cstr, driver_name_vms);
	eifrt_vms_filespec (c_code_dir_cstr,  c_code_dir_vms);

	/* allocate buffer for command, add 10 bytes of overhead for COPY command verb, spaces, and terminator */
	cmd_len = strlen(driver_name_vms) + strlen(c_code_dir_vms) + strlen(system_name_cstr) + 10;
	cmd = malloc (cmd_len);
	if (cmd == NULL)
	    enomem();

	sprintf (cmd, "COPY %s %s%s", driver_name_vms, c_code_dir_vms, system_name_cstr);
	assert (strlen(cmd) < cmd_len);
	printf ("$ %s\n",cmd);
	res = eif_system (cmd);
	free (cmd);

#else
	char *cmd;

	cmd = malloc(20 + strlen(eif_access(c_code_dir)) + strlen(eif_access(system_name)) +
					strlen(eif_access(prelink_command_name)) + strlen(eif_access(driver_name)));
	if (cmd == (char *)0)
		enomem();

	sprintf(cmd, "%s %s %s/%s", eif_access(prelink_command_name),
		 eif_access(driver_name), eif_access(c_code_dir),
		 eif_access(system_name));

	(void) eif_system(cmd);
	free(cmd);
#endif
}

void eif_gr_link_driver (EIF_OBJECT request, EIF_OBJECT c_code_dir, EIF_OBJECT system_name, EIF_OBJECT prelink_command_name, EIF_OBJECT driver_name)
{
#if defined EIF_WIN32 || defined EIF_OS2 || defined EIF_VMS
	eif_link_driver(c_code_dir, system_name, prelink_command_name, driver_name);
#else
	char *cmd;

	cmd = malloc(15 + strlen(eif_access(c_code_dir)) + strlen (eif_access(system_name)) +
					strlen(eif_access(prelink_command_name)) + strlen(eif_access(driver_name)));
	if (cmd == (char *)0)
		enomem();

	sprintf(cmd, "%s %s %s/%s", eif_access(prelink_command_name), eif_access(driver_name), eif_access(c_code_dir), eif_access(system_name));

	(*set_proc)(eif_access(request), RTMS (cmd));
	(*send_proc)(eif_access(request));

	free(cmd);
#endif
}

EIF_REFERENCE eif_date_string (EIF_INTEGER a_date)
{
	EIF_REFERENCE result;
	char *date_string = ctime((time_t*)&a_date);

	result = RTMS(date_string);
	/* free (date_string); FIXME - check with xavier */
	return (EIF_REFERENCE) result;
}

#ifdef EIF_WIN32

/* C routines for the communications of debugged application and debugger. */

extern STREAM *sp;

typedef void (* EVENT_CALLBACK)(EIF_REFERENCE);
EVENT_CALLBACK event_callback;
EIF_OBJECT event_object;
EIF_INTEGER delay;
UINT event_id;

void CALLBACK ioh_timer(HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime);

void win_ioh_make_client(EIF_POINTER a, EIF_OBJECT o, EIF_INTEGER a_delay)
{
	event_callback = (EVENT_CALLBACK) a;
	event_object = eif_adopt (o);
	delay = a_delay; 
}

void CALLBACK ioh_timer(HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime)
{
	/* KillTimer */
	if (WaitForSingleObject (readev(sp), 0) == WAIT_OBJECT_0)
		(event_callback)(eif_access(event_object));
}

void start_timer (void)
{
	/* Start the timer event to check for communications 
	   between bench and the application */
	event_id = SetTimer (NULL, 0, delay, (TIMERPROC) ioh_timer);
}

void stop_timer (void)
{
	/* Kill the timer event */
	KillTimer (NULL, event_id);
}

#endif
