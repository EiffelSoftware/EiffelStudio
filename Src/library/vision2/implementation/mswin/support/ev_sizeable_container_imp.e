indexing
	description:
		" A class for MS-Windows to simulate the resizing of%
		% a container";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

deferred class
	EV_SIZEABLE_CONTAINER_IMP

inherit
	EV_SIZEABLE_IMP
		redefine
			internal_set_minimum_width,
			internal_set_minimum_height,
			internal_set_minimum_size,
			internal_resize,
			minimum_width,
			minimum_height
		end

feature -- Access

	minimum_width: INTEGER is
			-- Minimum width of the window.
			-- We recompute it if necessary.
		do
			if bit_set (internal_changes, 1) then
				if bit_set (internal_changes, 2) then
					compute_minimum_size
					internal_changes := set_bit (internal_changes, 2, False)
				else
					compute_minimum_width
				end
				internal_changes := set_bit (internal_changes, 1, False)
			end
			Result := internal_minimum_width
		end

	minimum_height: INTEGER is
			-- Minimum height of the window.
			-- We recompute it if necessary.
		do
			if bit_set (internal_changes, 2) then
				if bit_set (internal_changes, 1) then
					compute_minimum_size
					internal_changes := set_bit (internal_changes, 1, False)
				else
					compute_minimum_height
				end
				internal_changes := set_bit (internal_changes, 2, False)
			end
			Result := internal_minimum_height
		end

feature -- Basic operations

	internal_set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			changed: BOOLEAN
		do
			if not bit_set (internal_changes, 4) then
				changed := internal_minimum_width /= value
				internal_minimum_width := value
				if not bit_set (internal_changes, 1) then
					-- If this bit is set, it means the widget
					-- doesn't know its minimum size, then nothing need to
					-- be done because the parent must be already awared of it.
					if managed then 
						if changed and parent_imp /= Void then
							parent_imp.notify_change (1)
						elseif displayed then 
							move_and_resize (x, y, width, height, True)
						end
					else
						move_and_resize (x, y, width.max (value), height, True)
					end
				end
			elseif displayed then
				move_and_resize (x, y, width, height, True)
			end
		end

	internal_set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			changed: BOOLEAN
		do
			if not bit_set (internal_changes, 8) then
				changed := internal_minimum_height /= value
				internal_minimum_height := value
				if not bit_set (internal_changes, 2) then
					-- If this bit is set, it means the widget
					-- doesn't know its minimum size, then nothing need to
					-- be done because the parent must be already awared of it.
					if managed then 
						if changed and parent_imp /= Void then
							parent_imp.notify_change (2)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					else
						move_and_resize (x, y, value, height.max (value), True)
					end
				end
			elseif displayed then
				move_and_resize (x, y, width, height, True)
			end
		end

	internal_set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			w_cd, h_cd: BOOLEAN
			w_ok, h_ok: BOOLEAN
			w_ns, h_ns: BOOLEAN
		do
			w_ok := not bit_set (internal_changes, 4)
			h_ok := not bit_set (internal_changes, 8)

			if w_ok and h_ok then
				w_cd := internal_minimum_width /= mw
				h_cd := internal_minimum_height /= mh
				internal_minimum_width := mw
				internal_minimum_height := mh
				w_ns := not bit_set (internal_changes, 1)
				h_ns := not bit_set (internal_changes, 2)
				if w_ns and h_ns then
					if managed then
						if parent_imp /= Void then
							if w_cd and h_cd then
								parent_imp.notify_change (3)
							elseif w_cd then
								parent_imp.notify_change (1)
							elseif h_cd then
								parent_imp.notify_change (2)
							else
								move_and_resize (x, y, width, height, True)
							end
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					else
						move_and_resize (x, y, width.max (mw), height.max (mh), True)
					end
				end

			elseif w_ok then
				w_cd := internal_minimum_width /= mw
				internal_minimum_width := mw
				if not bit_set (internal_changes, 1) then 
					-- If this bit is set, it means the widget
					-- doesn't know its minimum size, then nothing need to
					-- be done because the parent must be already awared of it.
					if managed then
						if w_cd and parent_imp /= Void then
							parent_imp.notify_change (1)
						elseif displayed then 
							move_and_resize (x, y, width, height, True)
						end
					else
						move_and_resize (x, y, width.max (mw), height, True)
					end
				end

			elseif h_ok then
				h_cd := internal_minimum_height /= mh
				internal_minimum_height := mh
				if not bit_set (internal_changes, 2) then 
					-- If this bit is set, it means the widget
					-- doesn't know its minimum size, then nothing need to
					-- be done because the parent must be already awared of it.
					if managed then
						if h_cd and parent_imp /= Void then
							parent_imp.notify_change (2)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					else
						move_and_resize (x, y, width, height.max (mh), True)
					end
				end

			elseif displayed then
				move_and_resize (x, y, width, height, True)
			end
		end

	notify_change (type: INTEGER) is
			-- Notify the current widget that the change identify by
			-- type have been done. For types, see `internal_changes'
			-- in class EV_SIZEABLE_IMP. If the container is shown, 
			-- we integrate the changes immediatly, otherwise, we postpone
			-- them.
		local
			mw, mh: INTEGER
		do
			inspect type
			when 1 then
				if displayed then
					compute_minimum_width
				elseif not bit_set (internal_changes, 1) then
					internal_changes := set_bit (internal_changes, 1, True)
					if parent_imp /= Void then
						parent_imp.notify_change (1)
					end
				end
			when 2 then
				if displayed then
					compute_minimum_height
				elseif not bit_set (internal_changes, 2) then
					internal_changes := set_bit (internal_changes, 2, True)
					if parent_imp /= Void then
						parent_imp.notify_change (2)
					end
				end
			when 3 then
				if displayed then
					compute_minimum_size
				elseif not (bit_set (internal_changes, 1) and bit_set (internal_changes, 2)) then
					internal_changes := set_bit (internal_changes, 1, True)
					internal_changes := set_bit (internal_changes, 2, True)
					if parent_imp /= Void then
						parent_imp.notify_change (3)
					end
				end
			end
		end

	internal_resize (a_x, a_y, a_width, a_height: INTEGER) is
			-- A function sometimes used (notebook) that update
			-- and resize the current widget.
		do
			inspect internal_changes
			when 1 then
				compute_minimum_width
			when 2 then
				compute_minimum_height
			when 3 then
				compute_minimum_size
			else
			end
			move_and_resize (a_x, a_y, a_width, a_height, True)
		end

	compute_minimum_width, compute_minimum_height, compute_minimum_size is
			-- Recompute the minimum_width of the object.
			-- Should call only set_internal_minimum_width.
		do
			if displayed then
				move_and_resize (x, y, width, height, True)
			end
		end

feature -- Deferred

	displayed: BOOLEAN is
			-- Is the window displayed on the screen?
			-- ie : is parent and current widget shown.
		deferred
		end

end -- class EV_CONTAINER_SIZEABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
