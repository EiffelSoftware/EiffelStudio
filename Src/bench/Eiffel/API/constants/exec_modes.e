class

	EXEC_MODES

feature -- Execution mode properties

	No_stop_points: INTEGER is 1;
			-- Execution with no stop points taken into account

	User_stop_points: INTEGER is 2;
			-- Execution with user-defined stop points taken into account

	All_breakable_points: INTEGER is 3;
			-- -- Execution with all breakable points set

	Routine_breakables: INTEGER is 4;
			-- Execution with only breakable points of current 
			-- routine taken into account

	Routine_breakables_and_user_stop_points: INTEGER is 5;
			-- Execution with breakable points of current routine 
			-- and user-defined stop points taken into account

	Routine_stop_points: INTEGER is 6;
			-- Execution with only user-defined stop points of 
			-- current routine taken into account

	Last_routine_breakable: INTEGER is 7;
			-- Execution with only the last breakable point of 
			-- current routine taken into account

	Out_of_routine: INTEGER is 8;
			-- Execution with all breakable points set except
			-- those of the current routine.

end -- class EXEC_MODES
