indexing
	description	: "Objects that represents a general text token."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EDITOR_TOKEN

inherit
	SHARED_EDITOR_PREFERENCES

	EV_FONT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end


feature -- Access

	image: STRING
			-- String representation of the token

	length: INTEGER
			-- Number of characters represented by the token.

	position: INTEGER
			-- position in pixels of the first character of
			-- this token

feature -- Linkable functions

	previous: EDITOR_TOKEN
			-- Previous token in the line. Void if none

	next: EDITOR_TOKEN
			-- Next token in the line. Void if none.

	set_next_token(next_token: EDITOR_TOKEN) is
			-- set `next' to `next_token'. `next' can
			-- be Void if there are no next token.
		do
			next := next_token
		end

	set_previous_token(previous_token: EDITOR_TOKEN) is
			-- set `next' to `next_token'. `next' can
			-- be Void if there are no next token.
		do
			previous := previous_token
			update_position
		end

	update_position is
			-- Update the value of `position' to
			-- its correct value
		do
				-- Update current position
			if previous /= Void then
				position := previous.position + previous.width
			else
				position := 0
			end

				-- Update position of linked tokens
			if next /= Void then
				next.update_position
			end
		end

feature -- Display

	display(d_y: INTEGER; device: EV_PIXMAP) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		deferred
		end

	display_selected(d_y: INTEGER; device: EV_PIXMAP) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state.
		do
				-- by default, we call the normal `display' feature.
				-- Redefine the feature to apply a different style.
			display(d_y, device)
		end

	display_half_selected(d_y: INTEGER; start_selection, end_selection: INTEGER; device: EV_PIXMAP) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state from beggining to `pivot'
		do
				-- by default, we call the normal `display' feature.
				-- Redefine the feature to apply a different style.
			display(d_y, device)
		end

feature -- Width & height

	width: INTEGER is
			-- Width in pixel of the entire token.
		deferred
		end
	
	height: INTEGER is
			-- Height in pixel of the token
		do
			Result := font.height
		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		require
			n_valid: n >= 0
		deferred
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		require
			a_width_valid: a_width >= 0
		deferred
		ensure
			Result_positive: Result > 0
			Result_small_enough: Result <= length
		end

feature {EDITOR_TOKEN} -- Properties used to display the token

	text_color: EV_COLOR is
		do
			Result := editor_preferences.normal_text_color
		end

	background_color: EV_COLOR is
		do
			--| by default, no background...
			--|	Result := editor_preferences.normal_background_color
		end

	selected_text_color: EV_COLOR is
		do
			Result := editor_preferences.selected_text_color
		end

	selected_background_color: EV_COLOR is
		do
			Result := editor_preferences.selected_background_color
		end

	font: EDITOR_FONT is
			-- Current text font.
		once
				-- create the font
			create Result.make_with_values (editor_preferences.font_family, Ev_font_weight_regular, Ev_font_shape_regular, 15)
		end

invariant
	image_not_void: image /= Void
	length_positive: length > 0
	width_positive_or_null: width >= 0
	previous = Void implies position = 0

end -- class EDITOR_TOKEN
