/* -*- c-basic-offset: 4 -*- */

#include "transport.h"
#include "address.h"
#include "buffer.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <netdb.h>
#include <sys/un.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/time.h>
#include <sys/types.h>
#include <stdlib.h>

static void xstrerror(void);

#define MAXBUF 1024
#define TRUE   1
#define FALSE  0

typedef int Boolean;

typedef struct
{
    int                fd;
    struct sockaddr_in sin;
    int                eof;
} SOCK_DATA_IN;

typedef struct
{
    int                fd;
    struct sockaddr_un sun;
    int                eof;
    int                do_unlink;
} SOCK_DATA_UN;

typedef struct
{
    fd_set rset;
    fd_set wset;
    fd_set xset;
    fd_set curr_rset;
    fd_set curr_wset;
    fd_set curr_xset;
} SELECT_DATA;

static char    err_text [1024];
static char    strbuf[1024];
static int     maxfd = -1;
/*************************************************************/

EIF_POINTER MICO_create_tcp_socket (void)
{
    SOCK_DATA_IN* sd = (SOCK_DATA_IN*) malloc (sizeof(SOCK_DATA_IN));
    int           fd = socket(PF_INET, SOCK_STREAM, 0);
    int           on = 1;

    if (!sd)
    {
        xstrerror();
        return (EIF_POINTER)0;
    }

    if (fd < 0)
    {
        xstrerror();
        return (EIF_POINTER)0;
    }
    else
        sd->fd = fd;

    if (fd > maxfd)
        maxfd = fd;

    sd->eof = 0;
    if (setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, (char*)&on, sizeof(on)) < 0)
    {
        xstrerror();
        return (EIF_POINTER)0;
    }

    return (EIF_POINTER) sd;
}
/******************************************************/

EIF_POINTER MICO_create_tcp_socket_with_fd (EIF_INTEGER fd)
{
   SOCK_DATA_IN* sd = (SOCK_DATA_IN*) malloc (sizeof(SOCK_DATA_IN));
   int           on = 1;

    if(!sd)
    {
        xstrerror();
        return (EIF_POINTER) 0;
    }

    if (fd > maxfd)
        maxfd = fd;

    sd->fd   = (int)fd;
    sd->eof  = 0;

    if (setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, (char*)&on, sizeof(on)) < 0)
    {
        xstrerror();
        return (EIF_POINTER)0;
    }    

    return (EIF_POINTER) sd;
}
/******************************************************/

EIF_POINTER MICO_create_unix_socket (void)
{
    SOCK_DATA_UN* sd = (SOCK_DATA_UN*) malloc (sizeof(SOCK_DATA_UN));
    int           fd = socket(PF_UNIX, SOCK_STREAM, 0);

    if (!sd)
    {
        xstrerror();
        return (EIF_POINTER)0;
    }

    if (fd < 0)
    {
        xstrerror();
        return (EIF_POINTER)0;
    }
    else
        sd->fd = fd;

    if (fd > maxfd)
        maxfd = fd;

    sd->eof  = 0;

    return (EIF_POINTER) sd;
}
/******************************************************/

EIF_POINTER MICO_create_unix_socket_with_fd (EIF_INTEGER fd)
{
   SOCK_DATA_UN* sd = (SOCK_DATA_UN*) malloc (sizeof(SOCK_DATA_UN));

    if (!sd)
    {
        xstrerror ();
        return (EIF_POINTER)0;
    }

    if (fd > maxfd)
        maxfd = fd;

    sd->fd   = (int)fd;
    sd->eof  = 0;

    return (EIF_POINTER) sd;
}
/******************************************************/

EIF_POINTER MICO_create_tcp_serv_socket (void)
{
    SOCK_DATA_IN* sd = (SOCK_DATA_IN*) malloc (sizeof(SOCK_DATA_IN));
    int           fd = socket(PF_INET, SOCK_STREAM, 0);
    int           on = 1;

    if (!sd)
    {
        xstrerror ();
        return (EIF_POINTER)0;
    }

    if (fd < 0)
    {
        xstrerror();
        return (EIF_POINTER)0;
    }
    else
        sd->fd = fd;

    if (fd > maxfd)
        maxfd = fd;

    sd->eof  = 0;

    if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, (char*)&on, sizeof(on)) < 0)
    {
        xstrerror();
        return (EIF_POINTER)0;
    }

    return (EIF_POINTER) sd;
}
/******************************************************/

