indexing
	description: "Formats .NET XML class text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$1.0$"

class DOTNET_TEXT_FORMATTER

inherit
	E_TEXT_FORMATTER

	SHARED_INST_CONTEXT

	SHARED_WORKBENCH

	SHARED_FORMAT_INFO
		rename
			is_short as format_is_short,
			set_is_short as format_set_is_short
		end

feature {NONE} -- Properties

	is_flat_short: BOOLEAN
			-- Is the format doing a flat short?

feature -- Setting
		
	set_is_flat_short is
			-- Set `is_flat_short' to True.
		do
			is_flat_short := True
		ensure
			is_flat_short: is_flat_short
		end

feature -- Output

	format (e_class: CONSUMED_TYPE; e_classi: CLASS_I) is
			-- Format text for eiffel class `e_class'.
		require
			valid_e_class: e_class /= Void
			valid_i_class: e_classi /= Void
		local
			f: DOTNET_CLASS_CONTEXT
			l_include_ancestors: BOOLEAN
		do
			l_include_ancestors := not is_flat_short
			create f.make (e_class, e_classi, l_include_ancestors)
			f.execute
			text := f.text
			error := f.execution_error
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

end -- class DOTNET_TEXT_FORMATTER
