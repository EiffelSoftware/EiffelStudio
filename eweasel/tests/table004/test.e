indexing
	description:
		""

	status:	"See notice at end of class"
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create

	make

feature {NONE} -- Initialization

	make is
		local
			h: HASH_TABLE [INTEGER, INTEGER]
		do
			create h.make (5)
			h.force (123, 1)
			io.output.put_string ("h.item(1)=" + h.item (1).out + "%N")
			io.output.put_string ("replace key `1' by `2' %N")
			h.replace_key (2, 1)
			io.output.put_string ("h.item(2)=" + h.item (2).out + "%N")
		end

end -- class TEST
