indexing
	description:
		"Eiffel Vision sizeable primitive. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$" 
 
deferred class
	EV_SIZEABLE_PRIMITIVE_IMP

inherit
	EV_SIZEABLE_IMP

feature -- Access

	ev_set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			p_imp: like parent_imp
		do
			if minimum_width /= value then
				internal_set_minimum_width (value)
				p_imp := parent_imp
				if p_imp /= Void then
					p_imp.notify_change (Nc_minwidth, Current)
				end
			end
		end

	ev_set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			p_imp: like parent_imp
		do
			if minimum_height /= value then
				internal_set_minimum_height (value)
				p_imp := parent_imp
				if p_imp /= Void then
					p_imp.notify_change (Nc_minheight, Current)
				end
			end
		end

	ev_set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			w_cd, h_cd: BOOLEAN
			p_imp: like parent_imp
		do
			w_cd := minimum_width /= mw
			h_cd := minimum_height /= mh
			internal_set_minimum_size (mw, mh)
			p_imp := parent_imp
			if p_imp /= Void then
				if w_cd and h_cd then
					p_imp.notify_change (Nc_minsize, Current)
				elseif w_cd then
					p_imp.notify_change (Nc_minwidth, Current)
				elseif h_cd then
					p_imp.notify_change (Nc_minheight, Current)
				end
			end
		end

end -- EV_SIZEABLE_PRIMITIVE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

