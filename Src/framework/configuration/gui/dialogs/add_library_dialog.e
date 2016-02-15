note
	description: "Dialog to add a library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ADD_LIBRARY_DIALOG

inherit
	ADD_GROUP_DIALOG
		redefine
			initialize,
			last_group
		end

	CONF_ACCESS
		undefine
			copy,
			default_create
		end

	PROPERTY_GRID_LAYOUT
		undefine
			copy,
			default_create
		end

	CONF_VALIDITY
		undefine
			copy,
			default_create
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			copy
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- Initialize.
		local
			l_btn: EV_BUTTON
			main, vb, vb2, l_padding: EV_VERTICAL_BOX
			hb, hbf, hb1, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
			l_filter: like filter
			l_clear_filter_button: EV_BUTTON
			l_update_index_button: EV_BUTTON
			nb: EV_NOTEBOOK
			libs_tab: detachable EV_NOTEBOOK_TAB
			iron_box: IRON_PACKAGE_COLLECTION_BOX
		do
			Precursor

			set_title (conf_interface_names.dialog_create_library_title)
			set_icon_pixmap (conf_pixmaps.new_library_icon)

				-- notebook
			create nb
			extend (nb)

				-- libraries		
			create main
			main.set_padding (layout_constants.default_padding_size)
			main.set_border_width (layout_constants.default_border_size)

			nb.extend (main)

			if nb.has (main) then
				libs_tab := nb.item_tab (main)
				nb.item_tab (main).set_text (conf_interface_names.dialog_create_libraries)
			end

			create vb
			main.extend (vb)

				-- default libraries
			create vb2
			vb.extend (vb2)

			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create hb1
			hb1.set_padding (layout_constants.small_padding_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_defaults)
			l_lbl.align_text_left
			hb1.extend (l_lbl)
			hb1.disable_item_expand (l_lbl)

			hb1.extend (create {EV_CELL})
			create hbf
			hb1.extend (hbf)

			hbf.extend (create {EV_LABEL}.make_with_text (Names.l_filter))
			hbf.disable_item_expand (hbf.last)
			create l_filter
			filter := l_filter
			hbf.extend (l_filter)
			l_filter.change_actions.extend (agent request_update_filter)

			create l_clear_filter_button
			l_clear_filter_button.select_actions.extend (agent l_filter.remove_text)
			l_clear_filter_button.set_pixmap (conf_pixmaps.general_remove_icon)
			l_clear_filter_button.set_tooltip (names.b_reset)
			hbf.extend (l_clear_filter_button)
			hbf.disable_item_expand (l_clear_filter_button)


			vb2.extend (hb1)
			vb2.disable_item_expand (hb1)

				-- Create grid
			create libraries_box.make (target)
			libraries_box.set_minimum_size (400, 200)
			libraries_box.on_library_selected_actions.extend (agent on_library_selected)

				-- Create border for the grid
			create l_padding
			l_padding.set_border_width (1)
			l_padding.set_background_color ((create {EV_STOCK_COLORS}).color_3d_shadow)
			l_padding.extend (libraries_box.widget)

			vb2.extend (l_padding)

				-- Libraries cache update
			create hb1
			hb1.set_padding (layout_constants.small_padding_size)
			vb2.extend (hb1)
			vb2.disable_item_expand (hb1)

			hb1.extend (create {EV_CELL})

			create l_update_index_button
			l_update_index_button.select_actions.extend (agent update_index)
			l_update_index_button.set_text (conf_interface_names.dialog_create_refresh)
			l_update_index_button.set_tooltip (conf_interface_names.dialog_create_refresh_tooltip)
			l_update_index_button.enable_sensitive
			hb1.extend (l_update_index_button)
			hb1.disable_item_expand (l_update_index_button)
			libraries_update_button := l_update_index_button

			create l_btn
			l_btn.set_pixmap (conf_pixmaps.project_settings_advanced_icon)
			l_btn.select_actions.extend (agent popup_configuration_information)
			l_btn.set_tooltip (conf_interface_names.dialog_display_configuration_tooltip)
			hb1.extend (l_btn)
			hb1.disable_item_expand (l_btn)

				-- name
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_name)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create name
			vb2.extend (name)
			vb2.disable_item_expand (name)

				-- location
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_location)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create hb2
			vb2.extend (hb2)
			vb2.disable_item_expand (hb2)
			hb2.set_padding (layout_constants.small_padding_size)

			create location
			hb2.extend (location)

			create l_btn.make_with_text_and_action (conf_interface_names.browse, agent browse)
			l_btn.set_pixmap (conf_pixmaps.general_open_icon)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

			-----------------
			--| [Ok] [Cancel]
			create hb
			main.extend (hb)
			main.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			hb.set_padding (layout_constants.default_padding_size)

			create l_btn.make_with_text (names.b_ok)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_push_button (l_btn)
			l_btn.select_actions.extend (agent on_ok)
			layout_constants.set_default_width_for_button (l_btn)

			create l_btn.make_with_text (names.b_cancel)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_cancel_button (l_btn)
			l_btn.select_actions.extend (agent on_cancel)
			layout_constants.set_default_width_for_button (l_btn)

				-- end of notebook tab #1 : Standard libraries
				-- notebook tab #2: Iron

				-- libraries		
			create main
			main.set_padding (layout_constants.default_padding_size)
			main.set_border_width (layout_constants.default_border_size)

			create vb2
			main.extend (vb2)

			nb.extend (main)
			if
				nb.has (main) and then
				attached nb.item_tab (main) as iron_tab
			then
				iron_tab.set_text (conf_interface_names.dialog_create_iron_packages)
				create iron_box.make (target)
					--| Whenever an operation is made on iron packages via the current EiffelStudio's dialog
					--| `on_iron_packages_changed' will be executed.
				iron_box.on_iron_packages_changed_actions.extend (agent on_iron_packages_changed)
				vb2.extend (iron_box.widget)

				-----------------
				--| [Back to libraries]
				create hb
				main.extend (hb)
				main.disable_item_expand (hb)
				hb.extend (create {EV_CELL})
				hb.set_padding (layout_constants.default_padding_size)

				create l_btn.make_with_text (conf_interface_names.dialog_create_back_to_previous_tab)
				hb.extend (l_btn)
				hb.disable_item_expand (l_btn)
				if libs_tab /= Void then
					l_btn.select_actions.extend (agent libs_tab.enable_select)
				else
					l_btn.select_actions.extend (agent nb.select_item (nb.first))
				end
				layout_constants.set_default_width_for_button (l_btn)

				nb.selection_actions.extend (agent (ia_libs, ia_nb: detachable EV_NOTEBOOK_TAB; ia_iron_box: IRON_PACKAGE_COLLECTION_BOX)
						do
							if ia_nb /= Void and then ia_nb.is_selected then
									--| the "IRON Packages" tab is selected
									--| then populate the associated grid to display iron packages
								ev_application.add_idle_action_kamikaze (agent ia_iron_box.populate)
							elseif ia_libs /= Void and then ia_libs.is_selected then
									--| the "Libraries" tab is selected
								if repopulate_requested then
										--| a command requested the re-population of the libraries grid
										--| most likely due to recent IRON changes from the related dialog
										--| that resetted the cache of iron libraries data.
									ev_application.add_idle_action_kamikaze (agent populate_libraries)
								end
							end
						end (libs_tab, iron_tab, iron_box)
					)
			end

				-- Initial Event
			show_actions.extend_kamikaze (agent
				do
					populate_libraries
					libraries_box.set_focus
				end)
		end

feature {NONE} -- Update filter

	update_filter_timeout: detachable EV_TIMEOUT

	request_update_filter
		local
			l_update_filter_timeout: like update_filter_timeout
		do
			cancel_delayed_update_filter
			l_update_filter_timeout := update_filter_timeout
			if l_update_filter_timeout = Void then
				create l_update_filter_timeout
				update_filter_timeout := l_update_filter_timeout
				l_update_filter_timeout.actions.extend_kamikaze (agent delayed_update_filter)
			end
			l_update_filter_timeout.set_interval (700)
		end

	cancel_delayed_update_filter
		do
			if attached update_filter_timeout as l_update_filter_timeout then
				l_update_filter_timeout.destroy
				update_filter_timeout := Void
			end
		end

	delayed_update_filter
		do
			cancel_delayed_update_filter
			update_filter
		end

	update_filter
		local
			l_style: EV_POINTER_STYLE
		do
			l_style := pointer_style
			set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor))

			-- FIXME: filter libs!
--			libraries_box.set_filter_text (filter_text)
			libraries_box.set_configuration_libraries (all_libraries (filter_text))
			libraries_box.update_grid

			set_pointer_style (l_style)
		end

feature {NONE} -- GUI elements

	libraries_box: EIFFEL_LIBRARY_COLLECTION_BOX
			-- Libraries collection box.

	filter: EV_TEXT_FIELD
			-- Filter.

	filter_text: detachable STRING_32
			-- Filter text.
		do
			Result := filter.text
		end

	name: EV_TEXT_FIELD
			-- Name of the library.

	location: EV_TEXT_FIELD
			-- Location of the library configuration file, choosen by the user.

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

	libraries_update_button: EV_BUTTON
			-- Update libraries cache.

feature -- Access

	last_group: CONF_LIBRARY
			-- Last created group.

feature {NONE} -- Callback

	on_iron_packages_changed (a_package: detachable IRON_PACKAGE)
			-- Called when the iron packages are changed from the IRON_PACKAGE_COLLECTION_BOX.
		do
			reset_iron_configuration_libraries (target)
			if not repopulate_requested then
				repopulate_requested := True
			end
		end

	repopulate_requested: BOOLEAN
			-- Any pending request to call `populate_libraries'?

