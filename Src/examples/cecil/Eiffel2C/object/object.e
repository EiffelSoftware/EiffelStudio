class
	OBJECT
inherit 
	MEMORY
		redefine
			dispose
		end
creation
	make
feature	-- Initialization

	make(s: STRING) is
			-- Set string attribute
		do
			string := s
		end

feature	-- Display

	display is
			-- Display Current
		require
			not_void: string /= Void
		do
			io.put_string ("Object string is ")
			io.put_string (string)
			io.new_line
		end

feature	 -- Access
	
	string: STRING
			-- String identifier
	
feature	-- Dispose

	dispose is
		do 
			notice_dispose
		end

feature	-- Externals

	notice_dispose is
		external
			"C | %"fext.h%""
		end

	
end	
