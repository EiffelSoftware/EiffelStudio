indexing

	description:
		"Partially deterministic finite state automata";
	comment:
		"See comment at end of class";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PDFA inherit

	ARRAY [LINKED_LIST [INTEGER]]
		rename
			make as array_make
		export
			{NONE} to_c
		end;

	NDFA
		undefine
			consistent, copy, setup, is_equal
		end;

	ASCII
		undefine
			consistent, copy, setup, is_equal
		end

create

	make

feature -- Initialization

	make (n, i: INTEGER) is
			-- Make a PDFA with `n' states, and `i' + 1 inputs.
		do
			nb_states := n;
			greatest_input := i;
			create input_array.make (0, greatest_input);
			create final_array.make (1, nb_states);
			array_make (1, nb_states);
			create keywords_list.make
		end; 

feature -- Access

	input_array: ARRAY [FIXED_INTEGER_SET];
			-- For each input, set of the states which have
			-- a transition on this input to the following state

	final_array: ARRAY [INTEGER];
			-- The `final' value for each state
			-- (regular expression, if any, for which it is final).

	keywords_list: LINKED_LIST [STRING];
			-- Keywords associated with current automaton.

	has_letters: BOOLEAN;
			-- Are there any letters among the active transitions?

feature -- Status setting

	set_letters is
			-- Direct the active transitions to include letters.
		do
			has_letters := True
		end; 

	set_final (s, r: INTEGER) is
			-- Make `s' the final state of regular expression `r'.
		do
			final_array.put (r, s)
		end; 

	set_transition (source, input_doc, target: INTEGER) is
			-- Set transition from `source' to `target' on `input_doc'.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input;
			good_successor: target = source + 1
		local
			set: FIXED_INTEGER_SET
		do
			if input_array.item (input_doc) = Void then
				create set.make (nb_states);
				input_array.put (set, input_doc)
			end;
			input_array.item (input_doc).put (source)
		end; 

	set_e_transition (source, target: INTEGER) is
			-- Set epsilon transition from `source' to `target'.
		local
			list: LINKED_LIST [INTEGER]
		do
			if item (source) = Void then
				create list.make;
				put (list, source)
			end;
			item (source).put_right (target);
			item (source).forth
		end; 

feature -- Element change

	add_keyword (word: STRING) is
			-- Insert `word' in the keyword list.
		do
			keywords_list.finish;
			keywords_list.put_right (word)
		end; 

	include (fa: PDFA; shift: INTEGER) is
			-- Copy `fa' with state numbers shifted
			-- by `shift' positions in the transitions.
			-- Do not preserve the `final' values.
		require
			same_inputs: greatest_input = fa.greatest_input;
			nb_states_large_enough: nb_states >= fa.nb_states + shift
		local
			index, last_index: INTEGER;
			input_doc: INTEGER;
			set: FIXED_INTEGER_SET
		do
			e_include (fa, shift);
			from
				input_doc := -1
			until
				input_doc = greatest_input
			loop
				input_doc := input_doc + 1;
				set := fa.input_array.item (input_doc);
				if set /= Void then
					last_index := set.largest;
					from
						index := set.smallest
					until
						index > last_index
					loop
						set_transition (index + shift, input_doc, index + shift + 1);
						index := set.next (index)
					end
				end
			end;
			if fa.has_letters then
				has_letters := True
			end
		end; 

	remove_case_sensitiveness is
			-- Remove case sensitiveness.
		require
			z_possible: greatest_input >= Lower_z
		local
			input_doc: INTEGER;
			upper_set, lower_set: FIXED_INTEGER_SET
		do
			if has_letters then
				from
					input_doc := Lower_a - 1
				until
					input_doc = Lower_z
				loop
					input_doc := input_doc + 1;
					lower_set := input_array.item (input_doc);
					upper_set := input_array.item (input_doc - Case_diff);
					if upper_set = Void then
						if lower_set /= Void then
							input_array.put (lower_set, input_doc - Case_diff);
						end
					elseif lower_set = Void then
						input_array.put (upper_set, input_doc)
					else
						upper_set := upper_set or (lower_set);
						input_array.put (upper_set, input_doc);
						input_array.put (upper_set, input_doc - Case_diff)
					end
				end
			end
		end; 

feature -- Removal

	delete_transition (source, input_doc, target: INTEGER) is
			-- Delete transition from `source' to `target' on `input_doc'.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input;
			good_successor: target = source + 1
		do
			if input_array.item (input_doc) /= Void then
				input_array.item (input_doc).remove (source)
			end
		end; 

