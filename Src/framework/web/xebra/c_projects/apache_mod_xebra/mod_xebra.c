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

/*
doc:    <routine name="create_srv_cfg" export="private">
doc:           <summary>Creates a default server config</summary>
doc:			<return>The xebra_svr_cfg</return>
doc:    </routine>
*/
static void* create_srv_cfg (apr_pool_t* pool, char* x)
{
	xebra_svr_cfg* svr_cfg = apr_palloc (pool, sizeof(xebra_svr_cfg));
	svr_cfg->port = "9999";
	svr_cfg->port = "0.0.0.0";
	svr_cfg->max_upload_size = 10000;
	return svr_cfg;
}

/*
doc:    <routine name="set_srv_cfg_port" export="private">
doc:           <summary>Sets the port attribute to the xebra_svr_cfg instance</summary>
doc:		   <return>NULL</return>
doc:    </routine>
*/
static const char *set_srv_cfg_port (cmd_parms *parms, void *mconfig,
		const char *arg)
{
	xebra_svr_cfg* svr_cfg = ap_get_module_config (
			parms->server->module_config, &xebra_module);
	svr_cfg->port = (char *) arg;
	return NULL;
}

/*
doc:    <routine name="set_srv_cfg_host" export="private">
doc:            <summary>Sets the host attribute to the xebra_svr_cfg instance</summary>
doc:			<return>NULL</return>
doc:    </routine>
*/
static const char *set_srv_cfg_host (cmd_parms *parms, void *mconfig,
		const char *arg)
{
	xebra_svr_cfg* svr_cfg = ap_get_module_config (
			parms->server->module_config, &xebra_module);
	svr_cfg->host = (char *) arg;
	return NULL;
}

/*
 doc:    <routine name="set_srv_cfg_max_upload_size" export="private">
 doc:            <summary>Sets the max_upload_size attribute to the xebra_svr_cfg instance</summary>
 doc:			 <return>NULL</return>
 doc:    </routine>
 */
static const char *set_srv_cfg_max_upload_size (cmd_parms *parms,
		void *mconfig, const char *arg)
{
	xebra_svr_cfg* svr_cfg = ap_get_module_config (
			parms->server->module_config, &xebra_module);
	svr_cfg->max_upload_size = atoi (arg);
	return NULL;
}

/*
 doc:    <function name="read_from_POST" export="private">
 doc:            <summary>Reads POST values and appends them to the buffer</summary>
 doc:            <param name="r" type="request_rec*>The request</param>
 doc:            <param name="buf" type="char**>A buffer to write the keys and values</param>
 doc:            <param name="max_upload_size" type="int>The maximum size of post data as specified in Content-Length</param>
 doc:            <param name="save_file" type="int>Specifies whether the data should be stored in a temp file or attached to buf. If a file is written the filename is stored in buf</param>
 doc:			 <return>Returns an apache RESPONSE_CODE</return>
 doc:    </routine>
 */
