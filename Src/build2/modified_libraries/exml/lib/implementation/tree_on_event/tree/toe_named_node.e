indexing
   description: "common anchestor for xml-nodes";
   status:			"See notice at end of class.";
   author:			"Andreas Leitner";

class
   TOE_NAMED_NODE
inherit
   XML_NODE_I
   TOE_NODE

feature {ANY} -- Access

   name: UCSTRING
   ns_prefix: UCSTRING
   namespace: UCSTRING
   
feature {ANY} -- Element change

   set_name (n: UCSTRING) is
      do
	 name := n
      end
   
   set_namespace (n: UCSTRING) is
      do
	 namespace := n
      end
   
   set_prefix (n: UCSTRING) is
      do
	 ns_prefix := n
      end
end -- TOE_NAMED_NODE

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
