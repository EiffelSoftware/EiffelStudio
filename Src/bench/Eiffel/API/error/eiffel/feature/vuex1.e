-- Error for a call to a local ar an argument with parameters

class VUEX1 

inherit

	FEATURE_ERROR
	
feature

	access: ACCESS_INV_AS;
			-- Access to an argument or a local

	set_access (a: like access) is
			-- Assign `a' to `access'.
		do
			access := a;
		end;
	
	code: STRING is "VUEX";
			-- Error code

end
