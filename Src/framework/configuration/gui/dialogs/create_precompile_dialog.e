note
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

	make (a_target: CONF_TARGET; a_factory: like factory)
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

	lookup_directories: attached ARRAYED_LIST [attached TUPLE [path: attached STRING; depth: INTEGER]]
			-- A list of lookup directories
		local
			l_filename: FILE_NAME
			l_file: RAW_FILE
		do
			create Result.make (10)

			l_filename := eiffel_layout.precompiles_config_name
			create l_file.make (l_filename)
			if l_file.exists then
				add_lookup_directories (l_filename, Result)
			end
			if eiffel_layout.is_user_files_supported then
				l_filename := eiffel_layout.user_priority_file_name (l_filename.string, True)
				if l_filename /= Void then
					l_file.reset (l_filename)
					if l_file.exists then
						add_lookup_directories (l_filename, Result)
					end
				end
			end

			if Result.is_empty then
					-- Extend the default library path
				Result.extend ([eiffel_layout.precompilation_path (target.setting_msil_generation), 0])
			end
		end

feature {NONE} -- Action handlers

	on_library_selected (a_library: attached CONF_SYSTEM; a_location: attached STRING)
			-- <Precursor>
		do
			name.set_text (a_library.library_target.name + "_precompile")
			location.set_text (a_location)
		end

	on_ok
			-- <Precursor>
		do
				-- library choosen?
			if not location.text.is_empty and not name.text.is_empty then
				if not is_valid_group_name (name.text) then
					prompts.show_error_prompt (conf_interface_names.invalid_precompile_name, Current, Void)
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

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
