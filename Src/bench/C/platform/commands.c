/*
	Commands used by the compiler to link the precompilation driver,
	to execute `finish_freezing' and other platform dependent actions.
*/

#include "config.h"
#include "portable.h"

#include <sys/types.h>
#include <time.h>
#include <sys/stat.h>

#if defined EIF_WINDOWS || defined EIF_OS2
#else
#include <unistd.h>
#endif

#include <stdlib.h>
#include <stdio.h>

#include "dir.h"
#include "file.h"	/* for PATH_MAX */

#ifdef EIF_WINDOWS
#define WIN32
#include <windows.h>
#include "..\extra\win32\ipc\shared\stream.h"
#endif

#ifdef EIF_OS2
#define INCL_DOSPROCESS		/* Constants used for calls to DosExecPgm() */
#define INCL_DOS
#define INCL_DOSERRORS
#include <os2.h>
#endif

rt_private fnptr set_proc;
rt_private fnptr send_proc;

extern EIF_INTEGER eif_system();

#ifdef EIF_WIN32
HANDLE eif_coninfile, eif_conoutfile;
extern char *eif_getenv (char *);
#endif

#ifdef EIF_OS2
extern char *eif_getenv (char *);
#endif

void async_shell_pass_address(send_address, set_address)
fnptr send_address, set_address;
{
		/* Rescord the `set_command_name' and `send' function pointers */
	set_proc = set_address;
	send_proc = send_address;
}

void eif_call_finish_freezing(c_code_dir, freeze_cmd_name)
EIF_OBJ c_code_dir, freeze_cmd_name;
{
#ifdef EIF_WINDOWS
#ifdef EIF_WIN32
	STARTUPINFO				siStartInfo;
	PROCESS_INFORMATION		procinfo;
	char					buf[1000];
#endif

	char *cmd, *current_dir, *eiffel_dir;

	current_dir = (char *) getcwd(NULL, PATH_MAX);
	chdir(eif_access(c_code_dir));

	eiffel_dir = (char *) eif_getenv("EIFFEL3");
	cmd = cmalloc (45 + strlen (eiffel_dir));
	if (cmd == (char *)0)
		enomem();
	sprintf (cmd, "%s\\bench\\spec\\", eiffel_dir);
	strcat (cmd, eif_getenv("PLATFORM"));
	strcat (cmd, "\\bin\\es3sh.exe");

#ifdef EIF_WIN32
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

	if (CreateProcess (cmd, NULL, NULL, NULL, TRUE, CREATE_NEW_CONSOLE, NULL, eif_access(c_code_dir), &siStartInfo, &procinfo))
		{
		CloseHandle (procinfo.hProcess);
		CloseHandle (procinfo.hThread);
		}
#else
	(void) WinExec(cmd, SW_SHOWNORMAL);
#endif
	xfree(cmd);

	chdir(current_dir);
	xfree(current_dir);
#elif defined EIF_OS2

	char *cmd, *current_dir, *eiffel_dir;
	UCHAR		LoadError[CCHMAXPATH] = {0};
	PSZ 		Args			 = NULL;
	PSZ 		Envs			 = NULL;
	RESULTCODES ChildRC 		 = {0};
	APIRET		rc				 = NO_ERROR;

	current_dir = getcwd(NULL, PATH_MAX);
	chdir(eif_access(c_code_dir));

	eiffel_dir = (char *) eif_getenv("EIFFEL3");
	cmd = cmalloc (45 + strlen (eiffel_dir));
	if (cmd == (char *)0)
		enomem();
	sprintf (cmd, "%s\\bench\\spec\\", eiffel_dir);
	strcat (cmd, eif_getenv("PLATFORM"));
    strcat (cmd, "\\bin\\es3sh.exe");
    rc = DosExecPgm(LoadError,           /* Object name buffer           */
                    sizeof(LoadError),   /* Length of object name buffer */
					EXEC_ASYNC, 		  /* Asynchronous/Trace flags	  */
                    Args,                /* Argument string              */
                    Envs,                /* Environment string           */
                    &ChildRC,            /* Termination codes            */
					cmd);				 /* Program file name			 */
	xfree (cmd);
	chdir(current_dir);
    xfree(current_dir);

#else
	DIR *dirp;
	char *cmd, *current_dir;

#ifndef __VMS
		/* First copy `finish_freezing' if it does not exist */
	dirp = (DIR *)dir_open(eif_access(c_code_dir));

	if ((char *)dir_search(dirp, "finish_freezing") == (char *)0){

				/* Actual copy */
			cmd = cmalloc(15 + strlen(eif_access(c_code_dir)) + strlen(eif_access(freeze_cmd_name)));
			if (cmd == (char *)0)
				enomem();

			sprintf(cmd, "cp %s %s", eif_access(freeze_cmd_name), eif_access(c_code_dir));

			(void) eif_system(cmd);
			xfree(cmd);
		}
	(void) closedir(dirp);

#endif
		/* Go to the C code directory and start finish_freezing */
	current_dir = getcwd(NULL, PATH_MAX);
	chdir(eif_access(c_code_dir));
	(void) eif_system("finish_freezing");
	chdir(current_dir);
	xfree(current_dir);
#endif
}

