indexing

	description:
		"The general notion of language construct,  %
		%characterized by a grammatical production %
		%and associated semantic actions";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class CONSTRUCT inherit

	TWO_WAY_TREE [CONSTRUCT]
		rename
			put as twt_put,
			make as twt_make
		redefine 
			parent, new_cell
		end

feature

	make is
		do
			twt_make (Void)
		end; -- make

	document: INPUT is
			-- Interface the document to parse,
			-- through a lexical analyser
		once
			!!Result.make
		end -- document

feature 

	process is
			-- Parse a specimen of the construct,
			-- then apply semantic actions
			-- if the parse is successful.
		do
			parse;
			if parsed then
				semantics
			end
		end; -- process

	parse is
			-- Attempt to analyze incoming lexical
			-- tokens according to current construct. 
			-- Set `parsed' to true if successful; 
			-- return to original position in input otherwise.
		local
			initial_document_position: INTEGER
		do
			initial_document_position := document.index;
			parsed := false;
			complete := false;
			committed := false;
			parse_body;
			if not complete and is_optional then
				document.go_i_th (initial_document_position);
				parsed := not committed
			else
				parsed := complete
			end;                                    
		end; -- parse

	parsed: BOOLEAN;
			-- Has construct been successfully parsed?
			-- (True for optional components not present)

	commit is
            -- If this construct is one among several possible ones,
            -- discard the others.
				-- By default this does nothing.
		do
		end; -- commit

	committed: BOOLEAN
			-- Have enough productions been recognized, to interpret
			-- failure of parsing as a syntax error in this construct?
			-- (Otherwise the parsing process will backtrack, trying other
			-- possible interpretations of the document read so far.)

feature {NONE}

	complete: BOOLEAN
			-- Has the construct been completely recognised?
			-- (Like parsed, but it must be there to qualify in
			-- case of an optional construct)

feature 

	print_name is
			-- Print the construct name on standard output.
		do
			io.putstring (construct_name)
		end -- print_name

feature {CONSTRUCT}

	parent: CONSTRUCT;
			-- Parent of current construct

	new_cell (v: like item): like item is
		do
			Result := v
		end -- new_cell

feature 

	semantics is
			-- Apply semantic actions in order:
			-- `pre_action, in_action, post_action'.
		do
			pre_action;
			in_action;
			post_action
		end; -- semantics

	pre_action is
			-- Do nothing here.
		do
		end; -- pre_action

	post_action is
			-- Do nothing here.
		do
		end; -- post_action

	is_optional: BOOLEAN;
			-- Is construct optional? 

	production: LINKED_LIST [CONSTRUCT] is 
			-- Right-hand side of the production for the construct
		deferred 
		end -- production

feature {NONE}

	put (c: CONSTRUCT) is
			-- Add a construct to the production.
		do  
			production.put_left (c);
			last_sub_construct := c
		end; -- put

	last_sub_construct: CONSTRUCT;
			-- Subconstruct most recently added to the production

	make_optional is
			-- Make the last entered subconstruct optional.
		do
			last_sub_construct.set_optional
		end; -- make_optional

	keyword (s: STRING) is
			-- Insert a keyword in the production.
		local
			key: KEYWORD
		do     
			!!key.make (s);
			put (key)
		end; -- keyword

	expand_next is
			-- Expand the next child of current node
			-- after current child.
			-- This is the most likely version of expand
			-- for types of construct where each subconstruct
			-- must be expanded in turn.
		local
			n: CONSTRUCT
		do
			if not production.empty then
				production.go_i_th (child_index + 1);
				if not production.after then
					n := clone (production.item);
					add_component (n)
				else
					child_finish;
					child_forth
				end
			else
				child_finish;
				child_forth
			end
		end; -- expand_next

	expand is
			-- Create next construct to be parsed.
			-- Used by `parse' to build the production
			-- that is expected at each node, according to `production'.
		deferred
		end;

	add_component (new: CONSTRUCT) is
			-- Add a new component to expand the production.
			-- Note that the components are always added in
			-- the tree node in left to right order.
		do
			child_finish;
			child_put_right (new);
			child_forth
		end -- add_component

