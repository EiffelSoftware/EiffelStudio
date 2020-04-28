note

	description:

		"Equality tester for EWG_EWG_C_AST_FUNCTION_TYPE objects"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_AST_FUNCTION_TYPE_EQUALITY_TESTER

inherit

	KL_EQUALITY_TESTER [EWG_C_AST_FUNCTION_TYPE]
		redefine
			test
		end

feature -- Status report

	test (v, u: EWG_C_AST_FUNCTION_TYPE): BOOLEAN 
			-- Are `v' and `u' considered equal?
		do
			if v = u then
				Result := True
			elseif v = Void then
				Result := (u = Void)
			elseif u = Void then
				Result := False
			else
				Result := v.is_same_type (u)
			end
		end

end
