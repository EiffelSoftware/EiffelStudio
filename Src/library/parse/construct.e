indexing

	description:
		"The general notion of language construct,  %
		%characterized by a grammatical production %
		%and associated semantic actions";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class CONSTRUCT inherit

	TWO_WAY_TREE [CONSTRUCT]
		rename
			put as twt_put,
			make as twt_make
		export
			{CONSTRUCT} twt_put, twt_make
		redefine 
			parent, new_cell
		end

feature -- Initialization

	make is
			-- Set up construct.
		do
			twt_make (Current)
		end;

feature -- Access

	document: INPUT is
			-- The document to be parsed
		once
			create Result.make
		end;

	production: LINKED_LIST [CONSTRUCT] is 
			-- Right-hand side of the production for the construct
		deferred 
		end;

	construct_name: STRING is 
			-- Name of the construct in the grammar
		deferred
		end;

feature -- Status report

	is_optional: BOOLEAN;
			-- Is construct optional? 

	left_recursion: BOOLEAN is 
			-- Is the construct's definition left-recursive?
		deferred 
		end;

	parsed: BOOLEAN;
			-- Has construct been successfully parsed?
			-- (True for optional components not present)

	committed: BOOLEAN
			-- Have enough productions been recognized to interpret
			-- failure of parsing as a syntax error in this construct?
			-- (Otherwise the parsing process will backtrack, trying
			-- other possible interpretations of the part already read.)

	print_mode: CELL [BOOLEAN] is 
			-- Must the left-recursion test also print the production?
			-- (Default: no.)
		once 
			create Result.put (False)
		end;

feature -- Status setting

	set_optional is
			-- Define this construct as optional.
		do
			is_optional := True
		ensure
			optional_construct: is_optional
		end;

feature -- Transformation

	process is
			-- Parse a specimen of the construct, then apply
			-- semantic actions if parsing successful.
		do
			parse;
			if parsed then
				semantics
			end
		end;

	parse is
			-- Attempt to analyze incoming lexical
			-- tokens according to current construct. 
			-- Set `parsed' to true if successful; 
			-- return to original position in input otherwise.
		local
			initial_document_position: INTEGER
		do
			initial_document_position := document.index;
			parsed := False;
			complete := False;
			committed := False;
			parse_body;
			if not complete and is_optional then
				document.go_i_th (initial_document_position);
				parsed := not committed
			else
				parsed := complete
			end;                                    
		end;

	commit is
            -- If this construct is one among several possible ones,
            -- discard the others.
				-- By default this does nothing.
		do
		end;

	semantics is
			-- Apply semantic actions in order:
			-- `pre_action', `in_action', `post_action'.
		do
			pre_action;
			in_action;
			post_action
		end;

	pre_action is
			-- Semantic action executed before construct is parsed
			-- (nothing by default; may be redefined in descendants).
		do
		end;

	post_action is
			-- Semantic action executed after construct is parsed
			-- (nothing by default; may be redefined in descendants).
		do
		end;



feature -- Output 

	print_name is
			-- Print the construct name on standard output.
		do
			io.put_string (construct_name)
		end;

feature {CONSTRUCT} -- Implementation

	complete: BOOLEAN
			-- Has the construct been completely recognized?
			-- (Like `parsed', but in addition the construct,
			-- if optional, must be present.)

	parent: CONSTRUCT;
			-- Parent of current construct

	new_cell (v: like item): like item is
		do
			Result := v
			Result.twt_put (v)
			Result.attach_to_parent (Current)
		end;

	check_recursion is 
			-- Check construct for left recursion.
		deferred 
		end;

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
		end;

