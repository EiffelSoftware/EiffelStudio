class CLASSI_STONE 

inherit

	FILED_STONE

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
 
feature -- dragging

	signature: STRING is
			-- Name and indication that the class is not compiled
		do
			Result := class_i.class_name.duplicate;
			Result.to_upper;
			Result.append (" (not in system)")
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

end
