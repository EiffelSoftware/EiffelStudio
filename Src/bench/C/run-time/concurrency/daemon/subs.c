#include "dog.h"

/*
main() {
	double num=1234567.01234567;
	char buff[40];
	int i;

	for (; num != 0.0; ) {
	printf("Please input a number:");
	scanf("%f", &num);
	printf("you have just input a number %f\n", num);
	i = dtoa(num, buff, 40);
	if (i<0) {
		printf("Error in dtoa: %d\n", i);
		exit(1);
	}
	else
		buff[i] = '\0';
	printf("you have just input a number %f(%s)\n", num, buff);
	}
}
*/

EIF_INTEGER inttoa(int num, char *buff, int buf_len) {
	EIF_INTEGER idx = 0;
	EIF_INTEGER model = 1000000000;	
	int dig=0;
	int flag=0;


	if (num<0) {
		buff[idx] = '-';
		idx++;
		num = -num;
	}

	for(; model > 0 && idx < buf_len; dig=num/model, num = num % model, model = model /10) {
		if (flag > 0 || dig > 0) {
			flag = 1;
			buff[idx] = '0'+ dig;
			idx++;
		}
	}
	if (idx < buf_len) {
		buff[idx] = '0' + dig; 
		idx++;
		buff[idx] = '\0';
		return idx;
	}
	else 
		return -1;
}
			 
EIF_INTEGER longtoa(EIF_INTEGER num, char *buff, int buf_len) {
	EIF_INTEGER idx = 0L;
	EIF_INTEGER model = 1000000000;	
	int dig=0;
	int flag=0;


	if (num<0) {
		buff[idx] = '-';
		idx++;
		num = -num;
	}

	for(; model > 0L && idx < buf_len; dig=num/model, num = num % model, model = model /10L) {
		if (flag > 0 || dig > 0) {
			flag = 1;
			buff[idx] = '0'+ dig;
			idx++;
		}
	}
	if (idx < buf_len) {
		buff[idx] = '0' + dig; 
		idx++;
		buff[idx] = '\0';
		return idx;
	}
	else 
		return -1;
}
			 
EIF_INTEGER rtoa(float num, char *buff, int buf_len) {
	EIF_INTEGER int_part;
	EIF_INTEGER idx = 0;
	EIF_INTEGER model = 1000000000;	
	int dig=0;
	int flag=0;


	if (num<0) {
		buff[idx] = '-';
		idx++;
		num = -num;
	}

	int_part = (EIF_INTEGER)num;
	num = num - int_part;	
	for(; model > 0 && idx < buf_len; dig=int_part/model, int_part = int_part % model, model = model /10) {
		if (flag > 0 || dig > 0) {
			flag = 1;
			if (idx >= buf_len) 
				return -1;
			buff[idx] = '0'+ dig;
			idx++;
		}
	}
	if (idx < buf_len) 
		buff[idx] = '0' + dig; 
	else 
		return -1;
	idx++;
	if (idx < buf_len) 
		buff[idx] = '.'; 
	else 
		return -1;
	idx++;
	for(flag=0; flag < 6; flag++) {
		num = num * 10;
		dig = (int)num;
		if (idx >= buf_len) 
			return -1;
		buff[idx] = '0' + dig;
		idx++;
		num = num - dig ;
	}
	buff[idx] = '\0';
	return idx;
}
			 
EIF_INTEGER dtoa(double num, char *buff, int buf_len) {
	EIF_INTEGER int_part;
	EIF_INTEGER idx = 0;
	EIF_INTEGER model = 1000000000;	
	int dig=0;
	int flag=0;


	if (num<0) {
		buff[idx] = '-';
		idx++;
		num = -num;
	}

	int_part = (EIF_INTEGER)num;
	num = num - int_part;	
	for(; model > 0 && idx < buf_len; dig=int_part/model, int_part = int_part % model, model = model /10) {
		if (flag > 0 || dig > 0) {
			flag = 1;
			if (idx >= buf_len) 
				return -1;
			buff[idx] = '0'+ dig;
			idx++;
		}
	}
	if (idx < buf_len) 
		buff[idx] = '0' + dig; 
	else 
		return -1;
	idx++;
	if (idx < buf_len) 
		buff[idx] = '.'; 
	else 
		return -1;
	idx++;
	for(flag=0; flag < 6; flag++) {
		num = num * 10;
		dig = (int)num;
		if (idx >= buf_len) 
			return -1;
		buff[idx] = '0' + dig;
		idx++;
		num = num - dig ;
	}
	buff[idx] = '\0';
	return idx;
}
			 
