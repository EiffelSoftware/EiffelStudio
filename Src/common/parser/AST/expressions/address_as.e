indexing

	description: 
		"AST representation of an Eiffel function pointer.";
	date: "$Date$";
	revision: "Revision $"

class ADDRESS_AS

inherit

	EXPR_AS

feature {AST_FACTORY} -- Initialization

	initialize (f: like feature_name) is
			-- Create a new ADDRESS AST node.
		require
			f_not_void: f /= Void
		do
			feature_name := f
		ensure
			feature_name_set: feature_name = f
		end

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

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_feature (feature_name.internal_name, void);
			ctxt.put_text_item_without_tabs (ti_Dollar);
			ctxt.put_normal_feature;
		end;

end -- class ADDRESS_AS
