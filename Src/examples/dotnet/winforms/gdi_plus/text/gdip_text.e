indexing
	description: ""

class
	GDIP_TEXT

inherit 
	WINFORMS_FORM
		rename
			make as make_form
		undefine
			to_string, finalize, equals, get_hash_code
		redefine
			on_paint,
			dispose_boolean
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		local
			l_background_image, l_text_image: DRAWING_BITMAP
			dummy: SYSTEM_OBJECT
		do
			create serif_font_family.make_from_generic_family (feature {DRAWING_GENERIC_FONT_FAMILIES}.serif)

			set_style (feature {WINFORMS_CONTROL_STYLES}.opaque, True)

			-- Make sure form redraws when it is resized
			set_style (feature {WINFORMS_CONTROL_STYLES}.resize_redraw, True)

			-- Load the image to be used for the background from the exe's resource fork
--			create l_background_image.make_from_original (create {DRAWING_BITMAP}.make_from_stream (feature {ASSEMBLY}.get_executing_assembly.get_manifest_resource_stream (("colorbars.jpg").to_cil)))
			create l_background_image.make_from_original (create {DRAWING_BITMAP}.make_from_filename (("D:\Eiffel52\examples\dotnet\winforms\gdi_plus\text\colorbars.jpg").to_cil))

			-- Now create the brush we are going to use to paint the background
			create background_brush.make_from_bitmap (l_background_image)

			-- Load the image to be used for the textured text from the exe's resource fork
--			create l_text_image.make_from_original (create {DRAWING_BITMAP}.make_from_stream (feature {ASSEMBLY}.get_executing_assembly.get_manifest_resource_stream (("marble.jpg").to_cil)))
			create l_text_image.make_from_original (create {DRAWING_BITMAP}.make_from_filename (("D:\Eiffel52\examples\dotnet\winforms\gdi_plus\text\marble.jpg").to_cil))
			create text_texture_brush.make_from_bitmap (l_text_image)

			-- Load the fonts we want to use
			set_font (create {DRAWING_FONT}.make_from_family_and_em_size (serif_font_family, 20))
			create title_font.make_from_family_and_em_size (serif_font_family, 60)
			create text_font.make_from_family_and_em_size (serif_font_family, 11)

			-- Set up shadow brush - make it translucent
			create title_shadow_brush.make (feature {DRAWING_COLOR}.from_argb_integer_color (70, feature {DRAWING_COLOR}.black))

			-- Set up fonts and brushes for printing japanese text
--			try {
--				japanese_font create {DRAWING_FONT}.make ("MS Mincho", 36)
--				linear_grad_brush = new LinearGradientBrush(new Point(0, 0), new Point(0, 45), feature {DRAWING_COLOR}.Blue, feature {DRAWING_COLOR}.Red)
--			} catch (Exception ex) {
--				MessageBox.Show("The Japanese font MS Mincho needs be present to run the Japanese part of this sample\n\n" + ex.Message)
--				do_japanese_sample = false
--			}

			initialize_component
			--dummy := show_dialog
			feature {WINFORMS_APPLICATION}.run_form (Current)
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
		once
			Result := ("I went down to the St James Infirmary,\nSaw my baby there,\nStretched out on a long white table,\nSo sweet,so cold,so fair,\nLet her go,let her go,God bless her,\nWherever she may be,\nShe can look this wide world over,\nBut she'll never find a sweet man like me,\nWhen I die want you to dress me in straight lace shoes,\nI wanna a boxback coat and a Stetson hat,\nPut a twenty dollar gold piece on my watch chain,\nSo the boys'll know that I died standing up.").to_cil
		ensure
			non_void_result: Result /= Void
		end
	
	flowed_text_2: SYSTEM_STRING is 
		once
			Result := ("the sky seems full when you're in the cradle\nthe rain will fall and wash your dreams\nstars are stars and they shine so hard...\nnow spit out the sky because its empty\nand hollow and all your dreams are hanging out to dry\nstars are stars and they shine so cold...\nonce i like crying twice i like laughter\ncome tell me what i'm after").to_cil
		ensure
			non_void_result: Result /= Void
		end
	
	japanese_text: SYSTEM_STRING is
			--
		local
			l_japanese_charecter: CHARACTER
			l_japanese_string: NATIVE_ARRAY [CHARACTER]
		once
			--create Result.make (new char[] {(char)31169, (char)12398, (char)21517, (char)21069, (char)12399, (char)12463, (char)12522, (char)12473, (char)12391, (char)12377, (char)12290})
--			create l_japanese_charecter.make
			create result.make_from_c_and_count ('#', 1)
		ensure
			non_void_result: Result /= Void
		end

	do_japanese_sample: BOOLEAN is True

	serif_font_family: DRAWING_FONT_FAMILY


feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		local
			dummy: WINFORMS_DIALOG_RESULT
			retried: BOOLEAN
		do
			if not retried then
				if components /= Void then
					components.dispose	
				end
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		rescue
			retried := true
			retry
		end

	on_paint (e: WINFORMS_PAINT_EVENT_ARGS) is
			--
		local
			graph: DRAWING_GRAPHICS
			title_text, text_to_draw, what_rendered_text: SYSTEM_STRING
			rectangle_11, rectangle_21: DRAWING_RECTANGLE_F
			rectangle_12, rectangle_22: DRAWING_RECTANGLE
			format: DRAWING_STRING_FORMAT
			characters, lines: INTEGER
			window_center, start_pos: DOUBLE
			string_size: DRAWING_SIZE_F
			dummy: SYSTEM_OBJECT
		do
			graph := e.graphics

			e.graphics.set_smoothing_mode (feature {DRAWING_SMOOTHING_MODE}.anti_alias)

			-- Fill the background use the texture brush
			-- and then apply a white wash
			graph.fill_rectangle (background_brush, client_rectangle)
			graph.fill_rectangle (create {DRAWING_SOLID_BRUSH}.make (feature {DRAWING_COLOR}.from_argb_integer_color (180, feature {DRAWING_COLOR}.white)), client_rectangle)

			-- Simple draw hello world
			graph.draw_string_string_font_brush_real_real (("Hello World").to_cil, font, create {DRAWING_SOLID_BRUSH}.make (feature {DRAWING_COLOR}.black), 10, 10)

			-- Draw a textured string
			title_text := ("graphics  Samples").to_cil
			graph.draw_string_string_font_brush_real_real (title_text, title_font, title_shadow_brush, 15, 25)
			graph.draw_string_string_font_brush_real_real (title_text, title_font, text_texture_brush, 10, 20)

			text_to_draw := ("Hello Symetrical World").to_cil

			-- Use Measure string to display a string at the center of the window
			window_center := display_rectangle.width / 2
			string_size := e.graphics.measure_string (text_to_draw, text_font)
			start_pos := window_center - (string_size.width / 2)
			graph.draw_string_string_font_brush_real_real (text_to_draw, text_font, create {DRAWING_SOLID_BRUSH}.make (feature {DRAWING_COLOR}.red), start_pos, 10)

			-- Now draw a string flowed into a rectangle
			rectangle_11.make_with_x (20, 150, 250, 300)
			rectangle_12.make_with_x (20, 150, 250, 300)
			graph.fill_rectangle (create {DRAWING_SOLID_BRUSH}.make (feature {DRAWING_COLOR}.gainsboro), rectangle_12)
			graph.draw_string (flowed_text_1, text_font, create {DRAWING_SOLID_BRUSH}.make (feature {DRAWING_COLOR}.blue), rectangle_11)

			-- Draw more flowed text but this time center it
			rectangle_21.make_with_x (450, 150, 250, 300)
			rectangle_22.make_with_x (450, 150, 250, 300)
			graph.fill_rectangle (create {DRAWING_SOLID_BRUSH}.make (feature {DRAWING_COLOR}.gainsboro), rectangle_22)
			create format.make
			format.set_alignment (feature {DRAWING_STRING_ALIGNMENT}.center)
			graph.draw_string_string_font_brush_rectangle_f_string_format (flowed_text_2, text_font, create {DRAWING_SOLID_BRUSH}.make (feature {DRAWING_COLOR}.Blue), rectangle_21, format)

			-- Work out how many lines and characters we printed just now
--			dummy := e.graphics.measure_string_string_font_size_f_string_format_integer (flowed_text_2, text_font, rectangle_21.size, format, characters, lines)
--			what_rendered_text := feature {SYSTEM_STRING}.concact_string_string_string_string (("We printed ").to_cil + characters.to_string + (" characters and ").to_cil + lines.to_string + " lines")
--			e.graphics.draw_string (what_rendered_text, text_font, create {DRAWING_SOLID_BRUSH}.make (feature {DRAWING_COLOR}.Black), 400,440)

			-- If we have the Japanese language pack draw some text in Japanese
			-- Rotate it to make life truly exciting
--			if do_japanese_sample then
--				graph.rotate_transform (-30)
--				graph.translate_transform (-180, 300)
--				graph.draw_string_string_font_brush_real_real (japanese_text, japanese_font, linear_grad_brush, 200, 140)
--				graph.reset_transform
--			end
		end

	initialize_component is
			-- 
		local
			l_size: DRAWING_SIZE
		do
			create components.make
			l_size.make_from_width_and_height (750, 500)
			set_size (l_size)
			set_text (("GDI+ Text Samples").to_cil)
		end

			
end -- Class GDIP_TEXT