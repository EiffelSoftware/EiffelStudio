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

	SHARED_WORKBENCH

creation

	make
	
feature -- making

	make (aclassc: CLASS_C) is
			-- Copy all information from argument
			-- OR KEEP A REFERENCE?
		do
			class_c := aclassc
		end;

	class_c: CLASS_C;

feature -- dragging

	signature: STRING is
		do
			Result := class_c.signature
		end;

	icon_name: STRING is
		do
			Result := clone (class_c.class_name)
			Result.to_upper;
		end;

	header: STRING is
		do
			!!Result.make (20);
			Result.append ("Class: ");
			Result.append (signature);
			Result.append ("  ");
			Result.append ("Cluster: ");
			Result.append (class_c.cluster.cluster_name);
			if class_c.is_precompiled then
				Result.append ("   (precompiled)")
			end
		end;

	stone_type: INTEGER is do Result := Class_type end;

	stone_name: STRING is do Result := l_Class end;
 
	click_list: ARRAY [CLICK_STONE] is
		do
			Result := class_c.click_list
		end;
 
	file_name: STRING is
			-- The one from CLASSC
		do
			if class_c /= Void then
				Result := class_c.file_name
			end
		end;

	set_file_name (s: STRING) is do end;

--	feature_named (n: STRING): FEATURE_STONE is
--			-- Feature whose internal name is `n'
--		do
--			--if Error_handler.has_error then
--				--Result := Tmp_feat_tbl_server.item (id).item (n)
--			--else
--				--Result := Feat_tbl_server.item (id).item (n)
--			--end
--		end;
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
			-- Yes. (FIXME?)
		do
			--if not Error_handler.has_error then
				Result := class_c.clickable
			--end
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		local
			class_i: CLASS_I
		do
			if fs_valid and then class_c /= Void then
				class_i := Universe.class_i (class_c.class_name);
				Result := class_i /= Void and then 
						class_i.compiled and then 
						class_c = class_i.compiled_class
			else
				Result := False
			end
		end;

feature -- Synchronization

	synchronized_stone: STONE is
			-- Clone of `Current' stone after a recompilation
			-- (May be Void if not valid anymore)
		do
			if class_c /= Void then
				Result := clone (Universe.class_stone (class_c.class_name))
			end
		end;

end
