note
	description:
		"General error during the loading of a configuration file."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class VD00

inherit
	LACE_ERROR
		redefine
			file_name,
			has_associated_file
		end

create
	default_create,
	make

feature {NONE} -- Creation

	make (e: CONF_ERROR)
			-- Associate error object with confoguration error `e'.
		do
			set_error (e)
		end

feature -- Properties

	error: CONF_ERROR
			-- Error from configuration system.

	file_name: detachable like {ERROR}.file_name
			-- <Precursor>
		do
			if attached {CONF_ERROR_PARSE} error as l_parse_error then
				Result := l_parse_error.file
			end
		end

feature -- Status report

	has_associated_file: BOOLEAN
			-- <Precursor>
		do
			if attached {CONF_ERROR_PARSE} error as l_parse_error then
				Result := attached l_parse_error.file
			end
		end

feature -- Output

	build_explain (st: TEXT_FORMATTER)
		do
			if attached error as l_error and then attached l_error.text as l_text then
				st.add (l_text)
			else
				st.add ("Unkown Error.")
			end
			st.add_new_line
		end

feature -- Setting

	set_error (an_error: CONF_ERROR)
			-- Set `an_error'.
		require
			an_error_not_void: an_error /= Void
		do
			error := an_error
			if attached {CONF_ERROR_PARSE} an_error as l_parse_error then
				line := l_parse_error.row
				column := l_parse_error.column
			else
				line := 0
				column := 0
			end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
