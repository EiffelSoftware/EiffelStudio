indexing
	description: "Maintains the pick and drop mechanism %
				%and terminates it when the data is dropped."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_TRANSPORTER_IMP

inherit
	EV_PND_TRANSPORTER_I

feature {NONE} -- Implementation

	pointed_target: EV_PND_TARGET_I is
			-- Hole at mouse position
		local
			tg: EV_PND_TARGET_I
			widget_pointed: EV_WIDGET_IMP
			x, y: INTEGER
			--| FIXME IEK This routine is only a temporary measure as it  may
			--| not return the correct target if widgets overlap (Z ordering of windows needed)
		do	
			from
				targets.start
			until
				targets.off
			loop
				tg := targets.item
				widget_pointed ?= tg
				gtk_widget_get_pointer (widget_pointed.widget, $x, $y)
				
				if x >= 0 and y >= 0 and x <= widget_pointed.width and y <= widget_pointed.height then
					Result := targets.item
				end
				targets.forth
			end
		end

	drop_command (args: EV_ARGUMENT2 [EV_PND_SOURCE_I, EV_INTERNAL_COMMAND]; ev_data: EV_PND_EVENT_DATA) is
			-- Drop the data in a target.
		local
			target: EV_PND_TARGET_I
		do
			target := pointed_target

			cancel_command (args, Void)

			if target /= Void then
				target.receive (args.first.data_type, args.first.transported_data, ev_data)
			end
		end

	gtk_widget_get_pointer (widg, x, y: POINTER) is
		external
			"C (GtkWidget *, gint *, gint *) | <gtk/gtk.h>"
		end

end -- class EV_PND_TRANSPORTER_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

