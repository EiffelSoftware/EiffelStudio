indexing

	description: 
		"Undoable command to change the parent of the figure%
		%after moving.";
	date: "$Date$";
	revision: "$Revision $"

class REPARENT_FIGURE_U 

inherit

	REPARENT_U
		rename
			redo as old_redo,
			undo as old_undo
		end;

creation

	make

feature -- Initialization

	make (figure: like entity; cluster: CLUSTER_DATA; x, y : like new_x) is
			-- Reparent a 'figure'
		require
			has_figure: figure /= Void
		local
			can_move_figure: BOOLEAN;
			class_data: CLASS_DATA;
			cluster_data: CLUSTER_DATA;
			tmp: STRING
		do
			class_data ?= figure;
			if class_data /= Void then
				can_move_figure := class_data.parent_cluster = cluster or else
					not cluster.has_class (class_data.name)
				if can_move_figure then
					tmp := clone (class_data.file_name);
					tmp.to_lower;
					can_move_figure := not (cluster.has_child_with_file_name 
								(class_data, tmp));
					if not can_move_figure then
						--Windows.error (Windows.main_graph_window, 
						--	Message_keys.reparent_figure_filename_er, Void);
					end;
				else
					--Windows.error (Windows.main_graph_window, Message_keys.reparent_figure_er, Void);
				end
			else
				cluster_data ?= figure;
				if cluster_data /= Void then
					can_move_figure := cluster_data.parent_cluster = cluster or else 
										not cluster.has_cluster (cluster_data.name)
					if can_move_figure then
						can_move_figure := not 
							(cluster.has_child_with_file_name 
									(cluster_data, cluster_data.file_name))
						if not can_move_figure then
							--Windows.error (Windows.main_graph_window, 
							--		Message_keys.reparent_figure_filename_er, Void);
						end
					else
						--Windows.error (Windows.main_graph_window, 
						--			Message_keys.reparent_figure_er, Void);
					end
				end
			end;
			if can_move_figure then
				record
				entity := figure
				new_x := x
				new_y := y
				new_parent := cluster
				old_x := figure.x
				old_y := figure.y
				old_parent := figure.parent_cluster
				redo
			end
		ensure
			figure_correctly_set: entity = figure
		end 

feature -- Update

	undo is
		do
			old_undo;
			update;
		end;

	redo is
		do
			old_redo;
			update;
		end;

	update is
		local
	--		c_l: EDITOR_LIST [EC_CLASS_WINDOW];
			class_data: CLASS_DATA;
		do
--			class_data ?= entity;
--			if class_data /= Void then
--				c_l := Windows.class_windows;
--				from
--					c_l.start
--				until
--					c_l.after
--				loop
--					if c_l.item.entity = class_data then
--						c_l.item.update_page (class_data.stone_type);
--					end;
--					c_l.forth;
--				end;
--			end;
		end;

feature -- Property

	name: STRING is "Reparent figure"

end -- class REPARENT_FIGURE_U
