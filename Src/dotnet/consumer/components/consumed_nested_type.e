indexing
	description: ".NET nested type as needed by the Eiffel compiler"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_NESTED_TYPE

inherit
	CONSUMED_TYPE
		rename
			make as type_make
		end

create
	make
	
feature {NONE} -- Initialization

	make (dn, en: STRING; is_inter, is_abstract, is_sealed, is_value_type, is_enumerator: BOOLEAN;
			par: like parent; inter: like interfaces; a_type: like enclosing_type)
		is
			-- Initialize instance.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_interfaces: inter /= Void
			a_type_not_void: a_type /= Void
		do
			type_make (dn, en, is_inter, is_abstract, is_sealed, is_value_type, is_enumerator,
				par, inter)
			enclosing_type := a_type
		ensure
			dotnet_name_set: dotnet_name = dn
			eiffel_name_set: eiffel_name = en
			is_interface_set: is_interface = is_inter
			is_deferred_set: is_deferred = is_abstract
			is_frozen_set: is_frozen = is_sealed
			is_expanded_set: is_expanded = is_value_type
			parent_set: parent = par
			interfaces_set: interfaces = inter
			enclosing_type_set: enclosing_type = a_type
		end
		
feature -- Access

	enclosing_type: CONSUMED_REFERENCED_TYPE
			-- Type in which Current is defined.

invariant
	enclosing_type_not_void: enclosing_type /= Void

end -- class CONSUMED_NESTED_TYPE
