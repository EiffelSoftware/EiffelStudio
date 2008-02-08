indexing
	description	: "[
					Describes a breakpoint. A breakpoint is represented by its `body_index' 
				  	and its `breakable_line_number' (line number in stop points view). 
					The run-time handles breakpoints through `real_body_id' 
					and `breakable_line_number'.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "$Author$"
	date		: "$Date$"
	revision	: "$Revision$"

class BREAKPOINT

inherit
	BREAKPOINT_KEY
		redefine
			make
		end

	DEBUG_OUTPUT
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

create {BREAKPOINTS_MANAGER}
	make

create {BREAKPOINT}
	make_copy_for_saving

feature {NONE} -- Creation

	make (a_location: BREAKPOINT_LOCATION) is
			-- Create a breakpoint at location `a_location'
		do
			Precursor {BREAKPOINT_KEY} (a_location)
			if not location.is_corrupted then
				bench_status := Bench_breakpoint_enabled
			end
			create when_hits_actions.make
			create {LINKED_LIST [STRING_32]} tags.make
			tags.compare_objects
		end

	make_copy_for_saving (bp: like Current) is
			-- Create Current as a copy of `bp'
		do
				--| Key part
			location := bp.location
			is_hidden := bp.is_hidden

				--| Current part
			if bp.condition /= Void then
				expression := bp.condition.expression
			end
			condition_type := bp.condition_type
			continue_on_condition_failure := bp.continue_on_condition_failure

			bench_status := bp.bench_status

			continue_execution := bp.continue_execution
			hits_count_condition := bp.hits_count_condition
			when_hits_actions := bp.when_hits_actions
			tags := bp.tags
		end

