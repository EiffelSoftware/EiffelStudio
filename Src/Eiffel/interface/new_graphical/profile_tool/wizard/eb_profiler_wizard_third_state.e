note
	description	: "Third state of the profiler wizard (Choose input file)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_THIRD_STATE

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

	EB_PROFILER_WIZARD_SHARED_INFORMATION
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature -- Basic Operation

	build
			-- Build entries.
		local
			profiler_type_box: EV_HORIZONTAL_BOX
			profiler_type_label: EV_LABEL
		do
			create runtime_information_record_textfield.make (Current)
			runtime_information_record_textfield.set_label_string (Interface_names.l_Runtime_information_record)
			runtime_information_record_textfield.enable_file_browse_button (all_files_filter)
			runtime_information_record_textfield.set_starting_directory (information.generation_path)
			runtime_information_record_textfield.generate

			create profiler_type_label.make_with_text (Interface_names.l_Profiler_used)
			profiler_type_label.align_text_left

			create profiler_list
			profiler_list.disable_edit
			fill_profiler_list

			create profiler_type_box
			profiler_type_box.set_padding (Layout_constants.Small_padding_size)
			profiler_type_box.extend (profiler_type_label)
			profiler_type_box.disable_item_expand (profiler_type_label)
			profiler_type_box.extend (profiler_list)

				-- Link
			choice_box.set_padding (Small_padding_size)
			choice_box.extend (runtime_information_record_textfield.widget)
			choice_box.extend (profiler_type_box)

				-- Update controls to reflect `information'
			select_profiler (information.runtime_information_type)
			runtime_information_record_textfield.set_text (information.runtime_information_record.name)
		end

	proceed_with_current_info
		do
			if is_supplied_runtime_information_record_valid then
				proceed_with_new_state (create {EB_PROFILER_WIZARD_FOURTH_STATE}.make (wizard_information))
			else
				proceed_with_new_state (create {EB_PROFILER_WIZARD_RUNTIME_INFO_RECORD_ERROR_STATE}.make (wizard_information))
			end
		end

	update_state_information
			-- Check User Entries
		do
			Precursor

			if not runtime_information_record_textfield.text.is_empty then
				information.set_runtime_information_record (create {PATH}.make_from_string (runtime_information_record_textfield.text))
			end

			information.set_runtime_information_type (profiler_list.text)
		end

feature {NONE} -- Implementation

	display_state_text
		do
			title.set_text (Interface_names.wt_Execution_Profile_Generation)
			subtitle.set_text (Interface_names.ws_Execution_Profile_Generation)
			message.set_text (Interface_names.wb_Execution_Profile_Generation)
		end

	fill_profiler_list
			-- Fill in `profiler_list' with all available profiler configuration files.
			-- Fill `profiler_list' with profilers
			-- for which configuration files could be found
			-- in Eiffel installation directory at "bench/profiler".
		require
			profiler_list_not_void: profiler_list /= Void
		local
			list_string: EV_LIST_ITEM
			u: FILE_UTILITIES
			l_files: LIST [STRING_32]
		do
			l_files := u.file_names (eiffel_layout.profile_path.name)
			from
				l_files.start
			until
				l_files.after
			loop
				create list_string.make_with_text (l_files.item)
				profiler_list.extend (list_string)
				l_files.forth
			end
		end

	select_profiler (a_profiler: STRING)
			-- Select `a_profiler' in the list `profiler_list'.
		require
			profiler_list_not_void: profiler_list /= Void
		local
			an_item: EV_LIST_ITEM
			found: BOOLEAN
		do
			if a_profiler /= Void then
				from
					profiler_list.start
				until
					profiler_list.after or found
				loop
					an_item := profiler_list.item
					if an_item.text.is_equal (a_profiler) then
						an_item.enable_select
						found := True
					end
					profiler_list.forth
				end
			else
				profiler_list.first.enable_select
			end
		end

	is_supplied_runtime_information_record_valid: BOOLEAN
			-- Is the supplied Runtime information record a valid file?
		local
			rtir_file: RAW_FILE
			rtir_path: PATH
		do
			create rtir_path.make_from_string (runtime_information_record_textfield.text)
				-- Check that the filename indicate a valid and readable file
			if not rtir_path.is_empty then
				create rtir_file.make_with_path (rtir_path)
				Result := rtir_file.exists and then rtir_file.is_readable and then
					rtir_path.parent.same_as (information.generation_path)
			end
		end

feature {NONE} -- Vision2 controls

	runtime_information_record_textfield: EB_WIZARD_SMART_TEXT_FIELD
			-- Text field where the Runtime information record is entered.

	profiler_list: EV_COMBO_BOX;
			-- Type of the profiler used to generate the record.

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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

end -- class EB_PROFILER_WIZARD_THIRD_STATE

