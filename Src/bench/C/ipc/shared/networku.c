/*
	NETWORKU.C - a file of network utilities not provided by default under Win32.

	The Windows equivalents can be found in Winsock but we don't have that
	in ebench.  This guarantees that the same functions are used everywhere.

	See UNIX man pages for the details of the functions and their purpose.
*/

#include "networku.h"

#define NTOHL(x)	(((x & 0x000000ffU) << 24) | \
					((x & 0x0000ff00U) <<  8) |	\
					((x & 0x00ff0000U) >>  8) |	\
					((x & 0xff000000U) >> 24))

#define NTOHS(x)	(((x & 0x00ff) << 8) |	\
					((x & 0xff00) >> 8))	

unsigned short ntohs(unsigned short x) {
	return (unsigned short) NTOHS(x);
}

unsigned short htons(short x) {
	return (unsigned short) NTOHS(x);
}

long ntohl(long x) {
	return NTOHL(x);
}

long htonl(long x) {
	return NTOHL(x);
}