feature {BREAK_LIST} -- Copy for saving

	copy_for_saving: like Current is
			-- Create Current as a copy of `bp'
		do
			create Result.make_copy_for_saving (Current)
		end

feature -- debug output

	debug_output: STRING is
			-- Debug output.
		do
			Result := string_representation (True)
		end

feature -- Output

	string_representation (with_details: BOOLEAN): STRING is
			-- String representation of current Breakpoint.
		local
			lcl: CLASS_C
			loc: BREAKPOINT_LOCATION
			rout: E_FEATURE
			idx: INTEGER
		do
			loc := location
			rout := loc.routine
			idx := loc.breakable_line_number

			Result := "{"
			if rout /= Void then
				lcl := rout.associated_class
			end
			if lcl /= Void then
				Result.append_string (lcl.name_in_upper)
			else
				Result.append_string ("???")
			end
			Result.append_string ("}.")
			if rout /= Void then
				Result.append_string (rout.name)
			else
				Result.append_string ("???")
			end
			Result.append_string (" [" + idx.out + "] ")
			if has_condition then
				Result.append_string ("(C)")
			end
			if has_when_hits_action then
				Result.append_string ("(W)")
			end
			if with_details then
				if loc.is_corrupted then
					Result.append_string (" <corrupted> ")
				end
				if is_set then
					if is_enabled then
						Result.append_string (" <enabled> ")
					end
					if is_disabled then
						Result.append_string (" <disabled> ")
					end
				else
					Result.append_string (" <not set> ")
				end
				if loc.is_set_for_application then
					Result.append_string (" <set for application> ")
				end
			end
			if is_hidden then
				Result.append_string (" -HIDDEN- ")
			end
		end

feature -- Tags access

	tags: LIST [STRING_32]
			-- Associated tags.

	tags_as_string: STRING_32 is
			-- Associated tags as string.
		local
			ltags: like tags
		do
			create Result.make_empty
			ltags := tags
			if ltags /= Void and then not ltags.is_empty then
				from
					ltags.start
					Result.append_string (ltags.item_for_iteration)
					ltags.forth
				until
					ltags.after
				loop
					Result.append_character (',')
					Result.append_character (' ')
					Result.append_string (ltags.item_for_iteration)
					ltags.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	tags_as_array: ARRAY [STRING_32] is
			-- Associated tags as Array.
		local
			ts: like tags
			i: INTEGER
		do
			ts := tags
			if tags /= Void and then not tags.is_empty then
				create Result.make (1, tags.count)
				from
					ts.start
					i := 1
				until
					ts.after
				loop
					Result[i] := ts.item_for_iteration
					i := i + 1
					ts.forth
				end
			end
		end

	match_tags (a_tags: ARRAY [STRING_32]): BOOLEAN is
			-- Does Current match `a_tags' criterion ?
		require
			a_tags_not_void: a_tags /= Void
		local
			i, p: INTEGER
			s_gcfi, -- string: group.{CLASS}.feature@index
			s_cfi,  -- string: {CLASS}.feature@index
			s: STRING_32
		do
			from
				Result := a_tags.is_empty
				if not Result then
					s_gcfi := to_tag_path
					if s_gcfi /= Void then
						p := s_gcfi.index_of ('{', 1)
						if p > 0 then
							s_cfi := s_gcfi.substring (p, s_gcfi.count)
						else
							s_cfi := s_gcfi
						end
					end
				end
				i := a_tags.lower
			until
				i > a_tags.upper or Result
			loop
				s := a_tags[i]
				if s /= Void and then not s.is_empty then
					if
						s_gcfi /= Void and then
						s.count > 4 and then --| 4 = ("bp:").count + at least 1 character
						s.item (1) = 'b' and s.item (2) = 'p' and s.item (3) = ':'
					then
						s := s.substring (4, s.count)
						s.left_adjust
						if not s.is_empty then
							if s.item (1) = '{' then --| {class}.feature@index
								Result := s_cfi.is_case_insensitive_equal (s)
							else --| group.{class}.feature.index
								Result := s_gcfi.is_case_insensitive_equal (s)
							end
						end
					else
						Result := tags.has (a_tags[i])
					end
				end
				i := i + 1
			end
		end

	to_tag_path: STRING_32 is
			-- Tag path representation of Current.
			-- Group_name.class_name.feature_name.index
		local
			r: E_FEATURE
			c: CLASS_C
			g: CONF_GROUP
		do
			r := location.routine
			if r /= Void then
				c := r.associated_class
				if c /= Void then
					create Result.make (10)
					Result.append_character ('{')
					Result.append_string (c.name_in_upper)
					Result.append_character ('}')
					Result.append_character ('.')
					Result.append_string (r.name)
					Result.append_character ('@')
					Result.append_integer (location.breakable_line_number)
					g := c.group
					if g /= Void then
						Result.prepend_character ('.')
						Result.prepend_string (g.name)
					end
				end
			end
		end

feature -- Tags change

	set_tags_from_array (a_tags: ARRAY [STRING_32]) is
			-- Set `tags' from `a_tags'
		local
			i: INTEGER
		do
			tags.wipe_out
			if a_tags /= Void and then not a_tags.is_empty then
				from
					i := a_tags.lower
				until
					i > a_tags.upper
				loop
					add_tag (a_tags[i])
					i := i + 1
				end
			end
		end

	add_tag (t: STRING_32) is
			-- Add tag `t' to `tags'
		require
			has_not_tag: not tags.has (t)
		do
			tags.extend (t)
		ensure
			has_tag: tags.has (t)
		end

	remove_tag (t: STRING_32) is
			-- Remove tag `t' from `tags'
		do
			tags.prune_all (t)
		ensure
			has_not_tag: not tags.has (t)
		end

