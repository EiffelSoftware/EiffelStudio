
/*****************************************************************
    In the C-programs, we use EIF_OBJECT and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#include "eif_net.h"
#include "eif_curextern.h"

EIF_BOOLEAN exist_in_server_list(hostn, port)
EIF_INTEGER hostn;
int port;
{
	SERVER *tmp;
	EIF_BOOLEAN ret = 0;

	for (tmp = _concur_ser_list; ! ret && tmp != NULL; tmp = tmp->next) { 
		ret = tmp->hostaddr == hostn && tmp->pid == port;
	}

	return ret;
}

EIF_INTEGER get_sock_from_server_list(hostn, port)
EIF_INTEGER hostn;
int port;
{
	SERVER *tmp;
	EIF_BOOLEAN stop = 0;

	for (tmp = _concur_ser_list; !stop && tmp != NULL; ) { 
		stop = tmp->hostaddr == hostn && tmp->pid == port;
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

