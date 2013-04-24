note

	description:
		"Constructs whose specimens are specimens of constructs %
		%chosen among a specified list."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class CHOICE inherit

	CONSTRUCT
		rename
			put_component as branch,
			is_leaf as no_components
		end

feature -- Access

	retained: detachable CONSTRUCT;
			-- Child which matches the input document;
			-- Void if none.

feature -- Status report

	left_recursion: BOOLEAN
			-- Is the construct's definition left-recursive?
		do
			if structure_list.has (production) then
				global_left_recursion.put (True);
				child_recursion.put (True);
				recursion_message.append (construct_name);
				recursion_message.append ("%N");
				Result := True
			else
				from
					structure_list.put_right (production);
					child_start;
					Result := False
				until
					no_components or child_after or Result
				loop
					Result := not message_construction;
					child_forth
				end
			end;
			structure_list.start;
			structure_list.search (production);
			structure_list.remove;
			structure_list.go_i_th (0)
		end;

feature {CONSTRUCT} -- Implementation

	check_recursion
			-- Check choice construct for left recursion.
		local
			l_child: like child
		do
			if not check_recursion_list.has (production) then
				check_recursion_list.extend (production);
				if print_mode.item then
					print_children
				end;
				from
					child_start
				until
					no_components or child_after
				loop
					l_child := child
					check l_child /= Void end -- Implied from the `child_after'.
					l_child.check_recursion;
					child_forth
				end
			end
		end

feature {NONE} -- Implementation

	print_children
			-- Print children separated with a bar.
		local
			l_child: like child
		do
			print_name;
			io.put_string (" :    ");
			from
				child_start
			until
				no_components or child_after
			loop
				l_child := child
				check l_child /= Void end -- Implied from the `child_after'.
				l_child.print_name;
				child_forth;
				if not child_after then
					io.put_string (" | ")
				end
			end;
			io.new_line
		end;

	expand
			-- Create list of possible choices.
		do
			expand_next
		end;

	parse_body
			-- Try each possible expansion and keep
			-- the one that works.
		local
			initial_document_position: INTEGER
			l_child: like child
		do
			from
				initial_document_position := document.index;
				expand
			until
				no_components or child_after or retained /= Void
			loop
				parse_child;
				l_child := child
				check l_child /= Void end -- Implied from the `child_after'.
				if l_child.parsed then
					retained := l_child
				else
					document.go_i_th (initial_document_position)
				end;
				expand
			end;
			complete := retained /= Void;
			wipe_out;
		-- A choice, once parsed, is not used as a tree node: it
		-- has only one child which is accessed through 'retained'
		end;

	in_action
		do
			if attached retained as l_retained then
				l_retained.semantics
			end
		end;

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




end -- class CHOICE

