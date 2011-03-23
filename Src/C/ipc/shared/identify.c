/*
	description: "[
			Identify parent, to make sure we are started via the ised wrapper.

			For Windows:
				Well actually check we were launched from a legitimate launcher.
				We need to uudecode the arguments that come down.
				We use the real command line usng GetCommandLine.
				Dummy console handles are (re)created at this point.
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
#ifdef EIF_VMS
#include "ipcvms.h"		/* VMS: force use of select jacket */
#endif
#include <string.h>
#ifdef I_SYS_TIMES
#include <sys/times.h>
#elif defined(I_SYS_TIME)
#include <sys/times.h>
#endif
#include <sys/types.h>
#include <sys/stat.h>
#include "eif_logfile.h"
#include "timehdr.h"
#include "ewbio.h"
#include "identify.h"
#include "shared.h" /* for C2P_IPC_NAMED_PIPE_PID_APP_TPL and P2C_.. */
#include <stdio.h>

#ifdef EIF_WINDOWS
#include "uu.h"
#include <windows.h>
#else /* non EIF_WINDOWS */
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <signal.h>
#include "limits.h"
#include <ctype.h>
#include <fcntl.h>
#define MAX_PATH PATH_MAX
#endif

#define BACKLOG 10


#ifdef EIF_WINDOWS
rt_private int get_pipe_events (char* id, HANDLE* p_event_r, HANDLE* p_event_w);
rt_private int get_pipe_data_from_socket(int a_port_number, char* id, HANDLE *p_in, HANDLE* p_out, HANDLE* p_event_r, HANDLE* p_event_w) 
#else
/*
rt_private void sigchld_handler(int s)
{
    while(waitpid(-1, NULL, WNOHANG) > 0);
}
*/

