indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	OBJECT
inherit 
	DISPOSABLE

create
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
	
feature	-- Externals

	dispose is
		external
			"C | %"fext.h%""
		alias
			"notice_dispose"
		end
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end	