EIF_INTEGER MICO_tcp_get_fd (EIF_POINTER sp)
{
    SOCK_DATA_IN* sd = (SOCK_DATA_IN*) sp;

    return (EIF_INTEGER) sd->fd;
}
/******************************************************/

EIF_INTEGER MICO_unix_get_fd (EIF_POINTER sp)
{
    SOCK_DATA_UN* sd = (SOCK_DATA_UN*) sp;

    return (EIF_INTEGER) sd->fd;
}
/******************************************************/
/*
 * a should be a pointer to a C structure representing the
 * IP address.
 * p should be the port number (*before* htons is applied
 * to it!!!).
 */

EIF_BOOLEAN MICO_tcp_bind (EIF_POINTER sp,
                           EIF_INTEGER p,
                           EIF_POINTER a)
{
    SOCK_DATA_IN*  sd  = (SOCK_DATA_IN*) sp;
    unsigned long  n   = htonl(INADDR_ANY);
    struct in_addr sin = get_ipaddr (a);

    /* Use a, p to initialize sd->sin */
    memset (&sd->sin, 0, sizeof(struct sockaddr_in));
    memcpy (&(sd->sin.sin_addr), &sin, sizeof(sd->sin.sin_addr));
    sd->sin.sin_family        = AF_INET;
    sd->sin.sin_port          = htons ((short)p);

    if (bind (sd->fd, (struct sockaddr*)&(sd->sin), sizeof(sd->sin)) < 0)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }
    return (EIF_BOOLEAN)1;
}
/******************************************************/
/*
 * a should be a pointer to a C structure representing the
 * IP address.
 * p should be the port number (*before* htons is applied
 * to it!!).
 */

EIF_BOOLEAN MICO_tcp_connect(EIF_POINTER sp,
                             EIF_INTEGER p,
                             EIF_POINTER a)
{
    SOCK_DATA_IN*  sd = (SOCK_DATA_IN*) sp;
    int            res;
    struct in_addr sin = get_ipaddr(a);

    /* Use p, a to initialize sd->sin */
    sd->sin.sin_family        = AF_INET;
    sd->sin.sin_port          = htons ((short)p);
    memcpy (&(sd->sin.sin_addr.s_addr), &sin, sizeof (struct in_addr));

    res = connect(sd->fd, (struct sockaddr*)&(sd->sin),
                            sizeof(struct sockaddr_in));

    if (res <0)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }
    else
        return (EIF_BOOLEAN)1;
}
/******************************************************/

void MICO_tcp_close(EIF_POINTER sp)
{
    SOCK_DATA_IN* sd = (SOCK_DATA_IN*) sp;

    close (sd->fd);
    free ((void *)sd); /* Not needed any more. */
}
/******************************************************/

EIF_BOOLEAN MICO_tcp_set_blocking (EIF_POINTER sp, EIF_BOOLEAN doblock)
{
    SOCK_DATA_IN* sd    = (SOCK_DATA_IN*) sp;
    int           flags = fcntl (sd->fd, F_GETFL, 0);

    if (flags == -1)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }

    if (doblock)
        flags &= ~O_NONBLOCK;
    else
        flags |= O_NONBLOCK;

    if (fcntl(sd->fd, F_SETFL, flags) < 0)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }
    return (EIF_BOOLEAN)1;
}
/******************************************************/

EIF_BOOLEAN MICO_tcp_isblocking(EIF_POINTER sp,
                                EIF_POINTER bp)
{
    SOCK_DATA_IN* sd    = (SOCK_DATA_IN*) sp;
    int           flags = fcntl (sd->fd, F_GETFL, 0);

    if (flags == -1)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }

    *((EIF_BOOLEAN*) bp) = (EIF_BOOLEAN) !!(flags & O_NONBLOCK);
    return (EIF_BOOLEAN)1;
}
/******************************************************/
/*
 * Read <= cnt bytes into the read buffer of
 * current.
 * Return the number of bytes actually read.
 */

EIF_INTEGER MICO_tcp_read (EIF_POINTER sp,
                           EIF_POINTER bf,
                           EIF_INTEGER len)
{
    SOCK_DATA_IN* sd   = (SOCK_DATA_IN*) sp;
    char*         b    = BUFFER_inbuf (bf);
    long          todo = (long) len;
    EIF_INTEGER   res  = (EIF_INTEGER)0;

    while (todo > 0)
    {
        res = read (sd->fd, b, todo);
        if (res < 0)
	{
            if (errno == EINTR)
                continue;
            if (errno == 0 || errno == EWOULDBLOCK || errno == EAGAIN ||
                todo != len)
                break;
            xstrerror();
            return res;
        }
        else if (res == 0)
	{
            sd->eof = TRUE;
            break;
        }
        b    += res;
        todo -= res;
    }
    return (len - todo);
}
/******************************************************/
/*
 * Write <= len bytes starting at BUFFER_buf (bf) + strt.
 * Return the number actually written.
 */

