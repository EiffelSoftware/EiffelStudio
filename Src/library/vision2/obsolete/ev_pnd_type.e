class
	EV_PND_TYPE

inherit
	HASHABLE

create
	make, make_with_cursor, make_with_id

feature {NONE} -- Initialization

	make is do end

	make_with_cursor (curs: EV_CURSOR) is do end

	make_with_id (id: INTEGER) is do end

feature -- Attribute

	identifier: INTEGER

	cursor: EV_CURSOR
	
feature -- Access

	set_cursor (curs: EV_CURSOR) is do end

feature {EV_PND_TARGET_I} -- Implementation

	hash_code: INTEGER is do end

feature {NONE} -- Implementation

	counter: INTEGER_REF is do end

end -- class EV_PND_TYPE
