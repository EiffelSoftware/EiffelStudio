class DEFERRED_AS

inherit

	ROUT_BODY_AS
		redefine
			is_deferred, byte_node
		end

feature -- Intialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

feature -- Conveniences

	is_deferred: BOOLEAN is
			-- Is the current routine body a defferred one ?
		do
			Result := True;
		end;

feature -- byte code

	byte_node: DEF_BYTE_CODE is
			-- Byte code for deferred feature
		do
			!!Result;
		end;

end
