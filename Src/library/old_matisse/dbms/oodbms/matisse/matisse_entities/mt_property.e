class MT_PROPERTY 

inherit

	MT_PROPERTY_EXTERNAL

feature -- Status Report

	is_ok (one_object : MT_OBJECT) : BOOLEAN  is
		-- Is property ok ?
		do
			Result := c_check_property(id,one_object.oid)
		end -- check

feature  -- Access

	id : INTEGER
		-- Identifier in database

end -- class MT_PROPERTY
