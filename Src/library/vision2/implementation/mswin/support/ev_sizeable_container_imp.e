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
				if managed then
					if changed then
						if not bit_set (internal_changes, 1) and parent_imp /= Void then
							parent_imp.notify_change (1)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					elseif displayed then
						move_and_resize (x, y, width, height, True)
					end
				else
					move_and_resize (x, y, width.max (value), height, True)
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
				if managed then
					if changed then
						if not bit_set (internal_changes, 2) and parent_imp /= Void then
							parent_imp.notify_change (2)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					elseif displayed then
						move_and_resize (x, y, width, height, True)
					end
				else
					move_and_resize (x, y, width, height.max (value), True)
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
		do
			-- First, we set some local variable
 			w_ok := not bit_set (internal_changes, 4)
 			h_ok := not bit_set (internal_changes, 8)
 
			-- We check that we are in a coherent status.
			check
				-- If we come here, both of the bits are necessarily set
				-- therefore, we chack only one.
				same_value: bit_set (internal_changes, 1) = bit_set (internal_changes, 2)
			end

			-- Then, we properly set the values and propagate the
			-- change if necessary.
			-- The user didn't set the minimum_width nor the minimum_height.
 			if w_ok and h_ok then
 				w_cd := internal_minimum_width /= mw
 				h_cd := internal_minimum_height /= mh
 				internal_minimum_width := mw
 				internal_minimum_height := mh
 				if managed then
					if w_cd and h_cd then
						if not bit_set (internal_changes, 1) and parent_imp /= Void then
							parent_imp.notify_change (3)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					elseif w_cd then
						if not bit_set (internal_changes, 1) and parent_imp /= Void then
							parent_imp.notify_change (1)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					elseif h_cd then
						if not bit_set (internal_changes, 1) and parent_imp /= Void then
							parent_imp.notify_change (2)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					elseif displayed then
						move_and_resize (x, y, width, height, True)
					end
				else
					move_and_resize (x, y, width.max (mw), height.max (mh), True)
				end

			-- The user did set the minimum_height already.
			elseif w_ok then
				w_cd := internal_minimum_width /= mw
				internal_minimum_width := mw
				if managed then
					if w_cd then
						if not bit_set (internal_changes, 1) and parent_imp /= Void then
							parent_imp.notify_change (1)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					elseif displayed then
						move_and_resize (x, y, width, height, True)
					end
				else
					move_and_resize (x, y, width.max (mw), height, True)
				end

			-- The user did set the minimum_height already.
			elseif h_ok then
				h_cd := internal_minimum_height /= mh
				internal_minimum_height := mh
				if managed then
					if h_cd then
						if not bit_set (internal_changes, 2) and parent_imp /= Void then
							parent_imp.notify_change (2)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					elseif displayed then
						move_and_resize (x, y, width, height, True)
					end
				else
					move_and_resize (x, y, width, height.max (mh), True)
				end

			-- The user did set everything already.
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
				if not bit_set (internal_changes, 1) then
					internal_changes := set_bit (internal_changes, 1, True)
					if displayed then
						compute_minimum_width
						internal_changes := set_bit (internal_changes, 1, False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (1)
						end
					end
				end
			when 2 then
				if not bit_set (internal_changes, 2) then
					internal_changes := set_bit (internal_changes, 2, True)
					if displayed then
						compute_minimum_height
						internal_changes := set_bit (internal_changes, 2, False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (2)
						end
					end
				end
			when 3 then
				if not (bit_set (internal_changes, 1) and bit_set (internal_changes, 2)) then
					internal_changes := set_bit (internal_changes, 1, True)
					internal_changes := set_bit (internal_changes, 2, True)
					if displayed then
						compute_minimum_size
						internal_changes := set_bit (internal_changes, 1, False)
						internal_changes := set_bit (internal_changes, 2, False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (3)
						end
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
