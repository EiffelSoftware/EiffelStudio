indexing
	description: "Manager of actions"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
class

	ACTIONS_MANAGER

inherit
	ACTIONS_MANAGER_CONTROLLER_WINDOWS

creation

	make

feature {NONE} -- Initialization

	make is
			-- Create the table
		do
			!!  widget_actions_table.make (1)
			actions_manager_list.extend (Current)
		end


feature -- Element change

	add (widget: WIDGET_IMP; c: COMMAND; arg: ANY) is
		local
			action: ACTION_WINDOWS
			wa: WIDGET_ACTIONS
		do
			widget.set_hash_code
			wa := widget_actions (widget)
			if wa = Void then
				!! wa.make (widget)
				widget_actions_table.put (wa, widget)
			end
			!! action.make (c, arg)
			wa.put (action)
		end

feature -- Removal

	delete (widget: WIDGET_IMP) is
			-- Delete all actions for `widget'
		do
			if widget_actions_table.has (widget) then
				widget_actions_table.remove (widget)
			end
		end

	remove (widget: WIDGET_IMP; c: COMMAND; arg: ANY) is
		local
			e: WIDGET_ACTIONS
		do
			e := widget_actions (widget)
			if e /= Void then
				e.remove (c, arg)
			end
		end

feature -- Basic operations

	execute (w: WIDGET_IMP; context_data: CONTEXT_DATA) is
			-- Execute the actions on widget with `context_data'
		local
			wa: WIDGET_ACTIONS
		do
			wa := widget_actions (w)
			if wa /= Void then
				wa.execute (context_data)
			end
		end

feature -- Implementation

	widget_actions (widget: WIDGET_IMP): WIDGET_ACTIONS is
			-- Actions for `widget'
		do
			Result := widget_actions_table.item (widget)
		end

	widget_actions_table: HASH_TABLE [WIDGET_ACTIONS, WIDGET_IMP]
			-- Table of Widget actions for a Widget

end -- class ACTIONS_MANAGER


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

