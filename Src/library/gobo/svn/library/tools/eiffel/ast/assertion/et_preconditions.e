indexing

	description:

		"Eiffel precondition lists"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_PRECONDITIONS

inherit

	ET_ASSERTIONS
		redefine
			make, make_with_capacity
		end

create

	make, make_with_capacity

feature {NONE} -- Initialization

	make is
			-- Create a new precondition clause.
		do
			require_keyword := tokens.require_keyword
			precursor
		end

	make_with_capacity (nb: INTEGER) is
			-- Create a new precondition clause with capacity `nb'.
		do
			require_keyword := tokens.require_keyword
			precursor (nb)
		end

feature -- Access

	require_keyword: ET_KEYWORD
			-- 'require' keyword

	else_keyword: ET_KEYWORD
			-- 'else' keyword

	position: ET_POSITION is
			-- Position of first character of
			-- current node in source code
		do
			Result := require_keyword.position
			if Result.is_null and not is_empty then
				Result := first.position
			end
		end

	first_leaf: ET_AST_LEAF is
			-- First leaf node in current node
		do
			Result := require_keyword
		end

	last_leaf: ET_AST_LEAF is
			-- Last leaf node in current node
		do
			if not is_empty then
				Result := last.last_leaf
			elseif else_keyword /= Void then
				Result := else_keyword
			else
				Result := require_keyword
			end
		end

	break: ET_BREAK is
			-- Break which appears just after current node
		do
			if not is_empty then
				Result := last.break
			elseif else_keyword /= Void then
				Result := else_keyword.break
			else
				Result := require_keyword.break
			end
		end

feature -- Status report

	is_require_else: BOOLEAN is
			-- Has precondition clause been declared with "require else"?
		do
			Result := (else_keyword /= Void)
		end

feature -- Setting

	set_require_keyword (a_require: like require_keyword) is
			-- Set `require_keyword' to `a_require'.
		require
			a_require_not_void: a_require /= Void
		do
			require_keyword := a_require
		ensure
			require_keyword_set: require_keyword = a_require
		end

	set_else_keyword (an_else: like else_keyword) is
			-- Set `else_keyword' to `an_else'.
		do
			else_keyword := an_else
		ensure
			else_keyword_set: else_keyword = an_else
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR) is
			-- Process current node.
		do
			a_processor.process_preconditions (Current)
		end

invariant

	require_keyword_not_void: require_keyword /= Void

end
