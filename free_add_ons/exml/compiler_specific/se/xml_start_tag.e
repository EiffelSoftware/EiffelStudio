class
	XML_START_TAG
inherit
	XML_START_TAG_ABS
creation
	make_from_c
feature {NONE} -- Implementation
	make_attribute_specifications_from_c (attr_spec_ptr: POINTER) is
			-- unfortunatly this feature uses some dirty C-tricks
		local
			a_name: STRING
			a_value: STRING
			attr: XML_ATTRIBUTE
			ptr1, ptr2: POINTER
		do
				-- make empty
			ptr1 := attr_spec_ptr
			from
				ptr2 := ptr_contents (ptr1)
			until
				ptr2 = default_pointer
			loop
				
				create_copy_of_string_from_zstring (ptr2)
				a_name := last_string
					
				ptr2 := ptr_contents (ptr_move (ptr1, 1))

				create_copy_of_string_from_zstring (ptr2)
				a_value := last_string

				!! attr.make (a_name, a_value)

				attributes.add_attribute (attr)

				ptr1 := ptr_move (ptr1, 2)
				ptr2 := ptr_contents (ptr1)
			end
		end

feature {NONE} -- Externals

	ptr_contents (ptr: POINTER): POINTER is
			-- returns the contents of a pointer given 'ptr' is of the C-type void**
		external
			"C"
		end

	ptr_move (ptr: POINTER; pos: INTEGER): POINTER is
			-- moves 'ptr' 'pos' characters further
		external
			"C"
		end
end -- class XML_START_TAG
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