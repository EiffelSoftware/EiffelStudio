#include "eiffel.h"
#include <netdb.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>

typedef struct
{
    struct hostent* hent;
    struct in_addr  ipaddr; /* Don't hand this back to the
                               Eiffel side; on 32-bit machines
                               Eiffel can't handle unsigned long!
			    */
} ADDR_DATA;

/* Externals from inet_address.e and unix_address.e */

extern EIF_POINTER ADDR_create (void);
extern EIF_INTEGER ADDR_gethostbyname (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN ADDR_gethostbyaddr (EIF_POINTER,
                                       EIF_POINTER,
                                       EIF_POINTER,
                                       EIF_INTEGER);
extern EIF_BOOLEAN ADDR_get_ipaddr_component (EIF_POINTER,
                                              EIF_POINTER, EIF_INTEGER);
extern EIF_INTEGER ADDR_get_nr_aliases (EIF_POINTER);
extern EIF_POINTER ADDR_get_an_alias (EIF_POINTER, EIF_INTEGER);
extern EIF_POINTER ADDR_inaddr_any (void);
extern EIF_BOOLEAN ADDR_get_ipvec (EIF_POINTER, EIF_POINTER, EIF_INTEGER);
extern EIF_INTEGER ADDR_Af_inet (void);
extern EIF_INTEGER ADDR_Af_unix (void);
extern EIF_POINTER MICO_tempnam (void);

extern struct in_addr get_ipaddr(EIF_POINTER);
extern EIF_POINTER    create_addr(struct in_addr);

extern EIF_BOOLEAN MICO_ipvec_to_ipaddr (EIF_POINTER,
                                         EIF_POINTER, EIF_INTEGER);


