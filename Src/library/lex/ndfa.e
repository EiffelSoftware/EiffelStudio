indexing

	description:
		"Non-deterministic finite state automata";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class NDFA inherit

	AUTOMATON

feature -- Access

	dfa: FIXED_DFA;
			-- DFA built by routine construct_dfa,
			-- which recognizes the same language.

	find_successors (source, input_doc: INTEGER): LINKED_LIST [INTEGER] is
			-- Successors of `source' on `input_doc';
			-- Void if no successor
		require
			source_in_automaton: source >= 1 and source <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		deferred
		end; 

	find_e_successors (source: INTEGER): LINKED_LIST [INTEGER] is
			-- Epsilon successors of source.
			-- Void if no successor.
		require
			source_in_automaton: source >= 1 and source <= nb_states
		deferred
		end 

feature -- Element change

	set_transition (source, input_doc, target: INTEGER) is
			-- Set transition from `source' to `target' for `input_doc'.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		deferred
		end; 

	set_e_transition (source, target: INTEGER) is
			-- Set epsilon transition from `source' to `target'.
		require
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states
		deferred
		end; 

feature -- Removal

	delete_transition (source, input_doc, target: INTEGER) is
			-- Delete transition from `source' to `target' on `input_doc'.
		require
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		deferred
		end; 

