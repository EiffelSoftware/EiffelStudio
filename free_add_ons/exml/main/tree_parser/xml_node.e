indexing
	description: "common anchestor for xml-nodes";
	status:			"See notice at end of class.";
	author:			"Andreas Leitner";

deferred class
	XML_NODE
inherit
	XML_CHILD_NODES
		rename
			make as make_child_nodes
		end
feature
	make (a_parent: XML_ELEMENT) is
		do
			make_child_nodes
			parent := a_parent
		end
feature
	parent: XML_ELEMENT
			-- parent of this node. Only void
			-- if this node is the root node

	level: INTEGER is
			-- depth at which this node occures
			-- relative to it's root. The root
			-- has the level 1.
		do
			if
				is_root
			then
				Result := 1
			else
				Result := parent.level + 1 
			end
		end
feature -- properties
	is_root: BOOLEAN is
			-- is this node the root node
		do
			Result := parent = Void
		end

	root: XML_ELEMENT is
			-- the root element of the XML-document
			-- this node belongs to
		do
			if
				not is_root
			then
				Result := parent.root
			end
		end

	children_allowed: BOOLEAN is
			-- Does this type of node allow children?
			-- I.e. CHARACTER_DATA does not
		deferred
		end
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