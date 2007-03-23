indexing
	description: " EiffelVision Toolbar button, mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			parent_imp, interface
		end

	EV_TOOL_BAR_ITEM_IMP
		undefine
			parent
		redefine
			set_pixmap, parent_imp,
			interface, pixmap,
			remove_pixmap, destroy
		end

	EV_INTERNALLY_PROCESSED_TEXTABLE_IMP
		redefine
			interface
		end

	EV_DOCKABLE_SOURCE_IMP
		redefine
			interface
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface, set_tooltip, destroy
		end

	WEL_ILC_CONSTANTS

	EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} --

	pointer_style: EV_POINTER_STYLE is
			--
		do

		end

	wel_has_capture: BOOLEAN is
			--
		do

		end

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			make_id
			create real_text.make (0)
		end

	initialize is
			-- Do post creation initialization.
		do
			is_sensitive := True
			set_is_initialized (True)
		end

	parent_imp: EV_TOOL_BAR_IMP
		-- The parent of `Current'.

feature -- Access

	wel_text: STRING_32 is
			-- Text of `Current'
		do
			if real_text /= Void then
				Result := real_text.twin
			end
		end

	text_length: INTEGER is
			-- Number of characters of `real_text'.
		do
			Result := real_text.count
		end

	real_text: STRING_32
			-- Internal `text'. Not to be returned directly. Use clone.

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current) + 1
		end

	set_parent_imp (a_parent_imp: like parent_imp) is
			-- Make `a_parent_imp' the new parent of `Current'.
			-- `a_parent_imp' can be Void then the parent is the screen.
		do
			if a_parent_imp /= Void then
				parent_imp := a_parent_imp
				parent_imp.auto_size
			else
				parent_imp := Void
			end
		end

	gray_pixmap: EV_PIXMAP is
			-- Pixmap of `Current'.
		local
			pix_imp: EV_PIXMAP_IMP
			image_icon: WEL_ICON
			image_list: EV_IMAGE_LIST_IMP
		do
				-- Retrieve the pixmap from the imagelist
			if has_gray_pixmap then
				if private_gray_pixmap = Void then
					create Result
					pix_imp ?= Result.implementation
					check
						pix_imp /= Void
					end
					image_list := parent_imp.default_imagelist
					image_icon := image_list.get_icon (image_index, Ild_normal)
					pix_imp.set_with_resource (image_icon)
				else
					Result := private_gray_pixmap
				end
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmap of `Current'.
		local
			pix_imp: EV_PIXMAP_IMP
			an_icon: WEL_ICON
		do
				-- Retrieve the pixmap from the imagelist
			if has_pixmap then
				if private_pixmap = Void then
					create Result
					pix_imp ?= Result.implementation
					check
						pix_imp /= Void
					end
					an_icon := parent_imp.hot_imagelist.get_icon (image_index, Ild_normal)
					an_icon.enable_reference_tracking
					pix_imp.set_with_resource (an_icon)
					an_icon.decrement_reference
				else
					Result := private_pixmap
				end
			end
		end

feature -- Status report

	is_sensitive: BOOLEAN
			-- Is `Current' sensitive?

	has_pixmap: BOOLEAN
			-- Has Current a pixmap?

	has_gray_pixmap: BOOLEAN
			-- Has Current a gray pixmap?

feature -- Status setting

	enable_sensitive is
			 -- Enable `Current'.
		do
			enabled_before := is_sensitive
			enable_sensitive_internal
		end

	disable_sensitive is
			 -- Disable `Current'.
		do
			enabled_before := is_sensitive
			disable_sensitive_internal
		end

	enable_sensitive_internal is
			 -- Enable `Current'.
			 -- This is a special version used internally by the code that updates
			 -- the pick and drop so that `enabled_before' is not updated. In
			 -- `enable_sensitive' which is called by a user, we must always updated the
			 -- state of `enabled_before' so that if it is called during a pick and drop,
			 -- this new state is respected at the end of the transport.
		do
			is_sensitive := True
			if parent_imp /= Void then
				parent_imp.enable_button (id)
			end
		end

	disable_sensitive_internal is
			 -- Disable `Current'.
			 -- This is a special version used internally by the code that updates
			 -- the pick and drop so that `enabled_before' is not updated. In
			 -- `disable_sensitive' which is called by a user, we must always updated the
			 -- state of `enabled_before' so that if it is called during a pick and drop,
			 -- this new state is respected at the end of the transport.
		do
			is_sensitive := False
			if parent_imp /= Void then
				parent_imp.disable_button (id)
			end
		end

	parent_is_sensitive: BOOLEAN is
			-- Is parent of `Current' sensitive?
		do
			if parent_imp /= Void and then parent_imp.is_sensitive then
				result := True
			end
		end

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		do
			if parent_imp /= Void then
				result := True
			end
		end

	set_tooltip (a_tooltip: STRING_GENERAL) is
			-- Assign `a_tooltip' to `internal_tooltip_string'.
		do
			internal_tooltip_string := a_tooltip.twin
		end


