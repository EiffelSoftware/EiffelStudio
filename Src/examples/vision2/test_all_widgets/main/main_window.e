indexing

	description: 
	"MAIND_WINDOW, main window for the application. Belongs to EiffelVision example."
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
	

creation

	make_top_level

feature --Access
	
	container: EV_DYNAMIC_TABLE
	
	current_demo_window: DEMO_WINDOW
	
feature -- Initialization
	
	make_top_level is
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
		do
			Precursor
			!!container.make (Current)
			container.set_finite_dimension (2)
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
			!!b.make_button (Current, "Label", "", c1)
			!!b.make_button (Current, "Buttons", "pixmaps/buttons.xpm", c10)
			!!b.make_button (Current, "Fixed", "pixmaps/fixed.xpm", c2)
			!!b.make_button (Current, "Box", "pixmaps/box.xpm", c3)
			!!b.make_button (Current, "Notebook", "pixmaps/notebook.xpm", c4)
			!!b.make_button (Current, "Text field", "pixmaps/text_field.xpm", c5)
			!!b.make_button (Current, "Text area", "pixmaps/text_area.xpm", c6)
			!!b.make_button (Current, "Menu", "pixmaps/menu.xpm", c7)
			!!b.make_button (Current, "Split area", "pixmaps/split_area.xpm", c8)
			!!b.make_button (Current, "Scrollable area", "pixmaps/scrollable_area.xpm", c9)
			!!b.make_button (Current, "List", "", c11)
			!!b.make_button (Current, "Table", "pixmaps/table.xpm", c12)
			!!b.make_button (Current, "Dynamic Table", "pixmaps/dtable.xpm", c13)
			!!b.make_button (Current, "Tree", "pixmaps/tree.xpm", c14)

			set_values
		end
	
feature -- Status setting
	
	execute (arg: EV_ARGUMENT1[DEMO_WINDOW]) is
			-- called when actions window is deleted
		do
 			arg.first.effective_button.set_state (False)
			if arg.first.actions_window /= Void then
				arg.first.actions_window.destroy
			end
			arg.first.hide
			set_insensitive (False)
		end
		
feature -- Status setting
	
	set_values is
		do
			set_title ("Test all widgets")
		end

end
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