EIF_INTEGER MICO_tcp_write (EIF_POINTER sp,
                            EIF_POINTER bf,
                            EIF_INTEGER strt,
                            EIF_INTEGER len)
{
    SOCK_DATA_IN* sd   = (SOCK_DATA_IN*) sp;
    char*         b    = BUFFER_outbuf(bf);
    long          todo = (long) len;
    EIF_INTEGER   res  = (EIF_INTEGER)0;

    while (todo > 0)
    {
        res = write (sd->fd, b, todo);

        if (res < 0)
	{
            if (errno == EINTR)
                continue;
            if (errno == 0 || errno == EWOULDBLOCK || errno == EAGAIN ||
                todo != len)
                break;
            xstrerror();
            return res;
        }
        else if (res == 0)
            break;
        b    += res;
        todo -= res;
    }
   return (EIF_INTEGER) (len - todo);
}
/******************************************************/

EIF_BOOLEAN MICO_tcp_eof (EIF_POINTER sp)
{
    SOCK_DATA_IN* sd = (SOCK_DATA_IN*) sp;

    return (EIF_BOOLEAN) sd->eof;
}
/******************************************************/

EIF_BOOLEAN MICO_tcp_getsockname (EIF_POINTER sp,
                                  EIF_POINTER fp,
                                  EIF_POINTER pp,
                                  EIF_POINTER ap)
{
    SOCK_DATA_IN* sd = (SOCK_DATA_IN*) sp;
    int           len;

    if (getsockname (sd->fd, (struct sockaddr*)&(sd->sin), &len) < 0)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }
    else
    {
        *((EIF_INTEGER*) fp) = ((EIF_INTEGER) sd->sin.sin_family);
        *((EIF_INTEGER*) pp) = (EIF_INTEGER) ntohs(sd->sin.sin_port);
        *((EIF_POINTER*) ap) = create_addr (sd->sin.sin_addr);
        return (ap) ? (EIF_BOOLEAN)1 : (EIF_BOOLEAN)0;
            
    }
}
/******************************************************/

EIF_BOOLEAN MICO_tcp_getpeername (EIF_POINTER sp,
                                  EIF_POINTER fp,
                                  EIF_POINTER pp,
                                  EIF_POINTER ap)
{
    SOCK_DATA_IN*       sd = (SOCK_DATA_IN*) sp;
    EIF_POINTER         ep;
    struct sockaddr_in  sin;
    int                 len;

    if (getpeername (sd->fd, (struct sockaddr*)&sin, &len) < 0)
        /* XXX Allow for peer after disconnect ... */
        return (EIF_BOOLEAN) 0;
    else
    {
        *((EIF_INTEGER*) fp) = ((EIF_INTEGER) sin.sin_family);
        *((EIF_INTEGER*) pp) = (EIF_INTEGER) ntohs(sin.sin_port);
        ep                   = create_addr (sin.sin_addr);
        if (ep)
	{
            *((EIF_POINTER*) ap) = ep;
            return (EIF_BOOLEAN) 1;
        }

        return (EIF_BOOLEAN) 0;
    }
}
/******************************************************/

EIF_BOOLEAN MICO_tcp_listen (EIF_POINTER sp)
{
    SOCK_DATA_IN* sd;

    sd = (SOCK_DATA_IN*) sp;

    if (listen (sd->fd, 10) < 0)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }
    return (EIF_BOOLEAN)1;
}
/******************************************************/

EIF_BOOLEAN MICO_tcp_accept (EIF_POINTER sp,
                             EIF_POINTER ip)
{
    SOCK_DATA_IN*      sd = (SOCK_DATA_IN*) sp;
    int                newfd;
    struct sockaddr_in sin;
    int                len;
    char*              buf;

    if ((newfd = accept (sd->fd, (struct sockaddr*)0, (int*)0)) < 0)
        if (errno != EWOULDBLOCK && errno != EAGAIN)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }

    *((EIF_INTEGER*)ip) = (EIF_INTEGER) newfd;
    return (EIF_BOOLEAN)1;
}
/******************************************************/

