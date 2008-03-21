indexing
	description: "[
		Visitor for processing code tokens.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CODE_TOKEN_VISITOR_I

inherit
	USABLE_I

feature {CODE_TOKEN} -- Processing

	process_code_token_cursor (a_value: !CODE_TOKEN_CURSOR)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_token_eol (a_value: !CODE_TOKEN_EOL)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_token_id (a_value: !CODE_TOKEN_ID)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_token_id_ref (a_value: !CODE_TOKEN_ID_REF)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_token_text (a_value: !CODE_TOKEN_TEXT)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

feature {CODE_TOKEN} -- Query

	is_applicable_visitation_entity (a_value: !ANY): BOOLEAN
			-- Determines if object instance `a_value' is applicable for a visitation
		do
			Result := True
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
