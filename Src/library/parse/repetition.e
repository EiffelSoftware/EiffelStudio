indexing

	description:
		"Constructs whose specimens are sequences of specimens %
		%of a specified base construct, delimited by a specified separator";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class REPETITION inherit

	CONSTRUCT
		rename
			add_component as field,
			is_leaf as no_components
		redefine
			expand_all
		end

feature {NONE}

	separator: STRING is 
			-- List separator in the descendant,
			-- must be defined as a keyword in the lexical analyser
		deferred 
		end; -- separator

	separator_code: INTEGER is 
			-- Code of the keyword-separator; -1 if none
			-- (according to lexical code)
		local
			separator_not_keyword: EXCEPTIONS
		do
			if separator /= Void then 
				Result := document.keyword_code (separator);
				if Result = -1 then
					!!separator_not_keyword;
					separator_not_keyword.raise( "separator_not_keyword" );
				end
			else
				Result := -1
			end
		end; -- separator_code

	commit_on_separator : BOOLEAN is
			-- Is one element of the sequence and a separator enough to
			-- commit the sequence?
			-- (This is true by default, but not where the same
			-- production may have different parents with a
			-- choice construct as a common ancestor of the parents)
		do
			Result := true
		end; -- commit_on_separator

	has_separator: BOOLEAN is
			-- Has the sequence a separator?
		do
			Result := separator_code /= -1
		end; -- has_separator

	expand is
			-- Create next construct to be parsed and insert it in
			-- the list of the elements of the sequence.
		local
			n: CONSTRUCT
		do
			n := clone (production.first);
			field (n)
		end; -- expand

	parse_body is
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
				separator_found := false;
				child_found := false;
				if has_separator then
					separator_found := document.token.is_keyword (separator_code);
					if separator_found then 
						if commit_on_separator then
							committed := true
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
		end; -- parse

	parse_one: BOOLEAN is
			-- Parse one element of the sequence and
			-- return true if successful.
		local
			tmp_committed: BOOLEAN
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
			Result := child.parsed;
			if not child.parsed then
				remove_child
			end
		end; -- parse_one

	in_action is
			-- Execute semantic actions on current construct
			-- by executing actions on children in sequence.
		do
			if not no_components then
				from
					child_start
				until
					child_after
				loop
					child.semantics;
					middle_action;
					child_forth
				end
			end
		end; -- in_action	

	middle_action is
			-- Execute this after parsing each child.
			-- Do nothing here.
		do
		end -- middle_action

feature 

		--  Routines for checking the grammar for left recursion

	no_left_recursion: BOOLEAN is
			-- Is the construct's production free of left recursion?
		do
			if structure_list.has (production) then
				left_recursion.put (true);
				child_recursion.put (true);
				recursion_message.append (construct_name);
				recursion_message.append ("%N");
				Result := false;
			else
				structure_list.put_right (production);
				child_start;
				Result := message_construction
			end;
			structure_list.search (production);
			structure_list.remove;
			structure_list.go_i_th (0)
		end -- no_left_recursion

feature {CONSTRUCT}

	expand_all is
			-- Expand all child constructs.
		do
			if no_components then
				expand
			end
		end; -- expand_all

	check_recursion is
			-- Check the sequence for left recursion.
		do
			if not check_recursion_list.has (production) then
				check_recursion_list.put_left (production);
				if print_mode.item then
					print_children
				end;
				child_start;
				child.expand_all;
				child.check_recursion
			end
		end -- check_recursion

feature {NONE}

	print_children is
			-- Print content of sequence,
			-- optional are between square brackets.
		do
			print_name;
			io.putstring (" :	");
			child_start;
			if child.is_optional then
				io.putchar ('[')
			end;
			child.print_name;
			if child.is_optional then
				io.putchar (']')
			end;
			io.putstring (" ..");
			child_forth;
			if has_separator then
				io.putstring (" ");
				print_keyword
			end;
			io.new_line
		end; -- print_children

	print_keyword is
			-- Print separator string.
		do
			io.putchar ('"');
			io.putstring (document.keyword_string (separator_code));
			io.putstring ("%" ")
		end -- print_keyword

end -- class REPETITION
 

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
