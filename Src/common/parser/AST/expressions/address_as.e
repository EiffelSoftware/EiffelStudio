indexing

	description: 
		"AST representation of an Eiffel function pointer.";
	date: "$Date$";
	revision: "Revision $"

class ADDRESS_AS

inherit

	EXPR_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			feature_name ?= yacc_arg (0);
		ensure then
			feature_name_exists: feature_name /= Void
		end;

feature -- Properties

	feature_name: FEATURE_NAME;
			-- Feature name to address

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_feature (feature_name.internal_name, void);
			ctxt.put_text_item_without_tabs (ti_Dollar);
			ctxt.put_normal_feature;
		end;

end -- class ADDRESS_AS
