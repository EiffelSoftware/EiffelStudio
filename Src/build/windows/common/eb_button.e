indexing
	description: "Eiffelbuild button that is focusable, has a symbol %
				% and whose borders are shown only when the mouse pointer %
				% enter the button."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class EB_BUTTON

inherit
	EV_TOOL_BAR_BUTTON
		redefine
			make
		end

--	FOCUSABLE

	CONSTANTS

feature {NONE} -- Initialization

	make (par: EV_TOOL_BAR) is
			-- Create the button with a pixmap.
		do
			{EV_TOOL_BAR_BUTTON} Precursor (par)
			set_pixmap (symbol)

			--| Default value for focus_string
--			create_focus_label
--			initialize_focus
		end

feature {NONE}

--	Focus_labels: FOCUS_LABEL_CONSTANTS is
--		once
--			!! Result
--		end
--	
--	focus_source: WIDGET is
--		do
--			Result := Current
--		end;

--	make_visible (a_parent: COMPOSITE) is	
--		require
--			valid_a_parent: a_parent /= Void
--		do
--			pict_color_make (Widget_names.pcbutton, a_parent);
--			set_symbol (symbol);
--
--			-- Default value for focus_string
--			create_focus_label
--			initialize_focus;
--		end;

	symbol: EV_PIXMAP is
		deferred
		end

--	set_symbol (s: STRING) is
--			-- Set icon symbol.
--		require
--			valid_argument: s /= Void
--		do
--		end

--	focus_label: FOCUS_LABEL_I is
--			-- has to be redefined, so that it returns correct toolkit initializer
--			-- to which object belongs for every instance of this class
--		local
--			ti: TOOLTIP_INITIALIZER
--		do
--			ti ?= top
--			check
--				valid_tooltip_initializer: ti/= void
--			end
--			Result := ti.label
--		end
--		
--	create_focus_label is
--		deferred
--		end

end -- class EB_BUTTON

