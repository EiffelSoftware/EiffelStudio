/*
	description: "Wide listening on all opened file descriptors (read)."
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

#include "eif_config.h"
#include "eif_portable.h"
#include <sys/types.h>
#include "app_proto.h"
#include "app_transfer.h"
#include "select.h"
#include "ewbio.h"
#include "listen.h"
#include "eif_logfile.h"

#include "stream.h"

rt_public void wide_listen(void)
{
	/* Listen on all the file descriptors opened for reading until the
	 * connected socket is broken.
	 */

	/* Make sure we listen on the connected socket and call the handling
	 * routine whenever data is available there.
	 */

#ifdef EIF_WINDOWS
	if (-1 == add_input(app_sp, (STREAM_FN) arqsthandle)) {
#else
	if (-1 == add_input(app_sp, arqsthandle)) {
#endif

#ifdef USE_ADD_LOG
		add_log(4, "add_input: %s (%s)", s_strerror(), s_strname());
#endif
		dexit(1);
	}

#ifdef USE_ADD_LOG
	add_log(12, "in listen");
#endif

	/* After having selected, we scan all our files to make sure none of them
	 * has been removed from the selection process. If at least one is missing,
	 * we are exiting immediately.
	 */

#ifdef EIF_WINDOWS

	while (0 <= do_select(0)) {
#ifdef USE_ADD_LOG
	add_log(12, "in while do_select");
#endif
		if (!has_input(app_sp)) {			/* Socket connection broken? */
#ifdef USE_ADD_LOG
	add_log(12, "in !has_input which is what we want");
#endif
			return;						/* Anyway, abort processing */
		}
	}
#ifdef USE_ADD_LOG
	add_log(12, "out of listen");
#endif

#else

	while (0 < do_select((struct timeval *) 0)) {
		if (!has_input(app_sp))			/* Socket connection broken? */
			return;						/* Anyway, abort processing */
	}
#endif

#ifdef USE_ADD_LOG
	add_log(12, "do_select: %s (%s)", s_strerror(), s_strname());
#endif
}