feature -- Properties

	hits_count_condition: TUPLE [mode: INTEGER; value: INTEGER]
			--| modes:
			--|	0	Hits_count_condition_always,
			--|	1	Hits_count_condition_equal,
			--|	2	Hits_count_condition_multiple,
			--|	3	Hits_count_condition_greater,
			--|	4	Hits_count_condition_continue_execution

	condition: DBG_EXPRESSION
			-- Condition to stop.

	condition_as_is_true: BOOLEAN is
			-- Condition is a "Is True" condition.
		do
			Result := condition_type = Condition_is_type_is_true
		end

	condition_as_has_changed: BOOLEAN is
			-- Condition is a "Has Changed" condition.
		do
			Result := condition_type = Condition_is_type_has_changed
		end

	continue_on_condition_failure: BOOLEAN
			-- Continue execution when condition failed to be evaluated ?
			-- Default: stop.

	continue_execution: BOOLEAN
			-- Continue execution when Current is reached ?
			-- Default: stop.

	when_hits_actions: LINKED_LIST [BREAKPOINT_WHEN_HITS_ACTION_I]
			-- Action to process when the breakpoint is hit.

feature -- Access

	condition_respected: BOOLEAN is
			-- Is condition respected ?
		require
			condition.expression_evaluator /= Void
		local
			eval: DBG_EXPRESSION_EVALUATOR
			ncv: like last_condition_value
		do
			eval := condition.expression_evaluator
			if eval.error_occurred then
				Result := not continue_on_condition_failure
			else
				inspect condition_type
				when Condition_is_type_is_true then
					Result := eval.final_result_is_true_boolean_value
				when Condition_is_type_has_changed then
					ncv := eval.final_result_value
					Result := last_condition_value = Void or ncv = Void
						or else (not ncv.same_as (last_condition_value))
					last_condition_value:= ncv
				else
					Result := True
				end
			end
		end

feature {BREAKPOINT} -- Internal properties

	condition_type: INTEGER
			-- Type of condition
			--| default: condition_is_true_type

feature -- Status and live properties

	bench_status: INTEGER
			-- Current status within Eiffel Studio.
			--
			-- See the private constants at the end of the class to see the
			-- different possible values taken.

	hits_count: INTEGER
			-- Number of times Current is reached (and satisfied condition if any).

feature {NONE} -- Internal value

	last_condition_value: DUMP_VALUE
			-- Last condition's value			

feature -- Change

	set_location (loc: BREAKPOINT_LOCATION) is
			-- Set `location' with `loc'
		do
			location := loc
		end

	set_continue_on_condition_failure (b: BOOLEAN) is
			-- Set `continue_on_condition_failure' to `b'
		do
			continue_on_condition_failure := b
		end

	set_continue_execution (b: BOOLEAN) is
			-- Set `continue_execution' to `b'
		do
			continue_execution := b
		end

	increase_hits_count is
			-- Increase hits_count by one
		do
			hits_count := hits_count + 1
		end

	reset_hits_count is
			-- Reset `hits_count'
		do
			hits_count := 0
		end

	set_hits_count_condition (m,v: INTEGER) is
			-- Set `hits_count_condition'
		do
			if m = 0 then
				hits_count_condition := Void
			else
				hits_count_condition := [m, v]
			end
		end

	set_condition_as_is_true is
			-- Set `condition_type' as `Condition_is_type_is_true'
		do
			condition_type := Condition_is_type_is_true
		end

	set_condition_as_has_changed is
			-- Set `condition_type' as `Condition_is_type_has_changed'
		do
			condition_type := Condition_is_type_has_changed
		end

	reset_session_data is
			-- Reset data changed during debugging session
		do
			reset_hits_count
			last_condition_value := Void
			if condition /= Void then
				condition.reset
			end
			revert_saved_bench_status
		end

	revert_session_data	is
			-- Revert breakpoint status changes which occurred during debugging session
		do
			revert_saved_bench_status
		end

	clear_when_hits_actions is
			-- Clear all when_hits_actions
		do
			when_hits_actions.wipe_out
		end

	when_hits_actions_for (a_type: TYPE [BREAKPOINT_WHEN_HITS_ACTION_I]): LIST [BREAKPOINT_WHEN_HITS_ACTION_I] is
			-- List of When hits actions of type `a_type'.
		require
			a_type_not_void: a_type /= Void
		local
			int: INTERNAL
			a: BREAKPOINT_WHEN_HITS_ACTION_I
		do
			create int
			from
				create {LINKED_LIST [BREAKPOINT_WHEN_HITS_ACTION_I]} Result.make
				when_hits_actions.start
			until
				when_hits_actions.after
			loop
				a := when_hits_actions.item_for_iteration
				if int.type_of (a).is_equal (a_type) then
					Result.extend (a)
				end
				when_hits_actions.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	add_when_hits_action (a_ac: BREAKPOINT_WHEN_HITS_ACTION_I) is
			-- Add `a_ac' to `when_hits_actions'
		do
			when_hits_actions.extend (a_ac)
		end

	remove_when_hits_action (a_ac: BREAKPOINT_WHEN_HITS_ACTION_I) is
			-- Remove `a_ac' from `when_hits_actions'
		do
			when_hits_actions.prune_all (a_ac)
		end

