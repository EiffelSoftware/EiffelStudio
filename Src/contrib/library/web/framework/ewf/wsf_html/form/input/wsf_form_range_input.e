note
	description: "[
		Represent an input type range
		Example
		<input type="range" min=0 max=100 step=20 value=50>
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_RANGE_INPUT

inherit

	WSF_FORM_INPUT
		redefine
			specific_input_attributes_string
		end

	WSF_FORM_FIELD_WITH_NUMERIC_ATTRIBUTE

create
	make,
	make_with_text

feature -- Access

	input_type: STRING = "range"


feature {NONE} -- Conversion

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			create Result.make_empty
			append_numeric_input_attributes_to (Result)
		end
end
