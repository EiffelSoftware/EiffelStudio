indexing
	description: "Vision2 Widget containing Active X Web Browser control for web browsing."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_BROWSER
	
inherit 
	EV_VERTICAL_BOX

create
	make

feature -- Creation

	make is 
			-- Create 
		do
			default_create
			
			create address_bar.make_with_text ("Enter address here")
			extend (address_bar)
			
			create browser_container
			browser_container.put (internal_browser)
			extend (browser_container)
			set_padding_width (2)
			
			disable_item_expand (address_bar)
			enable_item_expand (browser_container)
			
			setup_events
		end		

feature -- Interface	
	
	browser_container: EV_WINFORM_CONTAINER
			-- Vision 2 Winforms container
	
	address_bar: EV_COMBO_BOX
	
feature {NONE} -- Implementation

	internal_browser: WEB_BROWSER is
			-- Web browser control
		once
			create Result.make
		end

	setup_events is
			-- Setup interface events for browser interaction
		do
			address_bar.key_press_actions.extend (agent address_key_pressed (?))
		end
		
	address_key_pressed (key: EV_KEY) is
			-- A key was pressed in the address bar
		do
			if key.code = feature {EV_KEY_CONSTANTS}.Key_enter then
				Internal_browser.open_url (address_bar.text)				
			end
		end

end -- class DOCUMENT_BROWSER
