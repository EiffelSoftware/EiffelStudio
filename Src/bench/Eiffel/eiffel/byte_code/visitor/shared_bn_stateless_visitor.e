indexing
	description: "Collections of stateless BYTE_NODE visitors."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_BN_STATELESS_VISITOR

feature -- Byte code generators

	melted_generator: MELTED_GENERATOR is
			-- Generator for melted code.
		once
			create Result
		ensure
			melted_generator_not_void: Result /= Void
		end

	melted_assignment_generator: MELTED_ASSIGNMENT_GENERATOR is
			-- Generator assignments for melted code.
		once
			create Result
		ensure
			melted_assignment_generator_not_void: Result /= Void
		end

feature -- IL code generators

	cil_node_generator: IL_NODE_GENERATOR is
			-- Generator for CIL code.
		once
			create Result
		ensure
			cil_node_generator_not_void: Result /= Void
		end

	cil_access_address_generator: IL_ACCESS_ADDRESS_GENERATOR is
			-- Generator for loading address of an ACCESS_B node.
		once
			create Result
		ensure
			cil_access_address_generator_not_void: Result /= Void
		end

end
