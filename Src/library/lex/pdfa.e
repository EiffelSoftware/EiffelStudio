indexing

	description:
		"Partially deterministic finite state automata";
	comment:
		"See comment at end of class";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PDFA inherit

	ARRAY [LINKED_LIST [INTEGER]]
		rename
			make as array_make
		export
			{ANY} item
		end;

	NFA
		undefine
			consistent, copy, setup, is_equal
		end;

	ASCII
		undefine
			consistent, copy, setup, is_equal
		end

creation

	make

feature

	input_array: ARRAY [FIX_INT_SET];
			-- For each input, set of the states which have
			-- a transition on this input to the following state

	final_array: ARRAY [INTEGER];
			-- Attributes "final" of each state

	keywords_list: LINKED_LIST [STRING];
			-- Keywords associated with Current

	has_letters: BOOLEAN;
			-- Has Current letters among the actives transitions?
			-- This attribute is NOT automatically updated,
			-- but in feature include.

	make (n, i: INTEGER) is
			-- Make a PDFA with n states, and i + 1 inputs.
		do
			nb_states := n;
			greatest_input := i;
			!!input_array.make (0, greatest_input);
			!!final_array.make (1, nb_states);
			array_make (1, nb_states);
			!!keywords_list.make
		end; -- make

	now_has_letters is
			-- Set has_letters to true.
		do
			has_letters := true
		end; -- now_has_letters

	add_keyword (word: STRING) is
			-- Insert `word' in the keyword list.
		local
			already_in: BOOLEAN
		do
			keywords_list.finish;
			keywords_list.put_right (word)
		end; -- add_keyword

	set_final (s, r: INTEGER) is
			-- Declare state s as final state of regular expression r.
		do
			final_array.put (r, s)
		end; -- set_final

	set_transition (source, inp_ut, target: INTEGER) is
			-- Set transition from source to target on inp_ut.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_inp_ut: inp_ut >= 0 and inp_ut <= greatest_input;
			good_successor: target = source + 1
		local
			set: FIX_INT_SET
		do
			if input_array.item (inp_ut) = Void then
				!!set.make (nb_states);
				input_array.put (set, inp_ut)
			end;
			input_array.item (inp_ut).put (source)
		end; -- set_transition

	delete_transition (source, inp_ut, target: INTEGER) is
			-- Delete transition from source to target on inp_ut.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_inp_ut: inp_ut >= 0 and inp_ut <= greatest_input;
			good_successor: target = source + 1
		do
			if input_array.item (inp_ut) /= Void then
				input_array.item (inp_ut).remove (source)
			end
		end; -- delete_transition

	set_e_transition (source, target: INTEGER) is
			-- Set epsilon transition from source to target.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states
		local
			list: LINKED_LIST [INTEGER]
		do
			if item (source) = Void then
				!!list.make;
				put (list, source)
			end;
			item (source).put_right (target);
			item (source).forth
		end; -- set_e_transition

	include (fa: PDFA; shift: INTEGER) is
			-- Copy fa in Current with state numbers shifted
			-- in the transitions.
			-- The attributes "final" are not preserved.
		require
			same_inputs: greatest_input = fa.greatest_input;
			nb_states_large_enough: nb_states >= fa.nb_states + shift
		local
			index, last_index: INTEGER;
			inp_ut: INTEGER;
			set: FIX_INT_SET
		do
			e_include (fa, shift);
			from
				inp_ut := -1
			until
				inp_ut = greatest_input
			loop
				inp_ut := inp_ut + 1;
				set := fa.input_array.item (inp_ut);
				if set /= Void then
					last_index := set.largest;
					from
						index := set.smallest
					until
						index > last_index
					loop
						set_transition (index + shift, inp_ut, index + shift + 1);
						index := set.next (index)
					end
				end
			end;
			if fa.has_letters then
				has_letters := true
			end
		end; -- include

	remove_case_sensitiveness is
			-- Remove the case sensitiveness of Current.
		require
			z_possible: greatest_input >= Lower_z
		local
			inp_ut: INTEGER;
			upper_set, lower_set: FIX_INT_SET
		do
			if has_letters then
				from
					inp_ut := Lower_a - 1
				until
					inp_ut = Lower_z
				loop
					inp_ut := inp_ut + 1;
					lower_set := input_array.item (inp_ut);
					upper_set := input_array.item (inp_ut - Case_diff);
					if upper_set = Void then
						if lower_set /= Void then
							input_array.put (lower_set, inp_ut - Case_diff);
						end
					elseif lower_set = Void then
						input_array.put (upper_set, inp_ut)
					else
						upper_set := upper_set or (lower_set);
						input_array.put (upper_set, inp_ut);
						input_array.put (upper_set, inp_ut - Case_diff)
					end
				end
			end
		end; -- remove_case_sensitiveness

	trace is
			-- Output an internal representation of the current object.
		local
			index, inp_ut: INTEGER;
			set: FIX_INT_SET;
			epsilon_list: LINKED_LIST[INTEGER]
		do
			from
			until
				index = nb_states
			loop
				index := index + 1;
				io.putstring (" State # ");
				io.putint (index);
				if final_array.item (index) /= 0 then
					io.putstring (" final state of token type: ");
					io.putint (final_array.item (index));
				end;
				io.new_line;
				io.putstring (" Epsilon transitions to: ");
				epsilon_list := item (index);
				if epsilon_list /= Void then
					from
						epsilon_list.start
					until
						epsilon_list.after or epsilon_list.empty
					loop
						io.putint (epsilon_list.item);
						io.putstring (" ");
						epsilon_list.forth
					end
				end;
				io.putstring ("%N Inputs with a transition to the following state:%N");
				from
					inp_ut := -1
				until
					inp_ut = greatest_input
				loop
					inp_ut := inp_ut + 1;
					set := input_array.item (inp_ut);
					if set /= Void and then set.has (index) then
						io.putint (inp_ut);
						io.new_line
					end
				end;
				io.new_line
			end
		end -- trace

feature {NONE}

	closure (state: INTEGER): FIX_INT_SET is
			-- Epsilon_closure of ith state which means
			-- set of NFA state reachable from ith
			-- state on epsilon-transition alone.
		require else
			state_in_automaton: state > 0 and state <= nb_states
		local
			stack: LINKED_STACK [INTEGER];
			top, int: INTEGER;
			e_successors_list: LINKED_LIST [INTEGER]
		do
			!!stack.make;
			!!Result.make (nb_states);
			Result.put (state);
			from
				stack.put (state)
			until
				stack.empty
			loop
				top := stack.item;
				stack.remove;
				if item (top) /= Void then
					from
						e_successors_list := item (top);
						e_successors_list.start
					until
						e_successors_list.after or e_successors_list.empty
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
		end; -- closure

	move (initial_set: FIX_INT_SET; i: INTEGER): FIX_INT_SET is
			-- Set of NFA states to which there is a transition on
			-- input i from some NFA state s of initial_set.
			-- Void if the set if empty.
		require else
			possible_input: i >= 0 and i <= greatest_input;
			set_not_Void: initial_set /= Void
		do
			if input_array.item (i) /= Void then
				Result := initial_set and (input_array.item (i));
				if not Result.empty then
					Result := Result.right_shifted (1)
				else
					Result := Void
				end
			end
		end; -- move

	initial_final_designation is
			-- Set the final and initial attributes of dfa,
			-- in harmony with those of Current.
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
						sets_list.after or sets_list.empty
					loop
						if sets_list.item.has (index) then
							dfa_set_final (sets_list.index,
									final_array.item (index));
						end;
						sets_list.forth;
					end
				end
			end
		end; -- initial_final_designation

	dfa_set_final (s, f: INTEGER) is
			-- Assign f to the attribute final of state s.
		do
			dfa.item (s).set_final (final_array.item (f))
		end; -- dfa_set_final

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
						list.after or list.empty
					loop
						set_e_transition (index + shift, list.item + shift);
						list.forth
					end
				end
			end
		end; -- e_include

	find_successors (source, inp_ut: INTEGER): LINKED_LIST [INTEGER] is
			-- Successors of source on inp_ut;
			-- Void if no successor
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			possible_inp_ut: inp_ut >= 0 and inp_ut <= greatest_input
		do
			if input_array.item (inp_ut).has (source) then
				!!Result.make;
				Result.put_right (source + 1)
			end
		end; -- find_successors

	find_e_successors (source: INTEGER): LINKED_LIST [INTEGER] is
			-- Epsilon successors of source;
			-- Void if no successor
		require else
			source_in_automaton: source >= 1 and source <= nb_states
		do
			Result := item (source)
		end; -- find_e_successors

	set_state is
			-- This routine is deferred in NFA,
			-- but is unuseful in PDFA.
		do
		end -- set_state

end -- class PDFA

-- These PDFA have a very special structure.
-- They are NFA but for each state, only one successor is
-- possible, if the input is different of epsilon,
-- and this successor is the following state.
-- For the epsilon transitions each state can have as many
-- successors as possible.
-- Thus, the structure is different for the epsilons transitions,
-- which are recorded in an ARRAY [LINKED_LIST [INTEGER]],
-- and for the others transitions, which are recorded, for
-- each input, in a FIX_INT_SET.

-- For the use in a regular expression context, keywords
-- can be associated with Current.


 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel 3,
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
