/*
 * description: "Apache module that sends request data to xebra server and receives page to be displayed."
 * date:		"$Date$"
 * revision:	"$Revision$"
 * copyright:	"Copyright (c) 1985-2007, Eiffel Software."
 * license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
 * licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
 * copying: ""
 * source: 	"[
 * 			Eiffel Software
 * 			5949 Hollister Ave #B, Goleta, CA 93117
 * 			Telephone 805-685-1006, Fax 805-685-6869
 * 			Website http://www.eiffel.com
 * 			Customer support http://support.eiffel.com
 * 			]"
 */

#include "mod_xebra.h"

static void* create_srv_cfg (apr_pool_t* pool, char* x)
{
	xebra_svr_cfg* svr_cfg = apr_palloc (pool, sizeof(xebra_svr_cfg));
	svr_cfg->port = "1234";
	svr_cfg->port = "dinimer";
	return svr_cfg;
}

static const char *set_srv_cfg_port (cmd_parms *parms, void *mconfig,
		const char *arg)
{
	xebra_svr_cfg* svr_cfg = ap_get_module_config (
			parms->server->module_config, &xebra_module);
	svr_cfg->port = (char *) arg;
	return NULL;
}

static const char *set_srv_cfg_host (cmd_parms *parms, void *mconfig,
		const char *arg)
{
	xebra_svr_cfg* svr_cfg = ap_get_module_config (
			parms->server->module_config, &xebra_module);
	svr_cfg->host = (char *) arg;
	return NULL;
}

static int read_from_POST (request_rec* r, char **buf)
{
	int max_loops = 1000; /* hack to prevent endless loops*/
	int bytes, eos;
	apr_size_t count;
	apr_status_t rv;
	apr_bucket_brigade *bb;
	apr_bucket_brigade *bbin;
	char *baf;
	apr_bucket *b;
	const char *clen = apr_table_get (r->headers_in, "Content-Length");

	if (clen != NULL) {
		bytes = strtol (clen, NULL, 0);
		if (bytes >= MAX_POST_SIZE) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r,
					"Request too big (%d bytes; limit %d)", bytes,
					MAX_POST_SIZE);
			return HTTP_REQUEST_ENTITY_TOO_LARGE;
		}
	} else {
		bytes = MAX_POST_SIZE;
	}

	bb = apr_brigade_create (r->pool, r->connection->bucket_alloc);
	bbin = apr_brigade_create (r->pool, r->connection->bucket_alloc);
	count = 0;

	do {

		rv = ap_get_brigade (r->input_filters, bbin, AP_MODE_READBYTES,
				APR_BLOCK_READ, bytes);

		if (rv != APR_SUCCESS) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, rv, r,
					"failed to read form input");
			return HTTP_INTERNAL_SERVER_ERROR;
		}

		for (b = APR_BRIGADE_FIRST (bbin); b != APR_BRIGADE_SENTINEL (bbin); b
				= APR_BUCKET_NEXT (b)) {

			max_loops--;
			if (max_loops < 0) {
				return HTTP_REQUEST_ENTITY_TOO_LARGE;
			}

			/*=======hack to prevent endless loops*/
			if ((b == NULL) || (b->length < 0) || b->length > 1000) {
				break;
			}
			/*=======very strange */

			if (APR_BUCKET_IS_EOS (b)) {
				eos = 1;
			}

			if (!APR_BUCKET_IS_METADATA (b)) {
				if (b->length != (apr_size_t) (-1)) {
					count += b->length;
					if (count > MAX_POST_SIZE) {
						/* More data than we accept, murder the request, but mop up first */
						apr_bucket_delete (b);
					}
				}
			}

			if (count <= MAX_POST_SIZE) {
				APR_BUCKET_REMOVE (b);
				APR_BRIGADE_INSERT_TAIL (bb, b);
			}
		}
	} while (!eos);

	/* done with data, kill request if too much data */
	if (count > MAX_POST_SIZE) {
		ap_log_rerror (APLOG_MARK, APLOG_ERR, rv, r,
				"Request too big (%d bytes; limit %d)", bytes, MAX_POST_SIZE);
		return HTTP_REQUEST_ENTITY_TOO_LARGE;
	}

	(*buf) = apr_palloc (r->pool, count + 1);
	rv = apr_brigade_flatten (bb, (*buf), &count);
	if (rv != APR_SUCCESS) {
		ap_log_rerror (APLOG_MARK, APLOG_ERR, rv, r,
				"Error (flatten) reading form data");
		return HTTP_INTERNAL_SERVER_ERROR;
	}
	(*buf)[count] = '\0';
	return OK;
}

