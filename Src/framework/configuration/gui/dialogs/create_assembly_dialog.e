note
	description: "Dialog to create a new assembly."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_ASSEMBLY_DIALOG

inherit
	CREATE_GROUP_DIALOG
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

	CONF_GUI_INTERFACE_CONSTANTS
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
			vb, vb2, vb3: EV_VERTICAL_BOX
			hb, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
			l_assemblies: like assemblies
		do
			Precursor

			set_title (conf_interface_names.dialog_create_assembly_title)
			set_icon_pixmap (conf_pixmaps.new_reference_icon)

			create vb
			extend (vb)
			vb.set_padding (layout_constants.default_padding_size)
			vb.set_border_width (layout_constants.default_border_size)

				-- assemblies found in default locations
			create vb2
			vb.extend (vb2)
			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_assembly_found)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create vb3
			vb2.extend (vb3)
			vb3.set_border_width (1)
			vb3.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))

			create l_assemblies
			assemblies := l_assemblies
			vb3.extend (l_assemblies)
			l_assemblies.set_minimum_height (200)
			l_assemblies.set_minimum_width (600)
			l_assemblies.set_column_count_to (6)
			l_assemblies.column (1).set_title (names.l_Name)
			l_assemblies.column (1).set_width (162)
			l_assemblies.column (2).set_title (names.l_Version)
			l_assemblies.column (2).set_width (71)
			l_assemblies.column (3).set_title (names.l_Culture)
			l_assemblies.column (3).set_width (62)
			l_assemblies.column (4).set_title (names.l_Public_key_token)
			l_assemblies.column (4).set_width (105)
			l_assemblies.column (5).set_title (names.l_Platform)
			l_assemblies.column (5).set_width (60)
			l_assemblies.column (6).set_title (names.l_Path)
			l_assemblies.column (6).set_width (122)
			l_assemblies.enable_single_row_selection

				-- name
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_assembly_name)
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

			create l_lbl.make_with_text (conf_interface_names.dialog_create_assembly_location)
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

				-- ok/cancel
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
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

			show_actions.extend (agent
				local
					l_old_style: like pointer_style
				do
					l_old_style := pointer_style
					set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor))

					populate_assemblies

					set_pointer_style (l_old_style)

						-- Set focus based on content display
					if assemblies.row_count > 0 then
						assemblies.set_focus
					else
						name.set_focus
					end
				end)

			set_minimum_width (634)
		end

feature {NONE} -- GUI elements

	assemblies: ES_GRID
			-- Assemblies found in default locations.

	name: EV_TEXT_FIELD
			-- Name of the group.

	location: EV_TEXT_FIELD
			-- Location of the assembly (for local assemblies).

feature -- Access

	last_group: CONF_ASSEMBLY
			-- Last created assembly.

