/*
	description: "[
			Environment processing functions. We first try to look up in the environment
			variable table, then in the HKLM\Software\ISE\EiffelXX\app and if not found then in
			HKCU\Software\ISE\EiffelXX\app when app is the name of the started application.
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

#ifdef EIF_WINDOWS

#include "eif_file.h"
#include "rt_assert.h"

char *win_eif_getenv (char *k, char *app)
/*
	get the key `k' for application `app'.
	If app is not set use the modulename of the executing module.
*/
{
	char *result = getenv (k);

	if (result)
		return result;
	else {
		char *key, *lower_k;
		static unsigned char buf[1024];
		size_t appl_len, key_len;
		char modulename [PATH_MAX + 1];
		HKEY hkey;
		DWORD bsize;

		GetModuleFileName (NULL, modulename, PATH_MAX);

		if (app == NULL)
			appl_len = strrchr (modulename, '.') - strrchr (modulename, '\\') -1;
		else
			appl_len = strlen (app);
		key_len = strlen (k);
		if ((key = (char *) calloc (appl_len + 57 + key_len, 1)) == NULL)
			return result;

		if ((lower_k = (char *) calloc (key_len+1, 1)) == NULL) {
			free (key);
			return result;
		}

		strcpy (lower_k, k);
		CHECK ("Valid length", key_len <= INT32_MAX);
		CharLowerBuff (lower_k, (DWORD) key_len);

		strcpy (key, "Software\\ISE\\Eiffel_21.06\\");
		if (app == NULL)
			strncat (key, strrchr(modulename, '\\')+1, appl_len);
		else
			strcat (key, app);

		bsize = 1024;
		if (RegOpenKeyEx (HKEY_CURRENT_USER, key, 0, KEY_READ, &hkey) != ERROR_SUCCESS) {
			if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, key, 0, KEY_READ, &hkey) != ERROR_SUCCESS) {
				free (key);
				free (lower_k);
				return result;
			}
			if (RegQueryValueEx (hkey, lower_k, NULL, NULL, buf, &bsize) != ERROR_SUCCESS) {
				free (key);
				free (lower_k);
				RegCloseKey (hkey);
				return result;
			}
		} else {
			if (RegQueryValueEx (hkey, lower_k, NULL, NULL, buf, &bsize) != ERROR_SUCCESS) {
					/* Could not read from HKCU entry, so let's close it before opening
					 * the one possibly in HKLM */
				RegCloseKey (hkey);
				if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, key, 0, KEY_READ, &hkey) != ERROR_SUCCESS) {
					free (key);
					free (lower_k);
					return result;
				}
				if (RegQueryValueEx (hkey, lower_k, NULL, NULL, buf, &bsize) != ERROR_SUCCESS) {
					free (key);
					free (lower_k);
					RegCloseKey (hkey);
					return result;
				}
			}
		}

		free (key);
		free (lower_k);
		RegCloseKey (hkey);
		return (char *) buf;
	}
}

#endif