static int print_item (void* rec, const char *key, const char *value)
{
	request_rec* r = rec;
	table_buf = apr_pstrcat (r->pool, table_buf, TABLECSEP, key, TABLERSEP,
			value, TABLERSEP, NULL);
	return 1;
}

static int xebra_handler (request_rec* r)
{

	int sockfd; /* socket it */
	struct addrinfo hints, *servinfo, *p; /* information about connection */
	int rv = OK; /* information about connection */
	char s[INET6_ADDRSTRLEN]; /* information about connection */
	char * message; /* the message to be sent to the server */
	int numbytes; /* number of bytes recieved from server */
	char* rmsg_buf; /* buffer for receiving message */
	char* post_buf;
	char* srv_hostname;
	char* srv_port;
	xebra_svr_cfg *srvc = ap_get_module_config (r->server->module_config,
			&xebra_module);

	if (!r->handler || strcmp (r->handler, "mod_xebra"))
		return DECLINED;

	if ((r->method_number != M_GET) && (r->method_number != M_POST)) {
		return HTTP_METHOD_NOT_ALLOWED;
	}

	DEBUG ("===============NEW REQUEST===============");
	DEBUG ("Reading input...");

	ap_set_content_type (r, "text/html;charset=ascii");

	message = apr_palloc (r->pool, 1);
	message[0] = '\0';

	message = apr_pstrcat (r->pool, message, r->the_request, NULL);

	/* Read headers into message buffer */
	DEBUG2 ("Reading in headers...");

	table_buf = apr_palloc (r->pool, 1);
	table_buf[0] = '\0';
	apr_table_do (print_item, r, r->headers_in, NULL);
	apr_table_do (print_item, r, r->headers_out, NULL);
	apr_table_do (print_item, r, r->subprocess_env, NULL);
	message = apr_pstrcat (r->pool, message, HEADERSKEYWORD, table_buf, NULL);

	/* If there are, read POST parameters into message buffer */
	if (r->method_number == M_POST) {
		DEBUG2 ("Reading POST parameters...");
		const char* ctype = apr_table_get (r->headers_in, "Content-Type");

		if (ctype && (strcasecmp (ctype, "application/x-www-form-urlencoded")
				== 0)) {
			rv = read_from_POST (r, &post_buf);
		}
		if (rv != OK) {
			ap_rputs ("Error reading from data!", r);
			return rv;
		}
		message = apr_pstrcat (r->pool, message, POSTKEYWORD, post_buf, NULL);
	}

	message = apr_pstrcat (r->pool, message, "#END#", NULL);

	/* set up connection to server */
	DEBUG ("Setting up connection.");

	srv_hostname = apr_pstrcat (r->pool, srvc->host, NULL);
	srv_port = apr_pstrcat (r->pool, srvc->port, NULL);

	DEBUG ("Using server host %s and port %s", srv_hostname, srv_port);

	memset (&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;

	if ((rv = getaddrinfo (srv_hostname, srv_port, &hints, &servinfo)) != 0) {
		ap_log_rerror (APLOG_MARK, APLOG_ERR, rv, r, "Getaddrinfo: %s",
				gai_strerror (rv));
		ap_rputs ("Cannot connect to XEbraServer. See error log.", r);
		return OK;
	}

	/* loop through all the results and connect to the first we can */
	for (p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket (p->ai_family, p->ai_socktype, p->ai_protocol))
				== -1) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "error socket");
			ap_rputs ("Cannot connect to XEbraServer. See error log.", r);
			continue;
		}

		if (connect (sockfd, p->ai_addr, p->ai_addrlen) == -1) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "error connect");
			ap_rputs ("Cannot connect to XEbraServer. See error log.", r);
			continue;
		}
		break;
	}

	if (p == NULL) {
		ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "client: failed to connect");
		ap_rputs ("Cannot connect to XEbraServer. See error log.", r);
		return OK;
	}

	inet_ntop (p->ai_family, get_in_addr ((struct sockaddr *) p->ai_addr), s,
			sizeof s);

	freeaddrinfo (servinfo);

	DEBUG ("Connected.");

	DEBUG ("Sending message.");

	if (!send_message_fraged (message, sockfd, r)) {
		ap_rputs ("Error sending message. See error log.", r);
		return OK;
	}

	DEBUG ("Messages sent. Now waiting for back message...");

	numbytes = receive_message_fraged (&rmsg_buf, sockfd, r);

	if (numbytes < 1) {
		ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r,
				"error in receive_message_fraged");
		ap_rputs ("Error receiving message. See error log.", r);
		return OK;
	}

	DEBUG ("All receiving ok.");

	/* display received message */
	ap_rputs (rmsg_buf, r);
	//free (rmsg_buf); apache does it

	shutdown (sockfd, 2);
	close (sockfd);

	return OK;
}

