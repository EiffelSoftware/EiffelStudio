indexing
	description: "Widget destroy event."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class DESTROY_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.destroy_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.destroy_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.destroy_label
		end

	eiffel_text: STRING is "add_destroy_command ("

--	specific_add (a_widget: EV_WIDGET; a_command: EV_COMMAND) is
--			-- Add the command represented by `a_cmd_instance' to 
--			-- `a_context' according to the kind of event.
--		do
--			a_widget.add_destroy_action (a_command, Void)
--		end
--
--	specific_remove (a_widget: EV_WIDGET; a_command: EV_COMMAND) is
--			-- Remove `a_command' from `a_widget' according to the
--			-- kind of event.
--		do
--			a_widget.remove_destroy_action (a_command, Void)
--		end

end -- class DESTROY_EV

