note
	description: "Byte node visitor that collects targets of separate feature calls."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SEPARATE_TARGET_COLLECTOR

inherit
	BYTE_NODE_ITERATOR
		redefine
			default_create,
			process_nested_b
		end

	SHARED_BYTE_CONTEXT
		redefine
			default_create
		end

feature {NONE} -- Creation

	default_create
			-- <Precursor>
		do
			create {ARRAYED_SET [INTEGER]} target.make (0)
		end

feature -- Access

	target: TRAVERSABLE_SUBSET [INTEGER]
			-- Indexes of arguments that serve as separate targets.

feature -- Status report

	has_separate_target: BOOLEAN
			-- Is there a call on a separate target?

feature -- Status setting

	clean
			-- Clean any collected data.
		do
			has_separate_target := False
			target.wipe_out
		ensure
			not_has_separate_target: not has_separate_target
		end

feature {BYTE_NODE} -- Visitor

	process_nested_b (n: NESTED_B)
			-- <Precursor>
		local
			e: EXPR_B
		do
				-- Get rid of parentheses around a target of a call.
			from
				e := n.target
			until
				not attached {ACCESS_EXPR_B} e as a
			loop
				e := a.expr
			end
				-- Check if a target is an argument and whether it is separate.
			if e.is_argument and then context.real_type (e.type).is_separate then
					-- Record argument number.
				has_separate_target := True
				if attached {ARGUMENT_B} e as a then
					target.extend (a.position)
				end
			end
				-- Continue traversal.
			Precursor (n)
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
