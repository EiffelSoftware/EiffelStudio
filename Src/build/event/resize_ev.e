indexing
	description: "Resize event."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class RESIZE_EV 

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.resize_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.resize_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.resize_label
		end

	eiffel_text: STRING is "add_resize_command ("

--	specific_add (a_widget: WIDGET; a_command: COMMAND) is
--			-- Add the command represented by `a_cmd_instance' to 
--			-- `a_context' according to the kind of event.
--		local
--			drawing_area_widget: DRAWING_AREA
--		do
--			drawing_area_widget ?= a_widget
--			if drawing_area_widget /= Void then
--				drawing_area_widget.add_resize_action (a_command, Void)
--			end
--		end
--
--	specific_remove (a_widget: WIDGET; a_command: COMMAND) is
--			-- Remove `a_command' from `a_widget' according to the
--			-- kind of event.
--		local
--			drawing_area_widget: DRAWING_AREA
--		do
--			drawing_area_widget ?= a_widget
--			if drawing_area_widget /= Void then
--				drawing_area_widget.remove_resize_action (a_command, Void)
--			end
--		end

end -- class RESIZE_EV

