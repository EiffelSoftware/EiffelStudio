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
			is_infix, is_valid, offset, simple_format, visual_name,
			main_feature_format, format, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (op: like fix_operator; b: BOOLEAN) is
			-- Create a new INFIX AST node.
		require
			op_not_void: op /= Void
		do
			fix_operator := op
				-- Note: the following line is not
				-- necessary since this has already
				-- been done by the scanner.
			fix_operator.value.to_lower
			is_frozen := b
		ensure
			fix_operator_set: fix_operator = op
			is_frozen_set: is_frozen = b
		end

feature -- Attributes

	fix_operator: STRING_AS;
			-- Infix notation

feature -- Properties

	is_infix: BOOLEAN is
			-- is the feature name an infixed notation ?
		do
			Result := True;
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (fix_operator, other.fix_operator) and
				is_frozen = other.is_frozen
		end

feature -- Access

	visual_name: STRING is
			-- Visual name of fix operator
		do
			Result := fix_operator.value
		end;

	internal_name: ID_AS is
			-- Internal name used by the compiler
		local
			value, to_append: STRING;
		do
			temp_name.wipe_out;
			temp_name.append (Fix_notation);
			value := fix_operator.value;
			to_append := code_table.item (value);
			if to_append = Void then
					-- Free operator
				to_append := value;
			end;
			check
				good_string_to_append: to_append /= Void;
			end;
			temp_name.append (to_append);
			Result := clone (temp_name);
			Result.to_lower;
		end;

	Fix_notation: STRING is
			-- Infix notation prefix for the compiler
		once
			Result := "_infix_"
		end

	is_valid: BOOLEAN is
			-- Is the fix notation valid ?
		local
			value: STRING;
		do
			value := fix_operator.value;
			Result := code_table.has (value) or else is_free;
		end;

	is_free: BOOLEAN is
			-- Is the fix notation a free notation ?
		local
			value: STRING;
			first_char: CHARACTER;
			i, count: INTEGER;
		do
			value := fix_operator.value;
			first_char := value.item (1);
			if
				first_char = '%A'
				or else first_char = '%S'
				or else first_char = '%V'
				or else first_char = '&'
			then
				from
					Result := True;
					i := 2;
					count := value.count;
				until
					i > count
				loop
					Result := value.item (i) /= '%%';
					i := i + 1;
				end;
			end;
		ensure then
			Result implies not code_table.has (fix_operator.value);
		end;

	offset: INTEGER is
		do
			if is_frozen then
				Result := 7
			end;
			if is_prefix then
				Result := Result + 7
			else
				Result := Result + 6
			end
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
			elseif fix_operator = Void then
				Result := False
			elseif infix_feature.fix_operator = Void then
				Result := True
			else
				Result := fix_operator < infix_feature.fix_operator
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
				ctxt.prepare_for_infix (internal_name, Void);
			else
				ctxt.prepare_for_prefix (internal_name);
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
				ctxt.prepare_for_infix (internal_name, Void);
				ctxt.put_infix_feature
			else
				ctxt.put_text_item (ti_Prefix_keyword);
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_Double_quote);
				ctxt.prepare_for_prefix (internal_name);
				ctxt.put_prefix_feature
			end;
			ctxt.put_text_item_without_tabs (ti_Double_quote);
		end;

feature {COMPILER_EXPORTER}

	set_name (s: STRING) is
		do
			!!fix_operator;
			fix_operator.set_value (s);
		end;

end -- class INFIX_AS
