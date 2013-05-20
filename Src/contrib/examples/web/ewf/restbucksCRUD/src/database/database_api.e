note
	description: "Summary description for {DATABASE_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_API
create
	make

feature -- Initialization

	make
		do
			create orders.make (10)
		end

feature -- Access

	orders: HASH_TABLE [ORDER, STRING]

;note
	copyright: "2011-2012, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
