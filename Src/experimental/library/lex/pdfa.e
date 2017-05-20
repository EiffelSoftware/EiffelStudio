note
	description: "Partially deterministic finite state automata."

class PDFA

inherit
	NDFA
		redefine
			copy, is_equal
		end

	ASCII
		redefine
			copy, is_equal
		end

create

	make

feature {NONE} -- Initialization

	make (n, i: INTEGER)
			-- Make a PDFA with `n' states, and `i' + 1 inputs.
		do
			nb_states := n
			greatest_input := i
			create input_array.make_filled (Void, greatest_input + 1)
			create final_array.make_filled (0, 1, nb_states)
			create keywords_list.make
			create area.make_filled (Void, nb_states)
		end

feature {PDFA} -- Access

	item (i: INTEGER): detachable LINKED_LIST [INTEGER]
			-- Entry at index `i'.
		require
			valid_index: i >= 1 and i <= nb_states
		do
			Result := area.item (i - 1)
		end

	input_array: SPECIAL [detachable FIXED_INTEGER_SET]
			-- For each input, set of the states which have
			-- a transition on this input to the following state.

	final_array: ARRAY [INTEGER]
			-- The `final' value for each state
			-- (regular expression, if any, for which it is final).

	keywords_list: LINKED_LIST [STRING]
			-- Keywords associated with current automaton.

feature -- Access

	has_letters: BOOLEAN
			-- Are there any letters among the active transitions?

feature -- Status setting

	set_letters
			-- Direct the active transitions to include letters.
		do
			has_letters := True
		end

	set_final (s, r: INTEGER)
			-- Make `s' the final state of regular expression `r'.
		do
			final_array.put (r, s)
		end

	set_transition (source, input_doc, target: INTEGER)
			-- Set transition from `source' to `target' on `input_doc'.
		require else
			source_in_automaton: source >= 1 and source <= nb_states
			target_in_automaton: target >= 1 and target <= nb_states
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
			good_successor: target = source + 1
		local
			l_set: FIXED_INTEGER_SET
		do
			if attached input_array.item (input_doc) as l_input_array_item then
				l_input_array_item.put (source)
			else
				create l_set.make (nb_states)
				input_array.put (l_set, input_doc)
				l_set.put (source)
			end
		end

	set_e_transition (source, target: INTEGER)
			-- Set epsilon transition from `source' to `target'.
		local
			list: detachable LINKED_LIST [INTEGER]
		do
			list := item (source)
			if list = Void then
				create list.make
				put (list, source)
			end
			list.put_right (target)
			list.forth
		end

feature -- Element change

	put (v: like item; i: INTEGER)
			-- Replace `i'-th entry, if in index interval, by `v'.
		require
			valid_index: i >= 1 and i <= nb_states
		do
			area.put (v, i - 1)
		end

	add_keyword (word: STRING)
			-- Insert `word' in the keyword list.
		do
			keywords_list.finish
			keywords_list.put_right (word)
		end

	include (fa: PDFA; shift: INTEGER)
			-- Copy `fa' with state numbers shifted
			-- by `shift' positions in the transitions.
			-- Do not preserve the `final' values.
		require
			same_inputs: greatest_input = fa.greatest_input
			nb_states_large_enough: nb_states >= fa.nb_states + shift
		local
			index, last_index: INTEGER
			input_doc: INTEGER
			set: detachable FIXED_INTEGER_SET
		do
			e_include (fa, shift)
			from
				input_doc := -1
			until
				input_doc = greatest_input
			loop
				input_doc := input_doc + 1
				set := fa.input_array.item (input_doc)
				if set /= Void then
					last_index := set.largest
					from
						index := set.smallest
					until
						index > last_index
					loop
						set_transition (index + shift, input_doc, index + shift + 1)
						index := set.next (index)
					end
				end
			end
			if fa.has_letters then
				has_letters := True
			end
		end

	remove_case_sensitiveness
			-- Remove case sensitiveness.
		require
			z_possible: greatest_input >= Lower_z
		local
			input_doc: INTEGER
			upper_set, lower_set: detachable FIXED_INTEGER_SET
		do
			if has_letters then
				from
					input_doc := Lower_a - 1
				until
					input_doc = Lower_z
				loop
					input_doc := input_doc + 1
					lower_set := input_array.item (input_doc)
					upper_set := input_array.item (input_doc - Case_diff)
					if upper_set = Void then
						if lower_set /= Void then
							input_array.put (lower_set, input_doc - Case_diff)
						end
					elseif lower_set = Void then
						input_array.put (upper_set, input_doc)
					else
						upper_set := upper_set or lower_set
						input_array.put (upper_set, input_doc)
						input_array.put (upper_set, input_doc - Case_diff)
					end
				end
			end
		end

feature -- Removal

	delete_transition (source, input_doc, target: INTEGER)
			-- Delete transition from `source' to `target' on `input_doc'.
		require else
			source_in_automaton: source >= 1 and source <= nb_states
			target_in_automaton: target >= 1 and target <= nb_states
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
			good_successor: target = source + 1
		do
			if attached input_array.item (input_doc) as l_input_array_item then
				l_input_array_item.remove (source)
			end
		end

