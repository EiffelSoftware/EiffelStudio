indexing

	description: 
		"List of feature names.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_LIST_AS

inherit

	FEATURE_SET_AS
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (f: like features) is
			-- Create a new FEATURE_LIST AST node.
		require
			f_not_void: f /= Void
		do
			features := f
		ensure
			features_set: features = f
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			features ?= yacc_arg (0);
		end;

feature -- Properties

	features: EIFFEL_LIST [FEATURE_NAME];
			-- List of feature names

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (features, other.features)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.set_separator (ti_Comma);
			ctxt.set_space_between_tokens;
			features.simple_format (ctxt);
		end;

end -- class FEATURE_LIST_AS
