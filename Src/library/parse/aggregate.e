indexing

	description:
		"Constructs whose specimens are obtained %
		%by concatenating specimens of constructs %
		%of zero or more specified constructs";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class AGGREGATE inherit

	CONSTRUCT
		rename
			is_leaf as no_components
		redefine
			commit
		end

feature -- Semantics 

	commit is
			-- If this construct is one among several possible ones,
			-- discard the others.
		require else
			only_commit_once: not has_commit 
		do
			has_commit := true;
			commit_value := production.index - 1
		end -- commit

feature {NONE} -- Implementation

	commit_value: INTEGER;
			-- Threshold of successfully parsed subconstructs
			-- above which the construct is commited

	has_commit: BOOLEAN
			-- Is current aggregate committed?


	expand is
			-- Expand the next field of the aggregate.
		do
			expand_next;
			if has_commit and commit_value < child_index then
				committed := true
			end
		end; -- expand

	parse_body is
			-- Attempt to find input matching the components of
			-- the aggregate starting at current position.
			-- Set parsed to true if successful.
		require else
			no_child: no_components
		local
			wrong: BOOLEAN;
			err: STRING
		do
			from
				expand
			until
				wrong or no_components or child_after
			loop
				parse_child;
				wrong :=  not child.parsed;
				if not wrong then
					expand
				end
			end;
			complete := not wrong
		end; -- parse_body

	in_action is
			-- Perform semantics of the child constructs.
		do
			from
				child_start
			until
				no_components or child_after 
			loop
				child.semantics;
				child_forth
			end
		end -- in_action

feature 

		--  Routines for checking the grammar for left recursion

	no_left_recursion: BOOLEAN is
			-- Is the construct's production free of left recursion?
		local
			end_loop: BOOLEAN;
		do
			if structure_list.has (production) then
				left_recursion.put (true);
				child_recursion.put (true);
				recursion_message.append (construct_name);
				recursion_message.append ("%N");
				Result := false
			else
				from
					structure_list.add_right (production);
					child_start;
					Result := true
				until
					end_loop or no_components or child_after or not Result
				loop
					Result := message_construction;
					end_loop := not child.is_optional;
					child_forth
				end
			end;
			structure_list.search (production);
			structure_list.remove;
			structure_list.go_i_th (0)
		end -- no_left_recursion

feature {CONSTRUCT}

	check_recursion is
			-- Check the aggregate for left recursion.
		local
			not_optional_found, b: BOOLEAN
		do
			if not check_recursion_list.has (production) then
				check_recursion_list.add_left (production);
				if print_mode.item then
					print_children
				end;
				from
					child_start
				until
					no_components or child_after
				loop
					if not_optional_found then
						child.expand_all;
						b := child.no_left_recursion;
						if child_recursion.item then
							child_recursion.put (false)
						else
							child.check_recursion
						end;
						child_forth
					else
						child.expand_all;
						child.check_recursion;
						not_optional_found := not child.is_optional;
						child_forth
					end
				end
			end
		end  -- check_recursion

feature {NONE}

	print_children is
			-- Print content of aggregate.
		do
			from
				child_start;
				print_name;
				io.putstring (" :    ")
			until
				no_components or child_after
			loop
				print_child;
				io.putstring (" ");
				child_forth
			end;
			io.new_line
		end; -- print_children

	print_child is
			-- Print active child name,
			-- with square brackets if optional.
		do
			if child.is_optional then
				io.putchar ('[')
			end;
			child.print_name;
			if child.is_optional then
				io.putchar (']')
			end
		end

end -- class AGGREGATE
 

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel 3,
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
