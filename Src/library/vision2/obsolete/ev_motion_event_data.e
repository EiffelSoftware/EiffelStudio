class
	EV_MOTION_EVENT_DATA
	
inherit
	EV_EVENT_DATA	
		redefine
			make,
			print_contents
		end

create
	make
	
feature -- Initialization
	
	make is do end

feature -- Access	

	widget: EV_WIDGET 

	x: INTEGER 

	y: INTEGER 

	absolute_x: INTEGER 

	absolute_y: INTEGER 

	shift_key_pressed: BOOLEAN 

	control_key_pressed: BOOLEAN 

	first_button_pressed: BOOLEAN 

	second_button_pressed: BOOLEAN 

	third_button_pressed: BOOLEAN 

feature -- Debug
	
	print_contents is do end

feature {EV_WIDGET_IMP} -- Implementation
	
--	implementation: EV_MOTION_EVENT_DATA_I

end -- EV_MOTION_EVENT_DATA
