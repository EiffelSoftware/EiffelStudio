class NAMER_WIN_EDIT_HOLE 

inherit

	EB_BUTTON
		rename
			symbol as button_symbol
		end;
	HOLE
		redefine
			process_any
		select
			init_toolkit
		end;
	DRAG_SOURCE

creation

	make

feature {NONE} 

	create_focus_label is
		do
			set_focus_string (Focus_labels.namer_label)
		end;
	
	button_symbol: PIXMAP is
		do
			Result := Pixmaps.namer_pixmap
		end;

	make (a_parent: COMPOSITE) is
			-- Make Current
		do
			make_visible (a_parent);
			initialize_transport;
			register;	
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
			namable ?= dropped.data;
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
