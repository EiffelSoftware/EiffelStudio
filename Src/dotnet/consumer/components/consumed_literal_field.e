indexing
	description: "Literal fields as seen in Eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_LITERAL_FIELD

inherit
	CONSUMED_FIELD
		rename
			make as field_make
		redefine
			is_literal
		end

create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING; rt: CONSUMED_REFERENCED_TYPE; static, pub: BOOLEAN;
			val: STRING; a_type: CONSUMED_REFERENCED_TYPE)
		is
			-- Initialize field.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_return_type: return_type /= Void
			non_void_value: val /= Void
			a_type_not_void: a_type /= Void
		do
			field_make (en, dn, rt, static, pub, a_type)
			value := val
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			return_type_set: return_type = rt
			is_static_set: is_static = static
			is_public_set: is_public = pub
			value_set: value = val
			declared_type_set: declared_type = a_type
		end

feature -- Access

	value: STRING
			-- Literal value

feature -- Status report

	is_literal: BOOLEAN is True
			-- Current is literal.

invariant
	is_static: is_static

end -- class CONSUMED_LITERAL_FIELD
