#pragma once
#ifndef _RT_SHARED_PTR_HPP
#define _RT_SHARED_PTR_HPP

#include "eif_portable.h"
#include "eif_atomops.h"

namespace eiffel_run_time
{

template<class _Ty,
	_Ty _Val>
	struct integral_constant
	{	
	static const _Ty value = _Val;

	typedef _Ty value_type;
	typedef integral_constant<_Ty, _Val> type;

	operator value_type() const
		{	
		return (value);
		}
	};

typedef integral_constant<bool, true> true_type;
typedef integral_constant<bool, false> false_type;

template<class _Ty>
	struct is_lvalue_reference
		: false_type
	{	
	};

template<class _Ty>
	struct is_lvalue_reference<_Ty&>
		: true_type
	{	
	};

inline void _Init_atomic_counter(EIF_INTEGER_32& _Counter,
	EIF_INTEGER_32 _Value)
	{	
	_Counter = _Value;
	}

inline EIF_INTEGER_32
	_Get_atomic_count(const EIF_INTEGER_32& _Counter)
	{	
	return (_Counter);
	}

template<class _Ty>
	struct remove_reference
	{	
	typedef _Ty type;
	};

template<class _Ty> inline
	_Ty&& forward(typename remove_reference<_Ty>::type& _Arg)
	{	
	return (static_cast<_Ty&&>(_Arg));
	}

template<class _Ty> inline
	_Ty&& forward(typename remove_reference<_Ty>::type&& _Arg) throw ()
	{	
	static_assert(!is_lvalue_reference<_Ty>::value, "bad forward call");
	return (static_cast<_Ty&&>(_Arg));
	}

template<class _Ty>
	struct _Get_align
	{	
	_Ty _Elt0;
	char _Elt1;
	_Ty _Elt2;

	_Get_align();	
	};

template<class _Ty,
	size_t _Len>
	union _Align_type
	{	
	_Ty _Val;
	char _Pad[_Len];
	};

template<size_t _Len,
	size_t _Align,
	class _Ty,
	bool _Ok>
	struct _Aligned;

template<size_t _Len,
	size_t _Align,
	class _Ty>
	struct _Aligned<_Len, _Align, _Ty, true>
	{	
	typedef _Align_type<_Ty, _Len> type;
	};

typedef double max_align_t;

template<size_t _Len,
	size_t _Align>
	struct _Aligned<_Len, _Align, double, false>
	{	
 
	typedef _Align_type<max_align_t, _Len> type;
	};

template<size_t _Len,
	size_t _Align>
	struct _Aligned<_Len, _Align, int, false>
	{	
	typedef typename _Aligned<_Len, _Align, double, _Align <= (sizeof (_Get_align<double>) - 2 * sizeof (double))>::type type;
	};

template<size_t _Len,
	size_t _Align>
	struct _Aligned<_Len, _Align, short, false>
	{	
	typedef typename _Aligned<_Len, _Align, int, _Align <= (sizeof (_Get_align<int>) - 2 * sizeof (int))>::type type;
	};

template<size_t _Len,
	size_t _Align>
	struct _Aligned<_Len, _Align, char, false>
	{	
	typedef typename _Aligned<_Len, _Align, short, _Align <= (sizeof (_Get_align<short>) - 2 * sizeof (short))>::type type;
	};

template<class _Ty>
	struct alignment_of
		: integral_constant<size_t, (sizeof (_Get_align<_Ty>) - 2 * sizeof (_Ty))>
	{	
	};

template<class _Ty>
	struct alignment_of<_Ty&>
		: integral_constant<size_t, (sizeof (_Get_align<_Ty *>) - 2 * sizeof (_Ty *))>
	{	
	};

template<size_t _Len,
	size_t _Align = alignment_of<max_align_t>::value>
	struct aligned_storage
	{	
	typedef typename _Aligned<_Len, _Align, char, _Align <= (sizeof (_Get_align<char>) - 2 * sizeof (char))>::type type;
	};

class _Ref_count_base
	{	
private:
	EIF_INTEGER_32 _Uses;

private:
	virtual void _Destroy() = 0;
	virtual void _Delete_this() = 0;

protected:
	_Ref_count_base()
		{	
			_Init_atomic_counter(_Uses, 1);
		}

public:
	bool _Incref_nz()
		{	
		for (; ; )
			{	
 
			EIF_INTEGER_32 _Count = _Uses;

			if (_Count == 0)
				return (false);

			if (RTS_ACAS_I32(&_Uses, _Count + 1, _Count) == _Count)
				return (true);
 			}
		}

