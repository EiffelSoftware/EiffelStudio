#include "address.h"
#include <string.h>
#include <stdlib.h>

#ifndef INADDR_ANY
#define INADDR_ANY 0x0
#endif

/*******************************************************/

EIF_POINTER ADDR_create (void)
{
    ADDR_DATA* ad = (ADDR_DATA*) malloc(sizeof(ADDR_DATA));

    return (EIF_POINTER) ad;
}
/*******************************************************/

EIF_INTEGER ADDR_gethostbyname (EIF_POINTER ap,
                                EIF_POINTER n)
{
    ADDR_DATA* ad = (ADDR_DATA*) ap;

    ad->hent = gethostbyname ((char*) n);

    if (!ad->hent)
        return (EIF_INTEGER)-1;

    memcpy(&ad->ipaddr, ad->hent->h_addr_list[0], ad->hent->h_length);

    return (EIF_INTEGER) ad->hent->h_length;
}
/*******************************************************/

/*
 * The next two routines are only called from other
 * C routines.
 */

struct in_addr get_ipaddr (EIF_POINTER ap)
{
    ADDR_DATA* ad = (ADDR_DATA*) ap;

    return ad->ipaddr;
}
/*******************************************************/

EIF_POINTER create_addr (struct in_addr a)
{
    ADDR_DATA* ad = (ADDR_DATA*) malloc(sizeof(ADDR_DATA));

    if (ad == (ADDR_DATA*)0)
        return (EIF_POINTER)0;

    ad->hent   = (struct hostent*)0;
    ad->ipaddr = a;

    return (EIF_POINTER) ad;
}
/*******************************************************/

EIF_BOOLEAN ADDR_get_ipaddr_component (EIF_POINTER ap,
                                       EIF_POINTER rp,
                                       EIF_INTEGER i)
{
    ADDR_DATA* ad = (ADDR_DATA*) ap;
    char*      a  = (char*)&ad->ipaddr;

    if ((int)i > ad->hent->h_length || (int)i < 0)
        return (EIF_BOOLEAN)0;

    *((EIF_INTEGER*)rp) = (EIF_INTEGER) a[(int) i];
    return (EIF_BOOLEAN)1;
}
/*******************************************************/

EIF_BOOLEAN ADDR_gethostbyaddr (EIF_POINTER ap,
                                EIF_POINTER a,
                                EIF_POINTER p,
                                EIF_INTEGER n)
{
    ADDR_DATA*   ad     = (ADDR_DATA*) ap;
    char*        ipaddr = malloc((int)n + 1);
    EIF_INTEGER* aa = (EIF_INTEGER*)a;
    int          i;

    if (!ipaddr)
        return (EIF_BOOLEAN)0;

    for (i = 0; i < (int)n; ++i)
        ipaddr[i] = (unsigned char) aa[i];

    ipaddr[n] = '\0';

    ad->hent = gethostbyaddr (ipaddr, (int)n, AF_INET);

    if (!ad->hent)
        return (EIF_BOOLEAN)0;

    free ((void*)ipaddr);

    *((EIF_POINTER*)p) = (EIF_POINTER) ad->hent->h_name;
    return (EIF_BOOLEAN)1;
    
}
/*******************************************************/

EIF_INTEGER ADDR_get_nr_aliases (EIF_POINTER ap)
{
    ADDR_DATA*   ad = (ADDR_DATA*) ap;
    int          i;

    for (i = 0;; ++i)
        if (ad->hent->h_aliases [i] == (char*)0)
            break;

    return (EIF_INTEGER) (i - 1);
}
/*******************************************************/

EIF_POINTER ADDR_get_an_alias (EIF_POINTER ap,
                               EIF_INTEGER i)
{
    ADDR_DATA*   ad = (ADDR_DATA*) ap;

    return (EIF_POINTER) ad->hent->h_aliases[(int)i];
}
/*******************************************************/

static unsigned char buf[200];

EIF_POINTER ADDR_gethostname (void)
{
    memset (buf, 0, 200);
    gethostname (buf, 200);

    return (EIF_POINTER) buf;
}
/*******************************************************/

EIF_POINTER ADDR_inaddr_any (void)
{
    unsigned long  a  = htonl (INADDR_ANY);
    struct in_addr ia;

    memcpy(&ia, &a, sizeof(a));
    return create_addr (ia);
}
/*******************************************************/

EIF_INTEGER ADDR_Af_inet (void)
{
    return (EIF_INTEGER) AF_INET; /* This is a portable solution */
}
/*******************************************************/

EIF_INTEGER ADDR_Af_unix (void)
{
    return (EIF_INTEGER) AF_UNIX; /* This is a portable solution */
}
/*******************************************************/

EIF_INTEGER ADDR_htons (EIF_INTEGER n )
{
    return (EIF_INTEGER) htons ((unsigned short) n);
}
/*******************************************************/

EIF_INTEGER ADDR_ntohs (EIF_INTEGER n )
{
    return (EIF_INTEGER) ntohs ((int) n);
}
/******************************************************/

EIF_BOOLEAN MICO_ipvec_to_ipaddr (EIF_POINTER ap,
                                  EIF_POINTER p,
                                  EIF_INTEGER n)
{
    ADDR_DATA*     ad  = (ADDR_DATA*) ap;
    EIF_INTEGER*   pp  = (EIF_INTEGER*)p;
    struct in_addr sin;
    unsigned       res = 0;
    unsigned       i;
    char           buf[1024];

/*
    for (i = 0; i < (int)n; ++i)
        res = 256 * res + (signed char)pp [i];

    return (EIF_INTEGER) res;
*/
    if ((int)n != 4)
        return (EIF_BOOLEAN)0;

    sprintf(buf, "%d.%d.%d.%d", pp[0], pp[1], pp[2], pp[3]);
    sin.s_addr = inet_addr(buf);
    ad->ipaddr = sin;
    return (EIF_BOOLEAN)1;
}
/******************************************************/

/* This routine will have to be changed if IP addresses get longer */

EIF_BOOLEAN ADDR_get_ipvec (EIF_POINTER ap,
                            EIF_POINTER vp,
                            EIF_INTEGER n)
{
    ADDR_DATA*     ad  = (ADDR_DATA*) ap;
    EIF_INTEGER*   pp  = (EIF_INTEGER*) vp;
    struct in_addr sin = ad->ipaddr;
    char*          buf;

    if ((int)n != 4)
        return (EIF_BOOLEAN)0;

    buf = inet_ntoa(sin);
    sscanf(buf, "%d.%d.%d.%d", &pp[0], &pp[1], &pp[2], &pp[3]);
    return (EIF_BOOLEAN)1;
} 









