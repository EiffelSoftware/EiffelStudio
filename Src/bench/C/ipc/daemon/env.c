/*
	ENV.C - environment processing functions.
		This accesses the registry in key

		HKEY_LOCAL_MACHINE\Software\ISE\Eiffel\app

		where app is the name of the started application.

		This is standard Windows registry access.
*/

#include "eif_config.h"
#include "eif_file.h"

char *win_eif_getenv (char *k, char *app)
/*
	get the key `k' for application `app'.
	If app is not set use the modulename of the executing module.
*/
{
	char *key, *lower_k;
	static char buf[1024];
	int appl_len, key_len;
	char modulename [PATH_MAX + 1];
	HKEY hkey;
	DWORD bsize;

	GetModuleFileName (NULL, modulename, PATH_MAX);

	if (app == NULL)
		appl_len = strrchr (modulename, '.') - strrchr (modulename, '\\') -1;
	else
		appl_len = strlen (app);
	key_len = strlen (k);
	if ((key = (char *) calloc (appl_len + 57+key_len, 1)) == NULL)
		return getenv (k);

	if ((lower_k = (char *) calloc (key_len+1, 1)) == NULL) {
		free (key);
		return getenv (k);
	}

	strcpy (lower_k, k);
	CharLowerBuff (lower_k, key_len);

	strcpy (key, "Software\\ISE\\Eiffel45\\");
	if (app == NULL)
		strncat (key, strrchr(modulename, '\\')+1, appl_len);
	else
		strcat (key, app);

	if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, key, 0, KEY_READ, &hkey) != ERROR_SUCCESS) {
		free (key);
		free (lower_k);
		return getenv (k);
	}

	bsize = 1024;
	if (RegQueryValueEx (hkey, lower_k, NULL, NULL, buf, &bsize) != ERROR_SUCCESS) {
		free (key);
		free (lower_k);
		RegCloseKey (hkey);
		return getenv (k);
	}

	free (key);
	free (lower_k);
	RegCloseKey (hkey);
	return (char *) buf;
}
