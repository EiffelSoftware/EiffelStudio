class OK_BUTTON 

inherit

	EB_BUTTON_COM

creation

	make

feature {NONE} -- focus label

	create_focus_label is
		do
			set_focus_string (Focus_labels.accept_change_label)
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.ok_pixmap
		end

	make (namer:  NAMER_WINDOW; a_parent: COMPOSITE) is
		do
			namer_window := namer	
			make_visible (a_parent)
		end


feature {NONE} -- behaviour

	namer_window: NAMER_WINDOW

	execute (argument: ANY) is
		do
			namer_window.set_name
		end

end 
