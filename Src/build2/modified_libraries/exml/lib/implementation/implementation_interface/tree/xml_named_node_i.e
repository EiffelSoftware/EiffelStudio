indexing
   description: "common anchestor for xml-nodes";
   status:			"See notice at end of class.";
   author:			"Andreas Leitner";

deferred class
   XML_NAMED_NODE_I

inherit
   XML_NODE_I
feature {ANY} -- Access

   name: UCSTRING is
	 -- name of node
      deferred
      end
   
   ns_prefix: UCSTRING is
      deferred
      end
   
   namespace: UCSTRING is
      deferred
      end
feature {ANY} -- Element Change
   
   set_name (n: UCSTRING) is
      require
	 n_not_void: n /= Void
      deferred
      end
   
   set_namespace (n: UCSTRING) is
      deferred
      end
   
   set_prefix (n: UCSTRING) is
      deferred
      end
   
invariant
   name_not_void: name /= Void
   
end -- XML_NAMED_NODE_I

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
