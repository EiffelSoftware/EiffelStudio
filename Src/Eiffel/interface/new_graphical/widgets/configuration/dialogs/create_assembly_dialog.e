indexing
	description: "Dialog to create a new assembly."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_ASSEMBLY_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

	CONF_ACCESS
		undefine
			copy,
			default_create
		end

	EB_LAYOUT_CONSTANTS
		undefine
			copy,
			default_create
		end

	PROPERTY_GRID_LAYOUT
		undefine
			copy,
			default_create
		end

	CONF_INTERFACE_NAMES
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

	make (a_target: CONF_TARGET; a_factory: CONF_FACTORY) is
			-- Create.
		require
			a_target_not_void: a_target /= Void
			a_factory_not_void: a_factory /= Void
		do
			target := a_target
			factory := a_factory
			default_create
			set_title (dialog_create_assembly_title)
		ensure
			target_set: target = a_target
			factory_set: factory = a_factory
		end

	initialize is
			-- Initialize.
		local
			l_btn: EV_BUTTON
			vb, vb2: EV_VERTICAL_BOX
			hb, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
			l_il_env: IL_ENVIRONMENT
			l_alb: SYSTEM_ASSEMBLY_LIST_BUILDER
			l_assemblies: LIST  [STRING]
			l_item: EV_LIST_ITEM
			l_path, l_name: STRING
			i, j, cnt: INTEGER
		do
			Precursor {EV_DIALOG}

			create vb
			extend (vb)
			vb.set_padding (default_padding_size)
			vb.set_border_width (default_border_size)

				-- assemblies found in default locations
			create vb2
			vb.extend (vb2)
			vb2.set_padding (small_padding_size)
			vb2.set_border_width (small_border_size)

			create l_lbl.make_with_text (dialog_create_assembly_found)
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
			create l_alb.make (l_il_env.dotnet_framework_path, l_il_env.version)
			from
				l_assemblies := l_alb.assemblies
				l_assemblies.start
			until
				l_assemblies.after
			loop
				l_path := l_assemblies.item
				cnt := l_path.count
				i := l_path.last_index_of (operating_environment.directory_separator, cnt)
				j := l_path.last_index_of ('.', cnt)
				if i > 0 and j > 0 then
					l_name := l_path.substring (i+1, j-1)
				else
					l_name := l_path
				end
				create l_item.make_with_text (l_name)
				l_item.select_actions.extend (agent fill_assembly (l_name, l_path))
				assemblies.extend (l_item)
				l_assemblies.forth
			end

				-- name
			create vb2
			vb.extend (vb2)
			vb2.set_padding (small_padding_size)
			vb2.set_border_width (small_border_size)

			create l_lbl.make_with_text (dialog_create_assembly_name)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create name
			vb2.extend (name)
			vb2.disable_item_expand (name)

				-- location
			create vb2
			vb.extend (vb2)
			vb2.set_padding (small_padding_size)
			vb2.set_border_width (small_border_size)

			create l_lbl.make_with_text (dialog_create_assembly_location)
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
			l_btn.set_minimum_width (default_button_width)

			create l_btn.make_with_text (ev_cancel)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_cancel_button (l_btn)
			l_btn.select_actions.extend (agent on_cancel)
			l_btn.set_minimum_width (default_button_width)

			set_minimum_width (300)

			show_actions.extend (agent name.set_focus)
		end

feature -- Status

	is_ok: BOOLEAN
			-- Was the dialog closed with ok?

feature -- Access

	last_assembly: CONF_ASSEMBLY
			-- Last added assembly.

feature {NONE} -- GUI elements

	assemblies: EV_LIST
			-- Assemblies found in default locations.

	name: EV_TEXT_FIELD
			-- Name of the group.

	location: EV_TEXT_FIELD
			-- Location of the assembly (for local assemblies).

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
		do
			name.set_text (a_name)

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

			browse_dialog.open_actions.extend (agent set_location)
			browse_dialog.show_modal_to_window (Current)
		end

	set_location is
			-- Set location from `browse_dialog'.
		do
			location.set_text (browse_dialog.file_name)
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

				if target.groups.has (name.text) then
					create wd.make_with_text (group_already_exists (name.text))
				elseif l_local.is_empty then
					create wd.make_with_text (assembly_no_location)
				else
					last_assembly := factory.new_assembly (name.text, location.text, target)
					target.add_assembly (last_assembly)
				end

				if wd /= Void then
					wd.show_modal_to_window (Current)
				else
					is_ok := True
					destroy
				end
			end
		ensure
			is_ok_last_assembly: is_ok implies last_assembly /= Void
		end

feature {NONE} -- Implementation

	target: CONF_TARGET
			-- Target where we add the group.

	factory: CONF_FACTORY
			-- Factory to create a group.

invariant
	target_not_void: target /= Void
	factory_not_void: factory /= Void

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
