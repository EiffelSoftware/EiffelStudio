indexing
	description: "Dialog to add a precompile library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_PRECOMPILE_DIALOG

inherit
	CREATE_LIBRARY_DIALOG
		redefine
			make,
			last_group,
			on_library_selected,
			on_ok,
			lookup_directories
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: CONF_TARGET; a_factory: like factory) is
			-- <Precursor>
		do
			Precursor {CREATE_LIBRARY_DIALOG} (a_target, a_factory)
			set_title (conf_interface_names.dialog_create_precompile_title)
			set_icon_pixmap (conf_pixmaps.new_precompiled_library_icon)
		end

feature -- Access

	last_group: CONF_PRECOMPILE
			-- <Precursor>

feature {NONE} -- Access

	lookup_directories: !DS_ARRAYED_LIST [!TUPLE [path: !STRING; depth: INTEGER]]
			-- A list of lookup directories
		local
			l_file: !FILE_NAME
		do
			create Result.make_default

			l_file := eiffel_layout.precompiles_config_name
			if file_system.file_exists (l_file) then
				add_lookup_directories (l_file, Result)
			end
			if eiffel_layout.is_user_files_supported then
				if {l_user_file: FILE_NAME} eiffel_layout.user_priority_file_name (l_file.string, True) and then file_system.file_exists (l_user_file) then
					add_lookup_directories (l_user_file, Result)
				end
			end

			if Result.is_empty then
					-- Extend the default library path
				Result.force_last ([{!STRING} #? eiffel_layout.precomp_platform_path (target.setting_msil_generation), 0])
			end
		end

feature {NONE} -- Action handlers

	on_library_selected (a_library: !CONF_SYSTEM; a_location: !STRING)
			-- <Precursor>
		do
			name.set_text (a_library.library_target.name + "_precompile")
			location.set_text (a_location)
		end

	on_ok is
			-- <Precursor>
		do
				-- library choosen?
			if not location.text.is_empty and not name.text.is_empty then
				if not is_valid_group_name (name.text) then
					prompts.show_error_prompt (conf_interface_names.invalid_group_name, Current, Void)
				elseif group_exists (name.text, target) then
					prompts.show_error_prompt (conf_interface_names.group_already_exists (name.text), Current, Void)
				else
					last_group := factory.new_precompile (name.text, location.text, target)
					target.set_precompile (last_group)
					is_ok := True
					destroy
				end
			end
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
