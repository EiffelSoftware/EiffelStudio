indexing

	description:
		"AST representation of an access to the precursor of%
		%an Eiffel feature."
	date: "$Date$"
	revision: "$Revision$"

class PRECURSOR_AS

inherit
	ACCESS_AS
		redefine
			is_equivalent
		end

	CLICKABLE_AST
		redefine
			is_precursor
		end

feature {AST_FACTORY} -- Initialization

	initialize (n: like parent_name; p: like parameters) is
			-- Create a new PRECURSOR AST node.
		do
			parent_name := n
			parameters := p
			if parameters /= Void then
				parameters.start
			end
		ensure
			parent_name_set: parent_name = n
			parameters_set: parameters = p
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			parent_name ?= yacc_arg (0)
			parameters ?= yacc_arg (1)
			if parameters /= Void then
				parameters.start
			end
		end

feature -- Properties

	parent_name: ID_AS
			-- Optional parent qualification

	parameters: EIFFEL_LIST [EXPR_AS]
			-- List of parameters

	parameter_count: INTEGER is
			-- Number of parameters
		do
			if parameters /= Void then
				Result := parameters.count
			end
		end

	access_name: STRING is
		do
			-- Void because a Precursor call is like a client call but without
			-- a client, so there is no variable which is accessing the feature.
		end

	is_precursor: BOOLEAN is True
			-- Precursor makes reference to a class

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (parent_name, other.parent_name) and
				equivalent (parameters, other.parameters)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			p_name : STRING
		do
			ctxt.begin

			if parent_name /= Void then
				p_name := Clone (parent_name.string_value)
				p_name.to_upper
				ctxt.put_text_item (ti_L_curly)
				ctxt.put_class_name (p_name)
				ctxt.put_text_item (ti_R_curly)
			end

			ctxt.put_text_item (ti_space)
			ctxt.put_text_item (ti_Precursor_keyword)

				-- We simply use an empty feature name.
			ctxt.prepare_for_feature ("", parameters)
			ctxt.put_current_feature

			ctxt.commit
		end

feature {COMPILER_EXPORTER} -- Replication {PRECURSOR_AS, USER_CMD, CMD}

	set_parent_name (name: like parent_name) is
		require
			valid_arg: name /= Void
		do
			parent_name := name
		end

	set_parameters (p: like parameters) is
		do
			parameters := p
		end

end -- class PRECURSOR_AS
