-- Error for a root class having bad creation procedure arguments

class VSRC2 

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature

	code: STRING is "VSRC";

	subcode: INTEGER is 2;
	
feature

	creation_name: STRING;
			-- Creation procedure name involved in the error

	set_creation_name (s: STRING) is
			-- Assign `s' to `creation_name'.
		do
			creation_name := s;
		end;

end
