/*

 ######     #    ######             #    #    #           ####
 #          #    #                  #    ##   #          #    #
 #####      #    #####              #    # #  #          #
 #          #    #                  #    #  # #   ###    #
 #          #    #                  #    #   ##   ###    #    #
 ######     #    #      #######     #    #    #   ###     ####

	External for dealing with received (incoming) requests.
*/

#include "eif_io.h"
#include "cecil.h"
#include "plug.h"
#include "hector.h"

EIF_OBJ app_break_request;
EIF_OBJ app_except_request;
EIF_OBJ app_exit_request;
EIF_OBJ job_done_request;

EIF_PROC break_set;
EIF_PROC except_set;
EIF_PROC exit_set;
EIF_PROC jobdone_set;


char *received_request()
{
	/*
	 * Eiffel object descendant of IN_REQUEST, built from what's in the pipe.
	 * Called from Eiffel when the callback is triggered
	 * one of the globally declared EIF_OBJ
	 */

	Request rqst;
	STREAM *sp = stream_by_fd[EWBOUT];
	int request_type, app_message_type;
	char buf[20];
	char *eiffel_string;

	recv_packet (readfd(sp), &rqst);
	request_type = rqst.rq_type;

printf ("In eif_in.c, request type got on pipe is: %d", request_type);

	switch (request_type) {
		case APP_MSG:
			app_message_type = rqst.rq_opaque.op_first;
			switch (app_message_type) {
				case APP_BREAK:
					eiffel_string = makestr("2", 1);
					(break_set)(eif_access(app_break_request), eiffel_string);
					return eif_access(app_break_request);
					break;
				case APP_EXECPT:
					eiffel_string = makestr("2", 1);
					(except_set)(eif_access(app_except_request), eiffel_string);
					return eif_access(app_except_request);
					break;
				case APP_EXIT:
					eiffel_string = makestr("2", 1);
					(exit_set)(eif_access(app_exit_request), eiffel_string);
					return eif_access(app_exit_request);
					break;
				}
		case ASYNACK:
			/*
			sprintf(buf,"%d (%s)",rqst.rq_opaque.op_first,
				rqst.rq_opaque.op_second == AK_OK ? "Succeeded":"Failed");
			*/
sprintf(buf,"%d",rqst.rq_opaque.op_first);
			eiffel_string = makestr(buf, strlen(buf));
			(jobdone_set)(eif_access(job_done_request), eiffel_string);
			return eif_access(job_done_request);
			break;
		}
}

/*
 * Initialization routines for `received_request'
 */

void eifin_set(eiffel_request, request_type, setid_function)
EIF_OBJ eiffel_request;
EIF_INTEGER request_type;
EIF_PROC setid_function;
	{
	switch (request_type) {
		case APP_BREAK:
			app_break_request = eif_adopt(eiffel_request);
			break_set = setid_function;
			break;
		case APP_EXECPT:
			app_except_request = eif_adopt(eiffel_request);
			except_set = setid_function;
			break;
		case APP_EXIT:
			app_exit_request = eif_adopt(eiffel_request);
			exit_set = setid_function;
			break;
		case APP_JOBSTATUS:
			job_done_request = eif_adopt(eiffel_request);
			jobdone_set = setid_function;
			break;
		}
	}
