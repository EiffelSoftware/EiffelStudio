class SYSTEM_STONE 

inherit

	SHARED_EIFFEL_PROJECT;
	FILED_STONE;
	INTERFACE_W

creation

	make

feature 

	make is
		do
		end;

feature

	file_name: STRING is
			-- Name of the lace ifle
		do
			Result := Eiffel_project.lace_file_name
		end;
 
	set_file_name (s: STRING) is
			-- Assign `s' to `file_name' of lace.
		do
			Eiffel_project.set_lace_file_name (s)
		end;
 
	click_list: ARRAY [CLICK_STONE] is
		do
			Result := Eiffel_project.lace_click_list
		end;
 
	signature: STRING is
		do
			if Eiffel_project.initialized then
				Result := Eiffel_system.name
			else
				-- FIXME: `signature' is asked only when system is compiled, and therefore
				-- `system_name' exists.
				Result := "Uncompiled"
			end
		end;

	icon_name: STRING is "Ace";

	header: STRING is "Ace";
 
	stone_type: INTEGER is do Result := System_type end;
 
	stone_name: STRING is do Result := l_System end;
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
			Result := true
		end

end
