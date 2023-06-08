note
	description: "Object representing the GenericParamConstraint table"
	date: "$Date$"
	revision: "$Revision$"
	see: "II.22.21 GenericParamConstraint : 0x2C "

class
	PE_GENERIC_PARAM_CONSTRAINTS_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_owner: PE_GENERIC_REF; a_constraint: PE_TYPEDEF_OR_REF)
		do
			owner := a_owner
			constraint := a_constraint
		end

feature -- Access

	owner: PE_GENERIC_REF

	constraint: PE_TYPEDEF_OR_REF

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tGenericParam.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
			l_bytes := owner.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + constraint.render (a_sizes, a_dest, l_bytes.to_integer_32)
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
			l_bytes := owner.get (a_sizes, a_src, 0)
			l_bytes := l_bytes + constraint.get (a_sizes, a_src, l_bytes.to_integer_32)
			Result := l_bytes
		end

end
