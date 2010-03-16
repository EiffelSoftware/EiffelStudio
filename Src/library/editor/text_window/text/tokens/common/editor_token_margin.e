note
	description: "Token that belongs in the margin.  Examples are breakpoints, line number tokens, etc"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDITOR_TOKEN_MARGIN

inherit
	EDITOR_TOKEN
		redefine
			background_color_id,
			is_margin_token
		end

feature -- Access

	is_margin_token: BOOLEAN = True
		-- Is the current token a margin token?		

feature -- Miscellaneous

	separator_color: EV_COLOR
			-- Color of separator between margin and editor
		do
			Result := editor_preferences.color_of_id (separator_color_id)
		end

feature -- Color ids

	background_color_id: INTEGER
			-- Background color
		do
			Result := margin_background_color_id
		end

	separator_color_id: INTEGER
			-- Color of separator between margin and editor
		do
			Result := margin_separator_color_id
		end

feature -- Status Setting

	set_internal_image (a_image: like internal_image)
			-- Set `image'
		require
			image_not_void: a_image /= Void
		do
			internal_image := a_image
		ensure
			image_set: internal_image = a_image
		end

feature {NONE} -- Implementation

	internal_image: like wide_image
		-- Image containing character data.  Used instead of `wide_image' because a margin token is not an editable
		-- part of a line so `wide_image' must always be empty.

invariant
		image_is_empty: wide_image.is_empty

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




end -- class EDITOR_TOKEN_MARGIN
