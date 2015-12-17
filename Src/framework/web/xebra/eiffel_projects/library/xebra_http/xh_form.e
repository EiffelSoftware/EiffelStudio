note
	description: "[
		{XH_FORM}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_FORM

create
	make

feature -- Initialization

	make
			-- Initilizator
		do
		end

feature	-- Basic Functionality

	is_valid: BOOLEAN
			-- Are all of the form values valid?
		do
			-- FIXME: Validate correctly with all the validators
			Result := True
		end

	get_real_bean: ANY
			-- Returns the "real world" bean with the values set from the form
			-- Executes all the setter agents
		do
			-- FIXME: Return the real object with all its values set
			Result := "ERROR"
		ensure
			result_attached: attached Result
		end

	update_validation_errors (a_validation_errors: HASH_TABLE [LIST [STRING], STRING])
			-- Fills the table with errors from the validation
			-- `a_validation_table': Mapping between field and validation errors
		require
			a_validation_errors_attached: attached a_validation_errors
		do
			-- FIXME TODO
		end

--	add_validator (a_key: STRING; a_validator: XWA_VALIDATOR)
--			-- Adds a validator to the list of validators for a specific key
--		require
--			a_key_valid: attached a_key and then not a_key.is_empty
--			a_validator_attached: attached a_validator
--		do
--			-- FIXME TODO
--		end

	add_attribute_setter (a_key: STRING; a_setter: PROCEDURE [ANY])
			-- Sets the bean attribute setter for a specific key
		require
			a_key_valid: attached a_key and then not a_key.is_empty
			a_setter_attached: attached a_setter
		do
			-- FIXME TODO
		end

	retrieve (a_key: STRING): STRING
			-- Retrieves the value for a certain key
		require
			a_key_valid: attached a_key and then not a_key.is_empty
		do
			-- FIXME TODO
			Result := "NOT IMPLEMENTED"
		ensure
			result_attached: attached Result
		end
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
