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

#ifdef EIF_WIN32
#include "stream.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WIN32
extern int net_send(STREAM *cs, char *buffer, int size);
extern int net_recv(STREAM *cs, char *buf, int size, BOOL reset);
#else
extern int net_send(int cs, char *buffer, int size);
extern int net_recv(int cs, char *buf, int size);
#endif

#ifdef __cplusplus
}
#endif


#endif
