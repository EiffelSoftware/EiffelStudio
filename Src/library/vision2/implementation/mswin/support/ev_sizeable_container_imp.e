note
	description:
		"Eiffel Vision sizeable container. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SIZEABLE_CONTAINER_IMP

inherit
	EV_SIZEABLE_IMP
		undefine
			ev_apply_new_size
		redefine
			minimum_width,
			minimum_height,
			initialize_sizeable
		end

feature {NONE} -- Initialization

	initialize_sizeable
			-- Initialize sizing attributes of `Current'.
		do
			create child_cell
			set_minwidth_recomputation_needed (True)
			set_minheight_recomputation_needed (True)
		end

feature -- Status report

	is_minwidth_recomputation_needed: BOOLEAN
			-- Does minimum width need to be recomputed?

	is_minheight_recomputation_needed: BOOLEAN
			-- Does minimum height need to be recomputed?

	is_notify_originator: BOOLEAN
			-- Did Current launch `notification process'?

	is_in_min_height: BOOLEAN
			-- Is current recomputing its minimum height?

	is_in_min_width: BOOLEAN
			-- Is current recomputing its minimum width?

	is_in_notify: CELL [BOOLEAN]
			-- Is current already notified from a change in its children?
		once
			create Result.put (False)
		end

feature -- Status setting

	set_minwidth_recomputation_needed (flag: BOOLEAN)
			-- Set `is_minwidth_recomputation_needed' with `flag'?
		do
			is_minwidth_recomputation_needed := flag
		end

	set_minheight_recomputation_needed (flag: BOOLEAN)
			-- Set `is_minheight_recomputation_needed' with `flag'?
		do
			is_minheight_recomputation_needed := flag
		end

feature -- Access

	minimum_width: INTEGER
			-- Lower bound on `width' in pixels.
		do
			if is_minwidth_recomputation_needed then
				set_minwidth_recomputation_needed (False)
				is_in_min_width := True
				if is_minheight_recomputation_needed then
					set_minheight_recomputation_needed (False)
					is_in_min_height := True
					compute_minimum_size (False)
				else
					compute_minimum_width (False)
				end
				is_in_min_height := False
				is_in_min_width := False
			end
			Result := child_cell.minimum_width
		end

	minimum_height: INTEGER
			-- Lower bound on `height' in pixels.
		do
			if is_minheight_recomputation_needed then
				set_minheight_recomputation_needed (False)
				is_in_min_height := True
				if is_minwidth_recomputation_needed then
					set_minwidth_recomputation_needed (False)
					is_in_min_width := True
					compute_minimum_size (False)
				else
					compute_minimum_height (False)
				end
				is_in_min_height := False
				is_in_min_width := False
			end
			Result := child_cell.minimum_height
		end

