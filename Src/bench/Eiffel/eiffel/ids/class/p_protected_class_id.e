-- Precompiled protected class ids.
-- Protected classes are GENERAL, ANY, DOUBLE, REAL,
-- INTEGER, BOOLEAN, CHARACTER, ARRAY, BIT, POINTER, STRING
 
class P_PROTECTED_CLASS_ID
 
inherit
 
	P_CLASS_ID
		redefine
			protected
		end
 
creation
 
	make
 
feature -- Status report
 
	protected: BOOLEAN is True
			-- Is the class associated with id protected?
 
end -- class P_PROTECTED_CLASS_ID