feature -- Status

	has_condition: BOOLEAN is
			-- Is `Current' a conditional breakpoint?
		do
			Result := condition /= Void
		end

	has_hit_count_condition: BOOLEAN is
			-- Is `Current' has a condition on `hit_count' ?
		do
			Result := hits_count_condition /= Void and then hits_count_condition.mode /= hits_count_condition_always
		end

	has_when_hits_action: BOOLEAN is
			-- Has action to be processed when hit ?
		do
			Result := when_hits_actions /= Void and then not when_hits_actions.is_empty
		end

	has_when_hits_action_for (a_type: TYPE [BREAKPOINT_WHEN_HITS_ACTION_I]): BOOLEAN is
			-- Has When hits action of type `a_type' ?
		do
			Result := not when_hits_actions_for (a_type).is_empty
		end

	has_tags: BOOLEAN is
			-- Has tags ?
		do
			Result := tags /= Void and then not tags.is_empty
		end

feature -- Access

	is_useless: BOOLEAN is
			-- Is structure now useless ?
			--
			-- If the bench and the application status are `no_set'
			-- we don't need this structure anymore, and we can destroy it...
		do
			Result := bench_status = Bench_breakpoint_not_set and then not location.is_set_for_application
		ensure
			is_not_usefull: Result implies bench_status = bench_breakpoint_not_set and not location.is_set_for_application
		end

	is_set: BOOLEAN is
			-- Is the breakpoint set (enabled or disabled)?
		do
			Result := bench_status = Bench_breakpoint_enabled
				   or bench_status = Bench_breakpoint_disabled
				--| i.e: bench_status /= Bench_breakpoint_not_set
		end

	is_disabled: BOOLEAN is
			-- Is the breakpoint set but disabled?
		do
			Result := bench_status = Bench_breakpoint_disabled
		end

	is_enabled: BOOLEAN is
			-- Is the breakpoint set and enabled?
		do
			Result := bench_status = Bench_breakpoint_enabled
		end

