
/*
	Commands used by the compiler to link the precompilation driver or
	to execute `finish_freezing'
*/

#include "config.h"
#include "portable.h"

#include <sys/types.h>
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

	eiffel_dir = eif_getenv("EIFFEL3");

	cmd = cmalloc (40 + strlen (eiffel_dir));
	if (cmd == (char *)0)
		enomem();

	sprintf (cmd, "%s\\bench\\spec\\winwat\\bin\\es3sh.exe", eiffel_dir);

	(void) eif_system(cmd);
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
	eif_call_finish_freezing(c_code_dir, freeze_cmd_name)
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



void eif_link_driver (c_code_dir, systeme_name, prelink_command_name, driver_name)
EIF_OBJ c_code_dir, systeme_name, prelink_command_name, driver_name;
{
#ifdef __WATCOMC__
	char *ini_path, *cmd, *eiffel_dir;
	FILE *ini_file;

		/* First create the .INI file */
	ini_path = cmalloc(strlen(eif_access(c_code_dir))+strlen(eif_access(systeme_name))+10);
	if (ini_path == (char *)0)
		enomem();

	sprintf(ini_path, "%s/%s.INI", eif_access(c_code_dir), eif_access(systeme_name));

	ini_file = fopen(ini_path, "w");
	fprintf(ini_file, "[Environment]\nDriver=%s\n", eif_access(driver_name));
	fclose(ini_file);

	xfree(ini_path);

		/* Link */
	eiffel_dir = eif_getenv("EIFFEL3");

	cmd = cmalloc(40 + strlen(eiffel_dir) + strlen(eif_access(driver_name)));
	if (cmd == (char *)0)
		enomem();

	sprintf(cmd, "command.com /c copy %s\\bench\\spec\\winwat\\bin\\precompd.exe %s", eiffel_dir, eif_access(driver_name));

	(void) eif_system(cmd);
	xfree(cmd);
#else
	char *cmd;

	cmd = cmalloc(15 + strlen(eif_access(c_code_dir)) + strlen(eif_access(systeme_name)) +
					strlen(eif_access(prelink_command_name)) + strlen(eif_access(driver_name)));
	if (cmd == (char *)0)
		enomem();

	sprintf(cmd, "%s %s %s/%s", eif_access(prelink_command_name), eif_access(driver_name), eif_access(c_code_dir), eif_access(systeme_name));

	(void) eif_system(cmd);
	xfree(cmd);
#endif
}

void eif_gr_link_driver (request, c_code_dir, systeme_name, prelink_command_name, driver_name)
EIF_OBJ request;
EIF_OBJ c_code_dir, systeme_name, prelink_command_name, driver_name;
{
#ifdef __WATCOMC__
	eif_link_driver(c_code_dir, systeme_name, prelink_command_name, driver_name);
#else
	char *cmd;

	cmd = cmalloc(15 + strlen(eif_access(c_code_dir)) + strlen (eif_access(systeme_name)) +
					strlen(eif_access(prelink_command_name)) + strlen(eif_access(driver_name)));
	if (cmd == (char *)0)
		enomem();

	sprintf(cmd, "%s %s %s/%s", eif_access(prelink_command_name), eif_access(driver_name), eif_access(c_code_dir), eif_access(systeme_name));

	(*set_proc)(eif_access(request), RTMS (cmd));
	(*send_proc)(eif_access(request));

	xfree(cmd);
#endif
}

