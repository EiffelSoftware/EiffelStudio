indexing
	description: ".NET type member as seen by Eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_MEMBER

inherit
	CONSUMED_ENTITY
		rename
			make as entity_make
		end

create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING) is
			-- Initialize from `meth'.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
		do
			entity_make (en)
			dotnet_name := dn
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
		end
		
feature -- Access

	dotnet_name: STRING
			-- .NET member name

invariant
	non_void_dotnet_name: dotnet_name /= Void
	valid_dotnet_name: not dotnet_name.is_empty

end -- class CONSUMED_MEMBER
