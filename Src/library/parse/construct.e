note

	description:
		"The general notion of language construct,  %
		%characterized by a grammatical production %
		%and associated semantic actions"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONSTRUCT

inherit
	TWO_WAY_TREE [CONSTRUCT]
		rename
			put as twt_put,
			make as twt_make
		export
			{CONSTRUCT} twt_put, twt_make
		undefine
			new_tree, clone_node
		redefine
			parent,
			new_cell,
			child_cursor,
			twl_merge_left,
			twl_merge_right,
			tree_is_equal,
			tree_copy
		end

feature -- Initialization

	make
			-- Set up construct.
		do
			twt_make (Current)
		end

feature -- Access

	parent: detachable CONSTRUCT
			-- <precursor>

	child_cursor: CONSTRUCT_CURSOR
			-- <precursor>
		do
			create Result.make (child, child_after, child_before)
		end

	document: INPUT
			-- The document to be parsed
		once
			create Result.make
		end

	production: LINKED_LIST [CONSTRUCT]
			-- Right-hand side of the production for the construct
		deferred
		end

	construct_name: STRING
			-- Name of the construct in the grammar
		deferred
		end;

feature -- Status report

	is_optional: BOOLEAN
			-- Is construct optional?

	left_recursion: BOOLEAN
			-- Is the construct's definition left-recursive?
		deferred
		end

	parsed: BOOLEAN
			-- Has construct been successfully parsed?
			-- (True for optional components not present)

	committed: BOOLEAN
			-- Have enough productions been recognized to interpret
			-- failure of parsing as a syntax error in this construct?
			-- (Otherwise the parsing process will backtrack, trying
			-- other possible interpretations of the part already read.)

	print_mode: CELL [BOOLEAN]
			-- Must the left-recursion test also print the production?
			-- (Default: no.)
		once
			create Result.put (False)
		end

feature -- Status setting

	set_optional
			-- Define this construct as optional.
		do
			is_optional := True
		ensure
			optional_construct: is_optional
		end

feature -- Transformation

	process
			-- Parse a specimen of the construct, then apply
			-- semantic actions if parsing successful.
		do
			parse
			if parsed then
				semantics
			end
		end

	parse
			-- Attempt to analyze incoming lexical
			-- tokens according to current construct.
			-- Set `parsed' to true if successful;
			-- return to original position in input otherwise.
		local
			initial_document_position: INTEGER
		do
			initial_document_position := document.index
			parsed := False
			complete := False
			committed := False
			parse_body
			if not complete and is_optional then
				document.go_i_th (initial_document_position)
				parsed := not committed
			else
				parsed := complete
			end
		end

	commit
            -- If this construct is one among several possible ones,
            -- discard the others.
				-- By default this does nothing.
		do
		end

	semantics
			-- Apply semantic actions in order:
			-- `pre_action', `in_action', `post_action'.
		do
			pre_action
			in_action
			post_action
		end

	pre_action
			-- Semantic action executed before construct is parsed
			-- (nothing by default; may be redefined in descendants).
		do
		end

	post_action
			-- Semantic action executed after construct is parsed
			-- (nothing by default; may be redefined in descendants).
		do
		end

feature -- Output

	print_name
			-- Print the construct name on standard output.
		do
			if construct_name /= Void then
				io.put_string (construct_name)
			end
		end

feature -- Element Change

	twl_merge_left (other: CONSTRUCT)
			-- <precursor>
		do
			if attached {like Current} other as l_other then
				Precursor {TWO_WAY_TREE}(l_other)
			end
		end

	twl_merge_right (other: CONSTRUCT)
			-- <precursor>
		do
			if attached {like Current} other as l_other then
				Precursor {TWO_WAY_TREE}(l_other)
			end
		end

feature {CONSTRUCT} -- Implementation

	complete: BOOLEAN
			-- Has the construct been completely recognized?
			-- (Like `parsed', but in addition the construct,
			-- if optional, must be present.)

	new_cell (v: like item): CONSTRUCT
		do
				--| FIXME: Bad design, no way to ensure result is attached.
			check v /= Void end
			Result := v
			Result.twt_put (v)
			Result.attach_to_parent (Current)
		end

	check_recursion
			-- Check construct for left recursion.
		deferred
		end

	expand_all
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
		end

