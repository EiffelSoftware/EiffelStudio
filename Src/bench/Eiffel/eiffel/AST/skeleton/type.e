indexing

	description: "Abstract class for Eiffel types. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TYPE_AS

inherit
	AST_EIFFEL

feature -- Properties

	has_like: BOOLEAN is
			-- Is the type an anchored type ?
		do
			-- Do nothing
		end;

	has_formal_generic: BOOLEAN is
			-- Has type a formal generic parameter?
		do
			-- Do nothing
		end

	is_loose: BOOLEAN is
			-- Does type depend on formal generic parameters and/or anchors?
		do
			-- Do nothing
		ensure
			definition: Result = (has_like or has_formal_generic)
		end

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

	frozen is_deep_equal (other: TYPE_AS): BOOLEAN is
			-- Is the current type the same as `other' ?
			--| `deep_equal' cannot be used as for STRINGS, the area
			--| can have a different size but the STRING is still
			--| the same (problem detected for LIKE_FEATURE). Xavier
		do
			Result := other /= Void and then other.same_type (Current)
				and then is_internal_equivalent (other)
		end;

feature -- Comparison

	same_as (other: TYPE_AS): BOOLEAN is
			-- Is `other' the same as Current ?
			--|Note: implemented only for descendants of TYPE_A
		do
		end;

feature {NONE} -- Comparison

	frozen is_internal_equivalent (other: TYPE_AS): BOOLEAN is
			-- Safe call for descendants classes of AST_EIFFEL to `is_equivalent'.
		require
			other_not_void: other /= Void
			same_type: same_type (other)
		local
			l_other: like Current
		do
			l_other ?= other
			check
				not_void_since_same_type: l_other /= Void
			end
			Result := is_equivalent (l_other)
		end
	
feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feature table `feat_table'
		require
			feat_table_not_void: feat_table /= Void
			f_not_void: f /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	solved_type_for_format (feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feature table `feat_table'.
			-- This is for the format context where the solved type is not
			-- guaranteed to exist
		require
			feat_table_not_void: feat_table /= Void
			f_not_void: f /= Void
		do
			Result := solved_type (feat_table, f)
		ensure
			result_not_void: Result /= Void
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
				create vcfg3;
				vcfg3.set_class (a_class);
				vcfg3.set_formal_name ("Constraint genericity");
				vcfg3.set_location (start_location)
				Error_handler.insert_error (vcfg3);
			end
		end;

feature -- Output

	trace is
		do
			io.error.put_string (dump);
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

end -- class TYPE_AS
