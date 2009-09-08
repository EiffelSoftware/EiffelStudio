note
	description: "Summary description for {NS_GRAPHICS_CONTEXT_API}."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_GRAPHICS_CONTEXT_API

feature -- Creating a Graphics Context

	frozen graphics_context_with_attributes (a_attributes: POINTER): POINTER
			-- + (NSGraphicsContext *)graphicsContextWithAttributes: (NSDictionary *) attributes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSGraphicsContext graphicsContextWithAttributes: $a_attributes];"
		end

	frozen graphics_context_with_bitmap_image_rep (a_bitmap_rep: POINTER): POINTER
			-- + (NSGraphicsContext *)graphicsContextWithBitmapImageRep: (NSBitmapImageRep *) bitmapRep
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSGraphicsContext graphicsContextWithBitmapImageRep: $a_bitmap_rep];"
		end

	frozen graphics_context_with_graphics_port_flipped (a_graphics_port: POINTER; a_initial_flipped_state: BOOLEAN): POINTER
			-- + (NSGraphicsContext *)graphicsContextWithGraphicsPort: (void *) graphicsPort flipped: (BOOL) initialFlippedState
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSGraphicsContext graphicsContextWithGraphicsPort: $a_graphics_port flipped: $a_initial_flipped_state];"
		end

	frozen graphics_context_with_window (a_window: POINTER): POINTER
			-- + (NSGraphicsContext *)graphicsContextWithWindow: (NSWindow *) window
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSGraphicsContext graphicsContextWithWindow: $a_window];"
		end

feature -- Managing the Current Context

	frozen current_context : POINTER
			-- + (NSGraphicsContext *)currentContext
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSGraphicsContext currentContext];"
		end

	frozen set_current_context (a_context: POINTER)
			-- + (void)setCurrentContext: (NSGraphicsContext *) context
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSGraphicsContext setCurrentContext: $a_context];"
		end

	frozen graphics_port (a_ns_graphics_context: POINTER): POINTER
			-- - (void *)graphicsPort
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSGraphicsContext*)$a_ns_graphics_context graphicsPort];"
		end

feature -- Managing the Graphics State

	frozen set_graphics_state (a_g_state: INTEGER)
			-- + (void)setGraphicsState: (NSInteger) gState
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSGraphicsContext setGraphicsState: $a_g_state];"
		end

	frozen restore_graphics_state (a_ns_graphics_context: POINTER)
			-- - (void)restoreGraphicsState
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSGraphicsContext*)$a_ns_graphics_context restoreGraphicsState];"
		end
-- Error generating restoreGraphicsState: Message signature for feature not set

	frozen save_graphics_state (a_ns_graphics_context: POINTER)
			-- - (void)saveGraphicsState
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSGraphicsContext*)$a_ns_graphics_context saveGraphicsState];"
		end
-- Error generating saveGraphicsState: Message signature for feature not set

feature -- Testing the Drawing Destination

	frozen current_context_drawing_to_screen : BOOLEAN
			-- + (BOOL)currentContextDrawingToScreen
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSGraphicsContext currentContextDrawingToScreen];"
		end

	frozen is_drawing_to_screen (a_ns_graphics_context: POINTER): BOOLEAN
			-- - (BOOL)isDrawingToScreen
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSGraphicsContext*)$a_ns_graphics_context isDrawingToScreen];"
		end

feature -- Getting Information About a Context

	frozen attributes (a_ns_graphics_context: POINTER): POINTER
			-- - (NSDictionary *)attributes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSGraphicsContext*)$a_ns_graphics_context attributes];"
		end

	frozen is_flipped (a_ns_graphics_context: POINTER): BOOLEAN
			-- - (BOOL)isFlipped
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSGraphicsContext*)$a_ns_graphics_context isFlipped];"
		end

feature -- Flushing Graphics to the Context

	frozen flush_graphics (a_ns_graphics_context: POINTER)
			-- - (void)flushGraphics
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSGraphicsContext*)$a_ns_graphics_context flushGraphics];"
		end

feature -- Managing the Focus Stack

	frozen focus_stack (a_ns_graphics_context: POINTER): POINTER
			-- - (id)focusStack
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSGraphicsContext*)$a_ns_graphics_context focusStack];"
		end

	frozen set_focus_stack (a_ns_graphics_context: POINTER; a_stack: POINTER)
			-- - (void)setFocusStack: (id) stack
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSGraphicsContext*)$a_ns_graphics_context setFocusStack: $a_stack];"
		end

feature -- Configuring Rendering Options

	frozen set_compositing_operation (a_ns_graphics_context: POINTER; a_operation: NATURAL)
			-- - (void)setCompositingOperation: (NSCompositingOperation) operation
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSGraphicsContext*)$a_ns_graphics_context setCompositingOperation: $a_operation];"
		end

	frozen compositing_operation (a_ns_graphics_context: POINTER): NATURAL
			-- - (NSCompositingOperation)compositingOperation
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSGraphicsContext*)$a_ns_graphics_context compositingOperation];"
		end

	frozen set_image_interpolation (a_ns_graphics_context: POINTER; a_interpolation: NATURAL)
			-- - (void)setImageInterpolation: (NSImageInterpolation) interpolation
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSGraphicsContext*)$a_ns_graphics_context setImageInterpolation: $a_interpolation];"
		end

	frozen image_interpolation (a_ns_graphics_context: POINTER): NATURAL
			-- - (NSImageInterpolation)imageInterpolation
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSGraphicsContext*)$a_ns_graphics_context imageInterpolation];"
		end

	frozen set_should_antialias (a_ns_graphics_context: POINTER; a_antialias: BOOLEAN)
			-- - (void)setShouldAntialias: (BOOL) antialias
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSGraphicsContext*)$a_ns_graphics_context setShouldAntialias: $a_antialias];"
		end

	frozen should_antialias (a_ns_graphics_context: POINTER): BOOLEAN
			-- - (BOOL)shouldAntialias
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSGraphicsContext*)$a_ns_graphics_context shouldAntialias];"
		end

	frozen set_pattern_phase (a_ns_graphics_context: POINTER; a_phase: POINTER)
			-- - (void)setPatternPhase: (NSPoint) phase
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSGraphicsContext*)$a_ns_graphics_context setPatternPhase: *(NSPoint*)$a_phase];"
		end

	frozen pattern_phase (a_ns_graphics_context: POINTER; res: POINTER)
			-- - (NSPoint)patternPhase
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSPoint point = [(NSGraphicsContext*)$a_ns_graphics_context patternPhase]; memcpy($res, &point, sizeof(NSPoint));"
		end

feature -- Getting the Core Image Context

	frozen ci_context (a_ns_graphics_context: POINTER): POINTER
			-- - (CIContext *)CIContext
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSGraphicsContext*)$a_ns_graphics_context CIContext];"
		end

feature -- Managing the Color Rendering Intent

	frozen color_rendering_intent (a_ns_graphics_context: POINTER): INTEGER
			-- - (NSColorRenderingIntent)colorRenderingIntent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSGraphicsContext*)$a_ns_graphics_context colorRenderingIntent];"
		end

	frozen set_color_rendering_intent (a_ns_graphics_context: POINTER; a_rendering_intent: INTEGER)
			-- - (void)setColorRenderingIntent: (NSColorRenderingIntent) renderingIntent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSGraphicsContext*)$a_ns_graphics_context setColorRenderingIntent: $a_rendering_intent];"
		end

end
