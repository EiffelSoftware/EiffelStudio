indexing
	description:
		"Eiffel Vision sizeable container. Mswindows implementation."
	status: "See notice at end of class"
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

	initialize_sizeable is
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

	is_in_notify: BOOLEAN_REF is
			-- Is current already notified from a change in its children?
		once
			create Result
		end

feature -- Status setting

	set_minwidth_recomputation_needed (flag: BOOLEAN) is
			-- Set `is_minwidth_recomputation_needed' with `flag'?
		do
			is_minwidth_recomputation_needed := flag
		end

	set_minheight_recomputation_needed (flag: BOOLEAN) is
			-- Set `is_minheight_recomputation_needed' with `flag'?
		do
			is_minheight_recomputation_needed := flag
		end

feature -- Access

	minimum_width: INTEGER is
			-- Lower bound on `width' in pixels.
		do
			if is_minwidth_recomputation_needed then
				set_minwidth_recomputation_needed (False)
				is_in_min_width := True
				if is_minheight_recomputation_needed then
					set_minheight_recomputation_needed (False)
					is_in_min_height := True
					compute_minimum_size
				else
					compute_minimum_width
				end
				is_in_min_height := False
				is_in_min_width := False
			end
			Result := child_cell.minimum_width
		end

	minimum_height: INTEGER is
			-- Lower bound on `height' in pixels.
		do
			if is_minheight_recomputation_needed then
				set_minheight_recomputation_needed (False)
				is_in_min_height := True
				if is_minwidth_recomputation_needed then
					set_minwidth_recomputation_needed (False)
					is_in_min_width := True
					compute_minimum_size
				else
					compute_minimum_height
				end
				is_in_min_height := False
				is_in_min_width := False
			end
			Result := child_cell.minimum_height
		end

feature -- Basic operations

	ev_set_minimum_width (value: INTEGER) is
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
					p_imp.notify_change (Nc_minwidth, Current)
					do_change := True
				end
			end
			top_imp := top_level_window_imp
			if
				not do_change and then
				top_imp /= Void and then top_imp.is_displayed
			then
					-- Current width
				rw := child_cell.width
				if value > rw then
					ev_move_and_resize (x_position, y_position,
							value, child_cell.height, True)
				elseif is_initialized then
						-- Apply changes to descendant only
					ev_apply_new_size (x_position, y_position,
							rw.max (value), child_cell.height, True)
				end
			end
		end

	ev_set_minimum_height (value: INTEGER) is
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
					p_imp.notify_change (Nc_minheight, Current)
					do_change := True
				end
			end
			top_imp := top_level_window_imp
			if
				not do_change and then
				top_imp /= Void and then top_imp.is_displayed
			then
				rh := child_cell.height
				if value > rh then
						-- Apply changes to current and descendant
					ev_move_and_resize (x_position, y_position,
							child_cell.width, value, True)
				elseif is_initialized then
						-- Apply changes to descendant only
					ev_apply_new_size (x_position, y_position,
							child_cell.width, rh.max (value), True)
				end
			end
		end

	ev_set_minimum_size (a_width, a_height: INTEGER) is
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
							p_imp.notify_change (Nc_minsize, Current)
						else
							p_imp.notify_change (Nc_minwidth, Current)
						end
					else
						p_imp.notify_change (Nc_minheight, Current)
					end
					do_change := True
				end
			end
			top_imp := top_level_window_imp
			if
				not do_change and then
				top_imp /= Void and then top_imp.is_displayed
			then
				rw := child_cell.width
				rh := child_cell.height
				if a_width > rw or a_height > rh then
						-- Apply changes to current and descendant
					ev_move_and_resize (x_position, y_position,
							a_width.max (rw), a_height.max (rh), True)
				elseif is_initialized then
						-- Apply changes to descendant only
					ev_apply_new_size (x_position, y_position,
							rw.max (a_width), rh.max (a_height), True)
				end
			end
		end

	notify_change (type: INTEGER; child: EV_SIZEABLE_IMP) is
			-- Notify the current widget that the change identify by
			-- type have been done. For types, see `internal_changes'
			-- in class EV_SIZEABLE_IMP. If the container is shown, 
			-- we integrate the changes immediatly, otherwise, we postpone
			-- them.
			-- Use the constants defined in EV_SIZEABLE_IMP
		local
			p_imp: like parent_imp
			top_imp: like top_level_window_imp
			t: EV_SIZEABLE_CONTAINER_IMP
		do
			if not is_in_min_height and not is_in_min_width then
			if is_in_notify.item then
				t ?= child
				if t /= Void and then t.is_notify_originator then
						-- `notify_change' call has finished its work on descendants,
						-- we go up to parents.
					is_in_notify.set_item (False)
				end
			end
			if not is_in_notify.item then
				is_notify_originator := True
				is_in_notify.set_item (True)
				top_imp := top_level_window_imp
				if top_imp /= Void and then top_imp.is_displayed then
					inspect type
					when Nc_minwidth then
						set_minwidth_recomputation_needed (False)
						compute_minimum_width
					when Nc_minheight then
						set_minheight_recomputation_needed (False)
						compute_minimum_height
					when Nc_minsize then
						set_minwidth_recomputation_needed (False)
						set_minheight_recomputation_needed (False)
						compute_minimum_size
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
					p_imp := parent_imp
					if p_imp /= Void then
						p_imp.notify_change (type, Current)
					end
				end
				is_notify_originator := False
				is_in_notify.set_item (False)
			end
			end
		end

	top_level_window_imp: EV_WINDOW_IMP is
			-- Top window of Current.
		deferred
		end

	compute_minimum_width, compute_minimum_height, compute_minimum_size is
			-- Recompute the minimum_width of the object.
			-- Should call only ev_set_minimum_xxxx.
		deferred
		end

end -- class EV_CONTAINER_SIZEABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