rt_private int get_pipe_data_from_socket(int a_port_number, char* id, int *p_in, int* p_out) 
#endif
{
	struct sockaddr_in client_addr;	/* Client Internet address */
	char out_buf[4096];   			/* Output buffer for data */
	char in_buf[4096];    			/* Input buffer for data */
	char* debuggee_pid_str;
	unsigned int port_num;
#ifdef EIF_WINDOWS
	int addr_len;        					/* Internet address length */
	struct sockaddr_in   server_addr;     	/* Server Internet address */
    SOCKET sockfd, new_fd;  				/* listen on sock_fd, new connection on new_fd */
	WORD wVersionRequested = MAKEWORD(1,1);	/* Stuff for WSA functions */
	WSADATA wsaData;                    	/* Stuff for WSA functions */
#else
	socklen_t addr_len;		/* Internet address length */
    int sockfd, new_fd;  	/* listen on sock_fd, new connection on new_fd */
	int retcode;         	/* Return code */
    struct addrinfo hints, *servinfo, *p;
	char str_port_number[5]; /* max is 65535, see http://www.iana.org/assignments/port-numbers */
	int yes=1;
#endif

	port_num = (unsigned int) a_port_number;

#ifdef EIF_WINDOWS
	WSAStartup(wVersionRequested, &wsaData);

	/* Create a welcome socket
	 *   - AF_INET is Address Family Internet and SOCK_STREAM is streams */
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	if (sockfd < 0) {
#ifdef USE_ADD_LOG		
		add_log(1, "ERROR - socket() failed");
#endif
		return -1;
	}

	/* Fill-in server (my) address information and bind the welcome socket */
	server_addr.sin_family = AF_INET;					/* Address family to use */
	server_addr.sin_port = htons((u_short)port_num);	/* Port number to use */
	server_addr.sin_addr.s_addr = htonl(INADDR_ANY);	/* Listen on any IP address */
	if (bind(sockfd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
#ifdef USE_ADD_LOG		
		add_log(1, "ERROR - bind() failed");
#endif
		return -1;
	}
#else /* non EIF_WINDOWS */
	/* init socket */
/* - AF_INET is Address Family Internet and SOCK_STREAM is streams */
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
/*    hints.ai_family = AF_INET; */
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE; /* use my IP */
/*    hints.ai_flags = 0 */

	sprintf (str_port_number, "%d", port_num);
    retcode = getaddrinfo(NULL, str_port_number, &hints, &servinfo);
    if (retcode != 0) {
#ifdef USE_ADD_LOG		
		add_log(1, "getaddrinfo: %s", gai_strerror(retcode));
#endif
        return -1;
    }

    /* loop through all the results and bind to the first we can */
    for(p = servinfo; p != NULL; p = p->ai_next) {
        if ((sockfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) == -1) {
#ifdef USE_ADD_LOG		
			add_log(3, "ERROR: socket(..) failed (err:%s)", strerror(errno));
#endif
            continue;
        }
        if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(int)) == -1) {
#ifdef USE_ADD_LOG		
			add_log(3, "ERROR: setsockopt(..) failed (err:%s)", strerror(errno));
#endif
			
			return -1;
        }
        if (bind(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
            close(sockfd);
#ifdef USE_ADD_LOG		
			add_log(3, "ERROR: server: bind(..) failed (err:%s)", strerror(errno));
#endif
            continue;
        }
        break;
    }
    if (p == NULL)  {
#ifdef USE_ADD_LOG		
        add_log(1, "ERROR server failed to bind");
#endif
        return -1;
    }
    freeaddrinfo(servinfo); /* all done with this structure */
#endif
	
	/* Listen on welcome socket for a connection */
    if (listen(sockfd, BACKLOG) < 0) {
#ifdef USE_ADD_LOG		
		add_log(1, "ERROR: list(..) failed (err:%s)", strerror(errno));
#endif
        return -1;
    }

#ifdef EIF_WINDOWS

#else /* not EIF_WINDOWS */
	/* reap all dead processes
    sa.sa_handler = sigchld_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;
    if (sigaction(SIGCHLD, &sa, NULL) == -1) {
#ifdef USE_ADD_LOG		
		add_log(1, "ERROR: sigaction(..) failed (err:%s)", strerror(errno));
#endif
		return -1;
    }
	*/
#endif

	/* Accept a connection.  The accept() will block and then return with
	 * new_fd assigned and client_addr filled-in. */
	addr_len = sizeof(client_addr);
	new_fd = accept(sockfd, (struct sockaddr *)&client_addr, &addr_len);
	if (new_fd < 0) {
#ifdef USE_ADD_LOG		
		add_log(1, "ERROR: accept() failed (err:%s)", strerror(errno));
#endif
		return -1;
	}

	/* Send to the client using the connect socket */
	debuggee_pid_str = (char*) malloc(64* sizeof(char));

#ifdef EIF_WINDOWS
	sprintf (debuggee_pid_str, "%d", (unsigned int) GetCurrentProcessId());
#else
	sprintf (debuggee_pid_str, "%d", (unsigned int) getpid());
#endif
#ifdef USE_ADD_LOG		
	add_log(3, "Info: debuggee_pid=%s", debuggee_pid_str);
#endif
	
	strcpy(out_buf, debuggee_pid_str);
	if (send(new_fd, out_buf, ((unsigned int)strlen(out_buf) + 1), 0) < 0) {
#ifdef USE_ADD_LOG		
		add_log(1, "ERROR - send(..) failed (err:%s)", strerror(errno));
#endif
		return -1;
	}
#ifdef USE_ADD_LOG		
	add_log(3, "Waiting for debugger");
#endif
	
	/* Receive from the client using the connect socket */
	if (recv(new_fd, in_buf, sizeof(in_buf), 0) < 0) {
#ifdef USE_ADD_LOG		
		add_log(3, "ERROR - recv(..) failed (err:%s)", strerror(errno));
#endif
		return -1;
	}

#ifdef USE_ADD_LOG		
	add_log(3, "Opening pipes");
#endif

#ifdef EIF_WINDOWS
	{
		char pipe_name[MAX_PATH];
		HANDLE hPipe;
		BOOL fSuccess; 
		DWORD dwMode; 
		DWORD l_err;

		/* p_out */
		sprintf (pipe_name, C2P_IPC_NAMED_PIPE_PID_APP_TPL, GetCurrentProcessId(), "app");
#ifdef USE_ADD_LOG		
		add_log(3, "Opening pipe p_out=c2p %s", pipe_name);
#endif
		hPipe = INVALID_HANDLE_VALUE;
		while (hPipe == INVALID_HANDLE_VALUE) { /* 1 */
			hPipe = CreateFile( 
						pipe_name,   /* pipe name  */
						GENERIC_WRITE | FILE_READ_ATTRIBUTES, 
						0,              /* no sharing  */
						NULL,           /* default security attributes */
						OPEN_EXISTING,  /* opens existing pipe  */
						0,              /* default attributes  */
						NULL);          /* no template file  */
			if (hPipe != INVALID_HANDLE_VALUE)  {
				break; 
			}

			/* Exit if an error other than ERROR_PIPE_BUSY occurs. */
			l_err = GetLastError();
			if (l_err != ERROR_PIPE_BUSY) {
#ifdef USE_ADD_LOG		
				add_log(1, "ERROR: could not open pipe (err:%d)", l_err);
#endif
				return -1;
			}

			/* All pipe instances are busy, so wait for 20 seconds.  */
			if (!WaitNamedPipe(pipe_name, 20000)) { 
#ifdef USE_ADD_LOG		
				add_log(1, "ERROR: could not open pipe");
#endif
				return -1;
			} 
		}
		/* The pipe connected; change to message-read mode.  */
#ifdef USE_ADD_LOG		
		add_log(3, "pipe c2p connected %d", hPipe);
#endif

		dwMode = PIPE_READMODE_MESSAGE; 
		fSuccess = SetNamedPipeHandleState( 
				hPipe,    /* pipe handle  */
				&dwMode,  /* new pipe mode  */
				NULL,     /* don't set maximum bytes  */
				NULL);    /* don't set maximum time  */
		if (!fSuccess) 
		{
#ifdef USE_ADD_LOG		
			add_log(1, "ERROR: SetNamedPipeHandleState failed for pipe c2p (err=%d)", GetLastError());
#endif
			return -1;
		}
		*p_out = hPipe;

		/* p_in */
		sprintf (pipe_name, P2C_IPC_NAMED_PIPE_PID_APP_TPL, GetCurrentProcessId(), "app");
#ifdef USE_ADD_LOG		
		add_log(3, "Opening pipe p_in=p2c %s", pipe_name);
#endif
		hPipe = INVALID_HANDLE_VALUE;
		while (hPipe == INVALID_HANDLE_VALUE) { /* 1 */
			hPipe = CreateFile( 
						pipe_name,   /* pipe name  */
						GENERIC_READ | FILE_WRITE_ATTRIBUTES, 
						0,              /* no sharing  */
						NULL,           /* default security attributes */
						OPEN_EXISTING,  /* opens existing pipe  */
						0,              /* default attributes  */
						NULL);          /* no template file  */
			if (hPipe != INVALID_HANDLE_VALUE)  {
				break; 
			}

			/* Exit if an error other than ERROR_PIPE_BUSY occurs.  */
			l_err = GetLastError();
			if (l_err != ERROR_PIPE_BUSY) {
#ifdef USE_ADD_LOG		
				add_log(1, "ERROR: could not open pipe (err:%d)", l_err);
#endif
				return -1 ;
			}

			/* All pipe instances are busy, so wait for 20 seconds.  */
			if (!WaitNamedPipe(pipe_name, 20000)) { 
#ifdef USE_ADD_LOG		
				add_log(1, "ERROR: could not open pipe");
#endif
				return -1;
			} 
		}
		/* The pipe connected; change to message-read mode. */
#ifdef USE_ADD_LOG		
		add_log(3, "pipe p2c connected %d", hPipe);
#endif

		dwMode = PIPE_READMODE_MESSAGE; 
		fSuccess = SetNamedPipeHandleState( 
				hPipe,    /* pipe handle  */
				&dwMode,  /* new pipe mode  */
				NULL,     /* don't set maximum bytes  */
				NULL);    /* don't set maximum time  */
		if (!fSuccess) 
		{
#ifdef USE_ADD_LOG		
			add_log(1, "ERROR: SetNamedPipeHandleState for p2c failed (err=%d)", GetLastError());
#endif
			return -1;
		}

		*p_in = hPipe;

	}
#else
	{
		/* Get PIPE ....*/
		char pipe_name[MAX_PATH];

		/* p_out : writing */
		sprintf (pipe_name, C2P_IPC_NAMED_PIPE_PID_APP_TPL, getpid(), "app");
#ifdef USE_ADD_LOG
		add_log(3, "Opening pipe p_out=c2p: %s", pipe_name); 
#endif
		*p_out = open(pipe_name, O_WRONLY);
#ifdef USE_ADD_LOG
		add_log(3, "out=c2p= %d", *p_out); 
#endif

		/* p_in : reading */
		sprintf (pipe_name, P2C_IPC_NAMED_PIPE_PID_APP_TPL, getpid(), "app");
#ifdef USE_ADD_LOG
		add_log(3, "Opening pipe p_in=p2c: %s", pipe_name); 
#endif
		*p_in = open(pipe_name, O_RDONLY);
#ifdef USE_ADD_LOG
		add_log(3, "in=p2c= %d", *p_in); 
#endif
		
	}
#endif

#ifdef EIF_WINDOWS
	if (get_pipe_events (id, p_event_r, p_event_w) == -1) {
		return -1;
	}
#endif

	/* tell the parent we have the pipes and events, and thus we are ready to continue */
	strcpy(out_buf, "ready");
	if (send(new_fd, out_buf, ((unsigned int)strlen(out_buf) + 1), 0) < 0) {
#ifdef USE_ADD_LOG
		add_log(1, "ERROR - send(..) failed (err:%s)", strerror(errno)); 
#endif
		return -1;
	}


#ifdef EIF_WINDOWS
	/* Close the welcome and connect sockets */
	if (closesocket(sockfd) < 0) {
#ifdef USE_ADD_LOG
		add_log(1, "ERROR - closesocket(sockfd) failed (err:%s)", strerror(errno)); 
#endif
		return -1;
	}
	if (closesocket(new_fd) < 0) {
#ifdef USE_ADD_LOG
		add_log(1, "ERROR - closesocket(new_fd) failed (err:%s)", strerror(errno)); 
#endif
		return -1;
	}
	/* Clean-up winsock */
	WSACleanup();
#else
	/* Close the welcome and connect sockets */
	if (close(sockfd) < 0) {
#ifdef USE_ADD_LOG
		add_log(1, "ERROR - close(sockfd) failed (err:%s)", strerror(errno)); 
#endif
		return -1;
	}
	if (close(new_fd) < 0) {
#ifdef USE_ADD_LOG
		add_log(1, "ERROR - close(new_fd) failed (err:%s)", strerror(errno)); 
#endif
		return -1;
	}
#endif
	return 0;
}


