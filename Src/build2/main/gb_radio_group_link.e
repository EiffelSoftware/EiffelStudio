indexing
	description: "Objects that represent a displayable radio link."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	
class
	GB_RADIO_GROUP_LINK
	
inherit
	EV_LIST_ITEM
		undefine
			is_in_default_state
		redefine
			initialize
		end
	
	GB_DEFAULT_STATE
	
	GB_SHARED_TOOLS
		undefine
			default_create, 
			copy
		end
	
create
	default_create
	
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_LIST_ITEM}
			pointer_button_press_actions.force_extend (agent start_animation (?, ?, ?))
		end
		

feature -- Access

	object: GB_OBJECT
			-- Object linked by `Current'.
			
	gb_ev_container: GB_EV_CONTAINER
			-- Creator of `Current'.

feature -- Status setting

	set_object (an_object: GB_OBJECT) is
			-- Assign `an_object' to `object'.
		require
			object_not_void: an_object /= Void
		do
			object := an_object
			update_displayed_text
		ensure
			object_set: object = an_object
		end
		
	set_gb_ev_container (a_container: GB_EV_CONTAINER) is
			-- Assign `a_container' to `gb_ev_container'.
		require
			container_not_void: a_container /= Void
		do
			gb_ev_container := a_container
		ensure
			container_set: gb_ev_container = a_container
		end
		
feature {GB_EV_CONTAINER} -- Implementation

	update_displayed_text is
			--  Display text on `Current' detailing `object'.
		do
			if object.name.is_empty then
				set_text ("unnamed " + Object.short_type)
			else
				set_text (object.name)
			end
		ensure
			text_not_empty: not text.is_empty
		end
		
feature {NONE} -- Implementation

	start_animation (x, y, button: INTEGER) is
			-- Start animation on `layout_item' of `object'.
		local
			layout_item:GB_LAYOUT_CONSTRUCTOR_ITEM
		do
				-- Only animate item if left button is pressed.
				-- We do not want to perform an animation if
				-- a pick is started.
			if button = 1 then
				layout_item := object.layout_item
				if not layout_item.is_animated then
					layout_item.enable_animation
					create timer.make_with_interval (25)
					timer.actions.extend (agent animate)
					original_pixmap := layout_item.pixmap
					layout_constructor.ensure_object_visible (object)
				end
			end
		end
		
	animate is
			-- `animate' layout_item' of `obejct'.
		local
			current_pixmap: EV_PIXMAP
			a_cell: EV_CELL
			layout_item:GB_LAYOUT_CONSTRUCTOR_ITEM
			new_pixmap: EV_PIXMAP
		do
			layout_item := object.layout_item
			create new_pixmap
				-- We have to place `new_pixmap' into a container
				-- to force it to have a widget implementation.
				-- Otherwise, there is a bug on Windows, and you
				-- get a nice black pixmap displayed in the tree.
			create a_cell
			a_cell.extend (new_pixmap)
			new_pixmap.set_size (16, 16)
			new_pixmap.draw_pixmap (timer.count \\ 16, 0, original_pixmap)
			new_pixmap.draw_pixmap ((timer.count \\ 16) - 16, 0, original_pixmap)

				-- We get some artifacts on Windows, so for the final display,
				-- revert back to the original pixmap
			if timer.count = 16 then
				timer.destroy
				timer := Void
				layout_item.set_pixmap (original_pixmap)
				layout_item.disable_animation
			else
				layout_item.set_pixmap (new_pixmap)
			end
		end
		
	original_pixmap: EV_PIXMAP
		-- Orignal pixmap of layout item that is being animated.
		-- Needed for animation and finally restoration purposes.

		
	timer: EV_TIMEOUT
		-- Timer for layout constructor animation.
		
end -- class GB_RADIO_GROUP_LINK
