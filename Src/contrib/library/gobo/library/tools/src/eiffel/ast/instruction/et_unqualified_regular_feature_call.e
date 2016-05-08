note

	description:

		"Eiffel regular feature calls"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_UNQUALIFIED_REGULAR_FEATURE_CALL

inherit

	ET_REGULAR_FEATURE_CALL
		undefine
			is_qualified_call
		end

	ET_UNQUALIFIED_FEATURE_CALL
		undefine
			parenthesis_call
		end

feature {NONE} -- Initialization

	make (a_name: like name; args: like arguments)
			-- Create a new unqualified feature call.
		require
			a_name_not_void: a_name /= Void
		do
			name := a_name
			arguments := args
		ensure
			name_set: name = a_name
			arguments_set: arguments = args
		end

feature -- Initialization

	reset
			-- Reset call as it was when it was last parsed.
		do
			name.reset
			if attached arguments as l_arguments then
				l_arguments.reset
			end
		end

feature -- Access

	name: ET_FEATURE_NAME
			-- Feature name

	arguments: detachable ET_ACTUAL_ARGUMENT_LIST
			-- Arguments

	position: ET_POSITION
			-- Position of first character of
			-- current node in source code
		do
			Result := name.position
		end

	first_leaf: ET_AST_LEAF
			-- First leaf node in current node
		do
			Result := name.first_leaf
		end

	last_leaf: ET_AST_LEAF
			-- Last leaf node in current node
		do
			if attached arguments as l_arguments then
				Result := l_arguments.last_leaf
			else
				Result := name.last_leaf
			end
		end

feature -- Setting

	set_name (a_name: like name)
			-- Set `name' to `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_arguments (args: like arguments)
			-- Set `arguments' to `args'.
		do
			arguments := args
		ensure
			arguments_set: arguments = args
		end

end
