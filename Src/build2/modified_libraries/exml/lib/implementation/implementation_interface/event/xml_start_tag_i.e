indexing
   description:"Objects representig a XML-start tag"
   status:		"See notice at end of class."
   author:		"Andreas Leitner"

deferred class
   XML_START_TAG_I

inherit
   XML_TAG_I

feature

   attributes: XML_ATTRIBUTE_TABLE is
	 -- table of all attributes
      deferred
      end

invariant
   attributes_not_void: attributes /= Void
end -- class XML_START_TAG_I

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
