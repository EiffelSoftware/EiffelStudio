indexing
   description: "common anchestor for xml-nodes";
   status:			"See notice at end of class.";
   author:			"Andreas Leitner";

deferred class
   XML_NODE
inherit
   INTERFACE
      redefine
	 implementation
      end

feature {ANY} -- Access

   parent: XML_COMPOSITE is
	 -- parent of this node. Only void
	 -- if this node is the root node
      do
	 Result := implementation.parent
      end

   root_node: XML_COMPOSITE is
	 -- the root node of this node. In most cases this will be of
	 -- type XML_DOCUMENT
      do
	 if
	    not is_root_node
	 then
	    Result := parent.root_node
	 end
      end

   level: INTEGER is
	 -- depth at which this node occures
	 -- relative to it's root. The root node
	 -- has the level 1.
      do
	 if
	    is_root_node
	  then
	    Result := 1
	 else
	    Result := parent.level + 1
	 end
      end
feature {ANY} -- Status Report

   is_root_node: BOOLEAN is
	 -- is this node the root node
      do
	 Result := parent = Void
      end

feature {ANY} -- Basic Routines

   process (x: XML_NODE_PROCESSOR) is
      require
	 x_not_void: x /= Void
      deferred
      end

feature {ANY} -- Element change

   set_parent (a_parent: XML_COMPOSITE) is
	 -- make `a_parent' the new parent of this node.
      require
	 a_parent_not_void: a_parent /= Void
      do
	 implementation.set_parent (a_parent)
      ensure
	 parent_set: parent = a_parent
      end

feature {NONE} -- Implementation

   implementation: XML_NODE_I
end -- XML_NODE

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
