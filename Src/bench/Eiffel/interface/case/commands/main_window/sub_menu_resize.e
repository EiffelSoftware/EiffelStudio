class SUB_MENU_RESIZE 

inherit 

	EV_COMMAND

	--MENU_SELEC 
	--rename 
	--	make as old_make
	--end

	ONCES
creation 
	make

	feature -- Creation

		make( cl: like cluster_window; d: like drawing_component; s : INTEGER; b: BOOLEAN ) is
			do
				cluster_window := cl
				drawing_component := d
			 	shift := s
				is_height := b
			end

	feature -- Propeties
		
		cluster_window: MAIN_WINDOW
		drawing_component: DRAWING_COMPONENT

		
	feature -- Parameters

		is_height: BOOLEAN
	
		shift : INTEGER
			-- number linked to the resizing ...	

	feature -- Execution

		execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is

			local
				workarea: WORKAREA
				cluster	: CLUSTER_DATA
			do	
				workarea := drawing_component.drawing_area	 			
				cluster	:= workarea.data
	
				if cluster /= Void then
					if is_height then
						--workarea.set_height (cluster_window.draw_window.height + shift -100 ) 
						cluster.set_height	( cluster.height + shift - 100	)
					else
						--workarea.set_width ( cluster_window.draw_window.width + shift - 100)							
						cluster.set_width	( cluster.width + shift - 100	)
					end
					workarea.refresh_all
				else
					windows_manager.popup_message ("Mg", Void, cluster_window)
				end
			end

end
