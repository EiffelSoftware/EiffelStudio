class BIN_NE_AS

inherit

	BIN_EQ_AS
		redefine
			operator_name 
		end

feature

	operator_name: STRING is "_infix_/=";

end
