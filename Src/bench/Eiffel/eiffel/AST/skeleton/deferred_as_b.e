class DEFERRED_AS_B

inherit

	DEFERRED_AS;

	ROUT_BODY_AS_B
		undefine
			is_deferred, has_instruction, index_of_instruction,
			simple_format
		redefine
			is_deferred, byte_node, format
		end

feature -- byte code

	byte_node: DEF_BYTE_CODE is
			-- Byte code for deferred feature
		do
			!!Result;
		end;

feature -- formatter

	format (ctxt: FORMAT_CONTEXT_B) is
		do
			ctxt.always_succeed;
			ctxt.put_text_item (ti_Deferred_keyword);
		end;

end -- class DEFERRED_AS_B
