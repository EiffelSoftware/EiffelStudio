#include "eif_net.h"
#include "eif_curextern.h"
#include "eif_sig.h"

/* The folowing macros will be moved into "eif_constant.h" when the source file
 * is integrated into CEC's run-time.
 * Now, we define a SEP_OBJ's data as: 
 *		EIF_INTEGER sep_obj[constant_sep_obj_size]
 * where 
 *     sep_obj[0] -- Host's IP Address
 *     sep_obj[1] -- Port Number Corresponding to the Separate Object
 *	   sep_obj[2] -- Network Connection(Socket) to the Separate Object
 *	   sep_obj[3] -- The Separate Object's OID on the corresponding Processor
 *	   sep_obj[4] -- The Separate Object's Proxy's OID on the Local Processor
 * 
 */

EIF_REFERENCE eif_set_for_sep_obj(object, nbytes, type)
char *object;
unsigned int nbytes;
uint32 type;
{
    /* Set an Eiffel object for use: reset the zone with zeros, and try to
     * record the object inside the moved set, if necessary. The function
     * returns the address of the object (it may move if a GC cycle is raised).
     */
   
    register3 union overhead *zone;     /* Malloc info zone */
    register4 char *(*init)();          /* The optional initialization */
 
    SIGBLOCK;                   /* Critical section */
    memset (object, 0, nbytes);      /* All set with zeros */
 
    zone = HEADER(object);      /* Object's header */
    zone->ov_size &= ~B_C;      /* Object is an Eiffel one */
    zone->ov_flags = type;      /* Set dynamic type */
 
    if (type & EO_NEW)                  /* New object outside scavenge zone */
        if (-1 == epush(&moved_set, object)) {      /* Cannot record object */
            urgent_plsc(&object);                   /* Full collection */
            if (-1 == epush(&moved_set, object))    /* Still failed */
                enomem();                           /* Critical exception */
        }
 
    SIGRESUME;                  /* End of critical section */
 
    return object;
}


EIF_REFERENCE sep_obj_create() {
	/* Create the sep_obj, and return the direct reference */
	EIF_REFERENCE sep_obj;
	EIF_INTEGER sep_obj_size = constant_sep_obj_size*constant_sizeofint;
	sep_obj = xmalloc(sep_obj_size, EIFFEL_T, GC_ON);	
	if (sep_obj != (char *)0) {
		sep_obj = eif_set_for_sep_obj(sep_obj, sep_obj_size, _concur_sep_obj_dtype | EO_NEW); 
			/* Set for Eiffel use */
	} else {
		if (gen_scavenge & GS_ON)       /* If generation scaveging was on */
			sc_stop();                  /* Free 'to' and explode 'from' space
		sep_obj = xmalloc(sep_obj_size, EIFFEL_T, GC_OFF);	/* Try again */	
		if (sep_obj != (char *)0) {
			sep_obj = eif_set_for_sep_obj(sep_obj, sep_obj_size, _concur_sep_obj_dtype | EO_NEW); 
				/* Set for Eiffel use */
		} else {
			add_nl;
			sprintf(crash_info, CURIMPERR25);
			c_raise_concur_exception(exception_out_of_memory);
		}
	}
	return sep_obj;
}
void sep_obj_make(EIF_REFERENCE s_obj, EIF_INTEGER haddr, EIF_INTEGER port, EIF_INTEGER oid) {
	/* "s_obj" is direct reference */
	EIF_REFERENCE sep_obj;
	EIF_INTEGER sock;

	/* Create the sep_obj */
	sep_obj = henter(s_obj);

	set_host_port(eif_access(sep_obj), haddr, port);
	set_oid(eif_access(sep_obj), oid);
	sock =  c_concur_make_client(port, haddr);
	if (sock < 0) {
		sprintf(_concur_crash_info, CURERR23, c_get_name_from_addr(haddr), port);
		c_raise_concur_exception(exception_implementation_error);
	}
	set_sock(eif_access(sep_obj), sock);
	sep_obj = eif_wean(sep_obj);	
}

	/* "sep_obj" is direct reference */
/*
void sep_obj_make_without_connection(EIF_REFERENCE sep_obj, EIF_INTEGER oid) {
	set_oid(sep_obj, oid);
	set_sock(sep_obj, -2);
}
*/

void sep_obj_dispose(char *obj) {
/*
printf(" **** %d(%s) dispose (%d, %d, %d, %d, %d) with Dtype=%x, released=%d\n", _concur_pid, _concur_class_name_of_root_obj, sep_obj_host(obj), sep_obj_port(obj), sep_obj_sock(obj), sep_obj_oid(obj), sep_obj_proxy_id(obj), Dtype(obj), _concur_server_list_released);
*/
	if (!_concur_server_list_released) {
		if (sep_obj_sock(obj) >= 0) {
			/* the object is imported from another processor, so
			 * send it a UNREGISTER command.
			 */
			c_send_unregister_request(sep_obj_sock(obj), sep_obj_oid(obj));
		} else {
			/* the object is imported from itself, so process
			 * UNREGISTER directly.
			 */
			unregister_from_local_processor(sep_obj_host(obj), sep_obj_port(obj), sep_obj_oid(obj));
		}
		c_process_ser_list_from_sep_obj(sep_obj_host(obj), sep_obj_port(obj), sep_obj_sock(obj));
		cleanup_proxy(sep_obj_host(obj), sep_obj_port(obj), sep_obj_oid(obj), sep_obj_proxy_id(obj));

	}
}

