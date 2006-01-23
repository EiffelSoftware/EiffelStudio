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
			initialize
		end

	EV_DOCKABLE_SOURCE_IMP
		redefine
			interface
		end

	EV_SENSITIVE_IMP
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface
		end

	EV_TOOLTIPABLE_IMP
		undefine
			visual_widget
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the tool bar button.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_button_new)		
		end

	initialize is
			-- Initialization of button box and events.
		do
			Precursor {EV_ITEM_IMP}
				-- We want tool bar buttons to be flat in appearance and not focusable.
			{EV_GTK_EXTERNALS}.gtk_button_set_relief (visual_widget, {EV_GTK_EXTERNALS}.gtk_relief_none_enum)
			{EV_GTK_EXTERNALS}.GTK_WIDGET_UNSET_FLAGS (visual_widget, {EV_GTK_EXTERNALS}.gTK_CAN_FOCUS_ENUM)
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_button_box
			set_is_initialized (True)
		end

feature {EV_TOOL_BAR_IMP} -- Implementation

	initialize_button_box is
			-- Create the box for pixmap and label and connect action sequence.
		local
			box: POINTER
			par_imp: EV_TOOL_BAR_IMP
			a_box: POINTER
		do
			a_box := {EV_GTK_EXTERNALS}.gtk_bin_struct_child (visual_widget)
			if a_box /= default_pointer then
				{EV_GTK_EXTERNALS}.object_ref (text_label)
				{EV_GTK_EXTERNALS}.gtk_container_remove (a_box, text_label)
				
				{EV_GTK_EXTERNALS}.object_ref (pixmap_box)
				{EV_GTK_EXTERNALS}.gtk_container_remove (a_box, pixmap_box)
				
				{EV_GTK_EXTERNALS}.gtk_container_remove (visual_widget, a_box)
			end
			
			if parent_imp /= Void then
				par_imp ?= parent_imp
			end
			if par_imp /= Void and then not par_imp.has_vertical_button_style  then
				box := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			else
				box := {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0)
			end
			
			{EV_GTK_EXTERNALS}.gtk_container_add (visual_widget, box)
			{EV_GTK_EXTERNALS}.gtk_widget_show (box)
			{EV_GTK_EXTERNALS}.gtk_box_pack_end (box, text_label, True, True, 0)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (box, pixmap_box, True, True, 0)
			
			if text.is_equal ("") then
				{EV_GTK_EXTERNALS}.gtk_widget_hide (text_label)
			end
			
			if pixmap = Void then
				{EV_GTK_EXTERNALS}.gtk_widget_hide (pixmap_box)
			end
		end

feature -- Access

	gray_pixmap: EV_PIXMAP
			-- Image displayed on `Current'.

feature -- Element change

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

feature {EV_ANY_I, EV_GTK_CALLBACK_MARSHAL} -- Implementation
	
	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
			create Result
			real_signal_connect (visual_widget, "clicked", agent (App_implementation.gtk_marshal).toolbar_button_select_actions_intermediary (c_object), Void)
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

