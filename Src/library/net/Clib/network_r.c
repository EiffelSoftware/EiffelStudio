#include "config.h"

#include <sys/types.h>
#include <sys/time.h>
#include <errno.h>
#include <fcntl.h>
#include "cecil.h"

#ifdef I_SYS_SOCKET
#include <sys/socket.h>
#include <netdb.h>
#endif

#ifdef I_NETINET_IN
#include <netinet/in.h>
#endif
#ifdef I_SYS_IN
#include <sys/in.h>
#endif
#include <sys/un.h>
#include <netinet/tcp.h>
#ifdef SOC_XNS
#include <netns/ns.h>
#endif

#ifndef FNDELAY
#define FNDELAY O_NDELAY
#endif

#ifndef FASYNC
#define FASYNC O_SYNC
#endif

EIF_INTEGER c_errorno()
{
	return (EIF_INTEGER) errno;
}

EIF_INTEGER family_no_support ()
{
	return (EIF_INTEGER) EAFNOSUPPORT;
}

EIF_INTEGER proto_no_support ()
{
	return (EIF_INTEGER) EPROTONOSUPPORT;
}

EIF_INTEGER table_full ()
{
	return (EIF_INTEGER) EMFILE;
}

EIF_INTEGER no_buffs ()
{
	return (EIF_INTEGER) ENOBUFS;
}

EIF_INTEGER c_permission ()
{
	return (EIF_INTEGER) EPERM;
}

EIF_INTEGER bad_socket()
{
	return (EIF_INTEGER) EBADF;
}

EIF_INTEGER no_socket ()
{
	return (EIF_INTEGER) ENOTSOCK;
}

EIF_INTEGER error_address ()
{
	return (EIF_INTEGER) EADDRNOTAVAIL;
}

EIF_INTEGER busy_address ()
{
	return (EIF_INTEGER) EADDRINUSE;
}

EIF_INTEGER bound_address ()
{
	return (EIF_INTEGER) EINVAL;
}

EIF_INTEGER no_access ()
{
	return (EIF_INTEGER) EACCES;
}

EIF_INTEGER unreadable ()
{
	return (EIF_INTEGER) EFAULT;
}

EIF_INTEGER no_connect ()
{
	return (EIF_INTEGER) EOPNOTSUPP;
}

EIF_INTEGER would_block ()
{
	return (EIF_INTEGER) EWOULDBLOCK;
}

EIF_INTEGER in_use ()
{
	return (EIF_INTEGER) EISCONN;
}

EIF_INTEGER socket_expire ()
{
	return (EIF_INTEGER) ETIMEDOUT;
}

EIF_INTEGER connect_refused ()
{
	return (EIF_INTEGER) ECONNREFUSED;
}

EIF_INTEGER no_network ()
{
	return (EIF_INTEGER) ENETUNREACH;
}


EIF_INTEGER no_option ()
{
	return (EIF_INTEGER) ENOPROTOOPT;
}

EIF_INTEGER af_unix ()
{
	return (EIF_INTEGER) AF_UNIX;
}

EIF_INTEGER af_inet()
{
	return (EIF_INTEGER) AF_INET;
}

