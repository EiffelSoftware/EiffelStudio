-- Abstract description of an Eiffel function pointer

class ADDRESS_AS

inherit

	EXPR_AS
		redefine
			simple_format
		end

feature -- Attribute

	feature_name: FEATURE_NAME;
			-- Feature name to address

feature -- Initialization

	set is
			-- Yacc initialization
		do
			feature_name ?= yacc_arg (0);
		ensure then
			feature_name_exists: feature_name /= Void
		end;

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.prepare_for_feature (feature_name.internal_name, void);
			--if ctxt.is_feature_visible then
				ctxt.put_text_item (ti_Dollar);
				ctxt.put_current_feature; 	-- treat infix and prefix
				ctxt.commit;
			--end;
		end;

end
