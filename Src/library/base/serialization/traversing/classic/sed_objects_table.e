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
		do
			table.search ($an_obj)
			found := table.found
			found_item := table.found_item
		end

feature -- Status report

	has (an_obj: ANY): BOOLEAN is
			-- Does current have `an_obj'?
		do
			Result := table.has ($an_obj)
		end
		
	capacity: INTEGER is
			-- Default capacity of current.
		do
			Result := table.capacity
		end

feature -- Element change

	put (an_obj: ANY) is
			-- Insert `an_obj' in Current.
		do
			last_index := last_index + 1
			found_item := last_index
			table.put (last_index, $an_obj)
		end

feature -- Removal

	wipe_out is
			-- Remove all items.
		do
			table.clear_all
		end

feature {NONE} -- Implementation

	table: HASH_TABLE [NATURAL_32, POINTER]
			-- Mapping between object address and index.

invariant
	not_is_dotnet: not {PLATFORM}.is_dotnet
	table_not_void: table /= Void

end
