indexing
	description: "Transition name list."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class TRAN_NAME_LIST 

inherit
	SORTED_TWO_WAY_LIST [TRAN_NAME]

creation

	make
	
feature 

	has_label (cmd_label: CMD_LABEL): BOOLEAN is
			-- Does cmd_label already exists ?
		do
			from
				start
			until
				after or else Result
			loop
				Result := cmd_label.is_equal (item.cmd_label)
				forth
			end	
		end

end -- class TRAN_NAME_LIST