#ifdef EIF_WINDOWS

rt_private int get_pipe_events (char* id, HANDLE* p_event_r, HANDLE* p_event_w)
{
	HANDLE event_r, event_w;
	CHAR   event_str [128];
	unsigned int debuggee_pid;
	DWORD count;

	/* debuggee/application date */
	debuggee_pid = (unsigned int) GetCurrentProcessId();

	/* Get Semaphore */
	event_r = NULL;

/*      NT 3.51 is really fast - at this point we know we were launched by ebench.
	lets wait for it to catch up with us */

	sprintf (event_str, "eif_event_w%x_%s", debuggee_pid, id);
	for (count = 0; (event_r == NULL) && (count < 10); count++) {
		event_r = OpenSemaphore (SEMAPHORE_ALL_ACCESS, FALSE, event_str);
		if (event_r == NULL)
			Sleep(500);
	}
	if (event_r == NULL) {
#ifdef USE_ADD_LOG
		add_log(12, "not started from wrapper - no read event %d", GetLastError());
#endif
		return -1;
	}
	sprintf (event_str, "eif_event_r%x_%s", debuggee_pid, id);
	event_w = OpenSemaphore (SEMAPHORE_ALL_ACCESS, FALSE, event_str);
	if (event_w == NULL) {
#ifdef USE_ADD_LOG
		add_log(12, "not started from wrapper - no write event");
#endif
		return -1;
	}

	*p_event_r = event_r;
	*p_event_w = event_w;

	return 0;
}

