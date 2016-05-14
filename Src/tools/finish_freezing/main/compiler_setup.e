note
	description: "Automatically initialize the C compiler"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_SETUP

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	initialize

feature {NONE} -- Initialize

	initialize (options: RESOURCE_TABLE; a_force_32bit: BOOLEAN)
			-- Properly configure the C compiler.
		require
			options_not_void: options /= Void
		local
			l_vs_setup: VS_SETUP
			l_c_chosen_compiler: STRING
		do
			l_c_chosen_compiler := eiffel_layout.eiffel_c_compiler
				-- Check if a smart checking should be done.
			if l_c_chosen_compiler.starts_with ("msc") and options.get_boolean ("smart_checking", True) then
				if attached eiffel_layout.eiffel_c_compiler_version as l_version and then not l_version.is_empty then
					create l_vs_setup.make (l_version, Void, a_force_32bit)
				else
						-- Visual Studio C compiler.
					if l_c_chosen_compiler.starts_with ("msc_") then
						if l_c_chosen_compiler.count > 4 then
								-- We have chosen a specific version of the Microsoft C++ compiler as minimum version
							create l_vs_setup.make (Void, l_c_chosen_compiler.substring (5, l_c_chosen_compiler.count), a_force_32bit)
						else
								-- The ISE_C_COMPILER environment is improperly set. We default to latest version.
							create l_vs_setup.make (Void, Void, a_force_32bit)
						end
					else
							-- We are just handling msc so choose the Microsoft C++ compiler compatible with "VC100"
						create l_vs_setup.make (Void, "VC100", a_force_32bit)
					end
				end
				if l_vs_setup.successful then
					found_c_config := l_vs_setup.found_config
				end
			end
		end

feature -- Access

	found_c_config: detachable C_CONFIG
			-- Found C configuration if any.

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
