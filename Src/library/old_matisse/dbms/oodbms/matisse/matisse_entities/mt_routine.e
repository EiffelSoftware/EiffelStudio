deferred class MT_ROUTINE 

inherit

	INTERNAL
		export {NONE} all
		end

feature -- Access

	arguments: ARRAY [ANY] -- Arguments of routine body

feature -- Status Report

	name: STRING is
		-- Routine name used to communicate with C
		once
			Result := class_name (Current)
		ensure
			Result.is_equal (class_name (Current))
		end -- name

feature -- Status Setting

	set_arguments (parameter_list: ARRAY [ANY]) is
		-- Set `arguments'.
		require
			parameter_list /= void
		do
			arguments := parameter_list
		ensure
			arguments = parameter_list
		end -- set_arguments

feature -- Action

	execute is
		-- To be implemented in descendant class.
		deferred
		end -- execute

end -- class MT_ROUTINE
