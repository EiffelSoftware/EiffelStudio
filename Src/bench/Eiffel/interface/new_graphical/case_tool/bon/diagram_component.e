indexing
	description: "Graphical diagram components."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIAGRAM_COMPONENT

inherit
	EV_FIGURE_GROUP
		redefine
			world
		end

	ES_DIAGRAM_BUFFER_MANAGER
		undefine
			default_create
		end

	EB_CONTEXT_TOOL_DATA
		undefine
			default_create
		end

	SHARED_API_ROUTINES
		export
			{NONE} all
		undefine
			default_create
		end

	SHARED_XML_ROUTINES
		export
			{NONE} all
		undefine
		    default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create
		end

feature {NONE} -- Initialization

	initialize is
			-- Do custom initialization like creating the
			-- figures that `Current' might consist of.
		deferred
		end

feature -- Access

	world: CONTEXT_DIAGRAM is
		do
			Result ?= Precursor
		end

	cluster_figure: CLUSTER_FIGURE is
			-- Cluster figure `Current' is in directly.
			-- Void if none or more than one.
		deferred
		end

feature -- Status report
		
	needed_on_diagram: BOOLEAN
			-- Is `Current' needed on the diagram?

	ctrl_pressed: BOOLEAN is
			-- Is key Ctrl currently pressed?
		do
			Result := ev_application.ctrl_pressed
		end

feature -- Status setting

	enable_needed_on_diagram is
			-- Set `needed_on_diagram' to True.
		do
			needed_on_diagram := True
		ensure
			assigned: needed_on_diagram
		end

	disable_needed_on_diagram is
			-- Set `needed_on_diagram' to False.
		do
			needed_on_diagram := False
		ensure
			assigned: not needed_on_diagram
		end

	synchronize is
			-- `Current' needs to be updated because of recompilation
			-- or similar action that needs resynchonization.
		do
			wipe_out
			build_figure
		end

	set_active (b: BOOLEAN) is
			-- Highlight `Current' if `b' `True'.
		deferred	
		end

	update is
			-- Update graphically because something changed.
		deferred
		end

feature {LINKABLE_FIGURE_GROUP} -- XML

	xml_element (a_parent: XML_ELEMENT): XML_ELEMENT is
			-- XML representation.
		deferred
		end

	set_with_xml_element (an_element: XML_ELEMENT) is
			-- Set attributes from XML element.
		require
			an_element_not_void: an_element /= Void
		deferred
		end

feature {DIAGRAM_COMPONENT, CLASS_PLACEMENT} -- Implementation

	snap_to_default_grid is
			-- Move to the most nearby point on the default grid.
		do
			point.set_position (default_snapped_x (point.x), default_snapped_y (point.y))
		end
		
	default_snapped_x (ax: INTEGER): INTEGER is
			-- Nearest point on DEFAULT horizontal grid to `ax'.
		local
			px, wx: INTEGER
		do
			wx := world.point.x
			if point.origin /= void and then point.origin /= world.point then
				px := (point.origin.x_abs / point.origin.scale_x_abs).rounded
			end
			Result := world.x_to_default_grid (wx + px + ax) - px - wx
		end

	default_snapped_y (ay: INTEGER): INTEGER is
			-- Nearest point on DEFAULT vertical grid to `ay'.
		local
			py, wy: INTEGER
		do
			wy := world.point.y
			if point.origin /= void and then point.origin /= world.point then
				py := (point.origin.y_abs / point.origin.scale_y_abs).rounded
			end
			Result := world.y_to_default_grid (wy + py + ay) - py - wy
		end

feature {NONE} -- Implementation

	build_figure is
			-- Build graphical representation from recently updated structure.
		require
			is_empty: is_empty
		deferred
		end
	
	start_capture is
			-- Enable mouse capture on the drawing area
		local
			d_area: EV_DRAWING_AREA
		do
			d_area := world.context_editor.area
			if d_area /= Void and then not d_area.has_capture then
				d_area.enable_capture
			end
		end
		
	stop_capture is
			-- Enable mouse capture on the drawing area
		local
			d_area: EV_DRAWING_AREA
		do
			d_area := world.context_editor.area
--			world.context_editor.scroll_if_necessary (True)
			if d_area /= Void and then d_area.has_capture then
				d_area.disable_capture
			end
		end
		
feature -- Implementation (Drawing)

	offset_coordinates (coordinates: ARRAY [EV_COORDINATE]): ARRAY [EV_COORDINATE] is
			-- 
		local
			i: INTEGER
			coordinate: EV_COORDINATE
			old_x, old_y: INTEGER
		do
			create Result.make (coordinates.lower, coordinates.upper)
			from
				i:= Result.lower
			until
				i > Result.upper
			loop
				coordinate := coordinates @ i
				old_x := coordinate.x
				old_y := coordinate.y
				if coordinate /= Void then
					create coordinate.set (old_x - drawable_position.x, old_y - drawable_position.y)
					Result.put (coordinate, i)
				end
				i := i + 1
			end
		end
		
end -- class DIAGRAM_COMPONENT


