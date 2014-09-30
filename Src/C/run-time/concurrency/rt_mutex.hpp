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
			if (eif_pthread_cs_create (&section_pointer, 0) != T_OK)
			{
				esys ();
			}
		}

	~ mutex ()
		{	// clean up
			eif_pthread_cs_destroy (section_pointer);
			section_pointer = 0;
		}

private:
	mutex (const mutex &);	// not defined
	mutex & operator = (const mutex &);	// not defined

public:
	void lock()
		{	// lock the mutex
			eif_pthread_cs_lock (section_pointer);
		}

	bool try_lock()
		{	// try to lock the mutex
			return eif_pthread_cs_trylock (section_pointer) == T_OK;
		}

	void unlock()
		{	// unlock the mutex
			eif_pthread_cs_unlock (section_pointer);
		}

private:
	EIF_CS_TYPE * section_pointer;
}; // class mutex

} // namespace eiffel_run_time

#endif /* _RT_MUTEX_HPP */
