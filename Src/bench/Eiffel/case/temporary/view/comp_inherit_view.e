indexing

	description: 
		"View information for a compressed inheritance relationship.";
	date: "$Date$";
	revision: "$Revision $"

class COMP_INHERIT_VIEW

inherit

	INHERIT_VIEW
		rename
			make as inherit_make,
			update_data as old_update_data
		undefine
			copy, setup,is_equal	
		end;
	INHERIT_VIEW
		rename
			make as inherit_make
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

	make (comp_data: COMP_INHERIT_DATA) is
			-- Initialize Current with `comp_data'.
		do
			update_from (comp_data);
			comp_make (comp_data);
		end;

feature -- Properties

	data (link_data: LINKABLE_DATA): COMP_INHERIT_DATA is
			-- Data associated with supplier `link_data'
		local
			link: LINKABLE_DATA
		do
			link := View_information.linkable_of_view_id (view_id);
			if link /= Void then
				!! Result.make (link_data, link);
				update_data (Result)
			end
		end;

feature -- Setting

	update_data (comp_data: COMP_INHERIT_DATA) is
			-- Update Current from `comp_data'.
		local
			inherit_key: INHERIT_KEY;
			heir, parent: LINKABLE_DATA
		do
			old_update_data (comp_data);
			comp_update_data (comp_data);
			from
				start
			until
				after
			loop
				heir := View_information.linkable_of_view_id 
							(item.from_view_id);
				parent := View_information.linkable_of_view_id 
							(item.to_view_id);
				if heir /= Void and then parent /= Void then
					!! inherit_key.make (heir, parent);
					comp_data.finish;
					comp_data.put_right (inherit_key);
				end;
				forth
			end
		end;

end -- COMP_INHERIT_VIEW
