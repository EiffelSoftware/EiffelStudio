note
	description: "Helper class to facilitate xml file parsing"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_XML_PARSE_HELPER

feature -- Access

	last_tested_attribute: STRING
			-- Last checked attribute by `test_attribute'

	last_tested_boolean: BOOLEAN
			-- Last boolean value successfully tested by `test_non_void_boolean_attribute'		

	last_tested_double: DOUBLE
			-- Last double value successfully tested by `test_non_void_double_attribute'

	last_tested_integer: INTEGER
			-- Last integer value successfully tested by `test_integer_attribute'

feature -- Error raising

	create_last_error (a_message: STRING_GENERAL)
			-- Create `last_error' with `a_message'.
		deferred
		end

feature -- Value validity testing

	test_attribute (a_attr_id: INTEGER; a_current_attrs: HASH_TABLE [STRING, INTEGER]; a_error_agent: PROCEDURE [ANY, TUPLE])
			-- Check if attribute whose id is `a_attr_id' exists in `a_current_attrs',
			-- If True, store its value in `last_tested_attribute', otherwise, raise an error using `a_error_agent'.
		require
			a_current_attrs_attached: a_current_attrs /= Void
			a_error_agent_attached: a_error_agent /= Void
		do
			last_tested_attribute := a_current_attrs.item (a_attr_id)
			if last_tested_attribute = Void then
				a_error_agent.call (Void)
			end
		end

	test_ommitable_attribute (a_attr_id: INTEGER; a_current_attrs: HASH_TABLE [STRING, INTEGER]; a_default: like last_tested_attribute)
			-- Check if attribute whose id is `a_attr_id' exists in `a_current_attrs',
			-- If True, store its value in `last_tested_attribute', otherwise, use `a_default' instead.
		require
			a_current_attrs_attached: a_current_attrs /= Void
			a_default_attached: a_default /= Void
		do
			last_tested_attribute := a_current_attrs.item (a_attr_id)
			if last_tested_attribute = Void then
				last_tested_attribute := a_default.twin
			end
		end

	test_ommitable_boolean_attribute (a_boolean_str: STRING; a_error_message_agent: FUNCTION [ANY, TUPLE [STRING_GENERAL], STRING_GENERAL]): BOOLEAN
			-- Test if `a_boolean_str' represents a valid boolean value. If so, store the boolean value in `last_tested_boolean' and return True
			-- If `a_boolean_str' represents an invalid boolean value, fire an error with error message returned by `a_error_message' and return True.
			-- If `a_boolean_str' is Void, do not set `last_tested_boolean' and return False.			
		require
			a_error_message_agent_attached: a_error_message_agent /= Void
		do
			if a_boolean_str /= Void then
				test_non_void_boolean_attribute (a_boolean_str, a_error_message_agent.item ([a_boolean_str]))
				Result := True
			end
		end

	test_boolean_attribute (a_boolean_str: STRING; a_missing_error_message: STRING_GENERAL; a_invalid_error_message_agent: FUNCTION [ANY, TUPLE [STRING_GENERAL], STRING_GENERAL])
			-- Test if `a_boolean_str' represents a valid boolean value. If so, store the boolean value in `last_tested_boolean'.
			-- Otherwise if `a_boolean_str' is Void, fire an error with error message returned by `a_missing_error_message_agent',
			-- if `a_boolean_str' is non-Void but is not a valid boolean, fire an error with error message given by `a_invalid_error_message'.
		require
			a_missing_error_message_attached: a_missing_error_message /= Void
			a_error_message_agent_attached: a_invalid_error_message_agent /= Void
		do
			if a_boolean_str = Void then
				create_last_error (a_missing_error_message)
			else
				test_non_void_boolean_attribute (a_boolean_str, a_invalid_error_message_agent.item ([a_boolean_str]))
			end
		end

	test_non_void_boolean_attribute (a_boolean_str: STRING; a_error_message: STRING_GENERAL)
			-- Test if `a_boolean_str' represents a valid boolean value. If so, store the boolean value in `last_tested_boolean'.
			-- Otherwise fire an error with error message given by `a_error_message'.
		require
			a_boolean_str_attached: a_boolean_str /= Void
			a_error_message_attached: a_error_message /= Void
		do
			if a_boolean_str.is_boolean then
				last_tested_boolean := a_boolean_str.to_boolean
			else
				create_last_error (a_error_message)
			end
		ensure
			last_tested_boolean_set: a_boolean_str.is_boolean implies last_tested_boolean = a_boolean_str.to_boolean
		end

	test_non_void_double_attribute (a_double_str: STRING; a_error_message_agent: FUNCTION [ANY, TUPLE [STRING_GENERAL], STRING_GENERAL])
			-- Test if `a_double_str' represents a valid double value. If so, store the boolean value in `last_tested_double'.
			-- Otherwise fire an error with error message given by `a_error_message_agent'.
		require
			a_double_str_attached: a_double_str /= Void
			a_error_message_agent_attached: a_error_message_agent /= Void
		do
			if a_double_str.is_double then
				last_tested_double := a_double_str.to_double
			else
				create_last_error (a_error_message_agent.item ([a_double_str]))
			end
		ensure
			last_tested_double_set: a_double_str.is_double implies last_tested_double = a_double_str.to_double
		end

	test_integer_attribute (a_integer_str: STRING; a_missing_error_message: STRING_GENERAL; a_invalid_error_message_agent: FUNCTION [ANY, TUPLE [STRING_GENERAL], STRING_GENERAL])
			-- Test if `a_integer_str' represents a valid integer value. If so, store the integer value in `last_tested_integer'.
			-- Otherwise if `a_integer_str' is Void, fire an error with error message returned by `a_missing_error_message_agent',
			-- if `a_integer_str' is non-Void but is not a valid integer, fire an error with error message given by `a_invalid_error_message'.
		require
			a_missing_error_message_attached: a_missing_error_message /= Void
			a_error_message_agent_attached: a_invalid_error_message_agent /= Void
		do
			if a_integer_str = Void then
				create_last_error (a_missing_error_message)
			else
				test_non_void_integer_attribute (a_integer_str, a_invalid_error_message_agent.item ([a_integer_str]))
			end
		end

	test_non_void_integer_attribute (a_integer_str: STRING; a_error_message: STRING_GENERAL)
			-- Test if `a_integer_str' represents a valid integer value. If so, store the integer value in `last_integer_boolean'.
			-- Otherwise fire an error with error message given by `a_error_message'.
		require
			a_integer_str_attached: a_integer_str /= Void
			a_error_message_attached: a_error_message /= Void
		do
			if a_integer_str.is_integer then
				last_tested_integer := a_integer_str.to_integer
			else
				create_last_error (a_error_message)
			end
		ensure
			last_tested_integer_set: a_integer_str.is_integer implies last_tested_integer = a_integer_str.to_integer
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
