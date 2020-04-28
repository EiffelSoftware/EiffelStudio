note

	description:

		"Error: Unknown wrapper type"

	copyright: "Copyright (c) 2004, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_UNKNOWN_WRAPPER_TYPE_ERROR

inherit

	UT_ERROR

	EWG_CONFIG_ELEMENT_NAMES
		export {NONE} all end

	EWG_CONFIG_WRAPPER_TYPE_NAMES
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (an_element: XM_ELEMENT; a_position: XM_POSITION)
			-- Create an error reporting that the value of the attribute "type"
			-- in the "wrapper" elment `an_element' is unknown.
		require
			an_element_not_void: an_element /= Void
			an_element_has_option_as_name: STRING_.same_string (an_element.name, wrapper_element_name)
			an_element_has_name_attribute: an_element.has_attribute_by_name (type_attribute_name)
			a_name_attribute_not_empty: attached an_element.attribute_by_name (type_attribute_name) as l_type_attribute_name implies  l_type_attribute_name.value.count > 0
			a_position_not_void: a_position /= Void
		do
			create parameters.make_filled ("", 1, 2)
			if attached an_element.attribute_by_name (type_attribute_name) as l_type_attribute_name then
				parameters.put (l_type_attribute_name.value, 1)
			end
			parameters.put (a_position.out, 2)
		end

feature -- Access

	default_template: STRING = "wrapper type name '$1' in wrapper-element is unknown $2"
			-- Default template used to built the error message

	code: STRING = "EWG0004"
			-- Error code

end
