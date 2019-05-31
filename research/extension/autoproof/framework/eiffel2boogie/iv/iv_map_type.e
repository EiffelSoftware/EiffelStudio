note
	description: "Boogie map types."
	date: "$Date$"
	revision: "$Revision$"

class
	IV_MAP_TYPE

inherit
	IV_TYPE
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_type_params: ARRAY [STRING]; a_domain_types: like domain_types; a_range_type: IV_TYPE)
			-- Create a map type "<a_type_params>[a_domain_types]a_range_type".
		require
			a_type_params_exists: attached a_type_params
			a_domain_types_exists: attached a_domain_types
			a_range_type_exists: attached a_range_type
		do
			type_parameters := a_type_params
			domain_types := a_domain_types
			range_type := a_range_type
			type_parameters.compare_objects
			domain_types.compare_objects
		end

feature -- Access

	type_parameters: ARRAY [STRING]
			-- Bound type variables of the map type.

	domain_types: ARRAYED_LIST [IV_TYPE]
			-- Domains of the map type.

	range_type: IV_TYPE
			-- Range of the map type.

feature -- Visitor

	process (a_visitor: IV_TYPE_VISITOR)
			-- Process type.
		do
			a_visitor.process_map_type (Current)
		end

feature -- Equality

	is_equal (a_other: like Current): BOOLEAN
			-- Is `a_other' same type as this?
		do
			-- ToDo: semantic equality of map types should be implemented with DeBrujn indices,
			-- but hopefully we do not need this, because we are using standard type parameter names
			Result := type_parameters ~ a_other.type_parameters and
				domain_types ~ a_other.domain_types and
				range_type ~ a_other.range_type
		end

end
