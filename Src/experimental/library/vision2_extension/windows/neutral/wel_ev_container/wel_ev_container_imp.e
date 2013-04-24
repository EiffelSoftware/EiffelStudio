note
	description: "Objects that allow insertion of a Vision2 control%
		%within a WEL system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_EV_CONTAINER_IMP

inherit
	WEL_EV_CONTAINER_I
		redefine
			interface
		end

	EV_CELL_IMP
		redefine
			interface,
			notify_change,
			ev_set_minimum_size
		end

create
	make

feature {NONE} -- initialization

	set_real_parent (a_parent: WEL_WINDOW; x_pos, y_pos, a_width, a_height: INTEGER)
			-- Actually target `Current' to `a_parent' and set x_position to `x_pos',
			-- y_position to `y_pos', width to `a_width' and height to `a_height'.
			-- Create EV_APPLICATION if one has not been created.
		local
			temp_window: EV_WINDOW
			application: detachable EV_APPLICATION
		do
			-- We check EV_ENVIRONMENT to see if EV_APPLICATION exists.
			-- If it does not, then we must create an instance ourselves.
			application := (create {EV_ENVIRONMENT}).application
			if application = Void then
				create application
			end
			wel_set_parent (a_parent)
			wel_move_and_resize (x_pos, y_pos, a_width, a_height, True)
			child_cell.resize (a_width, a_height)

			create temp_window
			if attached {like top_level_window_imp} temp_window.implementation as l_impl then
				top_level_window_imp :=  l_impl
			else
				check has_top_level_window: False end
				top_level_window_imp := Void
			end
		end

feature {WEL_EV_CONTAINER_I}-- Access

	implementation_window: WEL_WINDOW
			-- Window containing `item'.
		do
			Result := Current
		end

feature {NONE} -- Implementation

	notify_change (type: INTEGER; child: detachable EV_ANY_I; a_is_size_forced: BOOLEAN)
			-- Notify the current widget that the change identify by
			-- type have been done. For types, see `internal_changes'
			-- in class EV_SIZEABLE_IMP. If the container is shown,
			-- we integrate the changes immediatly, otherwise, we postpone
			-- them.
			-- Use the constants defined in EV_SIZEABLE_IMP
		local
			p_imp: like parent_imp
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
					if attached wel_parent as l_wel_parent and then l_wel_parent.shown then
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
						p_imp := parent_imp
						if p_imp /= Void then
							p_imp.notify_change (type, Current, a_is_size_forced)
						end
					end
					is_notify_originator := False
					is_in_notify.put (False)
				end
			end
		end

	ev_set_minimum_size (a_width, a_height: INTEGER; a_is_size_forced: BOOLEAN)
			-- Assign `mw' to minimum_width and `mh' to minimum_height.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
			-- (from EV_SIZEABLE_CONTAINER_IMP)
		local
			w_cd, h_cd, do_change: BOOLEAN
			mw, mh: INTEGER
			rw, rh: INTEGER
			p_imp: like parent_imp
		do
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
							p_imp.notify_change (nc_minsize, Current, a_is_size_forced)
						else
							p_imp.notify_change (nc_minwidth, Current, a_is_size_forced)
						end
					else
						p_imp.notify_change (nc_minheight, Current, a_is_size_forced)
					end
					do_change := True
				end
			end
			if not do_change and then attached wel_parent as l_wel_parent and then l_wel_parent.shown then
				rw := child_cell.width
				rh := child_cell.height
				if a_width > rw or a_height > rh then
					ev_move_and_resize (x_position, y_position, a_width.max (rw), a_height.max (rh), True)
				elseif is_initialized then
					ev_apply_new_size (x_position, y_position, rw.max (a_width), rh.max (a_height), True)
				end
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable WEL_EV_CONTAINER note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
