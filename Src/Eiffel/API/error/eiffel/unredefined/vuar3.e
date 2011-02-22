note
	description: "[
		Validity error: formal argument of a separate feature call is not separate
		when the corresponding actual argument is of a reference type.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	VUAR3

inherit

	VUAR2
		redefine
			subcode
		end

create
	make

feature {NONE} -- Creation

	make (context: AST_CONTEXT; f: FEATURE_I; c: CLASS_C; i: INTEGER; t, a: TYPE_A; l: LOCATION_AS)
			-- Initialize an error object in context `context' with feature `f' called on class `c'
			-- with argument position `i' of formal type `t' and actual type `a' at location `l'.
		require
			f_attached: attached f
			c_attached: attached c
			valid_i: 0 < i and i <= f.argument_count
			a_attached: attached a
			t_attached: attached t
			l_attached: attached l
		do
			set_called_feature (f, c.class_id)
			set_argument_position (i)
			set_argument_name (f.arguments.item_name (i))
			set_actual_type (a)
			set_formal_type (t)
			set_location (l)
			context.init_error (Current)
		end

feature -- Access

	subcode: INTEGER = 3

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
