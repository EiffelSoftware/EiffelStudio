
/*****************************************************************
	In the C-programs, we use EIF_OBJECT and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#include "eif_net.h"
#include "eif_curextern.h"
#define tSTOP_GC

#define STOP_GC
#define tDEBUG
								   
void separate_server()
{
/* perform server function for the local processor.
 * Whenever it get a request from a client, it servers it.
 * It supports FCFS principle, keeps the atomicity of an application
 * operation.
 * Simply to say(not exactly), it finishes when there is no pending client
 * (i.e., no reference to the local objects from other
 * processors).
*/

	CHILD *tmp_child;
	CLIENT *tmp_client;
	fd_set tmp_read_mask;
	fd_set tmp_except_mask;
	int ready_nb, tmp_count;



#ifndef EIF_WIN32
	c_reset_timer();
	/* used to decide when to start GC.
	 * In the implementation, we use GC to release network connection
	 * between separate objects, we will start GC explicitly once after
	 * a certain period. The function call here is to start the "TIMER".
	*/
#endif


	memcpy(&tmp_read_mask, &_concur_mask, sizeof(fd_set));
	memcpy(&tmp_except_mask, &_concur_mask, sizeof(fd_set));

	c_concur_select(ready_nb, _concur_mask_limit.up+1, &tmp_read_mask, NULL, &tmp_except_mask, 1, 0);

#ifndef STOP_GC
#ifdef GC_ON_CPU_TIME
	if (!ready_nb && c_wait_time() >= constant_cpu_period) {
#else
	if (!ready_nb && c_wait_time() >= constant_absolute_period) {
#endif
		plsc();
		c_reset_timer();
	}
#endif

	if (FD_ISSET(_concur_sock, &tmp_read_mask)) {
	/* there is 'connection" request, process it */
		ready_nb--;
		/* we will process the request on one socket, so
		 * decrease the number.
		*/
		process_connection();
	}

	if (ready_nb) {
		tmp_count = process_exception(&tmp_except_mask);
		ready_nb -= tmp_count;
	}

#ifdef DEBUG
if (ready_nb > 1) {
	printf("\n%d MASK=", _concur_pid);
	for(tmp_count=_concur_mask_limit.low; tmp_count<=_concur_mask_limit.up; tmp_count++)
		if (FD_ISSET(tmp_count, &_concur_mask))
			printf(" %d ", tmp_count);
	printf("\n");
	printf("%d READY=", _concur_pid);
	for(tmp_count=_concur_mask_limit.low; tmp_count<=_concur_mask_limit.up; tmp_count++)
		if (FD_ISSET(tmp_count, &tmp_read_mask))
			printf(" %d ", tmp_count);
	printf("\n");
	printf("%d current=%d, cli_list_count=%d, blk_cli_list_count=%d\n", _concur_pid, _concur_current_client!=NULL, _concur_cli_list_count, _concur_blk_cli_list_count);
	if (_concur_current_client)
		printf("%d(%s) **** Current_client=<%s, %d, %d>, There are %d requests ready now\n", _concur_pid, _concur_class_name_of_root_obj, c_get_name_from_addr(_concur_current_client->hostaddr), _concur_current_client->pid, _concur_current_client->sock, ready_nb);
	else
		printf("%d(%s) **** Current_client=%x, There are %d requests ready now\n" , _concur_pid, _concur_class_name_of_root_obj, _concur_current_client, ready_nb);
	for(tmp_client=_concur_blk_cli_list; tmp_client; tmp_client=tmp_client->next)
		printf("%d(%s) Blocked Client <%s, %d, %d, %s>\n", _concur_pid, _concur_class_name_of_root_obj, c_get_name_from_addr(tmp_client->hostaddr), tmp_client->pid, tmp_client->sock, command_text(tmp_client->req_buf.command));
	for(tmp_client=_concur_cli_list; tmp_client; tmp_client=tmp_client->next)
		printf("%d(%s) Normal  Client <%s, %d, %d, %s>\n", _concur_pid, _concur_class_name_of_root_obj, c_get_name_from_addr(tmp_client->hostaddr), tmp_client->pid, tmp_client->sock, command_text(tmp_client->req_buf.command));
}
#endif
	if (ready_nb) {
		if (_concur_current_client) {
			if (FD_ISSET(_concur_current_client->sock, &tmp_read_mask)) {
			/* There is request from the current client, so processes it
			 * and then try to get the next request from the client
			 * until we finished the atomic application operation
			 * or there is no request arrived at the moment,
			 * in the case, we process some of other clients'
			 * requests.
			*/
				directly_get_cmd_data(_concur_current_client->sock);
				/* The following statement will check the Invarient if applicable.
				 */
				separate_call();
				/* If this is the last request of the application
				 * operation, we should try to get another client as
				 * the current and server it.
				*/
				ready_nb--;
				if (!_concur_current_client)
					if (_concur_blk_cli_list_count) {
						if (ready_nb)
							idle_usage(ready_nb, &tmp_read_mask, 0);
						_concur_current_client = take_head_from_blocked_client_list();
						/* The blocked request must be RESERVE_SEP_OBJ.  If
						 * REJECT to the request is available, then no request
						 * will be blocked here.
						*/
						_concur_command = (_concur_current_client->req_buf).command;
						_concur_para_num = (_concur_current_client->req_buf).para_num;
						(_concur_current_client->req_buf).command = constant_not_defined;
						get_data(_concur_current_client->sock);
						if (_concur_command != constant_reserve) {
							add_nl;
							sprintf(crash_info, CURIMPERR2, "RESERVE_SEP_OBJ", command_text(_concur_command), "separate_server");
							c_raise_concur_exception(exception_unexpected_request);
						}
						separate_call(); 
					}
					else
						if (ready_nb)
							idle_usage(ready_nb, &tmp_read_mask, 1);
				else
					if (ready_nb)
						idle_usage(ready_nb, &tmp_read_mask, 0);
			}
			else {
			/* There are requests from other clients, processes them */
			   idle_usage(ready_nb, &tmp_read_mask, 0);
			}
		}
		else {
		/* Process the requests from the clients, then Choose the first
		* client who has application request as
		 * the current client and process its requests.
		*/
			if (_concur_blk_cli_list_count)
				idle_usage(ready_nb, &tmp_read_mask, 0);
			else
				idle_usage(ready_nb, &tmp_read_mask, 1);
			if (!_concur_current_client && _concur_blk_cli_list_count) {
				_concur_current_client = take_head_from_blocked_client_list();
				/* The blocked request must be RESERVE_SEP_OBJ. If
				 * REJECT to the request is available, then no request
				 * will be blocked here.
				*/
				_concur_command = (_concur_current_client->req_buf).command;
				_concur_para_num = (_concur_current_client->req_buf).para_num;
				(_concur_current_client->req_buf).command = constant_not_defined;
				get_data(_concur_current_client->sock);
				if (_concur_command != constant_reserve) {
					add_nl;
					sprintf(crash_info, CURIMPERR2, "RESERVE_SEP_OBJ", command_text(_concur_command), "separate_server");
					c_raise_concur_exception(exception_unexpected_request);
				}
				separate_call(); 
			}
		}
	}

	return;
}
																	 
