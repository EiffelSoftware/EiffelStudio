
/*****************************************************************
    In the C-programs, we use EIF_OBJ and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#define tTEST
#define tTEST_CON
#define tDISP_MSG

#undef DISP_MSG

#ifdef TEST
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#else
#ifdef TEST_CON
#include "curserver.h"
#else
#include "net.h"
#include "curextern.h"
#endif

/*    The following two macros basically do the same thing, they are  
 * used to skip over the lines(with the leading
 * and ending blanks/tabs deleted first) whose length is less than 2 
 * and the comment lines(whose two leading characters are "--".
 *    The difference is that one has a parameter, the other does not.
*/

/* the macro is used in function "con_make" */
#define go_to_next_valuable_line(x) {\
	for(stop=x; !stop; ) {\
		end_of_file = read_a_line(fd, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line);\
		adjust_a_line(cur_raw_line, cur_line);\
		stop = end_of_file || valuable_line(cur_line);\
	}\
}

/* the macro is used in other functions in the file */
#define skip_to_next_valuable_line {\
	for(stop_line=0; !stop_line; ) {\
		*end_of_file = read_a_line(fd, buf, buf_idx, constant_size_of_data_buf, buf_data_len, cur_raw_line);\
		adjust_a_line(cur_raw_line, cur_line);\
		stop_line = *end_of_file || valuable_line(cur_line);\
	}\
}

void print_config();

void con_make(conf_file)
char *conf_file;
{
/* read the information of CONFIGURE file into system. If no configure file
 * is defined(conf_file==NULL), use the local host as the only source to
 * dispatch separate objects.
*/

	/* working variable */
	int line_idx;
	/* a line read from file directly */
	char cur_raw_line[constant_size_of_line_buf]; 
	/* a line packed the leading/ending blank/tab from "cur_raw_line */
	char cur_line[constant_size_of_line_buf]; 
	/* buffer used to read data from file */
	char buf[constant_size_of_data_buf];
	/* indicate which byte is the next one to be read in the data buffer */
	int buf_idx = 0; 
	/* the length of valid data in the data buffer */
	int buf_data_len = 0;
	/* file descriptor for the configure file */
	int fd;
	/* if the end of the configure file is met */
	char end_of_file;
	/* the following are working variables */
	int stop;
	char tmp_buf[20];
	int tmp_int;

	/* the following initialize the global variables */
	_concur_rem_ser_size = constant_num_of_remote_servers;
	_concur_rem_sers = (REMOTE_SERVER *)malloc(_concur_rem_ser_size*sizeof(REMOTE_SERVER));
	valid_memory(_concur_rem_sers);
	_concur_rem_ser_count = 0;

	_concur_host_size = constant_num_of_hosts; 
	_concur_hosts = (RESOURCE *)malloc(_concur_host_size*sizeof(RESOURCE));
	valid_memory(_concur_hosts);
	_concur_host_count = 0;
	for(stop=0; stop<_concur_host_size; stop++) {
		_concur_hosts[stop].executable[0] = '\0';
	}

	_concur_host_level_size = constant_num_of_host_levels;
	_concur_host_levels = (RESOURCE_LEVEL *)malloc(_concur_host_level_size*sizeof(RESOURCE_LEVEL));
	valid_memory(_concur_host_levels);
	_concur_host_level_count = 0;

	/* begin read configure information from the file */
	if (conf_file == NULL) {
		get_remote_servers(-1, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);
		get_network_resources(-1, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);
	}
	else {
		fd = open(conf_file, O_RDONLY);
		if (fd<0) {
			add_nl;
			sprintf(crash_info, CURAPPERR13, conf_file);
			c_raise_concur_exception(exception_configure_file_not_exist);
		}
		
		go_to_next_valuable_line(0);
		
		if (!end_of_file) {
			memcpy(tmp_buf, cur_line, 8);
			for(tmp_int=0; tmp_int<8; tmp_int++) 
				tmp_buf[tmp_int] = tolower(tmp_buf[tmp_int]);
			if (!memcmp(tmp_buf, "creation", 8)) {
				get_network_resources(fd, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);

				if (!end_of_file) {
					stop = valuable_line(cur_line); 
					go_to_next_valuable_line(stop);
				}
				if (!end_of_file && (int)strlen(cur_line) < 7) {
					add_nl;
					sprintf(crash_info, CURAPPERR37, cur_raw_line);
					c_raise_concur_exception(exception_configure_syntax_error);
				}
				if (!end_of_file) {
					memcpy(tmp_buf, cur_line, 7);
					for(tmp_int=0; tmp_int < 7; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++); 
					tmp_buf[7] = '\0';
					if (strcmp(tmp_buf, "default")) {
						if (!end_of_file) 
							get_remote_servers(fd, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);
						else
							get_remote_servers(-1, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);
	
						if (!end_of_file) {
							stop = valuable_line(cur_line); 
							go_to_next_valuable_line(stop);
						}
					}
				}
				if (!end_of_file) 
					get_default_values(fd, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);
			}
			else {
				get_remote_servers(fd, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);

				if (!end_of_file) {
					stop = valuable_line(cur_line); 
					go_to_next_valuable_line(stop);
				}
				if (!end_of_file) 
					get_network_resources(fd, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);
				else
					get_network_resources(-1, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);

				if (!end_of_file) {
					stop = valuable_line(cur_line); 
					go_to_next_valuable_line(stop);
				}
				if (!end_of_file) 
					get_default_values(fd, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);
	
			}
			
		}
		else {
			get_remote_servers(-1, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);
			get_network_resources(-1, buf, &buf_idx, constant_size_of_data_buf, &buf_data_len, cur_raw_line, cur_line, &end_of_file);
		}

		close(fd);
	}

	post_process();
#ifdef DISP_MSG
print_config();/**/
#endif
}

