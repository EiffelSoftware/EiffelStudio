-- Error for creating a new derivation of SPECIAL or TO_SPECIAL in `melt_only' mode
-- A refreezing is not possible

class MELT_EXP 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;

feature 

	code: STRING is "MELT_EXP";
			-- Error code

	generic_type: GEN_TYPE_I;

	set_generic_type (g: GEN_TYPE_I) is
		do
			generic_type := g;
		end;

	build_explain is
		do
			generic_type.trace;
		end;

end
