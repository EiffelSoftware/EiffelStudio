indexing

	description:
		"Abstract notion of a tool button.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_BUTTON

inherit
	ACTIVE_PICT_COLOR_B
		redefine
			make
		end

	FOCUSABLE

	TTY_CONSTANTS

	RESOURCE_USER
		redefine
			update_boolean_resource
		end

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create the 
		do
			{ACTIVE_PICT_COLOR_B} Precursor (a_name, a_parent)
			if General_resources.regular_button /= Void then
					-- Not Void implies that we are on Windows where
					-- the functionality is fully implemented.
				set_active (not General_resources.regular_button.actual_value)
				General_resources.add_user (Current)
			end
		end

feature -- Access

	symbol: PIXMAP is
			-- The pixmap representing Current.
		deferred
		end;

	focus_source: WIDGET is
			-- Widget representing Current on the screen.
		do
			Result := Current
		end;

	focus_label: FOCUS_LABEL_I is
			-- Focus_label
		local
			ti: TOOLTIP_INITIALIZER
		do
			ti ?= top
			check
				has_tooltip: ti /= Void
			end
			Result := ti.label
		end

feature -- Status Setting

	set_symbol (p: PIXMAP) is
			-- Set the pixmap if it it valid
		do
			if p.is_valid then
				set_pixmap (p)
			end;
		end;

feature -- Resource Update

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
		do
			if old_res = general_resources.regular_button then
				if new_res.actual_value then
					set_active (False)
				else
					set_active (True)
				end
					-- To update the display, the only way we found is to resize
					-- each button.
				set_width (width - 1)
				set_width (width + 1)
			end
		end
	
feature {NONE} -- Properties

	button_name: STRING is "push_b"

end -- class ISE_BUTTON
