indexing
	description: "Action sequence for node actions."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_NODE_ACTION

inherit
	EV_ACTION_SEQUENCE [TUPLE [EG_NODE]]
	-- EV_ACTION_SEQUENCE [TUPLE [a_node: EG_NODE]]
	-- (ETL3 TUPLE with named parameters)
	
create
	default_create
	
create {EG_NODE_ACTION}
	make_filled

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (agent wrapper (?, action))
		end

	wrapper (a_node: EG_NODE; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_node])
		end
		
	new_filled_list (n: INTEGER): like Current is
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end
		
end -- class EG_NODE_ACTION

--|----------------------------------------------------------------
--| EiffelGraph: library of graph components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

