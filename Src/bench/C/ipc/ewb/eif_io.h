/*

 ######     #    ######             #     ####           #    #
 #          #    #                  #    #    #          #    #
 #####      #    #####              #    #    #          ######
 #          #    #                  #    #    #   ###    #    #
 #          #    #                  #    #    #   ###    #    #
 ######     #    #      #######     #     ####    ###    #    #

*/

#ifndef _eif_io_h_
#define _eif_io_h_

#include "eif_config.h"
#include "eif_portable.h"
#include <stdio.h>     	 /* For error reports */
#include <sys/types.h>
#include "request.h"
#include "proto.h"
#include "com.h"
#include "stream.h"
#include "ewbio.h"
#include "transfer.h"

extern int rqstcnt;		/* Request count (number of requests sent) */

/* FIX THIS CRAP -- RAM */
#define APP_MSG 5
#define APP_BREAK 4
#define APP_EXCEPT 3
#define APP_EXIT 2
#define APP_JOBSTATUS 1

#endif