rt_private int get_pipe_data_from_command_line(int unused_arg, char* id, HANDLE *p_in, HANDLE* p_out, HANDLE* p_event_r, HANDLE* p_event_w)
{
	/*
	 * check the handle is valid
	 */

	HANDLE uu_handles [2];
	size_t tl, sz;
	char *t, *uu_str, *uu_t;
	

	t = GetCommandLine();
	tl = strlen (t);
		/* 2 because we retrieve 2 HANDLEs from the command line. */
	sz = (2 * sizeof(HANDLE) * 4 + 2) / 3;
	if (sz % 4) {
		sz += 4 - (sz % 4);
	}
	if ((tl < sz + 5) || (t[tl-1] != '"') || (t[tl-2] != '?') || (t[tl-(sz+3)] != '?') || (t[tl-(sz+4)] != '"'))
		return -1;

	uu_str = strdup ((t + tl  - (sz + 2)));
	uu_str [strlen(uu_str) -2] = '\0';
	uu_t = uudecode_str (uu_str);
	memcpy ((char *)uu_handles, uu_t, 2 * sizeof (HANDLE));
	free (uu_t);
	*p_out = uu_handles [0];
	*p_in = uu_handles [1];


	if (get_pipe_events (id, p_event_r, p_event_w) == -1) {
		return -1;
	}

	return 0;
}

