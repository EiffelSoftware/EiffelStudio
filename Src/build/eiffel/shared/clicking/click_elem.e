deferred class CLICK_ELEM 
	
feature 

	node: ANY is deferred end;

	start_position: INTEGER;

	end_position: INTEGER;

	start_focus: INTEGER is do Result := start_position end;
	
	end_focus: INTEGER is do Result := end_position end;

end