feature -- Output

	trace is
			-- Output an internal representation
			-- of the current automaton.
		local
			index, input_doc: INTEGER;
			set: FIXED_INTEGER_SET;
			epsilon_list: LINKED_LIST[INTEGER]
		do
			from
			until
				index = nb_states
			loop
				index := index + 1;
				io.put_string (" State # ");
				io.put_integer (index);
				if final_array.item (index) /= 0 then
					io.put_string (" final state of token type: ");
					io.put_integer (final_array.item (index));
				end;
				io.new_line;
				io.put_string (" Epsilon transitions to: ");
				epsilon_list := item (index);
				if epsilon_list /= Void then
					from
						epsilon_list.start
					until
						epsilon_list.after or epsilon_list.is_empty
					loop
						io.put_integer (epsilon_list.item);
						io.put_string (" ");
						epsilon_list.forth
					end
				end;
				io.put_string ("%N Inputs with a transition to the following state:%N");
				from
					input_doc := -1
				until
					input_doc = greatest_input
				loop
					input_doc := input_doc + 1;
					set := input_array.item (input_doc);
					if set /= Void and then set.has (index) then
						io.put_integer (input_doc);
						io.new_line
					end
				end;
				io.new_line
			end
		end 

feature {NONE} -- Implementation

	closure (state: INTEGER): FIXED_INTEGER_SET is
			-- Epsilon_closure of ith state which means
			-- set of NDFA state reachable from ith
			-- state on epsilon-transition alone.
		require else
			state_in_automaton: state > 0 and state <= nb_states
		local
			stack: LINKED_STACK [INTEGER];
			top, int: INTEGER;
			e_successors_list: LINKED_LIST [INTEGER]
		do
			create stack.make;
			create Result.make (nb_states);
			Result.put (state);
			from
				stack.put (state)
			until
				stack.is_empty
			loop
				top := stack.item;
				stack.remove;
				if item (top) /= Void then
					from
						e_successors_list := item (top);
						e_successors_list.start
					until
						e_successors_list.after or e_successors_list.is_empty
					loop
						int := e_successors_list.item;
						if not Result.has (int) then
							Result.put (int);
							stack.put (int)
						end;
						e_successors_list.forth
					end
				end
			end
		ensure then
			state_in_closure: Result.has (state)
		end; 

	move (initial_set: FIXED_INTEGER_SET; i: INTEGER): FIXED_INTEGER_SET is
			-- Set of NDFA states to which there is a transition on
			-- input i from some NDFA state s of initial_set.
			-- Void if the set if empty.
		require else
			possible_input: i >= 0 and i <= greatest_input;
			set_not_void: initial_set /= Void
		do
			if input_array.item (i) /= Void then
				Result := initial_set and (input_array.item (i));
				if not Result.is_empty then
					Result := Result.right_shifted (1)
				else
					Result := Void
				end
			end
		end; 

	initial_final_designation is
			-- Set the final and initial attributes of the dfa,
			-- consistent with those of the current automaton.
		require else
			dfa_exists: dfa /= Void
		local
			index: INTEGER
		do
			dfa.set_start (1);
			from
			until
				index = nb_states
			loop
				index := index + 1;
				if final_array.item (index) /= 0 then
					from
						sets_list.start
					until
						sets_list.after or sets_list.is_empty
					loop
						if sets_list.item.has (index) then
							dfa_set_final (sets_list.index,
									final_array.item (index));
						end;
						sets_list.forth;
					end
				end
			end
		end; 

	dfa_set_final (s, f: INTEGER) is
			-- Make `f' the `final' state for `s'.
		do
			dfa.item (s).set_final (final_array.item (f))
		end; 

	e_include (fa: PDFA; shift: INTEGER) is
			-- Copy the fa epsilon transition in Current
			-- with state numbers shifted in the transitions.
			-- The attributes are not preserved.
		require
			nb_states_large_enough: nb_states >= fa.nb_states + shift
		local
			index, last_index: INTEGER;
			list: LINKED_LIST [INTEGER]
		do
			last_index := fa.nb_states;
			from
			until
				index = last_index
			loop
				index := index + 1;
				if fa.item (index) /= Void then
					list := fa.item (index);
					from
						list.start
					until
						list.after or list.is_empty
					loop
						set_e_transition (index + shift, list.item + shift);
						list.forth
					end
				end
			end
		end; 

	find_successors (source, input_doc: INTEGER): LINKED_LIST [INTEGER] is
			-- Successors of `source' on `input_doc';
			-- void if no successor
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		do
			if input_array.item (input_doc).has (source) then
				create Result.make;
				Result.put_right (source + 1)
			end
		end; 

	find_e_successors (source: INTEGER): LINKED_LIST [INTEGER] is
			-- Epsilon successors of source;
			-- Void if no successor
		require else
			source_in_automaton: source >= 1 and source <= nb_states
		do
			Result := item (source)
		end; 

	set_state is
			-- This routine is deferred in NDFA,
			-- but is useless in PDFA.
		do
		end 

-- These PDFA have a very special structure.
-- They are NDFA but for each state, only one successor is
-- possible, if the input is different of epsilon,
-- and this successor is the following state.
-- For the epsilon transitions each state can have as many
-- successors as possible.
-- Thus, the structure is different for the epsilons transitions,
-- which are recorded in an ARRAY [LINKED_LIST [INTEGER]],
-- and for the others transitions, which are recorded, for
-- each input, in a FIXED_INTEGER_SET.

-- For the use in a regular expression context, keywords
-- can be associated with Current.

end -- class PDFA

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

