<<<<<<< ev_new_figure.e
indexing
	description: "Ancestor of all figures."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_NEW_FIGURE

feature -- Initialization

	init_figure (new_parent: EV_FIGURE_GROUP;new_center: EV_FIGURE_POINT) is
			-- Initialize figure.
			-- No parent means that Current is the root figure.
			-- The center may be defined later.
		do
			set_parent_figure (new_parent)
			set_center (new_center)
			Create referencees.make
		ensure
			not_void: origin /= Void and parent_figure /= Void
			set: new_center = center and parent_figure=new_parent
			referencees_exists: referencees /= Void
		end

feature -- Access

	surround_box: EV_CLOSURE is deferred end
			-- box surrounding  `Current`

	valid: BOOLEAN
		-- Is current figure still valid ?

	has_updater: BOOLEAN is
		-- Has Current a updater for positioning ?
		do
			Result := (updater /= Void)
		end

	has_reference: BOOLEAN is
		-- Has Current position computed from reference 'reference' ?
		do
			Result := (reference /= Void)
		end

	is_root: BOOLEAN is
		-- Has Current a parent figure ?
		do
			Result := (parent_figure = Void)
		end

feature -- Settings

	set_center(new_center: like center) is
			-- Set center of Current to 'new_center'.
		require
			not_void: new_center /= Void
		deferred
		ensure
			set: new_center = center
		end

	set_parent_figure(p: EV_FIGURE_GROUP) is
			-- Set parent of current figure.
			-- If 'p' is Void, this means that the parent
			-- is the drawing root.
		do
			parent_figure := p
		ensure
			set: parent_figure = p
		end

	set_reference(new_reference: like reference) is
			-- Set reference figure for Current positioning.
		require
			exists: new_reference /= Void
		do
			reference := new_reference
		ensure
			set: reference /= Void and then reference = new_reference
		end

	set_updater(new_updater: like updater) is
			-- Set 'new_updater' as new Current updater.
		require
			meaningfull: new_updater /= Void
		do
			updater := new_updater
		ensure
			not_void: updater /= Void
			set: updater = new_updater
		end

feature -- Update

	default_update(an_origin: like origin) is
		-- Default resolution of the position of Current
		require
			not_void: an_origin /= Void
		do
			origin := an_origin
		ensure
			set: origin = an_origin
			not_void: origin /= Void
		end

	update is
		-- resolution of Current positioning.
		-- This should not be called when Current is root, since
		-- positioning has in this case not more sense.
		require
			not_root: not is_root
		do
			if updater /= Void then
				updater.call([Current])
			elseif reference /= Void then
				default_update(reference.origin)
			else
				if parent_figure.origin=Void then
					-- Case when parent is root.
					Create origin.make_empty
				else
					default_update(parent_figure.origin)	
				end
			end
		ensure
			origin_recomputed: origin /= Void
		end	
		
 
feature -- Adding/Removing

	remove is
			-- Remove Current from system.
		require
			is_valid: valid
		deferred
		ensure
			is_invalid: not valid
		end

	unset_reference is
			-- Unset the reference, because this one died.
		require
			meaningfull: has_reference
		do
			reference := Void
		ensure
			no_more_reference: not has_reference
		end

	invalidate_updater is
		-- The updater is not anymore a valid
		-- way to compute the position of Current.
		require
			meaningfull: has_updater
		do
			updater := Void
		ensure
			no_more_updater: not has_updater
		end

feature {EV_PROJECTION,EV_NEW_FIGURE} -- Implementation

	parent_figure: EV_FIGURE_GROUP
		-- Parent of Current.

	center: EV_FIGURE_POINT is deferred end
		-- Center of Current.

	origin: EV_FIGURE_POINT
		-- Origin from which is computed the coordinates of 
		-- current figure.

	reference: EV_NEW_FIGURE
		-- Figure Current depends on, regarding the positioning.

	updater: PROCEDURE [ANY, TUPLE[EV_NEW_FIGURE]]
		-- Position resolution of Current, thanks to an
		-- agent.

	referencees: LINKED_LIST[EV_NEW_FIGURE]
		-- List of figure which have to be noticed when
		-- Current dies.

invariant
	origin_exists: origin /= Void
	referencees_exists: referencees /= Void
	closures_not_void: surround_box /= Void	
	positioning_possible: updater = Void implies ( reference /= Void or else origin /=Void)
	root_implies_null_origin: parent_figure=Void implies (origin /= Void and (origin.x=0 and origin.y=0))
end -- class EV_NEW_FIGURE
=======
>>>>>>> 1.1
