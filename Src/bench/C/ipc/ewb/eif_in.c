#include "eif_io.h"
#include "ewb.h"
#include "macros.h"

/*
	Eiffel/C interface routines
*/

EIF_OBJ db_info_handler; 
EIF_OBJ job_done_handler;
EIF_OBJ failure_handler;
EIF_OBJ melt_handler;

EIF_PROC db_info_hdlr_set;
EIF_PROC job_done_hldr_set;
EIF_PROC failure_hdlr_set;
EIF_PROC melt_hdlr_set;

void rqst_handler_to_c(eif_rqst_hdlr, rqst_type, eif_set)
EIF_OBJ eif_rqst_hdlr;
EIF_INTEGER rqst_type;
EIF_PROC eif_set;
{
	/* Keep a reference in C to the Eiffel objects 
	 * handling the requests from ised.
	 */

	switch (rqst_type) {
		case REP_DB_INFO:
			db_info_handler = eif_adopt (eif_rqst_hdlr);
			db_info_hdlr_set = eif_set;
			break;
		case REP_JOB_DONE:
			job_done_handler = eif_adopt (eif_rqst_hdlr);
			job_done_hldr_set = eif_set;
			break;
		case REP_FAILURE:
			failure_handler = eif_adopt (eif_rqst_hdlr);
			failure_hdlr_set = eif_set;
			break;
		case REP_MELT:
			melt_handler = eif_adopt (eif_rqst_hdlr);
			melt_hdlr_set = eif_set;
			break;
	}
}

EIF_OBJ request_handler ()
{
	/* Dispatch request from ised to
	 * proper RQST_HANDLER Eiffel object 
	 */

	Request rqst;
	STREAM *sp = stream_by_fd[EWBOUT];
	char *buf;
	char *eif_string;

	recv_packet (readfd(sp), &rqst);

	switch (rqst.rq_type) {
		default: /* default should not be encountered, but
				as long as other cases do not compile... */
		case DEAD:
			eif_string = makestr("Nothing", 7);
			(failure_hdlr_set)(eif_access(failure_handler), eif_string); 
			return eif_access(failure_handler);
	}
/*
		case APP_JOB_DONE:
			sprintf(buf, "%d", rqst.rq_opaque.op_first);
			eif_string = makestr(buf, strlen(buf));
			(job_done_hldr_set)(eif_access(job_done_handler), eif_string);
			return eif_access(job_done_handler);
		case APP_FAILURE:
			eif_string = makestr("Nothing", 7);
			(failure_hdlr_set)(eif_access(failure_handler), eif_string);
			return eif_access(failure_handler);
		case APP_MELT:
			eif_string = makestr("Nothing", 7);
			(melt_hdlr_set)(eif_access(failure_handler), eif_string);
			return eif_access(failure_handler);
	}
*/
}

/* 
	External C routines for the various Eiffel
	request handlers (RQST_HANDLER classes).
*/

public void send_byte_code (real_body_index, real_body_id, byte_array, size)
EIF_INTEGER real_body_index, real_body_id;
char *byte_array;
EIF_INTEGER size;
{

/*
	STREAM *sp;
	Request rqst;

	sp = stream_by_fd [EWBOUT];

	rqst.rq_type = BCODE;
	rqst.rq_opaque.op_first = (int) real_body_index;
	rqst.rq_opaque.op_second = (int) real_body_id;

	if (-1 == send_packet (writefd(sp), &rqst))
			printf ("error\n");

	if (-1 == twrite (byte_array, size))
			printf ("error\n");

	if (-1 == recv_packet (readfd(sp), &rqst))
			printf ("error\n");
	if (rqst.rq_type != ACK || rqst.rq_ack.ak_type != AK_OK)
			printf ("error\n");

*/

}

public int send_breakpoint (real_body_id, offset, opcode)
long real_body_id;
long offset;
EIF_BOOLEAN opcode;
{

/*
	STREAM *sp;
	Request rqst;

	sp = stream_by_fd [EWBOUT];

	rqst.rq_type = BREAK_ON;
	rqst.rq_opaque.op_first = (int) real_body_index;
	rqst.rq_opaque.op_second = (int) real_body_id;
	rqst.rq_opaque.op_third = (long) offset;

	if (-1 == send_packet (writefd(sp), &rqst))
		error
	if (rqst.rq_type != ACK || rqst.rq_ack.ak_type != AK_OK)
			printf ("error\n");

*/
}

public void send_ack_end ()
{
/*
	STREAM *sp = stream_by_fd [EWBOUT];

	send_ack (writefd(sp), AK_OK);
*/

}
