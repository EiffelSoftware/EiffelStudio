-- Root					: LEX_ROOT Name Cluster_mark Creation_procedure
--						 ;
-- Cluster_mark			: /* empty */
--						 | LEX_LEFT_PARAM Name LEX_RIGHT_PARAM
--						 ;
-- Creation_procedure		: /* empty */
--						 | LEX_COLUMN Name
--						 ;

class ROOT_SD

inherit

	AST_LACE
		redefine
			adapt
		end;
	SHARED_SERVER;
	SHARED_ERROR_HANDLER;
	STONABLE

feature -- Attributes

	root_name: ID_SD;
			-- Root class name

	cluster_mark: ID_SD;
			-- Cluster where the root class is

	creation_procedure_name: ID_SD;
			-- Creation procedure

	file_name: STRING;
			-- Updated by `adapt'

feature -- Initialization

	set is
			-- Yacc initialization
		do
			root_name ?= yacc_arg (0);
			cluster_mark ?= yacc_arg (1);
			creation_procedure_name ?= yacc_arg (2);
		ensure then
			root_name_exists: root_name /= Void;
			cluster_mark_exists: cluster_mark /= Void;
		end;

	adapt is
			-- Adapt system
		local
			cluster: CLUSTER_I;
			a_class: CLASS_I;
			vd19: VD19;
			vd20: VD20;
			root_class_name, creation_name: STRING;
			clusters: LINKED_LIST [CLUSTER_I];
			found: BOOLEAN;
			vd29: VD29;
			vd30: VD30;
		do
			root_class_name := root_name.duplicate;
			root_class_name.to_lower;

			if cluster_mark = Void then
				from
					clusters := Universe.clusters;
					clusters.start
				until
					clusters.after
				loop
					if clusters.item.classes.has (root_class_name) then
						if found then
							!!vd29;
							vd29.set_cluster (cluster);
							vd29.set_second_cluster_name (clusters.item.cluster_name);
							vd29.set_root_class_name (root_class_name);
							Error_handler.insert_error (vd29);
							Error_handler.checksum;
						else
							found := True;
							cluster := clusters.item;
						end;
					end;
					clusters.forth;
				end;
				if not found then
					!!vd30;
					vd30.set_root_class_name (root_class_name);
					Error_handler.insert_error (vd30);
					Error_handler.checksum;
				end;
			else
				cluster := Universe.cluster_of_name (cluster_mark);
			end;
			if cluster = Void then
				!!vd19;
				vd19.set_root_cluster_name (cluster_mark);
				Error_handler.insert_error (vd19);
			else
				System.set_root_cluster (cluster);
				a_class := cluster.classes.item (root_class_name);
				if a_class = Void then
					!!vd20;
					vd20.set_cluster (cluster);
					vd20.set_class_name (root_name);
					Error_handler.insert_error (vd20);
				else
					System.set_root_class_name (root_class_name);
					file_name := a_class.file_name;
					if creation_procedure_name /= Void then
						creation_name := creation_procedure_name.duplicate;
						creation_name.to_lower;
					end;
						-- Void string if no creation routine
					System.set_creation_name (creation_name);
				end;
			end;
				-- Check sum error
			Error_handler.checksum;
		end;
		
feature -- stoning
 
	stone (reference_class: CLASS_C): CLASSC_STONE is
		do
			!!Result.make (System.root_class.compiled_class)
		end

end
