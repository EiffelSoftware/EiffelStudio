indexing
   description:""
   status:		"See notice at end of class."
   author:		"Andreas Leitner"
class
   BIDIRECTIONAL_IMPLEMENTATION
inherit
   IMPLEMENTATION
feature {BIDIRECTIONAL_INTERFACE} -- Initialisation
   set_interface (a_interface: like interface) is
      require
	 a_interface_not_void: a_interface /= Void
      do
	 interface := a_interface
      end

feature {NONE} -- Implementation
   interface: BIDIRECTIONAL_INTERFACE

end -- class BIDIRECTIONAL_IMPLEMENTATION
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