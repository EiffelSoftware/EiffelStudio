class INVARIANT_SERVER

inherit
	LINKED_LIST [INVARIANT_FSAS];

creation
	make

feature

	format (ctxt: FORMAT_CONTEXT) is
		local
			is_not_first: BOOLEAN;
			target_class: CLASS_C;
		do
			if not empty then
				ctxt.set_in_assertion;
				ctxt.begin;
				ctxt.next_line;
				ctxt.put_keyword ("invariant");
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
							ctxt.put_string ("-- from ");
							ctxt.put_class_name (item.source_class);
							ctxt.indent_one_less;
							ctxt.next_line;
						end;
					end;
					item.format (ctxt);
					ctxt.put_special (";")
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
					ctxt.commit
				else
					ctxt.rollback
				end
				ctxt.set_not_in_assertion;
			end;
		end;

end
