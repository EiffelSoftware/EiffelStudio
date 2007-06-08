indexing

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
			interface
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

	make (an_interface: like interface) is
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

	set_angle (a_angle: REAL) is
			--
		do
			angle := a_angle
		end

feature -- Minimum size

	minimum_height: INTEGER is
			local
				a_rect: CGRECT_STRUCT
				a_size: CGSIZE_STRUCT
				ret, size: INTEGER
			do
				if internal_minimum_height > 0 then
					Result := internal_minimum_height
				else
					ret := get_control_data_size_external (c_object, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolstatictexttextheighttag, $size)
					ret := get_control_data_external (c_object, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolstatictexttextheighttag, size, $Result, $size)
				end
			end

	minimum_width: INTEGER is
			do
				Result:= text.split ('%N').first.count * 8 + 5 -- Currently we approximate the width of the first text line
			end

feature -- status setting


feature {EV_ANY_I} -- Implementation

	interface: EV_LABEL;

indexing
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end --class LABEL_IMP

