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
 * 			356 Storke Road, Goleta, CA 93117 USA
 * 			Telephone 805-685-1006, Fax 805-685-6869
 * 			Website http://www.eiffel.com
 * 			Customer support http://support.eiffel.com
 * 			]"
 */

#include "mod_xebra.h"

#define MAX_SIZE 1000 /*TODO: give this a better name */

static int read_from_POST (request_rec* r, char **buf)
{

	DEBUG2 ("start read post");
	int max_loops = 100; /* hack*/

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
		if (bytes >= MAX_SIZE) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r,
					"Request too big (%d bytes; limit %d)", bytes, MAX_SIZE);
			return HTTP_REQUEST_ENTITY_TOO_LARGE;
		}
	} else {
		bytes = MAX_SIZE;
	}

	DEBUG2 ("create brigades");

	bb = apr_brigade_create (r->pool, r->connection->bucket_alloc);
	bbin = apr_brigade_create (r->pool, r->connection->bucket_alloc);
	count = 0;

	do {

		DEBUG2 ("do");

		rv = ap_get_brigade (r->input_filters, bbin, AP_MODE_READBYTES,
				APR_BLOCK_READ, bytes);

		if (rv != APR_SUCCESS) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, rv, r,
					"failed to read form input");
			return HTTP_INTERNAL_SERVER_ERROR;
		}

		for (b = APR_BRIGADE_FIRST (bbin); b != APR_BRIGADE_SENTINEL (bbin); b
				= APR_BUCKET_NEXT (b)) {

			DEBUG2 ("for");
			max_loops--;
			if (max_loops < 0) {
				return HTTP_REQUEST_ENTITY_TOO_LARGE;
			}

			/*=======hack*/
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
					if (count > MAX_SIZE) {
						/* More data than we accept, murder the request, but mop up first */
						apr_bucket_delete (b);
					}
				}
			}

			if (count <= MAX_SIZE) {
				APR_BUCKET_REMOVE (b);
				APR_BRIGADE_INSERT_TAIL (bb, b);
			}

			if (b == NULL) {
				DEBUG2 ("b is NULL!");
			} else {
				DEBUG2 ("length is %i, type is %s", b->length, b->type->name);

			}

		}
	} while (!eos);

	DEBUG2 ("end while");

	/* done with data, kill request if too much data */
	if (count > MAX_SIZE) {
		ap_log_rerror (APLOG_MARK, APLOG_ERR, rv, r,
				"Request too big (%d bytes; limit %d)", bytes, MAX_SIZE);
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

static int xebra_handler (request_rec* r)
{

	int sockfd; /* socket it */
	struct addrinfo hints, *servinfo, *p; /* information about connection */
	int rv = OK; /* information about connection */
	char s[INET6_ADDRSTRLEN]; /* information about connection */
	char * message; /* the message to be sent to the server */
	char * hname = HOSTNAME; /* hostname of server */
	int numbytes; /* number of bytes recieved from server */
	char* rmsg_buf; /* buffer for receiving message */
	char* post_buf;

	if (!r->handler || strcmp (r->handler, "mod_xebra"))
		return DECLINED;

	if ((r->method_number != M_GET) && (r->method_number != M_POST)) {
		return HTTP_METHOD_NOT_ALLOWED;
	}

	DEBUG ("===============NEW REQUEST===============");
	DEBUG ("Reading input...");

	ap_set_content_type (r, "text/html;charset=ascii");

	if (r->method_number == M_POST) {
		ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "it is post");
		const char* ctype = apr_table_get (r->headers_in, "Content-Type");

		if (ctype && (strcasecmp (ctype, "application/x-www-form-urlencoded")
				== 0)) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "reading....");
			rv = read_from_POST (r, &post_buf);
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "read");

		} else {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "not good ctype");
		}

		if (rv != OK) {
			// ap_rputs ("Error reading from data!",r);
			return rv;
		}

		message = apr_palloc (r->pool, strlen (post_buf) + strlen (
				r->the_request) + 1);
		//	message = apr_pstrcat (r->pool, r->the_request, post_buf);


		// message = apr_palloc (r->pool, strlen(post_buf) + strlen(r->the_request) +1 );
		strcpy (message, "");
		strcat (message, r->the_request);
		strcat (message, post_buf);
		//memcpy (*msg_buf + msg_buf_strlength, frag_buf, numbytes);


	} else {
		message = r->the_request;
	}

	/* set up connection to server */
	DEBUG ("Setting up connection.\n");

	memset (&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;

	if ((rv = getaddrinfo (hname, PORT, &hints, &servinfo)) != 0) {
		fprintf (stderr, "getaddrinfo: %s\n", gai_strerror (rv));
		fflush (stderr);
		ap_rputs ("Cannot connect to XEbraServer. See error log.", r);
		return HTTP_INTERNAL_SERVER_ERROR;
	}

	/* loop through all the results and connect to the first we can */
	for (p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket (p->ai_family, p->ai_socktype, p->ai_protocol))
				== -1) {
			fprintf (stderr, "error socket");
			fflush (stderr);
			ap_rputs ("Cannot connect to XEbraServer. See error log.", r);
			continue;
		}

		if (connect (sockfd, p->ai_addr, p->ai_addrlen) == -1) {
			fprintf (stderr, "error connect");
			fflush (stderr);
			ap_rputs ("Cannot connect to XEbraServer. See error log.", r);
			continue;
		}

		break;
	}

	if (p == NULL) {
		fprintf (stderr, "client: failed to connect\n");
		fflush (stderr);
		ap_rputs ("Cannot connect to XEbraServer. See error log.", r);
		return HTTP_INTERNAL_SERVER_ERROR;
	}

	inet_ntop (p->ai_family, get_in_addr ((struct sockaddr *) p->ai_addr), s,
			sizeof s);

	freeaddrinfo (servinfo);

	DEBUG ("Connected.\n");

	DEBUG ("Sending message.\n");

	if (!send_message_fraged (message, sockfd, r)) {
		ap_rputs ("Error sending message. See error log.", r);
		return HTTP_INTERNAL_SERVER_ERROR;
	}

	DEBUG ("Messages sent. Now waiting for back message...\n");

	numbytes = receive_message_fraged (&rmsg_buf, sockfd, r);

	if (numbytes < 1) {
		fprintf (stderr, "error in receive_message_fraged\n");
		fflush (stderr);
		ap_rputs ("Error receiving message. See error log.", r);
		return HTTP_INTERNAL_SERVER_ERROR;
	}

	DEBUG ("All receiving ok.\n");

	ap_rputs (rmsg_buf, r);
	free (rmsg_buf);

	shutdown (sockfd, 2);
	close (sockfd);

	return OK;

}