post_process() {
	int idx, ind;

	_concur_resource_index = -1;
	for(idx=0; idx<_concur_host_count; idx++) {
		if (!strlen(_concur_hosts[idx].host) || !strlen(_concur_hosts[idx].directory)) {
			sprintf(_concur_crash_info, CURAPPERR21, _concur_hosts[idx].host, _concur_hosts[idx].directory);	
			c_raise_concur_exception(exception_configure_syntax_error);
		}
		if (_concur_hosts[idx].executable[0] == '\0') {
			for(ind=strlen(_concur_hosts[idx].directory); ind>=0 && _concur_hosts[idx].directory[ind] != '\\' && _concur_hosts[idx].directory[ind] != '/'; ind--);
			if (ind<0) {
				add_nl;
				sprintf(crash_info, CURAPPERR35, _concur_hosts[idx].host, _concur_hosts[idx].directory);
				c_raise_concur_exception(exception_configure_syntax_error);
			}
			strcpy(_concur_hosts[idx].executable, _concur_hosts[idx].directory+ind+1);
			_concur_hosts[idx].directory[ind+1] = '\0';
			if (_concur_hosts[idx].executable[0] == '\0') {
				add_nl;
				sprintf(crash_info, CURAPPERR36, _concur_hosts[idx].host, _concur_hosts[idx].directory);
				c_raise_concur_exception(exception_configure_syntax_error);
			}
		}
		if (_concur_hosts[idx].capability > 0 && _concur_resource_index < 0)
			_concur_resource_index = idx;
	}
	_concur_resource_count = 0;

}

