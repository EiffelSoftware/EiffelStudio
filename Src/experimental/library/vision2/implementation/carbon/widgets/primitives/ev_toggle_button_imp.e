note
	description: "EiffelVision toggle button, Carbon implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TOGGLE_BUTTON_IMP

inherit
	EV_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_BUTTON_IMP
		redefine
			make,
			interface,
			align_text_center,
			align_text_left,
			align_text_right,
			set_pixmap,
			remove_pixmap
		end

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
			rect.set_bottom (20)
			rect.set_right (100)
			ret := create_bevel_button_control_external ( null, rect.item,
				null, -- text
				{CONTROLDEFINITIONS_ANON_ENUMS}.kControlBevelButtonNormalBevel, -- size/thickness
				{CONTROLDEFINITIONS_ANON_ENUMS}.kControlBehaviorToggles, -- the behaviour: we want a toggle-button
				null, 0, 0, 0, $ptr )
			set_c_object ( ptr )

			event_id := app_implementation.get_id (current)
		end

feature -- Status setting

	align_text_center
			-- Display `text' centered.
		local
			ret: INTEGER
		do
			ret := set_bevel_button_text_alignment_external ( c_object, 1, 0 )
			ret := hiview_set_needs_display_external (c_object, 1)
		end

	align_text_left
			-- Display `text' left aligned.
		local
			ret: INTEGER
		do
			ret := set_bevel_button_text_alignment_external ( c_object, -2, 20 )
			ret := hiview_set_needs_display_external (c_object, 1)
		end

	align_text_right
			-- Display `text' right aligned.
		local
			ret: INTEGER
		do
			ret := set_bevel_button_text_alignment_external ( c_object, -1, 20 )
			ret := hiview_set_needs_display_external (c_object, 1)
		end

feature -- Status setting

	enable_select
			-- Set `is_selected' `True'.
		local
			ret: INTEGER
		do
			ret := hiview_set_value_external (c_object, 1)
		end

	disable_select
				-- Set `is_selected' `False'.
		local
			ret: INTEGER
		do
			ret := hiview_set_value_external (c_object, 0)
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is toggle button pressed?
		do
			Result := hiview_get_value_external (c_object).to_boolean
		end


feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP)

			-- Display image of `a_pixmap' on `Current'.
			-- Image of `pixmap' will be a copy of `a_pixmap'.
			-- Image may be scaled in some descendents, i.e EV_TREE_ITEM
			-- See EV_TREE.set_pixmaps_size.

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
				ret := set_bevel_button_graphic_alignment_external (c_object, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolbevelbuttonalignleft, 0, 0)
				ret := hiview_set_needs_display_external (c_object, 1)
			end

			-- Then move the text to the right
			align_text_right

		end

	remove_pixmap
			-- Remove image displayed on `Current'.

			local
			ret: INTEGER
			pixmap_imp: EV_PIXMAP_IMP
		do

			-- First remove the pixmap from the button

			ret := set_control_data_picture		(c_object,
												{CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolbuttonpart,
												{CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolbevelbuttoncontenttag,
												NULL)

			ret := hiview_set_needs_display_external (c_object, 1)


			-- Then put the text into the center
			align_text_center
		end


--feature -- Helper features

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

feature {EV_ANY_I}

	interface: EV_TOGGLE_BUTTON;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_TOGGLE_BUTTON_IMP