/*
 doc:    <routine name="byteArrayToInt" export="public">
 doc:            <summary>Converts an array of 4 bytes to an integer.</summary>
 doc:            <param name="b" type="char*">The bytes to convert</param>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
EIF_INTEGER_32 byteArrayToInt (char * b)
{
	return (b[0] << 24) + ((b[1] & 0xFF) << 16) + ((b[2] & 0xFF) << 8) + (b[3]
			& 0xFF);
}

/*
 doc:    <routine name="intToByteArray" export="public">
 doc:            <summary>Converts an integer to an array of 4 bytes. Make sure you free the return value later.</summary>
 doc:            <param name="i" type="EIF_INTEGER_32">The integer to convert</param>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
char * intToByteArray (EIF_INTEGER_32 i)
{
	char * bb;
	bb = malloc (4);
	bb[0] = (char) (i >> 24);
	bb[1] = (char) (i >> 16);
	bb[2] = (char) (i >> 8);
	bb[3] = (char) i;
	return bb;
}

/*
 doc:    <routine name="encode_natural" export="public">
 doc:            <summary>Encode i to include the flag. Use decode_natural to extract the original integer value and use decode_flag to extract the flag. I must not be bigger than 2^31</summary>
 doc:            <param name="i" type="EIF_NATURAL_32">The integer value to encode</param>
 doc:            <param name="flag" type="EIF_BOOLEAN">The flag value to encode</param>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
EIF_NATURAL_32 encode_natural (EIF_NATURAL_32 i, EIF_BOOLEAN flag)
{
	REQUIRE ("i_not_to_big", i < 2 ^ 31);

	return (i << 1) + flag;
}

/*
 doc:    <routine name="decode_natural" export="public">
 doc:            <summary>Decode i and return original integer value. i should be encoded with encode_natural</summary>
 doc:            <param name="i" type="EIF_NATURAL_32">The integer value to decode</param>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
EIF_NATURAL_32 decode_natural (EIF_NATURAL_32 i)
{
	return (i >> 1);
}

/*
 doc:    <routine name="decode_flag" export="public">
 doc:            <summary>Decode i and return flag. i should be encoded with encode_natural</summary>
 doc:            <param name="i" type="EIF_NATURAL_32">The integer value to decode</param>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
EIF_BOOLEAN decode_flag (EIF_NATURAL_32 i)
{
	return (i & 1);
}

/*
 doc:    <routine name="get_in_addr" export="public">
 doc:            <summary>Get socket address</summary>
 doc:            <param name="sa" type="struct sockaddr *">The address to write</param>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
void* get_in_addr (struct sockaddr *sa)
{
	if (sa->sa_family == AF_INET) {
		return &(((struct sockaddr_in*) sa)->sin_addr);
	}

	return &(((struct sockaddr_in6*) sa)->sin6_addr);
}

/*
 doc:    <routine name="send_message_fraged" export="public">
 doc:            <summary>Devides the message into fragments of length FRAG_SIZE. For each fragment it encodes the size of it in an array of 4 bytes, sends these 4 bytes and then sends the fragment. The 4 byte array contains also a flag that determines if there will be another fragment coming up.</summary>
 doc:            <param name="message" type="char *">The message to be sent</param>
 doc:            <param name="sockfd" type="EIF_INTEGER_32">The socket connection id</param>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
EIF_INTEGER_32 send_message_fraged (char * message, EIF_INTEGER_32 sockfd,
		request_rec* r)
{
	EIF_INTEGER_32 numbytes = -1; /* how much was sent in the last recv*/
	EIF_NATURAL_32 bytes_of_msg_sent = 0; /* how much is already sent (total) */
	char * encoded_msg_length_byte; /* ncoded size (as byte) of (frag of) message with frag flag */
	char * frag_msg; /* conatins the frag of message that is sent in the current loop */
	char * m_pointer; /* points to the start of part of message from where in the next step FRAG_SIZE byte will be sent */

	REQUIRE ("sockfd_valid", sockfd);

	DEBUG ("About to send message. Length is %i bytes\n", strlen (message));

	/* Create fragment */
	DEBUG2 ("   ---trying malloc...frag_msg     ");

	frag_msg = (char*) malloc (sizeof(char) * FRAG_SIZE + 1);

	DEBUG2 ("ok\n");

	if (frag_msg == NULL) {
		fprintf (stderr, "Error mallocating!");
		fflush (stderr);
		return -1;
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

			DEBUG (" -About to send last fragment. Length is %i bytes\n",
					strlen (frag_msg));

			/* encode last fragment */
			encoded_msg_length_byte = intToByteArray (encode_natural (strlen (
					frag_msg), 0));
		} else {
			/* we have to fragment the message*/

			/* copy FRAG_SIZE bytes from the original message (=m_pointer) into the frag_msg, which will be sent then */
			strncpy (frag_msg, m_pointer, sizeof(char) * FRAG_SIZE);
			frag_msg[sizeof(char) * FRAG_SIZE] = '\0';

			DEBUG ("-About to send fragment. Length is %i bytes\n", strlen (
					frag_msg));

			/* encode frag_msg */
			encoded_msg_length_byte = intToByteArray (encode_natural (strlen (
					frag_msg), 1));
		}

		DEBUG (" -Sending... ");
		DEBUG2 ("'%s'", frag_msg);
		DEBUG ("\n");

		/* send encoded messagte length */
		numbytes = send (sockfd, encoded_msg_length_byte, sizeof(int), 0);
		if (numbytes < 1) {
			fprintf (stderr, "failed to send encoded_msg_lengh\n");
			fflush (stderr);
			return 0;
		}

		free (encoded_msg_length_byte);

		/* send message */
		numbytes = send (sockfd, frag_msg, strlen (frag_msg) * sizeof(char), 0);

		if (numbytes < 1) {
			fprintf (stderr, "failed to send frag_msg\n");
			fflush (stderr);
			return 0;
		}

		bytes_of_msg_sent += strlen (frag_msg) * sizeof(char);

		/* shift m_pointer to the right to 'cut off' the already sent part (=frag_msg) */
		m_pointer = m_pointer + (sizeof(char) * FRAG_SIZE);
	}

	/* all ok */
	return 1;
}

