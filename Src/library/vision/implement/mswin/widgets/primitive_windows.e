indexing
	description:
		"Implementation of widget with no child for Windows"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PRIMITIVE_WINDOWS

inherit
	WIDGET_WINDOWS
		redefine
			unrealize
		end;

	PRIMITIVE_I

	COLORED_FOREGROUND_WINDOWS

	FONTABLE_WINDOWS

feature  -- Status report

	is_stackable: BOOLEAN is
		do
		end

feature  -- Status setting

	propagate_event is
			-- Propagate event to direct ancestor if no action
			-- is specified for event.
		do
		end

	set_no_event_propagation is
			-- Propagate no event to direct ancestor if no action
			-- is specified for event.
		do
		end

	unrealize is
			-- Destroy current primitive.
		do
			if exists then
				wel_destroy
			end
		end

	class_background: WEL_BRUSH is
			-- Default background.
		local
			windows_color: COLOR_WINDOWS
		do
			if private_background_color = Void then
				!! Result.make_by_sys_color (Color_window + 1)
			else
				windows_color ?= private_background_color.implementation
				Result := windows_color.brush
			end	
		end

end -- class PRIMITIVE_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
