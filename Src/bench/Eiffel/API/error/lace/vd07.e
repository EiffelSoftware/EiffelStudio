-- Error for unvalid include file name

class VD07

inherit

	EXC_INC_ERROR

feature

	code: STRING is
			-- Error code
		do
			Result := "VD07";
		end;

end
