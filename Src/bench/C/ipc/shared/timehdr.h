/*

  #####     #    #    #  ######  #    #  #####   #####           #    #
    #       #    ##  ##  #       #    #  #    #  #    #          #    #
    #       #    # ## #  #####   ######  #    #  #    #          ######
    #       #    #    #  #       #    #  #    #  #####    ###    #    #
    #       #    #    #  #       #    #  #    #  #   #    ###    #    #
    #       #    #    #  ######  #    #  #####   #    #   ###    #    #

	Configured time-related header inclusions.
*/

#ifndef _timehdr_h_
#define _timehdr_h_

#include "config.h"

#ifdef I_TIME
# include <time.h>
#endif

#ifdef I_SYS_TIME
# include <sys/time.h>
#endif

#ifdef I_SYS_TIME_KERNEL
# define KERNEL
# include <sys/time.h>
# undef KERNEL
#endif

#ifdef I_TMVAL_SYS_SELECT
#include <sys/select.h>
#endif

#endif

