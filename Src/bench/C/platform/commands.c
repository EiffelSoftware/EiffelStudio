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

#ifdef EIF_WIN32
#include <windows.h>
#include "..\ipc\shared\stream.h"
#endif

#ifdef EIF_VMS
#include <assert.h>
#endif

#ifdef EIF_OS2
#define INCL_DOSPROCESS		/* Constants used for calls to DosExecPgm() */
#define INCL_DOS
#define INCL_DOSERRORS
#include <os2.h>
#endif

rt_private fnptr set_proc;
rt_private fnptr send_proc;

extern EIF_INTEGER eif_system(char *);

#ifdef EIF_WIN32
extern char *eif_getenv (char *);
#endif

#ifdef EIF_OS2
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

void eif_call_finish_freezing(EIF_OBJ c_code_dir, EIF_OBJ freeze_cmd_name)
{
#ifdef EIF_WIN32
	STARTUPINFO				siStartInfo;
	PROCESS_INFORMATION		procinfo;
	char *cmd, *current_dir, *eiffel_dir;

	current_dir = (char *) getcwd(NULL, PATH_MAX);
	chdir(eif_access(c_code_dir));

	eiffel_dir = (char *) eif_getenv("EIFFEL4");
	cmd = malloc (45 + strlen (eiffel_dir));
	if (cmd == (char *)0)
		enomem();
	sprintf (cmd, "%s\\bench\\spec\\", eiffel_dir);
	strcat (cmd, eif_getenv("PLATFORM"));
	strcat (cmd, "\\bin\\finish_freezing.exe");

	memset (&siStartInfo, 0, sizeof(STARTUPINFO));
	siStartInfo.cb = sizeof(STARTUPINFO);
	siStartInfo.lpTitle = NULL;
	siStartInfo.lpReserved = NULL;
	siStartInfo.lpReserved2 = NULL;
	siStartInfo.cbReserved2 = 0;
	siStartInfo.lpDesktop = NULL;
	siStartInfo.dwFlags = 0;
	siStartInfo.hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
	siStartInfo.hStdInput =  GetStdHandle (STD_INPUT_HANDLE);
	siStartInfo.hStdError = GetStdHandle (STD_ERROR_HANDLE);

	if (CreateProcess (
			cmd,					/* Command 	*/
			NULL,					/* Command line */
			NULL,					/* Process security attribute */
			NULL,					/* Primary thread security attributes */
			TRUE,					/* Handles are inherited */
			CREATE_NEW_CONSOLE,		/* Creation flags */
			NULL,					/* Use parent's environment */
			eif_access(c_code_dir),	/* Use cmd's current directory */
			&siStartInfo,			/* STARTUPINFO pointer */
			&procinfo))				/* for PROCESS_INFORMATION */
			{
		CloseHandle (procinfo.hProcess);
		CloseHandle (procinfo.hThread);
	}
	free(cmd);

	chdir(current_dir);
	free(current_dir);

#elif defined EIF_OS2

	char *cmd, *current_dir, *eiffel_dir;
	UCHAR		LoadError[CCHMAXPATH] = {0};
	PSZ 		Args			 = NULL;
	PSZ 		Envs			 = NULL;
	RESULTCODES ChildRC 		 = {0};
	APIRET		rc				 = NO_ERROR;

	current_dir = getcwd(NULL, PATH_MAX);
	chdir(eif_access(c_code_dir));

	eiffel_dir = (char *) eif_getenv("EIFFEL4");
	cmd = malloc (45 + strlen (eiffel_dir));
	if (cmd == (char *)0)
		enomem();
	sprintf (cmd, "%s\\bench\\spec\\", eiffel_dir);
	strcat (cmd, eif_getenv("PLATFORM"));
    strcat (cmd, "\\bin\\finish_freezing.exe");
    rc = DosExecPgm(LoadError,           /* Object name buffer           */
                    sizeof(LoadError),   /* Length of object name buffer */
					EXEC_ASYNC, 		  /* Asynchronous/Trace flags	  */
                    Args,                /* Argument string              */
                    Envs,                /* Environment string           */
                    &ChildRC,            /* Termination codes            */
					cmd);				 /* Program file name			 */
	free (cmd);
	chdir(current_dir);
    free(current_dir);

#else
	char *current_dir;

#ifndef EIF_VMS
	char *cmd;
	DIR *dirp;
		/* First copy `finish_freezing' if it does not exist */
	dirp = (DIR *)dir_open(eif_access(c_code_dir));

	if ((char *)dir_search(dirp, "finish_freezing") == (char *)0){

				/* Actual copy */
			cmd = malloc(15 + strlen(eif_access(c_code_dir)) + strlen(eif_access(freeze_cmd_name)));
			if (cmd == (char *)0)
				enomem();

			sprintf(cmd, "cp %s %s", eif_access(freeze_cmd_name), eif_access(c_code_dir));

			(void) eif_system(cmd);
			free(cmd);
		}
	(void) closedir(dirp);
#endif /* not EIF_VMS */

		/* Go to the C code directory and start finish_freezing */
	current_dir = getcwd(NULL, PATH_MAX);
	chdir(eif_access(c_code_dir));
	(void) eif_system("finish_freezing");
	chdir(current_dir);
	free(current_dir);
#endif
}

