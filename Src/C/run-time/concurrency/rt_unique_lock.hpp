/*
	description: "Unique lock class."
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

#ifndef _RT_UNIQUE_LOCK_HPP
#define _RT_UNIQUE_LOCK_HPP
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif


namespace eiffel_run_time
{

template <class mutex_type>
class unique_lock
{
public:
	explicit unique_lock (mutex_type& m):
			mutex_pointer (&m), is_owned (false)
	{
			/* construct and lock */
		mutex_pointer -> lock();
		is_owned = true;
	}

	~unique_lock ()
	{
			/* clean up */
		if (is_owned) {
			mutex_pointer -> unlock();
		}
	}

	unique_lock (const unique_lock &);	/* not defined */
	unique_lock & operator = (const unique_lock &);	/* not defined */

	mutex_type * mutex ()
	{
			/* return pointer to managed mutex */
		return mutex_pointer;
	}

private:
	mutex_type * mutex_pointer;
	bool is_owned;

}; /* class unique_lock */

} /* namespace eiffel_run_time */

#endif