void get_default_values(fd, buf, buf_idx, size_of_data_buf, buf_data_len, cur_raw_line, cur_line, end_of_file)
int fd;
char *buf;
int *buf_idx;
int size_of_data_buf;
int *buf_data_len;
char *cur_raw_line;
char *cur_line;
char *end_of_file;
{
/* Precondition: fd >= 0 */
/* Read information about DEFAULT values from the configure file. */
	int port, instance;
	char stop, stop_line;
	char num_str[constant_max_len_of_int_in_str+1];
	int tmp_int;
	int len;
	char tmp_buf[20];
	int idx;
	int line_idx;

	/* get rid of "default" */
	memcpy(tmp_buf, cur_line, 7);
	for(tmp_int=0; tmp_int < 7; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++); 
	if (memcmp(tmp_buf, "default", 7)) {
		add_nl;
		sprintf(crash_info, CURAPPERR14, cur_raw_line);
		c_raise_concur_exception(exception_configure_syntax_error);
	}
	
	port = -1;
	instance = -1;
	
	skip_to_next_valuable_line;

	if (*end_of_file) {
		strcat(_concur_crash_info, CURAPPERR15);	
		c_raise_concur_exception(exception_configure_syntax_error);
	}
	
	memcpy(tmp_buf, cur_line, 3);
	for(tmp_int=0; tmp_int < 3; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++); 
	stop = !memcmp(tmp_buf, "end", 3) && strlen(cur_line)==3;

	for(idx=2; !stop && idx; idx--) {
		len = strlen(cur_line);
		/* Get default value's NAME */
		for(line_idx=0; line_idx<len && cur_line[line_idx]!=':' && line_idx<8; tmp_buf[line_idx]=cur_line[line_idx], line_idx++);
		tmp_buf[line_idx] = '\0';
		/* skip to NUMBER */
		for(; line_idx<len && (cur_line[line_idx]<'0' || cur_line[line_idx]>'9'); line_idx++);
		/* Get NUMBER */
		for(tmp_int=0; line_idx<len && cur_line[line_idx]>='0' && cur_line[line_idx]<='9';num_str[tmp_int]=cur_line[line_idx], tmp_int++, line_idx++);
		num_str[tmp_int] = '\0';

		if (!tmp_int || line_idx<len) {
			sprintf(_concur_crash_info, CURAPPERR16, cur_raw_line);	
			c_raise_concur_exception(exception_configure_syntax_error);
		}
	
		for(tmp_int=strlen(tmp_buf)-1; tmp_int>=0; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int--);
		if (!memcmp(tmp_buf, "port", 4)) 
			port = atoi(num_str);
		else if (!memcmp(tmp_buf, "instance", 8)) 
			instance = atoi(num_str);
		else {
			sprintf(_concur_crash_info, CURAPPERR17, cur_raw_line);	
			c_raise_concur_exception(exception_configure_syntax_error);
		}

		skip_to_next_valuable_line;
		if (*end_of_file) {
			strcat(_concur_crash_info, CURAPPERR18);	
			c_raise_concur_exception(exception_configure_syntax_error);
		}
	
		memcpy(tmp_buf, cur_line, 3);
		for(tmp_int=0; tmp_int < 3; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++); 
		stop = !memcmp(tmp_buf, "end", 3) && strlen(cur_line)==3 ;
	}

	if (!stop) {
		sprintf(_concur_crash_info, CURAPPERR18, cur_raw_line);	
		c_raise_concur_exception(exception_configure_syntax_error);
	}

	skip_to_next_valuable_line;
	if (!*end_of_file) {
		sprintf(_concur_crash_info, CURAPPERR19, cur_raw_line);	
		c_raise_concur_exception(exception_configure_syntax_error);
	}
	
	
#ifdef DISP_MSG
printf("\nNow, Remote Servers:\n");
#endif
	for(idx=0; idx<_concur_rem_ser_count; idx++) {
#ifdef DISP_MSG
printf("<%s, %s, %d>", _concur_rem_sers[idx].name, _concur_rem_sers[idx].host, _concur_rem_sers[idx].port);
#endif
		if (_concur_rem_sers[idx].port < 0)
			_concur_rem_sers[idx].port = port;
#ifdef DISP_MSG
printf("(%d)\n", _concur_rem_sers[idx].port);
#endif
		if (_concur_rem_sers[idx].port <= 0 || !strlen(_concur_rem_sers[idx].host)) {
			sprintf(_concur_crash_info, CURAPPERR20, _concur_rem_sers[idx].name, _concur_rem_sers[idx].host, _concur_rem_sers[idx].port);	
			c_raise_concur_exception(exception_configure_syntax_error);
		}
			
	}

#ifdef DISP_MSG
printf("\nNow, Host Level:\n");
	for(idx=0; idx<_concur_host_level_count; idx++) {
printf("<%s,  %d>\n", _concur_host_levels[idx].name, (_concur_host_levels[idx]).indicator);
	}
#endif

#ifdef DISP_MSG
printf("\nNow, Network Resources:\n");
#endif
	for(idx=0; idx<_concur_host_count; idx++) {
#ifdef DISP_MSG
printf("<%s, %d, %s>", _concur_hosts[idx].host, _concur_hosts[idx].capability, _concur_hosts[idx].directory);
#endif
		if (!_concur_hosts[idx].capability)
			_concur_hosts[idx].capability = instance;
#ifdef DISP_MSG
printf("(%d)\n", _concur_hosts[idx].capability);
#endif
		if (!strlen(_concur_hosts[idx].host) || !strlen(_concur_hosts[idx].directory)) {
			sprintf(_concur_crash_info, CURAPPERR21, _concur_hosts[idx].host, _concur_hosts[idx].directory);	
			c_raise_concur_exception(exception_configure_syntax_error);
		}
	}

	for(idx=0; idx<_concur_host_count && _concur_hosts[idx].capability<=0; idx++);
	if (idx == _concur_host_count) {
			strcat(_concur_crash_info, CURAPPERR22);	
			c_raise_concur_exception(exception_configure_syntax_error);
	}
	
#ifdef DISP_MSG
printf("------- Default.port=%d, instance=%d\n", port, instance);
#endif
}


