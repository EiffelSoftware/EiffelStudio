indexing
	description: "[
		Equivalent of HASH_TABLE [NATURAL_32, ANY], since this type cannot be written
		as ANY does not inherit from HASHABLE
		]"
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

feature -- Lookup

	index (an_obj: ANY): NATURAL_32 is
			-- Index of `an_obj' in Current		
		local
			l_obj: SYSTEM_OBJECT
			l_table: like table
		do
			l_table := table
			l_obj := l_table.item (an_obj)
			if l_obj /= Void then
				Result ?= l_obj
			else
				Result := last_index + 1
				last_index := Result
				l_table.add (an_obj, Result)
			end
		end

feature -- Status report

	capacity: INTEGER is
			-- Default capacity of current.
		do
				-- No way to get the capacity on .NET, so we return `count'.
			Result := table.count
		end

feature -- Removal

	wipe_out is
			-- Remove all items.
		do
			table.clear
		end

feature {NONE} -- Implementation

	table: HASHTABLE
			-- Equivalent of HASH_TABLE [NATURAL_32, ANY]

invariant
	is_dotnet: {PLATFORM}.is_dotnet
	table_not_void: table /= Void

end
