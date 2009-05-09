note

	description:
		"EiffelVision label, Cocoa implementation."
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
			set_default_minimum_size,
			set_background_color
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

	SINGLE_MATH

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			create {NS_TEXT_FIELD}cocoa_item.new
			text_field.set_editable (false)
			--text_field.set_draws_background (false)
			text_field.set_bordered (false)
			text_field.set_background_color (create {NS_COLOR}.control_color)

			align_text_center
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

	set_default_minimum_size
			-- Resize to a default size.
		do
			accomodate_text (" ")
		end

	accomodate_text (a_text: STRING_GENERAL)
			-- Change internal minimum size to make `a_text' fit.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		local
			t: TUPLE [width: INTEGER; height: INTEGER]
			a_width, a_height: INTEGER
			l_angle: REAL
		do
			t := internal_font.string_size (a_text)
			a_width := t.width
			a_height := t.height

			l_angle := angle
			if l_angle /= 0.0 then
				a_height := (a_width * sine (l_angle) + a_height * cosine (l_angle)).rounded
				a_width := (a_width * cosine (l_angle) + a_height * sine (l_angle)).rounded
			end
			internal_set_minimum_size (a_width.abs + 5, a_height.abs + 5)
		end

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			if not text.is_equal (a_text) then
				if a_text.is_empty then
					set_default_minimum_size
				else
					accomodate_text (a_text)
				end
				Precursor {EV_TEXTABLE_IMP} (a_text)
				text_field.set_string_value (a_text)
				-- invalidate
			end
		end

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'
		local
			color: NS_COLOR
		do
			Precursor {EV_PRIMITIVE_IMP} (a_color)
			create color.color_with_calibrated_red_green_blue_alpha (a_color.red, a_color.green, a_color.blue, 1.0)
			text_field.set_background_color (color)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_LABEL;

	text_field: NS_TEXT_FIELD
			--
		do
			Result ?= cocoa_item
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end --class LABEL_IMP

