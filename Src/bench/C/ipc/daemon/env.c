/*
	ENV.C - environment processing functions.
		This accesses the registry in key

		HKEY_LOCAL_MACHINE\Software\ISE\Eiffel\app

		where app is the name of the started application.

		This is standard Windows registry access.
*/

#include "eif_config.h"
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
	
		strcpy (key, "Software\\ISE\\Eiffel57\\");
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
