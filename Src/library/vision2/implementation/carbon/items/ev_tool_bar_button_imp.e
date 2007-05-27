indexing
	description:
		"EiffelVision2 Toolbar button, Carbon implementation%
		%a specific button that goes in a tool-bar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			interface
		end

	EV_ITEM_IMP
		undefine
			update_for_pick_and_drop
		redefine
			interface,
			initialize,
			set_pixmap
		end

	EV_DOCKABLE_SOURCE_IMP
		redefine
			interface
		end

	EV_SENSITIVE_IMP
		redefine
			interface,
			enable_sensitive
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface
		end
		
	MACHELP_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	cg_string: EV_CARBON_CF_STRING

	needs_event_box: BOOLEAN is do Result := False end

	make (an_interface: like interface) is
			-- Create a Carbon toggle button.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_bottom (100)
			rect.set_right (100)

			-- one could try to use create_icon_control_external. just a thought...
			ret := create_bevel_button_control_external ( null, rect.item,
				null, -- text
				{CONTROLDEFINITIONS_ANON_ENUMS}.kControlBevelButtonLargeBevel, -- size/thickness
				{CONTROLDEFINITIONS_ANON_ENUMS}.kControlBehaviorPushButton, -- the behaviour: we want a push-button
				null, 0, 0, 0, $ptr )
			set_c_object ( ptr )


		end

	initialize is
			-- Initialization of button box and events.
		do
			Precursor {EV_ITEM_IMP}
			pixmapable_imp_initialize
			set_is_initialized (True)
		end

feature -- Access

	text: STRING_32 is
			-- Text of the label.
		do
			if cg_string /= void then
					Result := cg_string.string
				else
					create Result.make_empty
				end
		end

	gray_pixmap: EV_PIXMAP
			-- Image displayed on `Current'.

	internal_tooltip: STRING_32
		-- Tooltip for `Current'.

feature -- Element change

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
			local
			ret: INTEGER
		do
			create cg_string.make_unshared_with_eiffel_string (a_text)

			ret:=set_control_title_with_cfstring_external (c_object, cg_string.item)
		end
	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		local
			ret: INTEGER
		do

		end

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP) is
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		do
		end

	remove_gray_pixmap is
			-- Make `pixmap' `Void'.
		do
		end

	enable_sensitive
	is
			--
		do
		end

	enable_sensitive_internal is
			-- Allow the object to be sensitive to user input.
		do
		end

	disable_sensitive_internal is
			-- Set the object to ignore all user input.
		do
		end

feature {NONE} -- Implementation

	call_select_actions is
			-- Call the select_actions for `Current'
		do
		end

	in_select_actions_call: BOOLEAN
		-- Is `Current' in the process of having its select actions called

feature {EV_ANY_I} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
		do
			create Result
		end

	create_drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- 	Create a drop down action sequence.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_BUTTON;

indexing
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end -- class EV_TOOL_BAR_BUTTON_IMP

