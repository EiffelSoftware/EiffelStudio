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
			on_ok,
			fill_library,
			fill_default_libraries
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: CONF_TARGET; a_factory: like factory) is
			-- Create.
		do
			Precursor {CREATE_LIBRARY_DIALOG} (a_target, a_factory)
			set_title (conf_interface_names.dialog_create_precompile_title)
			set_icon_pixmap (conf_pixmaps.new_precompiled_library_icon)
		end

feature -- Access

	last_group: CONF_PRECOMPILE
			-- Last added precompile library.

feature {NONE} -- Actions

	fill_library (a_name, a_subdir, a_file: STRING) is
			-- Fill in library informations.
		require else
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_file_ok: a_file /= Void and then not a_file.is_empty
		do
			name.set_text (a_name+"_pre")
			location.set_text ("$ISE_PRECOMP\"+a_file)
		end

	on_ok is
			-- Add library and close the dialog.
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

feature {NONE} -- Implementation

	fill_default_libraries is
			-- Fill in default precompiles.
		do
			add_configs_in_dir (eiffel_layout.precomp_platform_path (target.setting_msil_generation), Void)
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
