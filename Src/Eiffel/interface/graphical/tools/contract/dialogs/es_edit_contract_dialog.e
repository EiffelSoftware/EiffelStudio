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
			on_after_initialized,
			internal_recycle,
			icon,
			title,
			on_ok
		end

	ES_MODIFIABLE
		redefine
			internal_recycle
		end

create
	make

feature {NONE} -- Initialization

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			set_is_dirty (False)
		ensure then
			not_is_dirty: not is_dirty
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			Precursor {ES_ADD_CONTRACT_DIALOG}
			Precursor {ES_MODIFIABLE}
		end

feature -- Element change

	set_contract (a_tag: !STRING_GENERAL; a_contract: !STRING_GENERAL)
			-- Set the contract text.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_a_contract_is_empty: not a_contract.is_empty
		do
			tag_text.set_text (a_tag.as_string_32.as_attached)
			contract_editor.load_text (a_contract.as_string_8)
			set_is_dirty (False)
		ensure
			not_is_dirty: not is_dirty
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

feature {NONE} -- Action handler

	on_ok
			-- <Precursor>
		do
			Precursor
			set_is_dirty (True)
		ensure then
			is_dirty: is_dirty
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
