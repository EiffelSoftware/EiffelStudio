class ADDRESS_CURRENT_AS_B

inherit

	ADDRESS_CURRENT_AS;

	EXPR_AS_B
		undefine
			simple_format
		redefine
			type_check, byte_node, format
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an adress access on Current
		do
			context.put (pointer_type);
		end;

	byte_node: HECTOR_B is
			-- Byte code for current node.
		local
			current_access: CURRENT_B;
		do
			!!current_access;
			!!Result.make (current_access);
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Dollar);
			ctxt.put_string ("Current");
			ctxt.always_succeed;
		end;	

end -- class ADDRESS_CURRENT_AS_B