	unsigned int _Get_uses() const
		{	
			return (_Get_atomic_count(_Uses));
		}

	void _Incref()
		{	
			RTS_AI_I32 (&_Uses);
		}

	void _Decref()
		{	
			if (RTS_AD_I32(&_Uses) == 0) {
				_Destroy();
				_Delete_this();
			}
		}

};

template<class _Ty>
	class _Ref_count_obj
	: public _Ref_count_base
	{	
public:

	_Ref_count_obj() : _Ref_count_base() { ::new ((void *)&_Storage) _Ty(); }
	
	template<class _V0_t> _Ref_count_obj(_V0_t&& _V0) : _Ref_count_base() { ::new ((void *)&_Storage) _Ty(::std:: forward<_V0_t>(_V0)); }
	
	_Ty *_Getptr() const
		{	
		return ((_Ty *)&_Storage);
		}

private:
	virtual void _Destroy()
		{	
		_Getptr()->~_Ty();
		}

	virtual void _Delete_this()
		{	
		delete this;
		}

	typename aligned_storage<sizeof (_Ty),
		alignment_of<_Ty>::value>::type _Storage;

	};
	
template<class _Ty>
	class enable_shared_from_this;

template<class _Ty1,
	class _Ty2>
	void _Do_enable(_Ty1 *, enable_shared_from_this<_Ty2> *,
		_Ref_count_base *);

template<class _Ty>
	inline void _Enable_shared(_Ty *_Ptr, _Ref_count_base *_Refptr,
		typename _Ty::_EStype * = 0)
	{	
	if (_Ptr)
		_Do_enable(_Ptr,
			(enable_shared_from_this<typename _Ty::_EStype>*)_Ptr, _Refptr);
	}

inline void _Enable_shared(const volatile void *, const volatile void *)
	{	
	}

template<class _Ty>
	class _Ptr_base
	{	
public:
	typedef _Ptr_base<_Ty> _Myt;

	_Ptr_base()
		: _Ptr(0), _Rep(0)
		{	
		}

/*
	_Ptr_base(_Myt&& _Right)
		: _Ptr(0), _Rep(0)
		{	
		_Assign_rv(::std:: forward<_Myt>(_Right));
		}
*/

	template<class _Ty2>
		_Ptr_base(_Ptr_base<_Ty2>&& _Right)
		: _Ptr(_Right._Ptr), _Rep(_Right._Rep)
		{	
		_Right._Ptr = 0;
		_Right._Rep = 0;
		}

/*
	void _Assign_rv(_Myt&& _Right)
		{	
		if (this != &_Right)
			_Swap(_Right);
		}

	void _Swap(_Ptr_base& _Right)
		{	
		::std:: swap(_Rep, _Right._Rep);
		::std:: swap(_Ptr, _Right._Ptr);
		}
*/

	_Ty *_Get() const
		{	
		return (_Ptr);
		}

	void _Decref()
		{	
		if (_Rep != 0)
			_Rep->_Decref();
		}

	void _Reset()
		{	
		_Reset(0, 0);
		}

	template<class _Ty2>
		void _Reset(const _Ptr_base<_Ty2>& _Other)
		{	
		_Reset(_Other._Ptr, _Other._Rep);
		}

	template<class _Ty2>
		void _Reset(const _Ptr_base<_Ty2>& _Other, bool _Throw)
		{	
		_Reset(_Other._Ptr, _Other._Rep, _Throw);
		}

	template<class _Ty2>
		void _Reset(_Ty *_Ptr, const _Ptr_base<_Ty2>& _Other)
		{	
		_Reset(_Ptr, _Other._Rep);
		}

	void _Reset(_Ty *_Other_ptr, _Ref_count_base *_Other_rep)
		{	
		if (_Other_rep)
			_Other_rep->_Incref();
		_Reset0(_Other_ptr, _Other_rep);
		}