feature {NONE} -- Libraries cache.

	update_index
		do
			reset_iron_configuration_libraries (target)
			reset_configuration_libraries (target)
			populate_libraries
		end

feature {NONE} -- Configuration settings for libraries

	popup_configuration_information
			-- Popup information related to library dialog configuration.
		local
			dlg: EV_DIALOG
			p1, p2: PATH
			us1, us2: detachable READABLE_STRING_GENERAL
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			t: EV_TEXT
			l_close_button: EV_BUTTON
		do
			p1 := eiffel_layout.libraries_config_name
			if eiffel_layout.is_user_files_supported then
				us1 := eiffel_layout.user_priority_file_name (p1, False).name
			end
			p2 := eiffel_layout.precompiles_config_name
			if eiffel_layout.is_user_files_supported then
				us2 := eiffel_layout.user_priority_file_name (p2, False).name
			end

			create dlg
			dlg.set_title (conf_interface_names.dialog_display_configuration_title)
			create vb
			vb.set_border_width (Layout_constants.Default_border_size)
			vb.set_padding (Layout_constants.Default_padding_size)

			create t.make_with_text (conf_interface_names.dialog_display_configuration_text (p1.name, us1, p2.name, us2 , eiffel_layout.is_user_files_supported))
			t.disable_edit
			t.set_background_color ((create {EV_STOCK_COLORS}).white)
			t.set_minimum_size (500, 200)
			vb.extend (t)
			create hb
			create l_close_button.make_with_text (conf_interface_names.general_close)
			l_close_button.select_actions.extend (agent dlg.destroy)
			hb.set_padding (Layout_constants.Default_padding_size)
			dlg.set_icon_pixmap (Default_pixmaps.Information_pixmap)

			hb.extend (create {EV_CELL})
			hb.extend (l_close_button)
			hb.disable_item_expand (l_close_button)
			hb.extend (create {EV_CELL})
			vb.extend (hb)
			vb.disable_item_expand (hb)
			dlg.extend (vb)

			dlg.show_modal_to_window (Current)
		end

