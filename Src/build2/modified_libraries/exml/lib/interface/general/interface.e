indexing
   description:""
   status:		"See notice at end of class."
   author:		"Andreas Leitner"
class
   INTERFACE

feature {NONE} -- Initialisation

   make_from_imp (a_imp: like implementation) is
	 -- creates a new tag from from `a_imp'
      require
	 a_imp_not_void: a_imp /= Void
      do
	 implementation := a_imp
      end

feature {NONE} -- Implementation

   implementation: IMPLEMENTATION
	 -- Referenc to the implementation.
	 -- To be as portable as possible the visitor pattern is
	 -- used. The visitor pattern is described in the book
	 -- "Design Patterns" published by "Prentice Hall" (ISBN 0-201-63361-2)

end -- class INTERFACE
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