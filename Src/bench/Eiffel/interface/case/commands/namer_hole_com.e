indexing

	description: 
		"Hole that accepts namable objects. Located in the main panel.";
	date: "$Date$";
	revision: "$Revision $"

class 
	NAMER_HOLE_COM

inherit
	MAIN_PANEL_COM
		redefine
			--process_any, stone_type
		end

feature -- Properties

	symbol: EV_PIXMAP is
			-- Symbol representing Current button
		do
			Result := Pixmaps.namer_pixmap
		end;
	
	stone_type: INTEGER is
			-- Stone type that Current hole accepts
		do
			Result := Stone_types.any_type
		end;

feature -- Update

	process_any (dropped: STONE) is
			-- Popup namer window is `dropped' stone is
			-- namable.
		local
			namable: NAMABLE
		do
--			namable ?= dropped;
--			if namable /= Void then
--				Windows.namer_window.popup_at_current_position (namable)
--			end
		end;

feature -- Execution (work)

	work (arg: ANY) is 
			-- Do nothing. 
		do 
		end;

end -- class NAMER_HOLE_COM
