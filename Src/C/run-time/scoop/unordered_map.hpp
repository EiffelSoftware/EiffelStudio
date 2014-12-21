#include <cstddef>
#include <utility>
#include "rt_hashin.h"

namespace eiffel_run_time
{

template <class Value> class unordered_map_const_iterator
{	
public:
	unordered_map_const_iterator (struct htable t, size_t position)
		{
			table = t;
			pos = position;
		}

	const Value & operator*() const
		{	
			return *(const Value *) (((char *) table.h_values) + pos * table.h_sval);
		}

	Value & operator*()
		{	
			return *(Value *) (((char *) table.h_values) + pos * table.h_sval);
		}

	Value * operator->()
		{
			return (Value *) (((char *) table.h_values) + pos * table.h_sval);
		}

	Value * operator->() const
		{
			return (Value *) (((char *) table.h_values) + pos * table.h_sval);
		}

	unordered_map_const_iterator& operator++()
		{
			size_t hsize = table.h_size;
			rt_uint_ptr * hkeys = table.h_keys;

				// Skip items with zero keys.
			do {
				++pos;
			}
			while (hkeys [pos] == 0 || pos < hsize);
			return *this;
		}

	unordered_map_const_iterator operator++(int)
		{
			unordered_map_const_iterator result = *this;
			++ *this;
			return result;
		}

	bool operator==(const unordered_map_const_iterator & other) const
		{
			return pos == other.pos;
		}

	bool operator!=(const unordered_map_const_iterator & other) const
		{
			return !(*this == other);
		}

private: // Storage

	struct htable table;
	size_t pos;
};

template<class Key, class Value> class unordered_map
{

public: // Creation/destruction

	unordered_map ()
	{
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
		return const_iterator (table, 0);
	}

	const_iterator find (const Key & key) const
	{
			// TODO
		return const_iterator (table, 0);
	}

	const_iterator begin () const
	{
		return const_iterator (table, 0);
	}

	const_iterator end () const
	{
		return const_iterator (table, table.h_size);
	}

public: // Modification

	std::pair<iterator, bool> insert (const std::pair <Key, Value> & val)
	{
			// TODO
		return std::pair<iterator, bool> (const_iterator (table, 0), false);
	}

private: // Storage

	struct htable table;

}; // class unordered_map

}
