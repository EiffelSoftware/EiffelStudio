indexing

	description:
		"Constructs whose specimens are sequences of specimens %
		%of a specified base construct, delimited by a specified separator";

	status: "See notice at end of class";
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

	left_recursion: BOOLEAN is
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

	expand_all is
			-- Expand all child constructs.
		do
			if no_components then
				expand
			end
		end; 

	check_recursion is
			-- Check the sequence for left recursion.
		do
			if not check_recursion_list.has (production) then
				check_recursion_list.extend (production);
				if print_mode.item then
					print_children
				end;
				child_start;
				child.expand_all;
				child.check_recursion
			end
		end 

feature {NONE} -- Implementation

	separator: STRING is 
			-- List separator in the descendant,
			-- must be defined as a keyword in the lexical analyzer
		deferred 
		end; 

	separator_code: INTEGER is 
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

	commit_on_separator : BOOLEAN is
			-- Is one element of the sequence and a separator enough to
			-- commit the sequence?
			-- (This is true by default, but not where the same
			-- production may have different parents with a
			-- choice construct as a common ancestor of the parents)
		do
			Result := True
		end; 

	has_separator: BOOLEAN is
			-- Has the sequence a separator?
		do
			Result := separator_code /= -1
		end; 

	expand is
			-- Create next construct to be parsed and insert it in
			-- the list of the items of the sequence.
		local
			n: CONSTRUCT
		do
			n := clone (production.first);
			field (n)
		end; 

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
		end; 

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
		end; 

	middle_action is
			-- Execute this after parsing each child.
			-- Does nothing by default; may be redefined in descendants.
		do
		end;

	print_children is
			-- Print content of sequence,
			-- optional are between square brackets.
		do
			print_name;
			io.put_string (" :	");
			child_start;
			if child.is_optional then
				io.put_character ('[')
			end;
			child.print_name;
			if child.is_optional then
				io.put_character (']')
			end;
			io.put_string (" ..");
			child_forth;
			if has_separator then
				io.put_string (" ");
				print_keyword
			end;
			io.new_line
		end; 

	print_keyword is
			-- Print separator string.
		do
			io.put_character ('"');
			io.put_string (document.keyword_string (separator_code));
			io.put_string ("%" ")
		end 

end -- class REPETITION

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
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

