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

#ifndef _REQ_GRP_H
#define _REQ_GRP_H
#include <vector>

class processor;
class priv_queue;

/* A request group.
 *
 * Request groups model the group of locks taken and released. This
 * generally occurs when a call has separate arguments.
 */
class req_grp : public std::vector<priv_queue*>
{
public:
  /* Construct a new group.
   * @client the <processor> which will issue calls to the group.
   */
  req_grp(processor* client);

  /* Add a new processor to the group.
   * @supplier the supplier to add
   */
  void add(processor* supplier);

  /* Wait on all processors in the group.
   *
   * This call will only return when one of the group sends a notification.
   */
  void wait();

  /* Lock all processors in the group.
   */
  void lock();

  /* Unlock all processors in the group.
   */
  void unlock();
private:
  processor *client;
  bool sorted;
};

#endif
