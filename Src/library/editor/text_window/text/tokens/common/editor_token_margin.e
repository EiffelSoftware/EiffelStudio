indexing
	description: "Token that belongs in the margin.  Examples are breakpoints, line number tokens, etc"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDITOR_TOKEN_MARGIN

inherit
	EDITOR_TOKEN
		redefine
			background_color,
			is_margin_token
		end

feature -- Access

	is_margin_token: BOOLEAN is True
		-- Is the current token a margin token?		

feature -- Miscellaneous

	background_color: EV_COLOR is
			-- Background color
		do
			Result := editor_preferences.margin_background_color
		end
		
	separator_color: EV_COLOR is
			-- Color of separator between margin and editor
		do
			Result := editor_preferences.margin_separator_color
		end

feature -- Status Setting

	set_internal_image (a_image: like internal_image) is
			-- Set `image'
		require
			image_not_void: a_image /= Void
		do
			internal_image := a_image
		ensure
			image_set: internal_image = a_image
		end	

feature {NONE} -- Implementation

	internal_image: STRING
		-- Image containing character data.  Used instead of `image' because a margin token is not an editable
		-- part of a line so `image' must always be empty.

invariant
		image_is_empty: image.is_empty

end -- class EDITOR_TOKEN_MARGIN
