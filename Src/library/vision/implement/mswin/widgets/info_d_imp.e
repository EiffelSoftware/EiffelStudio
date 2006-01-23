indexing
	status: "See notice at end of class.";
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

create
	make

feature {NONE} -- Implementation

	icon: WEL_ICON is
			-- The windows standard info icon
		once
			create Result.make_by_predefined_id (Idi_asterisk)
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionInfoDialog"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class INFO_D_IMP

