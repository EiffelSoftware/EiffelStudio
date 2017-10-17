note
	description: "[
		Represent attributes applicable to input type type=[number, range, date]
		The attributes: min, max, step.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=numeric attributes", "src=https://html.spec.whatwg.org/multipage/forms.html#common-input-element-attributes"

class
	WSF_FORM_FIELD_WITH_NUMERIC_ATTRIBUTE

inherit

	SHARED_HTML_ENCODER


feature -- Access

	min: detachable READABLE_STRING_8
			-- minimun value accepted by Current field.

	max: detachable READABLE_STRING_8
			-- maximun value accepted by Current field.

	step: detachable READABLE_STRING_8
			--  step is the increment that the value should adjust up or down, with the default step value being 1.

feature -- Element Change

	set_min (a_val: INTEGER)
			-- Set `min' with `a_val'.
		do
			set_min_string (a_val.out)
		ensure
			min_set: attached min as l_min implies l_min.same_string (a_val.out)
		end

	set_max (a_val: INTEGER)
			-- Set `max' with `a_val'.
		do
			set_max_string (a_val.out)
		ensure
			max_set: attached max as l_max implies l_max.same_string (a_val.out)
		end

	set_step (a_val: REAL)
			-- Set `step' with `a_val'.
		do
			set_step_string (a_val.out)
		ensure
			step_set: attached step as l_step implies l_step.same_string (a_val.out)
		end

	set_min_string (a_val: READABLE_STRING_GENERAL)
			-- Set `min' with `a_val'.
		require
			is_valid_number: a_val.is_integer
		do
			if a_val.is_string_32 then
		 		min := html_encoder.encoded_string (a_val.as_string_32)
		 	elseif a_val.is_string_8 then
		 		min := a_val.as_string_8
		 	end
		ensure
			min_set: attached min as l_min implies l_min.same_string_general (a_val)
		end

	set_max_string (a_val: READABLE_STRING_GENERAL)
			-- Set `max' with `a_val'.
		require
			is_valid_number: a_val.is_integer
		do
			if a_val.is_string_32 then
		 		max := html_encoder.encoded_string (a_val.as_string_32)
		 	elseif a_val.is_string_8 then
		 		max := a_val.as_string_8
		 	end
		ensure
			max_set: attached max as l_max implies l_max.same_string_general (a_val)
		end

	set_step_string (a_val: READABLE_STRING_GENERAL)
			-- Set `step' with `a_val'.
		require
			is_valid_sequence: a_val.is_number_sequence or else a_val.is_real_sequence
 		do
 			if a_val.is_string_32 then
 				step := html_encoder.encoded_string (a_val.as_string_32)
 			elseif a_val.is_string_8 then
 				step := a_val.as_string_8
 			end
		ensure
			step_set: attached step as l_step implies l_step.same_string_general (a_val)
		end

feature {NONE} -- Conversion

	append_numeric_input_attributes_to (a_target: STRING)
			-- append numeric attributes to a_target, if any.
		do
				--min
			if attached min as l_min then
				a_target.append (" min=%"")
				a_target.append (l_min)
				a_target.append_character ('%"')
			end

				--max
			if attached max as l_max then
				a_target.append (" max=%"")
				a_target.append (l_max)
				a_target.append_character ('%"')
			end

				--step
			if attached step as l_step then
				a_target.append (" step=%"")
				a_target.append (l_step)
				a_target.append_character ('%"')
			end
		end

end
