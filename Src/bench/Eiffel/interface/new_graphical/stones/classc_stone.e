indexing
	description: 
		"Stone representing a compiled Eiffel class."
	date: "$Date$"
	revision: "$Revision $"

class
	CLASSC_STONE

inherit
	CLASSI_STONE
		rename
			make as classi_make
		redefine
			is_valid, synchronized_stone,
			class_i, cluster, class_name, file_name, 
			header, stone_signature, history_name
		end

creation
	make
	
feature {NONE} -- Initialization

	make (a_class: CLASS_C) is
			-- Copy all information from argument
			-- OR KEEP A REFERENCE?
		do
			e_class := a_class
		end

feature -- Properties

	e_class: CLASS_C

	cluster: CLUSTER_I is
		do
			Result := e_class.cluster
		end

	class_name: STRING is
		do
			Result := e_class.name
		end

	class_i: CLASS_I is
		do
			Result := e_class.lace_class
		end

feature -- Access

	stone_signature: STRING is
		do
			Result := e_class.class_signature
		end

	history_name: STRING is
		do
			Result := Interface_names.s_Class_stone + stone_signature
		end

	header: STRING is
			-- Display class name, class' cluster and class location in 
			-- window title bar.
		do
			create Result.make (80)
			Result.append (stone_signature)
			Result.append ("  in cluster ")
			Result.append (e_class.cluster.cluster_name)
			if e_class.is_precompiled then
				Result.append ("  (precompiled)")
			else
				Result.append ("   located in ")
				Result.append (e_class.lace_class.file_name)
			end
		end

	file_name: FILE_NAME is
			-- The one from CLASSC
		do
			if e_class /= Void then
				create Result.make_from_string (e_class.file_name)
			end
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result :=	e_class /= Void and then
						e_class.is_valid and then
						Precursor {CLASSI_STONE}
		end

feature -- Synchronization

	synchronized_stone: CLASSI_STONE is
			-- Clone of `Current' stone after a recompilation
			-- (May be Void if not valid anymore. It may also be a 
			-- classi_stone if the class is not compiled anymore)
		local
			new_cluster: CLUSTER_I
			new_ci: CLASS_I
		do
			if e_class /= Void then
				if e_class.is_valid then
					if is_valid then
						Result := Current
					else
						Result := create {CLASSC_STONE}.make (e_class)
					end
				else
					new_cluster := Eiffel_universe.cluster_of_name 
							(e_class.cluster.cluster_name)
					if new_cluster /= Void then
						new_ci := new_cluster.class_with_name (e_class.lace_class.name)
						if 
							new_ci /= Void
						then
							if not new_ci.compiled then
								!CLASSI_STONE! Result.make (e_class.lace_class)
							else
								create {CLASSC_STONE} Result.make (new_ci.compiled_class)
							end
							
						end
					end
				end
			end
		end

end -- class CLASSC_STONE