/*
 doc:    <routine name="receive_message_fraged" export="public">
 doc:            <summary>Receives a message that was send by send_message_fraged. For every incoming fragment, it first reads the 4 byte array determining the length of the fragment and if there will be another fragment coming up, then it calls recv until the whole fragment has been received.</summary>
 doc:            <param name="msg_buf" type="char **">The buffer where the message will be stored</param>
 doc:            <param name="sockfd" type="EIF_INTEGER_32">The socket connection id</param>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
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

	DEBUG ("Receiving message...\n");

	DEBUG2 ("   ---trying malloc...*msg_buf        ");
	(*msg_buf) = (char*) malloc (1);
	DEBUG2 ("ok\n");

	/* resetting *msg_buf */
	*msg_buf[0] = (char) 0;
	msg_buf_strlength = 0;

	/* create buffer to receive message fragment */
	DEBUG2 ("   ---trying malloc...*frag_buf          ");
	frag_buf = (char*) malloc (sizeof(char) * FRAG_SIZE + 1);
	DEBUG2 ("ok\n");

	if ((frag_buf) == NULL) {
		fprintf (stderr, "Error mallocating frag_buf!\n");
		fflush (stderr);
		return -1;
	}

	/* loop until we recieve a fragment with flag=0 */
	do {
		/* receive first 4 bytes determining length of message */
		numbytes = recv (sockfd, frag_length_byte, sizeof(int), 0);
		if (numbytes != sizeof(int)) {
			perror ("recv");
			fprintf (
					stderr,
					"Failed to receive fragment length. Received %i bytes instead of 4 bytes\n",
					numbytes);
			fflush (stderr);
			return -1;
		}

		/* decode */
		frag_length_int = byteArrayToInt (frag_length_byte);
		frag_length = decode_natural (frag_length_int);
		flag = decode_flag (frag_length_int);

		DEBUG ("Incoming frag, %i bytes, flag is %i\n", frag_length, flag);

		strcpy (frag_buf, "");
		bytes_recv = 0;

		/* loop to recieve whole fragement */
		while (bytes_recv < frag_length) {
			numbytes = recv (sockfd, buf, frag_length - bytes_recv, 0);
			buf[numbytes] = '\0';

			DEBUG ("  --filling buffer...%i bytes\n", numbytes);

			if (numbytes < 1) {
				fprintf (stderr, "Failed to receive message. numbytes=%i\n",
						numbytes);
				fflush (stderr);
				return -1;
			}
			bytes_recv += numbytes;
			strcat (frag_buf, buf);
		}

		numbytes = bytes_recv;

		if (numbytes != frag_length) {
			fprintf (stderr, "ERROR, received bytes=%i, frag_lengh is %i",
					numbytes, frag_length);
			fflush (stderr);
			return -1;
		}

		frag_buf[numbytes] = '\0';

		DEBUG ("Recieved %i bytes...:", numbytes);
		DEBUG2 ("'%s'", frag_buf);
		DEBUG ("\n");

		/* extend *msg_buf and copy frag to end of it */
		*msg_buf
				= (char *) realloc (*msg_buf, msg_buf_strlength + numbytes + 1);
		memcpy (*msg_buf + msg_buf_strlength, frag_buf, numbytes);
		msg_buf_strlength += numbytes;
	} while (flag == 1);

	free (frag_buf);

	DEBUG ("Completed recieving message.\n");

	return msg_buf_strlength;
}

static void register_hooks (apr_pool_t* pool)
{
	ap_hook_handler (xebra_handler, NULL, NULL, APR_HOOK_MIDDLE);
}

module AP_MODULE_DECLARE_DATA mod_xebra_module = { STANDARD20_MODULE_STUFF,
		NULL, NULL, NULL, NULL, NULL, register_hooks };
