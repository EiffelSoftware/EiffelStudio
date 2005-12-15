indexing
	description: "AST representation of a once routines."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_AS

inherit
	INTERNAL_AS
		redefine
			process, is_once
		end

create
	make

feature{NONE} -- Initialization

	make (c: like compound; l_as: KEYWORD_AS) is
			-- Create new DO AST node.
		do
			initialize (c)
			once_keyword := l_as
		ensure
			once_keyword_set: once_keyword = l_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_once_as (Current)
		end

feature -- Roundtrip

	once_keyword: KEYWORD_AS
			-- Keyword "once" associated with this structure

feature -- Properties

	is_once: BOOLEAN is True
			-- Is the current routine body a once one ?

end -- class ONCE_AS
