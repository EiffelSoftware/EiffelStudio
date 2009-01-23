note

	description:
		"Non-deterministic finite state automata"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class NDFA inherit

	AUTOMATON

feature -- Access

	dfa: ?FIXED_DFA;
			-- DFA built by routine construct_dfa,
			-- which recognizes the same language.

	find_successors (source, input_doc: INTEGER): ?LINKED_LIST [INTEGER]
			-- Successors of `source' on `input_doc';
			-- Void if no successor
		require
			source_in_automaton: source >= 1 and source <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		deferred
		end;

	find_e_successors (source: INTEGER): ?LINKED_LIST [INTEGER]
			-- Epsilon successors of source.
			-- Void if no successor.
		require
			source_in_automaton: source >= 1 and source <= nb_states
		deferred
		end

feature -- Element change

	set_transition (source, input_doc, target: INTEGER)
			-- Set transition from `source' to `target' for `input_doc'.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		deferred
		end;

	set_e_transition (source, target: INTEGER)
			-- Set epsilon transition from `source' to `target'.
		require
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states
		deferred
		end;

feature -- Removal

	delete_transition (source, input_doc, target: INTEGER)
			-- Delete transition from `source' to `target' on `input_doc'.
		require
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		deferred
		end;

feature -- Transformation

	construct_dfa
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
			dstates: LINKED_DFA
			state: STATE_OF_DFA
			state_memory: ?STATE_OF_DFA
			set, e_set: ?FIXED_INTEGER_SET
			old_move, current_set: FIXED_INTEGER_SET
			input_doc, old_index: INTEGER
			l_dfa: like dfa
			l_sets_list: like sets_list
		do
			build_closures
			create l_sets_list.make
			sets_list := l_sets_list
			create set_tree.make_filled (nb_states, 0)
			e_set := closure (start_number)
			search_in_tree (e_set)
			l_sets_list.put_right (e_set)
			create old_move.make (nb_states)
			from
				create dstates.make (greatest_input)
				dstates.set_state
			until
				dstates.after or dstates.is_empty
			loop
				state := dstates.item
				old_index := dstates.index
				l_sets_list.go_i_th (old_index)
				current_set := l_sets_list.item
				from
					input_doc := 0
				until
					input_doc = greatest_input + 1
				loop
					set := move (current_set, input_doc)
					if set /= Void then
						if set.is_equal (old_move) then
							state.append_transition (input_doc, state_memory)
						else
							old_move := set
							e_set := epsilon_closure (set)
							check e_set_attached: e_set /= Void end
							search_in_tree (e_set)
							if new_set then
								dstates.set_state
								l_sets_list.finish
								l_sets_list.put_right (e_set)
							end
							dstates.go_i_th (set_position)
							state_memory := dstates.item
							state.append_transition (input_doc, state_memory)
						end
					end
					input_doc := input_doc + 1
				end
				dstates.go_i_th (old_index + 1)
			end
			l_dfa := dstates.lcopy
			dfa := l_dfa
			initial_final_designation
			debug ("lex_output")
				l_dfa.trace
			end
		ensure
			-- Current and dfa recognize the same language.
			sets_list_attached: sets_list /= Void
			set_tree_attached: set_tree /= Void
		end

feature {NONE} -- Implementation

	sets_list: ?TWO_WAY_LIST [FIXED_INTEGER_SET];
			-- Sets used in construct_dfa:
			-- Each dfa state is associated with a FIXED_INTEGER_SET
			-- of NDFA states

	new_set: BOOLEAN;
			-- Was there a creation in last search_in_tree?

	new_number: INTEGER;
			-- Used to search a set in sets_list

	set_tree: ?FIXED_TREE [INTEGER];
			-- Used to search a set in sets_list:
			-- This tree is built by "search_in_tree" and
			-- contains the same informations as sets_list,
			-- but is quicker to use to find the position of a set

	set_position: INTEGER;
			-- Position of the last searched set in sets_list

	closures: ?ARRAY [FIXED_INTEGER_SET];
			-- Each element of this array represents the
			-- epsilon closure of one NDFA state

	epsilon_closure (initial_set: FIXED_INTEGER_SET): ?FIXED_INTEGER_SET
			-- Epsilon-closure of initial_set:
			-- set of NDFA states
			-- reachable from some NDFA states in initial_set
			-- on epsilon-transition alone
		require
			closures_exists: closures /= Void
		local
			l_closures: like closures
			index, last_index: INTEGER
		do
			l_closures := closures
				--| Implied from precondition
			check l_closures_attached: l_closures /= Void end

			create Result.make (initial_set.count);
			last_index := initial_set.count;
			from
				index := initial_set.smallest
			until
				index > last_index
			loop
				Result := Result or (l_closures.item (index));
				index := initial_set.next (index)
			end
		end;

	build_closures
			-- Build the array closures, which is used
			-- in epsilon_closure.
		local
			l_closures: like closures
			index: INTEGER
		do
			create l_closures.make (1, nb_states);
			from
				index := 0
			until
				index = nb_states
			loop
				index := index + 1;
				l_closures.put (closure (index), index)
			end
			closures := l_closures
		ensure
			closures_attached: closures /= Void
		end;

	search_in_tree (set: FIXED_INTEGER_SET)
			-- Search set in set_tree. If set is not found,
			-- insert set in set_tree.
			-- Change the value of "set_position" and set it
			-- to the position of set in sets_list.
		require
			set_no_void: set /= Void;
			set_no_empty: not set.is_empty
			set_tree_attached: set_tree /= Void
		local
			index, last_index: INTEGER;
			current_tree, new_tree, child: ?FIXED_TREE [INTEGER]
		do
			debug ("lex_output")
				set.print
			end
			last_index := set.largest
			current_tree := set_tree
				--| Implied by precondition
			check current_tree_attached: current_tree /= Void end
			from
				index := set.smallest
			until
				index > last_index
			loop
				debug ("lex_output")
					io.put_string ("Arity: ")
					io.put_integer (current_tree.arity)
					io.new_line
					io.put_string ("Index: ")
					io.put_integer (index)
					io.new_line
				end
				current_tree.child_go_i_th (index)
				child := current_tree.child
				check child_attached: child /= Void end
				if child.arity = 0 then
					create new_tree.make_filled (nb_states, 0)
					current_tree.replace_child (new_tree)
				end
				current_tree := current_tree.child
				check current_tree_attached: current_tree /= Void end
				index := set.next (index)
			end
			set_position := current_tree.item
			if set_position = 0 then
				new_number := new_number + 1
				current_tree.put (new_number)
				set_position := new_number
				new_set := True
			else
				new_set := False
			end
		end

	closure (i: INTEGER): FIXED_INTEGER_SET
			-- Epsilon_closure of ith state which means
			-- set of NDFA state reachable from ith
			-- state on epsilon-transition alone
		require
			i_in_automaton: i > 0 and i <= nb_states
		deferred
		ensure
			result_attached: Result /= Void
			i_in_closure: Result.has (i)
		end;

	move (initial_set: FIXED_INTEGER_SET; i: INTEGER): ?FIXED_INTEGER_SET
			-- Set of NDFA states to which there is a transition on
			-- input i from some NDFA state s of initial_set;
			-- Void if the set if empty
			-- Secret
		deferred
		end;

	initial_final_designation
			-- Set the final and initial attributes of dfa,
			-- consistent with those of the current automaton.
		require
			dfa_exists: dfa /= Void
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class NDFA

