class ADDRESS_RESULT_AS_B

inherit

	ADDRESS_RESULT_AS;

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
			-- Byte code for current node
		local
			result_access: RESULT_B;
		do
			!!result_access;
			!!Result.make (result_access);
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Dollar);
			ctxt.put_string ("Result");
			ctxt.always_succeed;
		end;

end -- class ADDRESS_RESULT_AS_B
