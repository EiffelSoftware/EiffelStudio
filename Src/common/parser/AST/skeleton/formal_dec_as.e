indexing
	description: "AST representation of a formal generic parameter. %
				%Instances produced by Yacc."
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_DEC_AS

inherit
	FORMAL_AS
		redefine
			set, simple_format,
			is_equivalent
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			formal_name ?= yacc_arg (0)
			constraint ?= yacc_arg (1)
			creation_constraint ?= yacc_arg (2)
			position := yacc_int_arg (0)
		ensure then
			formal_name_exists: formal_name /= Void
		end; 

feature -- Properties

	formal_name: ID_AS
			-- Formal generic parameter name

	constraint: TYPE
			-- Constraint of the formal generic

	creation_constraint: CREATE_AS
			-- Constraint on the creation routine

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (formal_name, other.formal_name)
				and then position = other.position
				and then equivalent (constraint, other.constraint)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			s: STRING
		do
			s := clone (formal_name)
			s.to_upper
			ctxt.put_string (s)
			if constraint /= Void then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_Constraint)
				ctxt.put_space
				ctxt.format_ast (constraint)
			end
		end

end -- class FORMAL_DEC_AS
