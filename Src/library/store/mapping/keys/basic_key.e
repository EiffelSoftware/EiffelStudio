indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BASIC_KEY

inherit
	KEY

feature -- Initialization

	make (type: like item)  is
			-- Initialize
		do
			item:=type	
		end

feature --Access

	item : HASHABLE

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := item.hash_code 
		end

	is_basic: BOOLEAN is True

end -- class BASIC_KEY
