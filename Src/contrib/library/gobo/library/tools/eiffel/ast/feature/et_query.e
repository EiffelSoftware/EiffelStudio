note

	description:

		"Eiffel queries (functions or attributes)"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2012, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_QUERY

inherit

	ET_FEATURE
		redefine
			reset, type
		end


feature -- Initialization

	reset
			-- Reset current feature as it was just after it was last parsed.
		local
			l_assigner: ET_ASSIGNER
		do
			precursor
			l_assigner := assigner
			if l_assigner /= Void then
				l_assigner.reset
			end
		end

feature -- Access

	type: ET_TYPE
			-- Return type
		do
			Result := declared_type.type
		ensure then
			type_not_void: Result /= Void
		end

	declared_type: ET_DECLARED_TYPE
			-- Declared type (type preceded by a colon)

	assigner: ET_ASSIGNER
			-- Assigner procedure

feature -- Setting

	set_assigner (an_assigner: like assigner)
			-- Set `assigner' to `an_assigner'.
		do
			assigner := an_assigner
		ensure
			assigner_set: assigner = an_assigner
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
			Result.set_semicolon (semicolon)
			Result.set_feature_clause (feature_clause)
			Result.set_first_indexing (first_indexing)
			Result.set_object_tests (object_tests)
			Result.set_across_components (across_components)
			Result.set_first_seed (first_seed)
			Result.set_other_seeds (other_seeds)
		end

invariant

	declared_type_not_void: declared_type /= Void
	is_query: is_query

end
