#ifndef _RT_UNIQUE_LOCK_HPP
#define _RT_UNIQUE_LOCK_HPP

namespace eiffel_run_time
{

template <class mutex_type>
class unique_lock
{
public:
	explicit unique_lock (mutex_type& m):
			mutex_pointer (&m), is_owned (false)
		{	// construct and lock
			mutex_pointer -> lock();
			is_owned = true;
		}

	~unique_lock ()
		{	// clean up
			if (is_owned)
				mutex_pointer -> unlock();
		}

	unique_lock (const unique_lock &);	// not defined
	unique_lock & operator = (const unique_lock &);	// not defined

	mutex_type * mutex ()
		{	// return pointer to managed mutex
			return mutex_pointer;
		}
private:
	mutex_type * mutex_pointer;
	bool is_owned;
}; // class unique_lock

} // namespace eiffel_run_time

#endif