void eif_gr_call_finish_freezing(request, c_code_dir, freeze_cmd_name)
EIF_OBJ request, c_code_dir, freeze_cmd_name;
{
#if defined EIF_WINDOWS || __VMS || defined EIF_OS2
	eif_call_finish_freezing(c_code_dir, freeze_cmd_name);
#else
	DIR *dirp;
	char *cmd;

	cmd = cmalloc(40 + 2*strlen(eif_access(c_code_dir)) + strlen(eif_access(freeze_cmd_name)));
	if (cmd == (char *)0)
		enomem();

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

	(*set_proc)(eif_access(request), RTMS (cmd));
	(*send_proc)(eif_access(request));

	xfree(cmd);
#endif
}



void eif_link_driver (c_code_dir, system_name, prelink_command_name, driver_name)
EIF_OBJ c_code_dir, system_name, prelink_command_name, driver_name;
{
#if defined EIF_WIN32 || defined EIF_OS2
	char *src, *eiffel_dir, *eiffel_plt, *system_exe;
	FILE *fi, *fo;
	char buffer[4096];
	char *start_dir, *i;
	int amount;

		/* Given abc\EIFGEN\W_code */
		/* The starting directory is abc or abc\EIFGEN\W_code - 14 characters */
	start_dir = cmalloc (strlen(eif_access(c_code_dir)),1);
	strncpy (start_dir, eif_access(c_code_dir), strlen(eif_access(c_code_dir))-14);

		/* Link */

	eiffel_dir = (char *) eif_getenv("EIFFEL3");
	src = cmalloc(strlen(eif_access(driver_name))+1);
	if (src == (char *)0)
		enomem();
	strcpy (src, eif_access (driver_name));
	fi = fopen (src, "rb");
	system_exe = cmalloc (strlen (eif_access (system_name)) +
							strlen (eif_access (c_code_dir)) + 5);
	sprintf (system_exe, "%s\\%s.EXE", eif_access (c_code_dir), eif_access (system_name));
	fo = fopen (system_exe, "wb");

	amount = 4096;
	while (amount == 4096)
		{
		amount = fread (buffer, sizeof(char), amount, fi);
		if (amount != fwrite (buffer, sizeof(char), amount, fo))
			eio();
		}

	fclose (fi);
	fclose (fo);
	xfree (src);
	xfree (system_exe);
#else
#ifdef EIF_WINDOWS
	char *ini_path, *src, *eiffel_dir, *eiffel_plt, *system_exe;
	FILE *ini_file, *fi, *fo;
	char buffer[4096];
	char *start_dir, *i;
	int amount;

		/* First create the .INI file */
	ini_path = cmalloc(strlen(eif_access(c_code_dir))+strlen(eif_access(system_name))+10);
	if (ini_path == (char *)0)
		enomem();

	// Given abc\EIFGEN\W_code
	// The starting directory is abc or abc\EIFGEN\W_code - 14 characters
	start_dir = cmalloc (strlen(eif_access(c_code_dir)),1);
	strncpy (start_dir, eif_access(c_code_dir), strlen(eif_access(c_code_dir))-14);

	sprintf(ini_path, "%s\\%s.INI", eif_access(c_code_dir), eif_access(system_name));

	ini_file = fopen(ini_path, "wt");
	fprintf(ini_file, "[Environment]\nDriver=%s\nStartDirectory=%s\n", 
			eif_access(driver_name), start_dir);
	fclose(ini_file);

	xfree(ini_path);

		/* Link */

	eiffel_dir = (char *) eif_getenv("EIFFEL3");
	src = cmalloc(38 + strlen (eiffel_dir));
	if (src == (char *)0)
		enomem();
	strcpy (src, eiffel_dir);
	strcat (src, "\\bench\\spec\\");
	eiffel_plt = (char *) eif_getenv("PLATFORM");
	strcat (src, eiffel_plt);
	strcat (src, "\\bin\\precompd.exe");
	fi = fopen (src, "rb");
	system_exe = cmalloc (strlen (eif_access (system_name)) + 
						  strlen (eif_access (c_code_dir)) + 5);
	if (strlen (eif_access (system_name)) > 8)
		{
		printf ("The system is called: %s\n", eif_access (system_name));
		printf ("The system name should not be more than 8 characters\n");
		}
	sprintf (system_exe, "%s\\%s.EXE", eif_access (c_code_dir), eif_access (system_name));
	fo = fopen (system_exe, "wb");

	amount = 4096;
	while (amount == 4096) 
		{
		amount = fread (buffer, sizeof(char), amount, fi);
		if (amount != fwrite (buffer, sizeof(char), amount, fo))
			eio();
		}

	fclose (fi);
	fclose (fo);
	xfree (src);
	xfree (system_exe);

#elif defined __VMS
	char *cmd;

	cmd = cmalloc(15 + strlen(eif_access(driver_name)) + 
		 strlen(eif_access(c_code_dir)),
		 strlen(eif_access(system_name)) );
	if (cmd == (char *)0)
		enomem();

	sprintf(cmd, "COPY %s %s%s", eif_access(driver_name),
		 eif_access(c_code_dir), eif_access(system_name));
	printf("%s\n",cmd);
	(void) eif_system(cmd);
	xfree(cmd);

#else
	char *cmd;

	cmd = cmalloc(15 + strlen(eif_access(c_code_dir)) + strlen(eif_access(system_name)) +
					strlen(eif_access(prelink_command_name)) + strlen(eif_access(driver_name)));
	if (cmd == (char *)0)
		enomem();

	sprintf(cmd, "%s %s %s/%s", eif_access(prelink_command_name),
		 eif_access(driver_name), eif_access(c_code_dir),
		 eif_access(system_name));

	(void) eif_system(cmd);
	xfree(cmd);
#endif
#endif
}

