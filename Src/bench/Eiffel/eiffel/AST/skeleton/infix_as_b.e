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
			temp_name
		redefine
			fix_operator, infix "<", internal_name, 
			main_feature_format
		end;

	FEATURE_NAME_B
		undefine
			is_infix, is_valid, offset, 
			main_feature_format, simple_format
		redefine
			format
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

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			if is_frozen then 
				ctxt.put_text_item (ti_Frozen_keyword);
				ctxt.put_space
			end;
			if is_infix then
				ctxt.put_text_item (ti_Infix_keyword);
				ctxt.put_space;
				ctxt.put_text_item (ti_Double_quote);
				ctxt.prepare_for_infix (internal_name, void);
			else
				ctxt.put_text_item (ti_Prefix_keyword);
				ctxt.put_space;
				ctxt.put_text_item (ti_Double_quote);
				ctxt.prepare_for_prefix (internal_name);
			end;
			ctxt.put_fix_name (ctxt.new_types.final_name);
			ctxt.put_text_item (ti_Double_quote);
			ctxt.commit;
		end;

	main_feature_format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			if is_frozen then
				ctxt.put_text_item (ti_Frozen_keyword);
				ctxt.put_space
			end;
			if is_infix then
				--ctxt.put_text_item (ti_Infix_keyword);
				--ctxt.put_space;
				ctxt.prepare_for_main_infix;
			else
				--ctxt.put_text_item (ti_Prefix_keyword);
				--ctxt.put_space;
				ctxt.prepare_for_main_prefix;
			end;
			ctxt.put_main_fix;
			ctxt.commit;
		end;
	
end -- INFIX_AS_B
