
class VALUE_CHANGED_EV 

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
			Result := - Event_const.value_changed_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.value_changed_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.value_changed_label
		end;

	eiffel_text: STRING is "add_value_changed_action (";	

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			toggle: TOGGLE_B_C;
			scale: SCALE_C;
		do
			toggle ?= a_context;
			scale ?= a_context;
			Result := (not (scale = Void)) or (not (toggle = Void))
		end;

	specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Add	the command represented by `a_cmd_instance' to 
			-- `a_context' according to the kind of event.
		local
			scrollbar_widget: SCROLLBAR
				-- This one should be useless.
			toggle_b_widget: TOGGLE_B
			scale_widget: SCALE
		do
			scrollbar_widget ?= a_widget
			toggle_b_widget ?= a_widget
			scale_widget ?= a_widget
			if scrollbar_widget /= Void then
				scrollbar_widget.add_value_changed_action (a_command, Void)
			elseif toggle_b_widget /= Void then
				toggle_b_widget.add_value_changed_action (a_command, Void)
			elseif scale_widget /= Void then
				scale_widget.add_value_changed_action (a_command, Void)
			end
		end

	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Remove `a_command' from `a_widget' according to the
			-- kind of event.
		local
			scrollbar_widget: SCROLLBAR
				-- This one should be useless.
			toggle_b_widget: TOGGLE_B
			scale_widget: SCALE
		do
			scrollbar_widget ?= a_widget
			toggle_b_widget ?= a_widget
			scale_widget ?= a_widget
			if scrollbar_widget /= Void then
				scrollbar_widget.remove_value_changed_action (a_command, Void)
			elseif toggle_b_widget /= Void then
				toggle_b_widget.remove_value_changed_action (a_command, Void)
			elseif scale_widget /= Void then
				scale_widget.remove_value_changed_action (a_command, Void)
			end
		end

end
