indexing
	description: "EiffelVision multi-column list row, mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I

	EV_EVENT_HANDLER_IMP
		export
			{EV_MULTI_COLUMN_LIST_IMP} execute_command
		end

	EV_ITEM_EVENTS_CONSTANTS_IMP

	WEL_LIST_VIEW_ITEM
		rename
			set_text as wel_set_text,
			make as wel_make
		end

creation
	make

feature -- Initialization

	make (par: EV_MULTI_COLUMN_LIST) is
			-- Create an empty row
		do
			parent_imp ?= par.implementation
			wel_make
			initialize_list (item_command_count)
		end

feature -- Access

	parent_imp: EV_MULTI_COLUMN_LIST_IMP
			-- List implementation that contain this row

	parent: EV_MULTI_COLUMN_LIST is
			-- List that container this row
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
			else
				Result := Void
			end
		end

	columns: INTEGER is
			-- Number of columns in the row
		do
			Result := parent_imp.columns
		end

feature -- Status report
	
	destroyed: BOOLEAN is
			-- Is Current row destroyed?  
		do
			check
				not_yet_implemented: False
			end
		end

	is_selected: BOOLEAN is
			-- Is the item selected
		do
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			check
				not_yet_implemented: False
			end
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
		end

feature -- Element Change

	set_cell_text (column: INTEGER; a_text: STRING) is
			-- Make `text ' the new label of the `column'-th
			-- cell of the row.
		do
			parent_imp.set_cell_text (column - 1, iitem, a_text)
		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Make `cmd' the executed command when the item is 
			-- activated.
		do
			add_command (Cmd_item_activate, cmd, arg)			
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Make `cmd' the executed command when the item is
			-- unactivated.
		do
			add_command (Cmd_item_deactivate, cmd, arg)		
		end

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

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
