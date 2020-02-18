note
	description: "Warning that a setting could not be changed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VD83

inherit
	ERROR
		undefine
			has_associated_file
		redefine
			error_string
		end

	LACE_WARNING
		redefine
			error_string,
			trace_single_line
		end

create
	make, make_error

feature {NONE} -- Initialization

	make (a_setting: STRING; an_old_value: like old_value; a_new_value: like new_value)
			-- Create a warning object.
		require
			a_setting_not_void: a_setting /= Void
			an_old_value_not_void: an_old_value /= Void
			a_new_value_not_void: a_new_value /= Void
		do
			setting := a_setting
			old_value := an_old_value
			new_value := a_new_value
		end

	make_error  (a_setting: STRING; an_old_value: like old_value; a_new_value: like new_value)
			-- Create an error object.
		require
			a_setting_not_void: a_setting /= Void
			an_old_value_not_void: an_old_value /= Void
			a_new_value_not_void: a_new_value /= Void
		do
			make (a_setting, an_old_value, a_new_value)
			is_error := True
		end

feature -- Properties

	setting: STRING
			-- Setting name.

	old_value: READABLE_STRING_GENERAL
			-- Old value (which was preserved).

	new_value: like old_value
			-- New value (which was ignored).

	is_error: BOOLEAN
			-- Does issue report represent an error rather than a warning?

feature {NONE} -- Output

	error_string: STRING
		do
			Result := if is_error then
				Precursor {ERROR}
			else
				Precursor {LACE_WARNING}
			end
		end

	build_explain (st: TEXT_FORMATTER)
		do
			st.add_new_line
			st.add ("Value of a setting could not be changed because the system is already compiled or uses a precompile: ")
			st.add (setting)
			st.add_new_line
			st.add ("Old: ")
			st.add (old_value)
			st.add_new_line
			st.add ("New: ")
			st.add (new_value)
			st.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context
				("Setting {1} cannot be changed.", "compiler.error"),
					<<agent {TEXT_FORMATTER}.add_string (setting)>>)
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
