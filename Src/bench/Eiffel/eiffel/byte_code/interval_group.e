indexing
	description: "Group of intervals with high density or a single interval with low density."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INTERVAL_GROUP

inherit
	INTERVAL_SPAN
	SHARED_IL_CODE_GENERATOR

create
	make

feature {NONE} -- Creation

	make (interval: like lower_interval) is
			-- Create a group with a single interval `interval'.
		do
			is_lower_included := true
			is_upper_included := true
			lower := interval.item.lower
			upper := interval.item.upper
			lower_interval := interval
			upper_interval := interval
			count := 1
			is_extended := true
			is_dense := 1 / (lower.distance (upper) + 1) >= density
		ensure
			lower_set: lower = interval.item.lower
			upper_set: upper = interval.item.upper
			lower_interval_set: lower_interval = interval
			upper_interval_set: upper_interval = interval
			count_set: count = 1
			is_extended: is_extended
			is_dense_set: is_dense = (1 / (lower.distance (upper) + 1) >= density)
		end

feature -- Access

	lower: INTERVAL_VAL_B
			-- Lower bound of a group

	upper: like lower
			-- Upper bound of a group

	is_lower_included: BOOLEAN
			-- Is `lower' included in the range?

	is_upper_included: BOOLEAN
			-- Is `upper' included in the range?

	lower_interval: BI_LINKABLE [INTERVAL_B]
			-- Lower interval in a group

	upper_interval: like lower_interval
			-- Upper interval in a group

feature -- Measurement

	count: DOUBLE
			-- Number of intervals and gaps in current group

feature {NONE} -- Status report

	is_dense: BOOLEAN
			-- Is group dense?

feature -- Status report

	is_extended: BOOLEAN
			-- Is group extended by last call to `extend_with_interval' or `extend_with_group'?

feature -- Status setting

	set_is_extended (value: like is_extended) is
			-- Set `is_extended' to `value'.
		do
			is_extended := value
		ensure
			is_extended_set: is_extended = value
		end

