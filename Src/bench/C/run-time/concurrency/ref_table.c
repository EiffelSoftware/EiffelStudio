
/*****************************************************************
    In the C-programs, we use EIF_OBJECT and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#include "eif_net.h"
#include "eif_curextern.h"
#define tDEBUG

#define STACK_SIZE (STACK_CHUNK-(sizeof(struct stchunk)/sizeof(char*)))


EIF_INTEGER get_oid_from_address(obj)
char *obj;
{
/* obj is direct(un-protected) address. */
/* we will do the following things:
 * 1) put the object address in "separate_object_id_set"(which will be
 * automatically maintained when GC moves the object in memory the objects
 * in the set are treated as alive by GC).
 * 2) if the object has been exported before, increase the pending number
 * in the EXPORTED_OBJECT_LIST by one to indicate that a REGISTER command
 * might come within the atomic application command; otherwise, create a 
 * new node for the object in the EXPORTED_OBJECT_LIST and set the pending
 * to be 1. For more information about `pending', please refer to
 * the definition of EXPORTED_OBJ_LIST_NODE in constant.h and c-procedure 
 * `adjust_exported_objects'.
 * 3) and last, return the OID of the object in the set.
*/

	EXPORTED_OBJ_LIST_NODE *exported_obj;
	EIF_INTEGER oid;
	EIF_REFERENCE root;

	if (obj==NULL)	
		return -1;
	root = henter(obj);	
	oid = eif_separate_object_id(root);
	root = eif_wean(root); /* it's not necessary keep the object in hector */

	for(exported_obj=_concur_exported_obj_list; exported_obj != NULL && exported_obj->oid != oid; exported_obj=exported_obj->next); 
	/* search the exported object list first */

	if (exported_obj) {
	/* it's in the list: it has been referred by other processor before */
		(exported_obj->pending)++;
		return exported_obj->oid;	
	}
	else {
	/* the object has never been referred by other processor before,*/
	/* when we get its OID, it has been kept in "separate_object_id_set"(so */
	/* it will keep alive at least when it's in the set). Now add the info */
	/* of the object into the exported objcect list */
		exported_obj = (EXPORTED_OBJ_LIST_NODE *)eif_malloc(sizeof(EXPORTED_OBJ_LIST_NODE));
		valid_memory(exported_obj); /* check if got enough memory */
		exported_obj->oid = oid;
		exported_obj->count = 0;
		exported_obj->pending = 1;
		exported_obj->next = _concur_exported_obj_list;
		_concur_exported_obj_list = exported_obj;
		return exported_obj->oid;
	}
}

char exported_obj_to_processor_before(oid, hostn, port)
EIF_INTEGER oid;
EIF_INTEGER hostn;
EIF_INTEGER port;
{
/* decide if a local object identified by "oid" has been exported to
 * a special processor(identified by <"hostn", "port">). If yes, return 1;
 * else return 0.
*/
	REF_LIST_NODE *obj_ref_list;
	REF_TABLE_NODE *ref_table_ptr;

	for(ref_table_ptr=_concur_ref_table; ref_table_ptr && (ref_table_ptr->pid!=port || hostn != ref_table_ptr->hostaddr); ref_table_ptr=ref_table_ptr->next);
	/* search the exported object table */

	if (ref_table_ptr) {
		for(obj_ref_list = ref_table_ptr->ref_list; obj_ref_list && obj_ref_list->oid != oid; obj_ref_list = obj_ref_list->next);
		/* search the list of objects exported to the processor */

		if (obj_ref_list)
			return 1;
		else
			return 0;
	}
	else
		return 0;

}