rt_public int identify(char* id, HANDLE *p_ewbin, HANDLE *p_ewbout, HANDLE *p_event_r, HANDLE *p_event_w)
{
	/* Identification protocol, to make sure we have been started via the
	 * ised wrapper. We expect a null character from file descriptor *p_ewbin and
	 * write a ^A on *p_ewbout.
	 */

	return custom_identify(id, p_ewbin, p_ewbout, p_event_r, p_event_w, &get_pipe_data_from_command_line, 0);
}

rt_public int identify_with_socket(char* id, HANDLE *p_ewbin, HANDLE *p_ewbout, HANDLE *p_event_r, HANDLE *p_event_w, int a_port_number)
{
	/* Identification protocol, to make sure we are attached by ised wrapper thanks to socket.
	 * We expect a null character from file descriptor *p_ewbin and
	 * write a ^A on *p_ewbout.
	 */


	return custom_identify(id, p_ewbin, p_ewbout, p_event_r, p_event_w, &get_pipe_data_from_socket, a_port_number);
}

rt_public int custom_identify(char* id, HANDLE *p_ewbin, HANDLE *p_ewbout, HANDLE *p_event_r, HANDLE *p_event_w, 
		int (*get_pipe_data_func_ptr)(int, char*, HANDLE*,HANDLE*,HANDLE*,HANDLE*), int get_pipe_data_func_arg1)
{
	/* Identification protocol, to make sure we have been started via the
	 * ised wrapper. We expect a null character from file descriptor *p_ewbin and
	 * write a ^A on *p_ewbout.
	 */

	HANDLE eif_conoutfile, eif_coninfile;
	HANDLE ewbin, ewbout;
	DWORD wait;
	SECURITY_ATTRIBUTES sa;
	char c;
	DWORD count;

	/* Get pipe pointer data */
	if ((*get_pipe_data_func_ptr)(get_pipe_data_func_arg1, id, &ewbin, &ewbout, p_event_r, p_event_w) == -1 ) {
		return -1;
	}

	*p_ewbin = ewbin;
	*p_ewbout = ewbout;

	/* Quickly poll on ewbin to see whether it's worth attempting a read on
	 * it or not. Wait at most 10 seconds (to let our parent initialize) and
	 * then return if nothing is available within that time frame.
	 */

	wait = WaitForSingleObject (*p_event_r, 10000);
	switch (wait) {
		case WAIT_TIMEOUT:
#ifdef USE_ADD_LOG
			add_log(2, "ERROR unexpected WaitForSingleObject WAIT_TIMEOUT");
#endif
			return -1;
			break;
		case WAIT_FAILED:
#ifdef USE_ADD_LOG
			add_log(2, "ERROR unexpected WaitForSingleObject WAIT_FAILED %x", GetLastError());
#endif
			return -1;
			break;
		case WAIT_OBJECT_0:
			/* Ok, continue */
			break;
		default:
#ifdef USE_ADD_LOG
			add_log(2, "ERROR unexpected WaitForSingleObject failure");
#endif
			return -1;
			break;
	}

	/* If nothing is available on ewbin, return with an error log message */

	if (!ReadFile(ewbin, &c, 1, &count, NULL)) {
#ifdef USE_ADD_LOG
		add_log(12, "not started from wrapper - read failure %d", GetLastError());
#endif
		return -1;
	} else if (c != 0) {
#ifdef USE_ADD_LOG
		add_log(12, "wrong parent, it would seem");
#endif
		return -1;
	} else {
		c = '\01';
		if (!WriteFile(ewbout, &c, 1, &count, NULL)) {
#ifdef USE_ADD_LOG
			add_log(12, "identification back failed %d on %d", GetLastError(), ewbout);
#endif
			return -1;
		}
		{ 
			LONG sem_count;
			ReleaseSemaphore (*p_event_w, 1, &sem_count);
#ifdef USE_ADD_LOG
			add_log(12, "ReleaseSemaphore (event_w) -> on %d", sem_count);
#endif
		}
	}

#ifdef USE_ADD_LOG
	add_log(12, "started from wrapper");
#endif

	sa.nLength = sizeof(SECURITY_ATTRIBUTES);
	sa.lpSecurityDescriptor = NULL;
	sa.bInheritHandle = TRUE;

    eif_conoutfile = CreateFile ("CONOUT$", GENERIC_WRITE | GENERIC_READ,
	      FILE_SHARE_READ | FILE_SHARE_WRITE, &sa, OPEN_EXISTING, 0, 0);

    if (eif_conoutfile == INVALID_HANDLE_VALUE) {
#ifdef USE_ADD_LOG
/*              add_log(12, "Create output handle failed %d", GetLastError()); */
#endif
/*              return -1; */
	}

	SetStdHandle (STD_OUTPUT_HANDLE, eif_conoutfile);
	eif_coninfile = CreateFile ("CONIN$", GENERIC_READ | GENERIC_WRITE,
	      FILE_SHARE_READ | FILE_SHARE_WRITE, &sa, OPEN_EXISTING, 0, 0);

	if (eif_coninfile == INVALID_HANDLE_VALUE)
	      {
#ifdef USE_ADD_LOG
/*              add_log(12, "Create input handle failed %d", GetLastError()); */
#endif
/*              return -1; */
	      }
	SetStdHandle (STD_INPUT_HANDLE, eif_coninfile);
	return 0;
}

