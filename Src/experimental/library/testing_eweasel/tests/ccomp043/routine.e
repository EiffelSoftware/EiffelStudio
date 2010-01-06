indexing

	description: "[
		Objects representing delayed calls to a routine,
		with some operands possibly still open
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUTINE [BASE_TYPE, OPEN_ARGS -> TUPLE]

feature

	frozen operands: OPEN_ARGS 

	callable: BOOLEAN is do end

	valid_operands (args: OPEN_ARGS): BOOLEAN is do end

	open_count: INTEGER

	frozen set_operands (args: OPEN_ARGS) is do end

	call (args: OPEN_ARGS) is do end

	apply is do end

	frozen closed_operands: TUPLE

	closed_count: INTEGER is
		do
		end

	frozen rout_disp: POINTER

	frozen calc_rout_addr: POINTER
	
	frozen open_map: SPECIAL [INTEGER]

	frozen encaps_rout_disp: POINTER

	frozen class_id: INTEGER

	frozen feature_id: INTEGER

	frozen is_precompiled: BOOLEAN is do end

	frozen is_basic: BOOLEAN is
		do
		end

	frozen is_target_closed: BOOLEAN is
		do
		end
	
	frozen is_inline_agent: BOOLEAN is
		do
		end

	frozen flags: INTEGER

	frozen set_rout_disp (a_rout_disp, a_encaps_rout_disp, a_calc_rout_addr: POINTER
						  a_class_id, a_feature_id: INTEGER; a_open_map: SPECIAL [INTEGER] 
						  a_is_precompiled, a_is_basic, a_is_target_closed, a_is_inline_agent: BOOLEAN
						  a_closed_operands: TUPLE; a_open_count: INTEGER) is
			-- Initialize object.
		do
		end

	frozen set_rout_disp_final (a_rout_disp, a_encaps_rout_disp, a_calc_rout_addr: POINTER
						 a_is_target_closed: BOOLEAN; a_closed_operands: TUPLE; a_open_count: INTEGER) is
			-- Initialize object.
		do
		end

end -- class ROUTINE

