/*

 #####    ####    ####    #####             #    #####   #####    ####
 #    #  #    #  #          #               #    #    #  #    #  #
 #    #  #    #   ####      #               #    #    #  #    #   ####
 #####   #  # #       #     #               #    #    #  #####        #   ###
 #   #   #   #   #    #     #               #    #    #  #   #   #    #   ###
 #    #   ### #   ####      #   #######     #    #####   #    #   ####    ###

	Internal representation filters for IPC requests.
*/

#ifndef _rqst_idrs_h_
#define _rqst_idrs_h_

#include "idrs.h"

#define MAX_STRLEN		45			/* Maximum string length for IPC */
#define MAX_FEATURE_LEN		512			/* Maximum string length for a feature name */
#define IDRF_SIZE		1024			/* A request size */

rt_public bool_t idr_Request(IDR *idrs, Request *ext);		/* Serializtion of IPC request */

#endif