#else /* not EIF_WINDOWS */
rt_public int identify(char* id, int fd_in, int fd_out)
{
	/* Identification protocol, to make sure we have been started via the
	 * ised wrapper. We expect a null character from file descriptor fd_in and
	 * write a ^A on fd_out.
	 */

	return custom_identify(id, &fd_in, &fd_out, NULL, 0);
}

rt_public int identify_with_socket(char* id, int* p_fd_in, int* p_fd_out, int a_port_number)
{
	/* Identification protocol, to make sure we are attached by ised wrapper thanks to socket.
	 * We expect a null character from file descriptor *p_fd_in and
	 * write a ^A on *p_fd_out.
	 */

	return custom_identify(id, p_fd_in, p_fd_out, &get_pipe_data_from_socket, a_port_number);
}

rt_public int custom_identify(char* id, int* p_fd_in, int* p_fd_out, int (*get_pipe_data_func_ptr)(int, char*, int*, int*), int get_pipe_data_func_arg1)
{
	/* Identification protocol, to make sure we have been started via the
	 * ised wrapper. We expect a null character from file descriptor fd_in and
	 * write a ^A on fd_out.
	 */

	char c;
	fd_set mask;
	struct timeval tm;			/* Timeout for select */
	struct stat buf;			/* Statistics buffer */
	int fd_in;
	int fd_out;

	fd_in = *p_fd_in;
	fd_out = *p_fd_out;

#ifdef EIF_VMS_V6_ONLY  /* VMS FIXME: is this still necessary? */
	/* close pipes that are open from parent; required because VMS uses */
	/* vfork().  This normally happens after fork() when the process id */
	/* is 0 (see spawn_child() in ipc/daemon/child.c)		    */
	FD_ZERO (&mask);
	FD_SET (EWBOUT, &mask); FD_SET (EWBIN, &mask);
	ipcvms_cleanup_fd (&mask, -1);
#endif

	/* Get pipe pointer data */
	if (get_pipe_data_func_ptr) {
		if ((*get_pipe_data_func_ptr)(get_pipe_data_func_arg1, id, p_fd_in, p_fd_out) == -1 ) {
			return -1;
		}
		fd_in = *p_fd_in;
		fd_out = *p_fd_out;
	}

	/* Cut off the whole process if file fd_in is not a valid file descriptor,
	 * something the kernel will gladly tell us by making the fstat() system
	 * call fail.
	 */

	FD_ZERO(&mask);
	FD_SET(fd_in, &mask);	/* Want to select of fd ewbin */

	if (-1 == fstat(fd_in, &buf)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR fstat: %m (%e)");
		add_log(2, "ERROR file fd_in not initialized by parent");
#endif
		return -1;
	}

	/* Quickly poll on ewbin to see whether it's worth attempting a read on
	 * it or not. Wait at most 2 seconds (to let our parent initialize) and
	 * then return if nothing is available within that time frame.
	 */

#ifdef EIF_VMS	/* VMS: spawn is slow; ensure enough time is allowed for parent to write to pipe. */
	tm.tv_sec = 5;
#else
	tm.tv_sec = 2;
#endif /* EIF_VMS */
	tm.tv_usec = 0;
	if (-1 == select(fd_in + 1, &mask, (Select_fd_set_t) 0, (Select_fd_set_t) 0, &tm)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR select: %m (%e)");
		add_log(2, "ERROR unexpected select failure");
#endif
		return -1;
	}

	/* If nothing is available on ewbin, return with an error log message */
	if (!FD_ISSET(fd_in, &mask)) {
#ifdef USE_ADD_LOG
		add_log(12, "nothing distilled by parent");
#endif
		return -1;
	}

	if (-1 == read(fd_in, &c, 1)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR read: %m (%e)");
		add_log(12, "not started from wrapper");
#endif
		return -1;
	} else if (c != 0) {
#ifdef USE_ADD_LOG
		add_log(12, "wrong parent, it would seem");
#endif
		return -1;
	} else {
		c = '\01';
		/* I don't care if we get SIGPIPE */
		if (-1 == write(fd_out, &c, 1)) {
#ifdef USE_ADD_LOG
			add_log(1, "SYSERR read: %m (%e)");
			add_log(12, "identification back failed");
#endif
			return -1;
		}
	}

#ifdef USE_ADD_LOG
	add_log(12, "started from wrapper");
#endif

	return 0;
}
#endif
