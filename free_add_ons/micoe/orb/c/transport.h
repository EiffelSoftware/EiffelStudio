/* externals from tcp_transport.e, tcp_transport_server.e,
                  unix_transport and unix_transport_server */
#include "eiffel.h"

extern EIF_POINTER MICO_create_tcp_socket (void);
extern EIF_POINTER MICO_create_tcp_socket_with_fd (EIF_INTEGER);
extern EIF_INTEGER MICO_tcp_get_fd (EIF_POINTER);
extern EIF_BOOLEAN MICO_tcp_bind (EIF_POINTER, EIF_INTEGER, EIF_POINTER);
extern EIF_BOOLEAN MICO_tcp_connect (EIF_POINTER, EIF_INTEGER, EIF_POINTER);
extern void        MICO_tcp_close (EIF_POINTER);
extern EIF_BOOLEAN MICO_tcp_set_blocking (EIF_POINTER, EIF_BOOLEAN);
extern EIF_BOOLEAN MICO_tcp_isblocking (EIF_POINTER, EIF_POINTER);
extern EIF_INTEGER MICO_tcp_read (EIF_POINTER, EIF_POINTER, EIF_INTEGER);
extern EIF_INTEGER MICO_tcp_write (EIF_POINTER,
                                   EIF_POINTER,
                                   EIF_INTEGER,
                                   EIF_INTEGER);
extern EIF_BOOLEAN MICO_tcp_eof (EIF_POINTER);
extern EIF_BOOLEAN MICO_tcp_getsockname (EIF_POINTER, EIF_POINTER,
                                         EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_tcp_getpeername (EIF_POINTER, EIF_POINTER,
                                         EIF_POINTER, EIF_POINTER);

/**************************************************************************/

extern EIF_POINTER MICO_create_tcp_serv_socket (void);
extern EIF_BOOLEAN MICO_tcp_listen (EIF_POINTER);
extern EIF_BOOLEAN MICO_tcp_accept (EIF_POINTER, EIF_POINTER);


/*****************************************************************************/

extern EIF_POINTER MICO_create_unix_socket (void);
extern EIF_POINTER MICO_create_unix_socket_with_fd (EIF_INTEGER);
extern EIF_INTEGER MICO_unix_get_fd (EIF_POINTER);
extern EIF_BOOLEAN MICO_unix_bind (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_unix_connect (EIF_POINTER, EIF_POINTER);
extern void        MICO_unix_close (EIF_POINTER);
extern EIF_BOOLEAN MICO_unix_set_blocking (EIF_POINTER, EIF_BOOLEAN);
extern EIF_BOOLEAN MICO_unix_isblocking (EIF_POINTER, EIF_POINTER);
extern EIF_INTEGER MICO_unix_read (EIF_POINTER, EIF_POINTER, EIF_INTEGER);
extern EIF_INTEGER MICO_unix_write (EIF_POINTER,
                                    EIF_POINTER,
                                    EIF_INTEGER,
                                    EIF_INTEGER);
extern EIF_BOOLEAN MICO_unix_eof (EIF_POINTER);
extern EIF_BOOLEAN MICO_unix_getsockname (EIF_POINTER,
                                          EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_unix_getpeername (EIF_POINTER,
                                          EIF_POINTER, EIF_POINTER);
extern void        MICO_unlink (EIF_POINTER);

/****************************************************************************/

extern EIF_POINTER MICO_create_unix_serv_socket (void);
extern EIF_BOOLEAN MICO_unix_listen (EIF_POINTER);
extern EIF_BOOLEAN MICO_unix_accept (EIF_POINTER, EIF_POINTER);

/****************************************************************************/

extern EIF_POINTER MICO_transport_errmsg (void);






