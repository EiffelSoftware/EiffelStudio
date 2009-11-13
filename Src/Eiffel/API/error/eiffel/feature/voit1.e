note
	description: "Error in loop iteration that is not of ITERABLE type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VOIT1

inherit
	FEATURE_ERROR
		redefine
			build_explain,
			subcode
		end

create
	make

feature {NONE} -- Creation

	make (c: AST_CONTEXT; s: TYPE_A; t: CL_TYPE_A; l: LOCATION_AS)
			-- Create error object for loop iteration that is of type `s' which does not conform
			-- to the target type `t' (ITERABLE [G]) in the context `c'.
		require
			c_attached: c /= Void
			s_attached: s /= Void
			t_attached: t /= Void
			l_attached: l /= Void
		do
			c.init_error (Current)
			source_type := s
			target_type := t
			set_location (l)
		ensure
			source_type_set: source_type = s
			target_type_set: target_type = t
		end

feature -- Error properties

	code: STRING = "VOIT"
			-- <Precursor>

	subcode: INTEGER = 1
			-- <Precursor>

feature {NONE} -- Access

	target_type: CL_TYPE_A
			-- Target type

	source_type: TYPE_A
			-- Source type

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- <Precursor>
		local
			s: CL_TYPE_A
		do
			a_text_formatter.add ("Target type: ")
			target_type.append_to (a_text_formatter)
			if
				attached {CL_TYPE_A} source_type as c and then
				target_type.associated_class.name.is_equal (c.associated_class.name)
			then
					-- Provide some details because the class names are the same.
				s := c
				a_text_formatter.add (" (from ")
				a_text_formatter.add_group (target_type.associated_class.lace_class.group,
					target_type.associated_class.lace_class.target.name)
				a_text_formatter.add (")")
			end
			a_text_formatter.add_new_line
			a_text_formatter.add ("Source type: ")
			source_type.append_to (a_text_formatter)
			if s /= Void then
				a_text_formatter.add (" (from ")
				a_text_formatter.add_group (s.associated_class.lace_class.group,
					s.associated_class.lace_class.target.name)
				a_text_formatter.add (")")
			end
			a_text_formatter.add_new_line
		end

invariant
	target_type_attached: target_type /= Void
	source_type_attached: source_type /= Void

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