feature {NONE} -- Access

	libraries_manager: ES_LIBRARY_MANAGER
		once
			create Result.make (2)
			Result.register (create {ES_LIBRARY_DELIVERY_PROVIDER})
			Result.register (create {ES_LIBRARY_IRON_PROVIDER})
		end

	reset_configuration_libraries (a_target: CONF_TARGET)
		do
			libraries_manager.reset_provider ({ES_LIBRARY_DELIVERY_PROVIDER}.identifier, a_target)
		end

	reset_iron_configuration_libraries (a_target: CONF_TARGET)
		do
			libraries_manager.reset_provider ({ES_LIBRARY_IRON_PROVIDER}.identifier, a_target)
		end

feature {NONE} -- Actions

	browse
			-- Browse for a location.
		local
			l_loc: CONF_FILE_LOCATION
			l_dir: DIRECTORY
			l_cfg_data: CONF_SYSTEM_VIEW
		do
			if not location.text.is_empty then
				create l_loc.make (location.text, target)
				create l_dir.make_with_path (l_loc.evaluated_directory)
			end
			if l_dir /= Void and then l_dir.exists then
				browse_dialog.set_start_path (l_dir.path)
			end

			browse_dialog.show_modal_to_window (Current)
			if attached browse_dialog.file_name as l_fn and then not l_fn.is_empty then
				create l_cfg_data.make_from_path (create {PATH}.make_from_string (l_fn))
				if l_cfg_data.has_library_target then
					if
						attached l_cfg_data.conf_option as l_options and then
						l_options.is_void_safety_sufficient (target.options)
					then
						on_library_selected (l_cfg_data, l_fn)
					else
						prompts.show_question_prompt (conf_interface_names.add_non_void_safe_library, Current, agent on_library_selected (l_cfg_data, l_fn), Void)
					end
				else
					prompts.show_error_prompt (conf_interface_names.file_is_not_a_library, Current, Void)
				end
			end
		end

