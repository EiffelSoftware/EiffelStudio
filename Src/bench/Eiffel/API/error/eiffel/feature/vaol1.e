-- Error when an old expression is found somewhere else that in a 
-- postcondition

class VAOL1 

inherit

	FEATURE_ERROR
	
feature 

	old_expr: UN_OLD_AS;
			-- Old expression involved in the error

	set_old_expr (o: like old_expr) is
			-- Assign `o' to `old_expr'.
		do
			old_expr := o;
		end;

	code: STRING is "VAOL";
			-- Error code

end
