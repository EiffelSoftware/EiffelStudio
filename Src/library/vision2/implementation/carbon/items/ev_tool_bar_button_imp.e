note
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
			interface
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface
		end
	MACHELP_FUNCTIONS_EXTERNAL

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a Carbon toggle button.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_bottom (10)
			rect.set_right (10)

			-- one could try to use create_icon_control_external. just a thought...
			ret := create_bevel_button_control_external ( null, rect.item,
				null, -- text
				{CONTROLDEFINITIONS_ANON_ENUMS}.kControlBevelButtonLargeBevel, -- size/thickness
				{CONTROLDEFINITIONS_ANON_ENUMS}.kControlBehaviorPushButton, -- the behaviour: we want a push-button
				null, 0, 0, 0, $ptr )
			set_c_object ( ptr )

			set_vertical_button_style

		end

	initialize
			-- Initialization of button box and events.
		do
			Precursor {EV_ITEM_IMP}
			pixmapable_imp_initialize
			set_is_initialized (True)
		end

	cg_string: EV_CARBON_CF_STRING

	needs_event_box: BOOLEAN do Result := False end



feature -- Status Report

	has_vertical_button_style: BOOLEAN
			-- Is the `pixmap' displayed vertically above `text' for
			-- all buttons contained in `Current'? If `False', then
			-- the `pixmap' is displayed to left of `text'.

	is_vertical: BOOLEAN
			-- Are the buttons in `Current' arranged vertically?
		local
			tool_bar_imp: EV_TOOL_BAR_IMP
		do
			tool_bar_imp ?= parent
			if tool_bar_imp /= Void then
				Result := tool_bar_imp.is_vertical
			end
		end

	has_text: BOOLEAN
			-- Does the button have a text?
		do
			if cg_string /= Void then
				Result := True
			end
		end

	has_pixmap: BOOLEAN
			-- Does the button have a pixmap?
		do
			Result := (pixmap /= Void)
		end



feature -- Access

	text: STRING_32
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

	disable_sensitive_internal
			--
		do

		end


	enable_sensitive_internal
			--
		do
			
		end



	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			ret: INTEGER
		do
			create cg_string.make_unshared_with_eiffel_string (a_text)
			ret:=set_control_title_with_cfstring_external (c_object, cg_string.item)

			layout


		end
	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to `pixmap'.

		local
			ret: INTEGER
			pixmap_imp: EV_PIXMAP_IMP
		do

			-- First load the pixmap into the button
			pixmap_imp ?= a_pixmap.implementation

			if
				pixmap_imp /= Void
			then
				ret := set_control_data_picture 	(c_object,
													{CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolbuttonpart,
													{CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolbevelbuttoncontenttag,
													pixmap_imp.drawable)
				ret := set_bevel_button_graphic_alignment_external (c_object, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolbevelbuttonaligncenter, 0, 0)
				ret := hiview_set_needs_display_external (c_object, 1)
			end

			layout

		end

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP)
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		do
			set_pixmap (a_gray_pixmap)
		end

	remove_gray_pixmap
			-- Make `pixmap' `Void'.
		local
			ret: INTEGER
		do
			ret := set_control_data_picture		(c_object,
												{CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolbuttonpart,
												{CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolbevelbuttoncontenttag,
												NULL)

			ret := hiview_set_needs_display_external (c_object, 1)


			remove_pixmap

		end



	set_vertical_button_style
			-- If vertical button style is set, then text is placed below the pixmap (as opposed to 'to the right of')
		local
			ret: INTEGER
		do

				ret := set_bevel_button_text_placement_external (c_object,{CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolbevelbuttonplacebelowgraphic)
				has_vertical_button_style := True


		end

	disable_vertical_button_style
			-- If vertical button style is disabled, then text is placed to the right of the pixmap (as opposed to 'below')
		local
			ret: INTEGER
		do
			ret := set_bevel_button_text_placement_external (c_object, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolbevelbuttonplacetorightofgraphic)
			has_vertical_button_style := False
		end

	set_control_data_picture (incontrol: POINTER; inpart: INTEGER; intagname: INTEGER; inpixmap: POINTER): INTEGER
			-- set a boolean value with set_control_data
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					
				 	ControlButtonContentInfo contentinfo;
				 	contentinfo.contentType = kControlContentCGImageRef;
				 	contentinfo.u.imageRef = $inpixmap;
				 	
					return SetControlData( $incontrol, $inpart, $intagname, sizeof(contentinfo), &contentinfo);
				}
			]"
		end


feature {EV_TOOL_BAR_IMP} -- Implementation


	layout
			-- Adjust the control to the size of the parent toolbar
		local
			rect: RECT_STRUCT
			ret: INTEGER
		do
			rect := get_bounds
			ret := rect.right
			ret := rect.bottom
			size_control_external (c_object, rect.right, rect.bottom)


		end

	get_bounds: RECT_STRUCT
			-- Get the bounds for current button
		local
			tool_bar_imp: EV_TOOL_BAR_IMP
			r_width, r_height: INTEGER
		do


			-- If it has a text, the bounds get stretched in all directions by the length & height of the text plus some margin
			if has_text then

					r_height := r_height + char_height + (2 * padding)
					r_width := r_width + text_width + (2 * padding)

			end


			if has_pixmap then

				-- if has_vertical_button_style, text & pixmap are displayed above each other
				if has_vertical_button_style then
					r_height := r_height + pixmap.height
					r_width := r_width.max (pixmap.width + (2 * padding))
				else
					r_height := r_height.max (pixmap.height + (2 * padding)) -- bigger of both values
					r_width := r_width + pixmap.width
				end

			end

			create Result.make_new_unshared
			Result.set_right (r_width)
			Result.set_bottom (r_height)
		end


	text_width: INTEGER
			-- Get the width (in pixel) of the text
		do
			Result := cg_string.length * char_length
		end



	call_select_actions
			-- Call the select_actions for `Current'
		do
		end

	in_select_actions_call: BOOLEAN
		-- Is `Current' in the process of having its select actions called

feature {EV_ANY_I, EV_GTK_CALLBACK_MARSHAL} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
			create Result
			--real_signal_connect (c_object, once "clicked", agent (App_implementation.gtk_marshal).new_toolbar_item_select_actions_intermediary (internal_id), Void)
		end

	create_drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- 	Create a drop down action sequence.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_BUTTON;

	char_length: INTEGER = 5;
	char_height: INTEGER = 15;
	padding: INTEGER = 10;

note
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

