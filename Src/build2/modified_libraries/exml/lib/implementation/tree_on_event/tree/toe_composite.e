indexing
   description: "xml nodes that may hold other child nodes";
   status:	"see notice at end of class.";
   author:	"Andreas Leitner";

deferred class
   TOE_COMPOSITE

inherit
   XML_COMPOSITE_I
      undefine
	 occurrences,
	 has,
	 is_equal,
	 copy
      end
   
   DS_LINKED_LIST [XML_NODE]
   
   TOE_NODE
      undefine
	 copy,
	 is_equal
      end

feature {ANY} -- Access
   
--   parent: XML_COMPOSITE
	 -- parent of this node. Only void
	 -- if this node is the root node
   
feature {ANY} -- Element change

--   set_parent (a_parent: XML_COMPOSITE) is
	 -- make `a_parent' the new parent of this node.
--      do
--	 parent := a_parent
--      end
   
end -- TOE_COMPOSITE

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
