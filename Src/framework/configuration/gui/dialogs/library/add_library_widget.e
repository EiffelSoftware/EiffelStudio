note
	description: "Summary description for {ADD_LIBRARY_WIDGET}."
	date: "$Date$"
	revision: "$Revision$"

class
	ADD_LIBRARY_WIDGET

inherit
	CONF_GUI_INTERFACE_CONSTANTS

	EVS_HELPERS

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_target: CONF_TARGET)
			-- Build the name + location + browse button.
		local
			vb2: EV_VERTICAL_BOX
			hb, hb2: EV_HORIZONTAL_BOX
			l_btn: EV_BUTTON
			l_lbl: EV_LABEL
		do
			target := a_target
			create on_ok_actions
			create on_cancel_actions

				-- name
			create vb2
			widget := vb2
			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_name)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create field_name
			vb2.extend (field_name)
			vb2.disable_item_expand (field_name)

				-- location
			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_location)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create hb2
			vb2.extend (hb2)
			vb2.disable_item_expand (hb2)
			hb2.set_padding (layout_constants.small_padding_size)

			create field_location
			hb2.extend (field_location)

			create l_btn.make_with_text_and_action (conf_interface_names.browse, agent browse)
			l_btn.set_pixmap (conf_pixmaps.general_open_icon)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

			-----------------
			--| [Ok] [Cancel]
			create hb
			vb2.extend (hb)
			vb2.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			hb.set_padding (layout_constants.default_padding_size)

			create l_btn.make_with_text (names.l_include)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			l_btn.select_actions.extend (agent on_ok)
			layout_constants.set_default_width_for_button (l_btn)

			create l_btn.make_with_text (names.b_cancel)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			l_btn.select_actions.extend (agent on_cancel)
			layout_constants.set_default_width_for_button (l_btn)
		end

feature -- Actions

	on_ok_actions: ACTION_SEQUENCE [TUPLE [ADD_LIBRARY_WIDGET]]

	on_cancel_actions: ACTION_SEQUENCE [TUPLE]

	on_ok
		do
			on_ok_actions.call ([Current])
		end

	on_cancel
		do
			on_cancel_actions.call
		end

feature -- Access

	target: CONF_TARGET

	widget: EV_WIDGET

	name: STRING_32
			-- Name of the library.
		do
			Result := field_name.text
		end

	location: STRING_32
			-- Location of the library configuration file, choosen by the user..
		do
			Result := field_location.text
		end

feature {NONE} -- Widgets		

	field_name: EV_TEXT_FIELD
			-- Field for the name of the library.

	field_location: EV_TEXT_FIELD
			-- Field for the location of the library configuration file, choosen by the user.

	browse_dialog: EV_FILE_OPEN_DIALOG
			-- Dialog to browse to a library
		local
			l_dir: DIRECTORY
		once
			create Result
			create l_dir.make_with_path (target.system.directory)
			if l_dir.is_readable then
				Result.set_start_path (l_dir.path)
			end
			Result.filters.extend ([config_files_filter, config_files_description])
			Result.filters.extend ([all_files_filter, all_files_description])
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	set_library (cfg: detachable CONF_SYSTEM_VIEW)
		do
			if cfg = Void then
				field_name.remove_text
				field_location.remove_text
			else
				field_name.set_text (cfg.library_target_name)
				field_location.set_text (cfg.original_location)
			end
		end

	set_name (a_name: READABLE_STRING_GENERAL)
		do
			field_name.set_text (a_name)
		end

	set_location (a_location: READABLE_STRING_GENERAL)
		do
			field_location.set_text (a_location)
		end

feature {NONE} -- Actions

	browse
			-- Browse for a location.
		local
			win: detachable EV_WINDOW
			l_loc: CONF_FILE_LOCATION
			l_dir: DIRECTORY
			l_cfg_data: CONF_SYSTEM_VIEW
		do
			win := widget_top_level_window (widget)
			if win /= Void then
				if not field_location.text.is_empty then
					create l_loc.make (field_location.text, target)
					create l_dir.make_with_path (l_loc.evaluated_directory)
				end
				if l_dir /= Void and then l_dir.exists then
					browse_dialog.set_start_path (l_dir.path)
				end

				browse_dialog.show_modal_to_window (win)
				if attached browse_dialog.file_name as l_fn and then not l_fn.is_empty then
					create l_cfg_data.make (create {PATH}.make_from_string (l_fn), l_fn)
					if l_cfg_data.has_library_target then
						if
							attached l_cfg_data.conf_option as l_options and then
							l_options.is_void_safety_sufficient (target.options)
						then
							set_library (l_cfg_data)
						else
							prompts.show_question_prompt (conf_interface_names.add_non_void_safe_library, win, agent set_library (l_cfg_data), Void)
						end
					else
						prompts.show_error_prompt (conf_interface_names.file_is_not_a_library, win, Void)
					end
				end
			end
		end

invariant

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
