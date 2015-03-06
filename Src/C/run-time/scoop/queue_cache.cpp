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
doc:<file name="queue_cache.cpp" header="queue_cache.hpp" version="$Id$" summary="SCOOP support.">
 */

#include "rt_msc_ver_mismatch.h"
#include "queue_cache.hpp"
#include "processor.hpp"

priv_queue* queue_cache::operator[] (processor * const supplier)
{
	RT_UNORDERED_MAP <processor*, queue_stack>::iterator found_it = queue_map.find (supplier);
	priv_queue *pq;
	if (found_it != queue_map.end()) {
		queue_stack &stack = found_it->second;
		if (stack.empty()) {
			stack.EMPLACE_BACK (supplier->new_priv_queue());
		}
		pq = stack.back();
	} else {
		const std::pair <RT_UNORDERED_MAP <processor*, queue_stack>::iterator, bool> &res =
				queue_map.EMPLACE (std::pair <processor*, queue_stack> (supplier, queue_stack ()));
		queue_stack &stack = res.first->second;
		stack.EMPLACE_BACK (supplier->new_priv_queue());
		pq = stack.back();
	}

	return pq;
}

/*
doc:</file>
*/
