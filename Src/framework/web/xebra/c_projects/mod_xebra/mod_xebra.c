/*
 *	 description: "Apache Module that sends request data to xebra server."
 *	 date:		"$Date$"
 *	 revision:	"$Revision$"
 *	 copyright:	"Copyright (c) 1985-2007, Eiffel Software."
 *	 license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
 *	 licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
 *	 copying: ""
 *	 source: 	"[
 *	 		Eiffel Software
 *	 		356 Storke Road, Goleta, CA 93117 USA
 *	 		Telephone 805-685-1006, Fax 805-685-6869
 *	 		Website http://www.eiffel.com
 *	 		Customer support http://support.eiffel.com
 *				 ]"
 */

#include <httpd.h>
#include <http_protocol.h>
#include <http_config.h>

#include "xebrasockets.h"

/*
 doc:    <routine name="xebra_handler" export="public">
 doc:            <summary>Contains the main logic of the module. Sends the request to the server and displays the return message.</summary>
 doc:            <param name="f" type="request_rec*">The HTTP request</param>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
staticintxebra_handler(request_rec* r)
{
	int sockfd; /* socket it */
	struct addrinfo hints, *servinfo, *p; /* information about connection */
	int rv; /* information about connection */
	char s[INET6_ADDRSTRLEN]; /* information about connection */
	char * message; /* the message to be sent to the server */
	char * hname = HOSTNAME; /* hostname of server */
	int numbytes; /* number of bytes recieved from server */
	char* rmsg_buf; /* buffer for receiving message */

	if (!r->handler || strcmp(r->handler, "mod_xebra"))
	return DECLINED;

	/* if (r->method_number != M_GET)
	 return HTTP_METHOD_NOT_ALLOWED;
	 */
	ap_set_content_type(r, "text/html;charset=ascii");

	DEBUG ("\n\n===============NEW REQUEST===============\n");

	message = r->the_request;

	/* set up connection to server */
	DEBUG ("Setting up connection.\n");

	memset (&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;

	if ((rv = getaddrinfo (hname, PORT, &hints, &servinfo)) != 0) {
		fprintf (stderr, "getaddrinfo: %s\n", gai_strerror (rv));
		fflush (stderr);
		ap_rputs("Cannot connect to XEbraServer. See error log.", r);
		return HTTP_INTERNAL_SERVER_ERROR;
	}

	/* loop through all the results and connect to the first we can */
	for (p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket (p->ai_family, p->ai_socktype, p->ai_protocol))
				== -1) {
			fprintf (stderr, "error socket");
			fflush (stderr);
			ap_rputs("Cannot connect to XEbraServer. See error log.", r);
			continue;
		}

		if (connect (sockfd, p->ai_addr, p->ai_addrlen) ==-1) {
	f printf(stde rr, " error connect");
			fflush (stderr);
			ap_rputs("Cannot connect to XEbraServer. See error log.", r);
			continue;
		}

		break;
	}

	if (p == NULL) {
		fprintf (stderr, "client: failed to connect\n");
		fflush (stderr);
		ap_rputs("Cannot connect to XEbraServer. See error log.", r);
		return HTTP_INTERNAL_SERVER_ERROR;
	}

	inet_ntop (p->ai_family, get_in_addr ((struct sockaddr *) p->ai_addr), s,
			sizeof s);

	freeaddrinfo (servinfo);

	DEBUG ("Connected.\n");

	DEBUG ("Sending message.\n");

	if (!send_message_fraged (message, sockfd)) {
		ap_rputs("Error sending message. See error log.", r);
		return HTTP_INTERNAL_SERVER_ERROR;
	}

	DEBUG ("Messages sent. Now waiting for back message...\n");

	numbytes = receive_message_fraged (&rmsg_buf, sockfd);

	if (numbytes < 1) {
		fprintf (stderr, "error in receive_message_fraged\n");
		fflush (stderr);
		ap_rputs("Error receiving message. See error log.", r);
		return HTTP_INTERNAL_SERVER_ERROR;
	}

	DEBUG ("All receiving ok.\n");

	ap_rputs(rmsg_buf, r);
	free (rmsg_buf);

	shutdown (sockfd, 2);
	close (sockfd);

	return OK;
}

/*
 doc:    <routine name="register_hooks" export="public">
 doc:            <summary>Registers hooks</summary>
 doc:            <param name="pool" type="apr_pool_t*">Memory pool</param>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
static void register_hooks(apr_pool_t* pool)
{
	ap_hook_handler(xebra_handler, NULL, NULL, APR_HOOK_MIDDLE);
}

module AP_MODULE_DECLARE_DATA mod_xebra_module = {
	STANDARD20_MODULE_STUFF,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	register_hooks
};
