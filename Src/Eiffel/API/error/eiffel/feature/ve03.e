note

	description:
		"Error when the target of an assignment or a reverse %
		%assignment is not a writable one or is of NONE type."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VE03
inherit
	FEATURE_ERROR
		redefine
			build_explain
		end

feature

	target: ACCESS_AS;
			-- Target of attachment involved in the error

	set_target (t: ACCESS_AS)
			-- Assign `t' to `target'.
		do
			target := t;
		end;

	code: STRING = "VJAW";
			-- Error code

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			a_text_formatter.add ("Target: ");
			a_text_formatter.add (target.access_name_32);
			a_text_formatter.add_new_line;
		end;

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class VE03
