indexing
	description: "Group of linkable diagram figures"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LINKABLE_FIGURE_GROUP

feature -- Access

	world: EV_FIGURE_WORLD is
			-- World `Current' belongs to.
		deferred
		end

	point: EV_RELATIVE_POINT is
			-- Origin of `Current'.
		deferred
		end

	cluster_figures: LINKED_LIST [CLUSTER_FIGURE]
			-- Clusters included in `Current'.

	class_figures: LINKED_LIST [CLASS_FIGURE]
			-- Classes included in `Current'.

	horizontal_spacing: INTEGER is 
			-- Space in pixels between figures horizontally.
		do
			Result := 40
		end

	vertical_spacing: INTEGER is
			-- Space in pixels between figures vertically.
		do
			Result := 40
		end

feature -- Status report

	minimum_size: EB_DIMENSIONS is
			-- [width, height] of area to fit `Current' in.
		local
			r: EV_RECTANGLE
		do
			r := bounds
			create Result
			Result.set (r.width + r.x + 20, r.height + r.y + 20)
		end

	bounds: EV_RECTANGLE is
			-- [x, y, width, height] of area to fit `Current' in.
		local
			x, y, w, h: INTEGER
			clas_f: CLASS_FIGURE
			clus_f: CLUSTER_FIGURE
			cd, cur_as_diagram: CONTEXT_DIAGRAM
			sx, sy: DOUBLE
			ml: EV_FIGURE_GROUP
			mh: EV_MOVE_HANDLE
			p: EV_RELATIVE_POINT
			csf: CLIENT_SUPPLIER_FIGURE
			label: EV_FIGURE_TEXT
		do
			cd ?= world
			if cd /= Void then
				sx := cd.scale_x
				sy := cd.scale_y
			else
				sx := 1.0
				sy := 1.0
			end
			x := 100000
			y := 100000
			from
				class_figures.start
			until
				class_figures.after
			loop
				clas_f ?= class_figures.item
				if clas_f/= Void then
					x := x.min (clas_f.left)
					y := y.min (clas_f.top)
					w := w.max (clas_f.left + (clas_f.width * sx).rounded)
					h := h.max (clas_f.top + (clas_f.height * sy).rounded)
				end
				class_figures.forth
			end
			from
				cluster_figures.start
			until
				cluster_figures.after
			loop
				clus_f ?= cluster_figures.item
				if clus_f /= Void then
					x := x.min (clus_f.left)
					y := y.min (clus_f.top)
					w := w.max (clus_f.left + (clus_f.width * sx).rounded)
					h := h.max (clus_f.top + (clus_f.height * sy).rounded)
				end
				cluster_figures.forth
			end
			cur_as_diagram ?= Current
			if cur_as_diagram /= Void and then cd /= Void then
				ml := cd.client_supplier_mover_layer
				from
					ml.start
				until
					ml.after
				loop
					mh ?= ml.item
					if mh /= Void then
						p := mh.point
						x := x.min (p.x_abs)
						y := y.min (p.y_abs)
						w := w.max (p.x_abs)
						h := h.max (p.y_abs)
					end
					ml.forth
				end
				ml := cd.inheritance_mover_layer
				from
					ml.start
				until
					ml.after
				loop
					mh ?= ml.item
					if mh /= Void then
						p := mh.point
						x := x.min (p.x_abs)
						y := y.min (p.y_abs)
						w := w.max (p.x_abs)
						h := h.max (p.y_abs)
					end
					ml.forth
				end
				ml := cd.client_supplier_layer
				from
				    ml.start
				until
				    ml.after
				loop
				    csf ?= ml.item
					if csf /= Void then
						label := csf.name_figure
						p := label.point
						x := x.min (p.x_abs)
						y := y.min (p.y_abs)
						w := w.max (p.x_abs + label.width)
						h := h.max (p.y_abs + label.height)
					end
					ml.forth
				end
			end
			if class_figures.is_empty and cluster_figures.is_empty then
				x := point.x_abs
				y := point.y_abs
			end
			create Result.set (x, y, (w - x + 20).max (0), (h - y + 20).max (0))
		end

feature {LINKABLE_FIGURE_GROUP} -- Implementation
	
	arrange_clusters is
			-- Items of `cluster_figures' need to be moved.
		do
		end

feature {NONE} -- Implementation

	layout: CLASS_PLACEMENT
			-- Used to set positions of figures.

end -- class LINKABLE_FIGURE_GROUP