EIF_INTEGER get_proxy_oid_of_imported_object(host, port, oid)
EIF_INTEGER host;
EIF_INTEGER port;
EIF_INTEGER oid;
{
/* if the object identified by OID has been imported before, return the */
/* corresponding proxy's OID(>0), otherwise return. 0 */
/* The proxy's address is kept in "object_id_stack"(which will be
 * automatically maintained by GC when the proxy object is moved in memory,
 * but the objects in the stack are not treated as "alive" by GC).
*/
	IMPORTED_OBJ_TABLE_NODE *tmp_tab_ptr;
	PROXY_LIST_NODE *tmp_list_ptr;
	EIF_BOOLEAN stop;

	for(tmp_tab_ptr=_concur_imported_obj_tab; tmp_tab_ptr && (tmp_tab_ptr->hostaddr != host || tmp_tab_ptr->pid!=port); tmp_tab_ptr=tmp_tab_ptr->next);
	/* search the imported object table */

	if (tmp_tab_ptr) {
	/* found the list for the objects imported from the processor identified */
	/* by "<host, port>" */
		tmp_list_ptr=tmp_tab_ptr->list_root; 
		if (oid == constant_root_oid) 
			stop = !tmp_list_ptr || tmp_list_ptr->oid<0;
		else
			stop = !tmp_list_ptr || tmp_list_ptr->oid==oid;
		for(; !stop; ) {
			tmp_list_ptr=tmp_list_ptr->next;
			if (oid == constant_root_oid) 
				stop = !tmp_list_ptr || tmp_list_ptr->oid<0;
			else
				stop = !tmp_list_ptr || tmp_list_ptr->oid==oid;
		}
		if (tmp_list_ptr)
		/* found the object */
			return tmp_list_ptr->proxy_id;
		else
		/* the object has not imported from the processor */
			return 0;
	}
	else
		return 0;
}


void insert_into_imported_object_table(host, port, oid, proxy_id)
EIF_INTEGER host;
EIF_INTEGER port;
EIF_INTEGER oid;
EIF_INTEGER proxy_id;
{
/* insert the proxy's OID into the imported object table so that it can be 
 * used next time.
*/
	IMPORTED_OBJ_TABLE_NODE *tmp_tab_ptr;
	PROXY_LIST_NODE *tmp_list_ptr;

	for(tmp_tab_ptr=_concur_imported_obj_tab; tmp_tab_ptr && (tmp_tab_ptr->hostaddr != host || tmp_tab_ptr->pid!=port); tmp_tab_ptr=tmp_tab_ptr->next);
	/* search the exported object table */

	if (tmp_tab_ptr) {
	/* some objects have been imported from processor "<host, port>" */
		tmp_list_ptr = (PROXY_LIST_NODE *)eif_malloc(sizeof(PROXY_LIST_NODE));
		valid_memory(tmp_list_ptr);
		tmp_list_ptr->oid = oid;
		tmp_list_ptr->proxy_id = proxy_id;
		tmp_list_ptr->next = tmp_tab_ptr->list_root;
		tmp_tab_ptr->list_root = tmp_list_ptr;
		return;
	}
	else {
		tmp_list_ptr = (PROXY_LIST_NODE *)eif_malloc(sizeof(PROXY_LIST_NODE));
		valid_memory(tmp_list_ptr);
		tmp_list_ptr->oid = oid;
		tmp_list_ptr->proxy_id = proxy_id;
		tmp_list_ptr->next = NULL;

		tmp_tab_ptr = (IMPORTED_OBJ_TABLE_NODE *)eif_malloc(sizeof(IMPORTED_OBJ_TABLE_NODE));
		valid_memory(tmp_tab_ptr);
		tmp_tab_ptr->hostaddr = host;
		tmp_tab_ptr->pid = port;
		tmp_tab_ptr->list_root = tmp_list_ptr;
		tmp_tab_ptr->next = _concur_imported_obj_tab;
		_concur_imported_obj_tab = tmp_tab_ptr;
		return;
	}
}


