indexing
	description:"Objects representing a XML-attribute"
	status:		"See notice at end of class."
	author:		"Andreas Leitner"
class
	XML_ATTRIBUTE
inherit
	ANY
		redefine
			out
		end
creation
	make
feature {NONE} -- Initialisation
	make (a_name, a_value: STRING) is
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		do
			name := clone (a_name)
			value := clone (a_value)
		end

feature
	name: STRING
	value: STRING
--	specified: BOOLEAN
		-- not yet implemented


	out: STRING is
		do
			!! Result.make (0)
			Result.append (" ")
			Result.append (name)
			Result.append ("=%"")
			Result.append (value)
			Result.append ("%"")
		end

invariant
	name_not_void: name /= Void
	value_not_void: value /= Void
end -- class XML_ATTRIBUTE
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