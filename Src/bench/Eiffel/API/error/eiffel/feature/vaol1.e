-- Error when an old expression is found somewhere else that in a 
-- postcondition

class VAOL1 

inherit

	FEATURE_ERROR
		redefine
			subcode
		end;

feature

	code: STRING is "VAOL";
			-- Error code

	subcode: INTEGER is
		do
			Result := 1
		end;

end
