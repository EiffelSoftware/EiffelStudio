note

	description:

		"Eiffel precursor calls"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_PRECURSOR

inherit

	ET_AST_NODE

feature {NONE} -- Initialization

	make (a_parent_name: like parent_name; args: like arguments)
			-- Create a new precursor call.
		do
			parent_name := a_parent_name
			arguments := args
			precursor_keyword := tokens.precursor_keyword
		ensure
			parent_name_set: parent_name = a_parent_name
			arguments_set: arguments = args
		end

feature -- Initialization

	reset
			-- Reset precursor as it was when it was last parsed.
		do
				-- Note: do not reset `parent_type' to Void. `parent_type'
				-- is set by the feature flattener regardless of whether
				-- it was already set or not. It is then used by the
				-- implementation checker. So we don't want to reset things
				-- set by the feature flattener if we only want to reset
				-- what the implementation checker did, and especially since
				-- it does not hurt to leave it there.
			if arguments /= Void then
				arguments.reset
			end
		end

feature -- Access

	precursor_keyword: ET_PRECURSOR_KEYWORD
			-- 'precursor' keyword

	parent_name: ET_PRECURSOR_CLASS_NAME
			-- Parent class name surrounded by braces

	arguments: ET_ACTUAL_ARGUMENT_LIST
			-- Arguments

	parent_type: ET_BASE_TYPE
			-- Parent type;
			-- Void if not resolved yet.

	position: ET_POSITION
			-- Position of first character of
			-- current node in source code
		do
			if is_parent_prefixed and parent_name /= Void then
				Result := parent_name.position
			else
				Result := precursor_keyword.position
			end
		end

	first_leaf: ET_AST_LEAF
			-- First leaf node in current node
		do
			if is_parent_prefixed and parent_name /= Void then
				Result := parent_name.first_leaf
			else
				Result := precursor_keyword
			end
		end

	last_leaf: ET_AST_LEAF
			-- Last leaf node in current node
		do
			if arguments /= Void then
				Result := arguments.last_leaf
			elseif not is_parent_prefixed and parent_name /= Void then
				Result := parent_name.last_leaf
			else
				Result := precursor_keyword
			end
		end

	break: ET_BREAK
			-- Break which appears just after current node
		do
			if arguments /= Void then
				Result := arguments.break
			elseif not is_parent_prefixed and parent_name /= Void then
				Result := parent_name.break
			else
				Result := precursor_keyword.break
			end
		end

feature -- Setting

	set_precursor_keyword (a_precursor: like precursor_keyword)
			-- Set `precursor_keyword' to `a_precursor'.
		require
			a_precursor_not_void: a_precursor /= Void
		do
			precursor_keyword := a_precursor
		ensure
			precursor_keyword_set: precursor_keyword = a_precursor
		end

	set_parent_type (a_parent_type: like parent_type)
			-- Set `parent_type' to `a_parent_type'.
		do
			parent_type := a_parent_type
		ensure
			parent_type_set: parent_type = a_parent_type
		end

feature -- Status report

	is_parent_prefixed: BOOLEAN
			-- Does parent clause appear before 'precursor' keyword?

feature -- Status setting

	set_parent_prefixed (b: BOOLEAN)
			-- Set `is_parent_prefixed' to `b'.
		do
			is_parent_prefixed := b
		ensure
			is_parent_prefixed_set: is_parent_prefixed = b
		end

invariant

	precursor_keyword_not_void: precursor_keyword /= Void

end
