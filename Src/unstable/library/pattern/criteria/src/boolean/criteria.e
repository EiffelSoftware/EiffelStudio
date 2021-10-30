note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CRITERIA [G]

inherit
	DEBUG_OUTPUT

feature -- Status report

	meet (d: G): BOOLEAN
			-- Does `b' meet Current criteria?
		deferred
		end

feature -- Functions to build a criterion tree.

	conjuncted alias "and" (t: CRITERIA [G]): CRITERIA_AND [G]
			-- Create and return an "and"-node with `Current' and `t' as children.
		do
			create Result.make (Current, t)
		end

	disjuncted alias "or" (t: CRITERIA [G]): CRITERIA_OR [G]
			-- Create and return an "or"-node with `Current' and `t' as children.
		do
			create Result.make (Current, t)
		end

	negated alias "not": CRITERIA_NOT [G]
			-- Create and return a "not"-node with `Current' as child.
		do
			create Result.make (Current)
		end

feature -- Factory

	list (lst: LIST [G]): LIST [G]
			-- Apply criteria on `lst' and return result.
		do
			create {ARRAYED_LIST [G]} Result.make (lst.count)
			across
				lst as c
			loop
				if meet (c) then
					Result.extend (c)
				end
			end
		ensure
			result_attached: Result /= Void
			new_object: Result /= lst
			coherent_result: Result.count <= lst.count and then ∀ r: Result ¦ lst.has (r)
		end

	apply_to_list (lst: LIST [G])
			-- Apply current criterai to `lst`.
		do
			from
				lst.start
			until
				lst.after
			loop
				if not meet (lst.item) then
					lst.remove
				else
					lst.forth
				end
			end
		ensure
			coherent_count: lst.count <= old lst.count and then ∀ r: lst ¦ (old lst).has (r)
		end

feature -- Visitor

	accept (a_visitor: CRITERIA_VISITOR [G])
			-- `accept' visitor `a_visitor'.
			-- See Visitor pattern
		deferred
		end

feature -- Output

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		local
			p: CRITERIA_PRINTER [G]
		do
			create p.make_default
			accept (p)
			Result := p.output
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
