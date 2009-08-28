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

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
