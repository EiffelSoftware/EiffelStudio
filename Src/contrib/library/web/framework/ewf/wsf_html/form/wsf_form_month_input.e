note
	description: "[
				Represent an input type Month
			Example:
			<input id="expiry" name="expiry" type="month" required>
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=month", "src=https://html.spec.whatwg.org/multipage/forms.html#month-state-(type=month)"

class
	WSF_FORM_MONTH_INPUT

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

	input_type: STRING = "month"


feature {NONE} -- Conversion

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			create Result.make_empty
			append_numeric_input_attributes_to (Result)
		end
end
