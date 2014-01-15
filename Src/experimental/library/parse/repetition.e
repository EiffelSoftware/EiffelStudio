note

	description:
		"Constructs whose specimens are sequences of specimens %
		%of a specified base construct, delimited by a specified separator"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class REPETITION inherit

	CONSTRUCT
		rename
			put_component as field,
			is_leaf as no_components
		redefine
			expand_all
		end

feature -- Status report

	left_recursion: BOOLEAN
			-- Is the construct's definition left-recursive?
		do
			if structure_list.has (production) then
				global_left_recursion.put (True);
				child_recursion.put (True);
				recursion_message.append (construct_name);
				recursion_message.append ("%N");
				Result := True;
			else
				structure_list.put_right (production);
				child_start;
				Result := not message_construction
			end;
			structure_list.search (production);
			structure_list.remove;
			structure_list.go_i_th (0)
		end

feature {CONSTRUCT} -- Implementation

	expand_all
			-- Expand all child constructs.
		do
			if no_components then
				expand
			end
		end;

	check_recursion
			-- Check the sequence for left recursion.
		local
			l_child: like child
		do
			if not check_recursion_list.has (production) then
				check_recursion_list.extend (production);
				if print_mode.item then
					print_children
				end;
				child_start;
				l_child := child
				if l_child /= Void then
					l_child.expand_all;
					l_child.check_recursion
				end
			end
		end

feature {NONE} -- Implementation

	separator: STRING
			-- List separator in the descendant,
			-- must be defined as a keyword in the lexical analyzer
		deferred
		end;

	separator_code: INTEGER
			-- Code of the keyword-separator; -1 if none
			-- (according to lexical code)
		local
			separator_not_keyword: EXCEPTIONS
		do
			if separator /= Void then
				Result := document.keyword_code (separator);
				if Result = -1 then
					create separator_not_keyword;
					separator_not_keyword.raise( "separator_not_keyword" );
				end
			else
				Result := -1
			end
		end;

	commit_on_separator : BOOLEAN
			-- Is one element of the sequence and a separator enough to
			-- commit the sequence?
			-- (This is true by default, but not where the same
			-- production may have different parents with a
			-- choice construct as a common ancestor of the parents)
		do
			Result := True
		end;

	has_separator: BOOLEAN
			-- Has the sequence a separator?
		do
			Result := separator_code /= -1
		end;

	expand
			-- Create next construct to be parsed and insert it in
			-- the list of the items of the sequence.
		local
			n: CONSTRUCT
		do
			n := production.first
			if n /= Void then
				n := n.twin
			end
			field (n)
		end;

	parse_body
			-- Attempt to find a sequence of constructs with separators
			-- starting at current position. Set committed
			-- at first separator if `commit_on_separator' is set.
		local
			child_found, first_child_found: BOOLEAN;
			separator_found, wrong: BOOLEAN
		do
			from
				child_found := parse_one;
				first_child_found := child_found
			until
				not child_found
			loop
				separator_found := False;
				child_found := False;
				if has_separator then
					separator_found := document.token.is_keyword (separator_code);
					if separator_found then
						if commit_on_separator then
							committed := True
						end;
						document.get_token
					end
				end;
				if (not has_separator) or separator_found then
					child_found := parse_one
				end
			end;
			wrong := has_separator and separator_found and not child_found;
			complete := first_child_found and not (committed and wrong)
		end;

	parse_one: BOOLEAN
			-- Parse one element of the sequence and
			-- return true if successful.
		local
			tmp_committed: BOOLEAN
			l_child: like child
		do
			expand;
			if has_separator then
				parse_child
			else
				tmp_committed := committed;
				committed := False;
				parse_child;
				committed := committed or tmp_committed
			end;
			l_child := child
			if l_child /= Void then
				Result := l_child.parsed;
			end
			if not Result then
				remove_child
			end
		end;

	in_action
			-- Execute semantic actions on current construct
			-- by executing actions on children in sequence.
		do
			if not no_components then
				from
					child_start
				until
					child_after
				loop
					if attached child as l_child then
						l_child.semantics;
					end
					middle_action;
					child_forth
				end
			end
		end;

	middle_action
			-- Execute this after parsing each child.
			-- Does nothing by default; may be redefined in descendants.
		do
		end;

	print_children
			-- Print content of sequence,
			-- optional are between square brackets.
		require
			has_child: not is_empty
		local
			l_child: like child
		do
			print_name;
			io.put_string (" :	");
			child_start;
			l_child := child
			if l_child /= Void then
				if l_child.is_optional then
					io.put_character ('[')
				end;
				l_child.print_name;
				if l_child.is_optional then
					io.put_character (']')
				end;
				io.put_string (" ..");
			end
			child_forth;
			if has_separator then
				io.put_string (" ");
				print_keyword
			end;
			io.new_line
		end;

	print_keyword
			-- Print separator string.
		do
			io.put_character ('"');
			io.put_string (document.keyword_string (separator_code));
			io.put_string ("%" ")
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class REPETITION

