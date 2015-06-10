note
	description: "[
				Represent an input type datetime
				Example
				<input id="entry-day-time" name="entry-day-time" type="datetime">
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=datetime", "src=https://html.spec.whatwg.org/multipage/forms.html#date-and-time-state-(type=datetime)"

class
	WSF_FORM_DATETIME_INPUT

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

	input_type: STRING = "datetime"


feature {NONE} -- Conversion

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			create Result.make_empty
			append_numeric_input_attributes_to (Result)
		end
end
