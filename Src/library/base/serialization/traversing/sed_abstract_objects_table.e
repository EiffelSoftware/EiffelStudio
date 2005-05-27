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

feature -- Access

	index (an_obj: ANY): NATURAL_32 is
			-- Index of `an_obj' in Current
		require
			an_obj_not_void: an_obj /= Void
		deferred
		end

feature -- Status report

	capacity: INTEGER is
			-- Default capacity of current.
		deferred
		ensure
			capacity_non_negative: Result >= 0
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
