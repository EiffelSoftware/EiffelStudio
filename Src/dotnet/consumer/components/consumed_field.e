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
			has_return_value, return_type, is_attribute, is_init_only, is_field
		end

create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING; rt: CONSUMED_REFERENCED_TYPE; static, pub, init_only: BOOLEAN;
			a_type: CONSUMED_REFERENCED_TYPE)
		is
			-- Initialize field.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_return_type: return_type /= Void
			a_type_not_void: a_type /= Void
		do
			member_make (en, dn, pub, a_type)
			if static then
				internal_flags := internal_flags | feature {FEATURE_ATTRIBUTE}.Is_static
			end
			if init_only then
				internal_flags := internal_flags | feature {FEATURE_ATTRIBUTE}.Is_init_only
			end
			return_type := rt
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			return_type_set: return_type = rt
			is_static_set: is_static = static
			is_public_set: is_public = pub
			declared_type_set: declared_type = a_type
		end

feature -- Access

	return_type: CONSUMED_REFERENCED_TYPE
			-- Field type

feature -- Status report

	is_attribute: BOOLEAN is True
			-- Current is an attribute.

	has_return_value: BOOLEAN is True
			-- An attribute always return a value.

	is_init_only: BOOLEAN is
			-- Is field a constant?
		do
			Result := internal_flags & feature {FEATURE_ATTRIBUTE}.Is_init_only =
				feature {FEATURE_ATTRIBUTE}.Is_init_only
		end
		
	is_field: BOOLEAN is
			-- Is field?
		do
			Result := True
		end

end -- class CONSUMED_FIELD
