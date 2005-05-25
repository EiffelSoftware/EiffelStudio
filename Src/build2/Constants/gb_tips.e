indexing
	description: "Objects that provide access to constants for tip of the day."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TIPS

feature -- Access

	pick_and_drop_tip: STRING is "EiffelBuild uses pick and drop to transport information/data/objects.%NTo start a pick and drop right click on the desired source,%Nand complete the transport by right clicking on a target.%NIf a deny cursor is displayed, the current target is not valid."
	
	discardable_dialogs: STRING is "Most warning/information dialogs in EiffelBuild may be supressed%Nby checking the %"do not show again%" check box.%NThe default behaviour of these dialogs may be re-instated through%Nthe preferences dialog, available from the %"View%",%N%"Preferences%", %"Preferences..%" menu option."
	
	display_window: STRING is "The Display Window shows an accurate view of the window that is being%Ncreated and should be used to preview the interface.%NYou may not build directly into the Display Window."

	shift_right_click_tip: STRING is "To insert an object at a particular index within a container,%Nhold the shift key while dropping on a child of the container.%NThe object will be inserted at the index preceeding the child."
	
	color_pick_and_drop_tip: STRING is "To copy the foreground or background color of an object, %Npick the representation of the color from the%Nobject editor, and drop to the representation in another editor.%NThe transported color will be assigned to the object."
	
	object_editor_tip: STRING is "Hold down Ctrl while right clicking on an object to display%Na floating object editor targeted to that object."
	
	name_is_generated_code_tip: STRING is "The name given to an object is used as the%Nfeature name of that object in the generated code."
	
	builder_window_ctrl_shift: STRING is "Hold down Ctrl and Shift keys while right%Nclicking on an object in the Builder Window to highlight%Nthat object in the layout constructor."
	
	builder_window_build: STRING is "The Builder Window shows an approximation of the%Ninterface that is being constructed and permits%Ninteractive building."
	
	directory_addition: STRING is "Adding or removing directories via the Widget Selector%Ncreates or removes these directories from the disk immediately."
	
	changing_type: STRING is "You may change the type of an object by picking it,%Nand dropping it on the type you wish to change it to in%Nthe Type Selector. Any objects contained will be re-parented into the new%Nobject. This may only occur if the new type matches, and supports%Ninsertion of all children."
	
	renaming_window: STRING is "Renaming a window or dialog that has already been generated,%Nmodifies the file and class names of the generated files on%Ndisk immediately."
	
	loading_constants: STRING is "Selecting %"Load constants from file%" within the project%Nsettings, ensures that constants are generated into a%Nfile, and loaded automatically when your generated system is executed.%NBy having different versions of this file, languages may be easily changed."
	
	importing: STRING is "You may import the contents of an existing .BPR%Nfile into your project, by selecting the 'File', 'Import Project...'%Ncommand, and selecting the existing project to be added."
	
	multiple_items: STRING is "While dropping from the Type Selector into%Nthe Layout Constructor, hold down one of the%Ndigit keys (1-9), to insert that many new objects."
	
	all_tips: ARRAYED_LIST [STRING] is
			-- All tips avaialable from `Current'.
		once
			create Result.make (5)
			Result.extend (pick_and_drop_tip)
			Result.extend (discardable_dialogs)
			Result.extend (display_window)
			Result.extend (shift_right_click_tip)
			Result.extend (object_editor_tip)
			Result.extend (builder_window_build)
			Result.extend (color_pick_and_drop_tip)
			Result.extend (name_is_generated_code_tip)
			Result.extend (builder_window_ctrl_shift)
			Result.extend (changing_type)
			Result.extend (renaming_window)
			Result.extend (directory_addition)
			Result.extend (loading_constants)
			Result.extend (importing)
			Result.extend (multiple_items)
		end
	
	tip_count: INTEGER is
			-- `Result' is total number of tips in system.
		once
			Result := all_tips.count	
		end
		
invariant
	all_tips_not_void: all_tips /= Void

end -- class GB_TIPS
