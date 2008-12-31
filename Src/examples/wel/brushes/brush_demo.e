note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	BRUSH_DEMO

inherit
	WEL_FRAME_WINDOW
		redefine
			on_paint
		end

	WEL_STANDARD_COLORS
		export
			{NONE} all
		end

	WEL_HS_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_top ("Brush demo")
			resize (350, 300)
			show
		end

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Fill some rectangles using different brushes.
		local
			row, column: INTEGER
			rec_width, rec_height: INTEGER
		do
			rec_width := (client_rect.width - (brushes.height *
					Separation)) // brushes.height
			rec_height := (client_rect.height - (brushes.width *
					Separation)) // brushes.width
			from
				row := 1
			until
				row > brushes.height
			loop
				from
					column := 1
				until
					column > brushes.width
				loop
					paint_dc.select_brush (brushes.item (row, column))
					paint_dc.rectangle (Separation + (rec_width + Separation) * (row - 1),
						Separation + (rec_height + Separation) * (column - 1),
						(Separation + rec_width) * row,
						(Separation + rec_height) * column)
					column := column + 1
				end
				row := row + 1
			end
		end

	Separation: INTEGER = 5
			-- Space beetween two rectangles

	std_colors: ARRAY [WEL_COLOR_REF]
		once
			Result := <<
				grey,
				blue,
				cyan,
				green,
				yellow,
				red,
				magenta,
				dark_blue>>
		ensure
			result_not_void: Result /= Void
		end

	std_hatch_styles: ARRAY [INTEGER]
		once
			Result := <<
				Hs_horizontal,
				Hs_vertical,
				Hs_fdiagonal,
				Hs_bdiagonal,
				Hs_cross,
				Hs_diagcross>>
		ensure
			result_not_void: Result /= Void
		end

	brushes: ARRAY2 [WEL_BRUSH]
		local
			brush: WEL_BRUSH
			row, column: INTEGER
		once
			create Result.make (std_colors.count,
				std_hatch_styles.count)
			from
				row := 1
			until
				row > Result.height
			loop
				from
					column := 1
				until
					column > Result.width
				loop
					create brush.make_hatch (
						std_hatch_styles.item (column),
						std_colors.item (row))
					Result.put (brush, row, column)
					column := column + 1
				end
				row := row + 1
			end
		ensure
			result_not_void: Result /= Void
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


end -- class BRUSH_DEMO

