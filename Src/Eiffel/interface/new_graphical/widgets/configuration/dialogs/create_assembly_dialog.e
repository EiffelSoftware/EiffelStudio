indexing
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

	EV_LAYOUT_CONSTANTS
		undefine
			copy,
			default_create
		end

	PROPERTY_GRID_LAYOUT
		undefine
			copy,
			default_create
		end

	CONF_INTERFACE_CONSTANTS
		undefine
			default_create,
			copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		local
			l_btn: EV_BUTTON
			vb, vb2: EV_VERTICAL_BOX
			hb, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
			l_il_env: IL_ENVIRONMENT
			l_alb: SYSTEM_ASSEMBLY_LIST_BUILDER
			l_locales: LIST [STRING]
			l_properties: LIST [ASSEMBLY_PROPERTIES]
			l_property: ASSEMBLY_PROPERTIES
			l_item: EV_LIST_ITEM
			l_name: STRING
			l_culture: STRING
			l_key: STRING
		do
			Precursor

			set_title (conf_interface_names.dialog_create_assembly_title)
			set_icon_pixmap (pixmaps.icon_pixmaps.new_reference_icon)

			create vb
			extend (vb)
			vb.set_padding (default_padding_size)
			vb.set_border_width (default_border_size)

				-- assemblies found in default locations
			create vb2
			vb.extend (vb2)
			vb2.set_padding (small_padding_size)
			vb2.set_border_width (small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_assembly_found)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create assemblies
			vb2.extend (assemblies)
			assemblies.set_minimum_height (200)

				-- get clr version
			if target.setting_msil_clr_version.is_empty then
				create l_il_env
			else
				create l_il_env.make (target.setting_msil_clr_version)
			end
			if l_il_env.is_dotnet_installed then
				create l_alb.make (l_il_env.dotnet_framework_path, l_il_env.version)
				from
					l_properties := l_alb.assemblies_properties
					l_properties.start
				until
					l_properties.after
				loop
					l_property := l_properties.item
					create l_name.make (300)
					l_name.append (l_property.name)
					l_name.append (once ", ")
					l_name.append (l_property.version_string)
					if l_property.is_neutral_locale then
						l_culture := once "Neutral"
					else
						l_locales := l_property.locales
						create l_culture.make (5 * l_locales.count)
						from l_locales.start until l_locales.after loop
							l_culture.append (l_locales.item)
							if not l_locales.islast then
								l_culture.append (once " | ")
							end
							l_locales.forth
						end
					end
					l_name.append (once ", ")
					l_name.append (l_culture)
					if l_property.is_signed then
						l_key := l_property.public_key_token_string
					else
						l_key := once "Null"
					end
					l_name.append (once ", ")
					l_name.append (l_key)
					create l_item.make_with_text (l_name)
					l_item.select_actions.extend (agent fill_assembly (l_name, l_property.location))
					l_item.set_pixmap (pixmaps.icon_pixmaps.folder_assembly_icon)
					assemblies.extend (l_item)
					l_properties.forth
				end

				sort_assemblies
			end

				-- name
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_padding (small_padding_size)
			vb2.set_border_width (small_border_size)

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
			vb2.set_padding (small_padding_size)
			vb2.set_border_width (small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_assembly_location)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create hb2
			vb2.extend (hb2)
			vb2.disable_item_expand (hb2)
			hb2.set_padding (small_padding_size)

			create location
			hb2.extend (location)

			create l_btn.make_with_text_and_action (interface_names.b_browse, agent browse)
			l_btn.set_pixmap (pixmaps.icon_pixmaps.general_open_icon)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

				-- ok/cancel
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			hb.set_padding (default_padding_size)

			create l_btn.make_with_text (ev_ok)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_push_button (l_btn)
			l_btn.select_actions.extend (agent on_ok)
			set_default_width_for_button (l_btn)

			create l_btn.make_with_text (ev_cancel)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_cancel_button (l_btn)
			l_btn.select_actions.extend (agent on_cancel)
			set_default_width_for_button (l_btn)

			set_minimum_width (440)

			if not assemblies.is_empty then
				show_actions.extend (agent assemblies.set_focus)
			else
				show_actions.extend (agent name.set_focus)
			end
		end

feature {NONE} -- GUI elements

	assemblies: EV_LIST
			-- Assemblies found in default locations.

	name: EV_TEXT_FIELD
			-- Name of the group.

	location: EV_TEXT_FIELD
			-- Location of the assembly (for local assemblies).

feature -- Access

	last_group: CONF_ASSEMBLY
			-- Last created assembly.

feature {NONE} -- Actions

	fill_assembly (a_name, a_path: STRING) is
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

	browse_dialog: EV_FILE_OPEN_DIALOG is
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

	browse is
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

	fill_fields is
			-- Set location from `browse_dialog'.
		do
			location.set_text (browse_dialog.file_name)
			if name.text.is_empty then
				name.set_text (name_from_location (browse_dialog.file_name))
			end
		end

	on_cancel is
			-- Close the dialog.
		do
			destroy
		end

	on_ok is
			-- Add group and close the dialog.
		local
			l_local: STRING
			wd: EV_WARNING_DIALOG
		do
			if not name.text.is_empty then
				l_local := location.text

				if not is_valid_group_name (name.text) then
					create wd.make_with_text (conf_interface_names.invalid_group_name)
				elseif group_exists (name.text, target) then
					create wd.make_with_text (conf_interface_names.group_already_exists (name.text))
				elseif l_local.is_empty then
					create wd.make_with_text (conf_interface_names.assembly_no_location)
				else
					last_group := factory.new_assembly (name.text, location.text, target)
					last_group.set_classes (create {HASH_TABLE [CONF_CLASS, STRING]}.make (0))
					target.add_assembly (last_group)
				end

				if wd /= Void then
					wd.show_modal_to_window (Current)
				else
					is_ok := True
					destroy
				end
			end
		ensure
			is_ok_last_assembly: is_ok implies last_group /= Void
		end

feature {NONE} -- Implementation

	name_from_location (a_location: STRING): STRING is
			-- Get a name out of `a_directory'.
		require
			a_location_not_void: a_location /= Void
		local
			l_cnt, i, j: INTEGER
		do
			l_cnt := a_location.count
			i := a_location.last_index_of (operating_environment.directory_separator, l_cnt)
			j := a_location.last_index_of ('.', l_cnt)
			if i > 0 and j > 0 then
				Result := a_location.substring (i+1, j-1)
			else
				Result := a_location
			end
		ensure
			Result_not_void: Result /= Void
		end

	sort_assemblies is
			-- Sort `assemblies'.
		require
			assemblies_set: assemblies /= Void
		local
			l_sorted_assemblies: DS_ARRAYED_LIST [EV_LIST_ITEM]
		do
			create l_sorted_assemblies.make (assemblies.count)
			assemblies.do_all (agent l_sorted_assemblies.force_last (?))
			assemblies.wipe_out
			l_sorted_assemblies.sort (create {DS_QUICK_SORTER [EV_LIST_ITEM]}.make (create {AGENT_BASED_EQUALITY_TESTER [EV_LIST_ITEM]}.make (agent (a, b: EV_LIST_ITEM): BOOLEAN
				do
					Result := a.text < b.text
				end)))
			from
				l_sorted_assemblies.start
			until
				l_sorted_assemblies.after
			loop
				assemblies.force (l_sorted_assemblies.item_for_iteration)
				l_sorted_assemblies.forth
			end
		ensure
			assemblies_same: assemblies.count = old assemblies.count
		end

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
end
