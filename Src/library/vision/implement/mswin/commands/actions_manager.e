indexing
	description: "Manager of actions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class

	ACTIONS_MANAGER

inherit
	ACTIONS_MANAGER_CONTROLLER_WINDOWS

create

	make

feature {NONE} -- Initialization

	make is
			-- Create the table
		do
			create  widget_actions_table.make (1)
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
				create wa.make (widget)
				widget_actions_table.put (wa, widget)
			end
			create action.make (c, arg)
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

	widget_actions_table: HASH_TABLE [WIDGET_ACTIONS, WIDGET_IMP];
			-- Table of Widget actions for a Widget

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




end -- class ACTIONS_MANAGER

