indexing



	description: "Objects that is a zone when floating."
	legal: "See notice at end of class."
	status: "See notice at end of class."



	date: "$Date$"



	revision: "$Revision$"







class



	SD_FLOATING_TAB_ZONE







inherit



	SD_MULTI_CONTENT_ZONE



			



	SD_DOCKER_SOURCE



		undefine



			default_create, copy	



		end



		



	SD_RESIZE_FLOATING_WINDOW



		rename



			prune as prune_resize_window,



			count as count_resize_window,



			extend as extend_resize_window,



			make as make_resize_window,



			on_pointer_motion as on_pointer_motion_resize_window



		end



create



	make







feature {NONE} -- Initlization







	make is



			-- 



		do



			create internal_shared



		end



		



feature {NONE} -- Implementation



--	internal_title_bar: SD_



	



	on_focus_in is



			-- 



		do



			internal_shared.docking_manager.disable_all_zones_focus_color



		end



	



	on_focus_out is



			-- 



		do



			



		end



indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end



