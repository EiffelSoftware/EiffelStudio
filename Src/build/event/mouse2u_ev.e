
class MOUSE2U_EV 

inherit

	EVENT

creation

	make

feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse2u_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse2u_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.mouse2u_label
		end;

	eiffel_text: STRING is "add_button_release_action (2, ";

end
