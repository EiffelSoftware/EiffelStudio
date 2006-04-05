indexing
	description: "Text box containing file path with corresponding browse button"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FILE_PATH_BOX

inherit
	WIZARD_FILE_PATH_BOX_IMP
		rename
			path_label as text_label,
			path_combo as text_combo
		redefine
			enable_sensitive,
			disable_sensitive
		end

	WIZARD_TEXT_BOX
		rename
			setup as text_box_setup,
			text_processor as path_validator
		undefine
			default_create,
			is_equal,
			copy
		end

feature -- Initialization

	setup (a_label, a_key: STRING; a_path_validator: like path_validator; a_file_extensions: like file_extensions; a_title: like title) is
			-- Initialize instance.
		require
			non_void_label: a_label /= Void
			non_void_key: a_key /= Void
			non_void_file_extensions: a_file_extensions /= Void
			non_void_title: a_title /= Void
		do
			text_box_setup (a_label, a_key, a_path_validator, Void, Void)
			file_extensions := a_file_extensions
			title := a_title
			auto_save := True
		ensure
			label_set: text_label.text.is_equal (a_label)
			key_set: key = a_key
			path_validator_set: path_validator = a_path_validator
			file_extensions_set: file_extensions = a_file_extensions
			title_set: title = a_title
			auto_save: auto_save
		end

feature {NONE} -- Events Handling

	on_browse is
			-- Called by `select_actions' of `path_button'.
			-- Browse for file.
		local
			l_file_dialog: EV_FILE_OPEN_DIALOG
			l_file_name: STRING
		do
			if title /= Void and file_extensions /= Void then
				create l_file_dialog.make_with_title (title)
				l_file_dialog.filters.append (file_extensions)
				l_file_dialog.show_modal_to_window ((create {EV_UTILITIES}).parent_window (Current))
				l_file_name := l_file_dialog.file_name
				if not l_file_name.is_empty then
					text_combo.set_text (l_file_name)
				end
			end
		end

feature -- Basic Operations

	enable_sensitive is
			-- Trigger validation
		do
			Precursor {WIZARD_FILE_PATH_BOX_IMP}
			on_change
		end
		
	disable_sensitive is
			-- Trigger validation
		do
			Precursor {WIZARD_FILE_PATH_BOX_IMP}
			on_change
		end
		
feature {NONE} -- Private Access

	file_extensions: ARRAYED_LIST [TUPLE [STRING, STRING]]
			-- File open dialog file extensions

	title: STRING;
			-- File open dialog title

indexing
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
end -- class WIZARD_FILE_PATH_BOX

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

