indexing

	description: 
		"Command to create a cluster in the workarea.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_MAKE_CLUSTER_COM

inherit

	WORKAREA_MAKE_COM
	TRANSLATION_ID

creation

	make

feature {NONE} -- Implementaion

	cluster_name: STRING is
			-- New default cluster name
		local
			tmp: STRING
		do
			from 
			until
				Result /= Void
			loop
				!! tmp.make (10);
				tmp.append ("CLUSTER_");
					-- To get positive value
				tmp.append_integer (system.cluster_view_number.hash_code);
				system.decrement_cluster_view_number;
				if not system.has_cluster (tmp) then
					Result := tmp;
				end;
			end;
		end

	make_entity (cluster_parent: CLUSTER_DATA; x_coord, y_coord: INTEGER) is
			-- Make cluster with parent `cluster_parent' at coordinates
			-- `x_coord' and `y_coord'.
		local
			new_cluster: CLUSTER_DATA;
			new_cluster_u: ADD_CLUSTER_U;
			new_glutton_cluster : ADD_GLUTTON_CLUSTER_U;
			a_new_content : LINKED_LIST[LINKABLE_DATA]
		do
			a_new_content := cluster_parent.new_content_area (x_coord, y_coord,
				Resources.cluster_width, Resources.cluster_height, Void);

			if a_new_content /= Void then
				!! new_cluster.make (cluster_name, system.cluster_view_number);
				--!! new_cluster.make ( cluster_name, from_string_to_id ( cluster_name ) )
				new_cluster.set_x (x_coord);
				new_cluster.set_y (y_coord);
				new_cluster.set_default;
				new_cluster.set_icon (False);

				if a_new_content.empty then
					!! new_cluster_u.make (cluster_parent, new_cluster, workarea)
				else
					!! new_glutton_cluster.make (cluster_parent, new_cluster, a_new_content)
				end;

				-- directly name the new class
		--		Windows.namer_window.set_new_entity
		--		Windows.namer_window.popup_at_current_position (new_cluster.stone)
			else
		--		windows.error (workarea.analysis_window, Message_keys.create_cluster_er, Void)
			end
		end

end -- class WORKAREA_MAKE_CLUSTER_COM