set_block(int m_sock) {
#ifndef EIF_WIN32
    int m_tmp, m_rc; 
    m_tmp = 0; 
    m_rc = ioctl(m_sock,FIONBIO,(char *)&m_tmp);
#else
	u_long arg = 0;
	ioctlsocket (m_sock, FIONBIO, &arg);
#endif	
}

set_non_block(int m_sock) {
#ifndef EIF_WIN32
    int m_tmp, m_rc;
    m_tmp = 1;
    m_rc = ioctl(m_sock,FIONBIO,(char *)&m_tmp);
#else
    u_long arg = 1;
    ioctlsocket (m_sock, FIONBIO, &arg);
#endif
}
                                                        
char dog_get_command(int m_sock, EIF_INTEGER *m_code, EIF_INTEGER *m_para_num) {
int m_nread;
int oldmask;

#ifndef EIF_WIN32 
	
#ifdef  tHAS_SIGSETMASK 
	oldmask = sigblock(sigmask(SIGCLD));
#endif
	m_nread = read(m_sock, (char *)m_code, CODE_SIZE);
#ifdef  tHAS_SIGSETMASK 
	sigsetmask(oldmask);
#endif
	if (m_nread != CODE_SIZE) { 
#ifdef TEST
		sprintf(loc,"\n%d 1ERROR in get_command to read %d but readed %d", getpid(), CODE_SIZE, m_nread);
		perror(loc);
#endif
		close(m_sock);
		return 1;
	}
#else 
	if (recv (m_sock, (char *)m_code, CODE_SIZE, 0) == SOCKET_ERROR) 
		if ( WSAGetLastError() != EWOULDBLOCK) {
			printf("Error in get_command.\n"); 
			return 1;
		}
#endif
	*m_code=ntohl (*m_code);
#ifndef EIF_WIN32 
#ifdef  tHAS_SIGSETMASK 
	oldmask = sigblock(sigmask(SIGCLD));
#endif
	m_nread = read(m_sock, (char *)m_para_num, DATA_SIZE);
#ifdef  tHAS_SIGSETMASK 
	sigsetmask(oldmask);
#endif
	if (m_nread != DATA_SIZE) {
#ifdef TEST
		sprintf(loc,"\n%d 2ERROR in get_command to read %d but readed %d(have got COMMAND CODE=%d from %d)", getpid(), DATA_SIZE, m_nread, m_code, m_sock);
		perror(loc);
#endif
		close(m_sock);
		return 1;
	}
#else 
	if (recv (m_sock, (char *)m_para_num, DATA_SIZE, 0) == SOCKET_ERROR) 
		if (WSAGetLastError() != EWOULDBLOCK) {
			printf("Error in get_command.\n"); 
			return 1;
		}
#endif
	*m_para_num=ntohl (*m_para_num);
	return 0;
}


char dog_get_data(int m_sock, char *buff, EIF_INTEGER *data_length) {

	int oldmask;
    int m_nread;
	if (*data_length < 0) {  /* <0 read data from server; >=0 read data from client */
#ifndef EIF_WIN32 
#ifdef  tHAS_SIGSETMASK 
		oldmask = sigblock(sigmask(SIGCLD));
#endif
	    m_nread = read(m_sock, (char *)data_length, DATA_SIZE);
#ifdef  tHAS_SIGSETMASK 
		sigsetmask(oldmask);
#endif
	    if (m_nread != DATA_SIZE) {
#ifdef TEST
		sprintf(loc,"\n%d ERROR in get_data1 to read %d but got %d", getpid(), DATA_SIZE, m_nread);
		perror(loc);
#endif
		close(m_sock);
		return 1;
	    }
#else 
	    if (recv (m_sock, (char *)data_length, DATA_SIZE, 0) == SOCKET_ERROR) 
		if (WSAGetLastError() != EWOULDBLOCK) {
			printf("Error in get_command.\n"); 
			return 1;
		}
#endif
	    *data_length = ntohl (*data_length);
	}
	if (*data_length > 0) {
#ifndef EIF_WIN32 
#ifdef  tHAS_SIGSETMASK 
		oldmask = sigblock(sigmask(SIGCLD));
#endif
	    m_nread = read(m_sock, buff, *data_length);
#ifdef  tHAS_SIGSETMASK 
		sigsetmask(oldmask);
#endif
	    if (m_nread != *data_length) {
#ifdef TEST
		sprintf(loc,"\n%d ERROR in get_data2 to read %d but got %d", getpid(), *data_length, m_nread);
		perror(loc);
#endif
		close(m_sock);
		return 1;
	    }
#else 
	if (recv (m_sock, buff, *data_length, 0) == SOCKET_ERROR) 
		if (WSAGetLastError() != EWOULDBLOCK) {
			printf("Error in get_command.\n"); 
			return 1;
		}
#endif 
	}
	return 0;
}

							
char dog_send_command(int m_sock, EIF_INTEGER m_code, EIF_INTEGER m_para_num) {
int m_nwrite;
int oldmask;

char send_buf[OP_SIZE];

	errno = 0;
	set_non_block(m_sock);

	*(EIF_INTEGER *)send_buf = htonl(m_code);
	*((EIF_INTEGER *)(send_buf+CODE_SIZE)) = htonl(m_para_num);
#ifndef EIF_WIN32 
#ifdef  tHAS_SIGSETMASK 
	oldmask = sigblock(sigmask(SIGCLD));
#endif
	
	m_nwrite = send(m_sock, send_buf, OP_SIZE, 0);
	if (m_nwrite != OP_SIZE) { 
#ifdef TEST
		sprintf(loc,"\n%d ERROR in send_command to write %d but wrote %d", getpid(), CODE_SIZE, m_nwrite);
		perror(loc);
#endif
		close(m_sock);
		return 1;
	}
#else 
	
	if (send (m_sock, send_buf, OP_SIZE, 0) == SOCKET_ERROR) 
		if ( WSAGetLastError() != EWOULDBLOCK) {
			printf("Error in send_command.\n"); 
			return 1;
		}
#endif
	
	set_block(m_sock);

	return 0;
}


