indexing

	description: 
		"Server for invariants.";
	date: "$Date$";
	revision: "$Revision $"

class INVARIANT_SERVER

inherit

	LINKED_LIST [INVARIANT_ADAPTER];
	SHARED_TEXT_ITEMS
		undefine
			copy, is_equal
		end

creation

	make

feature -- Output

	format (ctxt: FORMAT_CONTEXT) is
		local
			is_not_first: BOOLEAN
			target_class: CLASS_C
		do
			if not is_empty then
				target_class := ctxt.class_c
				ctxt.set_in_assertion
				ctxt.begin
				ctxt.put_text_item (ti_Before_invariant)
				ctxt.put_text_item_without_tabs (ti_Invariant_keyword)
				ctxt.indent
				ctxt.new_line
				ctxt.new_line
				from
					start
				until
					after
				loop
					ctxt.begin
					if target_class /= item.source_class then
						ctxt.indent
						ctxt.put_text_item (ti_Dashdash)
						ctxt.put_space
						ctxt.put_comment_text ("from ")
						ctxt.put_classi (item.source_class.lace_class)
						ctxt.exdent
						ctxt.new_line
					end
					item.format (ctxt)
					ctxt.new_line
					if ctxt.last_was_printed then
						is_not_first := true
						ctxt.commit
					else
						ctxt.rollback
					end
					forth
				end
				if is_not_first then
					ctxt.new_line
					ctxt.commit
					ctxt.put_text_item (ti_After_invariant)
				else
					ctxt.rollback
				end
				ctxt.set_not_in_assertion
			end
		end

end