feature {NONE} -- Implementation

	put (c: CONSTRUCT)
			-- Add a construct to the production.
		do
			production.put_left (c)
			last_sub_construct := c
		end

	last_sub_construct: detachable CONSTRUCT;
			-- Subconstruct most recently added to the production

	make_optional
			-- Make the last entered subconstruct optional.
		local
			l_last_sub: like last_sub_construct
		do
			l_last_sub := last_sub_construct
			if l_last_sub /= Void then
				l_last_sub.set_optional
			end
		end

	keyword (s: STRING)
			-- Insert a keyword into the production.
		require
			s_not_void: s /= Void
		local
			key: KEYWORD
		do
			create key.make (s)
			put (key)
		end

	expand_next
			-- Expand the next child of current node
			-- after current child.
			-- This is the most likely version of expand
			-- for types of construct where each subconstruct
			-- must be expanded in turn.
		local
			n: CONSTRUCT
		do
			if not production.is_empty then
				production.go_i_th (child_index + 1)
				if not production.after then
					n := production.item
					if n /= Void then
						n := n.twin
					end
					put_component (n)
				else
					child_finish
					child_forth
				end
			else
				child_finish
				child_forth
			end
		end

	expand
			-- Create next construct to be parsed.
			-- Used by `parse' to build the production
			-- that is expected at each node, according to `production'.
		deferred
		end

	put_component (new: CONSTRUCT)
			-- Add a new component to expand the production.
			-- Note that the components are always added in
			-- the tree node in left to right order.
		require
			new_not_void: new /= Void
		do
			child_finish;
			child_put_right (new)
			child_forth
		end

	raise_syntax_error (s: STRING)
			-- Print error message s.
		require
			s_not_void: s /= Void
		local
			s2 : STRING
		do
			s2 := s.twin
			s2.append (" in ")
			s2.append (construct_name)
			if attached parent as l_parent then
				s2.append (" in ")
				s2.append (l_parent.construct_name)
			end;
			document.raise_error (s2)
		end

	expected_found_error
			-- Print an error message saying what was
			-- expected and what was found.
		require
			child_not_void: child /= Void
		local
			l_child: like child
			err: STRING
		do
			l_child := child
			check l_child /= Void end -- Implied from the precondition.

			create err.make (20)
			err.append (l_child.construct_name)
			err.append (" expected, ")
			if document.token.type = -1 then
				err.append ("end of document found")
			elseif document.token.string_value.count > 0 then
				err.append (document.token.string_value)
				err.append (" found")
			end;
			raise_syntax_error (err)
		end

	structure_list: LINKED_LIST [LINKED_LIST [CONSTRUCT]]
			-- List of the structures already examined when
			-- searching for left recursion
		once
			create Result.make
		end

	check_recursion_list: LINKED_LIST [LINKED_LIST [CONSTRUCT]]
			-- List of the structures already examined when
			-- checking for left recursion
		once
			create Result.make
		end

	global_left_recursion: CELL [BOOLEAN]
			-- Is there any left recursion in the whole program?
		once
			create Result.put (False)
		end

	child_recursion: CELL [BOOLEAN]
			-- Is there any recursion in the whole program?
		once
			create Result.put (False)
		end

	recursion_message: STRING
			-- Error message when left recursion has been detected,
			-- with all productions involved in the recursion chain
		once
			create Result.make (100)
		end

	message_construction: BOOLEAN
			-- Has the message on left recursion been already printed?
		require
			child_not_void: child /= Void
		local
			l_child: like child
		do
			l_child := child
			check l_child /= Void end -- Implied from the precondition.
			l_child.expand_all
			Result := not l_child.left_recursion
			if not Result then
				if not structure_list.has (production) then
					structure_list.put_right (production)
					io.put_string ("Left recursion has been detected ")
					io.put_string ("in the following constructs:%N")
					io.put_string (recursion_message);
					io.new_line;
					recursion_message.wipe_out;
					Result := True
				else
					recursion_message.append (construct_name)
					recursion_message.append ("%N")
				end
			elseif Result and not structure_list.has (production) then
				io.put_string ("child.left_recursion = false")
				io.put_string ("		and recursion_visited = false%N")
			end
		end

	in_action
			-- Perform a certain semantic operation.
		deferred
		end

	parse_body
			-- Perform any special parsing action for a particular
			-- type of construct.
			-- Call `parse_child' on each child construct.
			-- Set `committed' to true if enough has been
			-- recognized to freeze the parse tree built so far.
			-- Set `complete' to true if the whole construct has been
			-- correctly recognized.
		deferred
		end

	parse_child
			-- Parse child recursively to build the tree.
			-- An error is output the first time a parse fails
			-- in an uncommitted child of a committed parent
			-- i.e. at the deepest point known to be meaningful.
		require
			child_not_void: child /= Void
		local
			l_child: like child
		do
			l_child := child
			check l_child /= Void end -- Implied from the precondition.
			l_child.parse
			if l_child.committed then
				committed := True
			end;
			if committed and not (l_child.parsed or l_child.committed) then
				expected_found_error
			end
		end

	tree_is_equal (t1, t2: like Current): BOOLEAN
			-- <precursor>
		do
			Result := Precursor {TWO_WAY_TREE}(t1, t2)
		end

	tree_copy (other, tmp_tree: like Current)
			-- <precursor>
		do
			Precursor {TWO_WAY_TREE}(other, tmp_tree)
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




end -- class CONSTRUCT

