indexing
	description: "Constants used in stepping contexte"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_CONTROL_CONSTANTS

feature {NONE} -- Value

--	Cst_step_range_next: INTEGER is 1
--	Cst_step_range_into: INTEGER is 2
	
	Cst_control_continue: INTEGER is 1
	Cst_control_stop: INTEGER is 2
	Cst_control_kill: INTEGER is 3
	Cst_control_step_next: INTEGER is 5
	Cst_control_step_into: INTEGER is 6
	Cst_control_step_out: INTEGER is 7
	Cst_control_nothing: INTEGER is 9

feature {NONE} -- stepping name

	control_mode_to_string (a_mode: INTEGER): STRING is
		do
			inspect a_mode 
--			when Cst_step_range_next then Result := "RangeNext"
--			when Cst_step_range_into then Result := "RangeInto"
			when Cst_control_continue then Result := "Continue"
			when Cst_control_stop then Result := "Stop"
			when Cst_control_kill then Result := "Kill"
			when Cst_control_step_next then Result := "Next"
			when Cst_control_step_into then Result := "Into"
			when Cst_control_step_out then Result := "Out"
			when Cst_control_nothing then Result := "Nothing"
				
			else Result := "Unknown stepping mode !"
			end
		end

end -- class EIFNET_DEBUGGER_CONTROL_CONSTANTS
