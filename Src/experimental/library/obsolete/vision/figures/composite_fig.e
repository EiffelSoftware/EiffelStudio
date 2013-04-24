note

	description: "Composite figure, ex: world, complex_fig ..."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	COMPOSITE_FIG

inherit
	
	FIGURE	
		redefine
			attach_drawing_imp,
			attach_drawing,
			translate,
			self_scale,
			self_rotate,	
			scale,
			rotate,
			conf_recompute
		end;

feature -- Access

	item: FIGURE
			-- figure at cursor position
		require
			not_off: not off
		deferred
		end;

feature -- Element change

	add (v: FIGURE)
			-- Append `v' 
		deferred
		end;

	attach_drawing (a_drawing: DRAWING)
			-- Attach a drawing to the figure.
		do
			attach_drawing_imp (a_drawing.implementation)
		end;

	 	merge (other: like Current)
			-- Merge `other' 
			-- Do not move cursor.
			-- Empty other.
		deferred
		end;

	put (v: FIGURE)
			-- Put item `v' at cursor position.
		require else
			not_off: not off
		deferred
		end;

	rotate (a: REAL; p: like origin)
			-- Rotate figure by `a' relative to `p'.
			-- Angle `a' is measured in degrees.
		do
			composite_mark;
			from
				start
			until
				off
			loop
				item.rotate (a, p);
				forth
			end;
			composite_return;
			set_conf_modified
		end;

	scale (f: REAL; p: like origin)
			-- Scale figure by `f' relative to `p'.
		do
			composite_mark;
			from
				start
			until
				off
			loop
				item.scale (f, p);
				forth
			end;
			composite_return;
			set_conf_modified
		end;

	self_rotate (a: REAL)
			-- Rotate figure by `a' relative to `origin'.
			-- Angle is measured in degrees.
		do
			composite_mark;
			from
				start
			until
				off
			loop
				item.rotate (a, origin);
				forth
			end;
			composite_return;
			set_conf_modified
		end;

	self_scale (f: REAL)
			-- Scale figure by `f' relative to `origin'.
		do
			composite_mark;
			from
				start
			until
				off
			loop
				item.scale (f, origin);
				forth
			end;
			composite_return;
			set_conf_modified
		end;

	translate (v: VECTOR)
			-- Translate current figure by `v'.
		do
			composite_mark;
			from
				start
			until
				off
			loop
				item.translate (v);
				forth
			end;
			composite_return;
			set_conf_modified
		end;

	xyrotate (a: REAL; px, py: INTEGER)
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			composite_mark;
			from
				start
			until
				off
			loop
				item.xyrotate (a, px, py);
				forth
			end;
			composite_return;
			set_conf_modified
		end;

	xyscale (f: REAL; px,py: INTEGER)
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			composite_mark;
			from
				start
			until
				off
			loop
				item.xyscale (f, px, py);
				forth
			end;
			composite_return;
			set_conf_modified	
		end;

	xytranslate (vx, vy: INTEGER)
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			composite_mark;
			from
				start
			until
				off
			loop
				item.xytranslate (vx, vy);
				forth
			end;
			composite_return;
			set_conf_modified
		end;

feature -- Removal

	remove (fig: FIGURE)
			-- remove `fig`
		require
			fig_not_void: fig /= Void 
		deferred
		end;

feature -- Cursor movement 

	start
		-- Move to first position
		deferred
		end;

	finish
		-- Move to last position
		deferred 
		end;

	forth
		-- Move to next position
		deferred
		end;

	composite_mark
		deferred
		end;

	composite_return
		deferred
		end;

feature -- Output
		
	draw
			-- Draw the figure in `drawing'.
		require else
			drawing_is_drawable: true
		do
			--if drawing.is_drawable then
				composite_mark;
				from
					start
				until
					off
				loop
					--if item.drawing /= Void then
					item.draw;
					forth
				end;
				composite_return
			--end
		end;

feature -- Updating

	conf_recompute
		do
			from
				composite_mark;
				start;
				surround_box.wipe_out;
			until
				off
			loop
				if item.conf_modified then
					item.conf_recompute
				end;
				surround_box.merge (item.surround_box);
				forth;
			end;
			composite_return;
			unset_conf_modified
		end;

feature -- Status report

	off: BOOLEAN
			-- Is cursor off edge ?
		deferred
		end;

	is_superimposable (other: like Current): BOOLEAN
			-- Is the figure superimposable to `other' ?
		do
			composite_mark;
			from
				start;
				other.start;
				Result := true;
			until
				not Result or off or other.off
			loop
				Result := Result and item.is_superimposable (other.item);
				forth;
				other.forth;
			end;
			Result := Result and off and other.off;
			composite_return;
			other.composite_return
		end;

feature {WORLD,FIGURE,CONFIGURE_NOTIFY} -- Element change

	attach_drawing_imp (a_drawing: DRAWING_I)
			-- Attach a drawing to the figure.
		do
			drawing := a_drawing;
			composite_mark;
			from
				start
			until 
				off
			loop
				item.attach_drawing_imp_with_parent (Current, drawing);
				forth
			end;
			composite_return;
			set_conf_modified_with (surround_box)
		end;

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




end --  class COMPOSITE_FIG

