#ifndef _RT_ATOMIC_HPP
#define _RT_ATOMIC_HPP

#include "eif_portable.h"
#include "eif_atomops.h"

// Microsoft Visual C++ does not support "noexcept" modifier.
#ifndef RT_NOEXCEPT
#	if defined NOEXCEPT
#		define RT_NOEXCEPT NOEXCEPT
#	elif defined _NOEXCEPT
#		define RT_NOEXCEPT _NOEXCEPT
#	elif defined _MSC_VER
#		define RT_NOEXCEPT
#	else
#		define RT_NOEXCEPT noexcept
#	endif
#endif

// Microsoft Visual C++ does not support "default", "delete" and "constexpr" modifiers.
#ifdef _MSC_VER
#	define RT_CONSTEXPR
#	define RT_DEFAULT {}
#	define RT_DELETE
#else
#	define RT_CONSTEXPR constexpr
#	define RT_DEFAULT = default
#	define RT_DELETE = delete
#endif


namespace eiffel_run_time
{

typedef enum memory_order {
	memory_order_relaxed,
	memory_order_consume,
	memory_order_acquire,
	memory_order_release,
	memory_order_acq_rel,
	memory_order_seq_cst,
} memory_order;

class atomic_int
{

public:

// Non-default constructors prevent aggregate initialization.
//
//	RT_CONSTEXPR atomic_int (EIF_INTEGER_32 v) RT_NOEXCEPT : value (v)
//		{
//		}
//
//	atomic_int() RT_NOEXCEPT: value () RT_DEFAULT;
//
//	~atomic_int() RT_NOEXCEPT RT_DEFAULT;

	EIF_INTEGER_32 operator++ (int)
		{
			// post-increment
			return RTS_AI_I32(&value) - 1;
		}

	EIF_INTEGER_32 operator-- ()
		{
			// pre-decrement
			return RTS_AD_I32(&value);
		}

public: // Should not be accessed directly, but has to be public to allow aggregate initializers under MSC.

	EIF_INTEGER_32 value;

private: // Not defined

// Non-default constructors prevent aggregate initialization.
//
//	atomic_int(const atomic_int&) RT_DELETE;

	atomic_int& operator=(const atomic_int&) RT_DELETE;
// MSC complains there are too many assignment operators.
//	atomic_int& operator=(const atomic_int&) volatile RT_DELETE;

	operator EIF_INTEGER_32() const RT_NOEXCEPT RT_DELETE;
	operator EIF_INTEGER_32() const volatile RT_NOEXCEPT RT_DELETE;

}; // class atomic_int

class atomic_bool
{

public:
	atomic_bool () RT_NOEXCEPT :  value (false)
		{
		}

	atomic_bool (bool v) RT_NOEXCEPT : value (v)
		{
		}

	operator bool ()
		{	// current value
			return (value == (EIF_INTEGER_32) true);
		}

	bool operator= (bool v)
		{	// assign from v
			RTS_AS_I32(&value, (EIF_INTEGER_32) v);
			return v;
		}
	bool compare_exchange_strong (bool& e, bool v)
		{
			EIF_INTEGER_32 prev = RTS_ACAS_I32(&value, (EIF_INTEGER_32) v, (EIF_INTEGER_32) e);
			if (prev == (EIF_INTEGER_32) e) {
				return true;
			}
			else {
				e = (prev == (EIF_INTEGER_32) true);
			}
			return false;
		}

	bool exchange(bool v, memory_order o = memory_order_seq_cst)
		{
			EIF_INTEGER_32 prev = RTS_AS_I32(&value, (EIF_INTEGER_32) v);
			return (prev == (EIF_INTEGER_32) true);
		}

private:
	EIF_INTEGER_32 value;

}; // class atomic_bool

class atomic_size_t
{

public:
	atomic_size_t () RT_NOEXCEPT: value (0)
		{
		}

	operator size_t () const RT_NOEXCEPT
		{	// current value
			return (size_t) value;
		}

	size_t load (memory_order Order = memory_order_seq_cst)
		{
			return RTS_AA_I32 (&value, 0);
		}

	void store (size_t v, memory_order o = memory_order_seq_cst)
		{
			RTS_AS_I32 (&value, (EIF_INTEGER_32) v);
		}

	size_t operator= (size_t v)
		{	// assign from v
			RTS_AS_I32 (&value, (EIF_INTEGER_32) v);
			return v;
		}

	size_t operator++ (int)
		{
			// post-increment
			return RTS_AI_I32 (&value) - 1;
		}

	size_t operator-- (int)
		{
			// post-decrement
			return RTS_AD_I32 (&value) + 1;
		}

	bool compare_exchange_weak (size_t& e, size_t v, memory_order o = memory_order_seq_cst)
		{
			EIF_INTEGER_32 prev = RTS_ACAS_I32 (&value, (EIF_INTEGER_32) v, (EIF_INTEGER_32) e);
			if (prev == (EIF_INTEGER_32) e) {
				return true;
			}
			else {
				e = (prev == (EIF_INTEGER_32) true);
			}
			return false;
		}

private:
	volatile EIF_INTEGER_32 value;

}; // class atomic_size_t


template <class ptr_type>
class atomic {

public:
	atomic () RT_NOEXCEPT: value (0)
		{
		}

	atomic (ptr_type v) RT_NOEXCEPT: value (v)
		{
		}

	atomic (const atomic& v) RT_NOEXCEPT: value (v.value)
		{
		}

	operator ptr_type () const RT_NOEXCEPT
		{	// current value
			return value;
		}

	operator ptr_type () const volatile RT_NOEXCEPT
		{	// current value
			return value;
		}

	ptr_type operator= (ptr_type v)
		{	// assign from v
			RTS_AS_PTR (&value, v);
			return v;
		}

	ptr_type operator= (ptr_type v) volatile
		{	// assign from v
			RTS_AS_PTR ((void * volatile *) &value, v);
			return v;
		}

	ptr_type exchange(ptr_type v, memory_order o = memory_order_seq_cst)
		{
			return (ptr_type) RTS_AS_PTR (&value, v);
		}

	ptr_type exchange(ptr_type v, memory_order o = memory_order_seq_cst) volatile
		{
			return (ptr_type) RTS_AS_PTR ((void * volatile *) &value, v);
		}

private:
	ptr_type value;

}; // class atomic


} // namespace eiffel_run_time

#endif