EIF_BOOLEAN MICO_unix_bind (EIF_POINTER sp,
                            EIF_POINTER pp)

{
    SOCK_DATA_UN* sd = (SOCK_DATA_UN*) sp;

    /* Use f, p, a to initialize sd->sin */
    sd->sun.sun_family  = AF_UNIX;
    (void) strcpy (sd->sun.sun_path, (char*)pp);
    sd->do_unlink = TRUE;

    if (bind (sd->fd, (struct sockaddr*)&(sd->sun), sizeof(sd->sun)) < 0)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }
    return (EIF_BOOLEAN)1;
}
/******************************************************/

EIF_BOOLEAN MICO_unix_connect (EIF_POINTER sp,
                               EIF_POINTER pp)

{
    SOCK_DATA_UN* sd = (SOCK_DATA_UN*) sp;

    /* Use pp to initialize sd->sin */
    sd->sun.sun_family = AF_UNIX;
    (void) strcpy (sd->sun.sun_path, (char*)pp);

    if (connect (sd->fd, (struct sockaddr*)&(sd->sun), sizeof(sd->sun)) < 0)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }
    return (EIF_BOOLEAN)1;
}
/******************************************************/

void MICO_unix_close(EIF_POINTER sp)
{
    SOCK_DATA_UN* sd = (SOCK_DATA_UN*) sp;

    if (sd->do_unlink && sd->sun.sun_path)
        unlink (sd->sun.sun_path);

    close (sd->fd);
    free ((void *)sd); /* Not needed any more. */
}
/******************************************************/

EIF_BOOLEAN MICO_unix_set_blocking (EIF_POINTER sp, EIF_BOOLEAN doblock)
{
    SOCK_DATA_UN* sd    = (SOCK_DATA_UN*) sp;
    int           flags = fcntl (sd->fd, F_GETFL, 0);

    if (flags == -1)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }

    if (doblock)
        flags &= ~O_NONBLOCK;
    else
        flags |= O_NONBLOCK;

    if (fcntl(sd->fd, F_SETFL, flags) < 0)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }
    return (EIF_BOOLEAN)1;
}
/******************************************************/

EIF_BOOLEAN MICO_unix_isblocking(EIF_POINTER sp,
                                 EIF_POINTER bp)
{
    SOCK_DATA_UN* sd    = (SOCK_DATA_UN*) sp;
    int           flags = fcntl (sd->fd, F_GETFL, 0);

    if (flags == -1)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }

    *((EIF_BOOLEAN*) bp) = (EIF_BOOLEAN) !!(flags & O_NONBLOCK);

    return (EIF_BOOLEAN)1;
}
/******************************************************/
/*
 * Read <= cnt bytes into the read buffer of
 * current.
 * Return the number of bytes actually read.
 */

EIF_INTEGER MICO_unix_read (EIF_POINTER sp,
                            EIF_POINTER bf,
                            EIF_INTEGER len)
{
    SOCK_DATA_UN* sd   = (SOCK_DATA_UN*) sp;
    char*         b    = BUFFER_inbuf (bf);
    long          todo = (long) len;
    EIF_INTEGER   res  = (EIF_INTEGER)0;

    while (todo > 0)
    {
        res = read (sd->fd, b, todo);
        if (res < 0)
	{
            if (errno == EINTR)
                continue;
            if (errno == 0 || errno == EWOULDBLOCK || errno == EAGAIN ||
                todo != len)
                break;
            xstrerror();
            return res;
        }
        else if (res == 0)
	{
            sd->eof = TRUE;
            break;
        }
        b    += res;
        todo -= res;
    }
    return (len - todo);
}
/******************************************************/
/*
 * Write <= len bytes starting at BUFFER_buf (bf) + strt.
 * Return the number actually written.
 */

EIF_INTEGER MICO_unix_write (EIF_POINTER sp,
                             EIF_POINTER bf,
                             EIF_INTEGER strt,
                             EIF_INTEGER len)
{
    SOCK_DATA_UN* sd   = (SOCK_DATA_UN*) sp;
    char*         b    = BUFFER_outbuf(bf);
    long          todo = (long) len;
    EIF_INTEGER   res  = (EIF_INTEGER)0;

    while (todo > 0)
    {
        res = write (sd->fd, b, todo);

        if (res < 0)
	{
            if (errno == EINTR)
                continue;
            if (errno == 0 || errno == EWOULDBLOCK || errno == EAGAIN ||
                todo != len)
                break;
            xstrerror();
            return res;
        }
        else if (res == 0)
            break;
        b    += res;
        todo -= res;
    }
   return (EIF_INTEGER) (len - todo);
}
/******************************************************/

