indexing
	description: 
		"MAIN_WINDOW class of the test_all_widget example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MAIN_WINDOW

inherit
	EV_WINDOW
		redefine	
			make_top_level
		end
	
	EV_COMMAND
	
	EXECUTION_ENVIRONMENT

creation
	make_top_level

feature --Access
	
	container: EV_DYNAMIC_TABLE
	
	current_demo_window: DEMO_WINDOW

feature -- Initialization
	
	make_top_level is
			-- Create the main window and the demo windows.
		local
			b: MAIN_WINDOW_BUTTON
			c1: LABEL_DEMO_WINDOW
			c2: FIXED_DEMO_WINDOW
			c3: BOX_DEMO_WINDOW
			c4: NOTEBOOK_DEMO_WINDOW
			c5: TEXT_FIELD_DEMO_WINDOW
			c6: TEXT_AREA_DEMO_WINDOW
			c7: MENU_DEMO_WINDOW
			c8: SPLIT_AREA_DEMO_WINDOW
			c9: SCROLLABLE_AREA_DEMO_WINDOW
			c10: BUTTONS_DEMO_WINDOW
			c11: LIST_DEMO_WINDOW
			c12: TABLE_DEMO_WINDOW
			c13: DYNAMIC_TABLE_DEMO_WINDOW
			c14: TREE_DEMO_WINDOW
			c15: MC_LIST_DEMO_WINDOW
			c16: DIALOG_DEMO_WINDOW
			c18: COMBO_DEMO_WINDOW
			c19: STATUS_DEMO_WINDOW
		do
			{EV_WINDOW} Precursor
			!!container.make (Current)
			container.set_finite_dimension (3)
			container.set_row_layout
			!!c1.make (Current)
			!!c2.make (Current)
			!!c3.make (Current)
			!!c4.make (Current)
			!!c5.make (Current)
			!!c6.make (Current)
			!!c7.make (Current)
			!!c8.make (Current)
			!!c9.make (Current)
			!!c10.make (Current)
			!!c11.make (Current)
			!!c12.make (Current)		
			!!c13.make (Current)
			!!c14.make (Current)
			!!c15.make (Current)
			!!c16.make (Current)
			!!c18.make (Current)
			!!c19.make (Current)
			
			!!b.make_button (Current, "Label", "", c1)
			!!b.make_button (Current, "Buttons", pixname("buttons"), c10)
			!!b.make_button (Current, "Fixed", "", c2) -- pixname("fixed")
			!!b.make_button (Current, "Box", pixname("box"), c3) 
			!!b.make_button (Current, "Notebook", pixname("notebook"), c4) 
			!!b.make_button (Current, "Text field", pixname("text_field"), c5)  
			!!b.make_button (Current, "Text area", pixname("text_area"), c6)
 			!!b.make_button (Current, "Menu", pixname("menu"), c7) 
			!!b.make_button (Current, "Split area", pixname("split_area"), c8)
			!!b.make_button (Current, "Scrollable area", pixname("scrollable_area"), c9)
			!!b.make_button (Current, "List", "", c11)
			!!b.make_button (Current, "Table", "", c12)  --pixname("table")
			!!b.make_button (Current, "Dynamic Table", "", c13) -- pixname("dtable")
			!!b.make_button (Current, "Tree", "", c14)  --pixname("tree")
			!!b.make_button (Current, "MC List", "", c15)
			!!b.make_button (Current, "Dialog", "", c16)
			!!b.make_button (Current, "Combo box", "", c18)
			!!b.make_button (Current, "Status Bar", "", c19)

			set_values
		end

feature -- Command execution
	
	execute (arg: EV_ARGUMENT1[DEMO_WINDOW]; data: EV_EVENT_DATA) is
			-- called when actions window is deleted.
		do
 			arg.first.effective_button.set_state (False)
			if arg.first.actions_window /= Void and then not arg.first.actions_window.destroyed then
				arg.first.actions_window.destroy
			end
			arg.first.hide
			set_insensitive (False)
		end
		
feature -- Status setting
	
	set_values is
			-- Set the values on the widgets
		do
			set_title ("Test all widgets")
		end

feature -- Basic operation

	pixname (a_name: STRING): STRING is
			-- Return the complete path of the given pixmap : root/../pixmaps/name
		do
--			Result := get ("$ISE_EIFFEL")
			Result := "d:\Eiffel43"
			Result.append ("\examples\vision2\test_all_widgets\pixmaps\")
			Result.append (a_name)
			Result.append (".bmp")
		end

end -- class MAIN_WINDOW

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
