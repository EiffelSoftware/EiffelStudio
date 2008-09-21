indexing
	description: "Error for the actual generic that is not self-initializing while the formal generic is."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VTGD4

inherit
	VTGD
		redefine
			build_explain,
			subcode
		end

create
	make

feature {NONE}

	make (t: GEN_TYPE_A; p: INTEGER; f: FEATURE_I; c: CLASS_C)
			-- Create an error that in feature `f' of class `c'
			-- the actual generic `p' in `t' is not self-initializing while the formal generic is.
		require
			t_attached: t /= Void
			p_valid: 0 < p and p <= t.generics.count
			f_attached: f /= Void
			c_attached: c /= Void
		do
			set_class (c)
			set_feature (f)
			position := p
			actual_type := t
		ensure
			class_c_set: class_c = c
			e_feature_set: e_feature /= Void and then e_feature.associated_feature_i = f
			position_set: position = p
			actual_type_set: actual_type = t
		end

feature -- Properties

	subcode: INTEGER_32 = 4

feature {NONE} -- Details

	actual_type: GEN_TYPE_A
			-- Actual type that causes the error

	position: INTEGER
			-- Position of the generic parameter

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_text_formatter.add_string ("Type: ")
			actual_type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add_string ("Generic parameter position: ")
			a_text_formatter.add_int (position)
			a_text_formatter.add_new_line
			a_text_formatter.add_string ("Actual generic: ")
			actual_type.generics [position].append_to (a_text_formatter)
			a_text_formatter.add_new_line
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class VTGD4

