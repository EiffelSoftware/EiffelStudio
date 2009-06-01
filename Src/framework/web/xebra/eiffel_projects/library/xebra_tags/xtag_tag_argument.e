note
	description: "[
		{XTAG_TAG_ARGUMENT}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_TAG_ARGUMENT


inherit
	XU_STRING_MANIPULATION

create
	make

feature -- Initialization

	make (a_value: STRING)
			-- `a_value': The value of the argument
		require
			a_value_attached: attached a_value
		do
			is_dynamic := dynamic_attribute_regexp.matches (a_value)
			if is_dynamic then
				internal_value := strip_off_dynamic_tags (a_value)
			else
				internal_value := a_value
			end
		ensure
			internal_value_attached: attached internal_value
		end

feature {NONE} -- Access

	is_dynamic: BOOLEAN
			-- Is the argument dynamic?

	internal_value: STRING
			-- The actual value

	dynamic_attribute_regexp: RX_PCRE_MATCHER
			-- Dynamic attribute regular expression
		once
			create Result.make
			Result.compile ("^%%=.+%%$")
		ensure
			result_attached: attached Result
			result_compiled: Result.is_compiled
		end

feature -- Access

	value (a_controller_id: STRING): STRING
			-- The value it represents
		do
			if is_dynamic then
				Result := "%"+" + a_controller_id + "." + internal_value + "+%""
			else
				Result := escape_string (internal_value)
			end
		end

	value_without_escape (a_controller_id: STRING): STRING
			-- Like #value but without escaping the value
		do
			if is_dynamic then
				Result := "%"+" + a_controller_id + "." + internal_value + "+%""
			else
				Result := internal_value
			end
		end

	is_plain_text: BOOLEAN
			-- Is the argument plain (not dynamic)?
		do
			Result := not is_dynamic
		end

feature {NONE} -- Implementation

	strip_off_dynamic_tags (a_string: STRING): STRING
			-- Strips off the "%=" and ending "%"  Probably better using the regexp		
		require
			a_string_attached: attached a_string
		do
			Result := a_string.substring (3, a_string.count - 1)
		end

invariant

	internal_value_attached: attached internal_value

end
