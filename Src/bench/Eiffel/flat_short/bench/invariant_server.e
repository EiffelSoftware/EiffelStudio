class INVARIANT_SERVER

inherit
	LINKED_LIST [INVARIANT_FSAS];


creation
	make


feature

	format (ctxt: FORMAT_CONTEXT) is
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
					ctxt.next_line;
					item.format (ctxt);
					forth
				end;
			end;
		end;

end
