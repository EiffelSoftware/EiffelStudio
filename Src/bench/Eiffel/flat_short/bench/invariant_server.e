class INVARIANT_SERVER

inherit
	LINKED_LIST [INVARIANT_FSAS];
	SHARED_TEXT_ITEMS

creation
	make

feature

	format (ctxt: FORMAT_CONTEXT_B) is
		local
			is_not_first: BOOLEAN;
			target_class: CLASS_C;
		do
			if not empty then
				ctxt.set_in_assertion;
				ctxt.begin;
				ctxt.put_text_item (ti_Before_invariant);
				ctxt.next_line;
				ctxt.put_text_item (ti_Invariant_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				from
					start
				until
					after
				loop
					ctxt.begin;
					if not ctxt.troff_format then
						target_class := ctxt.format.global_types.target_class;
						if target_class /= item.source_class then
							ctxt.indent_one_more;
							ctxt.put_text_item (ti_Dashdash);
							ctxt.put_space;
							ctxt.put_comment_text ("from ");
							ctxt.put_class_name (item.source_class);
							ctxt.indent_one_less;
							ctxt.next_line;
						end;
					end;
					item.format (ctxt);
					ctxt.put_text_item (ti_Semi_colon);
					ctxt.next_line;
					if ctxt.last_was_printed then
						is_not_first := true;
						ctxt.commit
					else
						ctxt.rollback
					end;
					forth
				end;
				if is_not_first then
					ctxt.commit;
					ctxt.put_text_item (ti_After_invariant)
				else
					ctxt.rollback
				end
				ctxt.set_not_in_assertion;
			end;
		end;

	storage_info (classc: CLASS_C; s: S_CLASS_DATA) is
		local
			is_not_first: BOOLEAN;
			target_class: CLASS_C;
		do
			if not empty then
				check
					count_equal_1: count = 1
				end;
				from
					start
				until
					after
				loop
					if item.assertion_list /= Void then
						s.set_invariants (item.storage_info (classc))
					end;
					forth
				end
			end;
		end;

end
