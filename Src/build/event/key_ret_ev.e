
class KEY_RET_EV 

inherit

	EVENT
		redefine
			is_valid_for_context
		end

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.key_return_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.key_return_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.key_return_label
		end;

	eiffel_text: STRING is "set_action (%"<Key>Return%", ";

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			a_tf: TEXT_FIELD_C;
		do
			a_tf ?= a_context;
			Result := not (a_tf = Void);
		end;

end
