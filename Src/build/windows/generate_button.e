
class GENERATE_BUTTON

inherit

	LICENCE_COMMAND
		select
			init_toolkit
		end
	EB_BUTTON_COM
	
creation

	make

feature {NONE}

	make (a_parent: COMPOSITE) is
		do
			make_visible (a_parent);
			add_button_press_action (3, Current, Select_toolkit)
			-- added by samik
			set_focus_string (Focus_labels.generate_code_label)
			-- end of samik
		end;

	Select_toolkit: ANY is
		once
			!! Result 
		end

-- samik	focus_string: STRING is 
-- samik		do
-- samik			Result := Focus_labels.generate_code_label
-- samik		end;

-- samik	focus_label: LABEL is
-- samik		do
-- samik			Result := main_panel.focus_label
-- samik		end

feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.generate_pixmap
		end;

	work (argument: ANY) is
		local
			cmd: GENERATE;
			toolkit_popup: TOOLKIT_SELECTION_POPUP
		do
			if argument = Select_toolkit then
				!! toolkit_popup.make;
				toolkit_popup.popup
			elseif main_panel.project_initialized then
				!!cmd
				cmd.execute (argument)
			end
		end

end
