indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class CLUST_REN_SD

inherit

	CLUST_ADAPT_SD
		redefine
			set, adapt
		end

feature {LACE_AST_FACTORY} -- Initialization

	initialize (cn: like cluster_name; r: like renamings) is
			-- Create a new CLUST_REN AST node.
		require
			cn_not_void: cn /= Void
		do
			cluster_name := cn
			cluster_name.to_lower
			renamings := r
		ensure
			cluster_name_set: cluster_name = cn
			renamings_set: renamings = r
		end

feature {NONE} -- Initialization 

	set is
			-- Yacc initialization
		do
			cluster_name ?= yacc_arg (0);
			cluster_name.to_lower;
			renamings ?= yacc_arg (1);
		ensure then
			cluster_name_exists: cluster_name /= Void;
		end;

feature -- Properties

	renamings: LACE_LIST [TWO_NAME_SD];
			-- Renaming list

feature {COMPILER_EXPORTER} -- Lace compilation

	adapt is
			-- Adapt current cluster
		local
			cluster, current_cluster: CLUSTER_I;
			renaming: TWO_NAME_SD;
			old_name, new_name: STRING;
			a_class: CLASS_I;
			vd04: VD04;
			vd46: VD46;
			vd47: VD47;
			vscn: VSCN;
			ok: BOOLEAN;
			renamed_classes: HASH_TABLE [STRING, STRING];
			classes: EXTEND_TABLE [CLASS_I, STRING]
		do

				-- Check first existence of cluster named `cluster_name'.
			ok := good_cluster;

			if ok and then renamings /= Void then
					-- Analyze renamings
				from
					cluster := Universe.cluster_of_name (cluster_name);
					current_cluster := context.current_cluster;
					!! renamed_classes.make (renamings.count);
					renamed_classes.compare_objects;
					renamings.start
				until
					renamings.after
				loop
					renaming := renamings.item;
					!! old_name.make (10);
					old_name.append (renaming.old_name);
					old_name.to_lower;
					!! new_name.make (10);
					new_name.append (renaming.new_name);
					new_name.to_lower;
						-- Check physical existence of class named `old_name'
						-- in cluster
					a_class := cluster.classes.item (old_name);
					if a_class = Void then
						!!vd04;
						vd04.set_old_name (renaming.old_name);
						vd04.set_cluster (cluster);
						Error_handler.insert_error (vd04);
					elseif renamed_classes.has_item (new_name) then
							-- `new_name' listed twice in the rename list.
						!!vd46;
						vd46.set_new_name (renaming.new_name);
						vd46.set_cluster (cluster);
						Error_handler.insert_error (vd46);
					elseif renamed_classes.has (old_name) then
							-- `old_name' listed twice in the rename list.
						!!vd47;
						vd47.set_old_name (renaming.old_name);
						vd47.set_cluster (cluster);
						Error_handler.insert_error (vd47);
					else
						renamed_classes.put (new_name, old_name);
						current_cluster.insert_renaming
												(cluster, old_name, new_name)
					end;

					renamings.forth
				end;
					-- Check for new name clashes in `cluster'.
				classes := cluster.classes;
				from
					renamed_classes.start
				until
					renamed_classes.after
				loop
					new_name := renamed_classes.item_for_iteration;
					if
						classes.has (new_name) and
						not renamed_classes.has (new_name)
					then
							-- Two classes with name `new_name'
							-- in cluster `cluster'.
						!!vscn;
						vscn.set_cluster (cluster);
						vscn.set_first (classes.found_item);
						vscn.set_second (classes.item (renamed_classes.key_for_iteration));
						Error_handler.insert_error (vscn)
					end;
					renamed_classes.forth
				end
			end
		end;

end -- class CLUST_REN_SD
