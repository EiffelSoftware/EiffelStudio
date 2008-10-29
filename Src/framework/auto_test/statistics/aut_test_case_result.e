indexing
	description:

		"Test case result"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_TEST_CASE_RESULT

create

	make

feature {NONE} -- Initialization

	make (a_witness: like witness; a_class: like class_; a_feature: like feature_) is
			-- Create new classification of feature `a_feature' from class `a_class' based on
			-- witness `a_witness'.
		require
			a_witness_not_void: a_witness /= Void
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
		do
			witness := a_witness
			class_ := a_class
			feature_ := a_feature
		ensure
			witness_set: witness = a_witness
			class_set: class_ = a_class
			feature_set: feature_ = a_feature
		end

feature -- Status Report

	is_pass: BOOLEAN is
			-- Did test case pass?
		do
			Result := witness.is_pass
		end

	is_fail: BOOLEAN is
			-- Did test case fail? This means a bug was found.
		do
			Result := witness.is_fail
		end

	is_invalid: BOOLEAN is
			-- Was test case not executable because a prerequisite was not
			-- established? Most often this means a precondition was violated.
		do
			Result := witness.is_invalid
		end

	is_bad_response: BOOLEAN is
			-- Did an unknown error occure that made the interpreter respond
			-- in an unexpected way?
		do
			Result := witness.is_bad_response
		end

feature -- Access

	class_: CLASS_C
			-- Class of `feature_'

	feature_: FEATURE_I
			-- Feature that was called

	witness: AUT_WITNESS
			-- Witness for this classification

invariant

	witness_not_void: witness /= Void
	class_not_void: class_ /= Void
	feature_not_void: feature_ /= Void

end
