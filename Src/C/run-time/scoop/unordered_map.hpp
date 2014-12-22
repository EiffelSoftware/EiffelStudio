#include <cstddef>
#include <utility>
#include "rt_hashin.h"
#include "eif_except.h"

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
			while (hkeys [pos] == 0 && pos < hsize);
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
  			// A pointer to a value should be returned in any case.
  			// If there was no element, a new one is returned created with a default constructor.
		size_t pos = ht_find (&table, (rt_uint_ptr) key);
		if (pos >= table.h_size)
		{
				// No element is found. Insert a new one.
			Value v;
			ht_force (&table, (rt_uint_ptr) key, (EIF_POINTER) &v);
			pos = ht_find (&table, (rt_uint_ptr) key);
		}
		return *(Value *) (((char *) table.h_values) + pos * table.h_sval);
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
		return iterator (table, ht_find (&table, (rt_uint_ptr) key));
	}

	const_iterator find (const Key & key) const
	{
		return const_iterator (table, ht_find (&table, (rt_uint_ptr) key));
	}

	const_iterator begin () const
	{
			// Go to a position -1 and look for the one that has a key.
		const_iterator result = const_iterator (table, ~ (size_t) 0);
		++ result;
		return result;
	}

	const_iterator end () const
	{
		return const_iterator (table, table.h_size);
	}

public: // Modification

	std::pair<iterator, bool> insert (const std::pair <Key, Value> & val)
	{
		bool is_inserted = false;
		iterator it = find (val.first);
		if (it == end ())
		{
				// There is no element with the given key.
				// Insert it.
			ht_force (&table, (rt_uint_ptr) val.first, (EIF_POINTER) &val.second);
				// Recompute iterator.
			it = find (val.first);
			is_inserted = true;
		}
		return std::pair<iterator, bool> (it, is_inserted);
	}

private: // Storage

	struct htable table;

}; // class unordered_map

}
