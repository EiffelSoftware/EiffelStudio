
/*****************************************************************
    In the C-programs, we use EIF_OBJECT and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#define tTEST
#define tTEST_CON
#define tDISP_MSG

#undef tDISP_MSG

#ifdef TEST
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#else
#ifdef TEST_CON
#include "eif_curserver.h"
#else
#include "eif_net.h"
#include "eif_curextern.h"
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
	cur_clear_configure_table();
	
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
	EIF_INTEGER ind;
	RESOURCE_LEVEL *g_tmp;
	RESOURCE *h_tmp;

	_concur_group_index = (RESOURCE_LEVEL *)NULL;
	_concur_host_index = (RESOURCE *)NULL;

	for(g_tmp=_concur_host_groups; g_tmp; g_tmp=g_tmp->next) {
		for (h_tmp=g_tmp->host_list; h_tmp; h_tmp = h_tmp->next) {	
			if (!strlen((*h_tmp).host) || !strlen((*h_tmp).directory)) {
				sprintf(_concur_crash_info, CURAPPERR21, (*h_tmp).host, (*h_tmp).directory);	
				c_raise_concur_exception(exception_configure_syntax_error);
			}
			if ((*h_tmp).executable[0] == '\0') {
				for(ind=strlen((*h_tmp).directory); ind>=0 && (*h_tmp).directory[ind] != '\\' && (*h_tmp).directory[ind] != '/'; ind--);
				if (ind<0) {
					add_nl;
					sprintf(crash_info, CURAPPERR35, (*h_tmp).host, (*h_tmp).directory);
					c_raise_concur_exception(exception_configure_syntax_error);
				}
				strcpy((*h_tmp).executable, (*h_tmp).directory+ind+1);
				(*h_tmp).directory[ind+1] = '\0';
				if ((*h_tmp).executable[0] == '\0') {
					add_nl;
					sprintf(crash_info, CURAPPERR36, (*h_tmp).host, (*h_tmp).directory);
					c_raise_concur_exception(exception_configure_syntax_error);
				}
			}
			if ((*h_tmp).capability > 0 && !_concur_host_index ) {
				_concur_group_index = g_tmp;
				_concur_host_index = h_tmp;;
				_concur_resource_count = 0;
			}
		}
	}

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
	char stop, stop_line;
	char num_str[constant_max_len_of_int_in_str+1];
	int tmp_int;
	int len;
	char tmp_buf[20];
	int idx;
	int line_idx;

	REMOTE_SERVER *tmp_r;
	RESOURCE *tmp_h;
	RESOURCE_LEVEL *tmp_g;

	/* get rid of "default" */
	memcpy(tmp_buf, cur_line, 7);
	for(tmp_int=0; tmp_int < 7; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++); 
	if (memcmp(tmp_buf, "default", 7)) {
		add_nl;
		sprintf(crash_info, CURAPPERR14, cur_raw_line);
		c_raise_concur_exception(exception_configure_syntax_error);
	}
	
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
			_concur_default_port = atoi(num_str);
		else if (!memcmp(tmp_buf, "instance", 8)) 
			_concur_default_instance = atoi(num_str);
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
	
	
	for(tmp_r=_concur_rem_sers; tmp_r; tmp_r=tmp_r->next) {
		if (tmp_r->port < 0)
			tmp_r->port = _concur_default_port;
		if (tmp_r->port <= 0 || !strlen(tmp_r->host)) {
			sprintf(_concur_crash_info, CURAPPERR20, tmp_r->name, tmp_r->host, tmp_r->port);	
			c_raise_concur_exception(exception_configure_syntax_error);
		}
			
	}

	idx = 0;
	for(tmp_g=_concur_host_groups; tmp_g; tmp_g=tmp_g->next) {
		for(tmp_h=tmp_g->host_list; tmp_h; tmp_h=tmp_h->next) {
			if (tmp_h->capability < 0)
				tmp_h->capability = _concur_default_instance;
			if (tmp_h->capability > 0)
				idx = 1;
		}
	}

	if (!idx) {
		strcat(_concur_crash_info, CURAPPERR22);	
		c_raise_concur_exception(exception_configure_syntax_error);
	}
	
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

	REMOTE_SERVER *tmp_r;
		

	if (fd < 0) {
	}
	else {
		/* get rid of "external" */
		memcpy(tmp_buf, cur_line, 8);
		for(tmp_int=0; tmp_int < 8; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++); 
		if (memcmp(tmp_buf, "external", 8) || strlen(cur_line)!=8) {
			sprintf(_concur_crash_info, CURAPPERR23, cur_raw_line);
			c_raise_concur_exception(exception_configure_syntax_error);
		}
		
		for(stop=0; !stop && !*end_of_file; ) {
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
		
			tmp_r = (REMOTE_SERVER *)eif_malloc(sizeof(REMOTE_SERVER));
			valid_memory(tmp_r);
/*
			tmp_r->name[0] = '\0';
			tmp_r->host[0] = '\0';
*/
			tmp_r->port = -1;
			tmp_r->next = _concur_rem_sers;
			_concur_rem_sers = tmp_r;

			/* Get SERVER NAME */
			for (tmp_int=0; line_idx<len && cur_line[line_idx]!=':'; ) {
				tmp_r->name[tmp_int] = cur_line[line_idx];
				tmp_int++; line_idx++;
			}
			tmp_r->name[tmp_int] = '\0';

			/* skip to MACHINE NAME */
			for(line_idx++; line_idx<len && cur_line[line_idx]!='"'; line_idx++);	

			/* get MACHINE NAME */
			for(line_idx++, tmp_int=0; line_idx<len && cur_line[line_idx]!='"'; ) {
				tmp_r->host[tmp_int] = cur_line[line_idx];
				tmp_int++; line_idx++;
			}
			tmp_r->host[tmp_int] = '\0';

			/* skip to PORT NUMBER */
			for(line_idx++; line_idx<len && (cur_line[line_idx]<'0' || cur_line[line_idx]>'9'); line_idx++);	

			/* get PORT NUMBER */
			for(tmp_int=0; line_idx<len && cur_line[line_idx]>='0' && cur_line[line_idx]<='9'; ) {
				port_str[tmp_int] = cur_line[line_idx];
				tmp_int++; line_idx++;
			}
			port_str[tmp_int] = '\0';
			if (tmp_int) 
				tmp_r->port = atoi(port_str);
			else
				tmp_r->port = -1;

		}

		if (!stop) {
			sprintf(_concur_crash_info, CURAPPERR25, cur_raw_line);
			c_raise_concur_exception(exception_configure_syntax_error);
		}
		
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
	char localhost[constant_max_host_name_len+1];
	char localdir[constant_max_directory_len+1];
	char tmp_buf[20];
	int tmp_int;
	int line_idx;
	int len;
	char stop, substop, stop_line;
	int index;
	char at_least_one_host;
	
	RESOURCE *tmp_host=(RESOURCE *)(NULL);
	RESOURCE_LEVEL *tmp_grp=(RESOURCE_LEVEL *)NULL;
		
	/* Now, we begin to read information from Configure File */
	if (fd < 0) {
		_concur_host_groups = _concur_end_of_host_groups = (RESOURCE_LEVEL *)eif_malloc(sizeof(RESOURCE_LEVEL));
		valid_memory(_concur_host_groups);
		strcpy(_concur_host_groups->name, "Current");
		_concur_host_groups->next = (RESOURCE_LEVEL *)NULL;
		_concur_host_groups->host_list = _concur_host_groups->end_of_host_list = (RESOURCE *)eif_malloc(sizeof(RESOURCE)); 
		valid_memory(_concur_host_groups->host_list);
		_concur_host_groups->host_list->next = (RESOURCE *)NULL;
		strcpy(_concur_host_groups->host_list->host, _concur_hostname);
		_concur_host_groups->host_list->capability = 1;
		strcpy(_concur_host_groups->host_list->directory, c_get_current_directory());
		strcpy(_concur_host_groups->host_list->executable, _concur_executable);
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
	for (stop=0; !stop && !*end_of_file; ) {
		memcpy(tmp_buf, cur_line, 3);
		for(tmp_int=0; tmp_int < 3; tmp_buf[tmp_int]=tolower(tmp_buf[tmp_int]), tmp_int++);
		stop = !memcmp(tmp_buf, "end", 3) && strlen(cur_line)==3;
		if (stop) {
			skip_to_next_valuable_line;
			break;
		}

		tmp_grp = (RESOURCE_LEVEL *)eif_malloc(sizeof(RESOURCE_LEVEL));
		valid_memory(tmp_grp);
		tmp_grp->next = NULL;
		tmp_grp->host_list = tmp_grp->end_of_host_list = (RESOURCE *)NULL;
		if (_concur_host_groups) {
			_concur_end_of_host_groups->next = tmp_grp;
			_concur_end_of_host_groups = tmp_grp;
		}
		else {
			_concur_host_groups = _concur_end_of_host_groups = tmp_grp;
		}

		/* get Level Name */
		for(line_idx=0, len=strlen(cur_line), tmp_int=0; line_idx<len && cur_line[line_idx]!=':'; ) {
                tmp_grp->name[tmp_int] = cur_line[line_idx];
                tmp_int++; line_idx++;
        }
		if (!stop && line_idx<len && cur_line[line_idx]==':') {	
	        tmp_grp->name[tmp_int] = '\0';
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

			tmp_host = (RESOURCE *)eif_malloc(sizeof(RESOURCE));
			valid_memory(tmp_host);

			tmp_host->host[0] = '\0';
			tmp_host->directory[0] = '\0';
			tmp_host->executable[0] = '\0';

			tmp_host->next = (RESOURCE *)NULL;
			if (tmp_grp->host_list) {
				tmp_grp->end_of_host_list->next = tmp_host;
				tmp_grp->end_of_host_list = tmp_host;
			} else {
				tmp_grp->host_list =
					tmp_grp->end_of_host_list = tmp_host;
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
				(*tmp_host).host[tmp_int] = cur_line[line_idx];
			(*tmp_host).host[tmp_int] = '\0';

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
				(*tmp_host).capability = -1;
			else {
				for(tmp_int=0, line_idx++; !substop && line_idx<len && ((cur_line[line_idx]>='0' && cur_line[line_idx]<='9') || cur_line[line_idx]=='-'); line_idx++, tmp_int++)
					 port_str[tmp_int] = cur_line[line_idx];
				port_str[tmp_int] = '\0';
				(*tmp_host).capability = atoi(port_str);
			}


			/* skip to DIRECTORY */
			for(; line_idx<len && cur_line[line_idx]!='"'; line_idx++);

			if (line_idx>=len) {
				sprintf(_concur_crash_info, CURAPPERR32, cur_raw_line);
				c_raise_concur_exception(exception_configure_syntax_error);
			}

			/* get DIRECTORY */
			for(line_idx++, tmp_int=0; line_idx<len && cur_line[line_idx]!='"'; line_idx++,tmp_int++)
				(*tmp_host).directory[tmp_int] = cur_line[line_idx];
			(*tmp_host).directory[tmp_int] = '\0';


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

	if (!index) {
		sprintf(_concur_crash_info, CURAPPERR42);
		c_raise_concur_exception(exception_configure_syntax_error);
	}

	return;
}

void print_config() {
	REMOTE_SERVER *tmp_ser;
	RESOURCE *tmp_host;
	RESOURCE_LEVEL *tmp_grp;
	
	printf(CURPROMPT1);

	printf(CURPROMPT2);
	for(tmp_ser=_concur_rem_sers; tmp_ser; tmp_ser=tmp_ser->next) {
		printf("<%s, %s, %d>\n", tmp_ser->name, tmp_ser->host, tmp_ser->port);
	}

	printf(CURPROMPT3);
	for(tmp_grp=_concur_host_groups; tmp_grp; tmp_grp=tmp_grp->next) {
		printf(CURPROMPT4, tmp_grp->name);
		for(tmp_host=tmp_grp->host_list; tmp_host; tmp_host=tmp_host->next) {
			printf("    <%s, %d, %s, %s>\n", (*tmp_host).host, (*tmp_host).capability, (*tmp_host).directory, (*tmp_host).executable);
		}
	}

	if (_concur_group_index && _concur_host_index)
		printf(CURPROMPT5, _concur_host_index->host, _concur_host_index->capability, _concur_host_index->directory, _concur_host_index->executable, _concur_group_index->name, _concur_resource_count);
	else
		printf(CURPROMPT6);

	printf(CURPROMPT7, _concur_default_port, _concur_default_instance);

	printf(CURPROMPT8);

}



char *dispatch_to() {
/* return the host(its name or IP address) to which the next separate 
 * object will be dispatched.
*/

	if (!_concur_host_index) {
		sprintf(_concur_crash_info, CURAPPERR43);
		c_raise_concur_exception(exception_configure_syntax_error);
	}
	_concur_dispatched_host = _concur_host_index->host;
	_concur_dispatched_directory = _concur_host_index->directory;
	_concur_dispatched_executable = _concur_host_index->executable;
	_concur_resource_count++;
	_concur_end_of_host_groups->next = _concur_host_groups;
	for (;_concur_resource_count >= _concur_host_index->capability;) {
		_concur_resource_count = 0;
		_concur_host_index = _concur_host_index->next;
		if (!_concur_host_index) {
			for(_concur_group_index=_concur_group_index->next;
				!(_concur_group_index->host_list); 
					_concur_group_index=_concur_group_index->next);
			_concur_host_index = _concur_group_index->host_list;
		}
	}
	_concur_end_of_host_groups->next = (RESOURCE_LEVEL *)NULL;
	return _concur_dispatched_host;
}


void reset_by_host(char *gname, char *hname)
{
/* reset the CURSOR(used for dispatching separate objects) to the 
 * host with the name.
*/

	for(_concur_group_index=_concur_host_groups; _concur_group_index && memcmp(_concur_group_index->name, gname, strlen(gname)); _concur_group_index=_concur_group_index->next);
	if (_concur_group_index) {
		for(_concur_host_index=_concur_group_index->host_list; _concur_host_index &&  memcmp(_concur_host_index->host, hname, strlen(hname)); _concur_host_index=_concur_host_index->next);
		if (_concur_host_index && _concur_host_index->capability>0) {
		/* The host name does  exist and its capacity is greater than 0! */
			_concur_resource_count = 0;
		} else {
			sprintf(_concur_crash_info, CURAPPERR39, hname, gname);	
			c_raise_concur_exception(exception_configure_syntax_error);
		}
	} else {
		sprintf(_concur_crash_info, CURAPPERR40, gname);	
		c_raise_concur_exception(exception_configure_syntax_error);
	}
	
	return;
}


void reset_by_level(char *gname)
{
/* reset the CURSOR(used for dispatching separate objects) to the 
 * first host in the host level indicated by the given level name.
*/

	for(_concur_group_index=_concur_host_groups; _concur_group_index && memcmp(_concur_group_index->name, gname, strlen(gname)); _concur_group_index=_concur_group_index->next);
	if (_concur_group_index) {
		for(_concur_host_index=_concur_group_index->host_list; _concur_host_index && _concur_host_index->capability<1; _concur_host_index=_concur_host_index->next);
		if (_concur_host_index) {
			_concur_resource_count = 0;
		} else {
			sprintf(_concur_crash_info, CURAPPERR41, gname);	
			c_raise_concur_exception(exception_configure_syntax_error);
		}
	} else {
		sprintf(_concur_crash_info, CURAPPERR40, gname);	
		c_raise_concur_exception(exception_configure_syntax_error);
	}
	return;	
}

void  cur_clear_configure_table() {
REMOTE_SERVER *tmp_r, *tmp_r1;
RESOURCE *tmp_h, *tmp_h1;
RESOURCE_LEVEL *tmp_g, *tmp_g1;

	for(tmp_r=_concur_rem_sers; tmp_r; ) {
		tmp_r1 = tmp_r;	
		tmp_r = tmp_r->next;
		eif_free(tmp_r1);
	}
	for(tmp_g=_concur_host_groups; tmp_g; ) {
		for(tmp_h=tmp_g->host_list; tmp_h; ) {
			tmp_h1 = tmp_h;	
			tmp_h = tmp_h->next;
			eif_free(tmp_h1);
		}
		tmp_g1 = tmp_g;
		tmp_g = tmp_g->next;
		eif_free(tmp_g1);
	}
	_concur_rem_sers = (REMOTE_SERVER *)NULL;
	_concur_host_groups = _concur_end_of_host_groups = (RESOURCE_LEVEL *)NULL;
	_concur_group_index = (RESOURCE_LEVEL *)NULL;
	_concur_host_index = (RESOURCE *)NULL;
	_concur_default_port = 0;
	_concur_default_instance = 0;
}
 
void add_group(char *gname) {
/* if the group already exists, do nothing */
	RESOURCE_LEVEL *tmp_g;

	for(tmp_g=_concur_host_groups; tmp_g && strcmp(tmp_g->name, gname); tmp_g=tmp_g->next);
	if (tmp_g)
		return;
	tmp_g=(RESOURCE_LEVEL *)eif_malloc(sizeof(RESOURCE_LEVEL));
	valid_memory(tmp_g);
	strcpy(tmp_g->name, gname);
	tmp_g->next = (RESOURCE_LEVEL *)NULL;
	tmp_g->host_list = tmp_g->end_of_host_list = (RESOURCE *)NULL;
	if (_concur_host_groups) {
		_concur_end_of_host_groups->next = tmp_g;
		_concur_end_of_host_groups = tmp_g;
	} else {
		_concur_host_groups = _concur_end_of_host_groups = tmp_g;
	}
}

void add_host (char *gname, char *hname, EIF_INTEGER cap, char *dir, char *exe) {
/* If the group does not exist, add it;
 * If the host exists, do nothing;
 * Otherwise, add it.
 */

	RESOURCE_LEVEL *tmp_g;
	RESOURCE *tmp_h;

	for(tmp_g=_concur_host_groups; tmp_g && strcmp(tmp_g->name, gname); tmp_g=tmp_g->next);
	if (!tmp_g) {
		add_group(gname);		
		tmp_g = _concur_end_of_host_groups;
	}
	for(tmp_h=tmp_g->host_list; tmp_h &&  memcmp(tmp_h->host, hname, strlen(hname)); tmp_h=tmp_h->next);
	if (tmp_h)
		return;
	tmp_h=(RESOURCE *)eif_malloc(sizeof(RESOURCE));
	valid_memory(tmp_h);
	strcpy(tmp_h->host, hname);
	strcpy(tmp_h->directory, dir);
	strcpy(tmp_h->executable, exe);
	tmp_h->capability = cap;
	tmp_h->next = (RESOURCE *)NULL;
	if (tmp_g->host_list) {
		tmp_g->end_of_host_list->next = tmp_h;	
		tmp_g->end_of_host_list = tmp_h;	
	} else {
		tmp_g->host_list = tmp_g->end_of_host_list = tmp_h;	
	}
	if (!_concur_host_index) {
		_concur_group_index = tmp_g;
		_concur_host_index = tmp_h;
	}
}

void change_capacity_of_host(char *gname, char *hname, EIF_INTEGER cap) {
/* If the group and host exist, change the host's capacity, otherwise,
 * do nothing.
 */
	RESOURCE_LEVEL *tmp_g;
	RESOURCE *tmp_h;
	for(tmp_g=_concur_host_groups; tmp_g && strcmp(tmp_g->name, gname); tmp_g=tmp_g->next);
	if (tmp_g) {
		for(tmp_h=tmp_g->host_list; tmp_h &&  memcmp(tmp_h->host, hname, strlen(hname)); tmp_h=tmp_h->next);
		if (tmp_h)
			tmp_h->capability = cap;
	}
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

void gettime (Timeval *t) {
}

ulong elapsed(Timeval *t1, Timeval *t2) {
return 0;
}

main() {
	int idx;

	con_make("conf");
	print_config();


	printf("\nresource_index=%x, count=%d\n", _concur_host_index, _concur_resource_count);
	printf("Dispatched to: <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);
	reset_by_host("fast_machine", "lannion");
	printf("After reset by 'fast_machine, lannion':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

	reset_by_host("slow_machine", "athen");
	printf("After reset by 'slow_machine, athen':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

	reset_by_host("fast_machine", "lannion");
	printf("After reset by 'fast_machine, lannion':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

	reset_by_level("middle_machine");
	printf("After reset by 'middle_machine':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

	reset_by_level("fast_machine");
	printf("After reset by 'fast_machine':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

	reset_by_level("middle_machine");
	printf("After reset by 'middle_machine':\n <%s, %s>\n", dispatch_to(), _concur_dispatched_directory);

    add_group("middle_machine");
    add_group("my_machine");
    add_host("my_machine", "katherine", 1, "/tang/c1", "fff");
    add_host("my_machine", "katherine", 2, "/tang/c2", "fff");
    add_host("my_machine1", "katherine", 1, "/tang/c2", "fff");
	change_capacity_of_host ("my_machine1", "katherine", 2);
	print_config(); 

	for(idx=0; idx<35; idx++) 
	printf("%dth <%s, %s>\n", idx, dispatch_to(), _concur_dispatched_directory);

	cur_clear_configure_table();
    add_group("middle_machine");
    add_group("my_machine");
    add_host("my_machine", "katherine", 1, "/tang/c1", "fff");
    add_host("my_machine", "katherine", 2, "/tang/c2", "fff");
    add_host("my_machine1", "katherine", 1, "/tang/c2", "fff");
	change_capacity_of_host ("my_machine1", "katherine", 2);
	reset_by_level("my_machine");
	print_config(); 
	for(idx=0; idx<20; idx++) 
	printf("%dth <%s, %s>\n", idx, dispatch_to(), _concur_dispatched_directory);
	con_make("conf");
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
