class
	EV_RICH_TEXT_EVENT_DATA
	
inherit
	EV_EVENT_DATA	
		redefine
			make,
			print_contents
		end

create
	make

feature {NONE} -- Initialization

	make is do end
	
feature -- Access	

	rich_text: EV_RICH_TEXT

feature -- Debug
	
	print_contents is do end

feature {EV_WIDGET_IMP} -- Implementation

--	implementation: EV_RICH_TEXT_EVENT_DATA_IMP

end -- class EV_RICH_TEXT_EVENT_DATA
