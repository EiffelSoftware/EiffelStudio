note
	description:
		"General error during the loading of a configuration file of a precompile."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VD77

inherit

	VD00
		rename
			make as make_error
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Creation

	make (l: STRING_32; e: CONF_ERROR)
			-- Initialize an error described by `e` for a precompile with specified location `l`.
		do
			location := l
			make_error (e)
		ensure
			location = l
			error = e
		end

feature {NONE} -- Access

	location: STRING_32
			-- Uninterpreted location specified in the project file.

feature -- Output

	build_explain (f: TEXT_FORMATTER)
		do
			f.add_new_line
			f.add (error.text)
			f.add_new_line
			f.add (locale.formatted_string (locale.translation_in_context ("Specified location: $1", "compiler"), location))
			f.add_new_line
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
