
class CUT_HOLE 

inherit

	ICON_HOLE;
	PIXMAPS
		export
			{NONE} all
		end;
	FOCUSABLE
		rename
			focus_source as button
		
		export
			{NONE} all
		end


creation

	make

	
feature {NONE}

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end;
 
	focus_string: STRING is "Wastebasket";
 
	
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			make_visible (a_parent);
			set_symbol (Wastebasket_pixmap);
			initialize_focus
		end;
	
feature {NONE}

	process_stone is
		local
			r: REMOVABLE;
			temp: ANY;
			n: NAMABLE
		do
			r ?= stone;
			io.putstring (stone.generator);
			io.new_line;
			if (r /= Void) then
				io.putstring ("in cut hole%N");
				r.remove_yourself;
				n ?= stone.original_stone;
				if not (n = Void) then
					main_panel.namer_hole.reset (n)
				end
			end;
		end;

end
