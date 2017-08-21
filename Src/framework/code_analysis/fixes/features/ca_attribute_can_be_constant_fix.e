note
	description: "Fixes violations of rule #48 ('Attribute can be made constant')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_ATTRIBUTE_CAN_BE_CONSTANT_FIX

inherit
	CA_FIX
		redefine
			execute,
			process_assign_as
		end

create
	make_with_attribute_and_value

feature {NONE} -- Initialization

	make_with_attribute_and_value (a_class: attached CLASS_C; a_attribute: attached FEATURE_AS; a_value: STRING_32)
			-- Initializes `Current' with class `a_class'. `a_attribute' is the attribute to be made constant.
		do
			make(ca_names.attribute_can_be_constant_fix, a_class)
			attribute_to_change := a_attribute
			constant_value := a_value
		end

feature {NONE} -- Implementation

	attribute_to_change: FEATURE_AS
		-- The attribute to be changed.

	constant_value: STRING_32
		-- The value of the attribute.

feature {NONE} -- Visitor

	execute
			-- <Precursor>
		local
			u: UTF_CONVERTER
		do
			attribute_to_change.body.append_text (" = " + u.string_32_to_utf_8_string_8 (constant_value), match_list)
			process_ast_node (parsed_class)
		end

	process_assign_as (a_assign: ASSIGN_AS)
			-- Removes all the assignments to the attribute.
		do
			if
				attached {ACCESS_ID_AS} a_assign.target as l_access_id
				and then l_access_id.access_name_32.is_equal (attribute_to_change.feature_name.name_32)
			then
				a_assign.remove_text (match_list)
			end
		end

end
