-- Inspect expression is not of type INTEGER or CHARACTER

class VOMB1 

inherit

	FEATURE_ERROR
	
feature

	multi_branch: INSPECT_AS;
			-- Inpect instruction node

	set_multi_branch (n: like multi_branch) is
			-- Assign `n' to `multi_branch'.
		do
			multi_branch := n;
		end;

	code: STRING is "VOMB";
			-- Error code

end
