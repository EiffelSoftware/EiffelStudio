
deferred class ICON_HOLE 

inherit

	ICON
		-- added by samik
		undefine
			init_toolkit
		-- end of samik     
		redefine
			set_widget_default
		end;
	HOLE
		-- added by samik
	FOCUSABLE
		--end of samik	
feature 

	set_widget_default is
		do
			register
		end;

	target: WIDGET is
		do
			Result := button
		end;


	-- added by samik
	Focus_labels: FOCUS_LABEL_CONSTANTS is
		once
			!! Result
		end

	focus_label: FOCUS_LABEL_I is
			-- has to be redefined, so that it returns correct toolkit initializer
			-- to which object belongs for every instance of this class
                local
                        ti: TOOLTIP_INITIALIZER
                do
                        ti ?= top
                        check
                                valid_tooltip_initializer: ti/= void
                        end
                        Result := ti.label
                end

	is_centered: BOOLEAN 
		
end
