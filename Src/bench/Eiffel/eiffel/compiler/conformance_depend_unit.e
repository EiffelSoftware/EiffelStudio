class CONFORMANCE_DEPEND_UNIT

inherit
	DEPEND_UNIT
		rename
			is_equal as old_is_equal,
			infix "<" as old_less_than,
			make as depend_unit_make
		end
	DEPEND_UNIT
		rename
			make as depend_unit_make
		redefine
			is_equal, infix "<"
		select
			is_equal, infix "<"
		end

creation
	make

feature {NONE} -- Initialization

	make (c_id, conf_id: CLASS_ID) is
			-- Initialization of conformance unit
		do
			id := c_id
			feature_id := -3
			conformance_id := conf_id
		end

feature -- Access

	conformance_id: CLASS_ID
			-- conformance id.

feature -- Comparison

	infix "<" (other: DEPEND_UNIT): BOOLEAN is
		local
			o: CONFORMANCE_DEPEND_UNIT
		do
			if other.feature_id /= -3 then
				Result := old_less_than (other)
			else
				o ?= other
				Result := id < other.id or else
					(id.is_equal (other.id) and then conformance_id < o.conformance_id)
			end
		end

	is_equal (other: like Current): BOOLEAN is
		do
			Result := old_is_equal (other) and then conformance_id.is_equal (other.conformance_id)
		end

end
