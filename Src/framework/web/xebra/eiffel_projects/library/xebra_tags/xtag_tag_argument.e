note
	description: "[
		Stands for attributes in tags (xhtml and xebra).
		There are three types it can stand for:
			-- Plain xhtml text attribute
			-- Call to a function of the controller
			-- Call to a function of a variable
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
			is_variable := variable_attribute_regexp.matches (a_value)
			if is_dynamic then
				internal_value := dynamic_attribute_regexp.captured_substring (1)
			elseif is_variable then
				internal_value := variable_attribute_regexp.captured_substring (1)
			else
				internal_value := a_value
			end
		end

feature {NONE} -- Access

	is_dynamic: BOOLEAN
			-- Is the argument dynamic?

	is_variable: BOOLEAN
			-- Is the argument a variable call?

	internal_value: STRING
			-- The actual value

	dynamic_attribute_regexp: RX_PCRE_MATCHER
			-- Dynamic attribute regular expression
		once
			create Result.make
			Result.compile ("^%%=(.+)%%$")
		ensure
			result_attached: attached Result
			result_compiled: Result.is_compiled
		end

	variable_attribute_regexp: RX_PCRE_MATCHER
			-- Dynamic attribute regular expression
		once
			create Result.make
			Result.compile ("^#{(.+)}$")
		ensure
			result_attached: attached Result
			result_compiled: Result.is_compiled
		end

feature -- Access

	is_empty: BOOLEAN
			-- Is the value the empty string?
		do
			Result := internal_value.is_empty
		end

	value (a_controller_id: STRING): STRING
			-- The value it represents
		do
			if is_dynamic then
				Result := "%"+" + a_controller_id + "." + internal_value + "+%""
			elseif is_variable then
				Result := "%"+" + internal_value + "+%""
			else
				Result := escape_string (internal_value)
			end
		end

	plain_value (a_controller_id: STRING): STRING
		do
			if is_dynamic then
				Result := a_controller_id + "." + internal_value
			elseif is_variable then
				Result := internal_value
			else
				Result := internal_value
			end
		end

	value_without_escape (a_controller_id: STRING): STRING
			-- Like #value but without escaping the value
		do
			if is_dynamic then
				Result := "%"+" + a_controller_id + "." + internal_value + "+%""
			elseif is_variable then
				Result := "%"+" + internal_value + "+%""
			else
				Result := internal_value
			end
		end

	is_plain_text: BOOLEAN
			-- Is the argument plain (not dynamic)?
		do
			Result := not is_dynamic
		end

end