void get_remote_servers(fd, buf, buf_idx, size_of_data_buf, buf_data_len, cur_raw_line, cur_line, end_of_file)
int fd;
char *buf;
int *buf_idx;
int size_of_data_buf;
int *buf_data_len;
char *cur_raw_line;
char *cur_line;
char *end_of_file;
{
/* Precondition: fd>0 */
/* Read information about REMOTE SERVER from the configure file. */
	char port_str[constant_max_len_of_int_in_str+1];
	char tmp_buf[20];
	int tmp_int;
	int line_idx;
	int len;
	char stop, stop_line;
	int index;
		

	if (fd < 0) {
		_concur_rem_ser_count = 0;
	}
	else {
		/* get rid of "external" */
		memcpy(tmp_buf, cur_line, 8);
		for(tmp_int=0; tmp_int < 8; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++); 
		if (memcmp(tmp_buf, "external", 8) || strlen(cur_line)!=8) {
			sprintf(_concur_crash_info, CURAPPERR23, cur_raw_line);
			c_raise_concur_exception(exception_configure_syntax_error);
		}
		
		for(index=0, stop=0; !stop && !*end_of_file; index++ ) {
			skip_to_next_valuable_line;
			if (!*end_of_file) {
				adjust_a_line(cur_raw_line, cur_line);
				memcpy(tmp_buf, cur_line, 3);
				for(tmp_int=strlen(tmp_buf)-1; tmp_int>=0; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int--);
				stop = !memcmp(tmp_buf, "end", 3) && strlen(cur_line)==3;
				if (!stop) {
					for(tmp_int=strlen(cur_line)-1; tmp_int>=0 && cur_line[tmp_int]!=':'; tmp_int--);
					if (tmp_int<0) {
						sprintf(_concur_crash_info, CURAPPERR24, cur_raw_line);
						c_raise_concur_exception(exception_configure_syntax_error);
					}
				}
				else {
					skip_to_next_valuable_line;
					break;
				}
			}
			else
				break;

			line_idx = 0;
			len = strlen(cur_line);
		
			/* Get SERVER NAME */
			for (tmp_int=0; line_idx<len && cur_line[line_idx]!=':'; ) {
				_concur_rem_sers[index].name[tmp_int] = cur_line[line_idx];
				tmp_int++; line_idx++;
			}
			_concur_rem_sers[index].name[tmp_int] = '\0';

			/* skip to MACHINE NAME */
			for(line_idx++; line_idx<len && cur_line[line_idx]!='"'; line_idx++);	

			/* get MACHINE NAME */
			for(line_idx++, tmp_int=0; line_idx<len && cur_line[line_idx]!='"'; ) {
				_concur_rem_sers[index].host[tmp_int] = cur_line[line_idx];
				tmp_int++; line_idx++;
			}
			_concur_rem_sers[index].host[tmp_int] = '\0';

			/* skip to PORT NUMBER */
			for(line_idx++; line_idx<len && (cur_line[line_idx]<'0' || cur_line[line_idx]>'9'); line_idx++);	

			/* get PORT NUMBER */
			for(tmp_int=0; line_idx<len && cur_line[line_idx]>='0' && cur_line[line_idx]<='9'; ) {
				port_str[tmp_int] = cur_line[line_idx];
				tmp_int++; line_idx++;
			}
			port_str[tmp_int] = '\0';
			if (tmp_int) 
				_concur_rem_sers[index].port = atoi(port_str);
			else
				_concur_rem_sers[index].port = -1;

		}

		if (!stop) {
			sprintf(_concur_crash_info, CURAPPERR25, cur_raw_line);
			c_raise_concur_exception(exception_configure_syntax_error);
		}
		
		_concur_rem_ser_count = index;
		
	}
}


