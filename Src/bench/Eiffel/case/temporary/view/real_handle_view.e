indexing

	description: 
		"Describes actual handle information for a given view.";
	date: "$Date$";
	revision: "$Revision $"

class REAL_HANDLE_VIEW

inherit

	ONCES;
	HANDLE_VIEW;
	COORD_XY_VIEW
		rename
			update_data as coord_xy_view
		end;
	COORD_XY_VIEW
		redefine
			update_data 
		select
			update_data
		end;

creation

	make

feature {NONE} -- Initialization
	
	make (handle_data: HANDLE_DATA) is
			-- Make Current View from `handle_data'.
		do
			update_from (handle_data);
			if handle_data.parent_cluster/= Void then
				parent_view_id := handle_data.parent_cluster.view_id;
			else
				-- it comes from the reverse ...
				handle_data.set_parent_cluster ( handle_data.from_link.parent_cluster)
			end
		end;

feature -- Properties

	parent_view_id: INTEGER;
			-- View id of parent

	data: HANDLE_DATA is
			-- Data associated with Current
		do
			!! Result;
			update_data (Result);
		end;

feature -- Setting

	update_data (handle_data: HANDLE_DATA) is
			-- Update `handle_data' from Current.
		do
			coord_xy_view (handle_data)		 
			handle_data.set_parent_cluster (
					View_information.cluster_of_view_id (parent_view_id))
		end;

end -- class REAL_HANDLE_VIEW
