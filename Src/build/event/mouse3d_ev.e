
class MOUSE3D_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse3d_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse3d_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.mouse3d_label
		end;

	eiffel_text: STRING is "add_button_press_action (3, ";

end