EIF_BOOLEAN MICO_unix_eof (EIF_POINTER sp)
{
    SOCK_DATA_UN* sd = (SOCK_DATA_UN*) sp;

    return (EIF_BOOLEAN) sd->eof;
}
/******************************************************/

EIF_BOOLEAN MICO_unix_getsockname (EIF_POINTER sp,
                                   EIF_POINTER fp,
                                   EIF_POINTER pp)

{
    SOCK_DATA_UN* sd = (SOCK_DATA_UN*) sp;
    int           len;

    if (getsockname (sd->fd, (struct sockaddr*)&(sd->sun), &len) < 0)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }
    else
    {
        *((EIF_INTEGER*) fp) = ((EIF_INTEGER) sd->sun.sun_family);
        *((EIF_POINTER*) pp) = ((EIF_POINTER) sd->sun.sun_path);
        return (EIF_BOOLEAN)1;
    }
}
/******************************************************/

EIF_BOOLEAN MICO_unix_getpeername (EIF_POINTER sp,
                                   EIF_POINTER fp,
                                   EIF_POINTER pp)

{
    SOCK_DATA_UN*       sd = (SOCK_DATA_UN*) sp;
    struct sockaddr_un  sun;
    int                 len;

    if (getpeername (sd->fd, (struct sockaddr*)&sun, &len) < 0)
        /* XXX Allow for peer after disconnect ... */
        return (EIF_BOOLEAN) 0;
    else
    {
        *((EIF_INTEGER*) fp) = ((EIF_INTEGER) sun.sun_family);
        *((EIF_POINTER*) pp) = ((EIF_POINTER) sun.sun_path);
        return (EIF_BOOLEAN) 1;
    }
}
/******************************************************/

EIF_POINTER MICO_create_unix_serv_socket (void)
{
   SOCK_DATA_UN* sd = (SOCK_DATA_UN*) malloc (sizeof(SOCK_DATA_UN));
   int           fd = socket(PF_UNIX, SOCK_STREAM, 0);

   if (!sd)
   {
        xstrerror();
        return (EIF_POINTER)0;
   }
   if (fd < 0)
   {
        xstrerror();
        return (EIF_POINTER)0;
   }
   else
       sd->fd = fd;

    sd->eof  = 0;

    return (EIF_POINTER) sd;
}
/******************************************************/

EIF_BOOLEAN MICO_unix_accept (EIF_POINTER sp,
                              EIF_POINTER ip)
{
    SOCK_DATA_UN* sd = (SOCK_DATA_UN*) sp;
    int           newfd;

    if ((newfd = accept (sd->fd, 0, 0)) < 0)
    {
        if (errno != EWOULDBLOCK && errno != EAGAIN)
	{
            xstrerror();
            return (EIF_BOOLEAN)0;
        }
    }
    
    *((EIF_INTEGER*) ip) = (EIF_INTEGER) newfd;
    return (EIF_BOOLEAN)1;
}
/******************************************************/

EIF_BOOLEAN MICO_unix_listen (EIF_POINTER sp)
{
    SOCK_DATA_UN* sd = (SOCK_DATA_UN*) sp;

    if (listen (sd->fd, 10) < 0)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }
    return (EIF_BOOLEAN)1;
}
/******************************************************/

void MICO_unlink (EIF_POINTER fn)
{
    unlink ((char*)fn);
}
/******************************************************/

EIF_POINTER MICO_transport_errormsg (void)
{
    return (EIF_POINTER) err_text;
}
/******************************************************/

EIF_POINTER MICO_get_rset (EIF_POINTER sp)
{
    return (EIF_POINTER) &(((SELECT_DATA*) sp)->rset);
}
/******************************************************/

EIF_POINTER MICO_get_wset (EIF_POINTER sp)
{
    return (EIF_POINTER) &(((SELECT_DATA*) sp)->wset);
}
/******************************************************/

EIF_POINTER MICO_get_xset (EIF_POINTER sp)
{
    return (EIF_POINTER) &(((SELECT_DATA*) sp)->xset);
}
/******************************************************/

EIF_POINTER MICO_get_curr_rset (EIF_POINTER sp)
{
    return (EIF_POINTER) &(((SELECT_DATA*) sp)->curr_rset);
}
/******************************************************/

EIF_POINTER MICO_get_curr_wset (EIF_POINTER sp)
{
    return (EIF_POINTER) &(((SELECT_DATA*) sp)->curr_wset);
}
/******************************************************/