feature {NONE} -- Action handlers

	on_library_selected (a_library: CONF_SYSTEM_VIEW; a_location: READABLE_STRING_GENERAL)
			-- Called when a library is selected
		require
			is_library_target: a_library.has_library_target
		do
			name.set_text (a_library.library_target_name)
			location.set_text (a_location)
		end

	on_ok
			-- Add library and close the dialog.
		local
			l_sys: CONF_SYSTEM
		do
				-- library choosen?
			if not location.text.is_empty and not name.text.is_empty then
				if not is_valid_group_name (name.text) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.invalid_library_name, Current, Void)
				elseif group_exists (name.text, target) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.group_already_exists (name.text), Current, Void)
				else
					last_group := factory.new_library (name.text, location.text, target)
						-- add an empty classes list that it get's displayed in the classes tree
					last_group.set_classes (create {STRING_TABLE [CONF_CLASS]}.make (0))
					l_sys := factory.new_system_generate_uuid_with_file_name ("dummy_location", "dummy")
					l_sys.set_application_target (target)
					last_group.set_library_target (factory.new_target ("dummy", l_sys))
					target.add_library (last_group)
					is_ok := True
					destroy
				end
			end
		ensure
			is_ok_last_library: is_ok implies last_group /= Void
		end

	on_cancel
			-- Close the dialog.
		do
			destroy
		end

feature {NONE} -- Basic operation

	all_libraries (a_filter: detachable READABLE_STRING_GENERAL): STRING_TABLE [CONF_SYSTEM_VIEW]
		do
			if a_filter /= Void then
				Result := libraries_manager.filtered_libraries (a_filter, target, Void)
			else
				Result := libraries_manager.libraries (target, Void)
			end
		end

	populate_libraries
			-- Populates the list of libraries in the UI
		local
			l_style: detachable EV_POINTER_STYLE
			libs_box: like libraries_box
			retried: BOOLEAN
			popup: detachable EV_POPUP_WINDOW
			bb,vb: EV_VERTICAL_BOX
		do
			repopulate_requested := False
			if not retried then
				l_style := pointer_style
				set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor))
				create popup.make_with_shadow
				create bb
				bb.set_border_width (1)
				create vb
				bb.extend (vb)
				vb.set_border_width (3 * layout_constants.default_border_size)
				vb.extend (create {EV_LABEL}.make_with_text (conf_interface_names.dialog_create_searching_please_wait_message))

				popup.extend (bb)
				popup.set_background_color ((create {EV_STOCK_COLORS}).white)
				popup.propagate_background_color
				bb.set_background_color ((create {EV_STOCK_COLORS}).blue)
				popup.set_position (x_position + (width - popup.width) // 2, y_position + (height - popup.height) // 2)
				popup.show_relative_to_window (Current)
				popup.refresh_now

				libs_box := libraries_box
				libs_box.set_configuration_libraries (all_libraries (filter_text))
--				libs_box.set_filter_text (filter_text)
				libs_box.update_grid
			end
			if popup /= Void then
				popup.destroy
			end

			if l_style /= Void then
				set_pointer_style (l_style)
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Constants

	name_column: INTEGER = 1
			-- Index of a column with a library name.

	void_safety_column: INTEGER = 2
			-- Index of a column with void-safety status.

	location_column: INTEGER = 3
			-- Index of a column with a library location.

invariant
	target_set_in_boxes: libraries_box.target = target

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
