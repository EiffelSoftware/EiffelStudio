    #include <windows.h>
    #include <stdio.h>

    int main (int argc, char *argv[])
    {
        BOOL                bRet = FALSE;
        STARTUPINFO         si   = {0};
        PROCESS_INFORMATION pi   = {0};
		int					result;

        // Make child process use this app's standard files.
        si.cb = sizeof(si);
        si.dwFlags    = STARTF_USESTDHANDLES;
        si.hStdInput  = GetStdHandle (STD_INPUT_HANDLE);
        si.hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
        si.hStdError  = GetStdHandle (STD_ERROR_HANDLE);

        if (argc == 1)
			return 1;

		bRet = CreateProcess (NULL, argv[1],
                        NULL, NULL,
                        TRUE, 0,
                        NULL, NULL,
                        &si, &pi
                        );
        if (bRet)
        {
            WaitForSingleObject (pi.hProcess, INFINITE);
			GetExitCodeProcess (pi.hProcess, &result);
            CloseHandle (pi.hProcess);
            CloseHandle (pi.hThread);
			return result;
        }
		else
			return 1;
    }
