note
	description: "Summary description for {NS_GRAPHICS_CONTEXT}."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_GRAPHICS_CONTEXT

inherit
	NS_OBJECT

create
	graphics_context_with_attributes,
	graphics_context_with_bitmap_image_rep,
	graphics_context_with_graphics_port_flipped,
	graphics_context_with_window,
	current_context
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature -- Creating a Graphics Context

	graphics_context_with_attributes (a_attributes: NS_DICTIONARY)
			-- Instantiates and returns an instance of `NSGraphicsContext' using the specified attributes.
		do
			share_from_pointer ({NS_GRAPHICS_CONTEXT_API}.graphics_context_with_attributes (a_attributes.item))
		end

	graphics_context_with_bitmap_image_rep (a_bitmap_rep: NS_BITMAP_IMAGE_REP)
			-- Instantiates and returns a new graphics context using the supplied `NSBitmapImageRep' object as the context destination.
		do
			share_from_pointer ({NS_GRAPHICS_CONTEXT_API}.graphics_context_with_bitmap_image_rep (a_bitmap_rep.item))
		end

	graphics_context_with_graphics_port_flipped (a_graphics_port: POINTER; a_initial_flipped_state: BOOLEAN)
			-- Instantiates and returns a new graphics context from the given graphics port.
		do
			share_from_pointer ({NS_GRAPHICS_CONTEXT_API}.graphics_context_with_graphics_port_flipped (a_graphics_port.item, a_initial_flipped_state))
		end

	graphics_context_with_window (a_window: NS_WINDOW)
			-- Creates and returns a new graphics context for drawing into a window.
		do
			share_from_pointer ({NS_GRAPHICS_CONTEXT_API}.graphics_context_with_window (a_window.item))
		end

feature -- Managing the Current Context

	current_context
			-- Returns the current graphics context of the current thread.
		do
			share_from_pointer ({NS_GRAPHICS_CONTEXT_API}.current_context)
		end

	set_current_context (a_context: NS_GRAPHICS_CONTEXT)
			-- Sets the current graphics context of the current thread.
		do
			{NS_GRAPHICS_CONTEXT_API}.set_current_context (a_context.item)
		end

	graphics_port: POINTER
			-- Returns the low-level, platform-specific graphics context represented by the receiver.
		do
			Result := {NS_GRAPHICS_CONTEXT_API}.graphics_port (item)
		end

feature -- Managing the Graphics State

	set_graphics_state (a_g_state: INTEGER)
			-- Makes the graphics context of the specified graphics state current, and resets graphics state.
		do
			{NS_GRAPHICS_CONTEXT_API}.set_graphics_state (a_g_state)
		end

	restore_graphics_state
			-- Pops a graphics context from the per-thread stack, makes it current, and sends the context a `restoreGraphicsState' message.
		do
			{NS_GRAPHICS_CONTEXT_API}.restore_graphics_state (item)
		end
-- Error generating restoreGraphicsState: Message signature for feature not set

	save_graphics_state
			-- Saves the graphics state of the current graphics context.
		do
			{NS_GRAPHICS_CONTEXT_API}.save_graphics_state (item)
		end
-- Error generating saveGraphicsState: Message signature for feature not set

feature -- Testing the Drawing Destination

	current_context_drawing_to_screen: BOOLEAN
			-- Returns a Boolean value that indicates whether the current context is drawing to the screen.
		do
			Result := {NS_GRAPHICS_CONTEXT_API}.current_context_drawing_to_screen ()
		end

	is_drawing_to_screen: BOOLEAN
			-- Returns a Boolean value that indicates whether the drawing destination is the screen.
		do
			Result := {NS_GRAPHICS_CONTEXT_API}.is_drawing_to_screen (item)
		end

feature -- Getting Information About a Context

	attributes: NS_DICTIONARY
			-- Returns the receiver`s attributes.
		do
			create Result.share_from_pointer ({NS_GRAPHICS_CONTEXT_API}.attributes (item))
		end

	is_flipped: BOOLEAN
			-- Returns a Boolean value that indicates the receiver`s flipped state.
		do
			Result := {NS_GRAPHICS_CONTEXT_API}.is_flipped (item)
		end

feature -- Flushing Graphics to the Context

	flush_graphics
			-- Forces any buffered operations or data to be sent to the receiver`s destination.
		do
			{NS_GRAPHICS_CONTEXT_API}.flush_graphics (item)
		end

feature -- Configuring Rendering Options

	set_compositing_operation (a_operation: NATURAL)
			-- Sets the receiver`s global compositing operation.
		do
			{NS_GRAPHICS_CONTEXT_API}.set_compositing_operation (item, a_operation)
		end

	compositing_operation: NATURAL
			-- Returns the receiver`s global compositing operation setting.
		do
			Result := {NS_GRAPHICS_CONTEXT_API}.compositing_operation (item)
		end

	set_image_interpolation (a_interpolation: NATURAL)
			-- Sets the receiver`s interpolation behavior.
		do
			{NS_GRAPHICS_CONTEXT_API}.set_image_interpolation (item, a_interpolation)
		end

	image_interpolation: NATURAL
			-- Returns a constant that specifies the receiver`s interpolation behavior.
		do
			Result := {NS_GRAPHICS_CONTEXT_API}.image_interpolation (item)
		end

	set_should_antialias (a_antialias: BOOLEAN)
			-- Sets whether the receiver should use antialiasing.
		do
			{NS_GRAPHICS_CONTEXT_API}.set_should_antialias (item, a_antialias)
		end

	should_antialias: BOOLEAN
			-- Returns a Boolean value that indicates whether the receiver uses antialiasing.
		do
			Result := {NS_GRAPHICS_CONTEXT_API}.should_antialias (item)
		end

	set_pattern_phase (a_phase: NS_POINT)
			-- Sets the amount to offset the pattern color when filling the receiver.
		do
			{NS_GRAPHICS_CONTEXT_API}.set_pattern_phase (item, a_phase.item)
		end

	pattern_phase: NS_POINT
			-- Returns the amount to offset the pattern color when filling the receiver.
		do
			create Result.make
			{NS_GRAPHICS_CONTEXT_API}.pattern_phase (item, Result.item)
		end

feature -- Getting the Core Image Context

	ci_context: POINTER
			-- Returns a `CIContext' object that you can use to render into the receiver.
		do
			Result := {NS_GRAPHICS_CONTEXT_API}.ci_context (item)
		end

feature -- Managing the Color Rendering Intent

	color_rendering_intent: INTEGER
			-- Returns the current rendering intent in the receiver`s graphics state.
		do
			Result := {NS_GRAPHICS_CONTEXT_API}.color_rendering_intent (item)
		end

	set_color_rendering_intent (a_rendering_intent: INTEGER)
			-- Sets the rendering intent in the receiver`s graphics state.
		do
			{NS_GRAPHICS_CONTEXT_API}.set_color_rendering_intent (item, a_rendering_intent)
		end

end