static int read_from_POST (request_rec* r, char **buf, int max_upload_size,
		int save_file)
{
	const char *bbuf;
	apr_size_t nbytes;
	int bytes;
	apr_status_t rv;
	apr_bucket_brigade *bb;
	apr_bucket *b;
	const char *clen;
	apr_file_t * tmpfile;
	char* tmpname;
	int eos;

	/* Check if content-length does not exceed max_upload_size */
	clen = apr_table_get (r->headers_in, "Content-Length");
	if (clen != NULL) {
		bytes = strtol (clen, NULL, 0);
		if (bytes >= max_upload_size) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r,
					"Request too big (%d bytes; limit %d)", bytes,
					max_upload_size);
			return HTTP_REQUEST_ENTITY_TOO_LARGE;
		}
	}
	DEBUG ("Content-Length: %d bytes", bytes);

	/* Prepare buffer */
	(*buf) = apr_palloc (r->pool, 1);
	(*buf)[0] = 0;

	if (save_file) {
		/* Prepare tmp file */
		tmpname = apr_pstrdup (r->pool, UP_FN);
		rv = apr_file_mktemp (&tmpfile, tmpname, APR_CREATE | APR_WRITE , r->pool);
		DEBUG ("Creating file... '%s'", tmpname);

#ifndef _WINDOWS
		rv = apr_file_perms_set(tmpname,  APR_FPROT_UREAD | APR_FPROT_UWRITE  |
											APR_FPROT_GREAD | APR_FPROT_GWRITE  |
											APR_FPROT_WREAD | APR_FPROT_WWRITE);

		if (rv != APR_SUCCESS)
		{
			ap_log_rerror (APLOG_MARK, APLOG_ERR, rv, r,
								"Failed to change permissions on temp file");
						return HTTP_INTERNAL_SERVER_ERROR;
		}
#endif

		(*buf) = apr_pstrcat (r->pool, KEY_FILE_UPLOAD, tmpname, NULL);
		if (rv != APR_SUCCESS) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, rv, r,
					"Failed to create temp file");
			return HTTP_INTERNAL_SERVER_ERROR;
		}
		apr_pool_cleanup_register (r->pool, tmpfile, (void*) apr_file_close,
				apr_pool_cleanup_null);
	}

	/* Iterate over brigades */
	eos = 0;
	do {
		/* Get brigade from input filters */
		bb = apr_brigade_create (r->pool, r->connection->bucket_alloc);
		rv = ap_get_brigade (r->input_filters, bb, AP_MODE_READBYTES,
				APR_BLOCK_READ, bytes);
		if (rv != APR_SUCCESS) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, rv, r,
					"Failed to get brigade from input filters");
			return HTTP_INTERNAL_SERVER_ERROR;
		}

		/* Iterate over brigade and read buckets*/
		for (b = APR_BRIGADE_FIRST (bb); b != APR_BRIGADE_SENTINEL (bb); b
				= APR_BUCKET_NEXT (b)) {
			DEBUG ("BUCKET>> data_type: %s, type: %s, length: %" APR_SIZE_T_FMT " bytes",
					(APR_BUCKET_IS_METADATA(b)) ? "metadata" : "data",
					b->type->name,
					b->length);

			if (APR_BUCKET_IS_EOS (b)) {
				eos = 1;
				break;
			}
			if (!(APR_BUCKET_IS_METADATA (b))) {
				rv = apr_bucket_read (b, &bbuf, &nbytes, APR_BLOCK_READ);
				if (rv == APR_SUCCESS) {
					DEBUG2 ("Bucket content: '%s'", bbuf);
					if (save_file) {
						apr_file_write (tmpfile, bbuf, &nbytes);
					} else {
						(*buf) = apr_pstrcat (r->pool, (*buf), bbuf, NULL);
					}
				} else {
					ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r,
							"(%s, %s): Failed to read bucket",
							(APR_BUCKET_IS_METADATA (b)) ? "metadata" : "data",
							b->type->name);
					return HTTP_INTERNAL_SERVER_ERROR;
				}
			}
		}
	} while (!eos);

	if (save_file)
		apr_file_flush (tmpfile);

	return OK;
}

/*
doc:    <routine name="print_item" export="private">
doc:            <summary>Callback function to be used with apr_table_do to process a table item. Appends all items to table_buf </summary>
doc:            <param name="rec" type="request_rec*>The request</param>
doc:            <param name="key" type="const char*>A key value from the table</param>
doc:            <param name="value" type="const char*>A value value from the table</param>
doc:			 <return>Returns 1 if the iteration should stop and 0 otherwise</return>
doc:    </routine>
*/
static int print_item (void* rec, const char *key, const char *value)
{
	request_rec* r = rec;
	table_buf = apr_pstrcat (r->pool, table_buf, TABLECSEP, key, TABLERSEP,
			value, NULL);
	return 1;
}

