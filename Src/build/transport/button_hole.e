
-- Hole with no label
deferred class BUTTON_HOLE 

inherit

	PICT_COLOR_B
		rename
			make as pict_color_make
		end;
	HOLE
	
feature {NONE}

	make_visible (a_parent: COMPOSITE) is
		do
			pict_color_make (a_parent);
			register
		end;

	target: WIDGET is
		do
			Result := Current
		end;

end
