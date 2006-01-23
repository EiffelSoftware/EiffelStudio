indexing
	description: "Object, which posts the bank account report."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POST_OFFICE
create
	make

feature	-- Initialization

	make (ptr: POINTER; p: BOOLEAN_REF) is
		do
			continue := True
			info := ptr
			finished := p
		end
	
feature	-- Access

	finished: BOOLEAN_REF

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
			res := io.last_string.twin
			if not res.is_equal ("y") then
				finished.set_item (True)
			end
		end

feature	{NONE} -- Externals

	c_post (ptr: POINTER) is
		external
			"C | %"fext.h%""
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


end -- class POST_OFFICE

