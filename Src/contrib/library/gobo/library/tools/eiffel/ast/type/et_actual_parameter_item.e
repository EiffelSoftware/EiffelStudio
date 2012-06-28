indexing

	description:

		"Eiffel actual generic parameters which appear in a comma-separated list of parameters"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2003-2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_ACTUAL_PARAMETER_ITEM

inherit

	ET_AST_NODE

feature -- Access

	actual_parameter: ET_ACTUAL_PARAMETER is
			-- Actual parameter in comma-separated list
		deferred
		ensure
			actual_parameter_not_void: Result /= Void
		end

	type: ET_TYPE is
			-- Type of `actual_parameter'
		deferred
		ensure
			type_not_void: Result /= Void
		end

	label: ET_IDENTIFIER is
			-- Label of `actual_parameter';
			-- Useful when part of a labeled tuple, Void if no label
		deferred
		end

feature -- Status report

	is_last_entity: BOOLEAN is
			-- Is current entity the last entity in an
			-- entity declaration group?
		require
			is_entity: label /= Void
		do
			Result := True
		end

feature -- Type processing

	resolved_formal_parameters_with_type (a_type: ET_TYPE): ET_ACTUAL_PARAMETER_ITEM is
			-- Version of current actual parameter where its type
			-- is replaced by `a_type'
		require
			a_type_not_void: a_type /= Void
		deferred
		ensure
			resolved_formal_parameters_not_void: Result /= Void
		end

end
