indexing
	description: "Object, which posts the bank account report."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POST_OFFICE
creation
	make

feature	-- Initialization

	make (ptr: POINTER; p: PROXY [BOOLEAN_REF]) is
		do
			continue := True
			info := ptr
			finished := p
		end

	
feature	-- Access

	finished : PROXY [BOOLEAN_REF]

	continue: BOOLEAN

	info: POINTER

feature -- Display

	post is
		local
			res: STRING
		do
			c_post (info)
			io.put_string ("Do you want to continue? (y/n)%N")
			io.read_line
			res := clone (io.last_string)
			if not res.is_equal ("y") then
				finished.item.set_item (True)
			end
		end

feature	{NONE} -- Externals

	c_post (ptr: POINTER) is
		external
			"C | %"fext.h%""
		end
	
end -- class POST_OFFICE

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

