class NAMER_WIN_EDIT_HOLE 

inherit

	EB_BUTTON
		rename
			symbol as button_symbol
		end;
	HOLE
		redefine
			process_any
		end;
	DRAG_SOURCE

creation

	make

feature {NONE} 

	namer_window: NAMER_WINDOW;

	focus_string: STRING is
		do
			Result := Focus_labels.namer_label
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := namer_window.focus_label
		end;
	
	button_symbol: PIXMAP is
		do
			Result := Pixmaps.namer_pixmap
		end;

	make (namer:  NAMER_WINDOW; a_parent: COMPOSITE) is
		do
			namer_window := namer;	
			make_visible (a_parent);
			initialize_transport
		end;

	target: WIDGET is
		do
			Result := Current
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.any_type
		end;

	process_any (dropped: STONE) is
		local
			namable: NAMABLE
		do
			namable ?= dropped;
			if namable /= Void then
				namer_window.set_namable (namable)
			end
		end;

feature {NONE} -- Stone

	stone: STONE is
		do
			Result ?= namer_window.namable
		end;

	source: WIDGET is
		do
			Result := Current
		end;

end 
