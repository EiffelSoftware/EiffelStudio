indexing

	description:
		"The objects available from the environment at time of execution";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"


class EXECUTION_ENVIRONMENT

feature -- Access

	command_line: ARGUMENTS is
			-- Command line that was used to start current execution
		once
			!!Result
		end

	current_working_directory: STRING is
			-- Directory of current execution 
		external
			"C"
		alias
			"dir_current"	
		end

	default_shell: STRING is
		once
			Result := get ("SHELL")
			if Result = Void then
				Result := ""
			end
		end

	get (s: STRING): STRING is
				-- Value of `s' if it is an environment variable and has been set;
				-- void otherwise.
		require
			s_exists: s /= Void
		local
			ext: ANY;
		do
			ext := s.to_c
			ext := eif_getenv($ext)
			if ext /= Void then
				!!Result.make (0)
				Result.from_c (ext)
			end
		end		

feature -- Status
	
	return_code : INTEGER 
			--  Status code set by last call to `system' or `put'


feature -- Status setting
	
	put (value,key: STRING) is
			-- Set the environment variable `key' to `value'.
		require
			key_exists: key /= Void
			key_meaningful: key.count > 0
			value_exists: value /= Void
		local
			v_to_c, k_to_c: ANY;
		do
			v_to_c := value.to_c
			k_to_c := key.to_c
			return_code := eif_putenv(v_to_c, k_to_c)
		ensure
			variable_set: (return_code = 0) implies (value.is_equal (get (key)))
		end

	system (s: STRING) is
			 -- Pass to the operating system a request to to execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_exists: s /= Void
		local
			ext : ANY
		do
			if s.empty then
				ext := default_shell.to_c
			else
				ext := s.to_c
			end
			return_code := system_call ($ext)
		end

feature {NONE} -- External

	eif_getenv (s : ANY): ANY is
			-- Value of environment variable `s'
		external
			"C"	
		end

	eif_putenv (v, k: ANY): INTEGER is
			-- Set `s' in the environment.
		external
			"C"	
		end

	system_call (s : ANY): INTEGER is
			-- Pass to the operating system a request to execute `s'.
		external
			"C"
		alias 
			"eif_system"
		end

end -- class EXECUTION_ENVIRONMENT


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

