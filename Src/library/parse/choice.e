--|---------------------------------------------------------------
--|   Copyright (C) 1993 Interactive Software Engineering, Inc. --
--|   270 Storke Road, Suite 7 Goleta, California 93117         --
--|               (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Constructs whose specimens are specimens of constructs
-- chosen among a specified list.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class CHOICE 

inherit

	CONSTRUCT
		rename
			add_component as branch,
			is_leaf as no_components
		end

feature 

	retained: CONSTRUCT;
			-- Child which matches the input document;
			-- Void if none

	no_left_recursion: BOOLEAN is
			-- Is the construct free of left recursion?
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
					no_components or child_after or not Result
				loop
					Result := message_construction;
					child_forth
				end
			end;
			structure_list.start;
			structure_list.search (production);
			structure_list.remove;
			structure_list.go_i_th (0)
		end -- no_left_recursion

feature {CONSTRUCT}

	check_recursion is
			-- Check choice construct for left recursion.
		local
			b: BOOLEAN
		do
			if not check_recursion_list.has (production) then
				check_recursion_list.put_left (production);
				if print_mode.item then
					print_children
				end;
				from
					child_start
				until
					no_components or child_after
				loop
					child.check_recursion;
					child_forth
				end
			end
		end -- check_recursion

feature {NONE}

	print_children is
			-- Print children separated with a bar.
		do
			print_name;
			io.putstring (" :    ");
			from
				child_start
			until
				no_components or child_after
			loop
				child.print_name;
				child_forth;
				if not child_after then
					io.putstring (" | ")
				end
			end;
			io.new_line
		end; -- print_children

	expand is
			-- Create list of possible choices.
		do
			expand_next
		end; -- expand

	parse_body is
			-- Try each possible expansion and keep
			-- the one that works.
		local
			initial_document_position: INTEGER
		do
			from
				initial_document_position := document.index;
				expand
			until
				no_components or child_after or retained /= Void
			loop
				parse_child;
				if child.parsed then
					retained := child
				else
					document.go_i_th (initial_document_position)
				end;
				expand
			end;
			complete := retained /= Void;
			wipe_out;
		-- A choice, once parsed, is not used as a tree node: it
		-- has only one child which is accessed through 'retained'
		end; -- parse_body

	in_action is
		do
			if retained /= Void then
				retained.semantics
			end
		end -- in_action

end -- class CHOICE
