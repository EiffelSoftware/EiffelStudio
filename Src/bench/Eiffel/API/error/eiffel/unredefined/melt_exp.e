indexing

	description: 
		"Error for creating a new derivation of SPECIAL or %
		%TO_SPECIAL in `melt_only' mode. A refreezing is not possible.";
	date: "$Date$";
	revision: "$Revision $"

class MELT_EXP 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;

feature -- Properties

	code: STRING is "MELT_EXP";
			-- Error code

	generic_type: GEN_TYPE_A;

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Type: ");
			generic_type.append_to (st);
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_generic_type (g: GEN_TYPE_I) is
		require
			valid_g: g /= Void
		do
			generic_type := g.type_a;
		end;

end -- class MELT_EXP