feature {NONE} -- Implementation

	put (c: CONSTRUCT) is
			-- Add a construct to the production.
		do  
			production.put_left (c);
			last_sub_construct := c
		end;

	last_sub_construct: CONSTRUCT;
			-- Subconstruct most recently added to the production

	make_optional is
			-- Make the last entered subconstruct optional.
		do
			last_sub_construct.set_optional
		end;

	keyword (s: STRING) is
			-- Insert a keyword into the production.
		local
			key: KEYWORD
		do     
			create key.make (s);
			put (key)
		end;

	expand_next is
			-- Expand the next child of current node
			-- after current child.
			-- This is the most likely version of expand
			-- for types of construct where each subconstruct
			-- must be expanded in turn.
		local
			n: CONSTRUCT
		do
			if not production.is_empty then
				production.go_i_th (child_index + 1);
				if not production.after then
					n := clone (production.item);
					put_component (n)
				else
					child_finish;
					child_forth
				end
			else
				child_finish;
				child_forth
			end
		end;

	expand is
			-- Create next construct to be parsed.
			-- Used by `parse' to build the production
			-- that is expected at each node, according to `production'.
		deferred
		end;

	put_component (new: CONSTRUCT) is
			-- Add a new component to expand the production.
			-- Note that the components are always added in
			-- the tree node in left to right order.
		do
			child_finish;
			child_put_right (new);
			child_forth
		end;

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
		end;

	expected_found_error is
			-- Print an error message saying what was 
			-- expected and what was found.
		local
			err: STRING
		do
			create err.make (20);
			err.append (child.construct_name);
			err.append (" expected, ");
			if document.token.type = -1 then
				err.append ("end of document found")
			elseif document.token.string_value.count > 0 then
				err.append (document.token.string_value);
				err.append (" found")
			end;
			raise_syntax_error (err)
		end;

	structure_list: LINKED_LIST [LINKED_LIST [CONSTRUCT]] is
			-- List of the structures already examined when
			-- searching for left recursion
		once
			create Result.make
		end;

	check_recursion_list: LINKED_LIST [LINKED_LIST [CONSTRUCT]] is
			-- List of the structures already examined when
			-- checking for left recursion
		once
			create Result.make
		end;

	global_left_recursion: CELL [BOOLEAN] is 
			-- Is there any left recursion in the whole program?
		once 
			create Result.put (False)
		end;

	child_recursion: CELL [BOOLEAN] is 
			-- Is there any recursion in the whole program?
		once 
			create Result.put (False)
		end;

	recursion_message: STRING is
			-- Error message when left recursion has been detected,
			-- with all productions involved in the recursion chain
		once
			create Result.make (100)
		end;

	message_construction: BOOLEAN is
			-- Has the message on left recursion been already printed?
		do
			child.expand_all;
			Result := not child.left_recursion;
			if not Result then
				if not structure_list.has (production) then
					structure_list.put_right (production);
					io.put_string ("Left recursion has been detected ");
					io.put_string ("in the following constructs:%N");
					io.put_string (recursion_message);
					io.new_line;
					recursion_message.wipe_out;
					Result := True
				else
					recursion_message.append (construct_name);
					recursion_message.append ("%N")
				end
			elseif Result and not structure_list.has (production) then
				io.put_string ("child.left_recursion = false");
				io.put_string ("		and recursion_visited = false%N")
			end
		end;

	in_action is
			-- Perform a certain semantic operation.
		deferred
		end;

	parse_body is
			-- Perform any special parsing action for a particular
			-- type of construct.
			-- Call `parse_child' on each child construct.
			-- Set `committed' to true if enough has been 
			-- recognized to freeze the parse tree built so far.
			-- Set `complete' to true if the whole construct has been
			-- correctly recognized.
		deferred
		end;

	parse_child is
			-- Parse child recursively to build the tree.
			-- An error is output the first time a parse fails 
			-- in an uncommitted child of a committed parent 
			-- i.e. at the deepest point known to be meaningful.
		do
			child.parse;
			if child.committed then
				committed := True;
			end;
			if committed and not (child.parsed or child.committed) then
				expected_found_error
			end
		end;

end -- class CONSTRUCT


--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

