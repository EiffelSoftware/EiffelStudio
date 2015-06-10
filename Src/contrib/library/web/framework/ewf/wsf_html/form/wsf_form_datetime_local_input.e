note
	description: "[
		Represent an input type datetime-local
		Example:
		<input id="arrival-time" name="arrival-time " type="datetime-local">
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=datetime-local", "src=https://html.spec.whatwg.org/multipage/forms.html#local-date-and-time-state-(type=datetime-local)"
class
	WSF_FORM_DATETIME_LOCAL_INPUT
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

	input_type: STRING = "datetime-local"


feature {NONE} -- Conversion

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			-- TODO find a way to validte differnet types of
			-- values to (min, max and step).
			create Result.make_empty
			append_numeric_input_attributes_to (Result)
		end
end
