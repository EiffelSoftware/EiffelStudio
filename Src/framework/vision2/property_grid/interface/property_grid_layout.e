note
	description: "Layout constants."
	date: "$Date$"
	revision: "$Revision$"

class
	PROPERTY_GRID_LAYOUT

inherit
	SHARED_BENCH_NAMES

feature {NONE} -- Button constants

	button_width: INTEGER = 75
	small_button_width: INTEGER = 20

	padding_size: INTEGER
		do
			Result := internal_padding_size.item
		end

feature {NONE} -- Margin constants

	margin_size: INTEGER = 10
	small_margin_size: INTEGER = 5

feature {NONE} -- Margin elements

	append_margin (a_box: EV_BOX)
			-- Append a small margin to `a_box'.
		require
			a_box_not_void: a_box /= Void
		local
			cl: EV_CELL
		do
			create cl
			cl.set_minimum_size (margin_size, margin_size)
			a_box.extend (cl)
			a_box.disable_item_expand (cl)
		end

	append_small_margin (a_box: EV_BOX)
			-- Append a small margin to `a_box'.
		require
			a_box_not_void: a_box /= Void
		local
			cl: EV_CELL
		do
			create cl
			cl.set_minimum_size (small_margin_size, small_margin_size)
			a_box.extend (cl)
			a_box.disable_item_expand (cl)
		end

feature {NONE} -- Colors

	override_color: EV_COLOR
			-- Background color for properties that do override.
		once
			create Result.make_with_8_bit_rgb (255, 245, 245)
		end

	inherit_color: EV_COLOR
			-- Background color for properties that are inherited.
		once
			create Result.make_with_8_bit_rgb (245, 245, 245)
		end

feature {NONE} -- Text

	force_inheritance: STRING_GENERAL do Result := names.l_force_inheritance	end
	use_inherited: STRING_GENERAL do Result := names.l_use_inherited	end
	up_button_text: STRING_GENERAL do Result := names.b_Up_text	end
	down_button_text: STRING_GENERAL do Result := names.b_Down_text	end
	change_button_text: STRING_GENERAL do Result := names.b_change	end

	dialog_title (a_name: READABLE_STRING_GENERAL): STRING_GENERAL
		do
			Result := names.t_dialog_title (a_name)
		end

	plus_button_text: STRING_GENERAL do Result := "+"	end
	minus_button_text: STRING_GENERAL do Result := "-"	end

feature -- Modification: default global settings

	set_padding_size (a_size: like padding_size)
			-- Set default padding size.
		do
			internal_padding_size.put (a_size)
		end

	set_override_color (c: EV_COLOR)
			-- Set color of overridden property to `c'.
		do
			override_color.copy (c)
		ensure
			override_color_set: override_color ~ c
		end

	set_inherit_color (c: EV_COLOR)
			-- Set color of inherited property to `c'.
		do
			inherit_color.copy (c)
		ensure
			inherit_color_set: inherit_color ~ c
		end

feature {NONE} -- Onces for global setting of layout values.

	internal_padding_size: CELL [INTEGER]
		once
			create Result.put (0)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
