-- Protected class ids.
-- Protected classes are GENERAL, ANY, DOUBLE, REAL,
-- INTEGER, BOOLEAN, CHARACTER, ARRAY, BIT, POINTER, STRING

class PROTECTED_CLASS_ID

inherit

	CLASS_ID
		redefine
			protected
		end

creation

	make

feature -- Status report

	protected: BOOLEAN is True
			-- Is the class associated with id protected?

end -- class PROTECTED_CLASS_ID
