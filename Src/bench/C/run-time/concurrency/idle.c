#include "net.h"
#include "curextern.h"

/* if we want that a processor can release all resources(separate objects)
 * currently held by itself when it can't get another resource, we should
 * define `with_rejection' option, otherwise, we just unset it.
*/

void idle_usage(check_nb, read_mask, assign_current) 
/* the function take advantage of any idle time to process the REGISTER/
 * UNREGISTER/RELEASE/RESERVE_SEP_OBJ requests to non-current Clients, so  
 * that the concurrent level can be improved.
 * The precondition of calling the function is:
 *    The current processor has been reserved, i.e, it's not free now.
 * CAUTION: the function will destroy the REQUEST environment, i.e., 
 * it may modify the values stored in:
 *    _concur_command
 *    _concur_command_oid
 *    _concur_command_ack
 *    _concur_command_class
 *    _concur_command_feature
 *    _concur_para_num
*/
int check_nb;				/* The number of sockets with requests
							 * in the `read_mask'.
							*/
fd_set *read_mask;			/* The mask returned by SELECT */
EIF_BOOLEAN assign_current; /* Assign the first client with application
							 * operation as the current client and server it.
							*/
{
	int i;
	CLIENT *cur_client, *cur_client_bak;

	EIF_BOOLEAN current_assignable = assign_current;

	EIF_BOOLEAN tmp_reserved;


	/* Now, we try to server REGISTER/UNREGISTER/RELEASE requests from other 
	 * processor. For each processed client, we will process the requests
	 * from the client until a non REGISTER/UNREGISTER?RELEASE request is
	 * met or the client is deleted from the client list.
	*/
	for(i=0, cur_client_bak=NULL, cur_client=_concur_cli_list; i<check_nb && cur_client; ) {
		if (FD_ISSET(cur_client->sock, read_mask) && (cur_client->req_buf).command == constant_not_defined) {
			directly_get_command(cur_client->sock);

			if (_concur_command == constant_register) {
#ifdef DISP_MSG
printf("%d/%d Got Command(in idle_usage) %s  para#: %d\n", _concur_pid, cur_client->sock, command_text(_concur_command), _concur_para_num);
#endif
				get_data(cur_client->sock);
#ifdef DISP_LIST
                printf("%d Before %s(on %s from <%s, %d, %d>):\n", _concur_pid, command_text(_concur_command), _concur_class_name_of_root_obj, CURGS(0), CURGI(1), CURGI(2));
                print_ref_table_and_exported_object();
#endif
				(cur_client->count)++;
				if (_concur_command == constant_register)
					send_register_ack(cur_client->sock);
				change_ref_table_and_exported_obj_list(cur_client->hostaddr, cur_client->pid, _concur_paras[2].uval.int_val, 1);
#ifdef DISP_LIST
                printf("%d After %s(on %s)\n", _concur_pid, command_text(_concur_command), _concur_class_name_of_root_obj);
                print_ref_table_and_exported_object();
#endif
				continue;
			}

			if (_concur_command == constant_unregister) {
#ifdef DISP_MSG
printf("%d/%d[%s,%d] Got Command(in idle_usage) %s  para#: %d\n", _concur_pid, cur_client->sock, c_get_name_from_addr(cur_client->hostaddr), cur_client->pid, command_text(_concur_command), _concur_para_num);
#endif
				get_data(cur_client->sock);
#ifdef DISP_LIST
                printf("%d Before %s(on %s from <%s, %d, %d>):\n", _concur_pid, command_text(_concur_command), _concur_class_name_of_root_obj, c_get_name_from_addr(cur_client->hostaddr), cur_client->pid, CURGI(0));
                print_ref_table_and_exported_object();
#endif
				tmp_reserved = _concur_current_client_reserved;
				_concur_current_client_reserved = 0;
				change_ref_table_and_exported_obj_list(cur_client->hostaddr, cur_client->pid, _concur_paras[0].uval.int_val, -1);
				_concur_current_client_reserved = tmp_reserved;
				(cur_client->count)--;
				if (cur_client->count == 0) {
					unset_mask(cur_client->sock);
					/* clear the socket from the socket mask */
					c_concur_close_socket(cur_client->sock);
					cur_client->sock = -2;
					if (cur_client_bak) {
						cur_client_bak->next = cur_client->next;
						if (_concur_end_of_cli_list == cur_client)
							_concur_end_of_cli_list = cur_client_bak; 
						free(cur_client);
						cur_client = cur_client_bak;
					}
					else {
						_concur_cli_list = cur_client->next;	
						if (_concur_end_of_cli_list == cur_client)
							_concur_end_of_cli_list = _concur_cli_list; 
						free(cur_client);
						cur_client = _concur_cli_list;
					}
					i++;
					(_concur_cli_list_count)--;
				}
#ifdef DISP_LIST
                printf("%d After %s(on %s)\n", _concur_pid, command_text(_concur_command), _concur_class_name_of_root_obj);
                print_ref_table_and_exported_object();
#endif
				continue;
			}

			if (_concur_command == constant_release) {
#ifdef DISP_MSG
printf("%d/%d[%s,%d] Got Command(in idle_usage) %s  para#: %d\n", _concur_pid, cur_client->sock, c_get_name_from_addr(cur_client->hostaddr), cur_client->pid, command_text(_concur_command), _concur_para_num);
#endif
				get_data(cur_client->sock);
#ifdef DISP_LIST
                printf("%d Before %s(on %s from <%s, %d>):\n", _concur_pid, command_text(_concur_command), _concur_class_name_of_root_obj, c_get_name_from_addr(cur_client->hostaddr), cur_client->pid);
                print_ref_table_and_exported_object();
#endif
				change_ref_table_and_exported_obj_list(cur_client->hostaddr, cur_client->pid, constant_not_defined, constant_release_all);
				unset_mask(cur_client->sock);
				/* clear the socket from the socket mask */
				c_concur_close_socket(cur_client->sock);
				cur_client->sock = -2;
				if (cur_client_bak) {
					cur_client_bak->next = cur_client->next;
					if (_concur_end_of_cli_list == cur_client)
						_concur_end_of_cli_list = cur_client_bak; 
					free(cur_client);
					cur_client = cur_client_bak->next;
				}
				else {
					_concur_cli_list = cur_client->next;	
					if (_concur_end_of_cli_list == cur_client)
						_concur_end_of_cli_list = _concur_cli_list; 
					free(cur_client);
					cur_client = _concur_cli_list;
				}
				(_concur_cli_list_count)--;
				i++;
#ifdef DISP_LIST
                printf("%d After %s(on %s)\n", _concur_pid, command_text(_concur_command), _concur_class_name_of_root_obj);
                print_ref_table_and_exported_object();
#endif
				continue;
			}

			if (_concur_command == constant_reserve) {
				if (current_assignable) {
					/* first, we assign the first client with
					 * application operation to be the current client.
					*/
					if (cur_client_bak) {
						cur_client_bak->next = cur_client->next;
						if (_concur_end_of_cli_list == cur_client)
							_concur_end_of_cli_list = cur_client_bak; 
						_concur_current_client = cur_client;
						cur_client = cur_client_bak->next;
					}
					else {
						_concur_cli_list = cur_client->next;	
						if (_concur_end_of_cli_list == cur_client)
							_concur_end_of_cli_list = _concur_cli_list; 
						_concur_current_client = cur_client;
						cur_client = _concur_cli_list;
					}
					(_concur_cli_list_count)--;
					i++;
					get_data(_concur_current_client->sock);
					/* Now, we answer the RESERVE_SEP_OBJ request. */
#ifdef DISP_LIST
            printf("%d Before Reserve(on %s from <%s, %d>):\n", _concur_pid, _concur_class_name_of_root_obj, c_get_name_from_addr(_concur_current_client->hostaddr), _concur_current_client->pid);
            print_ref_table_and_exported_object();
#endif
		            _concur_current_client_reserved = 1;
		            _concur_command = constant_reserve_ack;
	        		_concur_para_num = 0;
		            send_command(_concur_current_client->sock);
		            (_concur_current_client->reservation)++;
#ifdef DISP_LIST
            printf("%d After Reserve(on %s from <%s, %d>):\n", _concur_pid, _concur_class_name_of_root_obj, c_get_name_from_addr(_concur_current_client->hostaddr), _concur_current_client->pid);
            print_ref_table_and_exported_object();
#endif
					/* and last, we prevent another client as the
					 * current client in the idle usage session.
					*/
					current_assignable = 0;

					continue;
				}
				else  {
				/* the current separate object is busy, so reject the 
				 * RESERVE_SEP_OBJ request, and let the requestor to 
				 * try again. 
				*/
					if (is_with_rejection) {
#ifdef DISP_MSG
printf("%d In IDLE_USAGE got command %s, para_num=%d and return REJECT_TO_RESERVE_SEP_OBJ\n", _concur_pid, command_text(_concur_command), _concur_para_num);
#endif
						_concur_command = constant_reserve_fail;
						_concur_para_num = 0;
						send_command(cur_client->sock);	
						cur_client_bak = cur_client;
						cur_client = cur_client->next;
						i++;
						continue;
					}
				}
			}

			if (is_with_rejection) {
				add_nl;
				sprintf(crash_info, CURIMPERR2, "Nothing", command_text(_concur_command), "idle_usage");
				c_raise_concur_exception(exception_unexpected_request);
			}

			/* Now, we store the request's CODE part(no data) into the 
			 * client's node. Then we remove the socket from the
			 * socket mask and put it into `blocked client list'.
			*/
			(cur_client->req_buf).command = _concur_command;
			(cur_client->req_buf).para_num = _concur_para_num;
			if (_concur_command >= 0) {
				(cur_client->req_buf).command_oid = _concur_command_oid;
				(cur_client->req_buf).command_ack = _concur_command_ack;
				strcpy((cur_client->req_buf).command_class, _concur_command_class);
				strcpy((cur_client->req_buf).command_feature, _concur_command_feature);
			}
			if (cur_client_bak) {
				cur_client_bak->next = cur_client->next;
				if (_concur_end_of_cli_list == cur_client)
					_concur_end_of_cli_list = cur_client_bak; 
				add_to_blocked_client_queue(cur_client);
				cur_client = cur_client_bak->next;
			}
			else {
				_concur_cli_list = cur_client->next;	
				if (_concur_end_of_cli_list == cur_client)
					_concur_end_of_cli_list = _concur_cli_list; 
				add_to_blocked_client_queue(cur_client);
				cur_client = _concur_cli_list;
			}
			(_concur_cli_list_count)--;
			i++;
			continue;
		}
		else {
			cur_client_bak = cur_client;
			cur_client = cur_client->next;
		}
	}
	return;
}
