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
#define IDRF_SIZE		256			/* A request size */

public bool_t idr_Request();		/* Serializtion of IPC request */

#endif
