indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class ROOT_SD

inherit

	AST_LACE
		redefine
			adapt
		end;
	SHARED_SERVER;
	SHARED_ERROR_HANDLER;
	CLICKABLE_AST
		redefine
			associated_eiffel_class,
			valid_reference_class, is_class
		end

feature {NONE} -- Initialization 

	set is
			-- Yacc initialization
		do
			root_name ?= yacc_arg (0);
			root_name.to_lower;
			cluster_mark ?= yacc_arg (1);
			if cluster_mark /= Void then
				cluster_mark.to_lower;
			end;
			creation_procedure_name ?= yacc_arg (2);
			if creation_procedure_name /= Void then
				creation_procedure_name.to_lower;
			end;
		end;

feature -- Properties

	root_name: ID_SD;
			-- Root class name

	cluster_mark: ID_SD;
			-- Cluster where the root class is

	creation_procedure_name: ID_SD;
			-- Creation procedure

	file_name: STRING;
			-- Updated by `adapt'

feature -- Access

	is_class: BOOLEAN is True

	valid_reference_class (reference_class: CLASS_C): BOOLEAN is
		do
			Result := True
		end;

	associated_eiffel_class (reference_class: CLASS_C): CLASS_C is
		do
			Result := System.root_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	compile_all_classes: BOOLEAN is
			-- Is the root class NONE, i.e. all the classes must be
			-- compiled
		do
			Result := none_sd.is_equal (root_name)
		end;

	adapt is
			-- Adapt system
		local
			cluster: CLUSTER_I;
			a_class: CLASS_I;
			vd19: VD19;
			vd20: VD20;
			clusters: LINKED_LIST [CLUSTER_I];
			found: BOOLEAN;
			vd29: VD29;
			vd30: VD30;
			id_sd: ID_SD;
			compile_all: BOOLEAN;
		do
			if compile_all_classes then
				compile_all := True;
				root_name := any_sd;
			end;
			if cluster_mark = Void then
				from
					clusters := Universe.clusters;
					clusters.start
				until
					clusters.after
				loop
					if clusters.item.classes.has (root_name) then
						if found then
							!!vd29;
							vd29.set_cluster (cluster);
							vd29.set_second_cluster_name (clusters.item.cluster_name);
							vd29.set_root_class_name (root_name);
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
					vd30.set_root_class_name (root_name);
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
				a_class := cluster.classes.item (root_name);
				if a_class = Void then
					!!vd20;
					vd20.set_cluster (cluster);
					vd20.set_class_name (root_name);
					Error_handler.insert_error (vd20);
				else
					System.set_root_class_name (root_name);
					file_name := a_class.file_name;
						-- Void string if no creation routine
					System.set_creation_name (creation_procedure_name);
				end;
			end;
				-- Check sum error
			Error_handler.checksum;

				-- Reset `root_name'
			if compile_all then
				root_name := none_sd;
			end;
		end;

feature {NONE}

	any_sd: ID_SD is
		once
			!!Result.make (3);
			Result.append ("any")
		end;

	none_sd: ID_SD is
		once
			!!Result.make (4);
			Result.append ("none")
		end;

end -- class ROOT_SD
