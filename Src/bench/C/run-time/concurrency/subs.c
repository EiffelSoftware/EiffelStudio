

/*****************************************************************
	In the C-programs, we use EIF_OBJECT and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#include "eif_cecil.h"
#include "eif_hector.h"

#include "eif_net.h"
#include "eif_curextern.h"


void my_bzero (addr, len) 
char *addr;
int len;
{
	int i;
	for (i=0; i<len; i++)
		*(addr+i) = 0;
}


EIF_INTEGER inttoa(num, buff, buf_len)
int num;
char *buff;
int buf_len;
{
/* change a EIF_INTEGER into string. 
 * Return the length of the streng.
*/
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
			 
EIF_INTEGER longtoa(num, buff, buf_len)
EIF_INTEGER num;
char *buff;
int buf_len;
{
/* change a EIF_INTEGER into string. 
 * Return the length of the streng.
*/
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
			 
EIF_INTEGER realtoa(num, buff, buf_len) 
/* change a FLOAT into string. 
 * Return the length of the streng.
*/
float num;
char *buff;
int buf_len;
{
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
			 
EIF_INTEGER doutoa(num, buff, buf_len)
EIF_DOUBLE num;
char *buff;
int buf_len;
{
/* change a DOUBLE into string. 
 * Return the length of the streng.
*/
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
			 

EIF_INTEGER c_constant_unregister() {
	return constant_unregister;
}

EIF_INTEGER c_integer_type() {
	return Integer_type;
}

int c_constant_sizeofint() {
	return sizeof(EIF_INTEGER);
}
	
int c_constant_sizeofreal() {
	return sizeof(float);
}
	
int c_constant_sizeofdouble() {
	return sizeof(double);
}
	
	
void c_get_host_name() {
	int tmp;
	struct hostent *host;
#ifdef EIF_WIN32
	do_init();
#endif
	tmp = gethostname(_concur_hostname, constant_max_host_name_len);
	if (tmp == -1) {
		sprintf(_concur_crash_info, CURIMPERR9, error_info());
		c_raise_concur_exception(exception_implementation_error);
	}
	host=gethostbyname(_concur_hostname);
	if (!host) {
		sprintf(_concur_crash_info, CURIMPERR21, _concur_hostname, error_info());
		c_raise_concur_exception(exception_implementation_error);
	}
	if ((int)strlen(host->h_name)>=constant_max_host_name_len) {
		strcpy(_concur_crash_info, CURIMPERR18);
		c_raise_concur_exception(exception_implementation_error);
	}
	strcpy(_concur_hostname, host->h_name);
	_concur_hostaddr = htonl(((struct in_addr *)(host->h_addr))->s_addr);
	return;
}

char *c_get_name_from_addr(addr)
EIF_INTEGER addr;
{
	struct hostent *host;
	EIF_INTEGER real_addr = ntohl(addr);
	host=gethostbyaddr((char *)&real_addr, sizeof(EIF_INTEGER), AF_INET);
	if (!host) {
#ifdef EIF_WIN32
		{ struct in_addr tmp;
		tmp.s_addr = addr;
    	return inet_ntoa(tmp);
		}
		/* Because the BUG existed in Windows NT's socket. */
#endif
		sprintf(_concur_crash_info, CURIMPERR19, addr, error_info());
		c_raise_concur_exception(exception_implementation_error);
	}
	return  host->h_name;
}

EIF_INTEGER c_get_addr_from_name(name)
char *name;
{
	struct hostent *host;
	int i, len;
	int is_hostname;

	len = strlen(name);
	for(i=1, is_hostname = 0; i < len && ! is_hostname; i++)	
		if (name[i] != 46) {	
			is_hostname = name[i] < 48 || name[i] > 57; 
		}   
	if (is_hostname) {  
		host=gethostbyname(name);
		if (!host) {
			sprintf(_concur_crash_info, CURIMPERR20, name, error_info());
			c_raise_concur_exception(exception_implementation_error);
		}
		return htonl(((struct in_addr *)(host->h_addr))->s_addr);
	}
	else 
		return htonl(c_concur_net_host_addr(name));

}


char *c_get_current_directory() {
#ifndef EIF_WIN32
	char *tmp;
	
	tmp = (char *)getcwd(_concur_current_dir, constant_max_directory_len);
	if (tmp == NULL ) {
		sprintf(_concur_crash_info, CURIMPERR10, error_info());
		c_raise_concur_exception(exception_implementation_error);
	}
	return tmp;
#else
	DWORD tmp;

	tmp = GetCurrentDirectory((DWORD)constant_max_directory_len,  _concur_current_dir);
	if (tmp == 0) {
		sprintf(_concur_crash_info, CURIMPERR10, error_info());
		c_raise_concur_exception(exception_implementation_error);
	}
	return _concur_current_dir;
#endif
}

int c_get_pid() {
#ifndef EIF_WIN32
	return getpid() % 2000 + 5000;
#else
	return GetCurrentProcessId() % 2000 + 5000;
#endif
}

			 
void set_block(m_sock)
int m_sock;
{
#ifndef EIF_WIN32
	int m_tmp, m_rc; 
	m_tmp = 0; 
	m_rc = ioctl(m_sock,FIONBIO,(char *)&m_tmp);
#else
	u_long arg = 0;
	ioctlsocket (m_sock, FIONBIO, &arg);
#endif  
}
	
			 
void set_non_block(m_sock)
int m_sock;
{
#ifndef EIF_WIN32
	int m_tmp, m_rc; 
	m_tmp = 1; 
	m_rc = ioctl(m_sock,FIONBIO,(char *)&m_tmp);
#else
	u_long arg = 1;
	ioctlsocket (m_sock, FIONBIO, &arg);
#endif  
}
	

int c_try_to_get_command(sock)
long sock;
{
/* Try to get command from a SOCKET.
 * if no data available, return -1;
 * if there is network error, return -3;
 * otherwise, return the request's CODE.
*/
	int tmp;
	EIF_INTEGER str_len;

 	set_non_block(sock);

#ifndef EIF_WIN32 
	tmp = read(sock, &c_cmd, sizeof(EIF_INTEGER));
	if (tmp != sizeof(EIF_INTEGER)) {
		if ((errno && errno!=EWOULDBLOCK) || !tmp) { 
		/* the peer is killed */
			return -3;
		}
		else {
			return -1;
		}
	}
#else 
	if (recv (sock, (char *)&c_cmd, sizeof(EIF_INTEGER), 0) == SOCKET_ERROR)
		return -1;
#endif 
	c_cmd = ntohl(c_cmd);
	set_block(sock);
#ifndef EIF_WIN32
	tmp = read(sock, (char *)&c_para_num, sizeof(EIF_INTEGER));
	if (tmp <=0 ) {
		set_non_block(sock);
		strcpy(_concur_crash_info, CURERR6);
		c_raise_concur_exception(exception_network_connection_crash);
	}
#else 
	if (recv (sock, (char *)&c_para_num, sizeof(EIF_INTEGER), 0) == SOCKET_ERROR) {
		set_non_block(sock);
		strcpy(_concur_crash_info, CURERR6);
		c_raise_concur_exception(exception_network_connection_crash);
	}
#endif 
	c_para_num = ntohl(c_para_num);
	if (c_cmd >= 0) {
#ifndef EIF_WIN32
		tmp = read(sock, (char *)&c_oid, sizeof(EIF_INTEGER));
		if (tmp != sizeof(EIF_INTEGER) ) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		c_oid = ntohl(c_oid);
		tmp = read(sock, (char *)&str_len, sizeof(EIF_INTEGER));
		if (tmp != sizeof(EIF_INTEGER)) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		str_len = ntohl(str_len);
		tmp = read(sock, c_class, str_len);
		if (tmp != str_len ) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		c_class[tmp] = '\0';
		tmp = read(sock, (char *)&str_len, sizeof(EIF_INTEGER));
		if (tmp != sizeof(EIF_INTEGER)) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		str_len = ntohl(str_len);
		tmp = read(sock, c_feature, str_len);
		if (tmp != str_len ) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		c_feature[tmp] = '\0';
		tmp = read(sock, (char *)&c_ack, sizeof(EIF_INTEGER));
		if (tmp != sizeof(EIF_INTEGER) ) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		c_ack = ntohl(c_ack);
#else
		if (recv (sock, (char *)&c_oid, sizeof(EIF_INTEGER), 0) == SOCKET_ERROR) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		c_oid = ntohl(c_oid);
		if (recv (sock, (char *)&str_len, sizeof(EIF_INTEGER), 0) == SOCKET_ERROR) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		str_len = ntohl(str_len);
		if (recv (sock, c_class, str_len, 0) == SOCKET_ERROR) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		c_class[str_len] = '\0';
		if (recv (sock, (char *)&str_len, sizeof(EIF_INTEGER), 0) == SOCKET_ERROR) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		str_len = ntohl(str_len);
		if (recv (sock, c_feature, str_len, 0) == SOCKET_ERROR) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		c_feature[str_len] = '\0';
		if (recv (sock, (char *)&c_ack, sizeof(EIF_INTEGER), 0) == SOCKET_ERROR) {
 			set_non_block(sock);
			strcpy(_concur_crash_info, CURERR6);
			c_raise_concur_exception(exception_network_connection_crash);
		}
		c_ack = ntohl(c_ack);
#endif
	}
	return 1;
}

EIF_INTEGER c_get_command_code() {
	EIF_INTEGER tmp;
	tmp = c_cmd;
	c_cmd = -2;
	return tmp;
}
	
EIF_INTEGER c_get_oid() {
	EIF_INTEGER tmp;
	tmp = c_oid;
	c_oid = -2;
	return tmp;
}
	
EIF_INTEGER c_get_ack() {
	EIF_INTEGER tmp;
	tmp = c_ack;
	c_ack = -2;
	return tmp;
}
	
char *c_get_class_name() {
	return c_class;
}
	
char *c_get_feature_name() {
	return c_feature;
}
	
EIF_INTEGER c_get_para_num() {
	EIF_INTEGER tmp;
	tmp = c_para_num;
	c_para_num = -2;
	return tmp;
}
	

void c_get_usrname() {
#ifndef EIF_WIN32
	char *tmp;
	tmp = (char *)cuserid(_concur_user_name);
#else
	DWORD len = constant_max_user_name_len;
	BOOL ret;
	ret = GetUserName(_concur_user_name, &len);	 
	if (!ret) {
		sprintf(_concur_crash_info, CURIMPERR11, error_info());
		c_raise_concur_exception(exception_implementation_error);
	}
	_concur_user_name[len] = '\0';
#endif
	return;
}

	
void send_signal_to_scoop_dog(pid)
int pid;
{
#ifndef EIF_WIN32
	int tmp;
	if ((tmp = kill(pid, SIGUSR2)) < 0) {
		sprintf(_concur_crash_info, CURIMPERR12, error_info());
		_concur_root_of_the_application = 1;
		c_raise_concur_exception(exception_implementation_error);
	}
#endif
}

EIF_INTEGER c_concur_bind(s, add, length)
long s;
char *add;
long length;
{
	int ret;
	
	ret = bind ((int) s, (struct sockaddr *) add, (int) length);

#ifndef EIF_WIN32
	if (ret) 
		return errno;
#else
	if (ret == SOCKET_ERROR) 
		return WSAGetLastError();
#endif
	else
		return 0;
}

EIF_BOOLEAN c_get_released_server_list() {
	return  _concur_server_list_released;
}

void c_set_released_server_list(val)
EIF_BOOLEAN val;
{
	_concur_server_list_released = val;
}

EIF_BOOLEAN c_get_current_client_reserved() {
	return  _concur_current_client_reserved;
}


void c_set_current_client_reserved(val) 
EIF_BOOLEAN val;
{
	_concur_current_client_reserved = val;
}

	

EIF_INTEGER c_concur_make_client(port, addr)
EIF_INTEGER port;
EIF_INTEGER addr;
{
	int fd;
	struct hostent *hp;
	int i, len;
	
#if defined EIF_WIN32 || defined EIF_OS2
	do_init();
#endif
	fd = socket(AF_INET, SOCK_STREAM, 0);
#if defined EIF_WIN32 || defined EIF_OS2
	if (fd == INVALID_SOCKET) {
#else
	if (fd < 0) {
#endif
		if (_concur_exception_has_happened) 
			return -1;
		else {
			add_nl;
			sprintf(crash_info, CURIMPERR22, error_info()); 
			c_raise_concur_exception(exception_implementation_error);
		}
	}
	my_bzero((char*)&_concur_caddr, sizeof(struct sockaddr_in));
	c_concur_set_host_addr((EIF_POINTER)&(_concur_caddr.sin_addr), ntohl(addr));
	_concur_caddr.sin_family = AF_INET;
	_concur_caddr.sin_port = htons((short)port); 
	
	if (constant_retry_times_for_client == 0) 
		len = 1;
	else
		len = constant_retry_times_for_client;
	for (i = -1; len && i < 0; len--) {
#ifndef EIF_WIN32
		i = connect ((int) fd, (struct sockaddr *) &_concur_caddr, sizeof(struct sockaddr_in));
		if (i < 0 )
			if (errno != EINPROGRESS && errno != ETIMEDOUT) {
				len = 1;
			}
		if (errno == EINPROGRESS) {
				len = 1;
		}
#else
		do_init();
		i = connect ((int) fd, (struct sockaddr *) &_concur_caddr, sizeof(struct sockaddr_in));
		if (i == SOCKET_ERROR) {
			if (WSAGetLastError() == EINPROGRESS || WSAGetLastError() == ETIMEDOUT) {
				len = 1;
			}
		}
#endif
	}
	
	if (i < 0 ) {
		if (_concur_exception_has_happened)
			return -1;
		else {
			if (errno && errno != ETIMEDOUT) {
				add_nl;
				sprintf(crash_info, CURIMPERR13, c_get_name_from_addr(addr), port, error_info());
			}
			else
				if (port == _concur_scoop_dog_port)
					sprintf(_concur_crash_info, CURERR10, c_get_name_from_addr(addr), port, constant_retry_times_for_client);
				else
					sprintf(_concur_crash_info, CURIMPERR14, c_get_name_from_addr(addr), port, constant_retry_times_for_client, error_info());
#ifdef EIF_WIN32
			sprintf(crash_info, "\nWSAError = %d.", WSAGetLastError());
#endif
			c_raise_concur_exception(exception_cant_set_up_connection);
		}
	}
	else {
		c_concur_set_blocking(fd);
		return (EIF_INTEGER)fd;
	}
}

EIF_INTEGER c_concur_make_server(port)
EIF_INTEGER port;
{
	int fd;
	int res;

	fd = c_concur_socket(AF_INET, SOCK_STREAM, 0);
	if (fd < 0) {
		add_nl;
		sprintf(crash_info, CURIMPERR23, error_info()); 
		c_raise_concur_exception(exception_implementation_error);
	}
	my_bzero((char*)&_concur_saddr, sizeof(struct sockaddr_in));
	_concur_saddr.sin_family = AF_INET;
	_concur_saddr.sin_addr.s_addr = INADDR_ANY;
	_concur_saddr.sin_port = htons((short)port); 
	res = c_concur_bind(fd, (char *)(&_concur_saddr), sizeof(struct sockaddr_in));
	if (res)
		return -1;
	c_concur_listen(fd, 5);
	return (EIF_INTEGER)fd;
}

EIF_INTEGER c_concur_accept(s)
EIF_INTEGER s;
{
	int fd;
	int a_length;
	

/*
	fd = c_concur_my_accept(s, (EIF_POINTER)&_concur_caddr, sizeof(_concur_caddr));
*/
	a_length = sizeof(_concur_caddr);
#if defined EIF_WIN32 || defined EIF_OS2
    do_init();
#endif
	fd = accept ((int)s, (struct sockaddr *)(&_concur_caddr), &a_length);

#ifdef EIF_WIN32
    if (fd == SOCKET_ERROR)
        if (WSAGetLastError() != EWOULDBLOCK && !_concur_exception_has_happened) {
			add_nl;
			sprintf(crash_info, CURIMPERR24, error_info());
			c_raise_concur_exception(exception_implementation_error);
		}
		else
			return -1;
#elif defined EIF_OS2
    if (fd == -1)
        if (sock_errno() != SOCEWOULDBLOCK && !_concur_exception_has_happened) {
			add_nl;
			sprintf(crash_info, CURIMPERR24, error_info());
			c_raise_concur_exception(exception_implementation_error);
		} else
			return -1;
#else
    if (fd < 0)
        if (errno != EWOULDBLOCK && !_concur_exception_has_happened) {
			add_nl;
			sprintf(crash_info, CURIMPERR24, error_info());
			c_raise_concur_exception(exception_implementation_error);
		} else
			return -1;
#endif

	return (EIF_INTEGER) fd;
}

EIF_POINTER c_concur_read_stream(sock, len)
EIF_INTEGER sock;
EIF_INTEGER len;
{
	EIF_INTEGER res;
	EIF_INTEGER got=0;

	if (_concur_buffer_len <= len+33) {
		if (_concur_buffer)
			eif_free(_concur_buffer);
		if (len+33 < 1024) 
			_concur_buffer_len = 1024;
		else
			_concur_buffer_len = len + 33;
		_concur_buffer = (EIF_POINTER)eif_malloc(_concur_buffer_len);
		valid_memory(_concur_buffer);
	}
	while (got < len) {
		res = c_concur_my_read_stream(sock, len-got, _concur_buffer+got);
		if (res>0)
			got += res;
		else
			break;
	}
	if (got != len) {
        if (!_concur_exception_has_happened && _concur_command != constant_report_error) {
            add_nl;
            sprintf(crash_info, CURERR6);
            c_raise_concur_exception(exception_network_connection_crash);
        } else {
            sprintf(_concur_buffer+got, "\n[want %4d but got %4d bytes!]", len, got);
            got += 32;
        }
    }
	_concur_buffer[got] = '\0';
	return (EIF_POINTER)_concur_buffer;
}





EIF_POINTER c_get_crash_info() {
	return _concur_crash_info;
}

void c_raise_concur_exception(int type) {
	
	switch (type) {
		case exception_configure_file_not_exist:
			eraise("Resource File Not Exist", CONCURRENT_CRASH);
			break;
		case exception_configure_syntax_error:
			eraise("Resource File Syntax Error", CONCURRENT_CRASH);
			break;
		case exception_unexpected_request:
			eraise("Unexpected Request", CONCURRENT_CRASH);
			break;
		case exception_fail_creating_sep_obj:
			eraise("Can't Create Separate Object", CONCURRENT_CRASH);
			break;
		case exception_network_connection_crash:
			eraise("Network Connection Crashed", CONCURRENT_CRASH);
			break;
		case exception_implementation_error:
			eraise("Concurrent Error", CONCURRENT_CRASH);
			break;
		case exception_invalid_parameter:
			eraise("Invalid Parameter", CONCURRENT_CRASH);
			break;
		case exception_cant_set_up_connection:
			eraise("Can't Setup Network Connection", CONCURRENT_CRASH);
			break;
		case exception_out_of_memory:
			eraise("Out of Memory", CONCURRENT_CRASH);
			break;
		case exception_void_separate_object:
			eraise("Void Separate Object", CONCURRENT_CRASH);
			break;
		case exception_invalid_separate_object:
			eraise("Invalid Separate Object", CONCURRENT_CRASH);
			break;
		default:
			eraise("Concurrent Exception", CONCURRENT_CRASH);
			break;
	}
}

void c_reset_timer() {
#ifdef GC_ON_CPU_TIME
	double systimes;
	getcputime(&_concur_begin_tms, &systimes);
#else
	gettime(&_concur_begin_tms);
#endif
}

EIF_DOUBLE c_wait_time() {
/* return the length of CPU time/absolute time between last call 
 * of "c_reset_timer" and present in macro-seconds(0.001 second).
*/
#ifdef GC_ON_CPU_TIME
	double systimes;
	double _concur_end_tms;
	getcputime(&_concur_end_tms, &systimes);
	
	return (_concur_end_tms - _concur_begin_tms)*1000.0;
#else
	Timeval _concur_end_tms;
	gettime(&_concur_end_tms);
	return (EIF_DOUBLE)elapsed(&_concur_begin_tms, &_concur_end_tms) * 10.0;	
#endif
}

void c_process_ser_list_from_sep_obj(hosta, pid, sock)
EIF_INTEGER hosta;
EIF_INTEGER pid;
EIF_INTEGER sock;
{
/* when a SEP_OBJ proxy is to be collected by GC, the function is called,
 * so that the SERVER_LIST is adjusted.
*/
	SERVER *ser, *tmp;
	

	for(tmp=NULL, ser=_concur_ser_list; ser && ser->sock!=sock; tmp=ser, ser=ser->next);
	if (ser) {
		(ser->count)--;
		if (!ser->count) {
			if (sock>=0)
				c_concur_close_socket(sock);
			if (tmp) 
				tmp->next = ser->next;
			else
				_concur_ser_list = ser->next;	
			if (_concur_end_of_ser_list == ser)
				_concur_end_of_ser_list = tmp;
			eif_free(ser);
			(_concur_ser_list_count)--;
		}
/*
		else
			printf("$$$$ After c_p_ser_list_from_sep(%s, %d, %d) count=%d\n", c_get_name_from_addr(hosta), pid, sock, ser->count);
*/
	}
	else
		printf("!!!! Error Happened in  c_p_ser_list_from_sep(%s, %d, %d)\n", c_get_name_from_addr(hosta), pid, sock);
	
/*
	printf("$$$$ After c_p_ser_list_from_sep(%s, %d, %d) server_count=%d, cli_list_count=%d\n", hostname, pid, sock, _concur_ser_list_count, _concur_cli_list_count);
*/
}

/*
void c_concur_put_stream (fd, s, l)
EIF_INTEGER fd;
EIF_OBJECT s;
EIF_INTEGER l;
{
EIF_INTEGER tmp;
	c_concur_set_blocking(fd);
#ifndef EIF_WIN32
if (l>2000)
printf("%d To Send %d bytes(%d).\n", _concur_pid, l, errno);
	if (tmp=write ((int)fd, (char *)s, (int)l) < 0)
		if (errno != EWOULDBLOCK)
			eio();
if (l>2000)
printf("%d Just Sent %d bytes(%d). err=%d\n", _concur_pid, tmp, l, errno);
#else
	if (send (fd, s, l, 0) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
}
*/

void cur_usleep(tout)
EIF_INTEGER tout;
/* the time out period in micro second */
{
	int ret;
	int to_second = tout / 1000000;
	int to_micsec = tout % 1000000;
	fd_set tmp_mask;
	
	if (tout) {
#ifdef EIF_WIN32
		FD_ZERO(&tmp_mask);
		FD_SET(_concur_sock, &tmp_mask);
		c_concur_select(ret, 1, &tmp_mask, NULL, NULL, to_second, to_micsec);
#else
		c_concur_select(ret, 1, NULL, NULL, NULL, to_second, to_micsec);
#endif
	}
}


/**********************************************************************************
 * The following functions are utilities provided by class CONCURRENCY to user    *
 * so that he/she can set system's options and turn up the system's performance.  *
***********************************************************************************/

void cur_set_with_rejection() {
	set_with_rejection;
}

void cur_unset_with_rejection() {
	unset_with_rejection;
}

void cur_set_daemon_port(EIF_INTEGER port) {
	_concur_scoop_dog_port = port;
}

void cur_set_sleeping_time_of_reserve_sep_para(EIF_INTEGER to) {
	if (to < 0) 
		_concur_waiting_time_of_rspf = constant_waiting_time_in_reservation;
	else
		_concur_waiting_time_of_rspf = to;
}

void cur_set_sleeping_time_of_precondition (EIF_INTEGER to) {
	if (to < 0) 
		_concur_waiting_time_of_cspf = constant_waiting_time_in_precondition;
	else
		_concur_waiting_time_of_cspf = to;
}

EIF_INTEGER cur_port_of_local_server() {
	return _concur_pid;
}

void cur_set_gc_on_cpu() {
/*
	set_gc_on_cpu;
*/
}

void cur_unset_gc_on_cpu() {
/*
	unset_gc_on_cpu;
*/
}

void cur_set_gc_period(EIF_INTEGER gcp) {
/*
	if (gcp<0) {
		if (gc_on_cpu)
			_concur_gc_period = 10*constant_cpu_period;
		else
			_concur_gc_period = constant_absolute_period;
	}	
	else 
		_concur_gc_period = gcp;
*/
}

EIF_OBJECT cur_deep_import(EIF_OBJECT s_obj) {
	int i, fd;

	if (!s_obj) 
		return NULL;
	if (on_local_processor(eif_access(s_obj))) {
		/* now, deep clone the local object */
		return edclone(CURPROXY_OBJ(eif_access(s_obj)));
	} else {
		CURRSO(eif_access(s_obj));
		CURSARI(constant_execute_procedure, oid_of_sep_obj(eif_access(s_obj)), constant_deep_import, "_no_class", "_no_feature", 0);
		CURSG(eif_access(s_obj));
		CURFSO(eif_access(s_obj));
		return CURGO(0);		
	}
}
