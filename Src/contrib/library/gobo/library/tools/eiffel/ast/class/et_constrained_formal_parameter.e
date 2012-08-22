note

	description:

		"Eiffel constrained formal generic parameters"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002-2010, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_CONSTRAINED_FORMAL_PARAMETER

inherit

	ET_FORMAL_PARAMETER
		rename
			make as make_unconstrained
		redefine
			constraint, creation_procedures, break, last_leaf, process,
			constraint_base_type, set_constraint_base_type, reset
		end

create

	make

feature {NONE} -- Initialization

	make (a_name: like name; a_constraint: like constraint; a_creation: like creation_procedures; a_class: ET_CLASS)
			-- Create a new constrained formal generic parameter.
		require
			a_name_not_void: a_name /= Void
			a_constraint_not_void: a_constraint /= Void
			a_class_not_void: a_class /= Void
		do
			arrow_symbol := tokens.arrow_symbol
			constraint := a_constraint
			creation_procedures := a_creation
			make_unconstrained (a_name, a_class)
		ensure
			name_set: name = a_name
			constraint_set: constraint = a_constraint
			creation_procedures_set: creation_procedures = a_creation
			implementation_class_set: implementation_class = a_class
		end

feature -- Initialization

	reset
			-- Reset type as it was just after it was last parsed.
		do
			constraint.reset
			if creation_procedures /= Void then
				creation_procedures.reset
			end
		end

feature -- Access

	arrow_symbol: ET_SYMBOL
			-- '->' symbol

	constraint: ET_TYPE
			-- Generic constraint

	creation_procedures: ET_CONSTRAINT_CREATOR
			-- Creation procedures expected in `constraint'

	constraint_base_type: ET_BASE_TYPE
			-- Base type of constraint;
			-- Void means that there is no explicit constraint
			-- (i.e. the implicit constraint is "ANY"), or there
			-- is a cycle of the form "A [G -> H, H -> G]" in
			-- the constraints (i.e. the base type is also considered
			-- to be "ANY" in that case)

	last_leaf: ET_AST_LEAF
			-- Last leaf node in current node
		do
			if creation_procedures /= Void then
				Result := creation_procedures.last_leaf
			else
				Result := constraint.last_leaf
			end
		end

	break: ET_BREAK
			-- Break which appears just after current node
		do
			if creation_procedures /= Void then
				Result := creation_procedures.break
			else
				Result := constraint.break
			end
		end

feature -- Setting

	set_constraint (a_constraint: like constraint)
			-- Set `a_constraint' to `constraint'.
		require
			a_constraint_not_void: a_constraint /= Void
		do
			constraint := a_constraint
		ensure
			constraint_set: constraint = a_constraint
		end

	set_constraint_base_type (a_type: like constraint_base_type)
			-- Set `constraint_base_type' to `a_type'.
		do
			constraint_base_type := a_type
		end

	set_arrow_symbol (an_arrow: like arrow_symbol)
			-- Set `arrow_symbol' to `an_arrow'.
		require
			an_arrow_not_void: an_arrow /= Void
		do
			arrow_symbol := an_arrow
		ensure
			arrow_symbol_set: arrow_symbol = an_arrow
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_constrained_formal_parameter (Current)
		end

invariant

	arrow_symbol_not_void: arrow_symbol /= Void
	constraint_not_void: constraint /= Void

end
