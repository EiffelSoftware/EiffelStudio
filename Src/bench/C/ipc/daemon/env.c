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
		return (char *) 0;

	if ((lower_k = (char *) calloc (key_len+1, 1)) == NULL) {
		free (key);
		return (char *) 0;
	}

	strcpy (lower_k, k);
	CharLowerBuff (lower_k, key_len);

	strcpy (key, "Software\\ISE\\Eiffel44\\");
	if (app == NULL)
		strncat (key, strrchr(modulename, '\\')+1, appl_len);
	else
		strcat (key, app);

	if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, key, 0, KEY_READ, &hkey) != ERROR_SUCCESS) {
		free (key);
		free (lower_k);
		return (char *) 0;
	}

	bsize = 1024;
	if (RegQueryValueEx (hkey, lower_k, NULL, NULL, buf, &bsize) != ERROR_SUCCESS) {
		free (key);
		free (lower_k);
		RegCloseKey (hkey);
		return (char *) 0;
	}

	free (key);
	free (lower_k);
	RegCloseKey (hkey);
	return (char *) buf;
}

int win_eif_putenv ( char *v, char *k,  char *app)
/*
	set the key `k' for application `app' to value `v'

	If app is not set use the modulename of the executing module.
*/
{
	/* We need a copy of the string because the string will be
		referenced in the environment and the eiffel string can
		be garbage collected ...
 	*/

	char *key, *lower_k;
	char modulename [PATH_MAX + 1];
	int appl_len, key_len;
	extern char **_argv;
	HKEY hkey;
	DWORD disp;

	GetModuleFileName (NULL, modulename, PATH_MAX);

	if (app == NULL)
		appl_len = strrchr (modulename, '.') - strrchr (modulename, '\\') -1;
	else
		appl_len = strlen (app);
	key_len = strlen (k);
	if ((key = (char *) calloc (appl_len + 57+key_len, 1)) == NULL)
		return -1;

	if ((lower_k = (char *) calloc (key_len+1, 1)) == NULL) {
		free (key);
		return -1;
	}

	strcpy (lower_k, k);
	CharLowerBuff (lower_k, key_len);

	strcpy (key, "Software\\ISE\\Eiffel44\\");
	if (app == NULL)
		strncat (key, strrchr(modulename, '\\')+1, appl_len);
	else
		strcat (key, app);

	if (RegCreateKeyEx (HKEY_LOCAL_MACHINE, key, 0, "REG_SZ", REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, NULL, &hkey, &disp) != ERROR_SUCCESS) {
		free (key);
		free (lower_k);
		return -1;
	}
	if (RegSetValueEx (hkey, lower_k, 0, REG_SZ, k, strlen(k)+1) != ERROR_SUCCESS) {
		free (key);
		free (lower_k);
		RegCloseKey (hkey);
		return -1;
	}

	free (key);
	free (lower_k);
	RegFlushKey (hkey);
	RegCloseKey (hkey);
	return 0;
}
