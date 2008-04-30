indexing
	description: "Setup environment variables for Visual Studio C compiler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VS_SETUP

inherit
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	ENV_CONSTANTS
		export
			{NONE} all
		end

	ANY

create
	make

feature -- Initialization

	make (a_force_32bit_generation: BOOLEAN) is
			-- Create and setup environment variables for currently installed
			-- version of Visual Studio.
		local
			l_man: C_CONFIG_MANAGER
			l_config: C_CONFIG
		do
			create l_man.make (a_force_32bit_generation)
			if l_man.has_applicable_config then
					-- Synchronize with configuration
				l_config := l_man.best_configuration
				synchronize_variable (path_var_name, l_config.path_var)
				synchronize_variable (include_var_name, l_config.include_var)
				synchronize_variable (lib_var_name, l_config.lib_var)
				successful := True
			end
		end

feature -- Status report

	successful: BOOLEAN
			-- Indicates if a version of Visual Studio was found and the environment configured

feature -- Implementation

	synchronize_variable (a_name: STRING; a_values: STRING) is
			-- Merges the process environment variable `a_name' values with `a_values', removing duplicates in the process.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_process_values, l_values: LIST [STRING]
			l_process_var: STRING
			l_merged: STRING
			l_name, l_new_values: WEL_STRING
			l_success: BOOLEAN
		do
			if not a_values.is_empty then
				create l_name.make (a_name)

				l_values := a_values.split (';')
				if not l_values.is_empty then
					l_values.compare_objects

						-- Retrieve existing variable
					l_process_var := eiffel_layout.get_environment (a_name)
					if l_process_var /= Void then
						l_process_values := l_process_var.split (';')
						l_process_values.compare_objects
					end

					if l_process_values /= Void and not l_process_values.is_empty then
						from l_process_values.start until l_process_values.after loop
							if not l_values.has (l_process_values.item) then
								l_values.extend (l_process_values.item)
							end
							l_process_values.forth
						end

								-- Rebuild variable value string list
						create l_merged.make (300)
						from l_values.start until l_values.after loop
							l_merged.append (l_values.item + ";")
							l_values.forth
						end
						create l_new_values.make (l_merged)
					else
							-- No process values
						create l_new_values.make (a_values)
					end
					l_success := set_environment_variable (l_name.item, l_new_values.item)
					check l_success: l_success end
				end
			end
		end

feature {NONE} -- Externals

	set_environment_variable (name, value: POINTER): BOOLEAN is
			-- Set environment variable `name' with value `value'.
			-- Return True if successful.
		external
			"C macro signature (LPCTSTR, LPCTSTR): EIF_BOOLEAN use <windows.h>"
		alias
			"SetEnvironmentVariable"
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

end -- class VS_SETUP
