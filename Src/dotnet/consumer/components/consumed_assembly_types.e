indexing
	description: "Table of consumed types for a given assembly"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ASSEMBLY_TYPES

create
	make

feature {NONE} -- Initialization

	make (count: INTEGER) is
			-- Create name arrays.
		do
			create eiffel_names.make (1, count)
			create dotnet_names.make (1, count)
		end
		
feature -- Access

	eiffel_names: ARRAY [STRING]
			-- Assembly types eiffel name
	
	dotnet_names: ARRAY [STRING]
			-- Assembly types .NET name

	index: INTEGER
			-- Number of items in arrays

feature -- Element Settings	

	put (dn, en: STRING) is
			-- Add type with Eiffel name `en' and .NET name `dn'.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
		do
			index := index + 1
			eiffel_names.put (en, index)
			dotnet_names.put (dn, index)
		ensure
			eiffel_name_inserted: eiffel_names.item (eiffel_names.count) = en
			dotnet_name_inserted: dotnet_names.item (dotnet_names.count) = dn
		end

end -- class CONSUMED_ASSEMBLY_TYPES