feature -- Element change

	wel_set_text (txt: STRING_GENERAL) is
			-- Make `txt' the new label of `Current'.
		do
			if txt /= Void then
				real_text := txt.twin
			end
			if parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
				parent_imp.auto_size
			end
		end

	set_pixmap (p: EV_PIXMAP) is
			-- Assign `p' to the displayed pixmap.
		do
				-- We must destroy the pixmap before we set a new one,
				-- to ensure that we free up Windows GDI objects
			if private_pixmap /= Void then
				private_pixmap.destroy
				private_pixmap := Void
			end
			private_pixmap := p.twin
			has_pixmap := True

				-- If the item is currently contained in the toolbar then
			if parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
			end
		end

	remove_pixmap is
			-- Remove pixmap from `Current'.
		do
			if has_pixmap then
				has_pixmap := False
				if private_pixmap /= Void then
					private_pixmap.destroy
					private_pixmap := Void
				end

					-- If the item is currently contained in the toolbar then
				if parent_imp /= Void then
					parent_imp.internal_reset_button (Current)
				end
			end
		end

	set_gray_pixmap (p: EV_PIXMAP) is
			-- Assign `p' to the displayed gray pixmap.
		do
			if private_gray_pixmap /= Void then
				private_gray_pixmap.destroy
				private_gray_pixmap := Void
			end
			private_gray_pixmap.copy (p)

			has_gray_pixmap := True

				-- If the item is currently contained in the toolbar then
			if has_pixmap and parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
			end
		end

	remove_gray_pixmap is
			-- Remove pixmap from `Current'.
		do
			if has_gray_pixmap then
				has_gray_pixmap := False
				if private_gray_pixmap /= Void then
					private_gray_pixmap.destroy
					private_gray_pixmap := Void
				end

					-- If the item is currently contained in the toolbar then
				if parent_imp /= Void then
					parent_imp.internal_reset_button (Current)
				end
			end
		end

	set_pixmap_in_parent is
			-- Add the pixmap to the parent by updating the
			-- parent's image list.
		local
			default_imagelist: EV_IMAGE_LIST_IMP
			hot_imagelist: EV_IMAGE_LIST_IMP
			local_pixmap: EV_PIXMAP
			local_gray_pixmap: EV_PIXMAP
			gray_pixmap_position: INTEGER
			pixmap_position: INTEGER
		do
			default_imagelist := parent_imp.default_imagelist
			if parent_imp.has_false_image_list and has_pixmap then
					-- In this situation, a false image list is being used in `parent_imp' to
					-- ensure buttons are displayed at their minimum sizes. We remove this image
					-- list as `Current' has an image and we wish to use this with a new image list.
				parent_imp.remove_image_list
				default_imagelist := Void
			end
				-- Create the image list and associate it
				-- to the control if it's not already done.
			if default_imagelist = Void then
				if has_pixmap then
					parent_imp.setup_image_list (private_pixmap.width, private_pixmap.height)
					parent_imp.disable_false_image_list
				else
						-- Now set up an empty image list in `parent_imp' with a size 1x1.
						-- This ensures that when no pixmap is associated with an item, the button is
						-- approximately the size of the text only.
					parent_imp.enable_false_image_list
					parent_imp.setup_image_list (1, 1)
					default_imagelist := parent_imp.default_imagelist
					hot_imagelist := parent_imp.hot_imagelist
					image_index := -1
				end
			end

			if private_pixmap = Void and private_gray_pixmap = Void then
				-- image_index is already up-to-date.
			else
				default_imagelist := parent_imp.default_imagelist
				hot_imagelist := parent_imp.hot_imagelist

				local_pixmap := private_pixmap
				if local_pixmap = Void then
					local_pixmap := pixmap
				end

				if has_gray_pixmap then
					local_gray_pixmap := private_gray_pixmap
					if local_gray_pixmap = Void then
						local_gray_pixmap := gray_pixmap
					end
				else
						-- No gray pixmap, so both normal and hot state will
						-- have the same bitmap.
					local_gray_pixmap := local_pixmap
				end

					-- Look for `gray_pixmap' and `pixmap' in the imagelist
				default_imagelist.pixmap_position (local_gray_pixmap)
				hot_imagelist.pixmap_position (local_pixmap)
				gray_pixmap_position := default_imagelist.last_position
				pixmap_position := hot_imagelist.last_position

				if pixmap_position = gray_pixmap_position and then
				   pixmap_position /= -1
				then
						-- Add pixmap. Take cached versions into account.
					default_imagelist.add_pixmap (local_gray_pixmap)
					hot_imagelist.add_pixmap (local_pixmap)
				else
						-- Add pixmap. Do not take cached versions into account.
					default_imagelist.extend_pixmap (local_gray_pixmap)
					hot_imagelist.extend_pixmap (local_pixmap)
				end
				check
					hot_and_default_imagelist_synchronized:
						default_imagelist.last_position = hot_imagelist.last_position
				end
				image_index := default_imagelist.last_position

					-- Destroy the pixmaps.
				if private_pixmap /= Void then
					private_pixmap.destroy
					private_pixmap := Void
				end
				if private_gray_pixmap /= Void then
					private_gray_pixmap.destroy
					private_gray_pixmap := Void
				end
			end
		end

