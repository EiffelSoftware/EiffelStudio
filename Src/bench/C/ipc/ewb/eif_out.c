/*

 ######     #    ######           ####   #    #   #####           ####
 #          #    #               #    #  #    #     #            #    #
 #####      #    #####           #    #  #    #     #            #
 #          #    #               #    #  #    #     #     ###    #
 #          #    #               #    #  #    #     #     ###    #    #
 ######     #    #      #######   ####    ####      #     ###     ####

	Externals for dealing with sent (outgoing) requests.
*/

#include "eif_io.h"

extern char *makestr();			/* Run-time make string call */

/*
 * Synchronous requests
 */

public int sync_success;		/* Status of last synchronous request (1=ok) */

public void c_sync_order(code)
int code;		/* Request type */
{
	/* Send the simple request whose specification is given by code */

	Request rqst;
	STREAM *sp = stream_by_fd[EWBOUT];

	rqst.rq_type = code;
	send_packet(writefd(sp), &rqst);
	sync_success = 1;
}

public void c_sync_shell(cmd)
char *cmd;
{
	/* Send the shell command `cmd', to be executed synchronously */

	sync_success = shell(cmd) == 0 ? 1 : 0;
}

public char *c_sync_object(type, index, address)
long type;		/* Variable's type */
long index;		/* Variable's index */
long address;	/* Variable's address */
{
	/* Return a string (tagged_out) of the object in the application, specified
	 * by the given parameters.
	 */

	Request rqst;
	STREAM *sp = stream_by_fd[EWBOUT];
	char *string_read;
	int length;
	char *result;

	rqst.rq_type = INSPECT;
	rqst.rq_opaque.op_first = (int) type;
	rqst.rq_opaque.op_second = (int) index;
	rqst.rq_opaque.op_third = address;
	send_packet(writefd(sp), &rqst);

	tpipe(sp);
	string_read = tread(&length);
	if (string_read == (char *) 0) {
		sync_success = 0;			/* Transmission problem? */
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot receive string");
#endif
		return (char *) 0;
	}

	result = makestr(string_read, length);
	free(string_read);

	return result;
}

/*
 * Asynchronous requests.
 */

public int c_async_order(code)
int code;
{
	/* Send a simple request whose specification is only given by a single code.
	 * The request will be processed asynchronously. Note that it does not buy
	 * you much to do this since the extra fork in the daemon usually takes more
	 * time than the processing of the request itself--RAM. The function
	 * returns the job number of the request.
	 */

	Request rqst;
	STREAM *sp = stream_by_fd[EWBOUT];
 
	rqst.rq_type = code;
	rqst.rq_opaque.op_first = rqstcnt;  /* Use request count as job number */
	send_packet(writefd(sp), &rqst);
	return rqst.rq_opaque.op_first;		 /* The command's job number */
}

public int c_async_shell(cmd)
char *cmd;
{
	/* Send a shell command to be performed in the background and return the
	 * job number of the request. The daemon will fork and execute the command,
	 * then send the command status.
	 */

	return background(cmd);
}

