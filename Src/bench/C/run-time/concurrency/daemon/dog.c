
#include "dog.h"

#define tDIR_GOOD


char loc[100];
int child_set_up;
int owner[MAX_DESCRIPTOR];
char **descriptor[MAX_DESCRIPTOR];
int sock;
char socket_is_not_writable = 0;
EIF_INTEGER  child;
int wait_sig_from_child = 0;
char has_got_a_chd_signal = 0;

main()
{
	int csock;
	char execfile[MAX_EXEC_FILE_LEN+1];
	char execdir[MAX_EXEC_FILE_LEN+1];

	struct sockaddr_in name,myname;
	struct hostent *hp;
	int myportnum,namelen;

	struct passwd *pwd;
	char usrname[USERNAME_LEN];
	char *userp;
	char hostname[HOSTNAME_LEN+1];
	char *hnamep, env[50];
	char message[1024];

	int current_pid = getpid();
#ifdef EIF_WIN32
	char cur_pid_str[MAX_INT_STR_LEN + 1];
	int cmdLineLen;
	BOOL fSuccess;
	LPTSTR cmdLine;
	STARTUPINFO si;
	PROCESS_INFORMATION piChild;
	WORD wVersionRequested;
	WSADATA wsaData;
	int err;
	HANDLE hCurrentProc;
#endif

	EIF_INTEGER para_num;
	EIF_INTEGER code;
	EIF_INTEGER p_type, p_len;
	EIF_INTEGER i,j, index;
	EIF_INTEGER int_val;
	EIF_REAL real_val;
	EIF_DOUBLE dou_val;
	char *int_str, *real_str, *dou_str, *str_str;



#ifndef EIF_WIN32
	signal(SIGUSR1, sig_proc);
	signal(SIGUSR2, sig_proc);
#ifdef DEAD
	signal(SIGCLD, sig_chld);
#endif
#else
	wVersionRequested = MAKEWORD (1, 1);
	err = WSAStartup(wVersionRequested, &wsaData);
	if (err != 0)
		{
		fprintf (stderr, "Communications error %d", err);
		printf("Communications error %d", err);
		}
	p_len = longtoa((long)current_pid, cur_pid_str, MAX_INT_STR_LEN);       
	cur_pid_str[p_len] = '\0';      
	hCurrentProc = GetCurrentProcess();
	fSuccess = SetPriorityClass(hCurrentProc, HIGH_PRIORITY_CLASS);
	if (!fSuccess)
		printf("Fail to change SCOOP-DOG's priority.\n");
/*
#ifdef TEST
	printf("getpid()=%d, GetCurrentProcessId()=%d sizeof(EIF_INTEGER)=%d\n", getpid(), GetCurrentProcessId(), sizeof(EIF_INTEGER));
#endif
*/
#endif

/*
	setbuf(stdout,0);
	setbuf(stderr,0);
*/
	myportnum = SCOOP_DOG_PORT;

	/* Create socket from which to receive requests */
	sock=socket(AF_INET,SOCK_STREAM,0);
#ifndef EIF_WIN32
	if (sock<0) {
#else
	if (sock == INVALID_SOCKET) {
		printf("The result of socket: %d, errno: %d, INVALID_SOCKET: %d\n", sock, errno, INVALID_SOCKET);
#endif
		perror("ERROR in Concurrent Eiffel's Dameon<opening socket>");
		exit(1);
	}
	set_block(sock);

	myname.sin_family=AF_INET;
	myname.sin_addr.s_addr=INADDR_ANY;
	myname.sin_port=htons((u_short)myportnum);
#ifndef EIF_WIN32
	if (bind(sock,(struct sockaddr *)&myname,sizeof myname)<0) {
#else
	if (bind(sock,(struct sockaddr *)&myname,sizeof myname) == SOCKET_ERROR) {
#endif
		printf("ERROR in Concurrent Eiffel's Dameon<binding to port %d>: ", myportnum);
		perror("");
		printf("\n");
		close(sock);
		exit(1);
	}

	for(index=0; index<MAX_DESCRIPTOR; descriptor[index] = NULL, index++);
#ifndef EIF_WIN32
	if (listen (sock, 5) < 0) {
#else
	if (listen (sock, 5) == SOCKET_ERROR) {
#endif
		perror("ERROR in Concurrent Eiffel's Dameon<listen>");
		close(sock);
		exit(1);
	}

	namelen = sizeof(name);
	for(; ;) {
		next_step:
#ifndef EIF_WIN32
		for (csock = -1; csock < 0; )  {
			set_block(sock);
			csock=accept(sock,(struct sockaddr *)&name,&namelen);
		}
#else
		set_block(sock);
		csock=accept(sock,(struct sockaddr *)&name,&namelen);
		if (csock == SOCKET_ERROR) {
			if (errno !=  EWOULDBLOCK)
			perror("ERROR in Concurrent Eiffel's Dameon<listen>");
			close(sock);
			exit(1);
		}
#endif
#ifdef TEST
printf("=======================================================================\n");
#endif
		set_block(csock);
		/*
		nread = read(csock, checksum, CHECKSUM_LEN);
		if (nread != CHECKSUM_LEM) {
			printf("A non-Eiffel Application tried to get service from me!\n");
			close(csock);
			continue;
		}
		*/
		/* Get a free descriptor to store parameters */
		for(index=0; index<MAX_DESCRIPTOR && descriptor[index] != NULL; index=(index+1) % MAX_DESCRIPTOR);

		if (dog_get_command(csock, &code, &para_num)) {
			csock = -4;
			descriptor[index] = NULL;
			goto next_step;
		}
#ifdef TEST
printf("Got CODE = %d, PARA_NUMBER = %d\n", (int)code, (int)para_num);
#endif
		if (code != CREATE_SEP_OBJ) {
			if (dog_send_command(csock, REPORT_ERROR, 1)) {
#ifdef EIF_WIN32
				closesocket(csock);
#else
				close(csock);
#endif
				goto next_step;
			}
			int_val = c_get_host_name(hostname, HOSTNAME_LEN); 
			sprintf(message, "Detected Error Happened Here: on host <%s> \nError Message:\n    DAEMON got an invalid request(request code: %d).", hostname, code);
			p_len  = strlen(message);
			p_type = STRING_TYPE;
			if (dog_send_data(csock, &p_type, message, &p_len)) {
#ifdef EIF_WIN32
				closesocket(csock);
#else
				close(csock);
#endif
				goto next_step;
			}
#ifdef EIF_WIN32
			closesocket(csock);
#else
			close(csock);
#endif
			goto next_step;
		}

		descriptor[index] = (char **)malloc(sizeof(char *)*(para_num+1));
		if (descriptor[index] == NULL) {
			printf("Run out of memory!\n");
			exit(1);
		}
#ifdef EIF_WIN32
		cmdLineLen = strlen(cur_pid_str) + 1;
#endif
		for(i=2; i<=para_num-2; i++) {
			if (dog_get_data_info(csock, &p_type, &p_len)) {
				csock = -4;
				for (j=2; j<i; j++) 
					free(descriptor[index][j]);
				free(descriptor[index]);
				descriptor[index] = NULL;
				goto next_step;
			}
#ifdef TEST
printf("%d parameter's type: %d length: %d\n", i, (int)p_type, (int)p_len);
#endif
			switch (p_type) {
				case INTEGER_TYPE:
					if (dog_get_data(csock, (char *)&int_val, &p_len)) {
						csock = -4;
						for (j=2; j<i; j++) 
							free(descriptor[index][j]);
						free(descriptor[index]);
						descriptor[index] = NULL;
						goto next_step;
					}
					int_val = ntohl (int_val);
					int_str = (char *)malloc(MAX_INT_STR_LEN+1);
					if (int_str == NULL) {
						printf("OUT of memory for int_str.malloc\n");
						exit(1);
					}
					p_len = longtoa(int_val, int_str, MAX_INT_STR_LEN);     
					int_str[p_len] = '\0';
					descriptor[index][i] = int_str; 
					break;
				case REAL_TYPE:
					if (dog_get_data(csock, (char *)&real_val, &p_len)) {
						csock = -4;
						for (j=2; j<i; j++) 
							free(descriptor[index][j]);
						free(descriptor[index]);
						descriptor[index] = NULL;
						goto next_step;
					}
					real_str = (char *)malloc(MAX_REAL_STR_LEN+1);
					if (real_str == 0L) {
						printf("OUT of memory for real_str.malloc\n");
						exit(1);
					}
					p_len = rtoa(real_val, real_str, MAX_REAL_STR_LEN);     
					real_str[p_len] = '\0';
					descriptor[index][i] = real_str;        
					break;
				case DOUBLE_TYPE:
					if (dog_get_data(csock, (char *)&dou_val, &p_len)) {
						csock = -4;
						for (j=2; j<i; j++) 
							free(descriptor[index][j]);
						free(descriptor[index]);
						descriptor[index] = NULL;
						goto next_step;
					}
					dou_str = (char *)malloc(MAX_DOU_STR_LEN+1);
					if (dou_str == 0L) {
						printf("OUT of memory for dou_str.malloc\n");
						exit(1);
					}
					p_len = dtoa(real_val, dou_str, MAX_DOU_STR_LEN);       
					dou_str[p_len] = '\0';
					descriptor[index][i] = dou_str; 
					break;
				case STRING_TYPE:
					str_str = (char *)malloc(p_len+1);
					if (str_str == NULL) {
						printf("OUT of memory for int_str.malloc\n");
						exit(1);
					}
					if (dog_get_data(csock, str_str, &p_len)) {
						csock = -4;
						for (j=2; j<=i; j++) 
							free(descriptor[index][j]);
						free(descriptor[index]);
						descriptor[index] = NULL;
						goto next_step;
					}
					str_str[p_len] = '\0';
					descriptor[index][i] = str_str; 
					break;
			}
			
#ifdef EIF_WIN32
			cmdLineLen += (p_len+1);
#endif
			
#ifdef TEST
printf("   value: %s \n",descriptor[index][i]);
#endif
		}

#ifdef EIF_WIN32
		descriptor[index][1] = CREATION_FLAG;
		cmdLineLen += ((long)strlen(CREATION_FLAG)+1);
		descriptor[index][para_num-1] = NULL;
#else
		descriptor[index][1] = CREATION_FLAG;
		int_str = (char *)malloc(MAX_INT_STR_LEN+1);
		if (int_str == NULL) {
			printf("OUT of memory for int_str.malloc\n");
			exit(1);
		}
		p_len = longtoa(current_pid, int_str, MAX_INT_STR_LEN); 
		int_str[p_len] = '\0';
		descriptor[index][para_num-1] = int_str;        
		descriptor[index][para_num] = NULL;
#endif

		/* Get the directory under which the executable file resides */
		if (dog_get_data_info(csock, &p_type, &p_len)) {
			csock = -4;
			for (j=2; j<=para_num-1; j++) 
				free(descriptor[index][j]);
			free(descriptor[index]);
			descriptor[index] = NULL;
			goto next_step;
		}
		if (dog_get_data(csock, execdir, &p_len)) {
			csock = -4;
			for (j=2; j<=para_num-1; j++) 
				free(descriptor[index][j]);
			free(descriptor[index]);
			descriptor[index] = NULL;
			goto next_step;
		}
		execdir[p_len] = '\0';
/*
strcpy(execdir, "\\users\\terryt\\example2\\seq\\eifgen\\w_code");
*/

		/* Get the executable file's name */
		if (dog_get_data_info(csock, &p_type, &p_len)) {
			csock = -4;
			for (j=2; j<=para_num-1; j++) 
				free(descriptor[index][j]);
			free(descriptor[index]);
			descriptor[index] = NULL;
			goto next_step;
		}
		if (dog_get_data(csock, execfile, &p_len)) {
			csock = -4;
			for (j=2; j<=para_num-1; j++) 
				free(descriptor[index][j]);
			free(descriptor[index]);
			descriptor[index] = NULL;
			goto next_step;
		}
		execfile[p_len] = '\0';
#ifdef EIF_WIN32
		cmdLineLen += (p_len + 1);
#endif
		

		/* Get the user's name who starts the execution of the application */
		if (dog_get_data_info(csock, &p_type, &p_len)) {
			csock = -4;
			for (j=2; j<=para_num-1; j++) 
				free(descriptor[index][j]);
			free(descriptor[index]);
			descriptor[index] = NULL;
			goto next_step;
		}
		if (dog_get_data(csock, usrname, &p_len)) {
			csock = -4;
			for (j=2; j<=para_num-1; j++) 
				free(descriptor[index][j]);
			free(descriptor[index]);
			descriptor[index] = NULL;
			goto next_step;
		}
		usrname[p_len] = '\0';
/*
#ifdef EIF_WIN32
		closesocket(csock);
#else
		close(csock);
#endif
*/

#ifdef EIF_WIN32
		cmdLine = (char *)malloc(cmdLineLen);
		if (cmdLine == 0L) {
			printf("OUT of memory for cmdLine.malloc\n");
			exit(1);
		}       
		strcpy(cmdLine, execfile);
		strcat(cmdLine, " ");
		for (i=1; i <= para_num - 2; i++) {
			strcat(cmdLine, descriptor[index][i]);
			strcat(cmdLine, " ");
		}
		strcat(cmdLine, cur_pid_str);
		cmdLine[cmdLineLen-1] = '\0';
#else
		descriptor[index][0] = (char *)malloc(MAX_EXEC_FILE_LEN+1);
		if (descriptor[index][0] == 0L) {
			printf("OUT of memory for dou_str.malloc\n");
			exit(1);
		}
		strcpy(descriptor[index][0], execfile);
#endif
	

		if (code !=  CREATE_SEP_OBJ) 
			continue;
		

#ifdef EIF_WIN32
		ZeroMemory(&si, sizeof(si));
		si.cb = sizeof(si);
#ifdef TEST
printf("user=<%s>, Dir=<%s>, cmdline=<%s> cmdlinelen=%d\n", usrname, execdir, cmdLine, cmdLineLen);
#endif
#ifndef DIR_GOOD
		fSuccess = SetCurrentDirectory(execdir);
		if (fSuccess)         
		fSuccess = CreateProcess(NULL, cmdLine, NULL, NULL, FALSE, NORMAL_PRIORITY_CLASS, NULL, NULL, &si, &piChild);
#else
		if (execdir[strlen(execdir)-1] != '\\') 
			strcat(execdir, "\\");
		strcat(execdir, execfile);
		strcat(execdir, ".exe"); 

		fSuccess = CreateProcess(NULL, cmdLine, NULL, NULL, FALSE, NORMAL_PRIORITY_CLASS, NULL, execdir, &si, &piChild);
#endif
		if (fSuccess) {
#ifdef CHK_CHILD
			if (dog_send_command(csock, START_SEP_OBJ_OK, 0))
				goto next_step;
#endif
			CloseHandle(piChild.hThread);
			CloseHandle(piChild.hProcess);
			closesocket(csock);
			csock = -3;
			for (j=2;  descriptor[index][j] != NULL; j++)
				free(descriptor[index][j]);
			free(descriptor[index]);
			descriptor[index] = (char **)NULL;                
		}
		else  {
#ifdef CHK_CHILD
			if (dog_send_command(csock, REPORT_ERROR, 1)) {
				closesocket(csock);
				csock = -3;
				for (j=2;  descriptor[index][j] != NULL; j++)
					free(descriptor[index][j]);
				free(descriptor[index]);
				descriptor[index] = (char **)NULL;                
				goto next_step;
			}

			int_val = c_get_host_name(hostname, HOSTNAME_LEN); 
			sprintf(message, "Detected Crash Happened Here: \n    on host <%s> \nError Message:\n    DAEMON can't create separate object from class <%s>(Error No: %d)\nby executing file: <%s> in directory: <%s>.\n    Please check the configure file on the host to make sure that\nthe executable file exists in the directory.", hostname, descriptor[index][4], errno, execfile, execdir);
			p_len  = strlen(message);
			p_type = STRING_TYPE;
			if (dog_send_data(csock, &p_type, message, &p_len)) {
				closesocket(csock);
				csock = -3;
				for (j=2;  descriptor[index][j] != NULL; j++)
					free(descriptor[index][j]);
				free(descriptor[index]);
				descriptor[index] = (char **)NULL;                
				goto next_step;
			}
#endif
						
#ifdef TEST
			printf("Error in CreateProcess: %d\n", WSAGetLastError());
			perror("CreateProcess");
#endif
		}
#else

		child_set_up = 0;
		child = fork();
		if (child<0) {
#ifdef CHK_CHILD
			if (dog_send_command(csock, REPORT_ERROR, 1)) {
				csock = -4;
				for (j=2; descriptor[index][j] != NULL; j++) 
					free(descriptor[index][j]);
				free(descriptor[index]);
				descriptor[index] = NULL;
				goto next_step;
			}

			int_val = c_get_host_name(hostname, HOSTNAME_LEN); 
			sprintf(message, "Detected Error Happened Here: on host <%s> \nError Message:\n    DAEMON can't create processor for separate object from class <%s>(Error No: %d)\nWhen Execute File: <%s> In Directory: <%s>.\n-- Maybe no more available process or no more memory for a process.", hostname, descriptor[index][4], errno, execfile, execdir);
			p_len  = strlen(message);
			p_type = STRING_TYPE;
			if (dog_send_data(csock, &p_type, message, &p_len)) {
				csock = -4;
				for (j=2; descriptor[index][j] != NULL; j++) 
					free(descriptor[index][j]);
				free(descriptor[index]);
				descriptor[index] = NULL;
				goto next_step;
			}
			close(csock);
			goto next_step;
#endif
		}

		signal(SIGPIPE, sig_proc);

		if (child == 0) /* Child process */
		{ 
		    setpwent();
		    pwd = (struct passwd *)getpwnam(usrname);
		    endpwent();
		    setegid((gid_t) pwd->pw_gid);
		    seteuid((uid_t) pwd->pw_uid);
#ifdef TEST
printf("$$$$$$$$$ Now, call an exec with the following parameters: \n");
for(j=0; descriptor[index][j]; j++)
	printf("%dth parameter: <%s>\n", j, descriptor[index][j]);
#endif
			j = chdir(execdir);
			if (j == 0)
				j = execv(execfile, descriptor[index]);

#ifdef TEST
printf("ERROR: After execv, return %d, errno %d\n", j, errno);
perror("AFTER EXECV");
errno = 0;
#endif

#ifdef CHK_CHILD
			j = dog_send_command(csock, REPORT_ERROR, 1);

			int_val = c_get_host_name(hostname, HOSTNAME_LEN); 
			sprintf(message, "Detected Crash Happened Here: \n    on host <%s> \nError Message:\n    DAEMON can't create separate object from class <%s>(Error No: %d)\nby executing file: <%s> in directory: <%s>.\n    Please check the configure file on the host to make sure that\nthe executable file exists in the directory.", hostname, descriptor[index][4], errno, execfile, execdir);
			p_len  = strlen(message);
			p_type = STRING_TYPE;
			j = dog_send_data(csock, &p_type, message, &p_len);
			if (!j) 
				close(csock);
#endif
			
			csock = -2;

			if ((j = kill(getppid(), SIGUSR1)) < 0) {
				printf("%d ERROR in daemon.kill\n", getpid());
				perror("kill");
				exit(1);
			}

			exit(0);

		}
		else {
		/* Parent process wait for the child process has kept the 
		 * index of descriptor 
		*/

#ifdef WAIT
			owner[index] = child;
#else
			wait_sig_from_child = 1;
			for(; !child_set_up;) {
				sleep(constant_time_of_daemon_waiting_child);
				if (!has_got_a_chd_signal)
				/* means: time out for the sleep but no signal arrived */
					break;
				has_got_a_chd_signal = 0;
			}
#ifdef CHK_CHILD
			if (child_set_up == SIGUSR2) {
				j = dog_send_command(csock, START_SEP_OBJ_OK, 0);
			}
			else {
				if (child_set_up == 0) {
				/* time out but no signal arrived, first, kill the process in
 				 * case that separate object did not die , then send error
				 * message.
				 */
					wait_sig_from_child = 0;
					j = kill(child, SIGKILL);					
					j = dog_send_command(csock, REPORT_ERROR, 1);
					int_val = c_get_host_name(hostname, HOSTNAME_LEN); 
					sprintf(message, "DAEMON Detected Crash Happened: separate object `%s' on host <%s> \nError Message:\n    Child separate object did not response to the daemon for at leat %d seconds\n-- sometime the short of system resources(memory, file descriptore etc)\nwould cause the error.", descriptor[index][4], hostname, constant_time_of_daemon_waiting_child);
					p_len  = strlen(message);
					p_type = STRING_TYPE;
					j = dog_send_data(csock, &p_type, message, &p_len);
				} else
				if (child_set_up == SIGUSR1 || wait_sig_from_child==2) { 
					j = dog_send_command(csock, REPORT_ERROR, 1);
					int_val = c_get_host_name(hostname, HOSTNAME_LEN); 
					sprintf(message, "DAEMON Detected Crash Happened: separate object `%s' on host <%s> \nError Message:\n    Child separate object crashed\n-- sometime the short of system resources would cause the error.", descriptor[index][4], hostname);
					p_len  = strlen(message);
					p_type = STRING_TYPE;
					j = dog_send_data(csock, &p_type, message, &p_len);
				}
			}
#endif
			wait_sig_from_child = 0;
			close(csock);
			csock = -3;
			for (j=2;  descriptor[index][j] != NULL; j++)
				free(descriptor[index][j]);
			free(descriptor[index]);
			descriptor[index] = (char **)NULL;                
#endif
		signal(SIGUSR1, sig_proc);
		signal(SIGUSR2, sig_proc);
#ifdef DEAD
		signal(SIGCLD, sig_chld);
#endif

		}
#endif

	}

}



#ifndef EIF_WIN32

void sig_proc(int sig) {

#ifdef TEST
	printf("%d I got a signal:%d(SIGUSR2: %d, SIGUSR1: %d SIGPIPE: %d) \n", getpid(),sig, SIGUSR2, SIGUSR1, SIGPIPE);
#endif
	if (sig==SIGUSR1 || sig==SIGUSR2)
		child_set_up = sig;
	if (sig==SIGPIPE) {
		socket_is_not_writable = 1;
#ifdef tTEST
printf("######################## Captured a SIGPIPE\n");
#endif
	}
}

void sig_chld(int sig) {
	int j, ret,status;

#ifdef TEST
	printf("%d I got a signal:%d(SIGCLD: %d) \n", getpid(),sig, SIGCLD);
#endif
		ret = wait(&status);
		if (ret==child && wait_sig_from_child) {
			child_set_up = SIGUSR1;
/*			j = kill(getpid(), SIGUSR1);*/
			wait_sig_from_child = 2;
		}
		else
			has_got_a_chd_signal = 1;
#ifdef TEST
		printf("return code = %d, status = %d\n", ret, status);
/*
		printf("child=%d, WIFEXITED=%d, WEXITSTATUS=%d, WIFSIGNALED=%d, WTERMSIG=%d, WIFSTOPPED=%d\n", child, WIFEXITED(status), WEXITSTATUS(status), WIFSIGNALED(status), WTERMSIG(status), WIFSTOPPED(status));
*/
		perror("In Sig_Chld");
#endif
#ifdef WAIT
		for (j=0; j<MAX_DESCRIPTOR && owner[j] != ret; j++);
		printf("Now clear DESCRIPTOR at %d with pid %d\n", j, ret);
		status = j;
		for (j=0;  descriptor[status][j] != NULL; j++)
			free(descriptor[status][j]);
		free(descriptor[status]);
		descriptor[status] = (char **)NULL;               
		owner[status] = -1;
#endif
}

#endif

