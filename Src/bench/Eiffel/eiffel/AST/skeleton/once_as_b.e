class ONCE_AS_B

inherit

	ONCE_AS
		rename
			compound as old_compound
		end;

	INTERNAL_AS_B
		undefine
			is_once
		redefine
			byte_node
		select
			compound
		end;

feature

	byte_node: ONCE_BYTE_CODE is
			-- Byte code for once body
		do
			!!Result;
			if compound /= Void then
				Result.set_compound (compound.byte_node);
			end;
		end;

end -- class ONCE_AS_B
