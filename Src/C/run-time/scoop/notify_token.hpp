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

#ifndef _NOTIFY_TOKEN_H
#define _NOTIFY_TOKEN_H

#include "qoq.hpp"
#include <memory>

class processor;

/* A notification mechanism.
 *
 * This is used to implement the wait-condition mechanism.
 * In particular it allows multiple suppliers to notify a single
 * client that they are ready.
 */
class notify_token
{
public:
	/* Construct a notify token.
	 * @client the owner of the token
	 */
	notify_token(processor *client);

	/* Copy constructor.
	 * @other the token to copy.
	 */
	notify_token(const notify_token& other);

	/* Register with a new supplier.
	 * @supplier the new supplier to register with.
	 *
	 * This token is added to the notification list of the supplier.
	 */
     /*void register_supplier (processor *supplier);*/

	/* Wait for a signal from any supplier.
	 */
	void wait();

	/* Wake the supplier assocated with this token
	 */
	void notify(processor *client);

	/* The processor for which this token is <processor::my_token>.
	 *
	 * @return the client associated with this token.
	 */
	processor *client() const;

private:
	processor *client_;
	shared_ptr_type <mpscq<processor*> > token_queue_;
};

#endif
