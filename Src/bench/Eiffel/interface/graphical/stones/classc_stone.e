-- Internal representation of a compiled class.

class CLASSC_STONE

inherit

	FILED_STONE
		rename
			is_valid as fs_valid
		redefine
			synchronized_stone
		end;

	FILED_STONE
		redefine
			is_valid, synchronized_stone
		select
			is_valid
		end;

	SHARED_EIFFEL_PROJECT;
	
	HASHABLE_STONE
		undefine
			header
		redefine
			is_valid, synchronized_stone
		end;

	INTERFACE_W

creation

	make
	
feature -- making

	make (a_class: E_CLASS) is
			-- Copy all information from argument
			-- OR KEEP A REFERENCE?
		do
			e_class := a_class
		end;

	e_class: E_CLASS;

feature -- dragging

	signature: STRING is
		do
			Result := e_class.signature
		end;

	icon_name: STRING is
		do
			Result := clone (e_class.name)
			Result.to_upper;
		end;

	header: STRING is
		do
			!!Result.make (20);
			Result.append ("Class: ");
			Result.append (signature);
			Result.append ("  ");
			Result.append ("Cluster: ");
			Result.append (e_class.cluster.cluster_name);
			if e_class.is_precompiled then
				Result.append ("   (precompiled)")
			end
		end;

	stone_type: INTEGER is do Result := Class_type end;

	stone_name: STRING is do Result := l_Class end;
 
	click_list: CLICK_STONE_ARRAY is
		do
			!! Result.make (e_class.click_list, e_class)
		end;
 
	file_name: STRING is
			-- The one from CLASSC
		do
			if e_class /= Void then
				Result := e_class.file_name
			end
		end;

	set_file_name (s: STRING) is do end;

	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
			Result := e_class.has_feature_table or else
					e_class.has_ast
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result :=  fs_valid and then e_class /= Void
		end;

feature -- Synchronization

	synchronized_stone: STONE is
			-- Clone of `Current' stone after a recompilation
			-- (May be Void if not valid anymore. It may also be a 
			-- classi_stone if the class is not compiled anymore)
		local
			new_cluster: CLUSTER_I
		do
			if e_class /= Void then
				if Eiffel_system.class_of_id (e_class.id) = e_class then
					!CLASSC_STONE! Result.make (e_class)
				else
					new_cluster := Eiffel_universe.cluster_of_name 
							(e_class.cluster.cluster_name);
					if 
						new_cluster /= Void and then
						new_cluster.classes.has_item (e_class.lace_class)
					then
						!CLASSI_STONE! Result.make (e_class.lace_class)
					end
				end
			end
		end;

feature -- Hashable

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := e_class.name.hash_code
		end;

end
