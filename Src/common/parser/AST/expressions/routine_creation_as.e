indexing
	description: "Abstract description of an Eiffel routine object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_CREATION_AS

inherit
	EXPR_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		local
			access_feat_as: DELAYED_ACCESS_FEAT_AS
			current_as: CURRENT_AS
			access_id_as: ACCESS_ID_AS
		do
			target ?= yacc_arg (0)
			feature_name ?= yacc_arg (1)
			operands ?= yacc_arg (2)
		ensure then
			feature_name_exists: feature_name /= Void
		end

feature -- Attributes

	target: OPERAND_AS
			-- Target operand used when the feature will be called

	feature_name: ID_AS
			-- Feature name

	operands : EIFFEL_LIST [OPERAND_AS]
			-- List of operands used by the feature when called.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and then
					  equivalent (operands, other.operands) and then
					  equivalent (target, other.target)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			-- FIXME
		end

feature {ROUTINE_CREATION_AS}

	set_target (t : like target) is
			-- Set `target' to `t'.
		do
			target := t
		end

	set_feature_name (f : like feature_name) is
			-- Set `feature_name' to `f'.
		do
			feature_name := f
		end

	set_operands (o : like operands) is
			-- Set `operands' to `o'.
		do
			operands := o
		end

end -- class ROUTINE_CREATION_AS
