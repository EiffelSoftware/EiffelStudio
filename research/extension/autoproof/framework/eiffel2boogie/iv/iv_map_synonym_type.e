note
	description: "Summary description for {IV_MAP_SYNONYM_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IV_MAP_SYNONYM_TYPE

inherit
	IV_MAP_TYPE
		rename
			make as make_map
		undefine
			default_value,
			type_inv,
			has_rank,
			rank_leq,
			is_equal,
			process
		end

	IV_USER_TYPE
		rename
			make as make_synonym
		undefine
			process
		end

create
	make

feature {NONE} -- Initialization

	make (a_type_params: ARRAY [STRING]; a_domain_types: ARRAY [IV_TYPE]; a_range_type: IV_TYPE; a_constructor: STRING; a_params: ARRAY [IV_TYPE])
			-- Create a map type "<a_type_params>[a_domain_types]a_range_type" with synonym "a_constructor a_params".
		require
			a_type_params_exists: attached a_type_params
			a_domain_types_exists: attached a_domain_types
			a_range_type_exists: attached a_range_type
			a_constructor_exists: attached a_constructor
			a_params_exists: attached a_params
			all_params_exist: across a_params as p all attached p.item end
		do
			make_map (a_type_params, a_domain_types, a_range_type)
			make_synonym (a_constructor, a_params)
		end

feature -- Visitor

	process (a_visitor: IV_TYPE_VISITOR)
			-- Process type.
		do
			a_visitor.process_map_synonym_type (Current)
		end

end
