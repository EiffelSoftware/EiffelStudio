
class MOUSE_ENTER_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse_enter_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse_Enter_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.mouse_enter_label
		end;

	eiffel_text: STRING is "add_enter_action (";	

end