void get_network_resources(fd, buf, buf_idx, size_of_data_buf, buf_data_len, cur_raw_line, cur_line, end_of_file)
int fd;
char *buf;
int *buf_idx;
int size_of_data_buf;
int *buf_data_len;
char *cur_raw_line;
char *cur_line;
char *end_of_file;
{
/* Precondition: fd>0 */
/* Read information about NETWORK RESOURCEs from the configure file. */
	char port_str[constant_max_len_of_int_in_str+1];
	int level_idx;
	char localhost[constant_max_host_name_len+1];
	char localdir[constant_max_directory_len+1];
	char tmp_buf[20];
	int tmp_int;
	int line_idx;
	int len;
	char stop, substop, stop_line;
	int index;
	char at_least_one_host;
		
	/* Now, we begin to read information from Configure File */
	if (fd < 0) {
		_concur_host_level_count = 0;
		_concur_host_count = 1;
		/* c_get_host_name(); */
		strcpy(_concur_hosts[0].host, _concur_hostname);
		_concur_hosts[0].capability = 1;
		strcpy(_concur_hosts[0].directory, c_get_current_directory());
		strcpy(_concur_hosts[0].executable, _concur_executable);
		return;
	}
	
	/* get rid of "creation" */
    memcpy(tmp_buf, cur_line, 8);
    for(tmp_int=0; tmp_int < 8; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++);
	if (memcmp(tmp_buf, "creation", 8) || strlen(cur_line)!=8) {
		sprintf(_concur_crash_info, CURAPPERR26, cur_raw_line);
		c_raise_concur_exception(exception_configure_syntax_error);
	}


	skip_to_next_valuable_line;
	
	index = 0;
	level_idx = 0;
	for (stop=0; !stop && !*end_of_file; ) {
		memcpy(tmp_buf, cur_line, 3);
		for(tmp_int=0; tmp_int < 3; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++);
		stop = !memcmp(tmp_buf, "end", 3) && strlen(cur_line)==3;
		if (stop) {
			skip_to_next_valuable_line;
			break;
		}

		/* get Level Name */
		for(line_idx=0, len=strlen(cur_line), tmp_int=0; line_idx<len && cur_line[line_idx]!=':'; ) {
                _concur_host_levels[level_idx].name[tmp_int] = cur_line[line_idx];
                tmp_int++; line_idx++;
        }
		if (!stop && line_idx<len && cur_line[line_idx]==':') {	
	        _concur_host_levels[level_idx].name[tmp_int] = '\0';
	        _concur_host_levels[level_idx].indicator = index;
			level_idx++;
		}
		else {
			sprintf(_concur_crash_info, CURAPPERR27, cur_raw_line);
			c_raise_concur_exception(exception_configure_syntax_error);
		}

		/* skip to next VALUABLE line */
		skip_to_next_valuable_line;

		if (*end_of_file) 
			break;

		/* get rid of SYSTEM */
		memcpy(tmp_buf, cur_line, 6);
		for(tmp_int=0; tmp_int < 6; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++);
		if (memcmp(tmp_buf, "system", 6) || strlen(cur_line)!=6) {
			sprintf(_concur_crash_info, CURAPPERR28, cur_raw_line);
			c_raise_concur_exception(exception_configure_syntax_error);
		}


		/* skip to next VALUABLE line */
		skip_to_next_valuable_line;

		if (*end_of_file) 
			break;

		at_least_one_host = 0;
		for (substop=0; !stop && !(substop || *end_of_file); ) {
			memcpy(tmp_buf, cur_line, 3);
			for(tmp_int=0; tmp_int < 3; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++);
			substop = !memcmp(tmp_buf, "end", 3) && strlen(cur_line)==3;

			if (substop) {
				skip_to_next_valuable_line;
				break;
			}

			at_least_one_host = 1;
			line_idx = 0;
			len = strlen(cur_line);

			/* skip to HOST NAME */
			if (line_idx>=len || cur_line[line_idx]!='"') {
				sprintf(_concur_crash_info, CURAPPERR29, cur_raw_line);
				c_raise_concur_exception(exception_configure_syntax_error);
			}
/*
			for(; line_idx<len && cur_line[line_idx]!='"'; line_idx++);
*/

			if (line_idx>=len) {
				sprintf(_concur_crash_info, CURAPPERR30, cur_raw_line);
				c_raise_concur_exception(exception_configure_syntax_error);
			}

			/* get HOST NAME */
			for(line_idx++, tmp_int=0; line_idx<len && cur_line[line_idx]!='"'; line_idx++, tmp_int++) 
				_concur_hosts[index].host[tmp_int] = cur_line[line_idx];
			_concur_hosts[index].host[tmp_int] = '\0';

			/* skip to NUMBER */
/*
			for(line_idx++; line_idx<len && (cur_line[line_idx]<'0' || cur_line[line_idx]>'9') && cur_line[line_idx]!=':'; line_idx++);
*/
			for(line_idx++; line_idx<len && cur_line[line_idx]!='(' && cur_line[line_idx]!=':'; line_idx++);

			if (line_idx>=len) {
				sprintf(_concur_crash_info, CURAPPERR31, cur_raw_line);
				c_raise_concur_exception(exception_configure_syntax_error);
			}

			/* get NUMBER */
			if (line_idx<len && cur_line[line_idx]==':') 
				_concur_hosts[index].capability = 0;
			else {
				for(tmp_int=0, line_idx++; !substop && line_idx<len && ((cur_line[line_idx]>='0' && cur_line[line_idx]<='9') || cur_line[line_idx]=='-'); line_idx++, tmp_int++)
					 port_str[tmp_int] = cur_line[line_idx];
				port_str[tmp_int] = '\0';
				_concur_hosts[index].capability = atoi(port_str);
			}


			/* skip to DIRECTORY */
			for(; line_idx<len && cur_line[line_idx]!='"'; line_idx++);

			if (line_idx>=len) {
				sprintf(_concur_crash_info, CURAPPERR32, cur_raw_line);
				c_raise_concur_exception(exception_configure_syntax_error);
			}

			/* get DIRECTORY */
			for(line_idx++, tmp_int=0; line_idx<len && cur_line[line_idx]!='"'; line_idx++,tmp_int++)
				_concur_hosts[index].directory[tmp_int] = cur_line[line_idx];
			_concur_hosts[index].directory[tmp_int] = '\0';


			index++;

			/* skip to next valuable line */
			skip_to_next_valuable_line;
		}

		if (!at_least_one_host) {
			sprintf(_concur_crash_info, CURAPPERR33, cur_raw_line);
			c_raise_concur_exception(exception_configure_syntax_error);
		}
		if (!substop) {
			sprintf(_concur_crash_info, CURAPPERR34, cur_raw_line);
			c_raise_concur_exception(exception_configure_syntax_error);
		}
	}

	if (!stop) {
		sprintf(_concur_crash_info, CURAPPERR34, cur_raw_line);
		c_raise_concur_exception(exception_configure_syntax_error);
	}

	_concur_host_level_count = level_idx;
	_concur_host_count = index;

	if (!_concur_host_count) {
		_concur_host_level_count = 0;
		_concur_host_count = 1;
		strcpy(_concur_hosts[0].host, _concur_hostname);
		_concur_hosts[0].capability = 1;
		strcpy(_concur_hosts[0].directory, c_get_current_directory());
#if defined EIF_WIN32 || defined EIF_OS2
		strcat(_concur_hosts[0].directory, "\\");
#else
		strcat(_concur_hosts[0].directory, "/");
#endif
		strcat(_concur_hosts[0].directory, _concur_executable);
	}

	return;
}

