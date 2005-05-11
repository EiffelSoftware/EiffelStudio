indexing
	description: "[
		Abstract equivalent of HASH_TABLE [NATURAL_32, ANY], since this type cannot be written
		as ANY does not inherit from HASHABLE
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SED_ABSTRACT_OBJECTS_TABLE

feature {NONE} -- Initialization

	make (n: NATURAL_32) is
			-- Initialize current instance
		require
			n_not_too_large: n <= {INTEGER}.max_value.to_natural_32
		deferred
		ensure
			last_index_set: last_index = 0
		end

feature -- Lookup

	search (an_obj: ANY) is
			-- Search for item of key `an_obj'.
			-- If found, set `found' to true, and set
			-- `found_item' to item associated with `an_obj'.
		require
			an_obj_not_void: an_obj /= Void
		deferred
		end

feature -- Access
	
	found: BOOLEAN
			-- Was last search successful?

	found_item: NATURAL_32
			-- Value found at last successful search or last inserted item

feature -- Status report

	has (an_obj: ANY): BOOLEAN is
			-- Does current have `an_obj'?
		require
			an_obj_not_void: an_obj /= Void
		deferred
		end

feature -- Element change

	put (an_obj: ANY) is
			-- Insert `an_obj' in Current.
		require
			an_obj_not_void: an_obj /= Void
			not_inserted: not has (an_obj)
		deferred
		ensure
			inserted: has (an_obj)
			last_index_updated: last_index = old last_index + 1
			found_item_set: found_item = last_index
		end

feature -- Removal

	wipe_out is
			-- Remove all items.
		deferred
		end

feature {NONE} -- Implementation

	last_index: NATURAL_32
			-- Last index of inserted items.

end
