class ONCE_AS

inherit

	INTERNAL_AS
		redefine
			is_once, byte_node
		end;

feature

	is_once: BOOLEAN is
			-- Is the current routine body a once one ?
		do
			Result := true;
		end;

	byte_node: ONCE_BYTE_CODE is
			-- Byte code for once body
		do
			!!Result;
			if compound /= Void then
				Result.set_compound (compound.byte_node);
			end;
		end;

end
