class
	EV_KEY_EVENT_DATA
	
inherit
	EV_EVENT_DATA	
		redefine
			make,
			implementation,
			print_contents
		end

create
	make

feature {NONE} -- Initialization

	make is do end

feature -- Access	

	widget: EV_WIDGET 

	keycode: INTEGER 

	length: INTEGER 

	string: STRING 

	shift_key_pressed: BOOLEAN 

	control_key_pressed: BOOLEAN 

	caps_lock_key_pressed: BOOLEAN 

	num_lock_key_pressed: BOOLEAN 

	scroll_lock_key_pressed: BOOLEAN 

feature -- Debug
	
	print_contents is do end

feature {EV_WIDGET_IMP} -- Implementation

--	implementation: EV_KEY_EVENT_DATA_I

end -- class EV_KEY_EVENT_DATA
