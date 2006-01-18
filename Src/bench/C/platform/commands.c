/*
	description: "[
			Commands used by the compiler to link the precompilation driver,
			to execute `finish_freezing' and other platform dependent actions.
			]"
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
#include "rt_error.h"
#include "eif_path_name.h"  /* for eifrt_vms_filespec() */
#include "eif_commands.h"

#ifdef EIF_WINDOWS
#include <windows.h>
#include "..\ipc\shared\stream.h"
#endif

#ifdef EIF_VMS
#include <assert.h>
#endif

rt_private fnptr set_proc;
rt_private fnptr send_proc;

extern EIF_INTEGER eif_system(char *);

#ifdef EIF_WINDOWS
extern char *eif_getenv (char *);
#endif

void eif_beep (void)
{
#ifdef EIF_WINDOWS
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
#if defined EIF_WINDOWS || defined EIF_OS2
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
#if defined EIF_WINDOWS || defined EIF_OS2 || defined EIF_VMS
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
