indexing
	description: "EiffelVision Figure. Geometric figures that can be drawn%
				% on a drawing area."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FIGURE

inherit
	EV_GEOMETRICAL
		redefine
			notified,
			set_modified,
			set_modified_with,
			unset_modified
		end

feature {EV_FIGURE, EV_WORLD} -- Initialization

	init_fig (f: EV_FIGURE) is
			-- by default `plane` is 0, `notify` is false, `received` is false
		do
			if f /= Void then
				max_plane := f.max_plane
			else
				max_plane := Default_max_plane
			end
			init_notification	
			create changes_box.make
			create surround_box.make
			set_figure (f)
			set_receive
			set_notify
		end

feature -- Access

	changes_box: EV_CLOSURE
			-- box in which changes have been done 

	surround_box: EV_CLOSURE	
			-- box surrounding  `Current`

	Default_max_plane: INTEGER is 10
		-- Maximum default number of plane

	max_plane: INTEGER
		-- Maximum number of plane

	plane: INTEGER
		-- plane in which current has to be drawn, plane 0 is the background

	drawing: EV_DRAWABLE
			-- Drawing area 

	notified: EV_FIGURE
			-- receive notification modification

feature -- Status setting

	set_plane (p: INTEGER) is
		require
			non_negative_plane: plane >= 0
			less_than_max_plane: plane < max_plane
			plane_same_as_parent: (notified /= Void) implies (notified.plane = plane)
		do
			plane := p
			set_modified
		end

	set_modified is
		local
			cl: EV_CLOSURE
		do
				if not notify or else notified = Void then	
					set_value_modified (True)
					changes_box.merge (surround_box)
				else
					cl := deep_clone (surround_box)
					recompute
					cl.merge (surround_box)
					notified.set_modified_with (cl)
				end
		end

	set_modified_with (cl1: EV_CLOSURE) is
		local
			cl2: EV_CLOSURE
		do
				if not notify or else notified = Void then
					set_value_modified (True)
					changes_box.merge (cl1)
				else
					cl2 := deep_clone (surround_box)
					recompute
					cl2.merge (surround_box)
					cl2.merge (cl1)
					notified.set_modified_with (cl2)
				end
		end

	unset_modified is
		do
			set_value_modified (False)
		end

feature-- Element change

	set_figure (f: EV_FIGURE) is
		do
			if f /= Void then
				notified := f
			end
		end

	attach_drawing (a_drawing: EV_DRAWABLE) is
			-- Attach a drawing to the figure
		do
			drawing := a_drawing
			set_modified
			check
				drawing = a_drawing
			end
		end

	attach_drawing_with_parent (parent: EV_FIGURE; a_drawing: EV_DRAWABLE) is
			-- Attach a drawing to the figure.
		do
			set_figure (parent)
			attach_drawing (a_drawing)
		end

feature -- Basic operations

	draw is
			-- Draw the figure in `drawing'.
		require
			a_drawing_attached: drawing /= Void
		deferred
		end

	clip_draw (clip: EV_CLIP) is
			-- conditionnal drawing in the 'clip' zone
		require
			clip_not_void: clip /= Void 
			surround_box_not_void: surround_box /= Void
		do
			if modified then
				recompute
			end
			draw
		ensure
			not_modified: not modified
		end


	deselect is
			-- Do nothing by default
		 do
		 end

	select_figure is
			-- Do nothing by default
		 do
		 end

end -- class EV_FIGURE

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

