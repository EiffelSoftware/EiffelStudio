
class MOUSE1U_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse1u_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse1u_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.mouse1u_label
		end;

	eiffel_text: STRING is "add_button_release_action (1, ";

end