/*
doc:    <routine name="xebra_handler" export="private">
doc:            <summary>This is the main method that handles the request</summary>
doc:            <param name="rec" type="request_rec*>The request</param>
doc: 			 <return>Returns an apache RESPONSE_CODE</return>
doc:    </routine>
*/
static int xebra_handler (request_rec* r)
{	
#ifdef _WINDOWS
	WORD wVersionRequested;
	WSADATA wsaData;
	SOCKET m_socket;
	int wsaerr;
	SOCKADDR_IN clientService;
#else
	int sockfd; /* socket id */
	char s[INET6_ADDRSTRLEN]; /* information about connection */
	struct addrinfo hints, *servinfo, *p; /* information about connection */
#endif

	int rv = OK; /* information about connection */
	char * message; /* the message to be sent to the server */
	int numbytes; /* numcber of bytes recieved from server */
	char* rmsg_buf; /* buffer for receiving message */
	char* post_buf;
	char* tmp_ctype;
	char* srv_hostname;
	char* srv_port;
	int srv_port_int;
	int srv_max_upload_size; /* the max upload size read from config */
	char* ctype;
	xebra_svr_cfg *srvc;
	

	srvc = ap_get_module_config (r->server->module_config,
		&xebra_module);

	if (!r->handler || strcmp (r->handler, "mod_xebra"))
		return DECLINED;

	if ((r->method_number != M_GET) && (r->method_number != M_POST)) {
		return HTTP_METHOD_NOT_ALLOWED;
	}
	/* Reading config file */
	srv_hostname = apr_pstrcat (r->pool, srvc->host, NULL);
	srv_port = apr_pstrcat (r->pool, srvc->port, NULL);
	srv_max_upload_size = srvc->max_upload_size;

	/* Set a default content-type */
	ap_set_content_type (r, "text/html;charset=ascii");

#ifdef _WINDOWS
	/* winsock stuff */
	/* Using MAKEWORD macro, Winsock version request 2.2 */
	wVersionRequested = MAKEWORD(2, 2);
	wsaerr = WSAStartup(wVersionRequested, &wsaData);
	if (wsaerr != 0)
	{
		/* Tell the user that we could not find a usable */
		/* WinSock DLL.*/
		DEBUG("The Winsock dll not found!");
		return OK;
	}
	

	/* Confirm that the WinSock DLL supports 2.2.*/
	/* Note that if the DLL supports versions greater    */
	/* than 2.2 in addition to 2.2, it will still return */
	/* 2.2 in wVersion since that is the version we      */
	/* requested.                                        */

	if (LOBYTE(wsaData.wVersion) != 2 || HIBYTE(wsaData.wVersion) != 2 )
	{
		/* Tell the user that we could not find a usable */
		/* WinSock DLL.*/
		DEBUG("The dll do not support the Winsock version %u.%u!\n", LOBYTE(wsaData.wVersion),HIBYTE(wsaData.wVersion));
		WSACleanup();
		return 0;
	}
#endif

	DEBUG ("===============NEW REQUEST===============");
	DEBUG ("%s", r->the_request)
	DEBUG ("Reading input...");

	message = apr_palloc (r->pool, 1);
	message[0] = '\0';
	message = apr_pstrcat (r->pool, message, r->the_request, NULL);

	/* Read headers into message buffer */
	DEBUG2 ("Reading in headers...");

	table_buf = apr_palloc (r->pool, 1);
	table_buf[0] = '\0';
	table_buf = apr_pstrcat (r->pool, HEADERS_IN, NULL);
	apr_table_do (print_item, r, r->headers_in, NULL);
	table_buf = apr_pstrcat (r->pool, table_buf, TABLEEND, HEADERS_OUT, NULL);
	apr_table_do (print_item, r, r->headers_out, NULL);
	table_buf = apr_pstrcat (r->pool, table_buf, TABLEEND, SUBP_ENV, NULL);
	apr_table_do (print_item, r, r->subprocess_env, NULL);
	table_buf = apr_pstrcat (r->pool, table_buf, TABLEEND, NULL);
	message = apr_pstrcat (r->pool, message, table_buf, NULL);

	/* If there are, read POST or GET parameters into message buffer */
	if (r->method_number == M_POST) {
		DEBUG ("Reading POST parameters...");
		ctype = apr_table_get (r->headers_in, "Content-Type");
		DEBUG ("Content-Type: %s", ctype);
		tmp_ctype = apr_palloc (r->pool, 1);
		apr_cpystrn(tmp_ctype, ctype, strlen(CT_MULTIPART_FORM_DATA) +1);
		/* If the Content-Type is CT_MULTIPART_FORM_DATA save the post data to a file and don't append it to the message */
		if (tmp_ctype && (strcasecmp (tmp_ctype, CT_MULTIPART_FORM_DATA) == 0))
			rv = read_from_POST (r, &post_buf, srv_max_upload_size, 1);
		else
			rv = read_from_POST (r, &post_buf, srv_max_upload_size, 0);

		if (rv == HTTP_REQUEST_ENTITY_TOO_LARGE) {
			message = apr_pstrcat (r->pool, message, ARG, POST_TOO_BIG, NULL);
		} else if (rv != OK) {
			PRINT_ERROR ("Error reading POST data");
			return OK;
		} else {
			/* If the Content-Type is CT_APP_FORM_URLENCODED put a & betweeen ARG and the post data */
			if (ctype && (strcasecmp (ctype, CT_APP_FORM_URLENCODED) == 0)) {
				message = apr_pstrcat (r->pool, message, ARG, "&", post_buf,
						NULL);
			} else {
				message = apr_pstrcat (r->pool, message, ARG, post_buf, NULL);
			}
		}

	} else if (r->args != NULL) {
	    /* If its not a POST request, simply append the (GET) args to the message */
		message = apr_pstrcat (r->pool, message, ARG, "&", r->args, NULL);
	} else {
		message = apr_pstrcat (r->pool, message, ARG, NULL);
	}

#ifdef _WINDOWS
	/* Set up connection to server */
	DEBUG ("Setting up connection.");
	DEBUG ("Using server host %s and port %s", srv_hostname, srv_port);
	
	m_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (m_socket == INVALID_SOCKET)
	{
		PRINT_ERROR ("Cannot connect to Xebra Server. See apache error log.");
		WSACleanup();
		return OK;
	}
	DEBUG ("Socket created.");

	clientService.sin_family = AF_INET;
	clientService.sin_addr.s_addr = inet_addr(srv_hostname);
	srv_port_int = atoi(srv_port);
	clientService.sin_port = htons(srv_port_int);
	if (connect(m_socket, (SOCKADDR*)&clientService, sizeof(clientService)) == SOCKET_ERROR)
	{
		PRINT_ERROR ("Cannot connect to Xebra Server. See apache error log.");
		WSACleanup();
		return OK;
	}
#else
	memset (&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;

	if ((rv = getaddrinfo (srv_hostname, srv_port, &hints, &servinfo)) != 0) {
		ap_log_rerror (APLOG_MARK, APLOG_ERR, rv, r, "Getaddrinfo: %s",
				gai_strerror (rv));

		return OK;
	}

	/* loop through all the results and connect to the first we can */
	for (p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket (p->ai_family, p->ai_socktype, p->ai_protocol))
				== -1) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "error socket");
			continue;
		}

		if (connect (sockfd, p->ai_addr, p->ai_addrlen) == -1) {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "error connect");
			continue;
		}
		break;
	}

	if (p == NULL) {
		ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, "failed to connect");
		PRINT_ERROR ("Cannot connect to Xebra Server. See apache error log.");
		return OK;
	}

	inet_ntop (p->ai_family, get_in_addr ((struct sockaddr *) p->ai_addr), s,
			sizeof s);

	freeaddrinfo (servinfo);
