note

	description:

		"Eiffel regular feature calls"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_REGULAR_FEATURE_CALL

inherit

	ET_FEATURE_CALL
		redefine
			name,
			arguments
		end

feature -- Access

	name: ET_FEATURE_NAME
			-- Feature name
		deferred
		end

	arguments: detachable ET_ACTUAL_ARGUMENT_LIST
			-- Arguments
		deferred
		end

feature -- Setting

	set_parenthesis_call (a_target: ET_EXPRESSION; a_name: ET_PARENTHESIS_SYMBOL; a_arguments: ET_ACTUAL_ARGUMENT_LIST)
			-- Set `parenthesis_call' with `a_target', `a_name' and `a_arguments'.
		require
			a_target_not_void: a_target /= Void
			a_name_not_void: a_name /= Void
			a_arguments_not_void: a_arguments /= Void
			a_arguments_not_empty: a_arguments.count > 0
		deferred
		ensure
			parenthesis_call_set: attached parenthesis_call as l_parenthesis_call
			target_set: l_parenthesis_call.target = a_target
			name_set: l_parenthesis_call.name = a_name
			arguments_set: l_parenthesis_call.arguments = a_arguments
		end

end
