indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.Dictionary"

class
	DICTIONARY

feature -- Access

	Border_style: INTEGER is 3
			-- Window border style: a fixed, single line border
		indexing
			external_name: "BorderStyle"
		end
				
	Button_height: INTEGER is 23
			-- Button height
		indexing
			external_name: "ButtonHeight"
		end
		
	Button_width: INTEGER is 75
			-- Width of current buttons
		indexing
			external_name: "ButtonWidth"
		end

	Font_family_name: STRING is "Verdana"
			-- Name of label font family
		indexing
			external_name: "FontFamilyName"
		end

	Font_size: REAL is 8.0
			-- Font size
		indexing
			external_name: "FontSize"
		end

	Label_font_size: REAL is 10.0
			-- Label font size
		indexing
			external_name: "LabelFontSize"
		end

	Label_height: INTEGER is 20
			-- Label height
		indexing
			external_name: "LabelHeight"
		end
		
	Margin: INTEGER is 10
			-- Margin
		indexing
			external_name: "Margin"
		end

	Regular_style: INTEGER is 0
			-- Regular style
		indexing
			external_name: "RegularStyle"
		end

	System_event_handler_type: STRING is "System.EventHandler"
			-- System.EventHandler type
		indexing
			external_name: "SystemEventHandlerType"
		end
	
	Window_width: INTEGER is 750
			-- Window width
		indexing
			external_name: "WindowWidth"
		end
		
end -- class DICTIONARY