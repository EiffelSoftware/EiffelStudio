indexing

	description: "Abstract class for Eiffel types. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TYPE

inherit
	AST_EIFFEL

feature -- Properties

	has_like: BOOLEAN is
			-- Is the type an anchored type ?
		do
			-- Do nothing
		end;

	is_void: BOOLEAN is
			-- Is the type void (procedure type) ?
		do
			-- Do nothing
		end;

	is_like_current: BOOLEAN is
			-- Is the current type a anchored type an Current ?
		do
			-- Do nothing
		end;

feature -- Access

	frozen is_deep_equal (other: TYPE): BOOLEAN is
			-- Is the current type the same as `other' ?
			--| `deep_equal' cannot be used as for STRINGS, the area
			--| can have a different size but the STRING is still
			--| the same (problem detected for LIKE_FEATURE). Xavier
		do
			Result := other /= Void and then other.same_type (Current)
				and then is_equivalent (other)
		end;

feature -- Comparison

	same_as (other: TYPE): BOOLEAN is
			-- Is `other' the same as Current ?
			--|Note: implemented only for descendants of TYPE_A
		do
		end;

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feature table `feat_table'
		deferred
		end;

	solved_type_for_format (feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feature table `feat_table'.
			-- This is for the format context where the solved type is not
			-- guaranteed to exist
		do
			Result := solved_type (feat_table, f)
		end;

	actual_type: TYPE_A is
			-- Processed type of the type without taking care of the
			-- anchored type.
		deferred
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

feature -- Output

	trace is
		do
			io.error.putstring (dump);
		end;

	dump: STRING is
			-- Dumped trace
		deferred
		end;

	append_to (st: STRUCTURED_TEXT) is
			-- Append Current type to `st'.
		require
			non_void_st: st /= Void
		do
			st.add_string (dump)
		end;

feature

	is_solved: BOOLEAN is
			-- Is the type solved ? (i.e: is the type a result to a call
			-- to feature `solved_type' ?)
		do
			-- Do nothing
		end;

feature {COMPILER_EXPORTER} 

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_class_name (dump)
		end;

end -- class TYPE
