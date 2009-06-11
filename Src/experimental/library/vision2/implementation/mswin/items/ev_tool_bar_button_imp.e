note
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

	pointer_style: detachable EV_POINTER_STYLE
			--
		do

		end

	wel_has_capture: BOOLEAN
			--
		do

		end

feature -- Initialization

	old_make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Do post creation initialization.
		do
			make_id
			create real_text.make (0)
			is_sensitive := True
			set_is_initialized (True)
		end

	parent_imp: detachable EV_TOOL_BAR_IMP
		-- The parent of `Current'.

feature -- Access

	wel_text: STRING_32
			-- Text of `Current'
		do
			if attached real_text as l_real_text then
				Result := l_real_text.twin
			else
				Result := ""
			end
		end

	text_length: INTEGER
			-- Number of characters of `real_text'.
		do
			if attached real_text as l_real_text then
				Result := l_real_text.count
			end
		end

	real_text: detachable STRING_32
			-- Internal `text'. Not to be returned directly. Use clone.

	index: INTEGER
			-- Index of the current item.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.internal_get_index (Current) + 1
			end
		end

	set_parent_imp (a_parent_imp: like parent_imp)
			-- Make `a_parent_imp' the new parent of `Current'.
			-- `a_parent_imp' can be Void then the parent is the screen.
		do
			if a_parent_imp /= Void then
				parent_imp := a_parent_imp
				a_parent_imp.auto_size
			else
				parent_imp := Void
			end
		end

	gray_pixmap: detachable EV_PIXMAP
			-- Pixmap of `Current'.
		local
			pix_imp: detachable EV_PIXMAP_IMP
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
					if attached parent_imp as l_parent_imp and then attached l_parent_imp.default_imagelist as l_default_imagelist then
						image_list := l_default_imagelist
						image_icon := l_default_imagelist.get_icon (image_index, Ild_normal)
						pix_imp.set_with_resource (image_icon)
					else
						check False end
					end
				else
					Result := private_gray_pixmap
				end
			end
		end

	pixmap: detachable EV_PIXMAP
			-- Pixmap of `Current'.
		local
			pix_imp: detachable EV_PIXMAP_IMP
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
					if attached parent_imp as l_parent_imp and then attached l_parent_imp.hot_imagelist as l_hot_imagelist then
						an_icon := l_hot_imagelist.get_icon (image_index, Ild_normal)
						an_icon.enable_reference_tracking
						pix_imp.set_with_resource (an_icon)
						an_icon.decrement_reference
					else
						check False end
					end
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

	enable_sensitive
			 -- Enable `Current'.
		do
			enabled_before := is_sensitive
			enable_sensitive_internal
		end

	disable_sensitive
			 -- Disable `Current'.
		do
			enabled_before := is_sensitive
			disable_sensitive_internal
		end

	enable_sensitive_internal
			 -- Enable `Current'.
			 -- This is a special version used internally by the code that updates
			 -- the pick and drop so that `enabled_before' is not updated. In
			 -- `enable_sensitive' which is called by a user, we must always updated the
			 -- state of `enabled_before' so that if it is called during a pick and drop,
			 -- this new state is respected at the end of the transport.
		do
			is_sensitive := True
			if attached parent_imp as l_parent_imp then
				l_parent_imp.enable_button (id)
			end
		end

	disable_sensitive_internal
			 -- Disable `Current'.
			 -- This is a special version used internally by the code that updates
			 -- the pick and drop so that `enabled_before' is not updated. In
			 -- `disable_sensitive' which is called by a user, we must always updated the
			 -- state of `enabled_before' so that if it is called during a pick and drop,
			 -- this new state is respected at the end of the transport.
		do
			is_sensitive := False
			if attached parent_imp as l_parent_imp then
				l_parent_imp.disable_button (id)
			end
		end

	parent_is_sensitive: BOOLEAN
			-- Is parent of `Current' sensitive?
		do
			if attached parent_imp as l_parent_imp and then l_parent_imp.is_sensitive then
				Result := True
			end
		end

	has_parent: BOOLEAN
			-- Is `Current' parented?
		do
			if parent_imp /= Void then
				result := True
			end
		end

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Assign `a_tooltip' to `internal_tooltip_string'.
		do
			internal_tooltip_string := a_tooltip.as_string_32
			if internal_tooltip_string = a_tooltip then
				internal_tooltip_string := a_tooltip.as_string_32.string
			end
		end

