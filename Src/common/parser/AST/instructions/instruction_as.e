-- Abstract class for instruction AS node

deferred class INSTRUCTION_AS

inherit

	AST_EIFFEL
		redefine
			byte_node
		end

feature

	byte_node: INSTR_B is
			-- Associated byte code
		do
		ensure then
			False
		end

end
