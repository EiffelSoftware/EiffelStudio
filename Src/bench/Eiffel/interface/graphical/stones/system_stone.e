class SYSTEM_STONE 

inherit

	SHARED_WORKBENCH;
	FILED_STONE

creation

	make

feature 

	make (a_systemi: SYSTEM_I) is
		do
			system_i := a_systemi
		end;

	system_i: SYSTEM_I

feature

	file_name: STRING is
			-- Name of the lace ifle
		do
			if Lace /= Void then
				Result := Lace.file_name
			end
		end;
 
	set_file_name (s: STRING) is
			-- Assign `s' to `file_name' of lace.
		do
			if Lace /= Void then
				Lace.set_file_name (s)
			end
		end;
 
	click_list: ARRAY [CLICK_STONE] is
		local
			dummy_reference: CLASS_C
		do
			if 
				(Lace /= Void) and then (Lace.root_ast /= Void) and then
				Lace.not_first_parsing
			then
				Result := Lace.root_ast.click_list.clickable_stones (dummy_reference)
			end
		end;
 
	signature: STRING is
		do
			Result := system_i.system_name;
			if Result = Void then
				-- FIXME: `signature' is asked only when system is compiled, and therefore
				-- `system_name' exists.
				Result := "Uncompiled"
			end
		end;

	header: STRING is
		do
			!!Result.make (0);
			Result.append ("Ace");
		end;
 
	stone_type: INTEGER is do Result := System_type end;
 
	stone_name: STRING is do Result := l_System end;
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
			Result := true
		end

end
