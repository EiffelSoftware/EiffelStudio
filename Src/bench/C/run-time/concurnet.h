#ifndef _CONCURRENT_CONCURNET_
#define _CONCURRENT_CONCURNET_

#ifdef EIF_WIN32
#define my_set_sock_option(s) \
            { struct linger my_opt; \
            int ret; \
            my_opt.l_onoff = 1; \
            my_opt.l_linger = 100; \
            ret = setsockopt(s, SOL_SOCKET, SO_LINGER, (char *)&my_opt, sizeof(struct linger)); \
            }
#else
#define my_set_sock_option(s) ;
#endif
                                                      

extern 		void c_close_socket ();
extern 		void c_set_blocking ();
extern 		void c_set_non_blocking ();
extern 		EIF_INTEGER c_accept ();
extern 		void c_listen ();

#define     c_concur_close_socket(s) \
            { \
            my_set_sock_option(s); \
            c_close_socket(s); \
            }
#define		c_concur_set_blocking(s)			c_set_blocking(s)
#define		c_concur_set_non_blocking(s)		c_set_non_blocking(s)
#define		c_concur_my_accept(x, y, z)			c_accept(x, y, z) 
#define		c_concur_listen(s, n)				c_listen(s, n)


extern 		EIF_INTEGER c_socket ();
extern 		void set_sin_addr ();
extern 		void host_address_from_name ();
extern 		EIF_INTEGER net_host_addr ();

#define		c_concur_socket(a, t, p)			c_socket(a, t, p)
#define		c_concur_set_host_addr(x, y)		set_sin_addr(x, y)
#define		c_concur_host_address_from_name(x, y)	host_address_from_name(x, y)
#define		c_concur_net_host_addr(x)			net_host_addr(x)


extern 		EIF_INTEGER c_read_int ();
extern 		EIF_REAL c_read_float ();
extern 		EIF_DOUBLE c_read_double ();
extern 		EIF_INTEGER c_read_stream ();

#define		c_concur_read_int(s)				ntohl(c_read_int(s))
#define		c_concur_read_real(s)				c_read_float(s)
#define		c_concur_read_double(s)				c_read_double(s)
#define 	c_concur_my_read_stream(s, l, b)	c_read_stream(s, l, b)


extern 		void c_put_stream ();
extern 		void c_put_int ();
extern 		void c_put_float ();
extern 		void c_put_double ();

#define		c_concur_put_stream(s, p, l)		c_put_stream(s, p, l)
#define		c_concur_put_int(s, v)				c_put_int(s, htonl(v))
#define		c_concur_put_real(s, v)				c_put_float(s, v)
#define		c_concur_put_double(s, v)			c_put_double(s, v)


extern 		EIF_INTEGER c_select();

/*
#define 	c_concur_select(fn, rm, wm, em, to, tom)	c_select(fn, rm, wm, em, to, tom)
*/
#ifdef EIF_WIN32
#define 	c_concur_select( ret, nfds, rmask, wmask, emask, timeout, timeoutm)	{ \
	do_init(); \
	if (timeout == -1) { \
		if ((ret = select ((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, (struct timeval *) NULL)) == SOCKET_ERROR) \
			eio(); \
 	} else { \
		struct timeval t; \
		t.tv_sec = timeout; \
		t.tv_usec = timeoutm; \
		if ((ret = select ((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, &t)) == SOCKET_ERROR) \
			eio(); \
	} \
	} 
#else
#define 	c_concur_select( ret, nfds, rmask, wmask, emask, timeout, timeoutm)	{ \
	if (timeout == -1) { \
		if ((ret = select ((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, (struct timeval *) NULL)) < 0) \
			eio(); \
 	} else { \
		struct timeval t; \
		t.tv_sec = timeout; \
		t.tv_usec = timeoutm; \
		if ((ret = select ((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, &t)) < 0) \
			eio(); \
	} \
	}
#endif
		
#endif
