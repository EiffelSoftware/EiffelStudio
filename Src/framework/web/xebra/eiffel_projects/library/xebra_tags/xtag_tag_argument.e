note
	description: "[
		Stands for attributes in tags (xhtml and xebra).
		There are three types it can stand for:
			-- Plain xhtml text attribute
			-- Call to a function of the controller
			-- Call to a function of a variable
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XTAG_TAG_ARGUMENT


inherit
	XU_STRING_MANIPULATION

feature -- Initialization

	make (a_value: STRING)
			-- `a_value': The value of the argument
		require
			a_value_attached: attached a_value
		do
			internal_value := a_value			
		ensure
			internal_value_attached: attached internal_value
		end

	make_default
		do
			internal_value := ""
		ensure
			internal_value_attached: attached internal_value
		end

feature {XTAG_TAG_SERIALIZER} -- Access

	is_dynamic: BOOLEAN
			-- Is the argument dynamic?
		deferred
		end

	is_variable: BOOLEAN
			-- Is the argument a variable call?
		deferred
		end

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
		require
			a_controller_id_valid: attached a_controller_id
		deferred
		ensure
			Result_attached: attached Result
		end

	plain_value (a_controller_id: STRING): STRING
			-- Returns the plain_value without escaping and without quotes
		require
			a_controller_id_valid: attached a_controller_id
		deferred
		ensure
			Result_attached: attached Result
		end

	value_without_escape (a_controller_id: STRING): STRING
			-- Like #value but without escaping the value
		require
			a_controller_id_valid: attached a_controller_id
		deferred
		ensure
			Result_attached: attached Result
		end

	is_plain_text: BOOLEAN
			-- Is the argument plain (not dynamic nor variable)?
		do
			Result := not (is_dynamic or is_variable)
		end

invariant
	internal_value_attached: attached internal_value

end
