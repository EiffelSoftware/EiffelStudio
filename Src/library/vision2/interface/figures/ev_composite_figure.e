indexing
	description: "EiffelVision composite figure (drawing, world,...)."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMPOSITE_FIGURE

inherit
	EV_FIGURE	
		redefine
			attach_drawing,
			translate,
			self_scale,
			self_rotate,	
			scale,
			rotate,
			recompute
		end

feature -- Access

	item: EV_FIGURE is
			-- figure at cursor position
		require
			not_off: not off
		deferred
		end

feature -- Element change

	add (v: EV_FIGURE) is
			-- Append `v' 
		deferred
		end

	attach_drawing (a_drawing: EV_DRAWABLE) is
			-- Attach a drawing to the figure.
		do
			drawing := a_drawing
			composite_mark
			from
				start
			until
				off
			loop
				item.attach_drawing_with_parent (Current, drawing)
				forth
			end
			composite_return
			set_modified_with (surround_box)
		end

		merge (other: like Current) is
			-- Merge `other' 
			-- Do not move cursor.
			-- Empty other.
		deferred
		end

	put (v: EV_FIGURE) is
			-- Put item `v' at cursor position.
		require else
			not_off: not off
		deferred
		end

	rotate (a: REAL; p: like origin) is
			-- Rotate figure by `a' relative to `p'.
			-- Angle `a' is measured in degrees.
		do
			composite_mark
			from
				start
			until
				off
			loop
				item.rotate (a, p)
				forth
			end
			composite_return
			set_modified
		end

	scale (f: REAL; p: like origin) is
			-- Scale figure by `f' relative to `p'.
		do
			composite_mark
			from
				start
			until
				off
			loop
				item.scale (f, p)
				forth
			end
			composite_return
			set_modified
		end

	self_rotate (a: REAL) is
			-- Rotate figure by `a' relative to `origin'.
			-- Angle is measured in degrees.
		do
			composite_mark
			from
				start
			until
				off
			loop
				item.rotate (a, origin)
				forth
			end
			composite_return
			set_modified
		end

	self_scale (f: REAL) is
			-- Scale figure by `f' relative to `origin'.
		do
			composite_mark
			from
				start
			until
				off
			loop
				item.scale (f, origin)
				forth
			end
			composite_return
			set_modified
		end

	translate (v: EV_VECTOR) is
			-- Translate current figure by `v'.
		do
			composite_mark
			from
				start
			until
				off
			loop
				item.translate (v)
				forth
			end
			composite_return
			set_modified
		end

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360
			a_positive: a >= 0.0
		do
			composite_mark
			from
				start
			until
				off
			loop
				item.xyrotate (a, px, py)
				forth
			end
			composite_return
			set_modified
		end

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			composite_mark
			from
				start
			until
				off
			loop
				item.xyscale (f, px, py)
				forth
			end
			composite_return
			set_modified	
		end

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			composite_mark
			from
				start
			until
				off
			loop
				item.xytranslate (vx, vy)
				forth
			end
			composite_return
			set_modified
		end

feature -- Removal

	remove (fig: EV_FIGURE) is
			-- remove `fig`
		require
			fig_not_void: fig /= Void 
		deferred
		end

feature -- Cursor movement 

	start is
		-- Move to first position
		deferred
		end

	finish is
		-- Move to last position
		deferred 
		end

	forth is
		-- Move to next position
		deferred
		end

	composite_mark is
		deferred
		end

	composite_return is
		deferred
		end

feature -- Output
		
	draw is
			-- Draw the figure in `drawing'.
		require else
			drawing_is_drawable: True
		do
			--if drawing.is_drawable then
				composite_mark
				from
					start
				until
					off
				loop
					item.draw
					forth
				end
				composite_return
			--end
		end

feature -- Updating

	recompute is
		do
			from
				composite_mark
				start
				surround_box.wipe_out
			until
				off
			loop
				if item.modified then
					item.recompute
				end
				surround_box.merge (item.surround_box)
				forth
			end
			composite_return
			unset_modified
		end

feature -- Status report

	off: BOOLEAN is
			-- Is cursor off edge ?
		deferred
		end

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the figure superimposable to `other' ?
		do
			composite_mark
			from
				start
				other.start
				Result := true
			until
				not Result or off or other.off
			loop
				Result := Result and item.is_superimposable (other.item)
				forth
				other.forth
			end
			Result := Result and off and other.off
			composite_return
			other.composite_return
		end

end -- class EV_COMPOSITE_FIGURE

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

