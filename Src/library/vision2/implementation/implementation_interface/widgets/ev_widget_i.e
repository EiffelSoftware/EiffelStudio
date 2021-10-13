note
	description:
		"Eiffel Vision widget, implementation interface.%N%
		%See bridge pattern notes in ev_any.e"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "widget, component, control"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_I

inherit
	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_DOCKABLE_SOURCE_I
		redefine
			interface
		end

	EV_SENSITIVE_I
		redefine
			interface
		end

	EV_COLORIZABLE_I
		redefine
			interface
		end

	EV_WIDGET_ACTION_SEQUENCES_I

	EV_HELP_CONTEXTABLE_I
		redefine
			interface,
			on_help_context_changed
		end

feature -- Basic operations

	refresh_now
			-- Force an immediate redraw of `Current'.
		deferred
		end

feature -- Access

	parent: detachable EV_CONTAINER
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		deferred
		end

	pointer_position: EV_COORDINATE
            -- Position of the screen pointer relative to `Current'.
		deferred
		ensure
			result_not_void: Result /= Void
		end

	pointer_style: detachable EV_POINTER_STYLE
			-- Cursor displayed when screen pointer is over current widget.
			-- Void if none has been set using `set_pointer_position'.
		deferred
		end

	internal_pointer_style: EV_POINTER_STYLE
			-- Cursor displayed when screen pointer is over current widget,
			-- as seen from interface.
		local
			text_component: detachable EV_TEXT_COMPONENT
			l_result: detachable EV_POINTER_STYLE
		do
			l_result := pointer_style
			if l_result = Void then
				text_component ?= Current
				if text_component /= Void then
					Result := Default_pixmaps.Ibeam_cursor
				else
					Result := Default_pixmaps.Standard_cursor
				end
			else
				Result := l_result
			end
		end

	actual_drop_target_agent: detachable FUNCTION [INTEGER, INTEGER, detachable EV_ABSTRACT_PICK_AND_DROPABLE]
			-- Overrides default drop target on a certain position.
			-- If `Void', will use the default drop target.
			-- Always void if `Current' is not a widget.

	real_target: detachable EV_DOCKABLE_TARGET
			-- `Result' is target used during a dockable transport if
			-- mouse pointer is above `Current'.

	default_key_processing_handler: detachable PREDICATE [EV_KEY]
			-- Agent used to determine whether the default key processing should occur for `Current'.
			-- If agent returns `True' then default key processing continues as normal, False prevents
			-- default key processing from occurring.

feature -- Status Report

	is_show_requested: BOOLEAN
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		deferred
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
			-- False if `Current' is entirely obscured by another window.
		deferred
		end

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		deferred
		end

	has_capture: BOOLEAN
			-- Does widget have capture?
		deferred
		end

