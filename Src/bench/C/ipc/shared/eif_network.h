/*

 #    #  ######   #####  #    #   ####   #####   #    #          #    #
 ##   #  #          #    #    #  #    #  #    #  #   #           #    #
 # #  #  #####      #    #    #  #    #  #    #  ####            ######
 #  # #  #          #    # ## #  #    #  #####   #  #     ###    #    #
 #   ##  #          #    ##  ##  #    #  #   #   #   #    ###    #    #
 #    #  ######     #    #    #   ####   #    #  #    #   ###    #    #

 Header for network routines

*/

#ifndef _eif_network_h_
#define _eif_network_h_

#include "eif_portable.h"

#ifdef EIF_WINDOWS
#include "stream.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WINDOWS
extern int net_send(STREAM *cs, char *buffer, size_t size);
extern int net_recv(STREAM *cs, char *buf, size_t size, BOOL reset);
#else
extern int net_send(int cs, char *buffer, size_t size);
extern int net_recv(int cs, char *buf, size_t size);
#endif

#ifdef __cplusplus
}
#endif


#endif
