class CLASSI_STONE 

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

	SHARED_WORKBENCH

creation

	make
	
feature -- making

	make (aclassi: CLASS_I) is
			-- Copy all information from argument
			-- OR KEEP A REFERENCE?
		do
			class_i := aclassi
		end;
 
	class_i: CLASS_I;

	file_name: STRING is
		do
			Result := class_i.file_name
		end;

	set_file_name (s: STRING) is do end;
 
feature -- dragging

	signature: STRING is
			-- Name and indication that the class is not compiled
		do
			Result := clone (class_i.class_name)
			Result.to_upper;
--			Result.append (" (not in system)")
		end;

	icon_name: STRING is
		do
			Result := clone (class_i.class_name)
			Result.to_upper
		end;

	header: STRING is
		do
			!!Result.make (20);
			Result.append ("Class: ");
			Result.append (signature);
			Result.append ("  ");
			Result.append ("Cluster: ");
			Result.append (class_i.cluster.cluster_name);
			Result.append (" (not in system)");
		end;
 
	stone_type: INTEGER is do Result := Class_type end;
 
	stone_name: STRING is do Result := l_Class end;
 
--	feature_named (n: STRING): FEATURE_STONE is
--			-- Nothing: class is not compiled
--		do
--		end;

	click_list: ARRAY [CLICK_STONE] is do end;
			-- Unclickable: not compiled
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
			-- No
		do
			Result := False
		end

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			if fs_valid and then class_i /= Void then
				Result := Universe.class_i (class_i.class_name) = class_i
			else
				Result := False
			end
		end;

	synchronized_stone: STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		do
			if class_i /= Void then
				Result := clone (Universe.class_stone (class_i.class_name))
			end
		end;

end
