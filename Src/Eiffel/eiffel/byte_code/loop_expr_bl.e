note
	description: "Enlarged byte node for a loop expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	LOOP_EXPR_BL

inherit
	LOOP_EXPR_B
		rename
			make as make_b
--			register as result_register
--		redefine
--			analyze,
--			free_register,
--			generate,
--			result_register,
--			print_register,
--			unanalyze
		end

create
	make

feature {NONE} -- Creation

	make (other: LOOP_EXPR_B)
			-- Create enlarged object from `other'.
		require
			other_attached: other /= Void
		local
			i: detachable BYTE_LIST [BYTE_NODE]
			v: detachable VARIANT_B
		do
			if attached other.invariant_code as inv then
				i := inv.enlarged
			end
			if attached other.variant_code as var then
				v := var.enlarged
			end
			make_b (
				other.iteration_code.enlarged,
				i,
				v,
				other.exit_condition_code.enlarged,
				other.expression_code.enlarged,
				other.is_all,
				other.advance_code.enlarged
			)
		end

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
