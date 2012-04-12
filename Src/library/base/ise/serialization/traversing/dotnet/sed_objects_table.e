﻿note
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

	make (n: NATURAL_32)
			-- Initialize current instance
		do
			create table.make (n.to_integer_32, create {RT_REFERENCE_COMPARER}.make)
			last_index := 0
		end

feature -- Lookup

	index (an_obj: ANY): NATURAL_32
			-- Index of `an_obj' in Current		
		local
			l_table: like table
		do
			l_table := table
			if attached l_table.item (an_obj) as o then
				if attached {NATURAL_32} o as i then
					Result := i
				else
					check
						valid_item_type: False
					end
				end
			else
				Result := last_index + 1
				last_index := Result
				l_table.add (an_obj, Result)
			end
		end

feature -- Status report

	capacity: INTEGER
			-- Default capacity of current.
		do
				-- No way to get the capacity on .NET, so we return `count'.
			Result := table.count
		end

feature -- Removal

	wipe_out
			-- Remove all items.
		do
			last_index := 0
			table.clear
		end

feature {NONE} -- Implementation

	table: HASHTABLE
			-- Equivalent of HASH_TABLE [NATURAL_32, ANY]

invariant
	is_dotnet: {PLATFORM}.is_dotnet
	table_not_void: table /= Void

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
