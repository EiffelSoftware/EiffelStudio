indexing
	description: "Status of current compilation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	COMPILATION_MODES

feature -- Properties

	is_freezing, is_finalizing,
	is_precompiling, is_quick_melt: BOOLEAN
			-- Type of compilation.

feature -- Update

	set_is_freezing is
			-- Set `is_freezing' to `True'
		do
			is_freezing := True
		end

	set_is_quick_melt is
			-- Set `is_quick_melt' to `True'
		do
			is_quick_melt := True
		end

	set_is_finalizing is
			-- Set `is_finalizing' to `True'
		do
			is_finalizing := True
		end

	set_is_precompiling (b: BOOLEAN) is
			-- Set `is_precompiling' to `b'
		do
			is_precompiling := b
		end

feature -- Setting

	reset_modes is
		do
			is_quick_melt := False
			is_freezing := False
			is_finalizing := False
			is_precompiling := False
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class COMPILATION_MODES
