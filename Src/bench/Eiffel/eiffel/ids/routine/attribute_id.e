-- Attribute ids.

class ATTRIBUTE_ID

inherit

	ROUTINE_ID
		redefine
			is_attribute
		end

creation

	make

feature -- Status report

	is_attribute: BOOLEAN is True;
			-- Is current id an attribute id?

end -- class ATTRIBUTE_ID