void print_config() {
	EIF_INTEGER idx;
	
printf("\nNow, Remote Servers:\n");
	for(idx=0; idx<_concur_rem_ser_count; idx++) {
printf("<%s, %s, %d>\n", _concur_rem_sers[idx].name, _concur_rem_sers[idx].host, _concur_rem_sers[idx].port);
	}

printf("\nNow, Host Level:\n");
	for(idx=0; idx<_concur_host_level_count; idx++) {
printf("<%s,  %d>\n", _concur_host_levels[idx].name, (_concur_host_levels[idx]).indicator);
	}

printf("\nNow, Network Resources:\n");
	for(idx=0; idx<_concur_host_count; idx++) {
printf("<%s, %d, %s, %s>\n", _concur_hosts[idx].host, _concur_hosts[idx].capability, _concur_hosts[idx].directory, _concur_hosts[idx].executable);
	}
printf("\n");
}



char *dispatch_to() {
/* return the host(its name or IP address) to which the next separate 
 * object will be dispatched.
*/

	_concur_dispatched_host = _concur_hosts[_concur_resource_index].host;
	_concur_dispatched_directory = _concur_hosts[_concur_resource_index].directory;
	_concur_dispatched_executable = _concur_hosts[_concur_resource_index].executable;
	_concur_resource_count++;
	for (;_concur_resource_count >= _concur_hosts[_concur_resource_index].capability;) {
		_concur_resource_count = 0;
		_concur_resource_index = (_concur_resource_index+1) % _concur_host_count;
	}
	return _concur_dispatched_host;
}


