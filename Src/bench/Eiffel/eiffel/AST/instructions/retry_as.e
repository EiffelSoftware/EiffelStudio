indexing

	description:
			"Abstract description of an Eiffel loop instruction. %
			%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class RETRY_AS

inherit
	INSTRUCTION_AS
		redefine
			byte_node
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			line_number := yacc_line_number
		end

feature -- Comparison
		
	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_Retry_keyword)
		end

feature -- Type check and byte code

	byte_node: RETRY_B is
			-- Associated byte code
		do
			!!Result
			Result.set_line_number (line_number)
		end

	perform_type_check is
			-- Type check a retry instruction
		local
			vxrt: VXRT
		do
			if not context.level3 then
					-- Retry instruction outside a recue clause
				!!vxrt
				context.init_error (vxrt)
				Error_handler.insert_error (vxrt)
			end
		end

end -- class RETRY_AS
