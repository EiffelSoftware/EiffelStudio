-- Error for Lace

deferred class LACE_ERROR

inherit

	ERROR

feature

	code: STRING is
		do
			Result := generator;
		end;

end
