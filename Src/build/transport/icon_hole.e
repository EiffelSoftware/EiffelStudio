
deferred class ICON_HOLE 

inherit

	ICON
		-- added by samik
		undefine
			init_toolkit
		-- end of samik     
		redefine
			set_widget_default,
			set_label
		end;
	HOLE

feature 

	set_widget_default is
		do
			register
		end

	set_label (s: STRING) is
			-- Set icon label.
		local
			was_managed: BOOLEAN
		do
			label := clone (s)
			if widget_created then
				icon_label.unmanage
				icon_label.set_y (init_y)
				icon_label.set_text (label)
				icon_label.manage
			end
			if icon_label /= Void then
				if button /= Void then
					set_width (icon_label.width.max (button.width))
				else
					set_width (icon_label.width)
				end	
				update_positions
			end
		end

	set_focus_string (s: STRING) is
		do
			button.set_focus_string (s)
		end

	target: WIDGET is
		do
			Result := button
		end;


	-- added by samik
	Focus_labels: FOCUS_LABEL_CONSTANTS is
		once
			!! Result
		end

	is_centered: BOOLEAN 
		
end
