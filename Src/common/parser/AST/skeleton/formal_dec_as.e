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
			creation_feature_list ?= yacc_arg (2)
			position := yacc_int_arg (0)
		ensure then
			formal_name_exists: formal_name /= Void
		end; 

feature -- Properties

	formal_name: ID_AS
			-- Formal generic parameter name

	constraint: TYPE
			-- Constraint of the formal generic

	creation_feature_list: EIFFEL_LIST [FEATURE_NAME]
			-- Constraint on the creation routine

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (formal_name, other.formal_name)
				and then equivalent (constraint, other.constraint)
				and then equivalent (creation_feature_list, other.creation_feature_list)
				and then position = other.position
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			s: STRING
			feature_name: FEAT_NAME_ID_AS
		do
			s := clone (formal_name)
			s.to_upper
			ctxt.put_string (s)
			if constraint /= Void then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_Constraint)
				ctxt.put_space
				ctxt.format_ast (constraint)
				if creation_feature_list /= Void then
					from
						creation_feature_list.start
						ctxt.put_space
						feature_name ?= creation_feature_list.item
						ctxt.put_string (feature_name.feature_name)
						creation_feature_list.forth
					until
						creation_feature_list.after
					loop
						ctxt.put_text_item (ti_Comma)
						ctxt.put_space
						feature_name ?= creation_feature_list.item
						ctxt.put_string (feature_name.feature_name)
						creation_feature_list.forth
					end
				end
			end
		end

end -- class FORMAL_DEC_AS
