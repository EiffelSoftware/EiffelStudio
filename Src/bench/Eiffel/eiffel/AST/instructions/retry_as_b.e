indexing

	description:
			"Abstract description of an Eiffel loop instruction. %
			%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class RETRY_AS_B

inherit

	RETRY_AS;

	INSTRUCTION_AS_B
		undefine
			simple_format
		redefine
			type_check, byte_node,
			format
		end

feature -- Type check and byte code

	byte_node: RETRY_B is
			-- Associated byte code
		do
			!!Result
		end;

	type_check is
			-- Type check a retry instruction
		local
			vxrt: VXRT;
		do
			if not context.level3 then
					-- Retry instruction outside a recue clause
				!!vxrt;
				context.init_error (vxrt);
				Error_handler.insert_error (vxrt);
			end;
		end;

feature -- Debugger

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			ctxt.put_text_item (ti_Retry_keyword);
			ctxt.always_succeed;
		end;

end -- class RETRY_AS_B
