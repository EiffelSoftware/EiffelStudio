class DO_AS

inherit

	INTERNAL_AS

feature {}

	begin_keyword: BASIC_TEXT is
			-- "do" keyword
		once
			Result := ti_Do_keyword
		end;

end -- class DO_AS
