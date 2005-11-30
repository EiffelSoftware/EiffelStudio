indexing
	description: "Generate loading of the address for ACCESS_B node."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ACCESS_ADDRESS_GENERATOR

inherit
	BYTE_NODE_NULL_VISITOR
		redefine
			process_argument_b,
			process_attribute_b,
			process_current_b,
			process_local_b,
			process_result_b
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

feature -- IL code generation

	generate_il_address (a_code_generator: like il_generator; a_node: ACCESS_B) is
			-- Generate address loading of `a_node'.
		require
			a_code_generator_not_Void: a_code_generator /= Void
			a_node_not_void: a_node /= Void
		do
			il_generator := a_code_generator
			a_node.process (Current)
			il_generator := Void
		end

feature -- Access

	il_generator: IL_CODE_GENERATOR
			-- Actual IL code generator.


feature {NONE} -- Implementation

	process_argument_b (a_node: ARGUMENT_B) is
			-- Process `a_node'.
		do
			il_generator.generate_argument_address (a_node.position)
		end

	process_attribute_b (a_node: ATTRIBUTE_B) is
			-- Process `a_node'.
		local
			l_cl_type: CL_TYPE_I
		do
			l_cl_type ?= a_node.context_type
			il_generator.generate_current
			il_generator.generate_attribute_address (
				il_generator.implemented_type (a_node.written_in, l_cl_type),
				context.real_type (a_node.type), a_node.attribute_id)
		end

	process_current_b (a_node: CURRENT_B) is
			-- Process `a_node'.
		do
			il_generator.generate_current_address
		end

	process_local_b (a_node: LOCAL_B) is
			-- Process `a_node'.
		do
			il_generator.generate_local_address (a_node.position)
		end

	process_result_b (a_node: RESULT_B) is
			-- Process `a_node'.
		do
			il_generator.generate_result_address
		end

end