EIF_INTEGER af_ns()
{
#ifdef AF_NS
	return (EIF_INTEGER) AF_NS;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER sock_stream()
{
	return (EIF_INTEGER) SOCK_STREAM;
}

EIF_INTEGER sock_dgrm()
{
	return (EIF_INTEGER) SOCK_DGRAM;
}

EIF_INTEGER sock_raw()
{
	return (EIF_INTEGER) SOCK_RAW;
}

EIF_INTEGER level_sol_socket ()
{
	return (EIF_INTEGER) SOL_SOCKET;
}


#ifdef SOC_XNS

EIF_INTEGER level_nsproto_raw ()
{
	return (EIF_INTEGER) NSPROTO_RAW;
}

EIF_INTEGER level_nsproto_pe ()
{
	return (EIF_INTEGER) NSPROTO_PE;
}

EIF_INTEGER level_nsproto_spp ()
{
	return (EIF_INTEGER) NSPROTO_SPP;
}

EIF_INTEGER so_headerson_input ()
{
	return (EIF_INTEGER) SO_HEADERS_ON_INPUT;
}

EIF_INTEGER so_headerson_output ()
{
	return (EIF_INTEGER) SO_HEADERS_ON_OUTPUT;
}

EIF_INTEGER so_defaultheaders ()
{
	return (EIF_INTEGER) SO_DEFAULT_HEADERS;
}

EIF_INTEGER so_lastheader ()
{
	return (EIF_INTEGER) SO_LAST_HEADER;
}

EIF_INTEGER somtu ()
{
	return (EIF_INTEGER) SO_MTU;
}

EIF_INTEGER soseqno ()
{
	return (EIF_INTEGER) SO_SEQNO;
}

EIF_INTEGER so_allpackets ()
{
	return (EIF_INTEGER) SO_ALL_PACKETS;
}

EIF_INTEGER so_nsiproute ()
{
	return (EIF_INTEGER) SO_NSIP_ROUTE;
}



#else



EIF_INTEGER level_nsproto_raw ()
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER level_nsproto_pe ()
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER level_nsproto_spp ()
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_headerson_input ()
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_headerson_output ()
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_defaultheaders ()
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_lastheader ()
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER somtu ()
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER soseqno ()
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_allpackets ()
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_nsiproute ()
{
	return (EIF_INTEGER) 0;
}



#endif




EIF_INTEGER level_iproto_tcp ()
{
	return (EIF_INTEGER) IPPROTO_TCP;
}

EIF_INTEGER level_iproto_ip ()
{
	return (EIF_INTEGER) IPPROTO_IP;
}

EIF_INTEGER ipoptions ()
{
#ifdef IP_OPTIONS
	return (EIF_INTEGER) IP_OPTIONS;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER tcpmax_seg ()
{
	return (EIF_INTEGER) TCP_MAXSEG;
}

EIF_INTEGER tcpno_delay ()
{
	return (EIF_INTEGER) TCP_NODELAY;
}

EIF_INTEGER sobroadcast ()
{
	return (EIF_INTEGER) SO_BROADCAST;
}

EIF_INTEGER sodebug ()
{
	return (EIF_INTEGER) SO_DEBUG;
}

EIF_INTEGER so_dont_route ()
{
	return (EIF_INTEGER) SO_DONTROUTE;
}

EIF_INTEGER soerror ()
{
	return (EIF_INTEGER) SO_ERROR;
}

EIF_INTEGER so_keep_alive ()
{
	return (EIF_INTEGER) SO_KEEPALIVE;
}

EIF_INTEGER solinger ()
{
	return (EIF_INTEGER) SO_LINGER;
}

EIF_INTEGER so_oob_inline ()
{
	return (EIF_INTEGER) SO_OOBINLINE;
}

EIF_INTEGER so_rcv_buf ()
{
	return (EIF_INTEGER) SO_RCVBUF;
}

EIF_INTEGER so_snd_buf ()
{
	return (EIF_INTEGER) SO_SNDBUF;
}

EIF_INTEGER so_rcv_lowat ()
{
#ifdef SO_RCVLOWAT
	return (EIF_INTEGER) SO_RCVLOWAT;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER so_snd_lowat ()
{
#ifdef SO_SNDLOWAT
	return (EIF_INTEGER) SO_SNDLOWAT;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER so_rcv_timeo ()
{
#ifdef SO_RCVTIMEO
	return (EIF_INTEGER) SO_RCVTIMEO;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER so_snd_timeo ()
{
#ifdef SO_SNDTIMEO
	return (EIF_INTEGER) SO_SNDTIMEO;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER so_reuse_addr ()
{
	return (EIF_INTEGER) SO_REUSEADDR;
}

EIF_INTEGER sotype ()
{
	return (EIF_INTEGER) SO_TYPE;
}

EIF_INTEGER so_use_loopback ()
{
#ifdef SO_USELOOPBACK
	return (EIF_INTEGER) SO_USELOOPBACK;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER c_fgetown ()
{
#ifdef F_GETOWN
	return (EIF_INTEGER) F_GETOWN;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER c_fsetown ()
{
#ifdef F_SETOWN
	return (EIF_INTEGER) F_SETOWN;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER c_fgetfl ()
{
	return (EIF_INTEGER) F_GETFL;
}

EIF_INTEGER c_fsetfl ()
{
	return (EIF_INTEGER) F_SETFL;
}

EIF_INTEGER c_fndelay ()
{
	return (EIF_INTEGER) FNDELAY;
}

EIF_INTEGER c_fasync ()
{
	return (EIF_INTEGER) FASYNC;
}

EIF_INTEGER c_einprogress ()
{
	return (EIF_INTEGER) EINPROGRESS;
}

EIF_INTEGER c_oobmsg ()
{
	return (EIF_INTEGER) MSG_OOB;
}

EIF_INTEGER c_peekmsg ()
{
	return (EIF_INTEGER) MSG_PEEK;
}

EIF_INTEGER c_msgdontroute ()
{
#ifdef MSG_DONTROUTE
	return (EIF_INTEGER) MSG_DONTROUTE;
#else
	return (EIF_INTEGER) 0;
#endif
}
