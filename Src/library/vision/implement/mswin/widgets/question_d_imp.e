indexing
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	QUESTION_D_IMP

inherit
	MESSAGE_D_IMP
		redefine
			icon,
			class_name
		end

	QUESTION_D_I
		rename
			forbid_recompute_size as forbid_resize,
			allow_recompute_size as allow_resize
		end

create
	make

feature {NONE} -- Implementation

	icon: WEL_ICON is
			-- The windows standard question icon
		once
			create Result.make_by_predefined_id (Idi_question)
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionQuestionDialog"
		end
 
end -- class QUESTION_D_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

