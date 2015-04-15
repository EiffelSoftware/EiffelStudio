/*
	description:	"SCOOP support."
	date:		"$Date$"
	revision:	"$Revision: 96304 $"
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

/*
doc:<file name="notify_token.cpp" header="notify_token.hpp" version="$Id$" summary="SCOOP support.">
*/
#include "rt_msc_ver_mismatch.h"
#if 0
#include "notify_token.hpp"

notify_token::notify_token(processor *client) :
	client_(client),
	token_queue_(make_shared_function <mpscq <processor*> > ())
{
}

notify_token::notify_token(const notify_token& other) :
	client_(other.client_),
	token_queue_(other.token_queue_)
{
}

processor* notify_token::client() const
{
	return client_;
}

void notify_token::wait()
{
	processor* dummy;
	token_queue_->pop (dummy);
}

void notify_token::notify(processor *client)
{
	token_queue_->push (client);
}
#endif
