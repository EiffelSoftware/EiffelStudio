class FLAT_AST
	
inherit
	SHARED_TEXT_ITEMS

creation
	make

feature

	make (c: ANY) is
		do
			--class_c := c;
			--type := class_c.actual_type;
		end;

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			feature_as: FEATURE_AS;
			feat_adaptation: FEAT_ADAPTATION;
		do
			ctxt.put_text_item (ti_Before_feature_clause);
			ctxt.begin;
			ctxt.put_text_item (ti_Feature_keyword);
			ctxt.next_line;
			ctxt.indent_one_more;
			ctxt.next_line;
			ctxt.indent_one_less;
			ctxt.next_line;
			ctxt.commit;
			ctxt.put_text_item (ti_After_feature_clause)
		end;

end