EIF_INTEGER_32 byteArrayToInt (char * b)
{
	return (b[0] << 24) + ((b[1] & 0xFF) << 16) + ((b[2] & 0xFF) << 8) + (b[3]
			& 0xFF);
}

char * intToByteArray (request_rec* r, EIF_INTEGER_32 i)
{
	char * bb;
	bb = apr_palloc (r->pool, 4);
	bb[0] = (char) (i >> 24);
	bb[1] = (char) (i >> 16);
	bb[2] = (char) (i >> 8);
	bb[3] = (char) i;
	return bb;
}

EIF_NATURAL_32 encode_natural (EIF_NATURAL_32 i, EIF_BOOLEAN flag)
{
	REQUIRE ("i_not_to_big", i < 2 ^ 31);

	return (i << 1) + flag;
}

EIF_NATURAL_32 decode_natural (EIF_NATURAL_32 i)
{
	return (i >> 1);
}

EIF_BOOLEAN decode_flag (EIF_NATURAL_32 i)
{
	return (i & 1);
}

void* get_in_addr (struct sockaddr *sa)
{
	if (sa->sa_family == AF_INET) {
		return &(((struct sockaddr_in*) sa)->sin_addr);
	}

	return &(((struct sockaddr_in6*) sa)->sin6_addr);
}

EIF_INTEGER_32 send_message_fraged (char * message, EIF_INTEGER_32 sockfd,
		request_rec* r)
{
	EIF_INTEGER_32 numbytes = -1; /* how much was sent in the last recv*/
	EIF_NATURAL_32 bytes_of_msg_sent = 0; /* how much is already sent (total) */
	char * encoded_msg_length_byte; /* encoded size (as byte) of (frag of) message with frag flag */
	char * frag_msg; /* conatins the frag of message that is sent in the current loop */
	char * m_pointer; /* points to the start of part of message from where in the next step FRAG_SIZE byte will be sent */

	DEBUG ("About to send message. Length is %i bytes", (int) strlen (message));

	/* Create fragment */
	DEBUG2 ("   ---trying malloc...frag_msg     ");
	frag_msg = (char*) malloc (sizeof(char) * FRAG_SIZE + 1);
	DEBUG2 ("ok");

	if (frag_msg == NULL) {
		ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "Error mallocating!");
		return 0;
	}

	frag_msg[0] = (char) 0;

	/* initially, the m_pointer points to the start of message (to the whole message) */
	m_pointer = message;

	/* loop until the whole message has been sent */
	while (bytes_of_msg_sent < strlen (message)) {

		/* do we have to fragment the (current lenght of) message or not */
		if (strlen (m_pointer) <= FRAG_SIZE) {
			/* we don't have to */

			/* free the space for frag_msg before we attach it to another location */
			free (frag_msg);
			frag_msg = m_pointer;

			DEBUG (" -About to send last fragment. Length is %i bytes",
					(int) strlen (frag_msg));

			/* encode last fragment */
			encoded_msg_length_byte = intToByteArray (r, encode_natural (
					strlen (frag_msg), 0));
		} else {
			/* we have to fragment the message*/

			/* copy FRAG_SIZE bytes from the original message (=m_pointer) into the frag_msg, which will be sent then */
			strncpy (frag_msg, m_pointer, sizeof(char) * FRAG_SIZE);
			frag_msg[sizeof(char) * FRAG_SIZE] = '\0';

			DEBUG ("-About to send fragment. Length is %i bytes", (int) strlen (
					frag_msg));

			/* encode frag_msg */
			encoded_msg_length_byte = intToByteArray (r, encode_natural (
					strlen (frag_msg), 1));
		}

		DEBUG (" -Sending... ");
		DEBUG2 ("'%s'", frag_msg);

		/* send encoded messagte length */
		numbytes = send (sockfd, encoded_msg_length_byte, sizeof(int), 0);
		if (numbytes < 1) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r,
					"failed to send encoded_msg_lengh");
			return 0;
		}

		//free (encoded_msg_length_byte); ap does it

		/* send message */
		numbytes = send (sockfd, frag_msg, strlen (frag_msg) * sizeof(char), 0);

		if (numbytes < 1) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r,
					"failed to send frag_msg");
			return 0;
		}

		bytes_of_msg_sent += strlen (frag_msg) * sizeof(char);

		/* shift m_pointer to the right to 'cut off' the already sent part (=frag_msg) */
		m_pointer = m_pointer + (sizeof(char) * FRAG_SIZE);
	}

	/* all ok */
	return 1;
}