#endif


	DEBUG ("Connected.");

	DEBUG ("Sending message...");

#ifdef _WINDOWS
	if (!send_message_fraged (message, m_socket, r)) {
#else
	if (!send_message_fraged (message, sockfd, r)) {
#endif
		PRINT_ERROR ("Error sending message. See apache error log.");
		return OK;
	}

	DEBUG ("Messages sent. Now waiting for back message...");

#ifdef _WINDOWS
	numbytes = receive_message_fraged (&rmsg_buf, m_socket, r);
#else
	numbytes = receive_message_fraged (&rmsg_buf, sockfd, r);
#endif

	if (numbytes < 1) {
		ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r,
				"error in receive_message_fraged");
		PRINT_ERROR("Error receiving message. See apache error log.");
		return OK;
	}

	DEBUG ("All receiving ok.");

	rv = handle_response_message (r, rmsg_buf);
	if (rv != APR_SUCCESS)
	{
		PRINT_ERROR("Error reading message. See apache error log.");
	}
	
	/* Close sockets and quit */
#ifdef _WINDOWS
	WSACleanup();
#else
	shutdown (sockfd, 2);
	close (sockfd);
#endif

	return OK;
}


apr_status_t handle_response_message (request_rec* r, char* message)
{
	char* msg_copy;
	char* content_type;
	char* cookie_order_start;
	char* cookie_order_end;
	char* html;

	/* Extract cookie orders */
	msg_copy = apr_pstrdup (r->pool, message);
	cookie_order_start = ap_strstr_c (msg_copy, COOKIE_START);
	while (cookie_order_start != NULL) {
		DEBUG ("Extracting cookies...");
		cookie_order_start += strlen (COOKIE_START);
		cookie_order_end = ap_strstr_c (msg_copy, COOKIE_END);
		if (cookie_order_end != NULL) {
			cookie_order_start[cookie_order_end - cookie_order_start] = '\0';
			apr_table_add (r->headers_out, "Set-Cookie", cookie_order_start);
			apr_table_add (r->err_headers_out, "Set-Cookie", cookie_order_start);
			DEBUG2 ("... %s", cookie_order_start);
		} else {
			ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r,
				"Message from xebra server contains a cookie start "
				"tag '%s' without a cookie end tag '%s'", COOKIE_START,
				COOKIE_END);
			return APR_EGENERAL;
		}
		msg_copy = &cookie_order_start[cookie_order_end - cookie_order_start]
		+ 1;
		cookie_order_start = ap_strstr_c (msg_copy, COOKIE_START);
	}

	DEBUG2 ("Extracting content-type");
	content_type = apr_pstrcat (r->pool, message,  NULL);
	content_type = ap_strstr_c (content_type, CONTENT_TYPE_START);
	if (content_type != NULL)
	{
		content_type += strlen(CONTENT_TYPE_START);
		html = ap_strstr_c (content_type, HTML_START);
		content_type[html - content_type] = '\0';
		ap_set_content_type (r, content_type);
	}

	DEBUG2 ("Extracting html...");
	/* Extract html code */
	html = ap_strstr_c (message, HTML_START);
	if (html == NULL) {
		/* no html found */
		ap_log_rerror (
			APLOG_MARK,
			APLOG_ERR,
			0,
			r,
			"Message from xebra server does not contain a html start tag '%s'",
			HTML_START);
		return APR_EGENERAL;
	}
	html += strlen (HTML_START);

	/* Tell browsers not to cache the page */
	apr_table_addn(r->headers_out, "Cache-Control", "no-cache");

	/* Print html */ 
	ap_rputs (html, r);
	DEBUG2 ("Done.");
	return APR_SUCCESS;
}

