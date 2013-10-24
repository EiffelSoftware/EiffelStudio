note
	description: "Object that represents a results after parsing Accept(-*) headers."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_ANY_ACCEPT

inherit
	HTTP_HEADER_UTILITIES

	REFACTORING_HELPER

	DEBUG_OUTPUT

create
	make_from_string

feature -- Initialization

	make_from_string (a_string: READABLE_STRING_8)
		local
			s: STRING_8
			i: INTEGER
		do
			initialize
			i := a_string.index_of (';', 1)
			if i > 0 then
				create s.make_from_string (a_string.substring (1, i - 1))
			else
				create s.make_from_string (a_string)
			end

			s.left_adjust
			s.right_adjust
			set_value (s)
			if i > 0 then
				create parameters.make_from_substring (a_string, i + 1, a_string.count)
			end
		end

	initialize
		do
		end

feature -- Access

	value: READABLE_STRING_8
			-- Value composing an Accept(-*) header value

feature -- Access: parameters

	parameter (a_key: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Item associated with `a_key', if present
			-- otherwise default value of type `STRING'
		do
			if attached parameters as l_parameters then
				Result := l_parameters.item (a_key)
			end
		end

	parameters: detachable HTTP_PARAMETER_TABLE
			-- Table of all parameters for the media range

feature -- Status Report

	has_parameter (a_key: READABLE_STRING_8): BOOLEAN
			-- Is there an item in the table with key `a_key'?
		do
			if attached parameters as l_parameters then
				Result := l_parameters.has_key (a_key)
			end
		end

feature -- Element change

	set_value (v: READABLE_STRING_8)
			-- Set `value' with `v'
		do
			value := v
		ensure
			value_set: attached value as l_value implies l_value.same_string (v)
		end

	put_parameter (a_value: READABLE_STRING_8; a_key: READABLE_STRING_8)
			-- Insert `a_value' with `a_key' if there is no other item
			-- associated with the same key. If present, replace
			-- the old value with `a_value'
		local
			l_parameters: like parameters
		do
			l_parameters := parameters
			if l_parameters = Void then
				create l_parameters.make (1)
				parameters := l_parameters
			end
			l_parameters.force (a_value, a_key)
		ensure
			is_set: attached parameters as l_params and then (l_params.has_key (a_key) and l_params.has_item (a_value))
		end

feature -- Status Report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (value)
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
