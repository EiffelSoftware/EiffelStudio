indexing
	description: "Objects that provide access to constants for tip of the day."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TIPS

feature -- Access

	pick_and_drop_tip: STRING is "EiffelBuild uses pick and drop to transport information/data/objects.%NTo start a pick and drop right click on the desired source,%N and complete the transport by right clicking on a target.%NIf a deny cursor is displayed, the current target is not valid."
	
	discardable_dialogs: STRING is "Most warning/information dialogs in EiffelBuild may be supressed%N by checking the %"do not show again%" check box.%NThe default behaviour of these dialogs may be re-instated through%Nthe preferences dialog, available from the %"View%",%N%"Preferences%", %"Preferences..%"menu option."
	
	display_window: STRING is "The Display Window shows an accurate view of the window that is being%Ncreated and should be used to preview the interface.%N You may not build directly into the Display Window."

	shift_right_click_tip: STRING is "To insert an object at a paticular index within a container,%Nhold the shift key while dropping on a child of the container.%NThe object will be inserted at the index preceeding the child."
	
	color_pick_and_drop_tip: STRING is "To copy the foreground or background color of an object, %Npick the representation of the color from the%N object editor, and drop to the representation in another editor.%N The transported color will be assigned to the object."
	
	all_tips: ARRAYED_LIST [STRING] is
			-- All tips avaialable from `Current'.
		once
			create Result.make (5)
			Result.extend (pick_and_drop_tip)
			Result.extend (discardable_dialogs)
			Result.extend (display_window)
			Result.extend (shift_right_click_tip)
			Result.extend (color_pick_and_drop_tip)
		end
	
	tip_count: INTEGER is
			-- `Result' is total number of tips in system.
		once
			Result := all_tips.count	
		end
		
invariant
	all_tips_not_void: all_tips /= Void

end -- class GB_TIPS
