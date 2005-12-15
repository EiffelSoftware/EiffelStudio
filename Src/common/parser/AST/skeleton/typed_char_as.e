indexing
	description: "Objects that represent a typed char ast node"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPED_CHAR_AS

inherit
	CHAR_AS
		rename
			initialize as char_initialize
		redefine
			process
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t_as: TYPE_AS; c: CHARACTER; l, co, p, n: INTEGER) is
			-- Create a new CHARACTER AST node.
		require
			l_non_negative: l >= 0
			co_non_negative: co >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			value := c
			set_position (l, co, p, n)
			type := t_as
		ensure
			value_set: value = c
			type_set: type = t_as
		end

feature -- Roundtrip

	type: TYPE_AS
		-- Type associated with this node.

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Process this node.
		do
			v.process_typed_char_as (Current)
		end



end
