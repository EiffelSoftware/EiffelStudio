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
		redefine
			has_return_value, return_type, is_attribute
		end

create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING; rt: CONSUMED_REFERENCED_TYPE; static, pub: BOOLEAN) is
			-- Initialize field.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_return_type: return_type /= Void
		do
			member_make (en, dn, pub)
			if static then
				internal_flags := internal_flags | feature {FEATURE_ATTRIBUTE}.Is_static
			end
			return_type := rt
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			return_type_set: return_type = rt
			is_static_set: is_static = static
			is_public_set: is_public = pub
		end

feature -- Access

	return_type: CONSUMED_REFERENCED_TYPE
			-- Field type

feature -- Status report

	is_attribute: BOOLEAN is True
			-- Current is an attribute.

	has_return_value: BOOLEAN is True
			-- An attribute always return a value.

end -- class CONSUMED_FIELD
