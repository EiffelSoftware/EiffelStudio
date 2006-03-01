indexing
	description:
		"EiffelVision2 Toolbar button,%
		%a specific button that goes in a tool-bar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		export
			{EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} select_actions_internal
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface,
			initialize,
			event_widget,
			set_pixmap,
			needs_event_box
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
		undefine
			visual_widget
		redefine
			interface,
			set_tooltip,
			tooltip
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is do Result := False end

	make (an_interface: like interface) is
			-- Create the tool bar button.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_tool_button_new (NULL, NULL))
		end

	initialize is
			-- Initialization of button box and events.
		do
			Precursor {EV_ITEM_IMP}
			pixmapable_imp_initialize
			{EV_GTK_EXTERNALS}.gtk_tool_button_set_icon_widget (visual_widget, pixmap_box)

				-- Initialize gtk events
			{EV_GTK_EXTERNALS}.gtk_widget_add_events (visual_widget, gdk_events_mask)

			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tool_item_set_is_important (visual_widget, True)
			set_is_initialized (True)
		end

	event_widget: POINTER is
			-- Pointer to the Gtk widget that handles the events
		do
			Result := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (pixmap_box)
		end

feature -- Access

	text: STRING is
			-- Text of the label.
		local
			a_txt: POINTER
			a_cs: EV_GTK_C_STRING
		do
			a_txt := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tool_button_get_label (visual_widget)
			if a_txt /= Default_pointer then
				create a_cs.share_from_pointer (a_txt)
				Result := a_cs.string
			else
				Result := ""
			end
		end

	gray_pixmap: EV_PIXMAP
			-- Image displayed on `Current'.

	tooltip: STRING is
			-- Tooltip use for describing `Current'.
		do
			if internal_tooltip /= Void then
				Result := internal_tooltip.twin
			else
				Result := ""
			end
		end

	internal_tooltip: STRING
		-- Tooltip for `Current'.

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			a_parent_imp: EV_TOOL_BAR_IMP
			a_cs: EV_GTK_C_STRING
		do
			a_cs := App_implementation.c_string_from_eiffel_string (a_text)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tool_button_set_label (visual_widget, a_cs.item)
			a_parent_imp ?= parent_imp
			if a_parent_imp /= Void and then a_parent_imp.parent_imp /= Void then
				a_parent_imp.update_toolbar_style
			end
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		local
			a_parent_imp: EV_TOOL_BAR_IMP
		do
			Precursor {EV_ITEM_IMP} (a_pixmap)
			a_parent_imp ?= parent_imp
			if a_parent_imp /= Void and then a_parent_imp.parent_imp /= Void then
				a_parent_imp.update_toolbar_style
			end
		end

	set_tooltip (a_text: STRING) is
			-- Set `tooltip' to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
		do
			internal_tooltip := a_text.twin
			a_cs := App_implementation.c_string_from_eiffel_string (a_text)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tool_item_set_tooltip (
				visual_widget,
				app_implementation.tooltips,
				a_cs.item,
				NULL
			)
		end

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP) is
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		do
			gray_pixmap := a_gray_pixmap.twin
			--| FIXME IEK Needs proper implementation
		end

	remove_gray_pixmap is
			-- Make `pixmap' `Void'.
		do
			gray_pixmap := Void
			--| FIXME IEK Needs proper implementation
		end

	enable_sensitive is
			--
		local
			l_pointer_over_widget: BOOLEAN
			a_pointer_position: EV_COORDINATE
		do
			Precursor {EV_SENSITIVE_IMP}
			--| This is a hack for gtk 2.6.x that renders the button unusable if the mouse pointer is over `Current' when `enable_sensitive' is called.
			if is_displayed then
				l_pointer_over_widget := Current = app_implementation.gtk_widget_imp_at_pointer_position
				if l_pointer_over_widget then
					a_pointer_position := pnd_screen.pointer_position
					pnd_screen.set_pointer_position (a_pointer_position.x + width + 10, a_pointer_position.y + height + 10)
					pnd_screen.set_pointer_position (a_pointer_position.x, a_pointer_position.y)
				end
			end
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	call_select_actions is
			-- Call the select_actions for `Current'
		do
			if not in_select_actions_call then
				in_select_actions_call := True
				if select_actions_internal /= Void then
					select_actions_internal.call (Void)
				end
			end
			in_select_actions_call := False
		end

	in_select_actions_call: BOOLEAN
		-- Is `Current' in the process of having its select actions called

feature {EV_ANY_I, EV_GTK_CALLBACK_MARSHAL} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
			create Result
			real_signal_connect (c_object, once "clicked", agent (App_implementation.gtk_marshal).new_toolbar_item_select_actions_intermediary (internal_id), Void)
		end

	create_drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- 	Create a drop down action sequence.
		do
			create Result
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_BUTTON;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TOOL_BAR_BUTTON_IMP

