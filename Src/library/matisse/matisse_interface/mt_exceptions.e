indexing
	description: "Class which define the excption under Matisse"
	date: "$Date$"
	revision: "$Revision$"

class
	MT_EXCEPTIONS

inherit
	EXCEPTIONS
		rename
			class_name as exception_class_name
		redefine 
			is_developer_exception
		end

	MT_CONSTANTS
				
feature -- Status setting

	trigger (code: INTEGER; matisse_code: INTEGER; message: STRING) is
			-- Interrupt execution of current routine with exception
			-- of code 'code' and associated text 'message'.
		local
			str: ANY;
		do
			if message /= Void then
				str := message.to_c
			end
			c_set_matisse_exception_code (matisse_code)
			exclear
			eraise ($str, code);	
		end

	trigger_dev_exception (matisse_code: INTEGER; message: STRING) is
			-- Raise a developer exception.
		do
			trigger (Developer_exception, matisse_code, message)
		end
	
	raise_from_c (c_pointer: POINTER; latest_session_state: INTEGER) is 
			-- This procedure is used from external C functions
			-- c_pointer is a pointer to C string.
		do
			if current_db /= Void then
				current_db.set_state (latest_session_state)
			end
			exclear
			eraise (c_pointer, Developer_exception)
		end
	
		
feature -- Status report
	
	is_developer_exception: BOOLEAN is
			-- Is the last exception originally due to
			-- a developer exception?
		once
			Result := True
		end

feature -- Access

	matisse_exception_code: INTEGER is
		do
			Result := c_matisse_exception_code
		end
	
feature -- Externals

	c_matisse_exception_code: INTEGER is
		external
			"C"
		end
	
	c_set_matisse_exception_code (a_code: INTEGER) is
		external 
			"C"
		end

end -- class MT_EXCEPTIONS
