-- Internal representation of a compiled class.

class CLASSC_STONE

inherit

	FILED_STONE

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
			Result := class_c.class_name.duplicate;
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

end
