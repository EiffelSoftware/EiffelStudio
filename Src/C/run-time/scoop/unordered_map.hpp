#include <cstddef>
#include <utility>

namespace eiffel_run_time
{

template <class Value> class unordered_map_const_iterator
{	
public:
	unordered_map_const_iterator ()
		{	
		}

	const Value & operator*() const
		{	
			return value; // (*this->_Ptr);
		}

	Value & operator*()
		{	
			return value; // (*this->_Ptr);
		}

	Value * operator->()
		{
			return & value;
			// return (&**this);
		}

	Value * operator->() const
		{
			return (Value *) & value;
			// return (&**this);
		}

	unordered_map_const_iterator& operator++()
		{	
/*
		++this->_Ptr;
*/
			return (*this);
		}

	unordered_map_const_iterator operator++(int)
		{
		/*
		_Myiter _Tmp = *this;
		++*this;
		return (_Tmp); */
		}

	bool operator==(const unordered_map_const_iterator & other) const
		{	
			return false;	
/*		return (this->_Ptr == _Right._Ptr); */
		}

	bool operator!=(const unordered_map_const_iterator & other) const
		{
			return !(*this == other);
		}

private:
	Value value;
};

template<class Key, class Value> class unordered_map
{

public: // Creation/destruction

	unordered_map ()
	{
	}

	~ unordered_map ()
	{
	}

public: // Access

	typedef Value value_type;

  	Value & operator [] (const Key & key)
  	{
  		return value;
  	}

public: // Removal

	std::size_t erase(const Key& key)
	{
		return 0;
	}

public: // Iteration

	typedef unordered_map_const_iterator <std::pair <Key, Value> > const_iterator;
	typedef unordered_map_const_iterator <std::pair <Key, Value> > iterator;

	iterator find (const Key & key)
	{
		return const_iterator ();
	}

	const_iterator find (const Key & key) const
	{
		return const_iterator ();
	}

	const_iterator begin () const
	{
		return const_iterator ();
	}

	const_iterator end () const
	{
		return const_iterator ();
	}

public: // Modification

	std::pair<iterator, bool> insert (const std::pair <Key, Value> & val)
	{
		return std::pair<iterator, bool> ();
	}

private: // TODO: remove

	value_type value;

}; // class unordered_map

}
