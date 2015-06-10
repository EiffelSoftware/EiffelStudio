note
	description: "[
		Example:
		<name="startdate" min="2012-01-01" max="2013-01-01" type="date">
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=date",  "src=https://html.spec.whatwg.org/multipage/forms.html#date-state-(type=date)"

class
	WSF_FORM_DATE_INPUT
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

	input_type: STRING = "date"


feature {NONE} -- Conversion

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			create Result.make_empty
			append_numeric_input_attributes_to (Result)
		end
end