feature -- Transformation

	construct_dfa is
			-- Create an equivalent deterministic finite automaton.
			--| This algorithm is extracted from
			--| "Compilers: Principles, Techniques and Tools",
			--| from AHO, SETHI, ULLMAN, page 117, and is described
			--| as follows:
			--| "The general idea behind the NDFA-to-DFA construction"
			--| "is that each DFA state corresponds to a set of NDFA"
			--| "states. The DFA uses its state to keep track of all"
			--| "possible states the NDFA can be in after reading"
			--| "each input symbol. That is to say, after reading"
			--| "input a1a2a3..an, the DFA is in a state that"
			--| "represents the subset e_set of the states"
			--| "of the states that are reachable from the NDFA's start"
			--| "state along some path labeled a1-a2-..-an."
			--| Since it is impossible to know what the length of
			--| the DFA will be, this routine builds a linked DFA,
			--| then copy it in a fixed DFA (array), and then set
			--| the attributes `final' of the DFA to be consistent
			--| with those of Current.
		require
			start_number_designated: start_number > 0
		local
			dstates: LINKED_DFA;
			state, state_memory: STATE_OF_DFA;
			set, e_set, old_move, current_set: FIXED_INTEGER_SET;
			input_doc, old_index: INTEGER
		do
			build_closures;
			!! sets_list.make;
			!! set_tree.make (nb_states, 0);
			e_set := closure (start_number);
			search_in_tree (e_set);
			sets_list.put_right (e_set);
			!! old_move.make (nb_states);
			from
				!! dstates.make (greatest_input);
				dstates.set_state
			until
				dstates.after or dstates.is_empty
			loop
				state := dstates.item;
				old_index := dstates.index;
				sets_list.go_i_th (old_index);
				current_set := sets_list.item;
				from
					input_doc := 0
				until
					input_doc = greatest_input + 1
				loop
					set := move (current_set, input_doc);
					if set /= Void then
						if set.is_equal (old_move) then
							state.append_transition (input_doc, state_memory)
						else
							old_move := set;
							e_set := epsilon_closure (set);
							search_in_tree (e_set);
							if new_set then
								dstates.set_state;
								sets_list.finish;
								sets_list.put_right (e_set)
							end;
							dstates.go_i_th (set_position);
							state_memory := dstates.item;
							state.append_transition (input_doc, state_memory);
						end
					end;
					input_doc := input_doc + 1
				end;
				dstates.go_i_th (old_index + 1);
			end;
			dfa := dstates.lcopy;
			initial_final_designation;
			debug
				dfa.trace
			end
		ensure
			-- Current and dfa recognize the same language.
		end; 

feature {NONE} -- Implementation

	sets_list: TWO_WAY_LIST [FIXED_INTEGER_SET];
			-- Sets used in construct_dfa:
			-- Each dfa state is associated with a FIXED_INTEGER_SET
			-- of NDFA states

	new_set: BOOLEAN;
			-- Was there a creation in last search_in_tree?

	new_number: INTEGER;
			-- Used to search a set in sets_list

	set_tree: FIXED_TREE [INTEGER];
			-- Used to search a set in sets_list:
			-- This tree is built by "search_in_tree" and
			-- contains the same informations as sets_list,
			-- but is quicker to use to find the position of a set

	set_position: INTEGER;
			-- Position of the last searched set in sets_list

	closures: ARRAY [FIXED_INTEGER_SET];
			-- Each element of this array represents the
			-- epsilon closure of one NDFA state

	epsilon_closure (initial_set: FIXED_INTEGER_SET): FIXED_INTEGER_SET is
			-- Epsilon-closure of initial_set:
			-- set of NDFA states
			-- reachable from some NDFA states in initial_set
			-- on epsilon-transition alone
		require
			closures_exists: closures /= Void
		local
			index, last_index: INTEGER
		do
			!! Result.make (initial_set.count);
			last_index := initial_set.count;
			from
				index := initial_set.smallest
			until
				index > last_index
			loop
				Result := Result or (closures.item (index));
				index := initial_set.next (index)
			end
		end; 

	build_closures is
			-- Build the array closures, which is used
			-- in epsilon_closure.
		local
			index: INTEGER
		do
			!! closures.make (1, nb_states);
			from
				index := 0
			until
				index = nb_states
			loop
				index := index + 1;
				closures.put (closure (index), index)
			end
		end; 

	search_in_tree (set: FIXED_INTEGER_SET) is
			-- Search set in set_tree. If set is not found,
			-- insert set in set_tree.
			-- Change the value of "set_position" and set it
			-- to the position of set in sets_list.
		require
			set_no_void: set /= Void;
			set_no_empty: not set.is_empty
		local
			index, last_index: INTEGER;
			current_tree, new_tree: FIXED_TREE [INTEGER]
		do
			debug
				set.print;
			end;
			last_index := set.largest;
			current_tree := set_tree;
			from
				index := set.smallest
			until
				index > last_index
			loop
				debug
					io.put_string ("Arity: ")
					io.put_integer (current_tree.arity)
					io.new_line
					io.put_string ("Index: ")
					io.put_integer (index)
					io.new_line
				end
				current_tree.child_go_i_th (index);
				if current_tree.child = Void then
					!! new_tree.make (nb_states, 0);
					current_tree.put_child (new_tree)
				end;
				current_tree := current_tree.child;
				index := set.next (index)
			end;
			set_position := current_tree.item;
			if set_position = 0 then
				new_number := new_number + 1;
				current_tree.put (new_number);
				set_position := new_number;
				new_set := True
			else
				new_set := False
			end
		end; 

	closure (i: INTEGER): FIXED_INTEGER_SET is
			-- Epsilon_closure of ith state which means
			-- set of NDFA state reachable from ith
			-- state on epsilon-transition alone
		require
			i_in_automaton: i > 0 and i <= nb_states
		deferred
		ensure
			i_in_closure: Result.has (i)
		end; 

	move (initial_set: FIXED_INTEGER_SET; i: INTEGER): FIXED_INTEGER_SET is
			-- Set of NDFA states to which there is a transition on
			-- input i from some NDFA state s of initial_set;
			-- Void if the set if empty
			-- Secret
		deferred
		end; 

	initial_final_designation is
			-- Set the final and initial attributes of dfa,
			-- consistent with those of the current automaton.
		require
			dfa_exists: dfa /= Void
		deferred
		end

end -- class NDFA
 
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