/*
doc:    <routine name="byteArrayToInt" export="private">
doc:            <summary>Converts an array of 4 bytes to an integer.</summary>
doc:            <param name="b" type="char*">The bytes to convert</param>
doc: 			 <return>Returns the integer</return>
doc:    </routine>
*/
int byteArrayToInt (char * b)
{
	return (b[0] << 24) + ((b[1] & 0xFF) << 16) + ((b[2] & 0xFF) << 8) + (b[3]
	& 0xFF);
}

/*
doc:    <routine name="intToByteArray" export="private">
doc:            <summary>Converts an integer to an array of 4 bytes. Make sure you free the return value later.</summary>
doc:            <param name="i" type="int">The integer to convert</param>
doc: 			 <return>Returns the byte array</return>
doc:    </routine>
*/
char * intToByteArray (request_rec* r, int i)
{
	char * bb;
	bb = apr_palloc (r->pool, 4);
	bb[0] = (char) (i >> 24);
	bb[1] = (char) (i >> 16);
	bb[2] = (char) (i >> 8);
	bb[3] = (char) i;
	return bb;
}

/*
doc:    <routine name="encode_natural" export="private">
doc:            <summary>Encode i to include the flag. Use decode_natural to extract the original integer value and use decode_flag to extract the flag. I must not be bigger than 2^31</summary>
doc:            <param name="i" type="unsigned int">The integer value to encode</param>
doc:            <param name="flag" type="int">The flag value to encode</param>
doc: 			 <return>Returns the encoded unsigned integer</return>
doc:    </routine>
*/
unsigned int encode_natural (unsigned int i, int flag)
{
	if (i > 0x7FFFFFFF)	{
		return 0;
	} else {
		return (i << 1) + flag;
	}
}

/*
doc:    <routine name="decode_natural" export="private">
doc:            <summary>Decode i and return original integer value. i should be encoded with encode_natural</summary>
doc:            <param name="i" type="unsigned int">The integer value to decode</param>
doc: 			 <return>Returns the decoded unsigned integer</return>
doc:    </routine>
*/
unsigned int decode_natural (unsigned int i)
{
	return (i >> 1);
}

/*
doc:    <routine name="decode_flag" export="private">
doc:            <summary>Decode i and return flag. i should be encoded with encode_natural</summary>
doc:            <param name="i" type="unsigned int">The integer value to decode</param>
doc: 			 <return>Returns the decoded boolean flag</return>
doc:    </routine>
*/
int decode_flag (unsigned int i)
{
	return (i & 1);
}