void cleanup_proxy(host, port, oid, proxy_id)
EIF_INTEGER host;
EIF_INTEGER port;
EIF_INTEGER oid;
EIF_INTEGER proxy_id;
{
/* clear the proxy from object_id_stack and from imported_object_table */
	IMPORTED_OBJ_TABLE_NODE *tmp_tab_ptr1, *tmp_tab_ptr2;
	PROXY_LIST_NODE *tmp_list_ptr1, *tmp_list_ptr2;

	for(tmp_tab_ptr1=NULL, tmp_tab_ptr2=_concur_imported_obj_tab; tmp_tab_ptr2 && (tmp_tab_ptr2->hostaddr != host || tmp_tab_ptr2->pid!=port); tmp_tab_ptr1=tmp_tab_ptr2, tmp_tab_ptr2=tmp_tab_ptr2->next);
	/* search the imported object list for the processor */

	if (tmp_tab_ptr2) {
	/* the current processor has imported object from the processor before */
		for(tmp_list_ptr1=NULL, tmp_list_ptr2=tmp_tab_ptr2->list_root; tmp_list_ptr2 && tmp_list_ptr2->oid!=oid; tmp_list_ptr1=tmp_list_ptr2, tmp_list_ptr2=tmp_list_ptr2->next);
		if (tmp_list_ptr2 && tmp_list_ptr2->proxy_id==proxy_id) {
		/* delete the proxy from the imported object table */
			if(tmp_list_ptr1)
			/* delete it from the imported object list of the processor */
				tmp_list_ptr1->next = tmp_list_ptr2->next;
			else {
			/* delete it from the imported object list of the processor, */
				tmp_tab_ptr2->list_root = tmp_list_ptr2->next;
				if (!tmp_tab_ptr2->list_root) {
				/* if there is no object imported from the processor, delete */
				/* the processor from the imported object table */
					if (tmp_tab_ptr1)
						tmp_tab_ptr1->next = tmp_tab_ptr2->next;
					else
						_concur_imported_obj_tab = tmp_tab_ptr2->next;
					eif_free(tmp_tab_ptr2);
				}
			}
			eif_free(tmp_list_ptr2);
			eif_object_id_free(proxy_id); /* delete from object_id_stack */
			return;
		}
	}

	/* error happened */
	add_nl;
	strcat(_concur_crash_info, CURIMPERR5);
	c_raise_concur_exception(exception_implementation_error);
	
}



