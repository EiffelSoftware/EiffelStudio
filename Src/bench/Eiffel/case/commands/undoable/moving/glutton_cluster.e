indexing

	description: 
		"Abstract class for moving a cluster that%
		%has entities inside it.";
	date: "$Date$";
	revision: "$Revision $"

deferred class GLUTTON_CLUSTER

inherit
	
	MOVE
		redefine
			redo, undo
		end;
	CONSTANTS

feature -- Property

	entity: CLUSTER_DATA

feature -- Update

	redo is
			-- Re-execute command (after it was undone)
		do
			move_figure;
			workareas.change_data (entity);	
			move_children (-distance_x, -distance_y, entity);
			if is_recorded then
				graphicals_update
			end
		end; -- redo

	undo is
			-- Cancel effect of executing the command
		do
			move_children (distance_x, distance_y, old_children_parent);
			unmove_figure;
			workareas.change_data (entity);
			if is_recorded then
				graphicals_update
			end
		end -- undo

feature {NONE} -- Implementation

	new_children: LINKED_LIST [LINKABLE_DATA];
			-- new content of current glutton cluster

	old_children_parent: CLUSTER_DATA;
			-- old parent of 'new_children'

	distance_x: INTEGER;
			-- horizontal distance for revaluation
			-- relative x position of children

	distance_y: INTEGER;
			-- vertical distance for revaluation
			-- relative y position of children

	move_children (x, y: INTEGER; parent: CLUSTER_DATA) is
			-- move the children to their new parent
		require
			valid_parent: not new_children.empty implies
					parent /= Void
		local
			links: LINKED_LIST [RELATION_DATA];
			list: LINKED_LIST [HANDLE_DATA];
			handle: HANDLE_DATA;
			new_x, new_y: INTEGER
		do	
			!!links.make;
			from
				new_children.start
			until
				new_children.after
			loop
				links.append (new_children.item.extern_inherit_links);
				links.append (new_children.item.extern_client_links);
				new_x := new_children.item.x + x;
				new_y := new_children.item.y + y;
				if new_x < 0 then
						-- When resizing from top_left corner
						-- of cluster and drag left
					new_x := new_children.item.x - parent.x
				end;
				if new_y < 0 then
						-- When resizing from top_left corner
						-- of cluster and drag up
					new_y := new_children.item.y - parent.y
				end
				new_children.item.set_x (new_x);
				new_children.item.set_y (new_y);
				new_children.item.put_in_cluster (parent);
				workareas.change_data (new_children.item);
				new_children.forth
			end;
			from
				links.start
			until
				links.after
			loop
				if new_children.has (links.item.f_rom) and then 
					new_children.has (links.item.t_o)
				then
					from
						list := links.item.break_points;
						list.start
					until
						list.after
					loop
						handle := list.item;
						handle.set_x (links.item.break_points.item.x + x);
						handle.set_y (links.item.break_points.item.y + y);
						handle.put_in_cluster (parent);
						list.forth
					end;
					workareas.change_data (links.item)
				end;
				links.forth
			end

		end; -- move_children

	is_recorded: BOOLEAN is
		do
			Result := True
		end;

	graphicals_update is
		do
			--workareas.refresh_all;
			workareas.refresh;
		--	windows.system_window.update_page (Stone_types.class_type);
			System.set_is_modified
		end -- graphicals_update

invariant

	has_distance_x: distance_x /= Void;
	has_distance_y: distance_y /= Void

end -- class GLUTTON_CLUSTER
