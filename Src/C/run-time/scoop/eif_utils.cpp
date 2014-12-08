/*
	description: "??"
	date:		"$Date$"
	revision:	"$Revision: 96244 $"
	copyright:	"Copyright (c) 1985-2014, Eiffel Software.", "Copyright (c) 2014 Scott West <scott.gregory.west@gmail.com>"
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
doc:<file name="eif_utils.cpp" header="eif_utils.hpp" version="$Id$" summary="???">
*/

#include "rt_assert.h"
#include "eif_utils.hpp"

static void mark_ref (marker_t mark, EIF_REFERENCE *ref)
{
	REQUIRE("ref not null", ref);
	*ref = mark (ref);
}

void mark_call_data(marker_t mark, call_data* call)
{
	size_t i;

	REQUIRE("Cannot mark NULL calls", call);

	mark_ref (mark, &call->target);

	for (i = 0; i < call->count; i++) {
		if (call->argument[i].type == SK_REF) {
			mark_ref (mark, &call->argument[i].it_r);
		}
	}
}

/*
doc:</file>
*/
