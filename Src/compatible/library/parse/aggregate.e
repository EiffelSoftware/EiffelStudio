note

	description:
		"Constructs whose specimens are obtained %
		%by concatenating specimens of constructs %
		%of zero or more specified constructs"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class AGGREGATE inherit

	CONSTRUCT
		rename
			is_leaf as no_components
		redefine
			commit
		end

feature -- Status report

	left_recursion: BOOLEAN
			-- Is the construct's definition left-recursive?
		local
			end_loop: BOOLEAN;
			l_child: like child
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
					end_loop or no_components or child_after or Result
				loop
					Result := not message_construction;
					l_child := child
					check l_child_not_void: l_child /= Void end -- Implied from `child_after'.
					end_loop := not l_child.is_optional;
					child_forth
				end
			end;
			structure_list.search (production);
			structure_list.remove;
			structure_list.go_i_th (0)
		end

feature -- Transformation

	commit
			-- If this construct is one among several possible ones,
			-- discard the others.
		require else
			only_commit_once: not has_commit
		do
			has_commit := True;
			commit_value := production.index - 1
		end

	has_commit: BOOLEAN
			-- Is current aggregate committed?


feature {NONE} -- Implementation

	commit_value: INTEGER;
			-- Threshold of successfully parsed subconstructs
			-- above which the construct is commited


	expand
			-- Expand the next field of the aggregate.
		do
			expand_next;
			if has_commit and commit_value < child_index then
				committed := True
			end
		end;

	parse_body
			-- Attempt to find input matching the components of
			-- the aggregate starting at current position.
			-- Set parsed to true if successful.
		require else
			no_child: no_components
		local
			wrong: BOOLEAN;
			l_child: like child
		do
			from
				expand
			until
				wrong or no_components or child_after
			loop
				parse_child;
				l_child := child
				check l_child_not_void: l_child /= Void end -- Implied from `child_after'.
				wrong :=  not l_child.parsed;
				if not wrong then
					expand
				end
			end;
			complete := not wrong
			from
				child_start
			until
				no_components or child_after
			loop
				l_child := child
				check l_child_not_void: l_child /= Void end -- Implied from `child_after'.
				if l_child.is_optional and then l_child.parsed and then not l_child.complete then
					remove_child
				else
					child_forth
				end
			end
		end;

	in_action
			-- Perform semantics of the child constructs.
		local
			l_child: like child
		do
			from
				child_start
			until
				no_components or child_after
			loop
				l_child := child
				check l_child_not_void: l_child /= Void end -- Implied from `child_after'.
				l_child.semantics;
				child_forth
			end
		end

feature {CONSTRUCT} -- Implementation

	check_recursion
			-- Check the aggregate for left recursion.
		local
			not_optional_found, b: BOOLEAN
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
					check l_child_not_void: l_child /= Void end -- Implied from `child_after'.
					if not_optional_found then
						l_child.expand_all;
						b := not l_child.left_recursion;
						if child_recursion.item then
							child_recursion.put (False)
						else
							l_child.check_recursion
						end;
						child_forth
					else
						l_child.expand_all;
						l_child.check_recursion;
						not_optional_found := not l_child.is_optional;
						child_forth
					end
				end
			end
		end  -- check_recursion

feature {NONE} -- Implementation

	print_children
			-- Print content of aggregate.
		do
			from
				child_start;
				print_name;
				io.put_string (" :    ")
			until
				no_components or child_after
			loop
				print_child;
				io.put_string (" ");
				child_forth
			end;
			io.new_line
		end;

	print_child
			-- Print active child name,
			-- with square brackets if optional.
		require
			child_not_void: child /= Void
		local
			l_child: like child
		do
			l_child := child
			check l_child_not_void: l_child /= Void end -- Implied from `child_after'.
			if l_child.is_optional then
				io.put_character ('[')
			end;
			l_child.print_name;
			if l_child.is_optional then
				io.put_character (']')
			end
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




end -- class AGGREGATE

