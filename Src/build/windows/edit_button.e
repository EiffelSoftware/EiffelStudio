
deferred class EDIT_BUTTON 

inherit

	PIXMAPS;
	ICON_HOLE;
	FOCUSABLE;
	WINDOWS

feature 

	focus_source: PICT_COLOR_B is
		do
			Result := button;
		end;

	
feature {NONE}

	process_stone is
		local
			editable: EDITABLE
		do
			editable ?= stone.original_stone;
			if (editable /= Void) then
				editable.create_editor
			end			
		end;

end
