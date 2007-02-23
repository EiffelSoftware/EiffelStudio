indexing
	description: "[
		Equivalent of HASH_TABLE [NATURAL_32, ANY], since this type cannot be written
		as ANY does not inherit from HASHABLE
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_OBJECTS_TABLE

inherit
	SED_ABSTRACT_OBJECTS_TABLE

create
	make

feature {NONE} -- Initialization

	make (n: NATURAL_32) is
			-- Initialize current instance
		do
			create table.make (n.to_integer_32)
			last_index := 0
		end

feature -- Status report

	capacity: INTEGER is
			-- Default capacity of current.
		do
			Result := table.capacity
		end

feature -- Access

	index (an_obj: ANY): NATURAL_32 is
			-- Index of `an_obj' in Current
		local
			l_table: like table
			l_found_result: NATURAL_32
		do
			l_table := table
			Result := last_index + 1
			l_table.put (Result, $an_obj)
			l_found_result := l_table.found_item
			if Result /= l_found_result then
				Result := l_found_result
			else
				last_index := Result
			end
		end

feature -- Removal

	wipe_out is
			-- Remove all items.
		do
			last_index := 0
			table.clear_all
		end

feature {NONE} -- Implementation

	table: HASH_TABLE [NATURAL_32, POINTER]
			-- Mapping between object address and index.

invariant
	not_is_dotnet: not {PLATFORM}.is_dotnet
	table_not_void: table /= Void

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
