class

	EXEC_MODES

feature {NONE}

	No_stop_points: INTEGER is unique;
			-- Execution with no stop points taken into account

	User_stop_points: INTEGER is unique;
			-- Execution with user-defined stop points taken into account

	Routine_breakables: INTEGER is unique;
			-- Execution with only breakable points of current 
			-- routine taken into account

	Routine_breakables_and_user_stop_points: INTEGER is unique;
			-- Execution with breakable points of current routine 
			-- and user-defined stop points taken into account

	Routine_stop_points: INTEGER is unique;
			-- Execution with only user-defined stop points of 
			-- current routine taken into account

	Last_routine_breakable: INTEGER is unique;
			-- Execution with only the last breakable point of 
			-- current routine taken into account

end -- class EXEC_MODES