feature -- Element change

	wel_set_text (txt: STRING_GENERAL)
			-- Make `txt' the new label of `Current'.
		do
			if txt /= Void then
				real_text := txt.twin
			end
			if attached parent_imp as l_parent_imp then
				l_parent_imp.internal_reset_button (Current)
				l_parent_imp.auto_size
			end
		end

	set_pixmap (p: EV_PIXMAP)
			-- Assign `p' to the displayed pixmap.
		do
				-- We must destroy the pixmap before we set a new one,
				-- to ensure that we free up Windows GDI objects
			if attached private_pixmap as l_private_pixmap then
				l_private_pixmap.destroy
				private_pixmap := Void
			end
			private_pixmap := p.twin
			has_pixmap := True

				-- If the item is currently contained in the toolbar then
			if attached parent_imp as l_parent_imp then
				l_parent_imp.internal_reset_button (Current)
			end
		end

	remove_pixmap
			-- Remove pixmap from `Current'.
		do
			if has_pixmap then
				has_pixmap := False
				if attached private_pixmap as l_private_pixmap then
					l_private_pixmap.destroy
					private_pixmap := Void
				end

					-- If the item is currently contained in the toolbar then
				if attached parent_imp as l_parent_imp then
					l_parent_imp.internal_reset_button (Current)
				end
			end
		end

	set_gray_pixmap (p: EV_PIXMAP)
			-- Assign `p' to the displayed gray pixmap.
		local
			l_private_gray_pixmap: like private_gray_pixmap
		do
			l_private_gray_pixmap := private_gray_pixmap
			if l_private_gray_pixmap /= Void then
				l_private_gray_pixmap.destroy
				private_gray_pixmap := Void
			end
			create l_private_gray_pixmap
			l_private_gray_pixmap.copy (p)
			private_gray_pixmap := l_private_gray_pixmap

			has_gray_pixmap := True

				-- If the item is currently contained in the toolbar then
			if has_pixmap and attached parent_imp as l_parent_imp then
				l_parent_imp.internal_reset_button (Current)
			end
		end

	remove_gray_pixmap
			-- Remove pixmap from `Current'.
		do
			if has_gray_pixmap then
				has_gray_pixmap := False
				if attached private_gray_pixmap as l_private_gray_pixmap then
					l_private_gray_pixmap.destroy
					private_gray_pixmap := Void
				end

					-- If the item is currently contained in the toolbar then
				if attached parent_imp as l_parent_imp then
					l_parent_imp.internal_reset_button (Current)
				end
			end
		end

	set_pixmap_in_parent
			-- Add the pixmap to the parent by updating the
			-- parent's image list.
		local
			default_imagelist: detachable EV_IMAGE_LIST_IMP
			hot_imagelist: detachable EV_IMAGE_LIST_IMP
			local_pixmap: detachable EV_PIXMAP
			local_gray_pixmap: detachable EV_PIXMAP
			gray_pixmap_position: INTEGER
			pixmap_position: INTEGER
			l_parent_imp: like parent_imp
			l_private_pixmap: like private_pixmap
		do
			l_parent_imp := parent_imp
			check l_parent_imp /= Void end
			default_imagelist := l_parent_imp.default_imagelist
			if l_parent_imp.has_false_image_list and has_pixmap then
					-- In this situation, a false image list is being used in `parent_imp' to
					-- ensure buttons are displayed at their minimum sizes. We remove this image
					-- list as `Current' has an image and we wish to use this with a new image list.
				l_parent_imp.remove_image_list
				default_imagelist := Void
			end

			l_private_pixmap := private_pixmap

				-- Create the image list and associate it
				-- to the control if it's not already done.
			if default_imagelist = Void then
				if has_pixmap then
					check l_private_pixmap /= Void end
					l_parent_imp.setup_image_list (l_private_pixmap.width, l_private_pixmap.height)
					l_parent_imp.disable_false_image_list
				else

						-- Now set up an empty image list in `parent_imp' with a size 1x1.
						-- This ensures that when no pixmap is associated with an item, the button is
						-- approximately the size of the text only.
					l_parent_imp.enable_false_image_list
					l_parent_imp.setup_image_list (1, 1)
					default_imagelist := l_parent_imp.default_imagelist
					hot_imagelist := l_parent_imp.hot_imagelist
					image_index := -1
				end
			end

			if private_pixmap = Void and private_gray_pixmap = Void then
				-- image_index is already up-to-date.
			else
				default_imagelist := l_parent_imp.default_imagelist
				hot_imagelist := l_parent_imp.hot_imagelist

				local_pixmap := private_pixmap
				if local_pixmap = Void then
					local_pixmap := pixmap
				end
				check local_pixmap /= Void end

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
				check local_gray_pixmap /= Void end
					-- Look for `gray_pixmap' and `pixmap' in the imagelist
				check default_imagelist /= Void end
				check hot_imagelist /= Void end
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
				check l_private_pixmap /= Void end
				l_private_pixmap.destroy
				private_pixmap := Void
				if attached private_gray_pixmap as l_private_gray_pixmap then
					l_private_gray_pixmap.destroy
					private_gray_pixmap := Void
				end
			end
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.child_x (attached_interface)
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.child_y (attached_interface)
			end
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.child_x_absolute (attached_interface)
			end
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.child_y_absolute (attached_interface)
			end
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.child_width (attached_interface)
			end
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.child_height (attached_interface)
			end
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
			Result := width
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
			Result := height
		end

feature {EV_TOOL_BAR_IMP} -- Implementation

	restore_private_pixmaps
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

	private_gray_pixmap: detachable EV_PIXMAP
			-- Internal gray pixmap for Current. Void if none.

	destroy
			-- Destroy `Current'.
		do
			Precursor {EV_TOOL_BAR_ITEM_IMP}
			if attached private_pixmap as l_private_pixmap then
				l_private_pixmap.destroy
			end
			if attached private_gray_pixmap as l_private_gray_pixmap then
				l_private_gray_pixmap.destroy
			end
		end


feature {NONE} -- Implementation, pick and drop

	widget_source: detachable EV_WIDGET_IMP
			-- Widget drag source used for transport.
		do
			Result := parent_imp
		end

feature {EV_ANY, EV_ANY_I} -- Interface

	interface: detachable EV_TOOL_BAR_BUTTON note option: stable attribute end;

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

end -- class EV_TOOL_BAR_BUTTON_IMP
