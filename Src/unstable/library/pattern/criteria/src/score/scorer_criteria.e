note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCORER_CRITERIA [G]

inherit
	DEBUG_OUTPUT

feature -- Status report

	score (d: G): REAL
			-- Relevance with `d'.
			-- Result <= 0 means not relevant.
		deferred
		end

	weight: REAL
		deferred
		end

feature -- Functions to build a criterion tree.

	conjuncted alias "and" (t: SCORER_CRITERIA [G]): SCORER_CRITERIA_AND [G]
			-- Create and return an "and"-node with `Current' and `t' as children.
		do
			create Result.make (Current, t)
		end

	disjuncted alias "or" (t: SCORER_CRITERIA [G]): SCORER_CRITERIA_OR [G]
			-- Create and return an "or"-node with `Current' and `t' as children.
		do
			create Result.make (Current, t)
		end

	negated alias "not": SCORER_CRITERIA_NOT [G]
			-- Create and return a "not"-node with `Current' as child.
		do
			create Result.make (Current)
		end

feature -- Factory

	scores (lst: ITERABLE [G]; a_capacity: INTEGER): LIST [SCORED_VALUE [G]]
			-- Apply criteria on `lst' and return scored values.
		local
			s: like score
		do
			create {ARRAYED_LIST [SCORED_VALUE [G]]} Result.make (a_capacity)
			across
				lst as c
			loop
				s := score (c)
				if not score_is_zero (s) then
					Result.extend (create {SCORED_VALUE [G]}.make (c, s))
				end
			end
		ensure
			result_attached: Result /= Void
			coherent_result: Result.count <= a_capacity and then ∀ r: Result ¦ ∃ ic: lst ¦ ic = r.value
		end

	sorted_scores (lst: ITERABLE [G]; a_capacity: INTEGER): LIST [SCORED_VALUE [G]]
			-- Apply criteria on `lst' and return scored values sorted by score.
		do
			Result := scores (lst, a_capacity)
			; (create {QUICK_SORTER [SCORED_VALUE [G]]}.make (create {COMPARABLE_COMPARATOR [SCORED_VALUE [G]]})).sort (Result)
		end

	list (lst: LIST [G]): LIST [G]
			-- Apply criteria on `lst' and return result.
		local
			l_values: ARRAYED_LIST [SCORED_VALUE [G]]
			s: like score
		do
			create l_values.make (lst.count)
			across
				lst as c
			loop
				s := score (c)
				if not score_is_zero (s) then
					l_values.extend (create {SCORED_VALUE [G]}.make (c, s))
				end
			end

			; (create {QUICK_SORTER [SCORED_VALUE [G]]}.make (create {COMPARABLE_COMPARATOR [SCORED_VALUE [G]]})).sort (l_values)

			create {ARRAYED_LIST [G]} Result.make (l_values.count)
			⟳ v: l_values ¦ Result.extend (v.value) ⟲
		ensure
			result_attached: Result /= Void
			new_object: Result /= lst
			coherent_result: Result.count <= lst.count and then ∀ r: Result ¦ lst.has (r)
		end

	apply_to_list (lst: LIST [G])
			-- Apply current criterai to `lst'
		local
			l_values: ARRAYED_LIST [SCORED_VALUE [G]]
			s: like score
		do
			create l_values.make (lst.count)
			across
				lst as ic
			loop
				s := score (ic)
				if not score_is_zero (s) then
					l_values.extend (create {SCORED_VALUE [G]}.make (ic, s))
				end
			end
			; (create {QUICK_SORTER [SCORED_VALUE [G]]}.make (create {COMPARABLE_COMPARATOR [SCORED_VALUE [G]]})).sort (l_values)
			lst.wipe_out
			⟳ v: l_values ¦ lst.extend (v.value) ⟲
		ensure
			coherent_count: lst.count <= old lst.count and then ∀ r: lst ¦ (old lst).has (r)
		end

feature -- Visitor

	accept (a_visitor: SCORE_VISITOR [G])
			-- `accept' visitor `a_visitor'.
			-- See Visitor pattern
		deferred
		end

feature -- Output

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		local
			p: SCORE_PRINTER [G]
		do
			create p.make_default
			accept (p)
			Result := p.output
		end

feature {NONE} -- Helpers

	score_is_zero (r: like score): BOOLEAN
		do
			Result := r <= {REAL_32}.machine_epsilon
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
