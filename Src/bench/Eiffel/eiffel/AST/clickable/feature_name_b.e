indexing

	description:
		"Abstract class for an Eiffel feature name: id or %
		%infix/prefix notation.";
	date: "$Date$";
	revision: "$Revision$"

deferred class FEATURE_NAME_B

inherit
	FEATURE_NAME
		redefine
			internal_name, temp_name, associated_feature_name
		end

	AST_EIFFEL_B
		undefine
			is_equal
		redefine
			format
		end

feature -- Stoning

	internal_name: ID_AS_B is
			-- Internal name used by the compiler.
		deferred
		end;

	temp_name: ID_AS_B is
			-- Buffer for internal name evaluation.
		once
			!! Result.make (25)
		end;
 
	associated_feature_name: STRING is
		do
			Result := internal_name
		end

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text features calls within main features.
			-- Called by parent ast structures and by 
			-- feature that doesn't have a feature_i (not compiled).
		do
			if is_frozen then
				ctxt.put_text_item (ti_Frozen_keyword);
				ctxt.put_space
			end;
				-- Use the source type and target type
				-- of local_adapt
			ctxt.local_adapt.set_evaluated_type;
			ctxt.prepare_for_feature (internal_name, void);
			adapt_main_feature (ctxt);
		end;

	main_feature_format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text for main features of a class.
		require
			valid_target_feature: ctxt.global_adapt.target_enclosing_feature /= Void
		do
			if ctxt.global_adapt.target_enclosing_feature.is_frozen then
				ctxt.put_text_item (ti_Frozen_keyword);
				ctxt.put_space
			end;
			ctxt.prepare_for_main_feature;
			adapt_main_feature (ctxt);
		end;

feature {NONE} -- Implementation

	adapt_main_feature (ctxt: FORMAT_CONTEXT_B) is
			-- Adapt the main feature of a class to
			-- take into consideration the source and
			-- target class when reconsituting the text.
			--| An infix can turn into a prefix or normal feature,
			--| A prefix can turn into an infix or normal feature,
			--| A normal feature can turn into an infix or prefix.
		require
			valid_ctxt: ctxt /= Void
		local
			adapt: LOCAL_FEAT_ADAPTATION
		do
			adapt := ctxt.local_adapt;
			if adapt.is_infix then
				ctxt.put_text_item (ti_Infix_keyword);
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_Double_quote);
			elseif adapt.is_prefix then
				ctxt.put_text_item (ti_Prefix_keyword);
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_Double_quote);
			end;
			ctxt.put_main_feature_name;
			if not adapt.is_normal then
				ctxt.put_text_item_without_tabs (ti_Double_quote);
			end;
		end;

end -- class FEATURE_NAME_B
