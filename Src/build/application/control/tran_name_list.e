
class TRAN_NAME_LIST 

inherit

	SORTED_TWO_WAY_LIST [TRAN_NAME]

creation

	make
	
feature 

	has_label (cmd_label: STRING): BOOLEAN is
			-- Does cmd_label already exists ?
		do
			from
				start
			until
				after or else Result
			loop
				Result := cmd_label.is_equal (item.label_name);
				forth
			end;	
		end

end
