indexing

	description:
			"Abstract description for formal generic type. %
			%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAL_AS_B

inherit

	FORMAL_AS
		undefine
			same_as
		redefine
			associated_eiffel_class
		select
			text_position
		end;
	TYPE_B
		rename
			position as text_b_position
		undefine
			simple_format, format
		end;

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): FORMAL_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		do
			Result := actual_type;
		end;

	actual_type: FORMAL_A is
			-- Actual type for formal generic
		do
			!!Result;
			Result.set_position (position);
		end;

feature -- Output

	format (ctxt: FORMAT_CONTEXT_B) is
		local
			l_a: LOCAL_FEAT_ADAPTATION;
			new_type: TYPE_A
		do
			l_a := ctxt.local_adapt;
			if l_a /= Void then
				new_type := ctxt.local_adapt.adapted_type (Current);
			end;
			if new_type = Void then
				simple_format (ctxt)
			else
				new_type.format (ctxt)
			end;
		end;

feature -- Stoning
 
	associated_eiffel_class (ref_class: CLASS_C): CLASS_C is
		do  
			Result := actual_type.associated_eclass;
		end;

end -- class FORMAL_AS_B
