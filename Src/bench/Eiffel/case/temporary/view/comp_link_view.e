indexing

	description: 
		"Abstract view information for a compressed relationships.";
	date: "$Date$";
	revision: "$Revision $"

deferred class COMP_LINK_VIEW

inherit

	RELATION_VIEW
		rename
			make as relation_make
		undefine
			copy, setup, update_data, is_equal
		end;
	ARRAYED_LIST [RELATION_VIEW_KEY]
		rename
			make as list_make
		end

feature {NONE} -- Initialization

	make (comp_data: COMP_LINK_DATA [RELATION_DATA_KEY]) is
			-- Make Current with `comp_data'.
		local
			rel_view: RELATION_VIEW_KEY;
		do
			relation_make (comp_data);
			list_make (comp_data.count);
			from
				comp_data.start	
			until
				comp_data.after	
			loop
				!! rel_view.make (comp_data.item);
				extend (rel_view);
				comp_data.forth	
			end
		end;

	comp_update_data (comp_link: COMP_LINK_DATA [RELATION_DATA_KEY]) is
			-- Update Current link with `comp_link'.
		do
			-- Do nothing
		end;

end -- COMP_LINK_VIEW