feature -- Element change

	extend_with_interval (interval: like lower_interval) is
			-- Extend current group by adding `interval' or a gap to it
			-- unless density becomes smaller than `density'.
			-- Set `is_extended' to true if interval is included in group and to false otherwise.
		require
			interval_not_void: interval /= Void
			interval_outside_group:
				interval.item.upper < lower or else not is_lower_included and then interval.item.upper = lower or else
				upper < interval.item.lower or else not is_upper_included and then upper = interval.item.lower
		do
			extend (interval.item.lower, interval.item.upper, true, true, interval, interval, 1)
		ensure
			is_extended_implies_count_inremented: is_extended implies count > old count
			lower_unchanged:
				upper <= interval.item.lower implies
				(lower = old lower and then lower_interval = old lower_interval)
			upper_unchanged:
				interval.item.upper <= lower implies
				(upper = old upper and then upper_interval = old upper_interval)
			lower_interval_unchanged:
				not is_extended implies lower_interval = old lower_interval
			upper_interval_unchanged:
				not is_extended implies upper_interval = old upper_interval
			added_as_lower:
				is_extended and then interval.item.upper <= lower implies
				(is_lower_included and then lower = interval.item.lower and then lower_interval = interval)
			added_as_upper:
				is_extended and then upper <= interval.item.lower implies
				(is_upper_included and then upper = interval.item.upper and then upper_interval = interval)
			enlarged_at_lower:
				not is_extended and count > old count and then interval.item.upper <= lower implies
				(not is_lower_included and then lower = interval.item.upper)
			enlarged_at_upper:
				not is_extended and count > old count and then upper <= interval.item.lower implies
				(not is_upper_included and then upper = interval.item.lower)
			count_incremented_by_1_if_extended:
				is_extended and then
				(interval.item.upper.is_next (old lower) or else (old upper).is_next (interval.item.lower)) implies
				count = old count + 1
			count_incremented_by_2_if_extended:
				is_extended and then
				not interval.item.upper.is_next (old lower) and then not (old upper).is_next (interval.item.lower) implies
				count = old count + 2
			count_incremented_by_1_if_not_extended:
				not is_extended and then count > old count implies count = old count + 1
		end

	extend_with_lower_gap (value: like lower; is_value_included: BOOLEAN) is
			-- Extend current group by adding a gap `value'..`lower'
			-- to it unless density becomes smaller than `density'.
			-- Inclusion of `value' in range is specified by `is_value_included'.
		require
			value_not_void: value /= Void
			value_in_range: value < lower or else value = lower and then is_value_included and then not is_lower_included
		local
			distance: like count
		do
			distance := value.distance (upper)
			if not is_upper_included then
				distance := distance - 1
			end
			if is_value_included then
				distance := distance + 1
			end
			if (count + 1) / distance >= density then
					-- Extend current group with a gap
				count := count + 1
				is_dense := true
				lower := value
				is_lower_included := is_value_included
			end
		ensure
			lower_set: lower = old lower or else lower = value
			upper_unchanged: upper = old upper
			is_upper_included_unchanged: is_upper_included = old is_upper_included
			interval_unchanged: lower_interval = old lower_interval and then upper_interval = old upper_interval
			count_incremented_at_most_by_1: count = old count or else count = old count + 1
			count_incremented_implies_dense: count > old count implies is_dense
			count_incremented_implies_lower_set: count > old count implies lower = value
			count_incremented_implies_is_lower_included_set: count > old count implies is_lower_included = is_value_included
		end

	extend_with_upper_gap (value: like lower; is_value_included: BOOLEAN) is
			-- Extend current group by adding a gap `upper'..`value'
			-- to it unless density becomes smaller than `density'.
			-- Inclusion of `value' in range is specified by `is_value_included'.
		require
			value_not_void: value /= Void
			value_in_range: upper < value or else upper = value and then not is_upper_included and then is_value_included
		local
			distance: like count
		do
			distance := lower.distance (value)
			if not is_lower_included then
				distance := distance - 1
			end
			if is_value_included then
				distance := distance + 1
			end
			if (count + 1) / distance >= density then
					-- Extend current group with a gap
				count := count + 1
				is_dense := true
				upper := value
				is_upper_included := is_value_included
			end
		ensure
			upper_set: upper = old upper or else upper = value
			lower_unchanged: lower = old lower
			is_lower_included_unchanged: is_lower_included = old is_lower_included
			interval_unchanged: lower_interval = old lower_interval and then upper_interval = old upper_interval
			count_incremented_at_most_by_1: count = old count or else count = old count + 1
			count_incremented_implies_dense: count > old count implies is_dense
			count_incremented_implies_upper_set: count > old count implies upper = value
			count_incremented_implies_is_upper_included_set: count > old count implies is_upper_included = is_value_included
		end

	extend_with_group (group: INTERVAL_GROUP) is
			-- Extend current group by adding `group' or a gap to it.
			-- unless density becomes smaller than `density'.
			-- Set `is_extended' to true if `group' is merged with current one and to false otherwise.
		require
			group_not_void: group /= Void
			group_is_outside:
				group.upper < lower or else (is_lower_included /= group.is_upper_included) and then group.upper = lower or else
				upper < group.lower or else (is_upper_included /= group.is_lower_included) and then upper = group.lower
		do
			extend (group.lower, group.upper, group.is_lower_included, group.is_upper_included, group.lower_interval, group.upper_interval, group.count)
		ensure
			is_extended_implies_dense: is_extended implies is_dense
			count_incremented_if_extended: is_extended implies count = old count + group.count or else count = old count + group.count + 1
			count_incremented_if_not_extended: not is_extended implies (count = old count or else count = old count + 1)
			count_incremented_implies_dense: count > old count implies is_dense
		end

