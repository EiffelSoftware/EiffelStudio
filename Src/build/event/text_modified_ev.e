
class TEXT_MODIFIED_EV 

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
			Result := - Event_const.text_modified_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.scr_t_modify_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.scr_t_modify_label
		end;

	eiffel_text: STRING is "add_modify_action (";

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			text: TEXT_C
		do
			text ?= a_context;
			Result := not (text = Void)
		end;

end
