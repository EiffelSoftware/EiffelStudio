indexing
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	INFO_D_IMP

inherit
	MESSAGE_D_IMP
		redefine
			icon,
			class_name
		end

	INFO_D_I
		rename
			forbid_recompute_size as forbid_resize,
			allow_recompute_size as allow_resize
		end

creation
	make

feature {NONE} -- Implementation

	icon: WEL_ICON is
			-- The windows standard info icon
		once
			!! Result.make_by_predefined_id (Idi_asterisk)
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionInfoDialog"
		end

end -- class INFO_D_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

