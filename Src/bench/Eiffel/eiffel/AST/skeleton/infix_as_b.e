indexing

	description:
			"Abstract description of an Eiffel infixed feature name. %
			%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class INFIX_AS_B

inherit

	INFIX_AS
		undefine
			temp_name, associated_feature_name
		redefine
			fix_operator, infix "<", internal_name
		end;

	FEATURE_NAME_B
		undefine
			is_infix, is_valid, offset, simple_format, visual_name
		redefine
			main_feature_format, format
		end

feature -- Attributes

	fix_operator: STRING_AS_B;
			-- Infix notation

feature -- Conveniences

	infix "<" (other: FEATURE_NAME_B): BOOLEAN is
		local
			infix_feature: INFIX_AS_B;
			normal_feature: FEAT_NAME_ID_AS_B;
		do
			normal_feature ?= other;
			infix_feature ?= other;
			if infix_feature /= void then
				Result := fix_operator < infix_feature.fix_operator
			else
				check
					normal_feature /= void
				end;
				Result := false;
			end;
		end;

feature

	internal_name: ID_AS_B is
			-- Internal name used by the compiler
		local
			value, to_append: STRING;
		do
-- FIXME: same implementation as parent, different type
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

feature -- Output

	format (ctxt: FORMAT_CONTEXT_B) is
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
				ctxt.prepare_for_infix (internal_name, void);
			else
				ctxt.prepare_for_prefix (internal_name);
			end;
			adapt_main_feature (ctxt)
		end;

	main_feature_format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text for main features of a class.
		do
			if is_frozen then 
				ctxt.put_text_item (ti_Frozen_keyword);
				ctxt.put_space
			end;
			ctxt.prepare_for_main_feature;
			adapt_main_feature (ctxt)
		end;

end -- class INFIX_AS_B
