indexing
	description: ".NET field as seen by Eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_FIELD

inherit
	CONSUMED_MEMBER
		rename
			make as member_make
		end

create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING; rt: CONSUMED_REFERENCED_TYPE; static: BOOLEAN) is
			-- Initialize field.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_return_type: return_type /= Void
		do
			member_make (en, dn)
			is_static := static
			return_type := rt
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			return_type_set: return_type = rt
			is_static_set: is_static = static
		end

feature -- Access

	is_static: BOOLEAN
		-- Is field static?

	return_type: CONSUMED_REFERENCED_TYPE
		-- Field type

end -- class CONSUMED_FIELD
