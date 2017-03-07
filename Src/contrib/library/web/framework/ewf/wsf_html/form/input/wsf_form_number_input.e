note
	description: "[
		Represent the input type number.
		Example:
		<input type="number" min="5" max="18" step="0.5" value="9" name="shoe-size">
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name= Number", "src=https://html.spec.whatwg.org/multipage/forms.html#number-state-(type=number)"

class
	WSF_FORM_NUMBER_INPUT

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

	input_type: STRING = "number"

feature {NONE} -- Conversion

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			create Result.make_empty
			append_numeric_input_attributes_to (Result)
		end
end
