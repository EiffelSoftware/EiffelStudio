indexing
	description: "objects allowing access to a flat set of nodes";
	status:			"See notice at end of class.";
	author:			"Andreas Leitner";

class
	XML_CHILD_NODES
inherit
	DS_BILINKED_LIST [XML_NODE]
		redefine
			out
		end
creation
	make
feature -- initialisation

feature -- misc access
	out: STRING is
		local
			cs: DS_LINEAR_CURSOR [XML_NODE]
		do

			!! Result.make (0)

			from
				cs := new_cursor
				cs.start
			until 
				cs.off
			loop
				Result.append (cs.item.out)
				cs.forth 
			end

		end
end -- XML_CHILD_NODES

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