
class KEY_RELEASE_EV 

inherit

	EVENT

creation

	make

feature 

	identifier: INTEGER is
		do
			Result := - Event_const.key_release_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.key_release_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.key_release_label
		end;

	eiffel_text: STRING is "add_key_release_action (";	

end