void change_ref_table_and_exported_obj_list(cli_host, cli_pid, cli_oid, flag)
EIF_INTEGER cli_host;
EIF_INTEGER cli_pid;
EIF_INTEGER cli_oid;
EIF_INTEGER flag;
{

	REF_LIST_NODE *obj_ref_list=NULL;
	REF_LIST_NODE *tmp_ref_ptr, *tmp_ref_ptr1;
	REF_TABLE_NODE *ref_table_ptr, *tmp_tab_ptr;
	EXPORTED_OBJ_LIST_NODE *exported_obj, *tmp_ptr;

	for(tmp_tab_ptr=NULL, ref_table_ptr=_concur_ref_table; ref_table_ptr && (ref_table_ptr->pid!=cli_pid || cli_host != ref_table_ptr->hostaddr); tmp_tab_ptr=ref_table_ptr, ref_table_ptr=ref_table_ptr->next);
	/* search the exported object table */

	if (ref_table_ptr)
		obj_ref_list = ref_table_ptr->ref_list;

	switch (flag) {
		case constant_release_all:
			if (obj_ref_list) {
			/* release all references to the exported objects */
				for(tmp_ref_ptr=NULL; obj_ref_list; tmp_ref_ptr=obj_ref_list, obj_ref_list = obj_ref_list->next) {
				/* process an object each time */
					for(tmp_ptr=NULL, exported_obj=_concur_exported_obj_list; exported_obj && exported_obj->oid != obj_ref_list->oid; tmp_ptr= exported_obj, exported_obj = exported_obj->next);
					/* find the object in the exported object list */
					if (exported_obj) {
					/* we got the object in the exported object list */
						exported_obj->count -= obj_ref_list->count;
						/* reduce the reference number to the exported object */
						if (!(exported_obj->count)) {
						/* the exported object is not refered by separate objects,
						 * so delete it from the exported object list,  and  
						* before do this, delete it from "separate_object_id_set".
						*/
							eif_separate_object_id_free(exported_obj->oid);
							/* delete the exported object from "separate_object_id_set". */
							if (tmp_ptr) 
								tmp_ptr->next = exported_obj->next;
							else
								_concur_exported_obj_list = exported_obj->next;
							eif_free(exported_obj);
						}
					}
					else {
						add_nl;
						strcat(_concur_crash_info, CURIMPERR6);
						c_raise_concur_exception(exception_implementation_error);
					}

					if (tmp_ref_ptr)
						eif_free(tmp_ref_ptr);
				}
			
				if (tmp_ref_ptr)
					eif_free(tmp_ref_ptr);

				/* now, delete the separate object's reference list from the
				 * reference table 
				*/
				if (tmp_tab_ptr)
					tmp_tab_ptr->next = ref_table_ptr->next;
				else 
					_concur_ref_table = ref_table_ptr->next;
				eif_free(ref_table_ptr);
			}
			else {
				add_nl;
				strcat(_concur_crash_info, CURIMPERR6);
				c_raise_concur_exception(exception_implementation_error);
			}
			break;
		case 1:
			/* first, change the exported object table */
			if (obj_ref_list) {
			/* the separate object has referred to object(s) on local processor */
				for(tmp_ref_ptr=obj_ref_list; tmp_ref_ptr && tmp_ref_ptr->oid!=cli_oid; tmp_ref_ptr=tmp_ref_ptr->next);
				
				if (tmp_ref_ptr)
				/* the processor has referred to the object before */ 
					(tmp_ref_ptr->count)++;
				else {
				/* the processor has never referred to the object before */
					tmp_ref_ptr = (REF_LIST_NODE *)eif_malloc(sizeof(REF_LIST_NODE));
					valid_memory(tmp_ref_ptr);
					tmp_ref_ptr->oid = cli_oid;
					tmp_ref_ptr->count = 1;
					tmp_ref_ptr->next = obj_ref_list->next;
					obj_ref_list->next = tmp_ref_ptr;
				}
			}
			else {
			/* the separate object has never referrred to an object on local processor */
				obj_ref_list = (REF_LIST_NODE *)eif_malloc(sizeof(REF_LIST_NODE));
				valid_memory(obj_ref_list);
				obj_ref_list->count = 1;
				obj_ref_list->oid = cli_oid;
				obj_ref_list->next = NULL;

				tmp_tab_ptr = (REF_TABLE_NODE *)eif_malloc(sizeof(REF_TABLE_NODE));
				valid_memory(tmp_tab_ptr);
				tmp_tab_ptr->hostaddr = cli_host;
				tmp_tab_ptr->pid = cli_pid;
				tmp_tab_ptr->ref_list = obj_ref_list;
				tmp_tab_ptr->next =  _concur_ref_table ;
				_concur_ref_table = tmp_tab_ptr;
			}	

			/* now, change the exported object list */
			for(exported_obj=_concur_exported_obj_list; exported_obj && exported_obj->oid != cli_oid; exported_obj = exported_obj->next);
			if (exported_obj) {
				if (exported_obj->pending)
					(exported_obj->pending)--;
				(exported_obj->count)++;
			}
			else {
				add_nl;
				strcat(_concur_crash_info, CURIMPERR7);
				c_raise_concur_exception(exception_implementation_error);

				tmp_ptr = (EXPORTED_OBJ_LIST_NODE *)eif_malloc(sizeof(EXPORTED_OBJ_LIST_NODE));
				valid_memory(tmp_ptr);
				tmp_ptr->oid = cli_oid;
				tmp_ptr->count = 1;
				tmp_ptr->next = _concur_exported_obj_list;
				_concur_exported_obj_list = tmp_ptr;
			}
			break;
		case -1:
			if (obj_ref_list) {
				for(tmp_ref_ptr1=NULL, tmp_ref_ptr=obj_ref_list; tmp_ref_ptr && tmp_ref_ptr->oid!=cli_oid; tmp_ref_ptr1=tmp_ref_ptr, tmp_ref_ptr=tmp_ref_ptr->next);
				/* first, found the exported object in the exported object list to the processor */
				
				if (tmp_ref_ptr) {
					(tmp_ref_ptr->count)--;
					if (!_concur_current_client_reserved && !tmp_ref_ptr->count) {
					/* It's out of any atomic operation and the object is not
					 * referred by the processor any more
					*/
						if (tmp_ref_ptr1)
							tmp_ref_ptr1->next = tmp_ref_ptr->next;
						else
							obj_ref_list = tmp_ref_ptr->next;
						eif_free(tmp_ref_ptr);
						if (!obj_ref_list)  {
						/* now, delete the separate object's reference list from 
						 * the reference table 
						*/
							if (tmp_tab_ptr)
								tmp_tab_ptr->next = ref_table_ptr->next;
							else 
								_concur_ref_table = ref_table_ptr->next;
							eif_free(ref_table_ptr);
						}
						else
							ref_table_ptr->ref_list = obj_ref_list;
					}
				}
				else {
					add_nl;
					strcat(_concur_crash_info, CURIMPERR8);
					c_raise_concur_exception(exception_implementation_error);
				}
				
			}
			else {
				add_nl;
				strcat(_concur_crash_info, CURIMPERR8);
				c_raise_concur_exception(exception_implementation_error);
			}
			
			/* Now, adjust exported-object-list */
			for(tmp_ptr=NULL, exported_obj=_concur_exported_obj_list; exported_obj && exported_obj->oid != cli_oid; tmp_ptr=exported_obj, exported_obj = exported_obj->next);
			/* found the exported object in the exported object list */
			
			if (exported_obj) {
				(exported_obj->count)--;
				if (!_concur_current_client_reserved && !exported_obj->count) {
				/* It's out of any atomic operation and the object is not
				 * referred by any separate objects,
				 * so delete it from the exported object list,
				 * and before do this, delete it from separate_object_id_set.
				*/
					eif_separate_object_id_free(exported_obj->oid);
					/* delete the exported object from "separate_object_id_set". */
					if (tmp_ptr)	 
						tmp_ptr->next = exported_obj->next;
					else
						_concur_exported_obj_list = exported_obj->next;
					eif_free(exported_obj);
				}
			}
			else {
/*
printf("%d @@@@@@@@@@@@@@@@@@Can't find the exported object in the local processor's EXPORTED LIST <%s, %d, %d> is NULL\n", _concur_pid, c_get_name_from_addr(cli_host), cli_pid, cli_oid);
*/
				add_nl;
				strcat(_concur_crash_info, CURIMPERR8);
				c_raise_concur_exception(exception_implementation_error);
			}
			break;
	}
}

