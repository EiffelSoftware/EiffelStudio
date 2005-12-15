indexing
	description: "AST representation of a non-deferred routine.";
	date: "$Date$";
	revision: "$Revision$"

class DO_AS

inherit
	INTERNAL_AS
		redefine
			process
		end

create
	make

feature{NONE} -- Initialization

	make (c: like compound; l_as: KEYWORD_AS) is
			-- Create new DO AST node.
		do
			initialize (c)
			do_keyword := l_as
		ensure
			do_keyword_set: do_keyword = l_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_do_as (Current)
		end

feature -- Roundtrip

	do_keyword: KEYWORD_AS
			-- Keyword "do" associated with this structure

end -- class DO_AS
