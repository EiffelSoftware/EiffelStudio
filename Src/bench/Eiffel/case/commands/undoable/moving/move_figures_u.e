indexing

	description: 
		"Specify undoable actions to move (translate or reparent)%
		%figures (movables_list)";
	date: "$Date$";
	revision: "$Revision $"

class MOVE_FIGURES_U

inherit

	MULTIPLE_MOVE_U

creation

	make

feature -- Initialization

	make (list : like movables_list;
		hierarchy_changed : like must_update_system_comp) is
			-- Move a list of figures
		require
			has_list : list /= Void;
			list_not_empty : not list.empty
		local
			can_do_all: BOOLEAN;
			class_data: CLASS_DATA;
			cluster_data: CLUSTER_DATA;
			rep: REPARENT_MOVABLE_U;
			tmp: STRING
		do
--			from
--				list.start;
--				can_do_all := true;
--			until
--				list.after or else not can_do_all
--			loop
--				rep ?= list.item;
--				if rep /= Void then
--					class_data ?= rep.entity;
--					if class_data /= Void then
--						can_do_all := not rep.new_parent.has_class (class_data.name)
--						if can_do_all then
--							tmp := clone (class_data.file_name);
--							tmp.to_lower;
--							if not tmp.substring (tmp.count - 1, tmp.count).is_equal (".e") then
--								tmp.append (".e")
--							end;
--							can_do_all := not (rep.new_parent.has_child_with_file_name (class_data, tmp));
--							if not can_do_all then
--								Windows.error (Windows.main_graph_window, Message_keys.reparent_figure_filename_er, Void);
--							end
--						else
--							Windows.error (Windows.main_graph_window, Message_keys.reparent_figure_er, Void);
--						end
--					else
--						cluster_data ?= rep.entity;
--						if cluster_data /= Void then
--							can_do_all := not rep.new_parent.has_cluster (cluster_data.name)
--							if can_do_all then
--								can_do_all := not (rep.new_parent.has_child_with_file_name 
--											(cluster_data, cluster_data.file_name));
--								if not can_do_all then
--									Windows.error (Windows.main_graph_window, Message_keys.reparent_figure_filename_er, Void);
--								end;
--							else
--								Windows.error (Windows.main_graph_window, Message_keys.reparent_figure_er, Void);
--							end;
--						end;
--					end
--				end
--				list.forth;
--			end;
--			if can_do_all then
--				record;
--				movables_list := list;
--				must_update_system_comp := hierarchy_changed;
--				redo
--			end;
--		ensure
--			list_correctly_set : movables_list = list
		end -- make

feature -- Property

	name: STRING is "Move figures"

end -- class MOVE_FIGURES_U
