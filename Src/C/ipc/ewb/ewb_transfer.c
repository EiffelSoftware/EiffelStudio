/*
	description: "Transfer routines for ewb."
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
#include "eif_logfile.h"
#include "shared.h"
#include "com.h"
#include "stream.h"
#include "ewb_transfer.h"
#include "ewb_proto.h"

rt_public STREAM *ewb_sp;				/* Stream used for communications */

rt_public void ewb_tpipe(STREAM *stream) {
    /* Initialize the file descriptor to be used in data exchanges with the
     * remote process. This enables us to omit this parameter whenever an I/O
     * with the remote process has to be made.
     */

    if (ewb_sp != NULL) {
        unregister_packet_functions (ewb_sp);
    }
    if (stream != NULL) {
        ewb_sp = stream;
        register_packet_functions (ewb_sp, &ewb_send_packet, &ewb_recv_packet);
    } else {
        ewb_sp = (STREAM *) 0;
    };

#ifdef DEBUG
#ifdef USE_ADD_LOG
    if (ewb_sp != NULL) {
        add_log(20, "stream set up as (rd = #%d, wr = #%d)",
            readfd(ewb_sp), writefd(ewb_sp));
    }
#endif
#endif
}

rt_public char *ewb_tread(int *size)
          		/* Filled in with size of read string */
{
	/* Read bytes from the "pipe" and put them into a new allocated buffer.
	 * Returns the address of that buffer or a null pointer in case of errors.
	 */
	return tread(ewb_sp, size);
}

rt_public int ewb_twrite(void *buffer, size_t size)
{
	/* Write 'size' bytes held in 'buffer' into the "pipe". Return the number
	 * of bytes effectively written or -1 if an error occurred.
	 */

	return twrite(ewb_sp, buffer, size);
}

