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

#define BACKLOG 10     // how many pending connections queue will hold

/*
doc:    <routine name="sigchld_handler" export="public">
doc:            <summary>Kills zombies</summary>
doc:            <thread_safety></thread_safety>
doc:            <synchronization></synchronization>
doc:    </routine>
*/
void sigchld_handler (int s){
	while (waitpid (-1, NULL, WNOHANG) > 0);
}

/*
doc:    <routine name="main" export="public">
doc:            <summary>Waits for a client to connect and send a message, then sends a message back.</summary>
doc:            <thread_safety></thread_safety>
doc:            <synchronization></synchronization>
doc:    </routine>
*/
int main ( int argc, char *argv[] )
{
	char * rmsg_buf;			/* buffer to store received message */
	int sockfd, new_fd;  			/* listen on sock_fd, new connection on new_fd */
	struct addrinfo hints, *servinfo, *p;	/* connection info */
	struct sockaddr_storage their_addr; 	/* connection info */
	socklen_t sin_size;			/* connection info */
	struct sigaction sa;			/* connection info */
	char s[INET6_ADDRSTRLEN];		/* connection info */
	int rv;					/* connection info */
	int yes=1;
	int numbytes;				/* number of bytes received */


	/* loop endlessly */
	while (1){

		/* wait for connection */
		memset (&hints, 0, sizeof hints);
		hints.ai_family = AF_UNSPEC;
		hints.ai_socktype = SOCK_STREAM;
		hints.ai_flags = AI_PASSIVE; // use my IP
		
		printf ("\n\n\nWaiting for a new client\n");
	
		if ((rv = getaddrinfo (NULL, PORT, &hints, &servinfo)) != 0){
			fprintf  (stderr, "getaddrinfo: %s\n", gai_strerror (rv));
			return 1;
		}

		/* loop through all the results and bind to the first we can */
		for (p = servinfo; p != NULL; p = p->ai_next){
			if ((sockfd = socket (p->ai_family, p->ai_socktype,
			                         p->ai_protocol)) == -1){
				perror ("server: socket");
				continue;
			}

			if (setsockopt (sockfd, SOL_SOCKET, SO_REUSEADDR, &yes,
			                  sizeof (int)) == -1){
				perror ("setsockopt");
				return 1;
			}

			if (bind (sockfd, p->ai_addr, p->ai_addrlen) == -1){
				close (sockfd);
				perror ("server: bind");
				continue;
			}

			break;
		}

		if (p == NULL){
			fprintf (stderr, "server: failed to bind\n");
		} else {
			freeaddrinfo (servinfo); 

			if (listen (sockfd, BACKLOG) == -1){
				perror ("listen");
				return 1;
			}
			
			sa.sa_handler = sigchld_handler; 
			sigemptyset (&sa.sa_mask);
			sa.sa_flags = SA_RESTART;
			if ( sigaction (SIGCHLD, &sa, NULL) == -1){
				perror ("sigaction");
				return 1;
			}

			printf ("Waiting for connections...\n");

			
			sin_size = sizeof their_addr;
			new_fd = accept (sockfd, (struct sockaddr *) &their_addr, &sin_size);

			if (new_fd == -1){
				perror ("accept");
			}

			inet_ntop (their_addr.ss_family,
			            get_in_addr ((struct sockaddr *) &their_addr),
			            s, sizeof s);
			printf ("Got connection from %s\n", s);

			numbytes = receive_message_fraged (&rmsg_buf, new_fd);

			if (numbytes < 1){

				printf ("could not receive message");
			} else {
				printf ("NOW I would do something very complicated\n");

				printf ("Sending back message.\n");


				char * message = (char *) malloc (1000 + numbytes);
				/*
				char * message = "Danke, alles gut.";
				*/				
				strcpy (message,"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\"><html><head><title>Welcome to Xebra!</title>  </head><body><h1>Welcome to C-XEbraServer!!</h1><br>Your request was:\n '");

				strcat (message,rmsg_buf);

				strcat (message, "'\n</body></html>");

				send_message_fraged (message, new_fd);
				
				free (message);
		
				printf ("All done.\n");
			}
			free (rmsg_buf);
		}

		shutdown (new_fd, 2);
		shutdown (sockfd, 2);
		close (new_fd);  
		close (sockfd);
	}
	return 0;
}





