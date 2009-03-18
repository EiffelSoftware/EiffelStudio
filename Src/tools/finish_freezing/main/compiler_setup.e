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
			l_smart_checking: BOOLEAN
			l_vs_setup: VS_SETUP
		do
				-- Check if a smart checking should be done.
			l_smart_checking := options.get_boolean ("smart_checking", True)
			if eiffel_layout.eiffel_c_compiler ~ once "msc" and l_smart_checking then
					-- Visual Studio C compiler.
				create l_vs_setup.make (a_force_32bit)
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
