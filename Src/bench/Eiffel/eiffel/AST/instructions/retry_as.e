indexing

	description:
			"Abstract description of an Eiffel retry instruction. %
			%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class RETRY_AS

inherit
	INSTRUCTION_AS
		redefine
			byte_node
		end
		
	LEAF_AS

create
	make_with_location

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_retry_as (Current)
		end

feature -- Comparison
		
	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Type check and byte code

	byte_node: RETRY_B is
			-- Associated byte code
		do
			create Result
			Result.set_line_number (line)
		end

	perform_type_check is
			-- Type check a retry instruction
		local
			vxrt: VXRT
		do
			if not context.level3 then
					-- Retry instruction outside a recue clause
				create vxrt
				context.init_error (vxrt)
				vxrt.set_location (start_location)
				Error_handler.insert_error (vxrt)
			end
		end

end -- class RETRY_AS
