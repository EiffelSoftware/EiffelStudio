-- Abstract description of retry instruction

class RETRY_AS

inherit

	INSTRUCTION_AS
		redefine
			type_check, byte_node,
			format
		end

feature -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

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
 

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			ctxt.put_keyword("retry");
			ctxt.always_succeed;
		end;

end