feature -- Output

	trace
			-- Output an internal representation
			-- of the current automaton.
		local
			index, input_doc: INTEGER
			set: detachable FIXED_INTEGER_SET
			epsilon_list: detachable LINKED_LIST [INTEGER]
		do
			debug ("lex_output")
				from
				until
					index = nb_states
				loop
					index := index + 1
					io.put_string (" State # ")
					io.put_integer (index)
					if final_array.item (index) /= 0 then
						io.put_string (" final state of token type: ")
						io.put_integer (final_array.item (index))
					end
					io.new_line
					io.put_string (" Epsilon transitions to: ")
					epsilon_list := item (index)
					if epsilon_list /= Void then
						from
							epsilon_list.start
						until
							epsilon_list.after or epsilon_list.is_empty
						loop
							io.put_integer (epsilon_list.item)
							io.put_string (" ")
							epsilon_list.forth
						end
					end
					io.put_string ("%N Inputs with a transition to the following state:%N")
					from
						input_doc := -1
					until
						input_doc = greatest_input
					loop
						input_doc := input_doc + 1
						set := input_array.item (input_doc)
						if set /= Void and then set.has (index) then
							io.put_integer (input_doc)
							io.new_line
						end
					end
					io.new_line
				end
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			if other = Current then
				Result := True
			elseif area.count = other.area.count then
				Result := area.same_items (other.area, 0, 0, area.count)
			end
		end

feature -- Duplication

	copy (other: like Current)
			-- <Precursor>
		do
			if other /= Current then
				standard_copy (other)
				area := other.area.twin
			end
		end

feature {PDFA} -- Implementation: Access

	area: SPECIAL [detachable LINKED_LIST [INTEGER]]
			-- Storage.

feature {NONE} -- Implementation

	closure (state: INTEGER): FIXED_INTEGER_SET
			-- Epsilon_closure of ith state which means
			-- set of NDFA state reachable from ith
			-- state on epsilon-transition alone.
		require else
			state_in_automaton: state > 0 and state <= nb_states
		local
			stack: LINKED_STACK [INTEGER]
			top, int: INTEGER
		do
			create stack.make
			create Result.make (nb_states)
			Result.put (state)
			from
				stack.put (state)
			until
				stack.is_empty
			loop
				top := stack.item
				stack.remove
				if attached item (top) as e_successors_list then
					from
						e_successors_list.start
					until
						e_successors_list.after or e_successors_list.is_empty
					loop
						int := e_successors_list.item
						if not Result.has (int) then
							Result.put (int)
							stack.put (int)
						end
						e_successors_list.forth
					end
				end
			end
		ensure then
			result_attached: Result /= Void
			state_in_closure: Result.has (state)
		end

	move (initial_set: FIXED_INTEGER_SET; i: INTEGER): detachable FIXED_INTEGER_SET
			-- Set of NDFA states to which there is a transition on
			-- input i from some NDFA state s of initial_set.
			-- Void if the set if empty.
		require else
			possible_input: i >= 0 and i <= greatest_input
			set_not_void: initial_set /= Void
		do
			if attached input_array [i] as l_input_array_item then
				Result := initial_set and l_input_array_item
				if not Result.is_empty then
					Result := Result.right_shifted (1)
				else
					Result := Void
				end
			end
		end

	initial_final_designation
			-- Set the final and initial attributes of the dfa,
			-- consistent with those of the current automaton.
		local
			index: INTEGER
			l_array: like final_array
		do
			if attached dfa as l_dfa and attached sets_list as l_sets_list then
				l_array := final_array
				l_dfa.set_start (1)
				from
				until
					index = nb_states
				loop
					index := index + 1
					if l_array.item (index) /= 0 then
						from
							l_sets_list.start
						until
							l_sets_list.after or l_sets_list.is_empty
						loop
							if l_sets_list.item.has (index) then
								dfa_set_final (l_sets_list.index, l_array.item (index))
							end
							l_sets_list.forth
						end
					end
				end
			end
		end

	dfa_set_final (s, f: INTEGER)
			-- Make `f' the `final' state for `s'.
		do
			if attached dfa as l_dfa and then attached l_dfa.item (s) as l_state_of_dfa then
				l_state_of_dfa.set_final (final_array.item (f))
			end
		end

	e_include (fa: PDFA; shift: INTEGER)
			-- Copy the fa epsilon transition in Current
			-- with state numbers shifted in the transitions.
			-- The attributes are not preserved.
		require
			nb_states_large_enough: nb_states >= fa.nb_states + shift
		local
			index, last_index: INTEGER
		do
			last_index := fa.nb_states
			from
			until
				index = last_index
			loop
				index := index + 1
				if attached fa.item (index) as l_list then
					from
						l_list.start
					until
						l_list.after
					loop
						set_e_transition (index + shift, l_list.item + shift)
						l_list.forth
					end
				end
			end
		end

	find_successors (source, input_doc: INTEGER): detachable LINKED_LIST [INTEGER]
			-- Successors of `source' on `input_doc';
			-- void if no successor.
		require else
			source_in_automaton: source >= 1 and source <= nb_states
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		do
			if attached input_array.item (input_doc) as l_fixed_integer_set and then l_fixed_integer_set.has (source) then
				create Result.make
				Result.put_right (source + 1)
			end
		end

	find_e_successors (source: INTEGER): detachable LINKED_LIST [INTEGER]
			-- Epsilon successors of source;
			-- Void if no successor.
		require else
			source_in_automaton: source >= 1 and source <= nb_states
		do
			Result := item (source)
		end

	set_state
			-- This routine is deferred in NDFA,
			-- but is useless in PDFA.
		do
		end

note
	comment: "[
			 These PDFA have a very special structure.
			 They are NDFA but for each state, only one successor is
			 possible, if the input is different of epsilon,
			 and this successor is the following state.
			 For the epsilon transitions each state can have as many
			 successors as possible.
			 Thus, the structure is different for the epsilons transitions,
			 which are recorded in an ARRAY [LINKED_LIST [INTEGER]],
			 and for the others transitions, which are recorded, for
			 each input, in a FIXED_INTEGER_SET.

			 For the use in a regular expression context, keywords
			 can be associated with Current.
		]"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
