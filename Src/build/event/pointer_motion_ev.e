
class POINTER_MOTION_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.pointer_motion_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.pointer_motion_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.pointer_motion_label
		end;

	eiffel_text: STRING is "add_pointer_motion_action (";	

end
