class INVARIANT_SERVER

inherit
	LINKED_LIST [INVARIANT_FSAS];


creation
	make


feature

	format (ctxt: FORMAT_CONTEXT) is
		local
			is_not_first: BOOLEAN;
		do
			if not empty then
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
			end;
		end;

end
