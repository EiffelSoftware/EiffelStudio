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
