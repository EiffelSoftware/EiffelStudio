
class MOUSE_LEAVE_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse_leave_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse_leave_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.mouse_leave_label
		end;

	eiffel_text: STRING is "add_leave_action (";	

end