void reset_by_host(name)
char *name;
{
/* reset the CURSOR(used for dispatching separate objects) to the 
 * host with the name.
*/
	int idx;

	for(idx=0; idx<_concur_host_count && memcmp(_concur_hosts[idx].host, name, strlen(name)); idx++);
	if (idx<_concur_host_count) {
	/* The host name does  exist! */
		_concur_resource_index = idx;
		_concur_resource_count = 0;
		for (;_concur_resource_count >= _concur_hosts[_concur_resource_index].capability;) {
			_concur_resource_count = 0;
			_concur_resource_index = (_concur_resource_index+1) % _concur_host_count;
		}
	}
	return;
}


void reset_by_level(name)
char *name;
{
/* reset the CURSOR(used for dispatching separate objects) to the 
 * first host in the host level indicated by the given level name.
*/
	int idx;

	for(idx=0; idx<_concur_host_level_count && memcmp(_concur_host_levels[idx].name, name, strlen(name)); idx++);
	if (idx<_concur_host_level_count) {
	/* The level name does  exist! */
		_concur_resource_index = _concur_host_levels[idx].indicator;
		_concur_resource_count = 0;
		for (;_concur_resource_count >= _concur_hosts[_concur_resource_index].capability;) {
			_concur_resource_count = 0;
			_concur_resource_index = (_concur_resource_index+1) % _concur_host_count;
		}
	}
	return;	
}



#ifdef TEST_CON

eio(){
	printf("Exit from eio()\n");
	exit(1);
}

void eraise(){
	print_config();
	printf("%s\n", _concur_crash_info);
	printf("Exit from eraise()\n");
	exit(1);
}

EIF_POINTER makestr(){
	printf("Exit from makestr()\n");
	exit(1);
}

