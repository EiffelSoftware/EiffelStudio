indexing

	description:
		"Abstract class for an Eiffel feature name: id or %
		%infix/prefix notation."
	date: "$Date$"
	revision: "$Revision$"

deferred class FEATURE_NAME

inherit
	AST_EIFFEL
		undefine
			is_equal
		redefine
			format
		end

	COMPARABLE

	CLICKABLE_AST
		undefine
			is_equal
		redefine
			is_feature, associated_feature_name
		end

-- Undefined is_equal of AST_EIFFEL and CLICKABLE_AST because these are
-- not consistent with infix < operator
-- < is defined by the terms of < of feature name and is_equal 
-- (from ANY is c_standard_is_equal)

feature -- Stoning

	internal_name: ID_AS is
			-- Internal name used by the compiler.
		deferred
		end

	temp_name: ID_AS is
			-- Buffer for internal name evaluation.
		once
			!! Result.make (45)
		end
 
	associated_feature_name: STRING is
		do
			Result := internal_name
		end

feature -- Properties

	is_frozen: BOOLEAN
			-- Is the name of the feature frozen ?

	is_infix: BOOLEAN is
			-- Is the feature name an infixed notation ?
		do
		end

	is_prefix: BOOLEAN is
			-- Is the feature name a prefixed notation ?
		do
		end

	is_valid: BOOLEAN is
			-- is the feature name valid ?
		do
			Result := True
		end

	is_feature: BOOLEAN is True
			-- Does the Current AST represent a feature?

	visual_name: STRING is
			-- Named used in Eiffel code
		do	
			Result := internal_name
		end

feature -- Comparison

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		deferred
		end

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text features calls within main features.
			-- Called by parent ast structures and by 
			-- feature that doesn't have a feature_i (not compiled).
		do
			if is_frozen then
				ctxt.put_text_item (ti_Frozen_keyword)
				ctxt.put_space
			end
				-- Use the source type and target type
				-- of local_adapt
			ctxt.local_adapt.set_evaluated_type
			ctxt.prepare_for_feature (internal_name, Void)
			adapt_main_feature (ctxt)
		end

	main_feature_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text for main features of a class.
		require
			valid_target_feature: ctxt.global_adapt.target_enclosing_feature /= Void
		do
			if ctxt.global_adapt.target_enclosing_feature.is_frozen then
				ctxt.put_text_item (ti_Frozen_keyword)
				ctxt.put_space
			end
			ctxt.prepare_for_main_feature
			adapt_main_feature (ctxt)
		end

feature {NONE} -- Implementation

	adapt_main_feature (ctxt: FORMAT_CONTEXT) is
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
			adapt := ctxt.local_adapt
			if adapt.is_infix then
				ctxt.put_text_item (ti_Infix_keyword)
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_Double_quote)
			elseif adapt.is_prefix then
				ctxt.put_text_item (ti_Prefix_keyword)
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_Double_quote)
			end
			ctxt.put_main_feature_name
			if not adapt.is_normal then
				ctxt.put_text_item_without_tabs (ti_Double_quote)
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if is_frozen then
				ctxt.put_text_item (ti_Frozen_keyword)
				ctxt.put_space
			end
			ctxt.prepare_for_feature (internal_name, Void)
			ctxt.put_normal_feature
		end

feature {COMPILER_EXPORTER}

	set_name (s: STRING) is
		require
			s /= Void
		deferred
		end

	set_is_frozen (b: BOOLEAN) is
		do
			is_frozen := b
		end

feature {FEATURE_AS} -- Formatting

	offset: INTEGER is
		do
			if is_frozen then
					--| offset for frozen routines
				Result := 7
			end
		end

feature {NONE} -- Implementation

	code_table: HASH_TABLE [STRING, STRING] is
			-- Corrsepondance table for infix/prefix notation
		once
			!!Result.make (20)
			Result.put ("plus", "+")
			Result.put ("minus", "-")
			Result.put ("star", "*")
			Result.put ("slash", "/")
			Result.put ("lt", "<")
			Result.put ("gt", ">")
			Result.put ("le", "<=")
			Result.put ("ge", ">=")
			Result.put ("and", "and")
			Result.put ("or", "or")
			Result.put ("implies", "implies")
			Result.put ("xor", "xor")
			Result.put ("not", "not")
			Result.put ("mod", "\\")
			Result.put ("div", "//")
			Result.put ("power", "^")
			Result.put ("and_then", "and then")
			Result.put ("or_else", "or else")
		end

end -- class FEATURE_NAME
