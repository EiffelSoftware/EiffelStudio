indexing
	description: 
		"AST representation of an Eiffel infixed feature name."
	date: "$Date$"
	revision: "$Revision$"

class
	INFIX_AS

inherit
	FEATURE_NAME
		redefine
			is_infix, is_prefix, is_valid, offset, end_offset,
			visual_name, is_equivalent
		end

	SYNTAX_STRINGS
		export
			{NONE} all
		undefine
			is_equal
		end

create
	initialize

feature {AST_FACTORY} -- Initialization

	initialize (op: STRING_AS; b: BOOLEAN; inf: BOOLEAN) is
			-- Create a new INFIX AST node.
			-- `b' is `is_frozen', `inf' is `is_infix'.
		require
			op_not_void: op /= Void
		do
--			is_infix := inf
			is_frozen := b
			set_name (op.value)
		ensure
			is_frozen_set: is_frozen = b
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_infix_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equal (internal_name_id, other.internal_name_id) and
				is_infix = other.is_infix and
				is_frozen = other.is_frozen
		end

feature -- Properties

	is_infix: BOOLEAN is
			-- is the feature name an infixed notation ?
		do
			Result := True
		end

	is_prefix: BOOLEAN is
			-- Is the feature a prefix notation?
		do
			Result := not is_infix
		end

feature -- Access

	visual_name: STRING
			-- Visual name of fix operator

	internal_name: ID_AS
			-- Internal name used by the compiler

	is_valid: BOOLEAN is
			-- Is the fix notation valid ?
		do
--			Result := sc.is_valid_operator (visual_name)
		end

	is_free: BOOLEAN is
			-- Is the fix notation a free notation ?
		do
--			Result := sc.is_valid_free_operator (visual_name)
		end

	offset: INTEGER is
		do
			if is_frozen then
				Result := frozen_str.count
			end
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

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			if is_frozen then
--				ctxt.put_text_item (ti_Frozen_keyword);
--				ctxt.put_space
--			end
--			if is_infix then
--				ctxt.put_text_item (ti_Infix_keyword);
--				ctxt.put_space;
--				ctxt.put_text_item_without_tabs (ti_Double_quote);
--				ctxt.prepare_for_infix (internal_name, void);
--				ctxt.put_infix_feature
--			else
--				ctxt.put_text_item (ti_Prefix_keyword);
--				ctxt.put_space;
--				ctxt.put_text_item_without_tabs (ti_Double_quote);
--				ctxt.prepare_for_prefix (internal_name);
--				ctxt.put_prefix_feature
--			end
--			ctxt.put_text_item_without_tabs (ti_Double_quote);
--		end

feature

	set_name (s: STRING) is
		do
			visual_name := s
			if is_infix then
				create internal_name.initialize (infix_str + s + quote_str)
			else
				create internal_name.initialize (prefix_str + s + quote_str)
			end
		end

end -- class INFIX_AS
