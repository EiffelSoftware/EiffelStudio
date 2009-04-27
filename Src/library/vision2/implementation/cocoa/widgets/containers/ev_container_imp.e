indexing
	description:
		"Eiffel Vision container, Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CONTAINER_IMP

inherit
	EV_CONTAINER_I
		redefine
			interface,
			propagate_foreground_color,
			propagate_background_color
		end

	EV_WIDGET_IMP
		undefine
			ev_apply_new_size,
			minimum_width,
			minimum_height
		redefine
			interface,
			initialize,
			destroy
		end

	EV_SIZEABLE_CONTAINER_IMP
		redefine
			interface
		end

	EV_CONTAINER_ACTION_SEQUENCES_IMP

	PLATFORM

feature {NONE}

	initialize
		do
			Precursor
			initialize_sizeable
		end

feature -- Access

	client_width: INTEGER
			-- Width of the client area of container.
			-- Redefined in children.
		do
			Result := width
		end

	client_height: INTEGER
			-- Height of the client area of container
			-- Redefined in children.
		do
			Result := height
		end

	background_pixmap: EV_PIXMAP
			-- the background pixmap

	item_imp: EV_WIDGET_IMP
			-- `item'.`implementation'.
		do
			if item /= Void then
				Result ?= item.implementation
			end
		end

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		deferred

		end

feature -- Status setting

	connect_radio_grouping (a_container: EV_CONTAINER)
			-- Join radio grouping of `a_container' to `Current'.
		do
		end

	unconnect_radio_grouping (a_container: EV_CONTAINER)
			-- Remove Join of `a_container' to radio grouping of `Current'.
		do
		end

	add_radio_button (a_widget_imp: EV_WIDGET_IMP)
			-- Called every time a widget is added to the container.
		require
			a_widget_imp_not_void: a_widget_imp /= Void
		do
		end

	remove_radio_button (a_widget_imp: EV_WIDGET_IMP)
			-- Called every time a widget is removed from the container.
		require
			a_widget_imp_not_void: a_widget_imp /= Void
		do
		end

	internal_set_background_pixmap (a_pixmap: EV_PIXMAP)
			-- Set the container background pixmap to `pixmap'.
		do
		end

	set_background_pixmap (a_pixmap: EV_PIXMAP)
			-- Set the container background pixmap to `pixmap'.
		do
		end

	bg_pixmap (p: POINTER): POINTER
		do
		end

	remove_background_pixmap
			-- Make background pixmap Void.
		do
		end

feature -- Basic operations

	propagate_foreground_color
			-- Propagate the current foreground color of the
			-- container to the children.
		do
			--precursor {EV_CONTAINER_PI}

		end

	propagate_background_color
			-- Propagate the current background color of the
			-- container to the children.
		do
			Precursor {EV_CONTAINER_I}
		end

feature -- Command

	destroy
			-- Render `Current' unusable.
		do
--			if interface.prunable then
--				interface.wipe_out
--			end
			Precursor {EV_WIDGET_IMP}
		end

feature -- Event handling

	on_new_item (an_item_imp: EV_WIDGET_IMP)
			-- Called after `an_item' is added.
		do
			an_item_imp.set_parent_imp (Current)
			notify_change (Nc_minsize, Current)
		end

	on_removed_item (an_item_imp: EV_WIDGET_IMP)
			-- Called just before `an_item' is removed.
		do
			an_item_imp.set_parent_imp (Void)
			notify_change (Nc_minsize, Current)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_CONTAINER_IMP

