class
	EV_BUTTON_EVENT_DATA
	
inherit
	EV_EVENT_DATA	
		redefine
			make,
			print_contents
		end
	
create
	make
	
feature {NONE} -- Initialization

	make is
		do
		end

feature -- Access	

	widget: EV_WIDGET

	x: INTEGER

	y: INTEGER

	absolute_x: INTEGER

	absolute_y: INTEGER

	button: INTEGER

	shift_key_pressed: BOOLEAN

	control_key_pressed: BOOLEAN

	first_button_pressed: BOOLEAN 

	second_button_pressed: BOOLEAN

	third_button_pressed: BOOLEAN

feature -- Debug
	
	print_contents is
			-- print the contents of the object
		do
		end

feature {EV_WIDGET_IMP} -- Implementation
	
--	implementation: EV_BUTTON_EVENT_DATA_I
	
end -- class EV_BUTTON_EVENT_DATA
