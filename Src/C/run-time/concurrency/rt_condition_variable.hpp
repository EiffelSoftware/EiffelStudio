#ifndef _RT_CONDITION_VARIABLE_HPP
#define _RT_CONDITION_VARIABLE_HPP

#include "eif_posix_threads.h"

namespace eiffel_run_time
{

class condition_variable
{	// class for waiting for conditions
public:
	condition_variable()
		{	// construct
			if (eif_pthread_cond_create (& variable_pointer) != T_OK)
			{
				esys ();
			}
		}

	~condition_variable()
		{	// destroy
			eif_pthread_cond_destroy (variable_pointer);
			variable_pointer = 0;
		}

private:
	condition_variable(const condition_variable&);  // not defined
	condition_variable& operator=(const condition_variable&);	// not defined
public:
	void notify_one()
		{	// wake up one waiter
			eif_pthread_cond_signal (variable_pointer);
		}

	void notify_all()
		{	// wake up all waiters
			eif_pthread_cond_broadcast (variable_pointer);
		}

	void wait (unique_lock<mutex>& lock)
		{	// wait for signal
			eif_pthread_cond_wait (variable_pointer, lock.mutex () -> mutex_pointer);
		}

private:
	EIF_COND_TYPE * variable_pointer;

}; // class condition_variable

} // namespace eiffel_run_time

#endif
