-- Class_visibility        : /* empty */
--                         | Name
--                         | Name LEX_END
--                         | Name Creation_restriction Export_restriction External_rename LEX_END
--                         ;
-- 
-- Creation_restriction    : /* empty */
-- 
-- Creation_restriction    : /* empty */
--                         | LEX_CREATION Feature_name_list
--                         ;
-- 
-- Export_restriction        : /* empty */
--                         | LEX_EXPORT Feature_name_list
--                         ;
-- 
-- Feature_name_list        : Name_star
--                         | Feature_name_list LEX_COMMA Name_star
--                         ;
-- 
-- External_rename            : /* empty */
--                         | LEX_RENAME External_rename_list
--                         ;
-- 
-- External_rename_list    : ExternaL_rename_pair
--                         | External_rename_list LEX_COMMA ExternaL_rename_pair

class CLAS_VISI_SD

inherit

	AST_LACE
		redefine
			adapt
		end

feature -- Attributes

	class_name: ID_SD;

	visible_name: ID_SD;

	creation_restriction: LACE_LIST [ID_SD];

	export_restriction: LACE_LIST [ID_SD];

	renamings: LACE_LIST [TWO_NAME_SD];

feature -- Initialization

	set is
			-- Yacc initialization
		do
			class_name ?= yacc_arg (0);
			visible_name ?= yacc_arg (1);
			creation_restriction ?= yacc_arg (2);
			export_restriction ?= yacc_arg (3);
			renamings ?= yacc_arg (4)
		end;

	external_name: STRING is
			-- External name for the visible class
		do
			if visible_name = Void then
				Result := class_name;
			else
				Result := visible_name;
			end;
		end;

	adapt is
			-- Adapt external visibility of class
		require else
			class_name_exists: class_name /= Void;
		local
			cluster: CLUSTER_I;
			a_class: CLASS_I;
			level: VISIBLE_I;
			vd25: VD25;
			vd26: VD26;
		do
			cluster := context.current_cluster;
			a_class := cluster.classes.item (class_name);
			if a_class = Void then
				!!vd25;
				vd25.set_class_name (class_name);
				vd25.set_cluster (cluster);
				vd25.set_node (Current);
				Error_handler.insert_error (vd25);
			else
					-- First tset if there is no ambiguity for the 
					-- effective class name used for the external
					-- environment
				if Universe.is_ambiguous_name (external_name) then
					!!vd26;
					vd26.set_cluster (cluster);
					vd26.set_class_name (external_name);
					Error_handler.insert_error (vd26);
				end;
					
				level := visible_level;
				a_class.set_visible_level (visible_level);
				a_class.set_visible_name (visible_name);
			end;
		end;
		
	visible_level: VISIBLE_I is
			-- Visible level controler associated to current option
		local
			visi1: VISIBLE_EXPORT_I;
			visi2: VISIBLE_SELEC_I;
			table: SEARCH_TABLE [STRING];
			rename_table: HASH_TABLE [STRING, STRING];
			cuple: TWO_NAME_SD;
		do
			if export_restriction = Void then
				!!visi1;
				Result := visi1;
			else
				!!visi2;
				from
					!!table.make (export_restriction.count);
					export_restriction.start;
				until
					export_restriction.offright
				loop
					table.put (export_restriction.item);
					export_restriction.forth;
				end;
				visi2.set_visible_features (table);
				Result := visi2;
			end;
			if renamings /= Void then
				from
					renamings.start;
					!!rename_table.make (renamings.count);
				until
					renamings.offright
				loop
					cuple := renamings.item;
					rename_table.put (cuple.new_name, cuple.old_name);
					renamings.forth;
				end;
				Result.set_renamings (rename_table);
			end;
		ensure
			Result_exists: Result /= Void;
		end;
	
end