EIF_POINTER MICO_get_curr_xset (EIF_POINTER sp)
{
    return (EIF_POINTER) &(((SELECT_DATA*) sp)->curr_xset);
}
/******************************************************/

EIF_POINTER MICO_string_from_fdset (EIF_POINTER sp)
{
    char* str = (char*) malloc (sizeof (fd_set) + 1);
    int   i;

    for (i = 0; i < sizeof (fd_set); ++i)
    {
        if (FD_ISSET (i , (fd_set*) sp))
            str[i] = '1';
        else
            str[i] = '0';
    }

    str[i]              = '\0';
    return (EIF_POINTER) str;
}
/******************************************************/

EIF_POINTER MICO_create_select_dispatcher (void)
{
    SELECT_DATA* sd = (SELECT_DATA*) malloc (sizeof (SELECT_DATA));

    if (!sd)
        return (EIF_POINTER)0;

    FD_ZERO(&(sd->curr_rset));
    FD_ZERO(&(sd->curr_wset));
    FD_ZERO(&(sd->curr_xset));

    return (EIF_POINTER) sd;
}
/******************************************************/

void MICO_zero_fdsets (EIF_POINTER sp)
{
    SELECT_DATA* sd = (SELECT_DATA*) sp;

    FD_ZERO(&(sd->curr_rset));
    FD_ZERO(&(sd->curr_wset));
    FD_ZERO(&(sd->curr_xset));
}
/******************************************************/

void MICO_add_to_rset (EIF_POINTER sp,
                       EIF_INTEGER fd)
{
    SELECT_DATA* sd = (SELECT_DATA*) sp;

    FD_SET((int)fd, &(sd->curr_rset));
}
/******************************************************/

void MICO_add_to_wset (EIF_POINTER sp,
                       EIF_INTEGER fd)
{
    SELECT_DATA* sd = (SELECT_DATA*) sp;

    FD_SET((int)fd, &(sd->curr_wset));
}
/******************************************************/

void MICO_add_to_xset (EIF_POINTER sp,
                       EIF_INTEGER fd)
{
    SELECT_DATA* sd = (SELECT_DATA*) sp;

    FD_SET((int)fd, &(sd->curr_xset));
}
/******************************************************/

EIF_BOOLEAN MICO_is_set_in_rset (EIF_POINTER sp,
                                 EIF_INTEGER fd)
{
    SELECT_DATA* sd = (SELECT_DATA*) sp;

    return (EIF_BOOLEAN) FD_ISSET ((int)fd, &(sd->rset));
}
/******************************************************/

EIF_BOOLEAN MICO_is_set_in_wset (EIF_POINTER sp,

                                 EIF_INTEGER fd)
{
    SELECT_DATA* sd = (SELECT_DATA*) sp;

    return (EIF_BOOLEAN) FD_ISSET ((int)fd, &(sd->wset));
}
/******************************************************/

EIF_BOOLEAN MICO_is_set_in_xset (EIF_POINTER sp,
                                 EIF_INTEGER fd)
{
    SELECT_DATA* sd = (SELECT_DATA*) sp;

    return (EIF_BOOLEAN) FD_ISSET ((int)fd, &(sd->xset));
}
/******************************************************/

EIF_BOOLEAN MICO_select (EIF_POINTER sp,
                         EIF_INTEGER sec,
                         EIF_INTEGER usec)
{
    SELECT_DATA*   sd = (SELECT_DATA*) sp;
    struct timeval tm;
    int            res;

    tm.tv_sec  = (unsigned)sec;
    tm.tv_usec = (unsigned)usec;

    memcpy ((char*)&(sd->rset),
            (char*)&(sd->curr_rset),
            sizeof (sd->curr_rset));
    memcpy ((char*)&(sd->wset),
            (char*)&(sd->curr_wset),
            sizeof (sd->curr_wset));
    memcpy ((char*)&(sd->xset),
            (char*)&(sd->curr_xset),
            sizeof (sd->curr_xset));

    res = select (FD_SETSIZE, &(sd->rset), &(sd->wset), &(sd->xset), &tm);

    if (res < 0 && errno != EINTR && errno != EAGAIN)
    {
        xstrerror();
        return (EIF_BOOLEAN)0;
    }

    return (EIF_BOOLEAN) (res > 0); /* has something happened? */
}
/******************************************************/

static void xstrerror(void)
{
    strcpy (err_text, sys_errlist[errno]);

    return;
}