feature {NONE} -- Actions

	populate_assemblies
			-- Populates assembly list
		local
			l_il_env: IL_ENVIRONMENT
			l_alb: SYSTEM_ASSEMBLY_LIST_BUILDER
			l_properties: LIST [ASSEMBLY_PROPERTIES]
			l_property: ASSEMBLY_PROPERTIES
			l_row: EV_GRID_ROW
			l_item: EV_GRID_LABEL_ITEM
			l_value: STRING
			l_assemblies: like assemblies
		do
			l_assemblies := assemblies

				-- get clr version
			if target.setting_msil_clr_version.is_empty then
				create l_il_env
			else
				create l_il_env.make (target.setting_msil_clr_version)
			end
			if l_il_env.is_dotnet_installed then
				create l_alb.make (l_il_env.dotnet_framework_path, l_il_env.version)
				l_properties := l_alb.assemblies_properties
				l_assemblies.set_row_count_to (l_properties.count)
				from
					l_properties.start
				until
					l_properties.after
				loop
					l_property := l_properties.item
					l_row := l_assemblies.row (l_properties.index)

						-- Create row items
					create l_item.make_with_text (l_property.name)
					l_item.set_pixmap (conf_pixmaps.folder_assembly_icon)
					l_row.set_item (1, l_item)
					l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (l_property.version_string))

					if l_property.is_neutral_locale then
						l_value := once "Netural"
					else
						l_value := l_property.locales.first
					end
					l_row.set_item (3, create {EV_GRID_LABEL_ITEM}.make_with_text (l_value))

					if l_property.is_signed then
						l_row.set_item (4, create {EV_GRID_LABEL_ITEM}.make_with_text (l_property.public_key_token_string))
					end

					if l_property.is_msil then
						l_value := once "MSIL"
					elseif l_property.is_x86 then
						l_value := once "x86"
					elseif l_property.is_x64 then
						l_value := once "x64"
					else
						l_value := once "Unknown"
					end
					l_row.set_item (5, create {EV_GRID_LABEL_ITEM}.make_with_text (l_value))
					l_row.set_item (6, create {EV_GRID_LABEL_ITEM}.make_with_text (l_property.location))
					l_row.select_actions.extend (agent fill_assembly (l_property.name, l_property.location))

					l_properties.forth
				end
			end
		end

	fill_assembly (a_name, a_path: STRING)
			-- Fill location and name from `a_path' and `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_path_ok: a_path /= Void and then not a_path.is_empty
			name_ok: name /= Void
			location_ok: location /= Void
		local
			l_il_env: IL_ENVIRONMENT
			l_loc: STRING
			l_parts: LIST [STRING]
		do
			l_parts := a_name.split (',')
			name.set_text (l_parts.first.as_lower)

			if target.setting_msil_clr_version.is_empty then
				create l_il_env
			else
				create l_il_env.make (target.setting_msil_clr_version)
			end
			l_loc := a_path.twin
			l_loc.replace_substring_all (l_il_env.dotnet_framework_path, "$ISE_DOTNET_FRAMEWORK")
			location.set_text (l_loc)
		end

	browse_dialog: EV_FILE_OPEN_DIALOG
			-- Dialog to browse to a library
		local
			l_dir: DIRECTORY
		once
			create Result
			create l_dir.make (target.system.directory)
			if l_dir.exists then
				Result.set_start_directory (l_dir.name)
			end
			Result.filters.extend ([all_assemblies_filter, all_assemblies_description])
			Result.filters.extend ([all_files_filter, all_files_description])
		ensure
			Result_not_void: Result /= Void
		end

	browse
			-- Browse for a location.
		local
			l_loc: CONF_FILE_LOCATION
			l_dir: DIRECTORY
		do
			if not location.text.is_empty then
				create l_loc.make (location.text, target)
				create l_dir.make (l_loc.evaluated_directory)
			end
			if l_dir /= Void and then l_dir.exists then
				browse_dialog.set_start_directory (l_dir.name)
			end

			browse_dialog.open_actions.extend (agent fill_fields)
			browse_dialog.show_modal_to_window (Current)
		end

	fill_fields
			-- Set location from `browse_dialog'.
		local
			l_il_env: IL_ENVIRONMENT
			l_reader: ASSEMBLY_PROPERTIES_READER
			l_properties: ASSEMBLY_PROPERTIES
			l_file_name: STRING
			l_added: BOOLEAN
		do
				-- get clr version
			if target.setting_msil_clr_version.is_empty then
				create l_il_env
			else
				create l_il_env.make (target.setting_msil_clr_version)
			end
			create l_reader.make (l_il_env.version)
			l_file_name := browse_dialog.file_name
			if (create {PE_FILE_INFO}).is_com2_pe_file (l_file_name) then
				l_properties := l_reader.retrieve_assembly_properties (l_file_name)
				l_added := l_properties /= Void
				if l_added then
					name.set_text (l_properties.name)
					location.set_text (l_properties.location)
				end
			end

			if not l_added then
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (warnings.w_file_not_valid_assembly (l_file_name), Current, Void)
			end
		end

	on_cancel
			-- Close the dialog.
		do
			destroy
		end

	on_ok
			-- Add group and close the dialog.
		local
			l_local: STRING
		do
			if not name.text.is_empty then
				l_local := location.text

				if not is_valid_group_name (name.text) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.invalid_assembly_name, Current, Void)
				elseif group_exists (name.text, target) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.group_already_exists (name.text), Current, Void)
				elseif l_local.is_empty then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.assembly_no_location, Current, Void)
				else
					last_group := factory.new_assembly (name.text, location.text, target)
					last_group.set_classes (create {HASH_TABLE [CONF_CLASS, STRING]}.make (0))
					target.add_assembly (last_group)

					is_ok := True
					destroy
				end
			end
		ensure
			is_ok_last_assembly: is_ok implies last_group /= Void
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
end
