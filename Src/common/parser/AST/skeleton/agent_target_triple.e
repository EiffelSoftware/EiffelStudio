indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AGENT_TARGET_TRIPLE

create
	make

feature{NONE} -- Initialization

	make (l_as: like lparan_symbol; r_as: like rparan_symbol; o_as: like operand) is
			-- Create new ALIAS_TRIPLE sturcture.
		do
			lparan_symbol := l_as
			rparan_symbol := r_as
			operand := o_as
		ensure
			lparan_symbol_set: lparan_symbol = l_as
			rparan_symbol_set: rparan_symbol = r_as
			operand_set: operand = o_as

		end

feature -- Access

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Left and right paran symbol

	operand: OPERAND_AS

end
