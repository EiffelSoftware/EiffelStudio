indexing
	description: "node that has a name";
	status:			"See notice at end of class.";
	author:			"Andreas Leitner";

deferred class
	XML_NAMED_NODE
inherit
	XML_NODE
feature
	name: STRING
			-- name of the node
			-- `name' may have a different semantic in different descentants
invariant
	name_not_void: name /= Void
end -- XML_NAMED_NODE

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