feature -- Measurement

	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
			if parent_imp /= Void then
				Result := parent_imp.child_x (interface)
			end
		end

	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position' in pixels.
		do
			if parent_imp /= Void then
				Result := parent_imp.child_y (interface)
			end
		end

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		do
			if parent_imp /= Void then
				Result := parent_imp.child_x_absolute (interface)
			end
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen.
		do
			if parent_imp /= Void then
				Result := parent_imp.child_y_absolute (interface)
			end
		end

	width: INTEGER is
			-- Horizontal size in pixels.
		do
			if parent_imp /= Void then
				Result := parent_imp.child_width (interface)
			end
		end

	height: INTEGER is
			-- Vertical size in pixels.
		do
			if parent_imp /= Void then
				Result := parent_imp.child_height (interface)
			end
		end

	minimum_width: INTEGER is
			-- Minimum horizontal size in pixels.
		do
			Result := width
		end

	minimum_height: INTEGER is
			-- Minimum vertical size in pixels.
		do
			Result := height
		end

feature {EV_TOOL_BAR_IMP} -- Implementation

	restore_private_pixmaps is
			-- When `Current' is parented, `private_pixmap' and
			-- `private_gray_pixmap' are assigned Void. This is to stop
			-- us keeping to many references to GDI objects. When
			-- `Current' is removed from its parent, we must then
			-- restore them.
		do
			if has_pixmap then
				private_pixmap := pixmap
			end
			if has_gray_pixmap then
				private_gray_pixmap := gray_pixmap
			end
		end

feature {NONE} -- Implementation

	private_gray_pixmap: EV_PIXMAP
			-- Internal gray pixmap for Current. Void if none.

	destroy is
			-- Destroy `Current'.
		do
			Precursor {EV_TOOL_BAR_ITEM_IMP}
			if private_pixmap /= Void then
				private_pixmap.destroy
			end
			if private_gray_pixmap /= Void then
				private_gray_pixmap.destroy
			end
		end


feature {NONE} -- Implementation, pick and drop

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport.
		do
			Result := parent_imp
		end

feature {EV_ANY_I} -- Interface

	interface: EV_TOOL_BAR_BUTTON;

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




end -- class EV_TOOL_BAR_BUTTON_IMP

