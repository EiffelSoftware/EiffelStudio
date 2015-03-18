/*
	description:	"Declarations for the message channel struct."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2010-2012, Eiffel Software.",
				"Copyright (c) 2014 Scott West <scott.gregory.west@gmail.com>"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

#ifndef _rt_message_channel_h_
#define _rt_message_channel_h_

#include "spsc.hpp"
#include "rt_message.h"

struct rt_message_channel {
	spsc<rt_message> impl;
	int spin;
};

rt_shared rt_inline void rt_message_channel_init (struct rt_message_channel* self, int default_spin)
{
	self->spin = default_spin;
}

rt_shared void rt_message_channel_deinit (struct rt_message_channel* self)
{
}

/* Declarations */
rt_shared void rt_message_channel_send (struct rt_message_channel* self, struct rt_message* message);
rt_shared void rt_message_channel_receive (struct rt_message_channel* self, struct rt_message* message);
rt_shared void rt_message_channel_mark (struct rt_message_channel* self, MARKER marking);


#endif /* _rt_message_channel_h_ */
