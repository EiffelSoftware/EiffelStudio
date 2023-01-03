note
	description: "Status of current compilation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILATION_MODES

feature -- Properties

	is_freezing, is_finalizing,
	is_precompiling, is_quick_melt,
	is_discover: BOOLEAN
			-- Type of compilation.

feature -- Access

	string_representation: STRING
			-- Normalized output for current compilation mode.
		do
			if is_precompiling then
				if is_finalizing then
					Result := precompile_finalize_type
				else
					Result := precompile_type
				end
			elseif is_quick_melt then
				Result := quick_melt_type
			elseif is_discover then
				Result := discover_type
			elseif is_freezing then
				Result := freeze_type
			elseif is_finalizing then
				Result := finalize_type
			else
				Result := "Unknown"
			end
			Result := Result.twin
		ensure
			string_representation_not_void: Result /= Void
		end

	precompile_type: STRING = "Precompile"
	precompile_finalize_type: STRING = "Precompile+Finalize"
	quick_melt_type: STRING = "Quick_melt"
	discover_type: STRING = "Discover"
	freeze_type: STRING = "Freeze"
	finalize_type: STRING = "Finalize"

feature -- Update

	set_is_freezing
			-- Set `is_freezing' to `True'
		do
			is_freezing := True
		end

	set_is_quick_melt
			-- Set `is_quick_melt' to `True'
		do
			is_quick_melt := True
		end

	set_is_finalizing
			-- Set `is_finalizing' to `True'
		do
			is_finalizing := True
		end

	set_is_precompiling (b: BOOLEAN)
			-- Set `is_precompiling' to `b'
		do
			is_precompiling := b
		end

	set_is_discover
			-- Set `is_discover' to `True'.
		do
			is_discover := True
		ensure
			is_discover: is_discover
		end

feature -- Setting

	reset_modes
		do
			is_quick_melt := False
			is_freezing := False
			is_finalizing := False
			is_precompiling := False
			is_discover := False
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