#ifndef _WINDOWS
/*
doc:    <routine name="get_in_addr" export="private">
doc:            <summary>Get socket address</summary>
doc:            <param name="sa" type="struct sockaddr *">The address to write</param>
doc: 			 <return>Returns the address</return>
doc:    </routine>
*/
void* get_in_addr (struct sockaddr *sa)
{
	if (sa->sa_family == AF_INET) {
		return &(((struct sockaddr_in*) sa)->sin_addr);
	}

	return &(((struct sockaddr_in6*) sa)->sin6_addr);
}
#endif

/*
doc:    <routine name="send_message_fraged" export="private">
doc:            <summary>Devides the message into fragments of length FRAG_SIZE. For each fragment it encodes the size of it in an array of 4 bytes, sends these 4 bytes and then sends the fragment. The 4 byte array contains also a flag that determines if there will be another fragment coming up.</summary>
doc:            <param name="message" type="char *">The message to be sent</param>
doc:            <param name="sockfd" type="int/SOCKET">The socket connection id</param>
doc: 			 <return>Returns 1 on success and 0 otherwise</return>
doc:    </routine>
*/
#ifdef _WINDOWS
int send_message_fraged (char * message, SOCKET sockfd,	request_rec* r)
#else
int send_message_fraged (char * message, int sockfd, request_rec* r)
#endif
{
	int numbytes = -1; /* how much was sent in the last recv*/
	unsigned int bytes_of_msg_sent = 0; /* how much is already sent (total) */
	char * encoded_msg_length_byte; /* encoded size (as byte) of (frag of) message with frag flag */
	char * frag_msg; /* conatins the frag of message that is sent in the current loop */
	char * m_pointer; /* points to the start of part of message from where in the next step FRAG_SIZE byte will be sent */

	DEBUG ("About to send message. Length is %i bytes", (int) strlen (message));

	/* Create fragment */
	frag_msg = (char*) malloc (sizeof(char) * FRAG_SIZE + 1);

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

/**
doc:    <routine name="receive_message_fraged" export="private">
doc:            <summary>Receives a message that was send by send_message_fraged. For every incoming fragment, it first reads the 4 byte array determining the length of the fragment and if there will be another fragment coming up, then it calls recv until the whole fragment has been received.</summary>
doc:            <param name="msg_buf" type="char **">The buffer where the message will be stored</param>
doc:            <param name="sockfd" type="int">The socket connection id</param>
doc: 			 <return>Returns 1 on success and 0 otherwise</return>
doc:    </routine>
*/
#ifdef _WINDOWS
int receive_message_fraged (char **msg_buf, SOCKET sockfd, request_rec* r)
#else
int receive_message_fraged (char **msg_buf, int sockfd, request_rec* r)
#endif
{
	int msg_buf_strlength; /* string length of *msg_buf */
	char* frag_buf; /* stores the frag to be received */
	int numbytes = 0; /* received bytes */
	char frag_length_byte[sizeof(int)]; /* length of received frag (bytes) */
	unsigned int frag_length; /* length of received frag (int) */
	int flag = 0; /* contains the frag flag of the just received msg */
	unsigned int bytes_to_receive = 0; /* how many bytes are we going to receive in this frag */
	unsigned int frag_length_int; /* buffer to copy msg */
	char buf[sizeof(char) * FRAG_SIZE + 1]; /* buffer to receive message fragment fragments */
	int bytes_recv; /* number of bytes receivced for one fragment */

	DEBUG ("Receiving message...");

	(*msg_buf) = apr_palloc (r->pool, 1);

	/* resetting *msg_buf */
	*msg_buf[0] = '\0';
	msg_buf_strlength = 0;

	/* create buffer to receive message fragment */

	frag_buf = apr_palloc (r->pool, 1);
	frag_buf[0] = '\0';

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
		(*msg_buf) = apr_pstrcat (r->pool, (*msg_buf), frag_buf, NULL);

		msg_buf_strlength += numbytes;
	} while (flag == 1);

	DEBUG ("Completed recieving message.");

	return msg_buf_strlength;
}

/**
doc:    <routine name="register_hooks" export="private">
doc:            <summary>Registers the method xebra_handler as a hook in the module</summary>
doc:            <param name="pool" type="apr_pool_t**">The apr memory pool</param> doc:
doc:    </routine>
*/
static void register_hooks (apr_pool_t* pool)
{
	ap_hook_handler (xebra_handler, NULL, NULL, APR_HOOK_MIDDLE);
}


module AP_MODULE_DECLARE_DATA xebra_module = { STANDARD20_MODULE_STUFF, NULL,
NULL, create_srv_cfg, NULL, xebra_cmds, register_hooks };
