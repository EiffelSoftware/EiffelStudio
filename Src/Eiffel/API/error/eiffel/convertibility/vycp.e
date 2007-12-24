indexing
	description: "Error for violation of Creation Procedure rule"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VYCP

inherit
	EIFFEL_ERROR
		undefine
			subcode
		redefine
			build_explain
		end

create
	make

feature -- Initialization

	make (c: CLASS_C; n: FEATURE_NAME; t: TYPE_A; l: LOCATION_AS; s: like subcode) is
			-- Create error object for class `c' and type `t' at location `l' with subcode `s'.
		require
			c_attached: c /= Void
			n_attached: n /= Void
			t_attached: t /= Void
			l_attached: l /= Void
		do
			set_class (c)
			name := n.visual_name
			type := t
			set_location (l)
			subcode := s
		ensure
			class_set: class_c = c
			name_set: name = n.visual_name
			type_set: type = t
			line_set: line = l.line
			column_set: column = l.column
			subcode_set: subcode = s
		end

feature -- Access

	code: STRING is "VYCP"
			-- Name of error

	subcode: INTEGER
			-- Subcode of error

feature {NONE} -- Implementation

	name: STRING
			-- Conversion feature name

	type: TYPE_A
			-- Conversion type

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			Precursor (a_text_formatter)
			a_text_formatter.add ("Feature name: ")
			a_text_formatter.add_class_syntax (Current, class_c, name)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Conversion type: ")
			type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
		end

indexing
	copyright:	"Copyright (c) 2006, Eiffel Software"
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
