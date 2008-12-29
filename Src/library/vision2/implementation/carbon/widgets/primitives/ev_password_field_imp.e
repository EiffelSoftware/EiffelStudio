note
	description:
		"Eiffel Vision password field. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PASSWORD_FIELD_IMP

inherit
	EV_PASSWORD_FIELD_I
		undefine
			hide_border
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		redefine
			initialize,
			interface,
			make,
			text
		end

create
	make

feature {NONE} -- Initialization


		make (an_interface: like interface)
			-- Create Textfield on a user_pane
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_left (0)
			rect.set_right (106)
			rect.set_bottom (26)
			rect.set_top (0)
			ret := create_user_pane_control_external ( null, rect.item, {CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $c_object )

			rect.set_left (4)
			rect.set_right (102)
			rect.set_bottom (20)
			rect.set_top (4)
			ret := create_edit_unicode_text_control_external (null,rect.item, null,1, NULL, $entry_widget)
			ret := set_control_data_boolean (entry_widget, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontroledittextsinglelinetag, true)

			ret := hiview_set_visible_external (entry_widget, 1)
			ret := hiview_add_subview_external (c_object, entry_widget)
			text_binding (entry_widget)

			event_id := app_implementation.get_id (current)
		end
		

feature -- Access

	text: STRING_32
			-- Text displayed in field.
		local
			ret, size: INTEGER
			str: EV_CARBON_CF_STRING
			ptr: POINTER
		do

			ret := get_control_data_size_external (c_object, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlEditTextPasswordCFStringTag, $size)
			io.put_string("size: " + size.out)
			ret := get_control_data_external (c_object, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlEditTextPasswordCFStringTag, size, $ptr, $size)
			io.put_string ("ret :" + ret.out)
			create str.	make_unshared (ptr)
			REsult := str.string
		end


	initialize
			-- Create password field with `*'.
		do
			set_password (entry_widget)
		end
	set_password (obj: POINTER)
	external
		"C inline use <Carbon/Carbon.h>"
	alias

			"[
				{	
					TXNEchoMode($obj, '*',kTextEncodingUnicodeDefault, true);
				}
			]"
	end


feature {NONE} -- Implementation

	interface: EV_PASSWORD_FIELD;

note
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end -- class EV_PASSWORD_FIELD_IMP

