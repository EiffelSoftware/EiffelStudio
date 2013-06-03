note
	description:
		"Mswindows implementation of pick and dropable for items."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_ITEM_IMP

inherit
	EV_PICK_AND_DROPABLE_IMP
		undefine
			set_pointer_style
		redefine
			pnd_press,
			escape_pnd,
			check_drag_and_drop_release
		end

feature -- Access

	pnd_original_parent: detachable EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		-- Actual widget parent of `Current' when PND starts.
		--| This is required as the item's parent may change during
		--| exection of the actions, while we still need to access it
		--| after the actions have been called.

	set_pnd_original_parent
			-- Assign `parent_imp' to `pnd_original_parent'.
			--| This is done as a feature rather than just an assignment
			--| within pnd_press as EV_TREE_ITEM_IMP needs to store
			--| top_parent_imp. This allows a simply redefinition of
			--| this feature rather than pnd_press which would lead
			--| to unecessary code duplication.
		do
			pnd_original_parent ?= parent_imp
			check
				pnd_original_parent_not_void: pnd_original_parent /= Void
			end
		end

	parent_imp: detachable EV_ITEM_LIST_I [EV_ITEM]
			-- Parent implementation of `Current'.
		deferred
		end

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Window containing `Current' in parenting hierarchy.
		local
			pickable_parent: detachable EV_PICK_AND_DROPABLE_IMP
		do
			if parent_imp /= Void then
				pickable_parent ?= parent_imp
				check
					parent_is_item_list: pickable_parent /= Void then
				end
				Result := pickable_parent.top_level_window_imp
			end
		end

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER)
			-- Process a pointer press that may alter the current state
			-- of pick/drag and drop.
		do
			if press_action = Ev_pnd_start_transport then
					-- We must now check that we are not currently in a pick and drop.
					-- If we are, then we should do nothing, as the event was generated
					-- as a result of clicking on a widget while dropping.
				if application_imp.pick_and_drop_source = Void then
						-- Now check the correct pointer_button was pressed to start
						-- The transport, otherwise, do nothing.
					if (a_button = 1 and not mode_is_pick_and_drop) or
						(a_button = 3 and mode_is_pick_and_drop) then
						set_pnd_original_parent
						if attached pnd_original_parent as l_pnd_original_parent then
							start_transport (a_x, a_y, a_button, True, 0, 0, 0.5, a_screen_x,
								a_screen_y, False)
							if application_imp.pick_and_drop_source /= Void then
								if pebble /= Void then
									l_pnd_original_parent.set_parent_source_true
									l_pnd_original_parent.set_item_source (Current)
									l_pnd_original_parent.set_item_source_true
								end
							else
								l_pnd_original_parent.set_parent_source_false
							end
						end
					end
				end
			elseif press_action = Ev_pnd_end_transport then
				end_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x, a_screen_y)
				if attached pnd_original_parent as l_pnd_original_parent then
					l_pnd_original_parent.set_parent_source_false
					l_pnd_original_parent.set_item_source (Void)
					l_pnd_original_parent.set_item_source_false
						-- If the user cancelled a pick and drop with the left
						-- button then we need to make sure that the
						-- pointer_button_press_actions are not called on
						-- `pnd_original_parent' or an item at the current
						-- pointer position within `pnd_original_parent'.
					if a_button = 1 then
						l_pnd_original_parent.discard_press_event
					end
				end
			elseif attached pnd_original_parent as l_pnd_original_parent then
				l_pnd_original_parent.set_parent_source_false
				l_pnd_original_parent.set_item_source (Void)
				l_pnd_original_parent.set_item_source_false
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	escape_pnd
			-- <Precursor>
		do
			if attached pnd_original_parent as l_pnd_original_parent then
					-- There is nothing on items to finish pick and drop, we have to finish it via the parent.
				l_pnd_original_parent.escape_pnd
			else
					-- No parent, let's use inherited version.
				Precursor
			end
		end

	check_drag_and_drop_release (a_x, a_y: INTEGER)
			-- End transport if in drag and drop.
			--| Releasing the left button ends drag and drop.
		local
			l_original_top_level_window_imp: like original_top_level_window_imp
		do
			original_x := -1
			original_y := -1
			application_imp.end_awaiting_movement
			awaiting_movement := False
			if mode_is_drag_and_drop and press_action =
				Ev_pnd_end_transport then
				end_transport (a_x, a_y, 1, 0, 0, 0, 0, 0)
				if attached pnd_original_parent as l_pnd_original_parent then
					l_pnd_original_parent.set_parent_source_false
					l_pnd_original_parent.set_item_source (Void)
					l_pnd_original_parent.set_item_source_false
				end
			else
				l_original_top_level_window_imp := original_top_level_window_imp
				if l_original_top_level_window_imp /= Void then
					l_original_top_level_window_imp.move_to_foreground
				end
			end
		end

	set_pointer_style (c: EV_POINTER_STYLE)
			-- Assign `c' to `parent_imp' pointer style.
		local
			pickable_parent: detachable EV_PICK_AND_DROPABLE_IMP
		do
			if parent_imp /= Void then
				pickable_parent ?= parent_imp
				check
					parent_is_item_list: pickable_parent /= Void then
				end
				pickable_parent.set_pointer_style (c)
			end
		end

	set_capture
			-- Grab user input.
			-- Works only on current windows thread.
		do
			if attached pnd_original_parent as l_pnd_original_parent then
					-- It may be possible that `Current' has been removed from parent during PND.
				l_pnd_original_parent.set_capture
			end
		end

	release_capture
			-- Release user input.
			-- Works only on current windows thread.
		do
			if attached pnd_original_parent as l_pnd_original_parent then
					-- It may be possible that `Current' has been removed from parent during PND.
				l_pnd_original_parent.release_capture
			end
		end

	set_heavy_capture
			-- Grab user input.
			-- Works on all windows threads.
		do
			if attached pnd_original_parent as l_pnd_original_parent then
					-- It may be possible that `Current' has been removed from parent during PND.
				l_pnd_original_parent.set_heavy_capture
			end
		end

	has_heavy_capture: BOOLEAN
			-- Does `parent' have a heavy capture?
		do
			Result := attached pnd_original_parent as l_pnd_original_parent and then l_pnd_original_parent.has_heavy_capture
		end

	release_heavy_capture
			-- Release user input.
			-- Works on all windows threads.
		do
			if attached pnd_original_parent as l_pnd_original_parent then
					-- It may be possible that `Current' has been removed from parent during PND.
				l_pnd_original_parent.release_heavy_capture
			end
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_PICK_AND_DROPABLE_ITEM_IMP











