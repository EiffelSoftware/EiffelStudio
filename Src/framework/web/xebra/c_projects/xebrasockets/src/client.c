/*
 description: "Talks to the server to test funcionality of xebrasockets.c"
 date:		"$Date$"
 revision:	"$Revision$"
 copyright:	"Copyright (c) 1985-2007, Eiffel Software."
 license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
 licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
 copying: ""
 source: "[
 Eiffel Software
 356 Storke Road, Goleta, CA 93117 USA
 Telephone 805-685-1006, Fax 805-685-6869
 Website http://www.eiffel.com
 Customer support http://support.eiffel.com
 ]"
 */

#include "xebrasockets.h"

/*
 doc:    <routine name="stringgen" export="public">
 doc:            <summary>Generates a string with a given length.</summary>
 doc:            <param name="buf" type="char**">A buffer to store the string</param>
 doc:            <param name="size" type="int">How long the string should be</param>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
int stringgen (char **buf, int size)
{
	char t[10];
	int i;

	(*buf) = (char*) malloc (size);
	if ((*buf) == NULL) {
		return 0;
	}
	strcpy ((*buf), "");

	if (size % 10 != 0)
		return 0;

	for (i = 0; i < (size / 10) - 1; i++) {
		sprintf (t, "%d", (int) time (NULL));
		strcat (*buf, t);
	}
	return 1;
}

/*
 doc:    <routine name="main" export="public">
 doc:            <summary>Connects to the server, sends a message and receives a message.</summary>
 doc:            <thread_safety></thread_safety>
 doc:            <synchronization></synchronization>
 doc:    </routine>
 */
int main (int argc, char *argv[])
{
	int sockfd; /* socket it */
	struct addrinfo hints, *servinfo, *p; /* information about connection */
	int rv; /* information about connection */
	char s[INET6_ADDRSTRLEN]; /* information about connection */
	char * message; /* the message to be sent to the server */
	char * hname = HOSTNAME; /* hostname of server */
	int numbytes; /* number of bytes recieved from server */
	char* rmsg_buf; /* buffer for receiving message */

	printf ("Client started.\n");

	/* ==============READ MESSAGE FROM A FILE============== */
	/*FILE * pFile;
	 long lSize;

	 size_t result;

	 pFile = fopen ( "/home/fabioz/file2" , "rb" );
	 if ( pFile==NULL ) {fputs ( "File error",stderr ); exit ( 1 );}

	 // obtain file size:
	 fseek ( pFile , 0 , SEEK_END );
	 lSize = ftell ( pFile );
	 rewind ( pFile );

	 // allocate memory to contain the whole file:
	 message = ( char* ) malloc ( sizeof ( char ) *lSize );
	 if ( message == NULL ) {fputs ( "Memory error",stderr ); exit ( 2 );}

	 // copy the file into the buffer:
	 result = fread ( message,1,lSize,pFile );
	 if ( result != lSize ) {fputs ( "Reading error",stderr ); exit ( 3 );}

	 // the whole file is now loaded in the memory buffer.

	 // terminate
	 fclose ( pFile );


	 */

	/* ==============GENERATE LONG MESSAGE============== */
	/*
	 fprintf ( stderr,"\nGenerating message..." );
	 fflush ( stderr );
	 if ( !stringgen ( &message,500000 ) )
	 {

	 fprintf ( stderr, "Error in strgen\n" );
	 fflush ( stderr );
	 }
	 fprintf ( stderr,"Done.\n" );
	 fflush ( stderr );

	 */

	/* ==============USE SHORT MESSAGE============== */
	message = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	/* set up connection to server */
	printf ("Setting up connection.\n");

	memset (&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;

	if (argv[1] != NULL)
		hname = argv[1];

	if ((rv = getaddrinfo (hname, PORT, &hints, &servinfo)) != 0) {
		fprintf (stderr, "getaddrinfo: %s\n", gai_strerror (rv));
		fflush (stderr);
		return 0;
	}

	/* loop through all the results and connect to the first we can */
	for (p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket (p->ai_family, p->ai_socktype, p->ai_protocol))
				== -1) {
			fprintf (stderr, "error socket");
			fflush (stderr);
			continue;
		}

		if (connect (sockfd, p->ai_addr, p->ai_addrlen) == -1) {
			printf("sandro");close (sockfd);
			fprintf (stderr, "error connect");
			fflush (stderr);
			continue;
		}

		break;
	}

	if (p == NULL) {
		fprintf (stderr, "client: failed to connect\n");
		fflush (stderr);
		return 0;
	}

	inet_ntop (p->ai_family, get_in_addr ((struct sockaddr *) p->ai_addr), s,
			sizeof s);

	freeaddrinfo (servinfo);

	printf ("Connected.\n");

	/*
	 char * message = ( char * ) malloc ( 200000 );
	 char * message = "Hallo was laeuft.";
	 strcpy ( message,"Dear XebraServer, \n\nA user has just clicked on a page and has made the following request: '" );

	 strcpy( message, "clienttime: ");
	 char cl[20];
	 sprintf(cl, "%d", (int)time(NULL));
	 strcat( message,cl );


	 strcat ( message,r->the_request );
	 strcat ( message, "'. Can you please handle this request and send me some HTML back asp. \n\nLooking forward to hearing from you. \nYours sincerely, \n\nxebramod" );
	 */

	printf ("Sending message.\n");

	if (!send_message_fraged (message, sockfd))
		return 0;

	printf ("Messages sent. Now waiting for back message...\n");

	/*///////////////////SPECIALRECIEVE/////////////////////

	 char  msg_buf[100];

	 int jlphi;

	 jlphi = recv ( sockfd, msg_buf, 100, 0 );

	 printf("%s",msg_buf);

	 return 0;

	 ///////////////////SPECIALRECIEVE/////////////////////
	 */

	numbytes = receive_message_fraged (&rmsg_buf, sockfd);

	if (numbytes < 1) {
		printf ("Error in receive_message_fraged\n");
		return 0;
	}

	printf ("All receiving ok.\n");
	
	DEBUG2 ("Received: '%s'\n", rmsg_buf);


	free (rmsg_buf);

	shutdown (sockfd, 2);
	close (sockfd);

	
	printf ("Reached end of code. good bye\n");
	return 0;
}
