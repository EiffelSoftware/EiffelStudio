#include "net.h"

extern 		void c_close_socket ();
extern 		void c_set_blocking ();
extern 		void c_set_non_blocking ();
extern 		EIF_INTEGER c_accept ();
extern 		void c_listen ();

#define 	c_concur_close_socket(s)			c_close_socket(s)
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

#define		c_concur_read_int(s)				c_read_int(s)
#define		c_concur_read_real(s)				c_read_float(s)
#define		c_concur_read_double(s)				c_read_double(s)
#define 	c_concur_my_read_stream(s, l, b)	c_read_stream(s, l, b)

extern 		void c_put_stream ();
extern 		void c_put_int ();
extern 		void c_put_float ();
extern 		void c_put_double ();

#define		c_concur_put_stream(s, p, l)		c_put_stream(s, p, l)
#define		c_concur_put_int(s, v)				c_put_int(s, v)
#define		c_concur_put_real(s, v)				c_put_float(s, v)
#define		c_concur_put_double(s, v)			c_put_double(s, v)

