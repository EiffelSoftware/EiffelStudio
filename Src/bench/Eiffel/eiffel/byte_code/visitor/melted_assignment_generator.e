indexing
	description: "Visitor for performing assignments."
	date: "$Date$"
	revision: "$Revision$"

class
	MELTED_ASSIGNMENT_GENERATOR

inherit
	ASSIGNMENT_GENERATOR
		redefine
			process_local_b, process_attribute_b, process_result_b
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

feature -- Byte code generation

	generate_assignment (a_ba: BYTE_ARRAY; a_node: BYTE_NODE) is
			-- Generate assignment on `a_node'.
		require
			is_valid: is_valid
			a_ba_not_void: a_ba /= Void
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
		do
			ba := a_ba
			a_node.process (Current)
			ba := Void
		end

feature -- Access

	ba: BYTE_ARRAY
			-- Byte array where melted code is stored.

feature {NONE} -- Implementation

	process_attribute_b (a_node: ATTRIBUTE_B) is
			-- Process `a_node'.
		local
			l_instant_context_type: CL_TYPE_I
			l_base_class: CLASS_C
			l_rout_info: ROUT_INFO
		do
			l_instant_context_type ?= a_node.context_type
			l_base_class := l_instant_context_type.base_class
			if l_base_class.is_precompiled then
				l_rout_info := system.rout_info_table.item (l_base_class.feature_table.item_id (
					a_node.attribute_name_id).rout_id_set.first)
				ba.append_integer (l_rout_info.origin)
				ba.append_integer (l_rout_info.offset)
			else
				ba.append_integer (a_node.attribute_id)
				ba.append_short_integer (l_instant_context_type.associated_class_type.static_type_id - 1)
			end
			ba.append_uint32_integer (context.real_type (a_node.type).sk_value)
		end

	process_local_b (a_node: LOCAL_B) is
			-- Process `a_node'.
		do
			ba.append_short_integer (a_node.position)
		end

	process_result_b (a_node: RESULT_B) is
			-- Process `a_node'.
		do
			-- Nothing to be done.
		end

end
