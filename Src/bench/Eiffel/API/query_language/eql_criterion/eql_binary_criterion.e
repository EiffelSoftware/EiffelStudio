indexing
	description: "Object that represents a binary logic operation upon two EQL criteria"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_BINARY_CRITERION

inherit
	EQL_CRITERION

feature{NONE} -- Initialization

	make (a_cri1: like cri1; a_cri2: like cri2) is
			-- Initialize `cri1' with `a_cri1' and `cri2' with `a_cri2'.
		require
			a_cri1_not_void: a_cri1 /= Void
			a_cri2_not_void: a_cri2 /= Void
		do
			set_criteria (a_cri1, a_cri2)
		end

feature -- Operand criteria

	cri1: EQL_CRITERION
			-- First criterium	

	cri2: EQL_CRITERION
			-- Second criterium

feature -- Operand criteria setting

	set_cri1 (a_cri: like cri1) is
			-- Set `cri1' with `a_cri'.
		require
			a_cri_not_void: a_cri /= Void
		do
			cri1 := a_cri
		ensure
			cri1_set: cri1 = a_cri
		end

	set_cri2 (a_cri: like cri2) is
			-- Set `cri2' with `a_cri'.
		require
			a_cri_not_void: a_cri /= Void
		do
			cri2 := a_cri
		ensure
			cri2_set: cri2 = a_cri
		end

	set_criteria (a_cri1: like cri1; a_cri2: like cri2) is
			-- Initialize `cri1' with `a_cri1' and `cri2' with `a_cri2'.
		require
			a_cri1_not_void: a_cri1 /= Void
			a_cri2_not_void: a_cri2 /= Void
		do
			set_cri1 (a_cri1)
			set_cri2 (a_cri2)
		end

invariant
	cri1_not_void: cri1 /= Void
	cri2_not_void: cri2 /= Void

end