EIF_INTEGER_32 receive_message_fraged (char **msg_buf, EIF_INTEGER_32 sockfd,
		request_rec* r)
{
	EIF_INTEGER_32 msg_buf_strlength; /* string length of *msg_buf */
	char* frag_buf; /* stores the frag to be received */
	EIF_INTEGER_32 numbytes = 0; /* received bytes */
	char frag_length_byte[sizeof(int)]; /* length of received frag (bytes) */
	EIF_NATURAL_32 frag_length; /* length of received frag (int) */
	EIF_BOOLEAN flag = 0; /* contains the frag flag of the just received msg */
	EIF_NATURAL_32 bytes_to_receive = 0; /* how many bytes are we going to receive in this frag */
	EIF_NATURAL_32 frag_length_int; /* buffer to copy msg */
	char buf[sizeof(char) * FRAG_SIZE + 1]; /* buffer to receive message fragment fragments */
	EIF_INTEGER_32 bytes_recv; /* number of bytes receivced for one fragment */

	DEBUG ("Receiving message...");

	//DEBUG2 ("   ---trying apr_palloc...*msg_buf        ");
	//(*msg_buf) = (char*) malloc (1);
	(*msg_buf) = apr_palloc (r->pool, 1);
	//DEBUG2 ("ok");

	/* resetting *msg_buf */
	*msg_buf[0] = '\0';
	msg_buf_strlength = 0;

	/* create buffer to receive message fragment */
	//DEBUG2 ("   ---trying malloc...*frag_buf          ");
	//frag_buf = (char*) malloc (sizeof(char) * FRAG_SIZE + 1);
	frag_buf = apr_palloc (r->pool, 1);
	frag_buf[0] = '\0';
	//DEBUG2 ("ok");

	//if ((frag_buf) == NULL) {
	//	ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "Error pallocating frag_buf!");
	//	return 0;
	//}

	/* loop until we recieve a fragment with flag=0 */
	do {
		/* receive first 4 bytes determining length of message */
		numbytes = recv (sockfd, frag_length_byte, sizeof(int), 0);
		if (numbytes != sizeof(int)) {
			ap_log_rerror (
					APLOG_MARK,
					APLOG_ERR,
					0,
					r,
					"Failed to receive fragment length. Received %i bytes instead of 4 bytes",
					numbytes);
			return 0;
		}

		/* decode */
		frag_length_int = byteArrayToInt (frag_length_byte);
		frag_length = decode_natural (frag_length_int);
		flag = decode_flag (frag_length_int);

		DEBUG ("Incoming frag, %i bytes, flag is %i", frag_length, flag);

		//strcpy (frag_buf, "");
		bytes_recv = 0;

		/* loop to recieve whole fragement */
		while (bytes_recv < frag_length) {
			numbytes = recv (sockfd, buf, frag_length - bytes_recv, 0);
			buf[numbytes] = '\0';

			DEBUG2 ("  --filling buffer...%i bytes", numbytes);
			DEBUG2 ("  --'%s'", buf);

			if (numbytes < 1) {
				ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r,
						"Failed to receive message. numbytes=%i", numbytes);
				return 0;
			}
			bytes_recv += numbytes;
			frag_buf = apr_pstrcat (r->pool, frag_buf, buf, NULL);
		}

		numbytes = bytes_recv;

		if (numbytes != frag_length) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r,
					"ERROR, received bytes=%i, frag_lengh is %i", numbytes,
					frag_length);
			return 0;
		}

		frag_buf[numbytes] = '\0';

		DEBUG ("Recieved %i bytes...:", numbytes);
		DEBUG2 ("'%s'", frag_buf);

		/* extend *msg_buf and copy frag to end of it */
		//*msg_buf
		//		= (char *) realloc (*msg_buf, msg_buf_strlength + numbytes + 1);
		//memcpy (*msg_buf + msg_buf_strlength, frag_buf, numbytes);

		(*msg_buf) = apr_pstrcat (r->pool, (*msg_buf), frag_buf, NULL);

		msg_buf_strlength += numbytes;
	} while (flag == 1);

	//free (frag_buf);

	DEBUG ("Completed recieving message.");

	return msg_buf_strlength;
}

static void register_hooks (apr_pool_t* pool)
{
	ap_hook_handler (xebra_handler, NULL, NULL, APR_HOOK_MIDDLE);
}

module AP_MODULE_DECLARE_DATA xebra_module = { STANDARD20_MODULE_STUFF, NULL,
		NULL, create_srv_cfg, NULL, xebra_cmds, register_hooks };
