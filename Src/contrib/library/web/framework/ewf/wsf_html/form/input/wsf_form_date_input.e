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

feature -- Element change

	set_date_value (dt: DATE)
			-- Set value using date `dt`.
		local
			y,m,d: INTEGER
			s: STRING
		do
			y := dt.year
			m := dt.month
			d := dt.day
			create s.make (10)
			s.append_integer (y)
			s.append_character ('-')
			if m <= 9 then
				s.append_character ('0')
			end
			s.append_integer (m)
			s.append_character ('-')
			if d <= 9 then
				s.append_character ('0')
			end
			s.append_integer (d)
			set_text_value (s)
		end

feature {NONE} -- Conversion

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			create Result.make_empty
			append_numeric_input_attributes_to (Result)
		end
end