feature -- IL code generation

	generate_il (a_generator: IL_NODE_GENERATOR; min, max: like lower; is_min_included, is_max_included: BOOLEAN; labels: ARRAY [IL_LABEL]; instruction: INSPECT_B) is
			-- Generate code for group of intervals in `instruction' assuming that inspect value is in range `min'..`max'
			-- where bounds are included in interval according to values of `is_min_included' and `is_max_included'.
			-- Use `labels' to branch to the corresponding code.
		local
			i: like lower
			switch_count: INTEGER
			is_included: BOOLEAN
			interval: like lower_interval
			interval_b: INTERVAL_B
			generate_default_label: PROCEDURE [ANY, TUPLE]
			case_index: INTEGER
			case_label: IL_LABEL
			cases: LINKED_LIST [INTEGER]
		do
					-- Generate switch instruction for all intervals and gaps in group
			from
				i := lower
				is_included := is_lower_included
				interval := lower_interval
				a_generator.generate_il_load_value (instruction)
				i.generate_il_subtract (is_included)
				switch_count := i.distance (upper).truncated_to_integer - 1
				if is_included then
					switch_count := switch_count + 1
				end
				if is_upper_included then
					switch_count := switch_count + 1
				end
				il_generator.put_switch_start (switch_count)
				generate_default_label := agent il_generator.put_switch_label (labels.item (0))
				create cases.make
			until
				interval = Void
			loop
				i.do_all (is_included, interval.item.lower, false, generate_default_label)
				interval_b := interval.item
				case_index := interval_b.case_index
				case_label := labels.item (case_index)
				if case_label = Void then
					case_label := il_label_factory.new_label
					labels.put (case_label, case_index)
					cases.extend (case_index)
				end
				interval_b.lower.do_all (true, interval.item.upper, true, agent il_generator.put_switch_label (case_label))
				if interval = upper_interval then
					interval := Void
				else
					i := interval_b.upper
					interval := interval.right
					is_included := false
				end
			end
			upper_interval.item.upper.do_all (false, upper, is_upper_included, generate_default_label)
			if
				(is_min_included and then min = lower or else
				not is_min_included and then min.is_next (lower)) and then
				(is_max_included and then max = upper or else
				not is_max_included and then upper.is_next (max))
			then
					-- All cases are handled by switch
			else
					-- There are cases for Else_part
				il_generator.branch_to (labels.item (0))
			end
				-- Generate code for referenced When_part's
			from
				cases.start
			until
				cases.after
			loop
				a_generator.generate_il_when_part (instruction, cases.item, labels)
				cases.forth
			end
		end

feature {NONE} -- Status report

	density: DOUBLE is 0.25
			-- Minimum number of distinct elements (intervals and gaps) per their range of values
			-- Smaller values result in more table-driven (potentially faster, but longer) code: 0 means only tables are used
			-- Higher values result in more decision-tree (potentially shorter, but slower) code: 1 means only conditional instructions are used
			-- If calculated density is higher than some value (0.5 for average IL code), switch instruction is shorter,
			-- so it does not make sense to set `density' above this value, switch instruction is better both in speed and memory in this case
			-- and 1/2 of this value will only double the table size

feature {NONE} -- Element change

	extend (lb, ub: like lower; is_lb_included, is_ub_included: like is_lower_included; li, ui: like lower_interval; c: like count) is
			-- Extend current group by adding other group or a gap to it
			-- specified by `lb', `ub', `is_lb_included', `is_up_included', `li', `ui' and `c'
			-- unless density becomes smaller that `density'.
			-- Set `is_extended' to true if other group is added to the current one and to false otherwise.
		require
			lb_not_void: lb /= Void
			ub_not_void: ub /= Void
			li_not_void: li /= Void
			ui_not_void: ui /= Void
			consistent_intervals: li.item <= ui.item
			lb_consistent: lb <= li.item.lower
			ub_consistent: ub >= ui.item.upper
			lb_included: is_lb_included implies lb = li.item.lower
			ub_included: is_ub_included implies ub = ui.item.upper
			outside_group:
				ub < lower or else is_lower_included /= is_ub_included and then ub = lower or else
				upper < lb or else is_upper_included /= is_lb_included and then upper = lb
		local
			new_count: like count
			is_before: BOOLEAN
			has_gap: BOOLEAN
			distance: like count
		do
			is_extended := false
			if ub <= lower then
					-- Other group is before current one
				is_before := true
				if ub /= lower and then not (is_ub_included and then is_lower_included and then ub.is_next (lower)) then
						-- There is a gap
					has_gap := true
				end
				distance := lb.distance (upper)
				if not is_upper_included then
					distance := distance - 1
				end
				if is_lb_included then
					distance := distance + 1
				end
			else
					-- Other group is after current one
				if upper /= lb and then not (is_upper_included and then is_lb_included and then upper.is_next (lb)) then
						-- There is a gap
					has_gap := true
				end
				distance := lower.distance (ub)
				if not is_lower_included then
					distance := distance - 1
				end
				if is_ub_included then
					distance := distance + 1
				end
			end
			new_count := count + c
			if has_gap then
				new_count := new_count + 1
			end
			if new_count / distance >= density then
					-- Extend current group with other one
				is_extended := true
				count := new_count
				is_dense := true
				if is_before then
					lower := lb
					is_lower_included := is_lb_included
					lower_interval := li
				else
					upper := ub
					is_upper_included := is_ub_included
					upper_interval := ui
				end
			elseif has_gap then
					-- Extend current group with a gap
				if is_before then
					extend_with_lower_gap (ub, not is_ub_included)
				else
					extend_with_upper_gap (lb, not is_lb_included)
				end
			end
		end

invariant
	lower_interval_not_void: lower_interval /= Void
	upper_interval_not_void: upper_interval /= Void
	ordered_group: lower_interval = upper_interval or else lower_interval.item.upper <= upper_interval.item.lower
	consistent_lower: lower <= lower_interval.item.lower
	consistent_upper: upper >= upper_interval.item.upper
	density_in_range: 0 <= density and density <= 1

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
