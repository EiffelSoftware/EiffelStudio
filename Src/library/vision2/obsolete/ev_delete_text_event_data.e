class
	EV_DELETE_TEXT_EVENT_DATA
	
inherit
	EV_RICH_TEXT_EVENT_DATA	
		redefine
			make,
			implementation,
			print_contents
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
		end
	
feature -- Access	

	cursor_position: INTEGER 

	start_position: INTEGER 

	end_position: INTEGER 

	text: STRING 

feature -- Debug
	
	print_contents is do end

feature {EV_WIDGET_IMP} -- Implementation

--	implementation: EV_DELETE_TEXT_EVENT_DATA_IMP

end -- class EV_DELETE_TEXT_EVENT_DATA
