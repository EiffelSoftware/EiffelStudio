note
	description: "System root class."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

--TODO:
--   (Take a look at larry's EQA_UI_FUNCTIONS: http://github.com/larryliuming/GUI-Automatic-Testing/blob/766eb7b4282e4c019404898b4857af03f377af88/Eiffel/test_case/eqa_ui_functions.e)

class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create application
--			application.post_launch_actions.extend (agent set_with_named_file)
--			application.post_launch_actions.extend (agent save_to_named_file)
--			application.post_launch_actions.extend (agent clear)
--			application.post_launch_actions.extend (agent draw_segment)
			application.post_launch_actions.extend (agent draw_pixmap)
			application.post_launch_actions.extend (agent draw_sub_pixmap)
			application.post_launch_actions.extend (agent draw_sub_pixmap2)
--			application.post_launch_actions.extend (agent draw_text)
			application.post_launch_actions.extend (agent draw_text_draw_text_top_left)
--			application.post_launch_actions.extend (agent set_font_draw_text)

			application.post_launch_actions.extend (agent drawing_area_draw_pixmap)
			application.post_launch_actions.extend (agent drawing_area_draw_sub_pixmap)
--			application.post_launch_actions.extend (agent drawing_area_draw_text)

			application.post_launch_actions.extend (agent font_metrics)

--			application.post_launch_actions.extend (agent toolbar_with_button_icons)
			application.launch
		end

feature -- Pixmap

	set_with_named_file
			-- Reads an image file into a pixmap
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap
			pixmap.set_with_named_file (lenna)

			create window
			window.extend (pixmap)
			window.show
		end

	save_to_named_file
			-- Reads an image file and saves it again
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap
			pixmap.set_with_named_file (lenna)

			pixmap.save_to_named_file (create {EV_BMP_FORMAT}, create {FILE_NAME}.make_from_string("graphics/img.png"))
		end

	clear
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap.make_with_size (100, 100)
			pixmap.set_background_color (colors.red)
			pixmap.clear

			create window
			window.extend (pixmap)
			window.show
		end

	draw_segment
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap.make_with_size (100, 100)
			pixmap.set_background_color (colors.white)
			pixmap.clear
			pixmap.set_foreground_color (colors.blue)
			pixmap.draw_segment (10, 10, 90, 90)
			pixmap.set_foreground_color (colors.black)
			pixmap.draw_segment (10, 10, 10, 90)

			create window
			window.extend (pixmap)
			window.show
		end

	draw_pixmap
		local
			pixmap1, pixmap2: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap2
			pixmap2.set_with_named_file (lenna)


			create pixmap1.make_with_size (pixmap2.width + 15, pixmap2.height + 15)
			pixmap1.set_background_color (colors.red)
			pixmap1.clear

			pixmap1.draw_pixmap (5, 5, pixmap2)

			create window
			window.extend (pixmap1)
			window.show
		end

	draw_sub_pixmap
			-- Draws using draw_sub_pixmap and draw_pixmap (sub_pixmap), which should produce the same result
		local
			pixmap1, pixmap2: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap2
			pixmap2.set_with_named_file (lenna)

			create pixmap1.make_with_size (215, 110)
			pixmap1.set_background_color (colors.green)
			pixmap1.clear

			pixmap1.draw_sub_pixmap (5, 5, pixmap2, create {EV_RECTANGLE}.make (100, 100, 100, 100))

			pixmap1.draw_pixmap (110, 5, pixmap2.sub_pixmap (create {EV_RECTANGLE}.make (100, 100, 100, 100)))

			create window
			window.extend (pixmap1)
			window.show
		end

	draw_sub_pixmap2
		local
			pixmap1, pixmap2: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap2
			pixmap2.set_with_named_file (lenna)

			create pixmap1.make_with_size (215, 110)
			pixmap1.set_background_color (colors.green)
			pixmap1.clear

			pixmap1.draw_sub_pixmap (5, 5, pixmap2, create {EV_RECTANGLE}.make (100, 100, 100, 100))

			pixmap1.draw_sub_pixmap (110, 5, pixmap2, create {EV_RECTANGLE}.make (100, 100, 15000, 100))

			create window
			window.extend (pixmap1)
			window.show
		end

	draw_text
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap.make_with_size (100, 100)
			pixmap.clear

			pixmap.draw_text (10, 10, "black text")

			pixmap.set_foreground_color (colors.red)
			pixmap.draw_text (10, 30, "red text")

			create window
			window.extend (pixmap)
			window.show
		end

	draw_text_draw_text_top_left
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap.make_with_size (300, 50)
			pixmap.clear

			pixmap.set_foreground_color (colors.red)
			pixmap.draw_segment (8, 8, 12, 12)
			pixmap.draw_segment (8, 12, 12, 8)
			pixmap.draw_segment (98, 8, 102, 12)
			pixmap.draw_segment (98, 12, 102, 8)

			pixmap.set_foreground_color (colors.blue)
			pixmap.draw_segment (10, 10, 290, 10)

			pixmap.set_foreground_color (colors.black)
			pixmap.draw_text (10, 10, "draw_text")
			pixmap.draw_text_top_left (100, 10, "draw_text_top_left")

			create window
			window.extend (pixmap)
			window.show
		end

	set_font_draw_text
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
			font: EV_FONT
		do
			create pixmap.make_with_size (150, 150)
			pixmap.clear

			pixmap.draw_text (10, 10, "regular text")

			create font
			font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
			pixmap.set_font (font)
			pixmap.draw_text (10, 30, "bold text")

			create font
			font.set_shape ({EV_FONT_CONSTANTS}.Shape_italic)
			pixmap.set_font (font)
			pixmap.draw_text (10, 50, "italic text")

			create font
			font.set_height (font.height + 5)
			pixmap.set_font (font)
			pixmap.draw_text (10, 70, "big text")

			create font
			font.set_height (font.height + 5)
			font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
			pixmap.set_font (font)
			pixmap.draw_text (10, 90, "big, bold text")

			create window
			window.extend (pixmap)
			window.show
		end

feature -- Drawing area	

	drawing_area_draw_pixmap
		local
			pixmap: EV_PIXMAP
			drawing_area: EV_DRAWING_AREA
			window: EV_TITLED_WINDOW
		do
			create pixmap
			pixmap.set_with_named_file (lenna)

			create drawing_area
			drawing_area.set_background_color (colors.red)
			drawing_area.clear

			drawing_area.expose_actions.extend (agent (x, y, w, h: INTEGER_32; a_drawing_area: EV_DRAWING_AREA; a_pixmap: EV_PIXMAP)
				do
					a_drawing_area.draw_pixmap (5, 5, a_pixmap)
				end (?, ?, ?, ?, drawing_area, pixmap))

			create window
			window.extend (drawing_area)
			window.show
			window.set_size (pixmap.width + 15, pixmap.height + 15 + 22)
		end

	drawing_area_draw_sub_pixmap
		local
			pixmap: EV_PIXMAP
			drawing_area: EV_DRAWING_AREA
			window: EV_TITLED_WINDOW
		do
			create pixmap
			pixmap.set_with_named_file (lenna)

			create drawing_area
			drawing_area.set_background_color (colors.red)
			drawing_area.clear

			drawing_area.expose_actions.extend (agent (x, y, w, h: INTEGER_32; a_drawing_area: EV_DRAWING_AREA; a_pixmap: EV_PIXMAP)
				do
					a_drawing_area.draw_sub_pixmap (5, 5, a_pixmap, create {EV_RECTANGLE}.make (100, 100, 100, 100))
					a_drawing_area.draw_pixmap (110, 5, a_pixmap.sub_pixmap (create {EV_RECTANGLE}.make (100, 100, 100, 100)))
				end (?, ?, ?, ?, drawing_area, pixmap))

			create window
			window.extend (drawing_area)
			window.show
			window.set_size (2*100 + 15, 100 + 15 + 22)
		end

	drawing_area_draw_text
		local
			drawing_area: EV_DRAWING_AREA
			window: EV_TITLED_WINDOW
		do
			create drawing_area
			drawing_area.clear

			drawing_area.expose_actions.extend (agent (x, y, w, h: INTEGER_32; a_drawing_area: EV_DRAWING_AREA)
				do
					a_drawing_area.set_foreground_color (colors.black)
					a_drawing_area.draw_text (10, 10, "black text")
					a_drawing_area.set_foreground_color (colors.red)
					a_drawing_area.draw_text (10, 30, "red text")
				end (?, ?, ?, ?, drawing_area))

			create window
			window.extend (drawing_area)
			window.show
			window.set_size (100, 100)
		end

feature -- Font

	font_metrics
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
			font: EV_FONT
			size: TUPLE [width: INTEGER; height: INTEGER; left_offset: INTEGER; right_offset: INTEGER]
		do
			create pixmap.make_with_size (700, 50)
			pixmap.clear

			create font
			font.set_height (30)
			pixmap.set_font (font)

			-- string_size in yellow
			size := font.string_size ("the quick brown fox jumps over the lazy dog")
			pixmap.set_foreground_color (colors.yellow)
			pixmap.fill_rectangle (10, 10, size.width, size.height)

			-- top-line in red
			pixmap.set_foreground_color (colors.red)
			pixmap.draw_segment (10, 10, pixmap.width-10, 10)

			-- base-line and (base-line + descent) in blue
			pixmap.set_foreground_color (colors.blue)
			pixmap.draw_segment (10, 10 + font.ascent, pixmap.width-10, 10 + font.ascent)
			pixmap.draw_segment (10, 10 + font.ascent + font.descent, pixmap.width-10, 10 + font.ascent + font.descent)

			pixmap.set_foreground_color (colors.black)
			pixmap.draw_text_top_left (10, 10, "the quick brown fox jumps over the lazy dog")

			create window
			window.extend (pixmap)
			window.show
		end

feature -- Toolbar

	toolbar_with_button_icons
		local
			toolbar: EV_TOOL_BAR
			tool_bar_button: EV_TOOL_BAR_BUTTON
			window: EV_TITLED_WINDOW
			stock_pixmaps: EV_STOCK_PIXMAPS
		do
			create stock_pixmaps
			create toolbar

			create tool_bar_button.make_with_text ("Button 1")
			tool_bar_button.set_pixmap (stock_pixmaps.default_window_icon)
			toolbar.extend (tool_bar_button)

			create tool_bar_button.make_with_text ("Button 2")
			toolbar.extend (tool_bar_button)

			create window
			window.extend (toolbar)
			window.show
		end

feature -- Helper features

	application: EV_APPLICATION

    colors: EV_STOCK_COLORS
    	once
    		create Result
    	end

    lenna: STRING
    	once
    		Result := "graphics/Lenna.png"
    	end

end
