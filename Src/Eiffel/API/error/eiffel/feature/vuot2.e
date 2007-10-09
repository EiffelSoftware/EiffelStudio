indexing
	description: "Error when an Object-Test Local name clashes with feature name, local, etc."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VUOT2

inherit
	VUOT
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Creation

	make (c: AST_CONTEXT; n:INTEGER; t: like local_type; l: LOCATION_AS) is
			-- Create error object for Object-Test Local with name identified by `n'
			-- of type `t' at location `l' in the context `c'.
		require
			c_attached: c /= Void
			t_attached: t /= Void
			l_attached: l /= Void
		do
			c.init_error (Current)
			set_local_name (n)
			local_type := t
			set_location (l)
		ensure
			local_name_set: local_name /= Void
			local_type_set: local_type = t
		end

feature -- Error properties

	subcode: INTEGER is 2
			-- Subcode of error

feature {NONE} -- Access

	local_type: TYPE_A
			-- Type of Object-Test Local

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			Precursor (a_text_formatter)
			a_text_formatter.add ("Type: ")
			local_type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
		end

indexing
	copyright:	"Copyright (c) 2007, Eiffel Software"
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
