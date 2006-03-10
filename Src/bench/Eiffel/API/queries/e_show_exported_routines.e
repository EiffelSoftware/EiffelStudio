indexing
	description: "Command to display exported features of current_class."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class E_SHOW_EXPORTED_ROUTINES

inherit
	E_CLASS_FORMAT_CMD
		redefine
			display_feature
		end

create
	make, default_create

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		do
			Result := f.is_exported_to (any_class)
		ensure then
			good_criterium: Result = f.is_exported_to (Any_class)
		end

	display_feature (f: E_FEATURE; st: TEXT_FORMATTER) is
			-- Append `f' to `st'.
		do
			f.append_signature (st)
			if f.is_obsolete then
					-- The user might change the background color of comments.
				st.add ("  ")
				st.add_comment ("(obsolete)")
			end
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

end
