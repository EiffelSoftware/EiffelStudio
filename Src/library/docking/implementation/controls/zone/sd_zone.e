indexing
	description: "Objects that used to hold SD_WINDOW(s) and SD_RESIZE_BAR(s)."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_ZONE

feature -- Propoties

	content: SD_CONTENT is
			-- The content which current holded.
		deferred
		end
	
	set_content (a_content: SD_CONTENT) is
		require
			a_content_not_void: a_content /= Void
			a_content_parent_void: a_content.user_widget.parent = Void
		deferred
		end

feature {NONE}  -- Implementation

	init_focus_in (a_widget: EV_WIDGET) is
			-- Catch all widgets actions in `Current'.
		local
			l_container: EV_CONTAINER
			l_linear: LINEAR [EV_WIDGET]
		do
			l_container ?= a_widget
			if l_container /= Void then
				l_linear := l_container.linear_representation
				from 
					l_linear.start
				until
					l_linear.after
				loop
					init_focus_in (l_linear.item)
					l_linear.forth
				end
			end
			
			a_widget.pointer_button_press_actions.force_extend (agent handle_focus_in)
		end
		
	handle_focus_in is
			-- 
		deferred
		end
		
feature {SD_DOCKING_MANAGER} 
	handle_zone_focus_out is
			-- 
		deferred
		end

feature {SD_DOCKING_MANAGER, SD_STATE}

	destroy_focus_in is
			-- Destory all widgets actions in `Current'.
		local
			l_widget: EV_WIDGET
		do
			l_widget ?= Current
			check l_widget /= Void end
			destroy_focus_in_imp (l_widget)
		end
		
feature {NONE} -- Implementation
	
	destroy_focus_in_imp (a_widget: EV_WIDGET) is
			-- Destory all widgets actions in `Current'.
		local
			l_container: EV_CONTAINER
			l_linear: LINEAR [EV_WIDGET]
		do
			l_container ?= a_widget
			if l_container /= Void then
				l_linear := l_container.linear_representation
				from 
					l_linear.start
				until
					l_linear.after
				loop
					destroy_focus_in_imp (l_linear.item)
					l_linear.forth
				end
			end
			
			a_widget.pointer_button_press_actions.wipe_out
		end
	
	internal_shared: SD_SHARED
			-- All singletons.

feature {SD_HOT_ZONE}
	invalidate is
			-- Redraw current.
		local
--			l_container: EV_CONTAINER
--			l_widget: EV_WIDGET
		do
--			l_container ?= Current
--			check l_container /= Void end
--			l_widget := l_container.item
--			l_container.wipe_out
--			l_container.replace (l_widget)
		end
		
end
