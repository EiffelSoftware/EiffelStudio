class ONCE_AS_B

inherit

	ONCE_AS
		redefine
			compound
		end;

	INTERNAL_AS_B
		undefine
			is_once
		redefine
			byte_node, compound
		end;

feature -- Properties

	compound: EIFFEL_LIST_B [INSTRUCTION_AS_B]

feature -- Access

	byte_node: ONCE_BYTE_CODE is
			-- Byte code for once body
		do
			!!Result;
			if compound /= Void then
				Result.set_compound (compound.byte_node);
			end;
			Result.record_separate_calls_on_arguments
		end;

end -- class ONCE_AS_B
