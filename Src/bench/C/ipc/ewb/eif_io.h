/*
	description: "Declarations."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
