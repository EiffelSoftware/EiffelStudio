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

	Value & operator*() const
		{	
			return **(Value **) (((char *) table.h_values) + pos * table.h_sval);
		}

	Value & operator*()
		{	
			return **(Value **) (((char *) table.h_values) + pos * table.h_sval);
		}

	Value * operator->()
		{
			return &(operator*());
		}

	Value * operator->() const
		{
			return &(operator*());
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

	typedef std::pair <Key, Value> record_type;

public: // Creation/destruction

	unordered_map ()
	{
		table = new struct htable ();
		ht_create (table, 10, sizeof (record_type *));
		ref_count = new size_t (1);
	}

	unordered_map (const unordered_map <Key, Value> & other)
		// Copy constructor.
	{
		table = other.table;
		ref_count = other.ref_count;
		++ *ref_count;
	}

	~ unordered_map ()
	{
		-- *ref_count;

		if (*ref_count == 0)
		{
			size_t hsize = table -> h_size;
			rt_uint_ptr * hkeys = table -> h_keys;

				// Delete all values.
			for (size_t pos = 0; pos < hsize; ++ pos)
			{
					// Skip items with zero keys.
				if (hkeys [pos] != 0)
					delete *(record_type **) (((char *) table -> h_values) + pos * table -> h_sval);
			}
			ht_release (table);
			delete table;
			delete ref_count;
		}
	}

public: // Access

	typedef Value value_type;

  	Value & operator [] (const Key & key)
  	{
  			// A pointer to a value should be returned in any case.
  			// If there was no element, a new one is returned created with a default constructor.
		size_t pos = ht_find (table, (rt_uint_ptr) key);
		if (pos >= table -> h_size)
		{
				// No element is found. Insert a new one.
			record_type * v = new record_type (key, Value ());
			ht_force (table, (rt_uint_ptr) key, (EIF_POINTER) &v);
			pos = ht_find (table, (rt_uint_ptr) key);
		}
		return (*(record_type **) (((char *) table -> h_values) + pos * table -> h_sval)) -> second;
  	}

public: // Removal

                /**
                 * The original type is std::size_t, but because return value is not used in the run-time,
                 * it is changed to void for simplicity.
                 */
	void erase (const Key& key)
	{
			// Delete value.
		size_t pos = ht_find (table, (rt_uint_ptr) key);
		if (pos < table -> h_size)
		{
			delete *(record_type **) (((char *) table -> h_values) + pos * table -> h_sval);
		}
		ht_remove (table, (rt_uint_ptr) key);
	}

public: // Iteration

	typedef unordered_map_const_iterator <std::pair <Key, Value> > const_iterator;
	typedef unordered_map_const_iterator <std::pair <Key, Value> > iterator;

	iterator find (const Key & key)
	{
		return iterator (*table, ht_find (table, (rt_uint_ptr) key));
	}

	const_iterator find (const Key & key) const
	{
		return const_iterator (*table, ht_find (table, (rt_uint_ptr) key));
	}

	const_iterator begin () const
	{
			// Go to a position -1 and look for the one that has a key.
		const_iterator result = const_iterator (*table, ~ (size_t) 0);
		++ result;
		return result;
	}

	const_iterator end () const
	{
		return const_iterator (*table, table -> h_size);
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
			record_type * v = new record_type (val);
			ht_force (table, (rt_uint_ptr) val.first, (EIF_POINTER) &v);
				// Recompute iterator.
			it = find (val.first);
			is_inserted = true;
		}
		return std::pair<iterator, bool> (it, is_inserted);
	}

private: // Storage

	struct htable * table;
	size_t *ref_count;

}; // class unordered_map

}
