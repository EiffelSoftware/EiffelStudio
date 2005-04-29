indexing
	description	: "Abstraction for an editable tool or window."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TEXTABLE

feature {NONE} -- Initialization

	build_interface is
			-- Build system widget.
		do
			build_text_area
		end

feature -- Access

	widget: EV_WIDGET is
			-- Widget representing Current
		do
			Result := text_area.widget
		end

	text_area: EB_CLICKABLE_EDITOR
			-- Text area attached to Current

feature -- Status report

	changed: BOOLEAN is
			-- As the text changed since last save?
			-- False by default.
		do
			Result := text_area.changed
		end

feature -- Basic operations

	save_text is
			-- Save current text.
		require
			text_has_changed: changed
		deferred
		end

	save_as_text is
			-- Save current text as...
		deferred
		end

feature {NONE} -- Implementation

	build_text_area is
			-- Create the text component where the information will be displayed.
		local
			an_editor: EB_CLICKABLE_EDITOR
		do
			create an_editor.make (Void)
			text_area := an_editor
		end

end -- class EB_TEXTABLE
