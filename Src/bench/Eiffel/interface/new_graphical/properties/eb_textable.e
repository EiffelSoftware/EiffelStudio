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

	is_editable: BOOLEAN is
			-- Does Current tool have an editable text area?
			-- False by default.
		do
			Result := text_area.is_editable
		end

	able_to_edit: BOOLEAN is
			-- Are we able to edit the text?
			-- False by default
		do
		end

	changed: BOOLEAN is
			-- As the text changed since last save?
			-- False by default.
		do
			Result := text_area.changed
		end

feature -- Status setting

	enable_editable is
			-- Set edit mode for text modification.	
			-- (By default it is set to read only)
		do
			text_area.enable_editable
		end

	disable_editable is
			-- Set edit mode to Read-only (Default).	
		do
			text_area.disable_editable
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

feature -- Obsolete

	set_mode_for_editing is
			-- Set edit mode for text modification.	
			-- (By default it is set to read only)
		obsolete "use enable_editable instead"
		do
			enable_editable
		end

	has_editable_text: BOOLEAN is
			-- Does Current tool have an editable text area?
			-- False by default.
		obsolete "use is_editable instead"
		do
			Result := is_editable
		end

end -- class EB_TEXTABLE
