indexing

	description: 
		"View information for a compressed client supplier relationship.";
	date: "$Date$";
	revision: "$Revision $"

class COMP_CLI_SUP_VIEW

inherit

	CLI_SUP_VIEW
		rename
			update_data as old_update_data,
			make as client_make
		undefine
			copy, setup, is_equal	
		end
	CLI_SUP_VIEW
		rename
			make as client_make
		undefine
			copy, setup, is_equal	
		redefine
			update_data
		select
			update_data
		end;
	COMP_LINK_VIEW
		rename
			make as comp_make
		end
	
creation

	make

feature {NONE} -- Initialization

	make (comp_data: COMP_CLI_SUP_DATA) is
			-- Initialize Current with `comp_data'.
		do
			update_from (comp_data);
			comp_make (comp_data);
			if not comp_data.label.text.empty then
				set_label (comp_data.label.text)
			end
		end;

feature -- Properties

	data (link_data: LINKABLE_DATA): COMP_CLI_SUP_DATA is
			-- Data for supplier link_data 
		local
			link: LINKABLE_DATA
		do
			link := view_information.linkable_of_view_id (view_id);
			if link /= Void then
				!! Result.make_ref (link_data, link);
				update_data (Result)
			end;
		end;

	label: STRING is
			-- Label of link
		do
		end;

feature -- Setting

	update_data (comp_data: COMP_CLI_SUP_DATA) is
			-- Update Current from `comp_data'.
		local
			client_key: CLI_SUP_KEY;
			client, supplier: LINKABLE_DATA
		do
			if label /= Void then
				comp_data.set_label (label)
			end;
			old_update_data (comp_data);
			comp_update_data (comp_data);
			from
				start
			until
				after
			loop
				client := View_information.linkable_of_view_id
							(item.from_view_id);
				supplier := View_information.linkable_of_view_id
							(item.to_view_id);
				if client /= Void and then supplier /= Void then
					!! client_key.make (client, supplier);
					comp_data.finish;
					comp_data.put_right (client_key);
				end;
				forth
			end
		end;

	set_label (l: like label) is
			-- Set label to `l'.
		do
		end;

end -- class COMP_CLI_SUP_VIEW
