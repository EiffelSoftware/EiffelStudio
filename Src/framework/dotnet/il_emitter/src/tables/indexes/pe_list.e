note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_LIST

inherit
	PE_INDEX_BASE
		rename
			make as make_base
		redefine
			get_index_shift,
			has_index_overflow
		end

feature {NONE} -- Initialization

	make
		do
		end

feature -- Access

	associated_table_index: NATURAL_32
		deferred
		end

feature -- Operations

	update_index (idx: like index)
		require
			valid_index: idx > 0
		do
			index := idx
		ensure
			is_list_index_set
		end

feature -- Status report

	is_list_index_set: BOOLEAN
			-- Is first index of Current list set ?
		do
			Result := index /= 0
		end

feature -- Access

	get_index_shift: INTEGER
		do
			Result := 0
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_64]): BOOLEAN
		do
			Result := large (a_sizes [associated_table_index.to_integer_32 + 1].to_natural_32)
		end

end
