class ONCE_AS

inherit

	INTERNAL_AS
		redefine
			is_once
		end;

feature

	is_once: BOOLEAN is
			-- Is the current routine body a once one ?
		do
			Result := true;
		end;

feature {}

	begin_keyword: BASIC_TEXT is
			-- "once" keyword
		once
			Result := ti_Once_keyword
		end;

end