feature 

	construct_name: STRING is 
			-- Name of the construct in the grammar
		deferred
		end; -- construct_name

	set_optional is
			-- Set the attribute is_optional to true.
			-- If the production does not match the tokens,
			-- the construct will be parsed anyway.
		do
			is_optional := true
		end -- set_optional

feature {NONE}

	raise_syntax_error (s: STRING) is
			-- Print error message s.
		local
			s2 : STRING
		do  
			s2 := clone (s);
			s2.append (" in "); 
			s2.append (construct_name); 
			if parent /= Void then
				s2.append (" in "); 
				s2.append (parent.construct_name)
			end;
			document.raise_error (s2)
		end;  -- raise_syntax_error

	expected_found_error is
			-- Print an error message saying what was 
			-- expected and what was found.
		local
			err: STRING
		do
			!!err.make (20);
			err.append (child.construct_name);
			err.append (" expected, ");
			if document.token.type = -1 then
				err.append ("end of document found")
			elseif document.token.string_value.count > 0 then
				err.append (document.token.string_value);
				err.append (" found")
			end;
			raise_syntax_error (err)
		end; -- expected_found_error

	structure_list: LINKED_LIST [LINKED_LIST [CONSTRUCT]] is
			-- List of the structures already examined when
			-- searching for left recursion
		once
			!!Result.make
		end; -- structure_list

	check_recursion_list: LINKED_LIST [LINKED_LIST [CONSTRUCT]] is
			-- List of the structures already examined when
			-- checking for left recursion
		once
			!!Result.make
		end -- check_recursion_list

feature {CONSTRUCT}

	check_recursion is 
			-- Check construct for left recursion.
		deferred 
		end -- check_recursion

feature {NONE}

	left_recursion: CELL [BOOLEAN] is 
			-- Is there any left recursion in the whole program?
		once 
			!!Result.put (false)
		end; -- left_recursion

	child_recursion: CELL [BOOLEAN] is 
			-- Is there any recursion in the whole program?
		once 
			!!Result.put (false)
		end -- child_recursion

feature 

	print_mode: CELL [BOOLEAN] is 
			-- Must the left-recursion test also print the production?
		once 
			!!Result.put (false)
		end -- print_mode

feature {NONE}

	recursion_message: STRING is
			-- Error message when left recursion has been detected,
			-- with all productions involved in the recursion chain
		once
			!!Result.make (100)
		end -- recursion_message

feature 

	no_left_recursion: BOOLEAN is 
			-- Is the construct's production free of left recursion?
		deferred 
		end; -- no_left_recursion

feature {NONE}

	message_construction: BOOLEAN is
			-- Has the message on left recursion been already printed?
		do
			child.expand_all;
			Result := child.no_left_recursion;
			if not Result then
				if not structure_list.has (production) then
					structure_list.put_right (production);
					io.putstring ("Left recursion has been detected ");
					io.putstring ("in the following constructs:%N");
					io.putstring (recursion_message);
					io.new_line;
					recursion_message.wipe_out;
					Result := true
				else
					recursion_message.append (construct_name);
					recursion_message.append ("%N")
				end
			elseif Result and not structure_list.has (production) then
				io.putstring ("child.no_left_recursion = true");
				io.putstring ("		and recursion_visited = false%N")
			end
		end; -- message_construction

	in_action is
			-- Perform a certain semantic operation.
		deferred
		end; -- in_action

	parse_body is
			-- Perform any special parsing action for a particular
			-- type of construct.
			-- Call `parse_child' on each child construct.
			-- Set `committed' to true if enough has been 
			-- recognised to freeze the parse tree built so far.
			-- Set `complete' to true if the whole construct has been
			-- correctly recognized.
		deferred
		end -- parse_body

feature {CONSTRUCT}

	expand_all is
			-- Used by recursion checking
		do
			if is_leaf then
				from
					expand
				until
					is_leaf or child_after
				loop
					expand
				end
			end
		end -- expand_all

feature {NONE}

	parse_child is
			-- Parse child recursively to build the tree.
			-- An error is output the first time a parse fails 
			-- in an uncommitted child of a committed parent 
			-- i.e. at the deepest point known to be meaningful.
		do
			child.parse;
			if child.committed then
				committed := true;
			end;
			if committed and not (child.parsed or child.committed) then
				expected_found_error
			end
		end  -- parse_child

end -- class CONSTRUCT
 

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
