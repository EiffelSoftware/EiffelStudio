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
		redefine
			byte_node
		end

feature -- Type check and byte code

	byte_node: RETRY_B is
			-- Associated byte code
		do
			!!Result
			Result.set_line_number (line_number)
		end;

	perform_type_check is
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

end -- class RETRY_AS_B