void eif_gr_link_driver (request, c_code_dir, system_name, prelink_command_name, driver_name)
EIF_OBJ request;
EIF_OBJ c_code_dir, system_name, prelink_command_name, driver_name;
{
#if defined EIF_WINDOWS || __VMS || defined EIF_OS2
	eif_link_driver(c_code_dir, system_name, prelink_command_name, driver_name);
#else
	char *cmd;

	cmd = cmalloc(15 + strlen(eif_access(c_code_dir)) + strlen (eif_access(system_name)) +
					strlen(eif_access(prelink_command_name)) + strlen(eif_access(driver_name)));
	if (cmd == (char *)0)
		enomem();

	sprintf(cmd, "%s %s %s/%s", eif_access(prelink_command_name), eif_access(driver_name), eif_access(c_code_dir), eif_access(system_name));

	(*set_proc)(eif_access(request), RTMS (cmd));
	(*send_proc)(eif_access(request));

	xfree(cmd);
#endif
}

/* Platform definition */

EIF_BOOLEAN eif_is_os2()
{
#ifdef EIF_OS2
	return EIF_TRUE;
#else
	return EIF_FALSE;
#endif
}

EIF_BOOLEAN eif_is_vms()
{
#ifdef __VMS
	return EIF_TRUE;
#else
	return EIF_FALSE;
#endif
}

EIF_BOOLEAN eif_is_windows()
{
#ifdef EIF_WINDOWS
	return EIF_TRUE;
#else
	return EIF_FALSE;
#endif
}

EIF_BOOLEAN eif_is_win32()
{
#ifdef EIF_WIN32
	return EIF_TRUE;
#else
	return EIF_FALSE;
#endif
}

EIF_BOOLEAN eif_is_windows_3_1()
{
#ifdef EIF_WIN_31
	return EIF_TRUE;
#else
	return EIF_FALSE;
#endif
}

EIF_REFERENCE eif_date_string (a_date)
EIF_INTEGER a_date;
{
	EIF_REFERENCE result;
	char *date_string = ctime(&a_date);

	result = RTMS(date_string);
	free (date_string);
	return (EIF_REFERENCE) result;
}

#ifdef EIF_WIN32

/* C routines for the communications of bench */

extern STREAM *sp;

typedef void (* EVENT_CALLBACK)(EIF_OBJ);
EVENT_CALLBACK event_callback;
EIF_OBJ event_object;

VOID CALLBACK ioh_timer(HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime);

void win_ioh_make_client(a, o)
EIF_POINTER a;
EIF_OBJ     o;
{
	FILE *a_file;
	a_file = fopen ("comm.log", "wb");
	fwrite ("IO created\n", 1, strlen ("IO created\n"), a_file);
	fclose (a_file);

	event_callback = (EVENT_CALLBACK) a;
	event_object = eif_adopt (o);
	SetTimer (NULL, 0, 100, (TIMERPROC) ioh_timer);
}

VOID CALLBACK ioh_timer(HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime)
{
	FILE *a_file;
	a_file = fopen ("comm.log", "wb");
	fwrite ("Timer callback\n", 1, strlen ("Timer callback\n"), a_file);
	fclose (a_file);

	/* KillTimer */
	if (WaitForSingleObject (readev(sp), 0) == WAIT_OBJECT_0)
		(event_callback)(eif_access(event_object));
	/* SetTimer */
}

#endif
