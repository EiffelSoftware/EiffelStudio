indexing
	description: "Objects that used to hold SD_WINDOW(s) and SD_RESIZE_BAR(s)."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_ZONE

feature -- Propoties

	state: SD_STATE is
			--
		do
			Result := content.state
		end

	content: SD_CONTENT is
			-- The content which current holded.
		deferred
		ensure
			not_void: Result /= Void
		end

	set_content (a_content: SD_CONTENT) is
		require
			a_content_not_void: a_content /= Void
			a_content_parent_void: a_content.user_widget.parent = Void
		deferred
		end

	type: INTEGER is
			--
		do
			Result := content.type
		end

feature {NONE}  -- Implementation

	init_focus_in (a_widget: EV_WIDGET) is
			-- Catch all widgets actions in `Current'.
		local
			l_container: EV_CONTAINER
		do
			l_container ?= Current
			check l_container /= Void end

--			a_widget.pointer_button_press_actions.force_extend (agent on_focus_in)
		end



feature {SD_DOCKING_MANAGER}
	handle_zone_focus_out is
			--
		do
			content.focus_out_actions.call ([])
		end

feature {SD_DOCKING_MANAGER, SD_CONTENT}
	on_focus_in is
			--
		do
			content.focus_in_actions.call ([])
		end

feature {SD_DOCKING_MANAGER, SD_STATE}

	destroy_focus_in is
			-- Destory all widgets actions in `Current'.
		local
			l_app: EV_APPLICATION
		do
--			create l_app
--			l_app.pointer_button_press_actions.prune_all (agent on_focus_in)
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
