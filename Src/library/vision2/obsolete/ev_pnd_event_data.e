class
	EV_PND_EVENT_DATA

inherit
	EV_BUTTON_EVENT_DATA
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization
	
	make is
		do
		end

feature -- Access	
	
	data: ANY 

	data_type: EV_PND_TYPE 

feature {EV_PND_TARGET_I} -- Element change
	
	set_data (new_data: like data) is do end
	
	set_data_type (new_type: EV_PND_TYPE) is do end

feature {EV_PND_TARGET_I} -- Implementation
	
--	implementation: EV_PND_EVENT_DATA_I

end -- class EV_PND_EVENT_DATA
