/*
	description: "Condition variable class."
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

#ifndef _RT_CONDITION_VARIABLE_HPP
#define _RT_CONDITION_VARIABLE_HPP
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_posix_threads.h"

namespace eiffel_run_time
{

/* class for waiting for conditions */
class condition_variable
{
public:
	condition_variable()
	{
			/* construct */
		if (eif_pthread_cond_create (& variable_pointer) != T_OK) {
			esys ();
		}
	}

	~condition_variable()
	{
			/* destroy */
		eif_pthread_cond_destroy (variable_pointer);
		variable_pointer = 0;
	}

private:
	condition_variable(const condition_variable&); /* not defined */
	condition_variable& operator=(const condition_variable&);	/* not defined */

public:
	void notify_one()
	{
			/* wake up one waiter */
		eif_pthread_cond_signal (variable_pointer);
	}

	void notify_all()
	{
			/* wake up all waiters */
		eif_pthread_cond_broadcast (variable_pointer);
	}

	void wait (unique_lock<mutex>& lock)
	{
			/* wait for signal */
		eif_pthread_cond_wait (variable_pointer, lock.mutex () -> mutex_pointer);
	}

	void wait_with_timeout (unique_lock<mutex>& lock, rt_uint_ptr timeout)
	{
			/* Wait for a signal with timeout. */
		eif_pthread_cond_wait_with_timeout (variable_pointer, lock.mutex () -> mutex_pointer, timeout);
	}

private:
	EIF_COND_TYPE * variable_pointer;

}; /* class condition_variable */

} /* namespace eiffel_run_time */

#endif
