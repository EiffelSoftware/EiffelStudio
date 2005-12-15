indexing
	description: "Abstract description of an Eiffel routine object in tilda form"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TILDA_ROUTINE_CREATION_AS

inherit
	ROUTINE_CREATION_AS
		redefine
			process
		end

create
	make

feature{NONE} -- Initialization

	make (t: like target; f: like feature_name; o: like operands; ht: BOOLEAN; t_as: like tilda_symbol) is
			-- Create a new ROUTINE_CREATION AST node.
			-- When `t' is Void it means it is a question mark.
		do
			initialize (t, f, o, ht)
			tilda_symbol := t_as
		ensure
			tilda_symbol_set: tilda_symbol = t_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_tilda_routine_creation_as (Current)
		end

feature -- Roundtrip

	tilda_symbol: SYMBOL_AS
			-- Symbol "~" or "}~" associated with this structure

end
