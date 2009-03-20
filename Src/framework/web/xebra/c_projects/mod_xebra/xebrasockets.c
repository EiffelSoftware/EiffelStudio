/*
	description: "Provides methods to send and receive messages to and from Xebra Server via TCP sockets"
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
doc:    <routine name="byteArrayToInt" export="public">
doc:            <summary>Converts an array of 4 bytes to an integer.</summary>
doc:            <param name="b" type="char*">The bytes to convert</param>
doc:            <thread_safety></thread_safety>
doc:            <synchronization></synchronization>
doc:    </routine>
*/
EIF_INTEGER_32 byteArrayToInt (char * b)
{
	return (b[0] << 24)
	       + ((b[1] & 0xFF) << 16)
	       + ((b[2] & 0xFF) << 8)
	       + (b[3] & 0xFF);
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
	REQUIRE("i_not_to_big", i < 2^31);


	return (i << 1) +  flag;
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
	if (sa->sa_family == AF_INET){
		return & (((struct sockaddr_in*)sa)->sin_addr);
	}

	return & (((struct sockaddr_in6*)sa)->sin6_addr);
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
EIF_INTEGER_32 send_message_fraged (char * message, EIF_INTEGER_32 sockfd)
{
	EIF_INTEGER_32 numbytes = -1;		/* how much was sent in the last recv*/
	EIF_NATURAL_32 bytes_of_msg_sent = 0;	/* how much is already sent (total) */
	char * encoded_msg_length_byte;		/* ncoded size (as byte) of (frag of) message with frag flag */
	char * frag_msg;			/* conatins the frag of message that is sent in the current loop */
	char * m_pointer;			/* points to the start of part of message from where in the next step FRAG_SIZE byte will be sent */

	REQUIRE ("sockfd_valid", sockfd );

	DEBUG ("About to send message. Length is %i bytes\n", strlen (message));

	/* Create fragment */
	DEBUG2 ("   ---trying malloc...frag_msg     ");

	frag_msg = (char*) malloc (sizeof(char) * FRAG_SIZE  + 1);

	DEBUG2 ("ok\n");

	if (frag_msg == NULL){
		fprintf (stderr, "Error mallocating!");
		fflush (stderr);
		return -1;
	}

	frag_msg[0] = (char) 0;

	/* initially, the m_pointer points to the start of message (to the whole message) */
	m_pointer = message;

	/* loop until the whole message has been sent */
	while (bytes_of_msg_sent < strlen (message)){

		/* do we have to fragment the (current lenght of) message or not */
		if (strlen (m_pointer) <= FRAG_SIZE){
			/* we don't have to */

			/* free the space for frag_msg before we attach it to another location */
			free (frag_msg);
			frag_msg = m_pointer;

			DEBUG (" -About to send last fragment. Length is %i bytes\n", strlen (frag_msg));

			/* encode last fragment */
			encoded_msg_length_byte = intToByteArray (encode_natural (strlen (frag_msg), 0));
		} else {
			/* we have to fragment the message*/

			/* copy FRAG_SIZE bytes from the original message (=m_pointer) into the frag_msg, which will be sent then */
			strncpy (frag_msg, m_pointer, sizeof (char) * FRAG_SIZE);
			frag_msg[sizeof (char) * FRAG_SIZE] = '\0';


			DEBUG ("-About to send fragment. Length is %i bytes\n", strlen (frag_msg));

			/* encode frag_msg */
			encoded_msg_length_byte = intToByteArray (encode_natural (strlen (frag_msg), 1));
		}

		DEBUG (" -Sending... ");
		DEBUG2 ("'%s'",frag_msg);
		DEBUG ("\n");

		/* send encoded messagte length */
		numbytes = send (sockfd, encoded_msg_length_byte , sizeof (int) , 0);
		if (numbytes < 1){
			fprintf (stderr, "failed to send encoded_msg_lengh\n");
			fflush (stderr);
			return 0;
		}

		free (encoded_msg_length_byte);

		/* send message */
		numbytes = send (sockfd, frag_msg , strlen (frag_msg) *sizeof (char) , 0);

		if (numbytes < 1){
			fprintf (stderr, "failed to send frag_msg\n");
			fflush (stderr);
			return 0;
		}

		bytes_of_msg_sent += strlen (frag_msg) * sizeof (char);

		/* shift m_pointer to the right to 'cut off' the already sent part (=frag_msg) */
		m_pointer = m_pointer + (sizeof (char) * FRAG_SIZE);
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
EIF_INTEGER_32 receive_message_fraged (char **msg_buf, EIF_INTEGER_32 sockfd)
{
	EIF_INTEGER_32 msg_buf_strlength;		/* string length of *msg_buf */
	char* frag_buf;					/* stores the frag to be received */
	EIF_INTEGER_32 numbytes = 0;			/* received bytes */
	char frag_length_byte[sizeof (int)];		/* length of received frag (bytes) */
	EIF_NATURAL_32 frag_length;			/* length of received frag (int) */
	EIF_BOOLEAN flag = 0;				/* contains the frag flag of the just received msg */
	EIF_NATURAL_32 bytes_to_receive = 0;		/* how many bytes are we going to receive in this frag */
	EIF_NATURAL_32 frag_length_int;			/* buffer to copy msg */
	char buf[sizeof (char) * FRAG_SIZE+1];		/* buffer to receive message fragment fragments */
	EIF_INTEGER_32 bytes_recv;			/* number of bytes receivced for one fragment */

	DEBUG ("Receiving message...\n");

	DEBUG2 ("   ---trying malloc...*msg_buf        ");
	(*msg_buf) = (char*) malloc (1);
	DEBUG2 ("ok\n");

	/* resetting *msg_buf */
	*msg_buf[0] = (char) 0;
	msg_buf_strlength = 0;

	/* create buffer to receive message fragment */
	DEBUG2 ("   ---trying malloc...*frag_buf          " );
	frag_buf = (char*) malloc (sizeof(char) * FRAG_SIZE + 1);
	DEBUG2 ("ok\n" );

	if ((frag_buf) == NULL){
		fprintf (stderr, "Error mallocating frag_buf!\n");
		fflush (stderr);
		return -1;
	}

	/* loop until we recieve a fragment with flag=0 */
	do{
		/* receive first 4 bytes determining length of message */
		numbytes = recv (sockfd, frag_length_byte, sizeof (int), 0);
		if (numbytes != sizeof (int)){
			perror ("recv");
			fprintf ( stderr, "Failed to receive fragment length. Received %i bytes instead of 4 bytes\n", numbytes);
			fflush (stderr);
			return -1;
		}

		/* decode */
		frag_length_int = byteArrayToInt (frag_length_byte);
		frag_length =  decode_natural (frag_length_int);
		flag = decode_flag (frag_length_int);

		DEBUG ("Incoming frag, %i bytes, flag is %i\n" ,frag_length, flag);

		strcpy (frag_buf,"");
		bytes_recv = 0;

		/* loop to recieve whole fragement */
		while (bytes_recv < frag_length){
			numbytes = recv (sockfd, buf, frag_length-bytes_recv, 0);
			buf[numbytes] = '\0';

			DEBUG ("  --filling buffer...%i bytes\n",numbytes);

			if (numbytes < 1){
				fprintf (stderr, "Failed to receive message. numbytes=%i\n",numbytes);
				fflush (stderr);
				return -1;
			}
			bytes_recv += numbytes;
			strcat (frag_buf, buf);
		}

		numbytes = bytes_recv;

		if (numbytes != frag_length){
			fprintf (stderr, "ERROR, received bytes=%i, frag_lengh is %i", numbytes,frag_length);
			fflush (stderr);
			return -1;
		}

		frag_buf[numbytes] = '\0';

		DEBUG ("Recieved %i bytes...:", numbytes);
		DEBUG2 ("'%s'", frag_buf);
		DEBUG ("\n");

		/* extend *msg_buf and copy frag to end of it */
		*msg_buf = (char *) realloc (*msg_buf, msg_buf_strlength + numbytes + 1);
		memcpy (*msg_buf + msg_buf_strlength, frag_buf, numbytes);
		msg_buf_strlength += numbytes;
	}while (flag == 1);

	free (frag_buf);

	DEBUG ("Completed recieving message.\n");

	return msg_buf_strlength;
}
