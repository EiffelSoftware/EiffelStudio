indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_KEY

inherit
	KEY

create
	make

feature -- Initialization

	make (type: like item)  is
			-- Initialize
		do
			item:=type	
		end


feature --Access

	item : HASHABLE


feature -- All hash_table

	table : HASH_TABLE[ANY, like item] is 
		once
			create Result.make(20)
		end


feature --Process
	
	add_key_table (a: ANY ; i: like item) is
		do
			table.extend(a,i)
		end

end -- class BASIC_KEY
