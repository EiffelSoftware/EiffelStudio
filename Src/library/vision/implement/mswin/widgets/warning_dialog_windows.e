indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WARNING_DIALOG_WINDOWS

inherit
	MESSAGE_DIALOG_WINDOWS
		redefine
			icon,
			class_name
		end

	WARNING_D_I
		rename
			forbid_recompute_size as forbid_resize,
			allow_recompute_size as allow_resize
		end

creation
	make

feature {NONE} -- Implementation

	icon: WEL_ICON is
			-- The windows standard warning icon
		once
			!! Result.make_by_predefined_id (Idi_exclamation)
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionWarningDialog"
		end

end -- WARNING_DIALOG_WINDOWS

--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software 
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
