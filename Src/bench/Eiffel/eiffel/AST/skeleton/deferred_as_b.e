class DEFERRED_AS_B

inherit

	DEFERRED_AS;

	ROUT_BODY_AS_B
		undefine
			is_deferred, has_instruction, index_of_instruction
		redefine
			byte_node
		end

feature -- byte code

	byte_node: DEF_BYTE_CODE is
			-- Byte code for deferred feature
		do
			!!Result;
		end;

end -- class DEFERRED_AS_B