void eif_gr_call_finish_freezing(EIF_OBJ request, EIF_OBJ c_code_dir, EIF_OBJ freeze_cmd_name)
{
#if defined EIF_WIN32 || defined EIF_OS2
	eif_call_finish_freezing(c_code_dir, freeze_cmd_name);
#else
	DIR *dirp;
	char *cmd;

	cmd = malloc(40 + 2*strlen(eif_access(c_code_dir)) + strlen(eif_access(freeze_cmd_name)));
	if (cmd == (char *)0)
		enomem();

#ifdef EIF_VMS	/* skip cd, cp commands for VMS */
	strcpy(cmd, "finish_freezing");
#else
		/* First copy `finish_freezing' if it does not exist */
	dirp = (DIR *)dir_open(eif_access(c_code_dir));

	if ((char *)dir_search(dirp, "finish_freezing") == (char *)0){
			/* Actual copy */
		sprintf(cmd, "cp %s %s; ", eif_access(freeze_cmd_name), eif_access(c_code_dir));
		} else {
			cmd[0] = '\0';	/* NULL terminated string */
		}

	(void) closedir (dirp);

		/* Go to the C code directory and start finish_freezing */
	sprintf(cmd, "%scd %s; finish_freezing", cmd, eif_access(c_code_dir));
#endif /* not VMS */

	(*set_proc)(eif_access(request), RTMS (cmd));
	(*send_proc)(eif_access(request));

	free(cmd);
#endif
}


void eif_link_driver (EIF_OBJ c_code_dir, EIF_OBJ system_name, EIF_OBJ prelink_command_name, EIF_OBJ driver_name)
{
#if defined EIF_WIN32 || defined EIF_OS2
	char *src, *eiffel_dir, *system_exe;
	FILE *fi, *fo;
	char buffer[4096];
	char *start_dir;
	size_t amount;

		/* Given abc\EIFGEN\W_code */
		/* The starting directory is abc or abc\EIFGEN\W_code - 14 characters */
	start_dir = malloc (strlen(eif_access(c_code_dir)));
	strncpy (start_dir, eif_access(c_code_dir), strlen(eif_access(c_code_dir))-14);

		/* Link */

	eiffel_dir = (char *) eif_getenv("EIFFEL4");
	src = malloc(strlen(eif_access(driver_name))+1);
	if (src == (char *)0)
		enomem();
	strcpy (src, eif_access (driver_name));
	fi = fopen (src, "rb");
	system_exe = malloc (strlen (eif_access (system_name)) + strlen (eif_access (c_code_dir)) + 5);
	sprintf (system_exe, "%s\\%s.EXE", eif_access (c_code_dir), eif_access (system_name));
	fo = fopen (system_exe, "wb");

	amount = 4096;
	while (amount == 4096) {
		amount = fread (buffer, sizeof(char), amount, fi);
		if (amount != fwrite (buffer, sizeof(char), amount, fo))
			eio();
	}

	fclose (fi);
	fclose (fo);
	free (src);
	free (start_dir);
	free (system_exe);

#elif defined EIF_VMS
	char *cmd = eif_access(prelink_command_name);
	size_t len;
	len = 40 + strlen(eif_access(driver_name)) + strlen(eif_access(c_code_dir)) + strlen(eif_access(system_name));
	cmd = malloc(len);
	if (cmd == (char *)0)
		enomem();

	sprintf (cmd, "COPY %s %s%s", eif_access(driver_name), eif_access(c_code_dir), eif_access(system_name));
	assert (strlen(cmd) < len);
	printf ("$ %s\n",cmd);
	(void) eif_system (cmd);
	free(cmd);

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

void eif_gr_link_driver (EIF_OBJ request, EIF_OBJ c_code_dir, EIF_OBJ system_name, EIF_OBJ prelink_command_name, EIF_OBJ driver_name)
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

/* Platform definition */

EIF_BOOLEAN eif_is_os2(void)
{
#ifdef EIF_OS2
	return EIF_TRUE;
#else
	return EIF_FALSE;
#endif
}

EIF_BOOLEAN eif_is_vms (void)
{
#ifdef EIF_VMS
	return EIF_TRUE;
#else
	return EIF_FALSE;
#endif
}

EIF_BOOLEAN eif_is_windows(void)
{
#ifdef EIF_WINDOWS
	return EIF_TRUE;
#else
	return EIF_FALSE;
#endif
}

EIF_REFERENCE eif_date_string (EIF_INTEGER a_date)
{
	EIF_REFERENCE result;
#ifdef EIF_VMS
	char *date_string = ctime((time_t*)&a_date);
#else
	char *date_string = ctime(&a_date);
#endif

	result = RTMS(date_string);
	/* free (date_string); FIXME - check with xavier */
	return (EIF_REFERENCE) result;
}

#ifdef EIF_WIN32

/* C routines for the communications of bench */

extern STREAM *sp;

typedef void (* EVENT_CALLBACK)(EIF_OBJ);
EVENT_CALLBACK event_callback;
EIF_OBJ event_object;
EIF_INTEGER delay;
UINT event_id;

void CALLBACK ioh_timer(HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime);

void win_ioh_make_client(EIF_POINTER a, EIF_OBJ o, EIF_INTEGER a_delay)
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
