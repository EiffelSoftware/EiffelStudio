indexing
	description:
		"EiffelVision2 Toolbar button,%
		%a specific button that goes in a tool-bar."
	status: "See notice at end of class"
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
			sensitive_widget
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
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_tool_button_new (NULL, NULL))
		end

	initialize is
			-- Initialization of button box and events.
		do
			Precursor {EV_ITEM_IMP}
			pixmapable_imp_initialize
			feature {EV_GTK_EXTERNALS}.gtk_tool_button_set_icon_widget (visual_widget, pixmap_box)
			
			Precursor {EV_ITEM_IMP}
			initialize_events

			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tool_item_set_is_important (visual_widget, True)

			create tooltip.make (0)
			is_initialized := True
		end

	event_widget: POINTER is
			-- Pointer to the Gtk widget that handles the events
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (pixmap_box)
		end

feature -- Access

	text: STRING is
			--
		local
			a_txt: POINTER
			a_cs: EV_GTK_C_STRING
		do
			a_txt := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tool_button_get_label (visual_widget)
			if a_txt /= Default_pointer then
				create a_cs.make_from_pointer (a_txt)
				Result := a_cs.string				
			else
				Result := ""
			end
		end

	gray_pixmap: EV_PIXMAP
			-- Image displayed on `Current'.

	tooltip: STRING
			-- Tooltip use for describing `Current'

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			a_parent_imp: EV_TOOL_BAR_IMP
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_text
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tool_button_set_label (visual_widget, a_cs.item)
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
			tooltip := a_text.twin
			a_cs := a_text
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tool_item_set_tooltip (
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
			real_signal_connect (c_object, "clicked", agent (App_implementation.gtk_marshal).new_toolbar_item_select_actions_intermediary (internal_id), Void)
		end

feature {NONE} -- Implmentation

	sensitive_widget: POINTER is
			-- Widget used for enabling/disabling event sensitivity of `Current'
		do
			Result := c_object
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_BUTTON

end -- class EV_TOOL_BAR_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

