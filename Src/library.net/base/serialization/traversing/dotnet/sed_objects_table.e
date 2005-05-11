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

	search (an_obj: ANY) is
			-- Search for item of key `an_obj'.
			-- If found, set `found' to true, and set
			-- `found_item' to item associated with `an_obj'.
		local
			l_obj: SYSTEM_OBJECT
		do
			l_obj := table.item (an_obj)
			if l_obj /= Void then
				found := True
				found_item ?= l_obj
			else
				found := False
			end
		end

feature -- Status report

	has (an_obj: ANY): BOOLEAN is
			-- Does current have `an_obj'?
		do
			Result := table.contains (an_obj)
		end
	
feature -- Element change

	put (an_obj: ANY) is
			-- Insert `an_obj' in Current.
		do
			last_index := last_index + 1
			found_item := last_index
			table.add (an_obj, last_index)
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