feature -- Status setting

	hide
			-- Request that `Current' not be displayed when its parent is.
		deferred
		ensure
			--not_is_show_requested: not is_show_requested
			--| FIXME: does not hold when an action sequence is called as a result of hiding
			--| Current widget as this action sequence might call `show'.
		end

	show
			-- Request that `Current' be displayed when its parent is.
		deferred
		ensure
			--is_show_requested: is_show_requested
			--| FIXME: does not hold when an action sequence is called as a result of showing
			--| Current widget as this action sequence might call `hide'.
		end

	set_focus
			-- Grab keyboard focus.
		deferred
		ensure
			--has_focus: has_focus
			--| FIXME IEK Does not hold for non focus widgets such as box.
		end

	set_actual_drop_target_agent (an_agent: like actual_drop_target_agent)
			-- Assign `an_agent' to `actual_drop_target_agent'.
		require
			an_agent_not_void: an_agent /= Void
		local
			l_object_id: INTEGER
		do
			actual_drop_target_agent := an_agent;
			l_object_id := attached_interface.object_id;
			(create {EV_ENVIRONMENT}).implementation.application_i.pnd_targets.put (l_object_id, l_object_id)
		ensure
			assigned: actual_drop_target_agent = an_agent
		end

	set_real_target (a_target: EV_DOCKABLE_TARGET)
			-- Assign `a_target' to `real_target'.
		require
			target_not_void: a_target /= Void
		do
			real_target := a_target
		ensure
			assigned: real_target = a_target
		end

	remove_real_target
			-- Ensure `real_target' is `Void'.
		do
			real_target := Void
		ensure
			real_target_void: real_target = Void
		end

	set_default_key_processing_handler (a_handler: like default_key_processing_handler)
			-- Assign `default_key_processing_handler' to `a_handler'.
		do
			default_key_processing_handler := a_handler
		end

	remove_default_key_processing_handler
			-- Ensure `default_key_processing_handler' is Void.
		do
			default_key_processing_handler := Void
		ensure
			default_key_processing_handler_removed: default_key_processing_handler = Void
		end

feature -- Element change

	reset_minimum_width
			-- Reset the minimum width.
		deferred
		end

	reset_minimum_height
			-- Reset the minimum height.
		deferred
		end

	reset_minimum_size
			-- Reset the minimum size (width and height).
		deferred
		end

	set_minimum_width (a_minimum_width: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
		require
			a_minimum_width_positive: a_minimum_width >= 0
		deferred
		ensure
			minimum_width_assigned: is_usable implies
				((a_minimum_width > 0 implies attached_interface.minimum_width = a_minimum_width) or (a_minimum_width = 0 implies (attached_interface.minimum_width <= 1)))
		end

	set_minimum_height (a_minimum_height: INTEGER)
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		require
			a_minimum_height_positive: a_minimum_height >= 0
		deferred
		ensure
			minimum_height_assigned: is_usable implies
				((a_minimum_height > 0 implies attached_interface.minimum_height = a_minimum_height) or (a_minimum_height = 0 implies (attached_interface.minimum_height <= 1)))
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		require
			a_minimum_width_positive: a_minimum_width >= 0
			a_minimum_height_positive: a_minimum_height >= 0
		deferred
		ensure
			minimum_width_assigned: is_usable implies
				((a_minimum_width > 0 implies attached_interface.minimum_width = a_minimum_width) or (a_minimum_width = 0 implies (attached_interface.minimum_width <= 1)))
			minimum_height_assigned: is_usable implies
				((a_minimum_height > 0 implies attached_interface.minimum_height = a_minimum_height) or (a_minimum_height = 0 implies (attached_interface.minimum_height <= 1)))
		end

feature -- Measurement

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		deferred
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WIDGET note option: stable attribute end;
		-- Provides a common user interface to platform dependent functionality
		-- implemented by `Current'.
		-- (See bridge pattern notes in ev_any.e)

feature {EV_ANY_I} -- Implementation

	disable_default_processing_on_key (a_key: EV_KEY): BOOLEAN
			-- Should default processing of `Current' be disabled when `a_key' is press/released?
		do
			Result := attached default_key_processing_handler as l_default_key_processing_handler and then not l_default_key_processing_handler.item ([a_key])
		end

	on_parented
			-- `Current' is about to be put into a container.
		require
			parent_void: parent = Void
		do
		ensure
			parent_void: parent = Void
		end

	on_orphaned
			-- `Current' has just been removed from its container.
		require
			parent_void: parent = Void
		do
		ensure
			parent_void: parent = Void
		end

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		deferred
		end

feature {NONE} -- Implementation

	on_help_context_changed
			-- Connect help accelerators if not done already
		local
			top_window: detachable EV_TITLED_WINDOW_I
			a_parent: detachable EV_CONTAINER
		do
			from
				a_parent := parent
				top_window ?= Current
			until
				top_window /= Void or a_parent = Void
			loop
				top_window ?= a_parent.implementation
				a_parent := a_parent.parent
			end
			if top_window /= Void and then not top_window.help_enabled then
				top_window.enable_help
			end
		end

invariant
	is_displayed_implies_show_requested:
		is_usable and is_displayed implies is_show_requested

	--| FIXME IEK Not applicable for items that inherit from widget
	--| only on the implementation side such as T.B. Button
	--|parent_contains_current:
		--|is_usable and parent /= Void implies parent.has (interface)

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_WIDGET_I












