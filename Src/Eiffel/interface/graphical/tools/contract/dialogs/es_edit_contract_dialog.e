indexing
	description: "[
		A dialog used to edit an existing contract in the contract tool {ES_CONTRACT_TOOL}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_EDIT_CONTRACT_DIALOG

inherit
	ES_ADD_CONTRACT_DIALOG
		redefine
			icon,
			title
		end

create
	make

feature -- Element change

	set_contract (a_tag: !STRING_GENERAL; a_contract: !STRING_GENERAL)
			-- Set the contract text.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_a_tag_is_empty: not a_tag.is_empty
			not_a_contract_is_empty: not a_contract.is_empty
		do
			tag_text.set_text (({!STRING_32}) #? a_tag.as_string_32)
			contract_editor.load_text (a_contract.as_string_8)
		ensure
			--tag_text_set: a_tag.is_equal (tag_text.text.as_string_8)
			--contract_editor_text_set: contract_editor.text.is_equal (a_contract)
		end

feature -- Dialog access

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		once
			Result := stock_pixmaps.tool_contract_editor_icon_buffer
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := "Edit Contract"
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
