indexing
	description: "Abstract description of an Eiffel routine object in agent form"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AGENT_ROUTINE_CREATION_AS

inherit
	ROUTINE_CREATION_AS
		redefine
			process
		end

create
	make

feature{NONE} -- Initialization

	make (t: like target; f: like feature_name; o: like operands; ht: BOOLEAN; a_as: like agent_keyword; d_as: like dot_symbol) is
			-- Create a new ROUTINE_CREATION AST node.
			-- When `t' is Void it means it is a question mark.
		do
			initialize (t, f, o, ht)
			agent_keyword := a_as
			dot_symbol := d_as
		ensure
			agent_keyword_set: agent_keyword = a_as
			dot_symbol_set: dot_symbol = d_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_agent_routine_creation_as (Current)
		end

feature -- Roundtrip

	agent_keyword: KEYWORD_AS
			-- Keyword "agent" associated with this structure

	dot_symbol: SYMBOL_AS
			-- Symbol "." associated with this structure

end
