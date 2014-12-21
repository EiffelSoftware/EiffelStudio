#include <cstddef>
#include <utility>
#include "rt_hashin.h"

namespace eiffel_run_time
{

template <class Value> class unordered_map_const_iterator
{	
public:
	unordered_map_const_iterator ()
		{
			// TODO
		}

	const Value & operator*() const
		{	
			// TODO
			return value; // (*this->_Ptr);
		}

	Value & operator*()
		{	
			// TODO
			return value; // (*this->_Ptr);
		}

	Value * operator->()
		{
			// TODO
			return & value;
			// return (&**this);
		}

	Value * operator->() const
		{
			// TODO
			return (Value *) & value;
			// return (&**this);
		}

	unordered_map_const_iterator& operator++()
		{	
			// TODO
/*
		++this->_Ptr;
*/
			return (*this);
		}

	unordered_map_const_iterator operator++(int)
		{
			// TODO
		/*
		_Myiter _Tmp = *this;
		++*this;
		return (_Tmp); */
		}

	bool operator==(const unordered_map_const_iterator & other) const
		{	
			// TODO
			return false;	
/*		return (this->_Ptr == _Right._Ptr); */
		}

	bool operator!=(const unordered_map_const_iterator & other) const
		{
			return !(*this == other);
		}

private:
			// TODO
	Value value;
};

template<class Key, class Value> class unordered_map
{

public: // Creation/destruction

	unordered_map ()
	{
			// TODO
		ht_create (&table, 10, sizeof (Value));
		ht_zero (&table);
	}

	~ unordered_map ()
	{
			// TODO: call destructors for all keys and values.
		ht_free (&table);
	}

public: // Access

	typedef Value value_type;

  	Value & operator [] (const Key & key)
  	{
  			// A pointer to a value should be returned even if it is not present
  			// to allow insertion of new elements.
  		EIF_POINTER p = ht_first (&table, (rt_uint_ptr) key);
		if (p == 0) {
			if (ht_xtend (&table)) {
				eraise("Hashtable extension failure", EN_FATAL);
			}
			p = ht_first (&table, (rt_uint_ptr) key);
		}
		return *(Value *) p;
  	}

public: // Removal

                /**
                 * The original type is std::size_t, but because return value is not used in the run-time,
                 * it is changed to void for simplicity.
                 */
	void erase (const Key& key)
	{
			// TODO: call destructor for key and value.
		ht_remove (&table, (rt_uint_ptr) key);
	}

public: // Iteration

	typedef unordered_map_const_iterator <std::pair <Key, Value> > const_iterator;
	typedef unordered_map_const_iterator <std::pair <Key, Value> > iterator;

	iterator find (const Key & key)
	{
			// TODO
		return const_iterator ();
	}

	const_iterator find (const Key & key) const
	{
			// TODO
		return const_iterator ();
	}

	const_iterator begin () const
	{
			// TODO
		return const_iterator ();
	}

	const_iterator end () const
	{
			// TODO
		return const_iterator ();
	}

public: // Modification

	std::pair<iterator, bool> insert (const std::pair <Key, Value> & val)
	{
			// TODO
		return std::pair<iterator, bool> ();
	}

private: // Storage

	struct htable table;

}; // class unordered_map

}
