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
				ctxt.put_keyword ("invariant");
				ctxt.indent_one_more;
				from
					start
				until
					after
				loop
					ctxt.begin;
					ctxt.next_line;
					item.format (ctxt);
					if ctxt.last_was_printed then
						is_not_first := true;
						ctxt.commit
					else
						ctxt.rollback
					end;
					forth
				end;
			end;
		end;

end
