indexing
	description: "Draw text in a form, using different fonts and brushes."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	GDIP_TEXT

inherit 
	WINFORMS_FORM
		rename
			make as make_form
		redefine
			on_paint,
			dispose_boolean
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make is
			-- | Initialize all brushes and fonts used in form.
			-- | Call `initialize_component'.
			-- Entry point.
		local
			l_background_image, l_text_image: DRAWING_BITMAP
		do
			create serif_font_family.make ({DRAWING_GENERIC_FONT_FAMILIES}.serif)

			set_style ({WINFORMS_CONTROL_STYLES}.opaque, True)

				-- Make sure form redraws when it is resized
			set_style ({WINFORMS_CONTROL_STYLES}.resize_redraw, True)

			-- Load the image to be used for the background from the exe's resource fork
			create l_background_image.make_from_filename ("colorbars.jpg")

				-- Now create the brush we are going to use to paint the background
			create background_brush.make_from_bitmap (l_background_image)

			-- Load the image to be used for the textured text from the exe's resource fork
			create l_text_image.make_from_filename ("marble.jpg")

			create text_texture_brush.make_from_bitmap (l_text_image)

				-- Load the fonts we want to use
			set_font (create {DRAWING_FONT}.make (serif_font_family, 20))
			create title_font.make (serif_font_family, 60)
			create text_font.make (serif_font_family, 11)

				-- Set up shadow brush - make it translucent
			create title_shadow_brush.make ({DRAWING_COLOR}.from_argb (70, {DRAWING_COLOR}.black))

				-- Set up fonts and brushes for printing japanese text
			set_up_japanese_text

			initialize_component
			{WINFORMS_APPLICATION}.run_form (Current)
		ensure
			non_void_background_brush: background_brush /= Void
			non_void_text_texture_brush: text_texture_brush /= Void
			non_void_title_font: title_font /= Void
			non_void_text_font: text_font /= Void
			non_void_title_shadow_brush: title_shadow_brush /= Void
		end

feature -- Access

	components: SYSTEM_DLL_SYSTEM_CONTAINER
			-- System.ComponentModel.Container 

	background_brush, text_texture_brush: DRAWING_TEXTURE_BRUSH
	title_shadow_brush: DRAWING_SOLID_BRUSH
	linear_grad_brush: DRAWING_BRUSH
			-- Brush 

	title_font, text_font, japanese_font: DRAWING_FONT
			-- Font
			
	flowed_text_1: SYSTEM_STRING is
			-- A text to draw.
		once
			Result := "[
I went down to the St James Infirmary,
Saw my baby there,
Stretched out on a long white table,
So sweet, so cold, so fair,
Let her go, let her go, God bless her,
Wherever she may be,
She can look this wide world over,
But she'll never find a sweet man like me,
When I die want you to dress me in straight lace shoes,
I wanna a boxback coat and a Stetson hat,
Put a twenty dollar gold piece on my watch chain,
So the boys'll know that I died standing up.
						]"
		ensure
			non_void_result: Result /= Void
		end
	
	flowed_text_2: SYSTEM_STRING is 
			-- A text to draw.
		once
			Result := "[
the sky seems full when you're in the cradle
the rain will fall and wash your dreams
stars are stars and they shine so hard...
now spit out the sky because its empty
and hollow and all your dreams are hanging out to dry
stars are stars and they shine so cold...
once i like crying twice i like laughter
come tell me what i'm after
						]"
		ensure
			non_void_result: Result /= Void
		end
	
	japanese_text: SYSTEM_STRING is
			-- A japanese text to draw.
		local
			l_japanese_string: NATIVE_ARRAY [CHARACTER]
		once
			create l_japanese_string.make (11)
			l_japanese_string.put (0, (31169).to_character)
			l_japanese_string.put (1, (12398).to_character)
			l_japanese_string.put (2, (21517).to_character)
			l_japanese_string.put (3, (21069).to_character)
			l_japanese_string.put (4, (12399).to_character)
			l_japanese_string.put (5, (12463).to_character)
			l_japanese_string.put (6, (12522).to_character)
			l_japanese_string.put (7, (12473).to_character)
			l_japanese_string.put (8, (12391).to_character)
			l_japanese_string.put (9, (12377).to_character)
			l_japanese_string.put (10, (12290).to_character)
			create Result.make (l_japanese_string)
		ensure
			non_void_result: Result /= Void
		end

	do_japanese_sample: BOOLEAN
		-- Is japanese sample can be drawn.

	serif_font_family: DRAWING_FONT_FAMILY
		-- Serif font family.

feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		local
			retried: BOOLEAN
		do
			if not retried then
				if components /= Void then
					components.dispose	
				end
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		rescue
			retried := True
			retry
		end

	on_paint (e: WINFORMS_PAINT_EVENT_ARGS) is
			-- Feature performed when form is painted.
		local
			graph: DRAWING_GRAPHICS
			title_text, text_to_draw: SYSTEM_STRING
			rectangle_11, rectangle_21: DRAWING_RECTANGLE_F
			rectangle_12, rectangle_22: DRAWING_RECTANGLE
			format: DRAWING_STRING_FORMAT
			window_center, start_pos: DOUBLE
			string_size: DRAWING_SIZE_F
		do
			graph := e.graphics

			e.graphics.set_smoothing_mode ({DRAWING_SMOOTHING_MODE}.anti_alias)

				-- Fill the background use the texture brush
				-- and then apply a white wash
			graph.fill_rectangle (background_brush, client_rectangle)
			graph.fill_rectangle (create {DRAWING_SOLID_BRUSH}.make ({DRAWING_COLOR}.from_argb (180, {DRAWING_COLOR}.white)), client_rectangle)

				-- Simple draw hello world
			graph.draw_string ("Hello World", font, create {DRAWING_SOLID_BRUSH}.make ({DRAWING_COLOR}.black), 10, 10)

				-- Draw a textured string
			title_text := "graphics  Samples"
			graph.draw_string (title_text, title_font, title_shadow_brush, 15, 25)
			graph.draw_string (title_text, title_font, text_texture_brush, 10, 20)

			text_to_draw := "Hello Symmetrical World"

				-- Use Measure string to display a string at the center of the window
			window_center := display_rectangle.width / 2
			string_size := e.graphics.measure_string (text_to_draw, text_font)
			start_pos := window_center - (string_size.width / 2)
			graph.draw_string (text_to_draw, text_font, create {DRAWING_SOLID_BRUSH}.make ({DRAWING_COLOR}.red), start_pos, 10)

				-- Now draw a string flowed into a rectangle
			rectangle_11.make (20, 150, 250, 300)
			rectangle_12.make (20, 150, 250, 300)
			graph.fill_rectangle (create {DRAWING_SOLID_BRUSH}.make ({DRAWING_COLOR}.gainsboro), rectangle_12)
			graph.draw_string (flowed_text_1, text_font, create {DRAWING_SOLID_BRUSH}.make ({DRAWING_COLOR}.Blue), rectangle_11)

				-- Draw more flowed text but this time center it
			rectangle_21.make (450, 150, 250, 300)
			rectangle_22.make (450, 150, 250, 300)
			graph.fill_rectangle (create {DRAWING_SOLID_BRUSH}.make ({DRAWING_COLOR}.gainsboro), rectangle_22)
			create format.make
			format.set_alignment ({DRAWING_STRING_ALIGNMENT}.center)
			graph.draw_string (flowed_text_2, text_font, create {DRAWING_SOLID_BRUSH}.make ({DRAWING_COLOR}.Blue), rectangle_21, format)

				-- If we have the Japanese language pack draw some text in Japanese
				-- Rotate it to make life truly exciting
			if do_japanese_sample then
				graph.rotate_transform (-30)
				graph.translate_transform (-180, 300)
				graph.draw_string (japanese_text, japanese_font, linear_grad_brush, 200, 140)
				graph.reset_transform
			end
		end

	initialize_component is
			-- Initialize window components.
		local
			l_size: DRAWING_SIZE
		do
			create components.make
			l_size.make (750, 500)
			set_size (l_size)
			set_text ("GDI+ Text Samples")
		end

	set_up_japanese_text is
			-- Set up japanese text.
		local
			retried: BOOLEAN
			res: WINFORMS_DIALOG_RESULT
		do
			if not retried then
				do_japanese_sample := True
					-- Load the fonts we want to use
				japanese_font := (create {DRAWING_FONT}.make ("MS Mincho", 36))
				linear_grad_brush := create {DRAWING_LINEAR_GRADIENT_BRUSH}.make (
													create {DRAWING_POINT}.make (0, 0), 
													create {DRAWING_POINT}.make (0, 45), 
													{DRAWING_COLOR}.Blue, 
													{DRAWING_COLOR}.Red)
			else
				do_japanese_sample := False
			end
		rescue
			res := {WINFORMS_MESSAGE_BOX}.show (
				"The Japanese font MS Mincho needs be present to run the Japanese part of this sample%N%N")
			retried := True
			retry
		end

invariant
	non_void_background_brush: background_brush /= Void
	non_void_text_texture_brush: text_texture_brush /= Void
	non_void_title_font: title_font /= Void
	non_void_text_font: text_font /= Void
	non_void_title_shadow_brush: title_shadow_brush /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- Class GDIP_TEXT
