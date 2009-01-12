indexing
	description: "[
			Tool which convert old eweasel codes to new (6.3 testing tool) eweasel Eiffel classes test cases
																							]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_CONVERSION_TOOL_PANEL

inherit
	EB_TOOL

	EC_EIFFEL_LAYOUT

create
	make

feature {NONE} -- Initialization

	is_recycled_on_closing: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

	widget: EV_HORIZONTAL_BOX
			-- <Precursor>

	build_interface
			-- Create ui
		local
			l_ver_box: EV_VERTICAL_BOX
			l_hor_box: EV_HORIZONTAL_BOX
		do
			create widget

			create l_ver_box
			l_ver_box.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			l_ver_box.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			widget.extend (l_ver_box)
			widget.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			widget.disable_item_expand (l_ver_box)

			-- Source part
			create l_hor_box
			l_hor_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			l_ver_box.extend (l_hor_box)
			l_ver_box.disable_item_expand (l_hor_box)

			create source_button.make_with_text ("Select source folder")
			l_hor_box.extend (source_button)
			l_hor_box.disable_item_expand (source_button)
			source_button.select_actions.extend (agent on_select_source_folder)

			create source_label.make_with_text (eweasel_source_path)
			l_hor_box.extend (source_label)


			-- Desination part
			create l_hor_box
			l_hor_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			l_ver_box.extend (l_hor_box)
			l_ver_box.disable_item_expand (l_hor_box)

			create destination_button.make_with_text ("Select destination folder")
			l_hor_box.extend (destination_button)
			l_hor_box.disable_item_expand (destination_button)
			destination_button.select_actions.extend (agent on_select_dest_folder)

			create destination_label.make_with_text ("Please select")
			l_hor_box.extend (destination_label)

			-- Start convert button
			create l_hor_box
			l_hor_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			l_ver_box.extend (l_hor_box)
			l_ver_box.disable_item_expand (l_hor_box)

			create start_convert_button.make_with_text ("Start convert")
			l_hor_box.extend (start_convert_button)
			l_hor_box.disable_item_expand (start_convert_button)
			start_convert_button.select_actions.extend (agent on_start_convert)
			start_convert_button.disable_sensitive
		end

eweasel_source_path: DIRECTORY_NAME
		-- Try to find eweasel test cases path if $EWEASEL has been set
	local
		l_eweasel: STRING
	do
		l_eweasel := get_environment ("EWEASEL")
		if l_eweasel = Void then
			l_eweasel := "$EWEASEL"
		end

		create Result.make_from_string (l_eweasel)
		Result.extend ("tests")
	ensure
		not_void: Result /= Void
	end

feature {NONE} -- View implementation

	show_on_active_window (a_dialog: EV_DIRECTORY_DIALOG)
			-- Attempts to show `a_dialog' parented to the last active window.
		require
			is_interface_usable: is_interface_usable
		local
			l_dev_window: like develop_window
			l_window: EV_WINDOW
		do
			l_window := helpers.parent_window_of_focused_widget
			if l_window = Void then
				l_dev_window := develop_window
				if l_dev_window /= Void then
					l_window := l_dev_window.window
				end
			end

			if l_window /= Void then
				a_dialog.show_modal_to_window (l_window)
			end
		end

	frozen helpers: !EVS_HELPERS
			-- Helpers to extend the operations of EiffelVision2
		once
			create Result
		end

	destination_button: EV_BUTTON
			-- Destination select button

	destination_label: EV_LABEL
			-- Destination label

	source_button: EV_BUTTON
			-- Test case source button

	source_label: EV_LABEL
			-- Source label

	start_convert_button: EV_BUTTON
			-- Start convert button

	on_select_source_folder
			-- Handle action when select source folder
		local
			l_dir_chooser: EV_DIRECTORY_DIALOG
			l_dir: STRING_32
		do
			create l_dir_chooser.make_with_title ("Select source folder")
			show_on_active_window (l_dir_chooser)

			l_dir := l_dir_chooser.directory
			if l_dir /= Void and not l_dir.is_empty then
				source_label.set_text (l_dir)
			end

			update_sensitive
		end

	on_select_dest_folder
			-- Handle action when select destination folder
		local
			l_dir_chooser: EV_DIRECTORY_DIALOG
			l_dir: STRING_32
		do
			create l_dir_chooser.make_with_title ("Select destination folder")
			show_on_active_window (l_dir_chooser)

			l_dir := l_dir_chooser.directory
			if l_dir /= Void and not l_dir.is_empty then
				destination_label.set_text (l_dir)
			end

			update_sensitive
		end

	update_sensitive
			-- Update button sensitivity
		do
			if is_ready_convert then
				start_convert_button.enable_sensitive
			else
				start_convert_button.disable_sensitive
			end
		end

feature {NONE} -- Model Implementation

	on_start_convert
			-- Start convertion
		require
			ready: is_ready_convert
		do
			convert_test_cases_in (source_test_case_dir)
		end

	convert_test_cases_in (a_top_source_dir: DIRECTORY_NAME)
			-- Convert all test cases in `a_top_source_dir'
		require
			a_dir_not_void: a_top_source_dir /= Void
		local
--			l_setup: EW_EQA_WINDOWS_SETUP
		do
--			create l_setup.make
--			l_setup.setup
--			l_setup.convert_all_tcf_in (a_top_source_dir, dest_test_case_dir, "test")
		end

feature -- Query

	is_ready_convert: BOOLEAN
			-- If current ready for eweasel test case conversion
		local
			l_source_dir, l_dest_dir: DIRECTORY_NAME
			l_dir: DIRECTORY
		do
			l_source_dir := source_test_case_dir
			l_dest_dir := dest_test_case_dir
			Result := l_source_dir /= Void and then not l_source_dir.is_empty and then l_source_dir.is_valid
				and then l_dest_dir /= Void and then not l_dest_dir.is_empty and then l_dest_dir.is_valid

			if Result then
				create l_dir.make (l_source_dir)
				if l_dir.exists then
					create l_dir.make (l_dest_dir)
					if l_dir.exists then
						Result := True
					else
						Result := False
					end
				else
					Result := False
				end
			end
		end

	catalog_file: FILE_NAME
			-- Catalog file

	source_test_case_dir: DIRECTORY_NAME
			-- Top dir which contain all test cases
		local
			l_text: STRING_32
		do
			l_text := source_label.text
			if l_text /= Void and then not l_text.is_empty then
				create Result.make_from_string (l_text)
			end
		end

	dest_test_case_dir: DIRECTORY_NAME
			-- Top dir which all test cases will be generated
		local
			l_text: STRING_32
		do
			l_text := destination_label.text
			if l_text /= Void and then not l_text.is_empty then
				create Result.make_from_string (l_text)
			end
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
