class
	OBJECT
inherit 
	MEMORY
		redefine
			dispose
		end
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

--|----------------------------------------------------------------
--| CECIL: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

