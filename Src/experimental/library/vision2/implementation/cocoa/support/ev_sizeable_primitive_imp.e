note
	description: "Summary description for {EV_SIZEABLE_PRIMITIVE_IMP}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SIZEABLE_PRIMITIVE_IMP

inherit
	EV_SIZEABLE_IMP

feature -- Measurement

	internal_set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			w_cd, h_cd: BOOLEAN
			p_imp: like parent_imp
		do
			w_cd := minimum_width /= a_minimum_width
			h_cd := minimum_height /= a_minimum_height
			if not is_user_min_height_set then
				internal_minimum_height := a_minimum_height
			end
			if not is_user_min_width_set then
				internal_minimum_width := a_minimum_width
			end
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

	internal_set_minimum_height (a_minimum_height: INTEGER)
			-- Make `a_minimum_height' the new `minimum_height' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		do
			if minimum_height /= a_minimum_height then
				if not is_user_min_height_set then
					internal_minimum_height := a_minimum_height
				end
				if attached parent_imp as l_parent_imp then
					l_parent_imp.notify_change (Nc_minheight, Current)
				end
			end
		end

	internal_set_minimum_width (a_minimum_width: INTEGER)
			-- Abstracted implementation for minimum size setting.
		do
			if minimum_width /= a_minimum_width then
				if not is_user_min_width_set then
					internal_minimum_width := a_minimum_width
				end
				if attached parent_imp as l_parent_imp then
					l_parent_imp.notify_change (Nc_minwidth, Current)
				end
			end
		end

end
