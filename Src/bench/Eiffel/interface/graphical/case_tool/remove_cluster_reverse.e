indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class 
	REMOVE_CLUSTER_REVERSE

inherit
	CASE_COMMAND
creation
	make

feature	
	
	execute ( a : ANY ) is
	local
		ind : INTEGER
	do
		if scroll2.selected_item /= Void then
			scroll1.put_right(scroll2.selected_item)
			ind := scroll2.selected_position
			scroll2.go_i_th(ind)
		end 
	end

end -- class REMOVE_CLUSTER_REVERSE