feature -- Live's changes

	live_enable is
			-- Enable Current during debugging session
		do
			save_bench_status
			set_bench_status (Bench_breakpoint_enabled)
		end

	live_disable is
			-- Disable Current during debugging session
		do
			save_bench_status
			set_bench_status (Bench_breakpoint_disabled)
		end

	saved_bench_status: CELL [like bench_status]
			-- During execution, the `bench_status' can be artificially modified by
			-- a `BREAKPOINT_WHEN_HITS_ACTION' event

	save_bench_status is
			-- Save original bench status
		do
			if saved_bench_status = Void then
				create saved_bench_status.put (bench_status)
			end
		end

	revert_saved_bench_status is
			-- Revert `bench_status' to `saved_bench_status' if any
		do
			if saved_bench_status /= Void then
				bench_status := saved_bench_status.item
			end
			reset_saved_bench_status
		end

	reset_saved_bench_status is
			-- Reset `saved_bench_status'
		do
			saved_bench_status := Void
		end

feature -- Setting

	discard is
			-- Set the breakpoint to be removed.
		do
			bench_status := Bench_breakpoint_not_set
			condition := Void
			when_hits_actions.wipe_out
			tags.wipe_out
			reset_session_data
		ensure
			breakpoint_is_removed: bench_status = Bench_breakpoint_not_set
		end

	enable is
			-- Set and enable the breakpoint.
		do
			reset_saved_bench_status
			set_bench_status (Bench_breakpoint_enabled)
		ensure
			breakpoint_is_enabled: bench_status = Bench_breakpoint_enabled
		end

	disable is
			-- Disable the breakpoint.
		do
			reset_saved_bench_status
			set_bench_status (Bench_breakpoint_disabled)
		ensure
			breakpoint_is_disabled: bench_status = Bench_breakpoint_disabled
		end

	update_status: INTEGER is
			-- Update the status between Bench and the application.
			--
			-- See the public constants below to see the
			-- different possible value taken.
		do
			Result := Breakpoint_do_nothing

			if (bench_status /= location.application_status) then
				inspect bench_status
					when Bench_breakpoint_enabled then
						-- bench breakpoint is set, application breakpoint is not set
						Result := Breakpoint_to_add

					when Bench_breakpoint_not_set then
						-- bench breakpoint is not set, application breakpoint is set
						Result := Breakpoint_to_remove

					when Bench_breakpoint_disabled then
						if location.is_set_for_application then
							-- bench breakpoint is disabled but application breakpoint is set
							-- so remove it
							Result := Breakpoint_to_remove
						end
				end
			end
		end

feature {NONE} -- bench status implementation

	set_bench_status (v: like bench_status) is
			-- Set `bench_status' to `v'
		do
			bench_status := v
		end

feature -- Condition change

	set_condition (expr: DBG_EXPRESSION) is
			-- Set `Current's condition.
		require
			valid_breakable_line_number: location.breakable_line_number > 0
							and location.breakable_line_number <= location.routine.number_of_breakpoint_slots
			valid_expression: expr /= Void and then not expr.syntax_error_occurred
				and then (condition_as_is_true implies expr.is_boolean_expression (location.routine))
		do
			condition := expr
		end

	remove_condition is
			-- Remove any condition on `Current'.
		do
			condition := Void
		end

feature {BREAK_LIST} -- Saving protocol.

	reload is
			-- To be used after save and load operations, to restore the condition.
		do
			if expression /= Void then
				create condition.make_for_context (expression)
				if
					condition.syntax_error_occurred
					or else (condition_as_is_true and not condition.is_boolean_expression (location.routine) )
				then
					condition := Void
				end
				expression := Void
			end
		end

feature {NONE} -- Implementation

	expression: STRING_32
			-- String representation of the condition, if any, during save and load operations.

feature -- Public constants

	Breakpoint_do_nothing: INTEGER 	= 0 --| Default
	Breakpoint_to_remove: INTEGER	= 1
	Breakpoint_to_add: INTEGER 		= 2

	Hits_count_condition_always: INTEGER 				= 0 --| Default
	Hits_count_condition_equal: INTEGER 				= 1
	Hits_count_condition_multiple: INTEGER				= 2
	Hits_count_condition_greater: INTEGER				= 3
	Hits_count_condition_continue_execution: INTEGER	= 4

feature {NONE} -- Private constants

	Condition_is_type_is_true: INTEGER 		= 0 --| Default
	Condition_is_type_has_changed: INTEGER 	= 1

	Bench_breakpoint_enabled: INTEGER 		= 0 --| aka: _set
	Bench_breakpoint_not_set: INTEGER 		= 1
	Bench_breakpoint_disabled: INTEGER 		= 2

;indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class BREAKPOINT