main() {
	int idx;

	con_make("conf");


	printf("\nresource_index=%d, count=%d\n", _concur_resource_index, _concur_resource_count);
	reset_by_host("lannion");
	printf("After reset by 'lannion':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

	reset_by_host("authen");
	printf("After reset by 'authen':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

	reset_by_host("1lannion");
	printf("After reset by '1lannion':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

	reset_by_level("middle_machine");
	printf("After reset by 'middle_machine':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

	reset_by_level("fast_machine");
	printf("After reset by 'fast_machine':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

	reset_by_level("1fast_machine");
	printf("After reset by '1fast_machine':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

	for(idx=0; idx<20; idx++) 
	printf("%dth <%s, %s>\n", idx, dispatch_to(), _concur_dispatched_directory);

	
}
#endif
#endif

void adjust_a_line(raw, processed)
char *raw;
char *processed;
{
/* delete the leading & ending space/tab from RAW line and put the
 * processed line into PROCESSED.
*/
	int len = strlen(raw);
	int idx1, idx2;

#ifdef EIF_WIN32
	if (len && raw[len-1]=='\r')
		len--;
#endif
	for(idx1=len-1; idx1>=0 && (raw[idx1]==' ' || raw[idx1]=='\t'); idx1--);
	raw[idx1+1] = '\0';
	len = strlen(raw);
	for(idx1=0; idx1<len && (raw[idx1]==' ' || raw[idx1]=='\t'); idx1++); 
	for(idx2=0; idx1<len; idx1++, idx2++)
		processed[idx2] = raw[idx1];
	processed[idx2] = '\0';
	return;	
}


char read_a_line(fd, buf, buf_idx, buf_size, buf_data_len, line_buf)
int fd;
char *buf;
int *buf_idx;
int buf_size;
int *buf_data_len;
char *line_buf;
{
/* Read a line from a file. */
/* we assume that "line_buf"(now set to be constant_size_of_line_buf(=1024)
 * is big enough to contain any line in configure file.
*/
	int idx=0;
	int count;
	int end_of_file = 0;

	for(; *buf_idx<*buf_data_len && buf[*buf_idx]!='\n'; (*buf_idx)++, idx++) 
		line_buf[idx] = buf[*buf_idx];		
	if (*buf_idx<*buf_data_len && buf[*buf_idx]=='\n') {
		(*buf_idx)++;
		line_buf[idx] = '\0';		
		return 0;
	}
	
	for(; !end_of_file && *buf_idx == *buf_data_len; ) {
		count = read(fd, buf, buf_size);
		if (count < 0)
			return count;
		if (count < buf_size)
			end_of_file = 1;
		*buf_idx = 0;
		*buf_data_len = count;
		for(; *buf_idx<*buf_data_len && buf[*buf_idx]!='\n'; (*buf_idx)++, idx++) {
			line_buf[idx] = buf[*buf_idx];		
		}
		if (*buf_idx<*buf_data_len && buf[*buf_idx]=='\n') {
			(*buf_idx)++;
			line_buf[idx] = '\0';		
			return 0;
		}
	}
	line_buf[idx] = '\0';
	if (idx)
		return 0;
	else
		return 1;
}

#ifdef TEST
main(int argc, char **argv) {
	int fd;
	char data_buf[1024], line_buf[1024], fine[1024];
	int buf_idx=0;
	int buf_data_len=0;
	int end_file=0;
	if (argc<2) {
		printf("Usage: executable text_file_name\n");
		exit(1);
	}
	fd = open(argv[1], O_RDWR);
	printf(" To process file <%s>: %d\n", argv[1], fd);
	if (fd<0) {
		printf("Open file %s error.\n", argv[1]);
		exit(1);
	}
	printf("-------------------\n");
	for(; !end_file; ) {
		end_file = read_a_line(fd, data_buf, &buf_idx, 1024, &buf_data_len, line_buf);
		if (end_file<0) {
			printf("Read file error.\n");
			exit(1);
		}
		if (end_file) {
			return;
		}
		adjust_a_line(line_buf, fine);
		printf("<%s>\n", line_buf);
/*
		printf("--Raw line:\n<%s>\n** Fined line:\n<%s>\n", line_buf, fine);
*/
	}
	printf("-------------------\n");
	return;
}
#endif
