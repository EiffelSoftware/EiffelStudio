indexing
	description:"Objects representig a XML-start tag"
	status:		"See notice at end of class."
	author:		"Andreas Leitner"

deferred class
	XML_START_TAG_ABS
inherit
	XML_TAG
		rename
			make_from_c as make_from_c_xml_tag
		redefine
			out
		end
feature {NONE} -- Initialisation
	make_from_c (name_ptr, attribute_specifications_ptr: POINTER) is
		require
			name_ptr_not_void: name_ptr /= Void
			attribute_specifications_ptr_not_void: attribute_specifications_ptr /= Void
		do
			!! attributes.make
			make_from_c_xml_tag (name_ptr)
			make_attribute_specifications_from_c (attribute_specifications_ptr)
		ensure
			attributes_not_void: attributes /= Void
		end

feature

	attributes: XML_ATTRIBUTE_TABLE
		-- table of all attributes

	out: STRING is
		local
			cs: DS_LINEAR_CURSOR [XML_ATTRIBUTE]
		do
			!! Result.make (0)
			Result.append ("<")
			Result.append (name)

			from
				cs := attributes.new_cursor
				cs.start
			until
				cs.off
			loop
				Result.append (cs.item.out)
				cs.forth
			end

			Result.append (">")
		end

	element (a_parent: XML_ELEMENT): XML_ELEMENT is
			-- create a XML_ELEMENT with `a_parent' as
			-- parent element from this tag
		local
			cs: DS_LINEAR_CURSOR [XML_ATTRIBUTE]
		do
			!! Result.make (a_parent, name)
			Result.set_attributes (clone (attributes))
		end

feature {NONE} -- Implementation
	make_attribute_specifications_from_c (attr_spec_ptr: POINTER) is
			-- attribute_specifications_ptr is a zero terminated array of pointers.
			-- it points to pairs of name and value (each again zero terminated).
		require
			attr_spec_ptr_not_null: attr_spec_ptr /= default_pointer
			attributes_not_void: attributes /= Void
		deferred
		end

invariant
	attributes_not_void: attributes /= Void
end -- class XML_START_TAG_ABS
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner
 and others
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