indexing

	description: "Figures implementation for X";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	FIGURE

inherit

	BASIC_ROUTINES
			export {NONE} all
		end;

	GEOMETRIC_OP;

	CONFIGURE_NOTIFY
		rename
			make as notify_make
		export
			{CONFIGURE_NOTIFY} 
				notify_make,
				get_conf_notified,
				set_conf_notified,
				set_conf_value_modified,
				set_conf_not_notify,
				set_conf_notify,
				set_conf_not_receive,
				set_conf_receive,
				conf_notify,
				conf_receive,
				conf_recompute,
				conf_modified;
		redefine
			set_conf_modified,
			set_conf_modified_with,
			unset_conf_modified
		end

feature -- Access

	changes_box: CLOSURE;
			-- box in which changes have been done 

	surround_box: CLOSURE;	
			-- box surrounding  `Current`

	Default_max_plane: INTEGER is 10;
		-- Maximum default number of plane

	max_plane: INTEGER;
		-- Maximum number of plane

	plane: INTEGER;
		-- plane in which current has to be drawn, plane 0 is the background

	drawing: DRAWING_I;
			-- Drawing area 

feature -- Element change

	attach_drawing (a_drawing: DRAWING) is
			-- Attach a drawing to the figure
		do
			drawing := a_drawing.implementation;
			set_conf_modified
			check
				drawing = a_drawing.implementation
			end
		end;

	set_plane (p: INTEGER) is
		require
			non_negative_plane: plane >= 0;
			less_than_max_plane: plane < max_plane;
			plane_same_as_parent: (conf_notified /= Void) implies (conf_notified.plane = plane)
		do
			plane := p;
			set_conf_modified
		end;

	deselect is
			-- Do nothing by default
		 do
		 end;

	select_figure is
			-- Do nothing by default
		 do
		 end;
	
feature -- Output

	draw is
			-- Draw the figure in `drawing'.
		require
			a_drawing_attached: drawing /= Void
		deferred
		end;

	clip_draw (clip: CLIP) is
			-- conditionnal drawing in the 'clip' zone
		require
			clip_not_void: clip /= Void ;
			surround_box_not_void: surround_box /= Void
		do
			if conf_modified then
				conf_recompute
			end;
			draw
		ensure
			not_conf_modified: not conf_modified
		end;

feature -- Access

	conf_notified: FIGURE;
			-- receive notification modification


feature {WORLD, FIGURE} -- Initialization

	init_fig (f: FIGURE) is
			-- by default `plane` is 0, `notify` is false, `received` is false
		do
			if f /= Void then
				max_plane := f.max_plane
			else
				max_plane := Default_max_plane
			end;
			notify_make;	
			!! changes_box.make;
			!! surround_box.make;
			set_figure (f);
			set_conf_receive;
			set_conf_notify
		end;

feature {CONFIGURE_NOTIFY} -- Access

	set_figure (f: FIGURE) is
		do
			if f /= Void then
				conf_notified := f
			end
		end;

	attach_drawing_with_parent (parent: FIGURE; a_drawing: DRAWING) is
			-- Attach a drawing to the figure
		do
			set_figure (parent);
			attach_drawing (a_drawing);
		end;

	attach_drawing_imp_with_parent (parent: FIGURE; a_drawing_imp: DRAWING_I) is
			-- Attach a drawing to the figure
		do
			set_figure (parent);
			attach_drawing_imp (a_drawing_imp);
		end;

	attach_drawing_imp (a_drawing_imp: DRAWING_I) is
			-- Attach a drawing to the figure
		do
			drawing := a_drawing_imp;
			set_conf_modified
		end;

	set_conf_modified is
		local
			cl: CLOSURE;
		do
				if not conf_notify or else conf_notified = Void then	
					set_conf_value_modified (true);
					changes_box.merge (surround_box)
				else
					cl := deep_clone (surround_box);
					conf_recompute;
					cl.merge (surround_box);
					conf_notified.set_conf_modified_with (cl)
				end
		end;

	set_conf_modified_with (cl1: CLOSURE) is
		local
			cl2: CLOSURE;
		do
				if not conf_notify or else conf_notified = Void then
					set_conf_value_modified (true);
					changes_box.merge (cl1)
				else
					cl2 := deep_clone (surround_box);
					conf_recompute;
					cl2.merge (surround_box);
					cl2.merge (cl1);
					conf_notified.set_conf_modified_with (cl2)
				end
		end;

	unset_conf_modified is
		do
			set_conf_value_modified (false)
		end;

invariant
	non_negative_plane: plane >= 0;
	less_than_max_plane: plane < max_plane;
	plane_same_as_parent: (conf_notified /= Void) implies (conf_notified.plane = plane)

end -- class FIGURE



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

