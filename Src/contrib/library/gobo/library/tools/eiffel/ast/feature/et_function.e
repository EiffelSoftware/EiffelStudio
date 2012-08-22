note

	description:

		"Eiffel functions"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2012, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_FUNCTION

inherit

	ET_QUERY
		undefine
			is_routine,
			arguments,
			preconditions,
			postconditions,
			reset_preconditions,
			reset_postconditions,
			obsolete_message
		redefine
			is_function,
			is_prefixable, is_infixable,
			is_bracketable, undefined_feature
		end

	ET_ROUTINE
		undefine
			reset, type, is_prefixable, is_infixable, is_bracketable
		redefine
			is_function
		end

feature {NONE} -- Initialization

	make (a_name: like extended_name; args: like arguments; a_type: like declared_type; a_class: like implementation_class)
			-- Create a new function.
		require
			a_name_not_void: a_name /= Void
			a_type_not_void: a_type /= Void
			a_class_not_void: a_class /= Void
		do
			extended_name := a_name
			hash_code := name.hash_code
			arguments := args
			declared_type := a_type
			end_keyword := tokens.end_keyword
			clients := tokens.empty_clients
			implementation_class := a_class
			implementation_feature := Current
		ensure
			extended_name_set: extended_name = a_name
			arguments_set: arguments = args
			declared_type_set: declared_type = a_type
			implementation_class_set: implementation_class = a_class
			implementation_feature_set: implementation_feature = Current
		end

feature -- Status report

	is_function: BOOLEAN = True
			-- Is feature a function?

	is_infixable: BOOLEAN
			-- Can current feature have a name of
			-- the form 'infix ...'?
		do
			Result := arguments /= Void and then arguments.count = 1
		end

	is_prefixable: BOOLEAN
			-- Can current feature have a name of
			-- the form 'prefix ...'?
		do
			Result := arguments = Void or else arguments.count = 0
		end

	is_bracketable: BOOLEAN
			-- Can current feature have a name of
			-- the form 'alias "[]"'?
		do
			Result := arguments /= Void and then arguments.count > 0
		end

feature -- Access

	header_break: ET_BREAK
			-- Break which appears where the header comment is expected
		local
			l_break: ET_BREAK
		do
			if is_keyword /= Void then
				l_break := is_keyword.break
				if l_break /= Void and then l_break.has_comment then
					Result := l_break
				end
			end
			if Result = Void then
				l_break := declared_type.break
				if l_break /= Void and then l_break.has_comment then
					Result := l_break
				end
			end
			if Result = Void and assigner /= Void then
				l_break := assigner.break
				if l_break /= Void and then l_break.has_comment then
					Result := l_break
				end
			end
			if Result = Void then
				Result := declared_type.break
			end
		end

feature -- Conversion

	undefined_feature (a_name: like extended_name): ET_DEFERRED_FUNCTION
			-- Undefined version of current feature
		do
			create Result.make (a_name, arguments, declared_type, implementation_class)
			Result.set_assigner (assigner)
			Result.set_obsolete_message (obsolete_message)
			Result.set_preconditions (preconditions)
			Result.set_postconditions (postconditions)
			Result.set_clients (clients)
			Result.set_implementation_feature (implementation_feature)
			Result.set_first_precursor (Current)
			Result.set_is_keyword (is_keyword)
			Result.set_end_keyword (end_keyword)
			Result.set_semicolon (semicolon)
			Result.set_feature_clause (feature_clause)
			Result.set_first_indexing (first_indexing)
			Result.set_object_tests (object_tests)
			Result.set_across_components (across_components)
			Result.set_first_seed (first_seed)
			Result.set_other_seeds (other_seeds)
		end

end
