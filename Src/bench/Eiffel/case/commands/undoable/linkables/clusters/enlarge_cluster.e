indexing

	description: 
		"Undoable command to ensure the moved cluster has%
		%area to move to.";
	date: "$Date$";
	revision: "$Revision $"

class ENLARGE_CLUSTER

inherit

	GLUTTON_CLUSTER
		redefine
			redo, undo
		end;

creation

	make

feature {NONE} -- Initialization

	make (a_cluster: CLUSTER_DATA; 	
				extra_height: INTEGER; extra_width: INTEGER) is
		require
			valid_cluster: a_cluster /= Void;
			non_negative_extra_h: extra_height >= 0
			non_negative_extra_w: extra_width >= 0
		local
			a_new_content: LINKED_LIST [LINKABLE_DATA];
			child_y, x, y, width, height: INTEGER;
			extra_w, extra_h: INTEGER;
			min_y: INTEGER
		do
			entity := a_cluster;
			x := entity.x;
			y := entity.y;
			old_width := entity.width;
			old_height := entity.height;
			new_width := extra_width + old_width ;
			new_height := old_height + extra_height;
			if not entity.is_root and then not entity.is_icon and then
				not entity.parent_cluster.is_area_legal_for (
						x, y, new_width, new_height,
						entity)
			then
				new_children :=
						entity.parent_cluster.all_entities_in_area (
						x, y, entity.parent_cluster.width - x,
						entity.parent_cluster.height -y,  
						entity);
				if not new_children.empty then
					min_y := entity.y + new_height
				end;
				from
					new_children.start
				until
					new_children.after
				loop
					child_y :=  new_children.item.y;
					if child_y < min_y then
						min_y := new_children.item.y;
					end;
					new_children.forth
				end;
				if min_y /= 0 then
						-- Add 30 so that the class or cluster title
						-- can clear the cluster.
					distance_y := (new_height + entity.y) - min_y + 30;
				end;
				-- pascalf ... system's stability ...
				if entity.parent_cluster /= Void then
					extra_w := entity.x + new_width -
						entity.parent_cluster.width + 50 ;  -- 50 did not exist before
					if distance_y = 0 then
						extra_h := entity.y + new_height -
						entity.parent_cluster.height + 50; -- 50 did not exizst before
					else	
						extra_h := distance_y +50 -- 50 didn't exist before
					end;
					if extra_h > 0 or else extra_w > 0 then
						if extra_h < 0 then
							extra_h := 0
						elseif extra_w < 0 then
							extra_w := 0
						end;
						!! enlarge_cluster.make
							(entity.parent_cluster, 
							extra_h, extra_w)
					end
				end;
			else
				!! new_children.make;
			end;
		end;

feature -- Property

	name: STRING is "Enlarge cluster"

feature -- Update

	move_figure is
		do
			if new_height /= old_height or else
				new_width /= old_width
			then
				entity.set_height (new_height)
				entity.set_width (new_width)
				workareas.change_data (entity)
			end;
		end

	unmove_figure is
		do
			if new_height /= old_height or else
				new_width /= old_width
			then
				entity.set_height (old_height)
				entity.set_width (old_width)
				workareas.change_data (entity)
			end
		end

	redo is
			-- Re-execute command (after it was undone)
		do
			move_figure
			move_children (distance_x, distance_y, entity.parent_cluster)
			if enlarge_cluster /= Void then
				enlarge_cluster.redo
			end
		end

	undo is
			-- Cancel effect of executing the command
		do
			move_children (-distance_x, -distance_y, entity.parent_cluster)
			unmove_figure
			if enlarge_cluster /= Void then
				enlarge_cluster.undo
			end
		end

feature {NONE} -- Implementation

	old_height, new_height: INTEGER
		-- Old/New height for entity

	old_width, new_width: INTEGER
		-- Old/New height for entity

	enlarge_cluster: ENLARGE_CLUSTER

end 
