indexing
	description: "Representation of a root class specification"
	date: "$Date$"
	revision: "$Revision$"

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

create
	initialize

feature {NONE} -- Initialization

	initialize (rn: like root_name; cm: like cluster_mark;
		cp: like creation_procedure_name) is
			-- Create a new ROOT AST node.
		require
			rn_not_void: rn /= Void
		do
				-- Class names are stored in upper, thus the conversion to upper cases.
			root_name := rn
			root_name.to_upper
			cluster_mark := cm
			if cluster_mark /= Void then
				cluster_mark.to_lower
			end
			creation_procedure_name := cp
			if creation_procedure_name /= Void then
				creation_procedure_name.to_lower
			end
		ensure
			root_name_set: root_name.is_equal (rn.as_upper)
			cluster_mark_set: cluster_mark = cm
			creation_procedure_name_set: creation_procedure_name = cp
		end

feature -- Properties

	root_name: ID_SD;
			-- Root class name

	cluster_mark: ID_SD;
			-- Cluster where the root class is
			-- Can be Void

	creation_procedure_name: ID_SD;
			-- Creation procedure

	file_name: STRING;
			-- Updated by `adapt'

feature -- Setting

	set_root_name (rn: like root_name) is
			-- Set `root_name' with `rn'.
		require	
			rn_not_void: rn /= Void
		do
			root_name := rn
		ensure
			root_name_set: root_name = rn
		end

	set_creation_procedure_name (cp: like creation_procedure_name) is
			-- Set `creation_procedure_name' with lower case version
			-- of `cp'.
		do
			if cp /= Void then
				cp.to_lower
			end
			creation_procedure_name := cp
		ensure
			creation_procedure_name_set: creation_procedure_name = cp
		end

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

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object.
		do
			create Result.initialize (root_name.duplicate, duplicate_ast (cluster_mark),
				duplicate_ast (creation_procedure_name))
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then root_name.same_as (other.root_name)
					and then same_ast (cluster_mark, other.cluster_mark)
					and then same_ast (creation_procedure_name, other.creation_procedure_name)
		end

feature -- Save

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			root_name.save (st)
		
			if cluster_mark /= Void then
				st.putstring (" (")
				cluster_mark.save (st)
				st.putstring (")")
			end

			if creation_procedure_name /= Void then
				st.putstring (": ")
				creation_procedure_name.save (st)
			end
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
			clusters: ARRAYED_LIST [CLUSTER_I];
			found: BOOLEAN;
			vd29: VD29;
			vd30: VD30;
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
							create vd29;
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
					create vd30;
					vd30.set_root_class_name (root_name);
					Error_handler.insert_error (vd30);
					Error_handler.checksum;
				end;
			else
				cluster := Universe.cluster_of_name (cluster_mark);
			end;
			if cluster = Void then
				create vd19;
				vd19.set_root_cluster_name (cluster_mark);
				Error_handler.insert_error (vd19);
			else
				System.set_root_cluster (cluster);
				a_class := cluster.classes.item (root_name);
				if a_class = Void then
					create vd20;
					vd20.set_cluster (cluster);
					vd20.set_class_name (root_name);
					Error_handler.insert_error (vd20);
				else
					System.set_root_class_name (root_name);
					file_name := a_class.file_name;
					if not compile_all then
							-- If we are using NONE as root class, then creation
							-- procedure, if specified, is useless.
							-- When not specified, we get a Void string.
						System.set_creation_name (creation_procedure_name);
					else
							-- Reset `creation_name' from SYSTEM_I in case
							-- we have switched the root class of the Ace file 
							-- from a meaningful class to NONE.
						System.set_creation_name (Void)
					end
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
			create Result.make (3);
			Result.append ("ANY")
		end;

	none_sd: ID_SD is
		once
			create Result.make (4);
			Result.append ("NONE")
		end;

end -- class ROOT_SD
