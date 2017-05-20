note
	description: "Summary description for {WSF_FORM_TIME_INPUT}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=time", "src=https://html.spec.whatwg.org/multipage/forms.html#time-state-(type=time)"
class
	WSF_FORM_TIME_INPUT

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

	input_type: STRING = "time"


feature {NONE} -- Conversion

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			create Result.make_empty
			append_numeric_input_attributes_to (Result)
		end
end