	void _Reset(_Ty *_Other_ptr, _Ref_count_base *_Other_rep, bool _Throw)
		{	
			
			
		if (_Other_rep && _Other_rep->_Incref_nz())
			_Reset0(_Other_ptr, _Other_rep);
		else if (_Throw)
			throw bad_weak_ptr(0);
		}

	void _Reset0(_Ty *_Other_ptr, _Ref_count_base *_Other_rep)
		{	
		if (_Rep != 0)
			_Rep->_Decref();
		_Rep = _Other_rep;
		_Ptr = _Other_ptr;
		}

private:
	_Ty *_Ptr;
	_Ref_count_base *_Rep;
	template<class _Ty0>
		friend class _Ptr_base;
	};

	
template<class _Ty>
	class shared_ptr
		: public _Ptr_base<_Ty>
	{	
public:
	typedef shared_ptr<_Ty> _Myt;
	typedef _Ptr_base<_Ty> _Mybase;

	shared_ptr() throw ()
		{	
		}

/*
	template<class _Ux>
		explicit shared_ptr(_Ux *_Px)
		{	
		_Resetp(_Px);
		}
*/

	shared_ptr(const _Myt& _Other) throw ()
		{	
		this->_Reset(_Other);
		}

	shared_ptr(_Myt&& _Right) throw ()
		: _Mybase(forward<_Myt>(_Right))
		{	
		}

	~shared_ptr() throw ()
		{	
		this->_Decref();
		}

/*
	void swap(_Myt& _Other) throw ()
		{	
		this->_Swap(_Other);
		}
*/

	_Ty *get() const throw ()
		{	
		return (this->_Get());
		}

/*
	typename add_reference<_Ty>::type operator*() const throw ()
		{	
		return (*this->_Get());
		}
*/

	_Ty *operator->() const throw ()
		{	
		return (this->_Get());
		}

private:
/*
	template<class _Ux>
		void _Resetp(_Ux *_Px)
		{	
		try {	
		_Resetp0(_Px, new _Ref_count<_Ux>(_Px));
		} catch (...) {	
		delete _Px;
		throw;
		}
		}

	template<class _Ux,
		class _Dx>
		void _Resetp(_Ux *_Px, _Dx _Dt)
		{	
		try {	
		_Resetp0(_Px, new _Ref_count_del<_Ux, _Dx>(_Px, _Dt));
		} catch (...) {	
		_Dt(_Px);
		throw;
		}
		}


	template<class _Ux,
		class _Dx,
		class _Alloc>
		void _Resetp(_Ux *_Px, _Dx _Dt, _Alloc _Ax)
		{	
		typedef _Ref_count_del_alloc<_Ux, _Dx, _Alloc> _Refd;
		typename _Alloc::template rebind<_Refd>::other _Al = _Ax;

		try {	
		_Refd *_Ptr = _Al.allocate(1);
		::new (_Ptr) _Refd(_Px, _Dt, _Al);
		_Resetp0(_Px, _Ptr);
		} catch (...) {	
		_Dt(_Px);
		throw;
		}
		}
*/

public:
	template<class _Ux>
		void _Resetp0(_Ux *_Px, _Ref_count_base *_Rx)
		{	
		this->_Reset0(_Px, _Rx);
		_Enable_shared(_Px, _Rx);
		}
	};

template<class _Ty>
	void swap(shared_ptr<_Ty>& _Left,
		shared_ptr<_Ty>& _Right) throw ()
	{	
	_Left.swap(_Right);
	}

template<class _Ty  > inline shared_ptr<_Ty> make_shared() {
	_Ref_count_obj<_Ty> *_Rx = new _Ref_count_obj<_Ty>();
	shared_ptr<_Ty> _Ret;
	_Ret._Resetp0(_Rx->_Getptr(), _Rx);
	return (_Ret);
	}
	
template<class _Ty , class _V0_t> inline shared_ptr<_Ty> make_shared(_V0_t&& _V0) {
	_Ref_count_obj<_Ty> *_Rx = new _Ref_count_obj<_Ty>(forward<_V0_t>(_V0));
	shared_ptr<_Ty> _Ret;
	_Ret._Resetp0(_Rx->_Getptr(), _Rx);
	return (_Ret);
	}

};

#endif /* _RT_SHARED_PTR_HPP */
