note

	description:
		"EiffelVision label, Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LABEL_IMP

inherit
	EV_LABEL_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			minimum_height,
			minimum_width
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CARBONEVENTS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Connect interface and initialize `c_object'.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_right(150)
			rect.set_bottom(90)

			ret := create_static_text_control_external( null, rect.item, null, null, $ptr )
			set_c_object ( ptr )
			align_text_center

			event_id := app_implementation.get_id (current)

			expandable := false

		end

feature -- Access

	angle: REAL
		-- Amount text is rotated counter-clockwise from horizontal plane in radians.

	set_angle (a_angle: REAL)
			--
		do
			angle := a_angle
		end

feature -- Minimum size

	minimum_height: INTEGER
			local
				a_rect: CGRECT_STRUCT
				a_size: CGSIZE_STRUCT
				ret, size: INTEGER
			do
			--	if internal_minimum_height > 0 then
			--		Result := internal_minimum_height
			--	else
			--		ret := get_control_data_size_external (c_object, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolstatictexttextheighttag, $size)
			--		ret := get_control_data_external (c_object, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolstatictexttextheighttag, size, $Result, $size)
			--	end
			Result := 15
			end

	minimum_width: INTEGER
			do
				Result:= text.split ('%N').first.count * 8 + 5 -- Currently we approximate the width of the first text line
			end

		set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			ret: INTEGER
			a_widget : EV_WIDGET_IMP
			old_min_height, old_min_width: INTEGER
		do
			a_widget ?= interface.implementation

			check
				has_imp: a_widget /= void
			end

			old_min_height := a_widget.minimum_height
			old_min_width := a_widget.minimum_width

			if accelerators_enabled then
				create real_text.make_unshared_with_eiffel_string (u_lined_filter (a_text))
			else
				create real_text.make_unshared_with_eiffel_string (a_text)
			end
			ret := hiview_set_text_external (c_object, real_text.item)

			if a_widget.parent_imp /= void then
				a_widget.parent_imp.child_has_resized (current, (a_widget.minimum_height - old_min_height), (a_widget.minimum_width - old_min_width))
			end

		end

feature -- status setting


feature {EV_ANY_I} -- Implementation

	interface: EV_LABEL;

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end --class LABEL_IMP

