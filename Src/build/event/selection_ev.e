indexing
	description: "List/Tree selection event."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class SELECTION_EV

inherit
	EVENT

creation
	make
	
feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.selection_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.selection_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.selection_label
		end

	eiffel_text: STRING is "add_selection_command ("

--	specific_add (a_widget: WIDGET; a_command: COMMAND) is
--			-- Add `a_command' to `a_widget' according to the 
--			-- kind of event.
--		local
--			scrollable_list_widget: SCROLLABLE_LIST
--		do
--			scrollable_list_widget ?= a_widget
--			if scrollable_list_widget /= Void then
--				scrollable_list_widget.add_selection_action (a_command, Void)
--			end
--		end
--
--	specific_remove (a_widget: WIDGET; a_command: COMMAND) is
--			-- Remove `a_command' from `a_widget' according to the
--			-- kind of event.
--		local
--			scrollable_list_widget: SCROLLABLE_LIST
--		do
--			scrollable_list_widget ?= a_widget
--			if scrollable_list_widget /= Void then
--				scrollable_list_widget.remove_selection_action (a_command, Void)
--			end
--		end

end -- class SELECTION_EV

