indexing
	description:	"abstract definition of C-type string helper features."
	note:				"the implementation may be different on different%
						%Eiffel-compilers"

class
	C_STRING_HELPER_ABS
feature
	create_copy_of_string_from_zstring (c_string_ptr: POINTER) is
			-- creates a Eiffel STRING object from a zero terminated C-string
			-- the data will be copied so 'c_string_ptr' needs only to be valid
			-- during the execution of this feature.
			--
			-- The Eiffel-STRING object will be stored in 'last_string'
		require
			c_string_ptr /= default_pointer
		deferred
		ensure
			last_string /= Void
		end

	last_string: STRING
	
end -- class C_STRING_HELPER_ABS
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------