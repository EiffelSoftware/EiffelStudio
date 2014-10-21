#pragma once
#ifndef _RT_MUTEX_HPP
#define _RT_MUTEX_HPP

#include "eif_error.h"
#include "eif_posix_threads.h"

namespace eiffel_run_time
{

class mutex
{
public:
	mutex ()
		{
			if (eif_pthread_mutex_create (&mutex_pointer) != T_OK)
			{
				esys ();
			}
		}

	~ mutex ()
		{	// clean up
			eif_pthread_mutex_destroy (mutex_pointer);
			mutex_pointer = 0;
		}

private:
	mutex (const mutex &);	// not defined
	mutex & operator = (const mutex &);	// not defined

public:
	void lock()
		{	// lock the mutex
			eif_pthread_mutex_lock (mutex_pointer);
		}

	bool try_lock()
		{	// try to lock the mutex
			return eif_pthread_mutex_trylock (mutex_pointer) == T_OK;
		}

	void unlock()
		{	// unlock the mutex
			eif_pthread_mutex_unlock (mutex_pointer);
		}

private:
	friend class condition_variable;
	EIF_MUTEX_TYPE * mutex_pointer;
}; // class mutex

} // namespace eiffel_run_time

#endif /* _RT_MUTEX_HPP */
