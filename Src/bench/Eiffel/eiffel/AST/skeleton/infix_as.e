indexing

	description:
			"Abstract description of an Eiffel infixed feature name. %
			%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class INFIX_AS

inherit
	FEATURE_NAME
		redefine
			is_infix, is_prefix, is_valid, offset, end_offset, simple_format, visual_name,
			main_feature_format, format, is_equivalent
		end

	SYNTAX_STRINGS
		export
			{NONE} all
		undefine
			is_equal
		end

feature {AST_FACTORY} -- Initialization

	initialize (op: STRING_AS; b: BOOLEAN; inf: BOOLEAN) is
			-- Create a new INFIX AST node.
			-- `b' is `is_frozen', `inf' is `is_infix'.
		require
			op_not_void: op /= Void
		do
			is_infix := inf
			is_frozen := b
			set_name (op.value)
		ensure
			is_frozen_set: is_frozen = b
		end

feature -- Properties

	is_infix: BOOLEAN
			-- is the feature name an infixed notation ?

	is_prefix: BOOLEAN is
			-- Is the feature a prefix notation?
		do
			Result := not is_infix
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equal (internal_name_id, other.internal_name_id) and
				is_infix = other.is_infix and
				is_frozen = other.is_frozen
		end

feature -- Access

	visual_name: STRING
			-- Visual name of fix operator

	internal_name: ID_AS
			-- Internal name used by the compiler

	is_valid: BOOLEAN is
			-- Is the fix notation valid ?
		do
			Result := sc.is_valid_operator (visual_name)
		end;

	is_free: BOOLEAN is
			-- Is the fix notation a free notation ?
		do
			Result := sc.is_valid_free_operator (visual_name)
		end;

	offset: INTEGER is
		do
			if is_frozen then
				Result := frozen_str.count
			end;
			if is_prefix then
				Result := Result + prefix_str.count
			else
				Result := Result + infix_str.count
			end
		end

	end_offset: INTEGER is
		once
			Result := Quote_str.count
		end

feature -- Conveniences

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		local
			infix_feature: INFIX_AS;
			normal_feature: FEAT_NAME_ID_AS;
		do
			normal_feature ?= other
			infix_feature ?= other

			check
				Void_normal_feature: normal_feature = Void implies infix_feature /= Void
				Void_infix_feature: infix_feature = Void implies normal_feature /= Void
			end

			if infix_feature = Void then
				Result := False
			else
				Result := visual_name < infix_feature.visual_name
			end
		end

feature -- Output

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text features calls 
			-- within main features.
		do
			if is_frozen then
				ctxt.put_text_item (ti_Frozen_keyword);
				ctxt.put_space
			end;
				-- Use the source type and target type
				-- of local_adapt
			ctxt.local_adapt.set_evaluated_type;
			if is_infix then
				ctxt.prepare_for_infix (internal_name, visual_name, Void);
			else
				ctxt.prepare_for_prefix (internal_name, visual_name);
			end;
			adapt_main_feature (ctxt)
		end;

	main_feature_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text for main features of a class.
		do
			if is_frozen then 
				ctxt.put_text_item (ti_Frozen_keyword);
				ctxt.put_space
			end;
			ctxt.prepare_for_main_feature;
			adapt_main_feature (ctxt)
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if is_frozen then
				ctxt.put_text_item (ti_Frozen_keyword);
				ctxt.put_space
			end;
			if is_infix then
				ctxt.put_text_item (ti_Infix_keyword);
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_Double_quote);
				ctxt.prepare_for_infix (internal_name, visual_name, Void);
				ctxt.put_infix_feature
			else
				ctxt.put_text_item (ti_Prefix_keyword);
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_Double_quote);
				ctxt.prepare_for_prefix (internal_name, visual_name);
				ctxt.put_prefix_feature
			end;
			ctxt.put_text_item_without_tabs (ti_Double_quote);
		end;

feature {COMPILER_EXPORTER}

	set_name (s: STRING) is
		do
			visual_name := s
			if is_infix then
				create internal_name.initialize (infix_str + s + quote_str)
			else
				create internal_name.initialize (prefix_str + s + quote_str)
			end
		end;

feature {NONE} -- Implementation

	sc: EIFFEL_SYNTAX_CHECKER
			-- Tool that checks the validity of feature names.

end -- class INFIX_AS
