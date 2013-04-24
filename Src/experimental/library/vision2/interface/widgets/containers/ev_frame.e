note
	description:
		"[
			Displays an optionally labeled border around a widget.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			+<`text'>-----+
			|             |
			|   `item'    |
			|             |
			+-------------+
		]"
	status: "See notice at end of class."
	keywords: "container, frame, box, border, bevel, outline, raised, lowered"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FRAME

inherit
	EV_CELL
		undefine
			create_implementation,
			initialize
		redefine
			implementation,
			is_in_default_state,
			default_identifier_name
		end

	EV_TEXT_ALIGNABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_FONTABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_FRAME_CONSTANTS
		export
			{NONE} all
			{ANY} valid_frame_border
		undefine
			default_create, copy
		end

create
	default_create,
	make_with_text

feature -- Access

	style: INTEGER
			-- Visual appearance. See: EV_FRAME_CONSTANTS.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.style
		ensure
			bridge_ok: Result = implementation.style
		end

	default_identifier_name: STRING_32
			-- Default `identifier_name' if no specific name is set
		do
			if text.is_empty then
				Result := Precursor {EV_CELL}
			else
				Result := text.twin
				Result.to_lower
				Result.prune_all ('.')
				Result.prune_all (':')
			end
		end

feature -- Status Report

	border_width: INTEGER
			-- Width of border around container in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.border_width
		ensure
			bridge_ok: Result = implementation.border_width
			positive: Result >= 0
		end

feature -- Element change

	set_style (a_style: INTEGER)
			-- Assign `a_style' to `style'.
		require
			not_destroyed: not is_destroyed
			a_style_valid: valid_frame_border (a_style)
		do
			implementation.set_style (a_style)
		ensure
			style_assigned: style = a_style
		end

feature -- Status Setting

	set_border_width (value: INTEGER)
			-- Assign `value' to `border_width'.
		require
			not_destroyed: not is_destroyed
			positive_value: value >= 0
		do
			implementation.set_border_width (value)
		ensure
			border_width_assigned: border_width = value
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CELL} and Precursor {EV_TEXT_ALIGNABLE} and
				is_left_aligned and style = {EV_FRAME_CONSTANTS}.Ev_frame_etched_in
				and Precursor {EV_FONTABLE}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_FRAME_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- Create implementation of frame.
		do
			create {EV_FRAME_IMP} implementation.make
		end

invariant
	valid_style: is_usable implies valid_frame_border (style)

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




end -- class EV_FRAME









