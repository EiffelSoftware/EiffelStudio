indexing

	description: 
		"Undoable command for resizing a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class RESIZE_CLUSTER_U 

inherit

	GLUTTON_CLUSTER;
	TRANSLATE_MOVE
		undefine
			redo, undo, graphicals_update
		redefine
			move_figure, unmove_figure
		end
	ALIGN_GRID

creation

	make, make_with_figures

feature -- Initialization

	make (figure: CLUSTER_DATA; h: INTEGER; x, y: INTEGER) is
			-- Move a figure
		require
			valid_figure: figure /= Void
		do
			entity := figure;
			handle := h;
			relative_x := x;
			relative_y := y;
			old_x := entity.x;
			old_y := entity.y;
			old_width := entity.width;
			old_height := entity.height;
			old_tag_relative_x := entity.tag_relative_x;
			!! new_children.make;
			record;
			redo
		end;

	make_with_figures (figure: CLUSTER_DATA; h: INTEGER; x, y: INTEGER;
			figures: LINKED_LIST[LINKABLE_DATA]) is
			-- Move a figure
		require
			valid_figure: figure /= Void;
			valid_figures: figures /= Void and then not figures.empty
		local
			can_reparent_all_figures: BOOLEAN;
			class_data: CLASS_DATA;
			cluster_data: CLUSTER_DATA;
			tmp: STRING
		do
--			from
--				figures.start;
--				can_reparent_all_figures := true;
--			until
--				figures.after or else not can_reparent_all_figures
--			loop
--				class_data ?= figures.item;
--				if class_data /= Void then
--					can_reparent_all_figures := not figure.has_class (class_data.name)
--					if can_reparent_all_figures then
--						tmp := clone (class_data.file_name);
--						tmp.to_lower;
--						if not tmp.substring (tmp.count - 1, tmp.count).is_equal (".e") then
--							tmp.append (".e")
--						end;
--						can_reparent_all_figures := not (figure.has_child_with_file_name 
--									(class_data, tmp));
--						if not can_reparent_all_figures then
--							Windows.error (Windows.main_graph_window, Message_keys.reparent_figure_filename_er, Void);
--						end;
--					else
--						Windows.error (Windows.main_graph_window, Message_keys.reparent_figure_er, Void);
--					end
--				else
--					cluster_data ?= figures.item;
--					if cluster_data /= Void then
--						can_reparent_all_figures := not figure.has_cluster (cluster_data.name);
--						if can_reparent_all_figures then
--							can_reparent_all_figures := not (figure.has_child_with_file_name 
--										(cluster_data, cluster_data.file_name));
--							if not can_reparent_all_figures then
--								Windows.error (Windows.main_graph_window, Message_keys.reparent_figure_filename_er, Void);
--							end;
--						else
--							Windows.error (Windows.main_graph_window, Message_keys.reparent_figure_er, Void);
--						end;
--					end;
--				end;
--				figures.forth;
--			end
--			if can_reparent_all_figures then
--				entity := figure;
--				handle := h;
--				relative_x := x;
--				relative_y := y;
--				old_x := entity.x;
--				old_y := entity.y;
--				old_width := entity.width;
--				old_height := entity.height;
--				old_tag_relative_x := entity.tag_relative_x;
--				new_children := figures;
--				old_children_parent := figures.first.parent_cluster;
--				distance_x := entity.x;
--				distance_y := entity.y;
--				record;
--				redo
--			end;
		end; -- Make

feature -- Property

	name: STRING is "Resize cluster"

feature {NONE} -- Implementation properties

	handle: INTEGER;
			-- Handle used for resize

	old_x, old_y, old_width, old_height, old_tag_relative_x: INTEGER;
			-- values used to unmove the figure

feature {NONE} -- Implementation

	move_figure is
		local
			tag_width: INTEGER;
		do
			if handle = 1 then
				entity.set_x (align_grid (entity.x - relative_x));
				entity.set_y (align_grid (entity.y - relative_y))
			elseif handle = 2 then
				entity.set_y (align_grid (entity.y - relative_y))
			elseif handle = 3 then
				entity.set_x (align_grid (entity.x - relative_x))
			end;
			entity.set_width (align_grid (entity.x + entity.width + relative_x) - entity.x);
			entity.set_height (align_grid (entity.y + entity.height + relative_y) - entity.y);

			tag_width := resources.get_font("cluster_name_font").string_width (entity.name) 
						+ Resources.cluster_title_margin * 2;

			if entity.tag_relative_x + tag_width > entity.width then
				entity.set_tag_relative_x (entity.width - tag_width);
			end;
		end

	unmove_figure is
		do
			entity.set_x (old_x);
			entity.set_y (old_y);
			entity.set_width (old_width);
			entity.set_height (old_height);
			entity.set_tag_relative_x (old_tag_relative_x);
		end -- unmove_figure

end -- class RESIZE_CLUSTER_U
