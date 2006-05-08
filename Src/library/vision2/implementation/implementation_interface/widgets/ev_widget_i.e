indexing
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

	EV_POSITIONED_I
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

	refresh_now is
			-- Force an immediate redraw of `Current'.
		deferred
		end

feature -- Access

	parent: EV_CONTAINER is
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		deferred
		end

	pointer_position: EV_COORDINATE is
            -- Position of the screen pointer relative to `Current'.
		deferred
		end

	pointer_style: EV_CURSOR is
			-- Cursor displayed when screen pointer is over current widget.
			-- Void if none has been set using `set_pointer_position'.
		deferred
		end

	internal_pointer_style: EV_CURSOR is
			-- Cursor displayed when screen pointer is over current widget,
			-- as seen from interface.
		local
			text_component: EV_TEXT_COMPONENT
		do
			Result := pointer_style
			if Result = Void then
				text_component ?= Current
				if text_component /= Void then
					Result := Default_pixmaps.Ibeam_cursor
				else
					Result := Default_pixmaps.Standard_cursor
				end
			end
		end


	actual_drop_target_agent: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_ABSTRACT_PICK_AND_DROPABLE]
			-- Overrides default drop target on a certain position.
			-- If `Void', will use the default drop target.
			-- Always void if `Current' is not a widget.

	real_target: EV_DOCKABLE_TARGET
			-- `Result' is target used during a dockable transport if
			-- mouse pointer is above `Current'.

feature -- Status Report

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		deferred
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
			-- False if `Current' is entirely obscured by another window.
		deferred
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		deferred
		end

	has_capture: BOOLEAN is
			-- Does widget have capture?
		deferred
		end

feature -- Status setting

	hide is
			-- Request that `Current' not be displayed when its parent is.
		deferred
		ensure
			--not_is_show_requested: not is_show_requested
			--| FIXME: does not hold when an action sequence is called as a result of hiding
			--| Current widget as this action sequence might call `show'.
		end

	show is
			-- Request that `Current' be displayed when its parent is.
		deferred
		ensure
			--is_show_requested: is_show_requested
			--| FIXME: does not hold when an action sequence is called as a result of showing
			--| Current widget as this action sequence might call `hide'.
		end

	set_focus is
			-- Grab keyboard focus.
		deferred
		ensure
			--has_focus: has_focus
			--| FIXME IEK Does not hold for non focus widgets such as box.
		end

	set_actual_drop_target_agent (an_agent: like actual_drop_target_agent) is
			-- Assign `an_agent' to `actual_drop_target_agent'.
		require
			an_agent_not_void: an_agent /= Void
		do
			actual_drop_target_agent := an_agent;
			(create {EV_ENVIRONMENT}).application.implementation.pnd_targets.extend (interface.object_id)
		ensure
			assigned: actual_drop_target_agent = an_agent
		end

	set_real_target (a_target: EV_DOCKABLE_TARGET) is
			-- Assign `a_target' to `real_target'.
		require
			target_not_void: a_target /= Void
		do
			real_target := a_target
		ensure
			assigned: real_target = a_target
		end

	remove_real_target is
			-- Ensure `real_target' is `Void'.
		do
			real_target := Void
		ensure
			real_target_void: real_target = Void
		end

feature -- Element change

	set_minimum_width (a_minimum_width: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
		require
			a_minimum_width_positive: a_minimum_width >= 0
		deferred
		ensure
			minimum_width_assigned: is_usable implies
				interface.minimum_width = a_minimum_width
		end

	set_minimum_height (a_minimum_height: INTEGER) is
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		require
			a_minimum_height_positive: a_minimum_height >= 0
		deferred
		ensure
			minimum_height_assigned: is_usable implies
				interface.minimum_height = a_minimum_height
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		require
			a_minimum_width_positive: a_minimum_width >= 0
			a_minimum_height_positive: a_minimum_height >= 0
		deferred
		ensure
			minimum_width_assigned: is_usable implies
				interface.minimum_width = a_minimum_width
			minimum_height_assigned: is_usable implies
				interface.minimum_height = a_minimum_height
		end

feature -- Measurement

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		deferred
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_WIDGET
		-- Provides a common user interface to platform dependent functionality
		-- implemented by `Current'.
		-- (See bridge pattern notes in ev_any.e)

	on_parented is
			-- `Current' is about to be put into a container.
		require
			parent_void: parent = Void
		do
		ensure
			parent_void: parent = Void
		end

	on_orphaned is
			-- `Current' has just been removed from its container.
		require
			parent_void: parent = Void
		do
		ensure
			parent_void: parent = Void
		end

feature {NONE} -- Implementation

	on_help_context_changed is
			-- Connect help accelerators if not done already
		local
			top_window: EV_TITLED_WINDOW_I
			a_parent: EV_CONTAINER
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
	pointer_position_not_void: is_usable implies pointer_position /= Void

	--| FIXME IEK The minimum dimension size should be greater than 0
	--| This does not hold for containers though

	is_displayed_implies_show_requested:
		is_usable and is_displayed implies is_show_requested

	--| FIXME IEK Not applicable for items that inherit from widget
	--| only on the implementation side such as T.B. Button
	--|parent_contains_current:
		--|is_usable and parent /= Void implies parent.has (interface)

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




end -- class EV_WIDGET_I

