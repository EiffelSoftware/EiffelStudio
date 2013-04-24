note
	description: "Summary description for {EV_SIZABLE_CONTAINER_IMP}."
	author: ""
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
			minimum_height
		end

feature {NONE} -- Initialization

	initialize_sizeable
			-- Initialize sizing attributes of `Current'.
		do
			is_minwidth_recomputation_needed := True
			is_minheight_recomputation_needed := True
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

feature -- Access

	minimum_width: INTEGER
			-- Lower bound on `width' in pixels.
		do
			if is_minwidth_recomputation_needed then
				is_minwidth_recomputation_needed := False
				is_in_min_width := True
				if is_minheight_recomputation_needed then
					is_minheight_recomputation_needed := False
					compute_minimum_size
				else
					compute_minimum_width
				end
				is_in_min_height := False
				is_in_min_width := False
			end
			Result := internal_minimum_width
		end

	minimum_height: INTEGER
			-- Lower bound on `height' in pixels.
		do
			if is_minheight_recomputation_needed then
				is_minheight_recomputation_needed := False
				is_in_min_height := True
				if is_minwidth_recomputation_needed then
					is_minheight_recomputation_needed := False
					is_in_min_width := True
					compute_minimum_size
				else
					compute_minimum_height
				end
				is_in_min_height := False
				is_in_min_width := False
			end
			Result := internal_minimum_height
		end

feature -- Basic Operations


	internal_set_minimum_width (a_min_width: INTEGER)
			-- Assign `value' to `minimum_width'.
			-- Should check if the user didn't set the minimum width
			-- before we set the new value.
		local
			p_imp: like parent_imp
			do_change: BOOLEAN
			top_imp: like top_level_window_imp
		do
			if minimum_width /= a_min_width then
				if not is_user_min_width_set then
					internal_minimum_width := a_min_width
				end
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
				if a_min_width > width then
					ev_move_and_resize (x_position, y_position, a_min_width, height, True)
				elseif is_initialized then
						-- Apply changes to descendant only
					ev_apply_new_size (x_position, y_position, width.max (a_min_width), height, True)
				end
			end
		end

	internal_set_minimum_height (a_min_height: INTEGER)
			-- Assign `value' to `minimum_height'.
			-- Should check if the user didn't set the minimum width
			-- before we set the new value.
		local
			p_imp: like parent_imp
			do_change: BOOLEAN
			top_imp: like top_level_window_imp
		do
			if minimum_height /= a_min_height then
				if not is_user_min_height_set then
					internal_minimum_height := a_min_height
				end
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
				if a_min_height > height then
						-- Apply changes to current and descendant
					ev_move_and_resize (x_position, y_position, width, a_min_height, True)
				elseif is_initialized then
						-- Apply changes to descendant only
					ev_apply_new_size (x_position, y_position, width, height.max (a_min_height), True)
				end
			end
		end

	internal_set_minimum_size (a_min_width, a_min_height: INTEGER)
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
			mw := minimum_width
			mh := minimum_height
 			w_cd := mw /= a_min_width
 			h_cd := mh /= a_min_height
			if w_cd or h_cd then
				if not is_user_min_height_set then
					internal_minimum_height := a_min_height
				end
				if not is_user_min_width_set then
					internal_minimum_width := a_min_width
				end
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
				rw := width
				rh := height
				if a_min_width > rw or a_min_height > rh then
						-- Apply changes to current and descendant
					ev_move_and_resize (x_position, y_position, a_min_width.max (rw), a_min_height.max (rh), True)
				elseif is_initialized then
						-- Apply changes to descendant only
					ev_apply_new_size (x_position, y_position, rw.max (a_min_width), rh.max (a_min_height), True)
				end
			end
		end

	compute_minimum_width, compute_minimum_height, compute_minimum_size
			-- Recompute the minimum_width of the object.
			-- Should call only internal_set_minimum_xxxx.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top window of Current.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	notify_change (type: INTEGER; child: detachable EV_SIZEABLE_IMP)
			-- Notify the current widget that the change identify by
			-- type have been done. For types, see `internal_changes'
			-- in class EV_SIZEABLE_IMP. If the container is shown,
			-- we integrate the changes immediatly, otherwise, we postpone
			-- them.
			-- Use the constants defined in EV_SIZEABLE_IMP
		local
			p_imp: like parent_imp
			top_imp: like top_level_window_imp
		do
			if not is_in_min_height and not is_in_min_width then
				if is_in_notify.item then
					if attached {EV_SIZEABLE_CONTAINER_IMP} child as t and then t.is_notify_originator then
							-- `notify_change' call has finished its work on descendants,
							-- we go up to parents.
						is_in_notify.put (False)
					end
				end
				if not is_in_notify.item then
					is_notify_originator := True
					is_in_notify.put (True)
					top_imp := top_level_window_imp
					if top_imp /= Void and then top_imp.is_displayed then
						inspect type
						when Nc_minwidth then
							is_minwidth_recomputation_needed := False
							compute_minimum_width
						when Nc_minheight then
							is_minheight_recomputation_needed := False
							compute_minimum_height
						when Nc_minsize then
							is_minwidth_recomputation_needed := False
							is_minheight_recomputation_needed := False
							compute_minimum_size
						end
					else
						inspect type
						when Nc_minwidth then
							is_minwidth_recomputation_needed := True
						when Nc_minheight then
							is_minheight_recomputation_needed := True
						when Nc_minsize then
							is_minwidth_recomputation_needed := True
							is_minheight_recomputation_needed := True
						end
						p_imp := parent_imp
						if p_imp /= Void then
							p_imp.notify_change (type, Current)
						end
					end
					is_notify_originator := False
					is_in_notify.put (False)
				end
			end
		end

end
