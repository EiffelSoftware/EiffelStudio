class OK_BUTTON 

inherit

	EB_BUTTON_COM;

creation

	make

feature {NONE} -- focus label

-- samik	focus_string: STRING is
-- samik		do
-- samik			Result := Focus_labels.accept_change_label
-- samik		end;

-- samik	focus_label: FOCUS_LABEL is
-- samik		do
-- samik			Result := namer_window.focus_label
-- samik		end
	
	symbol: PIXMAP is
		do
			Result := Pixmaps.ok_pixmap
		end;

	make (namer:  NAMER_WINDOW; a_parent: COMPOSITE) is
		do
			namer_window := namer;	
			make_visible (a_parent);
			set_focus_string (Focus_labels.accept_change_label)
		end;


feature {NONE} -- behaviour

	namer_window: NAMER_WINDOW;

	execute (argument: ANY) is
		do
			namer_window.set_name
			namer_window.close
		end;

end 