char dog_send_data(int m_sock, EIF_INTEGER *type, char *buff, EIF_INTEGER *data_length) {

	int oldmask;
    int m_nwrite;

	char send_buf[OP_SIZE];

	*(EIF_INTEGER *)send_buf = htonl(*type);
	*((EIF_INTEGER *)(send_buf+CODE_SIZE)) = htonl(*data_length);
#ifndef EIF_WIN32 
#ifdef  tHAS_SIGSETMASK 
	oldmask = sigblock(sigmask(SIGCLD));
#endif
	
	m_nwrite = send(m_sock, send_buf, OP_SIZE, 0);
#ifdef  tHAS_SIGSETMASK 
	sigsetmask(oldmask);
#endif
	if (m_nwrite != OP_SIZE) { 
#ifdef TEST
		sprintf(loc,"\n%d ERROR in send_data to write %d but wrote %d", getpid(), SIZEOFINT, m_nwrite);
		perror(loc);
#endif
		close(m_sock);
		return 1;
	}
#else 
	
	if (send (m_sock, send_buf, OP_SIZE, 0) == SOCKET_ERROR) 
		if ( WSAGetLastError() != EWOULDBLOCK) {
			printf("Error in send_data.\n"); 
			return 1;
		}
#endif

#ifndef EIF_WIN32 
#ifdef  tHAS_SIGSETMASK 
	oldmask = sigblock(sigmask(SIGCLD));
#endif
	m_nwrite = send(m_sock, (char *)buff, *data_length, 0);
#ifdef  tHAS_SIGSETMASK 
	sigsetmask(oldmask);
#endif
	if (m_nwrite != *data_length) { 
#ifdef TEST
		sprintf(loc,"\n%d ERROR in send_data to write %d but wrote %d", getpid(), *data_length, m_nwrite);
		perror(loc);
#endif
		close(m_sock);
		return 1;
	}
#else 
	if (send (m_sock, (char *)buff, *data_length, 0) == SOCKET_ERROR) 
		if ( WSAGetLastError() != EWOULDBLOCK) {
			printf("Error in send_data.\n"); 
			return 1;
		}
#endif

	return 0;
}

							
void do_init();

EIF_INTEGER c_get_host_name(char *buf, int len) {
    int tmp;
#ifdef EIF_WIN32
    do_init();
#endif
    tmp = gethostname(buf, len);
    if (tmp == -1) {
        return -1;
    }

    return 0;
}
                                                             
#ifdef EIF_WIN32
eif_winsock_cleanup()
{
    int err;
    err = WSACleanup ();
    /* bad luck if this is an error ! */
}
void do_init()
{
    WORD wVersionRequested;
    WSADATA wsaData;
    int err;
    static BOOL done = FALSE;

    if (!done)
        {
        wVersionRequested = MAKEWORD (1, 1);
        err = WSAStartup(wVersionRequested, &wsaData);
        if (err != 0)
            {
            fprintf (stderr, "Communications error %d", err);
            /*eraise ("Unable to start WINSOCK", EN_PROG);*/
			exit(1);
            }
/*        eif_register_cleanup (eif_winsock_cleanup); is changhed into: */
		eif_winsock_cleanup();
        }
}
#endif
