-- Error for an include file without any class in it

class VD08

inherit

	EXC_INC_ERROR

feature

	code: STRING is
			-- Error code
		do
			Result := "VD08";
		end

end