feature -- Basic operations

	ev_set_minimum_width (value: INTEGER; a_is_size_forced: BOOLEAN)
			-- Assign `value' to `minimum_width'.
			-- Should check if the user didn't set the minimum width
			-- before we set the new value.
		local
			mw, rw: INTEGER
			p_imp: like parent_imp
			do_change: BOOLEAN
			top_imp: like top_level_window_imp
		do
			mw := child_cell.minimum_width
			if mw /= value then
				internal_set_minimum_width (value)
				p_imp := parent_imp
				if p_imp /= Void and then (not is_in_notify.item or else is_notify_originator) then
					p_imp.notify_change (Nc_minwidth, attached_interface.implementation, a_is_size_forced)
					do_change := True
				end
			end
			top_imp := top_level_window_imp
			if
				not do_change and then
				(a_is_size_forced or (top_imp /= Void and then top_imp.is_displayed))
			then
					-- Current width
				rw := child_cell.width
				if value > rw then
					ev_move_and_resize (x_position, y_position,
							value, child_cell.height, True)
				elseif is_initialized then
						-- Apply changes to children only
					ev_apply_new_size (x_position, y_position,
							rw.max (value), child_cell.height, True)
				end
			end
		end

	ev_set_minimum_height (value: INTEGER; a_is_size_forced: BOOLEAN)
			-- Assign `value' to `minimum_height'.
			-- Should check if the user didn't set the minimum width
			-- before we set the new value.
		local
			mh, rh: INTEGER
			p_imp: like parent_imp
			do_change: BOOLEAN
			top_imp: like top_level_window_imp
		do
			mh := child_cell.minimum_height
			if mh /= value then
				internal_set_minimum_height (value)
				p_imp := parent_imp
				if p_imp /= Void and then (not is_in_notify.item or else is_notify_originator) then
					p_imp.notify_change (Nc_minheight, attached_interface.implementation, a_is_size_forced)
					do_change := True
				end
			end
			top_imp := top_level_window_imp
			if
				not do_change and then
				(a_is_size_forced or (top_imp /= Void and then top_imp.is_displayed))
			then
				rh := child_cell.height
				if value > rh then
						-- Apply changes to current and children
					ev_move_and_resize (x_position, y_position,
							child_cell.width, value, True)
				elseif is_initialized then
						-- Apply changes to children only
					ev_apply_new_size (x_position, y_position,
							child_cell.width, rh.max (value), True)
				end
			end
		end

	ev_set_minimum_size (a_width, a_height: INTEGER; a_is_size_forced: BOOLEAN)
			-- Assign `mw' to minimum_width and `mh' to minimum_height.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			w_cd, h_cd, do_change: BOOLEAN
			mw, mh: INTEGER
			rw, rh: INTEGER
			p_imp: like parent_imp
			top_imp: like top_level_window_imp
		do
				-- Then, we properly set the values and propagate the
				-- change if necessary.
				-- The user didn't set the minimum_width nor the minimum_height.
			mw := child_cell.minimum_width
			mh := child_cell.minimum_height
 			w_cd := mw /= a_width
 			h_cd := mh /= a_height
			if w_cd or h_cd then
				internal_set_minimum_size (a_width, a_height)
				p_imp := parent_imp
				if p_imp /= Void and then (not is_in_notify.item or else is_notify_originator) then
					if w_cd then
						if h_cd then
							p_imp.notify_change (Nc_minsize, attached_interface.implementation, a_is_size_forced)
						else
							p_imp.notify_change (Nc_minwidth, attached_interface.implementation, a_is_size_forced)
						end
					else
						p_imp.notify_change (Nc_minheight, attached_interface.implementation, a_is_size_forced)
					end
					do_change := True
				end
			end
			top_imp := top_level_window_imp
			if
				not do_change and then
				(a_is_size_forced or (top_imp /= Void and then top_imp.is_displayed))
			then
				rw := child_cell.width
				rh := child_cell.height
				if a_width > rw or a_height > rh then
						-- Apply changes to current and children
					ev_move_and_resize (x_position, y_position,
							a_width.max (rw), a_height.max (rh), True)
				elseif is_initialized then
						-- Apply changes to children only
					ev_apply_new_size (x_position, y_position,
							rw.max (a_width), rh.max (a_height), True)
				end
			end
		end

	notify_change (type: INTEGER; child: detachable EV_ANY_I; a_is_size_forced: BOOLEAN)
			-- Notify the current widget that the change identify by
			-- type have been done. For types, see `internal_changes'
			-- in class EV_SIZEABLE_IMP. If the container is shown,
			-- we integrate the changes immediatly, otherwise, we postpone
			-- them.
			-- Use the constants defined in EV_SIZEABLE_IMP
		local
			p_imp: like parent_imp
			top_imp: detachable like top_level_window_imp
			t: detachable EV_SIZEABLE_CONTAINER_IMP
		do
			if not is_in_min_height and not is_in_min_width then
				if is_in_notify.item then
					t ?= child
					if t /= Void and then t.is_notify_originator then
							-- `notify_change' call has finished its work on descendants,
							-- we go up to parents.
						is_in_notify.put (False)
					end
				end
				if not is_in_notify.item then
					is_notify_originator := True
					is_in_notify.put (True)
					top_imp := top_level_window_imp
					if (a_is_size_forced or (top_imp /= Void and then top_imp.is_displayed)) then
						inspect type
						when Nc_minwidth then
							set_minwidth_recomputation_needed (False)
							compute_minimum_width (a_is_size_forced)
						when Nc_minheight then
							set_minheight_recomputation_needed (False)
							compute_minimum_height (a_is_size_forced)
						when Nc_minsize then
							set_minwidth_recomputation_needed (False)
							set_minheight_recomputation_needed (False)
							compute_minimum_size (a_is_size_forced)
						end
					else
						inspect type
						when Nc_minwidth then
							set_minwidth_recomputation_needed (True)
						when Nc_minheight then
							set_minheight_recomputation_needed (True)
						when Nc_minsize then
							set_minwidth_recomputation_needed (True)
							set_minheight_recomputation_needed (True)
						end
						if top_imp = Void or else not top_imp.is_displayed then
							p_imp := parent_imp
							if p_imp /= Void then
								p_imp.notify_change (type, attached_interface.implementation, a_is_size_forced)
							end
						end
					end
					is_notify_originator := False
					is_in_notify.put (False)
				end
			end
		end

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top window of Current.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	compute_minimum_width, compute_minimum_height, compute_minimum_size (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum_width of the object.
			-- Should call only ev_set_minimum_xxxx.
			-- If `a_is_size_forced' then force an actual computation of the real size too.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_CONTAINER_SIZEABLE_IMP











