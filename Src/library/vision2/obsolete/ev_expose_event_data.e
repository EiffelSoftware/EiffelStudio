class
	EV_EXPOSE_EVENT_DATA 

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

	clip_region: EV_CLIP 

	exposes_to_come: INTEGER 

feature -- Debug
	
	print_contents is do end

feature {EV_WIDGET_IMP} -- Implementation
	
--	implementation: EV_EXPOSE_EVENT_DATA_I
	
end -- class EV_EXPOSE_EVENT_DATA