void adjust_exported_objects(hostn, port)
EIF_INTEGER hostn;
EIF_INTEGER port;
{
/* the reason that we have this procedure is:
 * we can't delete an item in REF_TABLE or EXPORTED_OBJ_LIST immediately
 * when the reference count becomes 0. The reason is the asynchronous 
 * modification to requestor's IMPORTED_OBJ_TABLE and provider's
 * REF_TABLE and EXPORTED_OBJ_LIST. The asynchronous modification owes
 * to the fact that we relay on GC to eif_free separate object proxy.
 * So, whenever we exit from an atomic operation, we should clean up
 * the nodes in REF_TABLE and EXPORTED_OBJ_LIST whose reference count
 * becomed 0.
*/
	REF_LIST_NODE *obj_ref_list=NULL;
	REF_LIST_NODE *tmp_ref_ptr, *tmp_ref_ptr1;
	REF_TABLE_NODE *ref_table_ptr, *tmp_tab_ptr;
	EXPORTED_OBJ_LIST_NODE *exported_obj, *tmp_ptr;

	for(tmp_tab_ptr=NULL, ref_table_ptr=_concur_ref_table; ref_table_ptr && (ref_table_ptr->pid!=port || hostn != ref_table_ptr->hostaddr); tmp_tab_ptr=ref_table_ptr, ref_table_ptr=ref_table_ptr->next);
	/* search the exported object table */

	if (ref_table_ptr) {
		obj_ref_list = ref_table_ptr->ref_list;

		for(tmp_ref_ptr=NULL; obj_ref_list; ) {
			if (obj_ref_list->count) {
				if (!tmp_ref_ptr)
					tmp_ref_ptr = obj_ref_list;
				obj_ref_list = obj_ref_list->next;
			}
			else  {
				tmp_ref_ptr1 = obj_ref_list;
				obj_ref_list = obj_ref_list->next;
				eif_free(tmp_ref_ptr1);
			}
		}
	
		if (!tmp_ref_ptr) {
			if (tmp_tab_ptr)
				tmp_tab_ptr->next = ref_table_ptr->next;
			else 
				_concur_ref_table = ref_table_ptr->next;
			eif_free(ref_table_ptr);
		}
		else
			ref_table_ptr->ref_list = tmp_ref_ptr;
	}

	/* Now, adjust exported-object-list */
	for(exported_obj=_concur_exported_obj_list, _concur_exported_obj_list=NULL; exported_obj; ) {
		if (exported_obj->count) {
			exported_obj->pending = 0;
			if (!_concur_exported_obj_list)
				_concur_exported_obj_list = exported_obj;
			exported_obj = exported_obj->next;
		}
		else  {
			eif_separate_object_id_free(exported_obj->oid);
			/* delete the exported object from "separate_object_id_set". */
			tmp_ptr = exported_obj;
			exported_obj = exported_obj->next;
			eif_free(tmp_ptr);
		}
	}

	return;
}
