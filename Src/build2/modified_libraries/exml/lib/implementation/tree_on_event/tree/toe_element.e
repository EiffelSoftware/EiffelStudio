indexing
   description: "objects representing a element";
   status:			"See notice at end of class.";
   author:			"Andreas Leitner";

class
   TOE_ELEMENT

inherit
   TOE_COMPOSITE
   XML_ELEMENT_I
      undefine
	 has,
	 is_equal,
	 copy,
	 occurrences
      end
   
   TOE_NAMED_NODE
      undefine
	 is_equal,
	 copy,
	 set_parent
      end

creation   
   make_root,
   make_child
   
feature {NONE} -- Implementation

   make_root (a_name, a_ns_prefix: UCSTRING) is
	 -- make a new root element based on the information held in a 
	 -- XML_START_TAG object. This will fill in the name and the attributes
      require
	 a_name_not_void: a_name /= Void
      do
	 internal_cursor := new_cursor	 
	 name := a_name
	 ns_prefix := a_ns_prefix
      ensure
	 name_set: equal (name, a_name)
      end
   
   make_child (a_parent: XML_COMPOSITE; a_name, a_ns_prefix: UCSTRING) is
	 -- make a new child element based on the information held in a 
	 -- XML_START_TAG object. This will fill in the name and the attributes
      require
	 a_parent_not_void: a_parent /= Void
	 a_name_not_void: a_name /= Void
      do
	 make_root (a_name, a_ns_prefix)
	 parent := a_parent
      ensure
	 name_set: equal (name, a_name)
      end


feature {ANY} -- Access

feature {ANY} -- Element Change
   
   add_attributes (a_attributes: DS_BILINEAR [DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]]; a_parent: XML_ELEMENT) is
      local
	 cs: DS_BILINEAR_CURSOR [DS_PAIR[DS_PAIR [UCSTRING, UCSTRING], UCSTRING]]
	 toe: TOE_ATTRIBUTE
	 xml: XML_ATTRIBUTE
      do
	 from
	    cs:= a_attributes.new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    !! toe.make (cs.item.first.first, cs.item.first.second, cs.item.second, a_parent)
	    !! xml.make_from_imp (toe)
	    force_last (xml)
	    cs.forth
	 end
      end
   

end -- TOE_ELEMENT

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
