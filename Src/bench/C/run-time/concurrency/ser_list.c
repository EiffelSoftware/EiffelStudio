
/*****************************************************************
    In the C-programs, we use EIF_OBJ and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#include "net.h"
#include "curextern.h"

EIF_BOOLEAN exist_in_server_list(hostn, port)
char *hostn;
int port;
{
	SERVER *tmp;
	EIF_BOOLEAN ret = 0;

	for (tmp = _concur_ser_list; ! ret && tmp != NULL; tmp = tmp->next) { 
		ret = !memcmp(tmp->hostname, hostn, strlen(hostn)) && tmp->pid == port;
	}

	return ret;
}

EIF_INTEGER get_sock_from_server_list(hostn, port)
char *hostn;
int port;
{
	SERVER *tmp;
	EIF_BOOLEAN stop = 0;

	for (tmp = _concur_ser_list; !stop && tmp != NULL; ) { 
		stop = !memcmp(tmp->hostname, hostn, strlen(hostn)) && tmp->pid == port;
		if (!stop)
			tmp = tmp->next;
	}

	if (tmp) {
		(tmp->count)++;
		return tmp->sock;
	}
	else
		return -3;
}

NOUSEadd_to_server_list(hname, port, sock)
char *hname;
int port;
int sock;
{
	SERVER *tmp;

	tmp = (SERVER *)malloc(sizeof(SERVER));
	strcpy(tmp->hostname, hname);
	tmp->pid = port;
	tmp->sock = sock;
	tmp->count = 1;
	tmp->next = _concur_ser_list;
	_concur_ser_list = tmp;
	return;
}
