/*
	Commands used by the compiler to link the precompilation driver or
	to execute `finish_freezing'
*/

#include "config.h"
#include "portable.h"

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>

#include "dir.h"
#include "file.h"	/* for PATH_MAX */

private fnptr set_proc;
private fnptr send_proc;

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
#ifdef __WATCOMC__
	char *cmd, *current_dir, *eiffel_dir;

	current_dir = getcwd(NULL, PATH_MAX);
	chdir(eif_access(c_code_dir));

	eiffel_dir = (char *) eif_getenv("EIFFEL3");
	cmd = cmalloc (40 + strlen (eiffel_dir),1);
	if (cmd == (char *)0)
		enomem();
	sprintf (cmd, "%s\\bench\\spec\\", eiffel_dir);
	strcat (cmd, eif_getenv("PLATFORM"));
	strcat (cmd, "\\bin\\es3sh.exe");

	(void) WinExec(cmd, SW_SHOWNORMAL);
	xfree(cmd);

	chdir(current_dir);
	xfree(current_dir);
#else
	DIR *dirp;
	char *cmd, *current_dir;

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
#ifdef __WATCOMC__
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
		sprintf(cmd, "cp %s %s", eif_access(freeze_cmd_name), eif_access(c_code_dir));
		} else {
			cmd[0] = '\0';	/* NULL terminated string */
		}

	(void) closedir (dirp);

		/* Go to the C code directory and start finish_freezing */
	sprintf(cmd, "%s; cd %s; finish_freezing", cmd, eif_access(c_code_dir));

	(*set_proc)(eif_access(request), RTMS (cmd));
	(*send_proc)(eif_access(request));

	xfree(cmd);
#endif
}



void eif_link_driver (c_code_dir, system_name, prelink_command_name, driver_name)
EIF_OBJ c_code_dir, system_name, prelink_command_name, driver_name;
{
#ifdef __WATCOMC__
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

#else
	char *cmd;

	cmd = cmalloc(15 + strlen(eif_access(c_code_dir)) + strlen(eif_access(system_name)) +
					strlen(eif_access(prelink_command_name)) + strlen(eif_access(driver_name)));
	if (cmd == (char *)0)
		enomem();

	sprintf(cmd, "%s %s %s/%s", eif_access(prelink_command_name), eif_access(driver_name), eif_access(c_code_dir), eif_access(system_name));

	(void) eif_system(cmd);
	xfree(cmd);
#endif
}

void eif_gr_link_driver (request, c_code_dir, system_name, prelink_command_name, driver_name)
EIF_OBJ request;
EIF_OBJ c_code_dir, system_name, prelink_command_name, driver_name;
{
#ifdef __WATCOMC__
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

