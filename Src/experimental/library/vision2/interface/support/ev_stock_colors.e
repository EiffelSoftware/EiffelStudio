note
	description:
		"Facilities for accessing standardized colors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "color, default"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_COLORS

feature -- Access

	White: EV_COLOR
			-- White.
		once
			create Result.make_with_rgb (1, 1, 1)
		ensure
			result_not_void: Result /= Void
		end

	Black: EV_COLOR
			-- Black.
		once
			create Result.make_with_rgb (0, 0, 0)
		ensure
			result_not_void: Result /= Void
		end

	Grey, Gray: EV_COLOR
			-- Grey.
		once
			create Result.make_with_rgb (0.7, 0.7, 0.7)
		ensure
			result_not_void: Result /= Void
		end

	Dark_grey, Dark_gray: EV_COLOR
			-- Dark grey.
		once
			create Result.make_with_rgb (0.5, 0.5, 0.5)
		ensure
			result_not_void: Result /= Void
		end

	Blue: EV_COLOR
			-- Blue.
		once
			create Result.make_with_rgb (0, 0, 1)
		ensure
			result_not_void: Result /= Void
		end

	Dark_blue: EV_COLOR
			-- Dark blue.
		once
			create Result.make_with_rgb (0, 0, 0.5)
		ensure
			result_not_void: Result /= Void
		end

	Cyan: EV_COLOR
			-- Cyan.
		once
			create Result.make_with_rgb (0, 1, 1)
		ensure
			result_not_void: Result /= Void
		end

	Dark_cyan: EV_COLOR
			-- Dark cyan.
		once
			create Result.make_with_rgb (0, 0.5, 0.5)
		ensure
			result_not_void: Result /= Void
		end

	Green: EV_COLOR
			-- Green.
		once
			create Result.make_with_rgb (0, 1, 0)
		ensure
			result_not_void: Result /= Void
		end

	Dark_green: EV_COLOR
			-- Dark green.
		once
			create Result.make_with_rgb (0, 0.5, 0)
		ensure
			result_not_void: Result /= Void
		end

	Yellow: EV_COLOR
			-- Yellow.
		once
			create Result.make_with_rgb (1, 1, 0)
		ensure
			result_not_void: Result /= Void
		end

	Dark_yellow: EV_COLOR
			-- Dark yellow.
		once
			create Result.make_with_rgb (0.5, 0.5, 0)
		ensure
			result_not_void: Result /= Void
		end

	Red: EV_COLOR
			-- Red.
		once
			create Result.make_with_rgb (1, 0, 0)
		ensure
			result_not_void: Result /= Void
		end

	Dark_red: EV_COLOR
			-- Dark red.
		once
			create Result.make_with_rgb (0.5, 0, 0)
		ensure
			result_not_void: Result /= Void
		end

	Magenta: EV_COLOR
			-- Magenta.
		once
			create Result.make_with_rgb (1, 0, 1)
		ensure
			result_not_void: Result /= Void
		end

	Dark_magenta: EV_COLOR
			-- Dark magenta.
		once
			create Result.make_with_rgb (0.5, 0, 0.5)
		ensure
			result_not_void: Result /= Void
		end

feature -- Access

	Color_dialog, Color_3d_face: EV_COLOR
			-- Used for dialog box background.
			-- Name: "color dialog".
		do
			Result := implementation.Color_3d_face
		ensure
			result_not_void: Result /= Void
		end

	Color_3d_highlight: EV_COLOR
			-- Used for 3D-effects (light color)
			-- Name "color highlight"
		do
			Result := implementation.Color_3d_highlight
		ensure
			result_not_void: Result /= Void
		end

	Color_3d_shadow: EV_COLOR
			-- Used for 3D-effects (dark color)
			-- Name "color shadow"
		do
			Result := implementation.Color_3d_shadow
		ensure
			result_not_void: Result /= Void
		end

	Color_read_only: EV_COLOR
			-- Used for background of editable when read-only.
			-- Name: "color read only".
		do
			Result := implementation.Color_read_only
		ensure
			result_not_void: Result /= Void
		end

	Color_read_write: EV_COLOR
			-- Used for background of editable when write/write enabled.
			-- Name: "color read write".
		do
			Result := implementation.Color_read_write
		ensure
			result_not_void: Result /= Void
		end

	Default_background_color: EV_COLOR
			-- Used for background of most widgets.
			-- Name: "default background".
		do
			Result := implementation.default_background_color
		ensure
			result_not_void: Result /= Void
		end

	Default_foreground_color: EV_COLOR
			-- Used for foreground of most widgets.
			-- Name: "default foreground".
		do
			Result := implementation.default_foreground_color
		ensure
			result_not_void: Result /= Void
		end

feature -- Basic operations

	All_colors: LINKED_LIST [EV_COLOR]
			-- A list of all the basic colors.
		once
			create Result.make
			Result.force (White)
			Result.force (Black)
			Result.force (Grey)
			Result.force (Dark_grey)
			Result.force (Blue)
			Result.force (Dark_blue)
			Result.force (Cyan)
			Result.force (Dark_cyan)
			Result.force (Green)
			Result.force (Dark_green)
			Result.force (Yellow)
			Result.force (Dark_yellow)
			Result.force (Red)
			Result.force (Dark_red)
			Result.force (Magenta)
			Result.force (Dark_magenta)
		ensure
			result_not_void: Result /= Void
			all_colors_included: Result.count = 16
		end

feature {NONE} -- Implementation

	implementation: EV_STOCK_COLORS_IMP
			-- Responsible for interaction with native graphics toolkit.
		once
			create Result
		end

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




end -- class EV_STOCK_COLORS

