indexing
	description: "EiffelVision geometrical. A geometrical object on which%
				% geometric operations can be applied (rotation, translation...)."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GEOMETRICAL

inherit
	BASIC_ROUTINES
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	init_notification is
			-- Initialize the modifications notification.
			-- Instances either notify `notified` or keep modification in
			-- `modified`, depending on the `notify` boolean value".
		do
			set_notify
			set_receive
		end

feature -- Access

	get_notified: EV_FIGURE is
		do
			Result ?= notified
		end

	origin: EV_COORDINATES is
			-- Origin of figure (used by `self_rotate' and `self_scale')
		deferred
		end

	contains (p: EV_POINT): BOOLEAN is
			-- Is `p' in Current ?
			-- (Unless redefined, by default it is false)
		require
			point_exists: p /= Void
		do
			Result := False
		end

feature -- Status report

	notify: BOOLEAN

	modified: BOOLEAN
			-- has `Current` been modified

	receive: BOOLEAN

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the figure able to be superimposed on `other' ?
		deferred
		end

feature -- Status setting

	set_notify is
			-- 'Current' notifies `conf_notified' when changes configuration
		do
			notify := True
		ensure
			notified: notify
		end

	set_not_notify is
			-- 'Current' does not notify `conf_notified' when changes configuration
			-- but set the 'conf_modified' attribute instead
		do
			notify := False
		ensure
			not_notified: not notify
		end

	set_receive is
			-- 'Current' receives modification notification
			-- so that it does not have to test the 'conf_modified' attribute
			-- of its dependents
		do
			receive := True
		ensure
			received: receive
		end

	set_not_receive is
			-- 'Current' does not receive modification notification
			-- so that it has to test the 'conf_modified' attribute
			-- of its dependents
		do
			receive := False
		ensure
			not_received: not receive
		end

	set_notified (arg: EV_FIGURE) is
			-- Set the figure object to notify when 'notify' is true
		do
			notified := arg
		end

	set_modified is
			-- To be called when a configuration change has been performed
		do
			if not notify then
				modified := True
			else
				recompute
				get_notified.set_modified
			end
		end

	set_modified_with (arg: EV_CLOSURE) is
			-- To be called when a configuration change has been performed
			-- with an 'arg' information 
		do
			if not notify then
				modified := True
			else
				recompute
				get_notified.set_modified_with (arg)
			end
		end

	unset_modified is
			-- Disable the 'conf_modified' state
		do
			modified := False
		ensure
			unset_modified: not modified
		end

	set_value_modified (bool: BOOLEAN) is
		do
			modified := bool
		end

	set_no_origin is
			-- Erase other definition of `origin'.
		do
			origin_user_type := 0
		end

	set_origin (an_origin: like origin) is
			-- Set `origin' to `an_origin'.
		require
			an_origin_exists: an_origin /= Void
		do
			origin_user_type := 1
			origin_user := an_origin
		end

feature -- Element change
	
	recompute is
			-- To be called before unsetting configuration
		do
			unset_modified			
		end

	rotate (a: REAL; p: like origin) is
			-- Rotate figure by `a' relative to `p'.
			-- Angle `a' is measured in degrees.
		require
			point_exists: p /= Void
			angle_large_enough: a >= 0
			angle_small_enough: a <= 360
		do
			xyrotate (a, p.x, p.y)
		end

	scale (f: REAL; p: like origin) is
			-- Scale figure by `f' relative to `p'.
		require
			scale_factor_positive: f > 0.0
			point_exists: p = Void
		do
			xyscale (f, p.x, p.y)
		end

	self_rotate (a: REAL) is
			-- Rotate figure by `a' relative to `origin'.
			-- Angle is measured in degrees.
		require
			origin_exists: origin /= Void
			angle_large_enough: a >= 0
			angle_small_enough: a < 360
		do
			xyrotate (a, origin.x, origin.y)
		end

	self_scale (f: REAL) is
			-- Scale figure by `f' relative to `origin'.
		require
			origin_exists: origin /= Void
			scale_factor_positive: f > 0.0
		do
			xyscale (f, origin.x, origin.y)
		end

	translate (v: EV_VECTOR) is
			-- Translate current figure by `v'.
		require
			vector_exists: v /= Void
		do
			xytranslate (v.x, v.y)
		end

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require
			a_smaller_than_360: a < 360
			a_positive: a >= 0.0
		deferred
		end

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require
			scale_factor_positive: f > 0.0
		deferred
		end

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		deferred
		end

feature {NONE} -- Access

	notified: ANY
			-- Object being modified

	origin_user: like origin
			-- User definition of `origin' when `origin_user_type' is 1

	origin_user_type: INTEGER
			-- Type of origin typed by the user

invariant
	origin_user_type_constraint: origin_user_type >= 0
	user_origin_constraint: (origin_user_type = 1) implies origin_user /= Void

end -- class EV_GEOMETRICAL

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

