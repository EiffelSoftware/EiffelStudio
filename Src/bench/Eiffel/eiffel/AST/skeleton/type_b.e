indexing

	description: "Abstract class for Eiffel types. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TYPE_B

inherit

	TYPE
		redefine
			is_deep_equal, same_as
		end;

	AST_EIFFEL_B
		undefine
			simple_format
		end;

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feature table `feat_table'
		deferred
		end;

	actual_type: TYPE_A is
			-- Processed type of the type without taking care of the
			-- anchored type.
		deferred
		end;

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string (dump)
		end;

	same_as (other: TYPE_B): BOOLEAN is
			-- Is `other' the same as Current ?
			--|Note: implemented only for descendants of TYPE_A
		do
			-- Do nothing: implemented only for descendants of TYPE_A
		end;

	is_deep_equal (other: TYPE_B): BOOLEAN is
			-- Is the current type the same as `other' ?
			--| `deep_equal' cannot be used as for STRINGS, the area
			--| can have a different size but the STRING is still
			--| the same (problem detected for LIKE_FEATURE). Xavier
		do
			Result := deep_equal (Current, other)
		end;

	check_constraint_type (a_class: CLASS_C) is
			-- Is the constraint type valid in the
			-- context of `a_class' ?
			-- A valid type is a class type that exists
			-- in the system
		local
			vcfg3: VCFG3;
		do
			if has_like then
				!!vcfg3;
				vcfg3.set_class (a_class);
				vcfg3.set_formal_name ("Constraint genericity");
				Error_handler.insert_error (vcfg3);
			end
		end;

end -- class TYPE_B
