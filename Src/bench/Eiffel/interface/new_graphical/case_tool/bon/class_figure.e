indexing
	description:
		"Graphical representations of classes without%N%
		%commitment to any notation."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLASS_FIGURE

inherit
	LINKABLE_FIGURE
		redefine
			synchronize,
			set_origin,
			cluster_figure
		end

feature {NONE} -- Initialization

	make_with_class (lace_class: CLASS_I) is
			-- Initialize with `lace_class'.
		require
			lace_class_not_void: lace_class /= Void
		do
			default_create
			create code_generator.make (lace_class)
			create ancestor_figures.make
			create descendant_figures.make
			create client_figures.make
			client_figures.compare_objects
			create supplier_figures.make
			supplier_figures.compare_objects
			class_i := lace_class
			build_queries
			initialize
			initialize_structure
			if class_i.compiled then
				create {CLASSC_FIGURE_STONE} pebble.make (Current)
			else
				create {CLASSI_FIGURE_STONE} pebble.make (Current)
			end
			set_target_name (clone (name))
			drop_actions.extend (~on_class_drop)
			set_accept_cursor (Cursors.cur_Class)
			build_figure
		end

	initialize is
			-- Build `Current' representation.
		deferred
		end

feature -- Memory management

	recycle is
			-- Frees `Current's memory, and leave `Current' in an unstable state
			-- so that we know whether we're still referenced or not.
		deferred
		end

feature -- Access

	class_i: CLASS_I
			-- Class this figure is a representation of.

	cluster_figure: CLUSTER_FIGURE
			-- Cluster `Current' belongs to.

	generics: STRING
			-- Formal parameters enclosed by square brackets.

	color: EV_COLOR is
			-- User selected color.
		deferred
		end

	ancestor_figures_of_same_cluster: LINKED_LIST [INHERITANCE_FIGURE] is
			-- Links to ancestors in the same cluster as `Current'.
			-- Equivalent to `ancestor_figures' if `cluster_figure' is void.
			--| FIXME: has to take clusters into account as well.
		local
			c: CLASS_FIGURE
		do
			if cluster_figure /= Void then
				create Result.make
				from
					ancestor_figures.start
				until
					ancestor_figures.after
				loop
					c ?= ancestor_figures.item.ancestor
					if c /= Void and then c.cluster_figure = cluster_figure then
						Result.extend (ancestor_figures.item)
					end
					ancestor_figures.forth
				end
			else
				Result := ancestor_figures
			end
		end

	descendant_figures_of_same_cluster: LINKED_LIST [INHERITANCE_FIGURE] is
			-- Links to descendants in the same cluster as `Current'.
			-- Equivalent to `descendant_figures' if `cluster_figure' is void.
			--| FIXME: has to take clusters into account as well.
		local
			c: CLASS_FIGURE
		do
			if cluster_figure /= Void then
				create Result.make
				from
					descendant_figures.start
				until
					descendant_figures.after
				loop
					c ?= descendant_figures.item.descendant
					if c /= Void and then c.cluster_figure = cluster_figure then
						Result.extend (descendant_figures.item)
					end
					descendant_figures.forth
				end
			else
				Result := descendant_figures
			end
		end

	queries: LIST [CASE_SUPPLIER]
			-- All written queries in `class_i'.

	suppliers_with_class (a_class: CLASS_I): LIST [CASE_SUPPLIER] is
			-- Sublist of `queries' that have type `a_class'.
		local
			cs: CASE_SUPPLIER
		do
			create {LINKED_LIST [CASE_SUPPLIER]} Result.make
			from
				queries.start
			until
				queries.after
			loop
				cs := queries.item
				if cs.has_supplier (a_class) then
					Result.extend (cs)
				end
				queries.forth
			end
		end

	links: LINKED_LIST [LINK_FIGURE] is
			-- All 4 links merged together.
		do
			create Result.make
			from
				ancestor_figures.start
			until
				ancestor_figures.after
			loop
				Result.extend (ancestor_figures.item)
				ancestor_figures.forth
			end
			from
				descendant_figures.start
			until
				descendant_figures.after
			loop
				Result.extend (descendant_figures.item)
				descendant_figures.forth
			end
			from
				client_figures.start
			until
				client_figures.after
			loop
				Result.extend (client_figures.item)
				client_figures.forth
			end
			from
				supplier_figures.start
			until
				supplier_figures.after
			loop
				Result.extend (supplier_figures.item)
				supplier_figures.forth
			end
		end

	current_cluster_links: LINKED_LIST [LINK_FIGURE] is
			-- All 4 links, which origin is `cluster_figure'.
		require
			cluster_figure_exists: cluster_figure /= Void
		do
			Result := links
			from
				Result.start
			until
				Result.after
			loop
				if Result.item.actual_origin /= cluster_figure.point and then
					Result.item.actual_origin /= point then
						Result.remove
				else
					Result.forth
				end
			end
		end

feature -- Status setting

	set_origin (a_point: EV_RELATIVE_POINT) is
			-- Assign `a_point' to the origin of all
			-- figures related to `Current'.
		local
			lf: like links
		do
			point.set_origin (a_point)
			lf := links
			from
				lf.start
			until
				lf.after
			loop
				if lf.item.world /= Void then
					lf.item.update_origin
				end
				lf.forth
			end
		end
	
	synchronize is
			-- `Current' needs to be updated because of recompilation
			-- or similar action that needs resynchonization.
		do
			wipe_out
			initialize_structure
			build_figure
		end

	update is
			-- `Current' has just been moved/resized.
			-- Links need to adapt.
		do
			from ancestor_figures.start until ancestor_figures.after loop
				ancestor_figures.item.update
				ancestor_figures.forth
			end
			from descendant_figures.start until descendant_figures.after loop
				descendant_figures.item.update
				descendant_figures.forth
			end
			from client_figures.start until client_figures.after loop
				client_figures.item.update
				client_figures.forth
			end
			from supplier_figures.start until supplier_figures.after loop
				if supplier_figures.item.parent_link = Void then
					supplier_figures.item.update
				end
				supplier_figures.forth
			end
		end

	update_pebble is
			-- `Current' status may have changed due to recompilation.
		do
			if class_i.exists then
				if class_i.compiled then
					create {CLASSC_FIGURE_STONE} pebble.make (Current)
				else
					create {CLASSI_FIGURE_STONE} pebble.make (Current)
				end	
			else
				pebble := Void
			end
		end

	mask is
			-- `Current' no longer needs to be displayed.
		deferred
		end

	unmask is
			-- `Current' needs to be displayed again.
		deferred
		end

feature -- Status report

	is_deferred: BOOLEAN is
			-- Is the represented class deferred?
		local
			c: CLASS_C
		do
			c := class_i.compiled_class
			if c /= Void then
				Result := c.is_deferred
			end
		end

	is_effective: BOOLEAN is
			-- Is the represented class effective?
			--| i.e. Is the class effecting any of its ancestors?
			--| i.e. Is the class not deferred and is a direct ancestor deferred or
			--| does it have an undefine or redefine clause?
		local
			c, c_tmp: CLASS_C
			l: EIFFEL_LIST [PARENT_AS]
		do
			c := class_i.compiled_class
			if c /= Void then
				if not c.is_deferred then
					if c.ast /= Void then
						l := c.ast.parents
					end
					if l /= Void then
						from
							l.start
						until
							Result or l.after
						loop
							c_tmp := l.item.associated_class (c)
							Result := (c_tmp /= Void and then c_tmp.is_deferred) or else l.item.is_effecting
							l.forth
						end
					end
				end
			end
		end

	is_persistent: BOOLEAN is
			-- Is the represented class persistent?
			--| Does the class inherit STORABLE or does the indexing
			--| clause contain the tag "persistent"?
		local
			c, st: CLASS_C
			i: EIFFEL_LIST [INDEX_AS]
			s: STRING
		do
			c := class_i.compiled_class
			if c /= Void then
				st := Storable_class
				if st /= Void then
					Result := c.conform_to (Storable_class)
				end
				if not Result then
					i := c.ast.top_indexes
					if i /= Void then
						from i.start until Result or i.after loop
							s := i.item.tag
							Result := s /= Void and then s.is_equal ("persistent")
							i.forth
						end
					end
					i := c.ast.bottom_indexes
					if i /= Void then
						from i.start until Result or i.after loop
							s := i.item.tag
							Result := s /= Void and then s.is_equal ("persistent")
							i.forth
						end
					end
				end
			end
		end

	is_interfaced: BOOLEAN is
			-- Is the represented class interfaced?
			--| Does the class have external features?
		local
			c: CLASS_C
			f: LIST [E_FEATURE]
		do
			c := class_i.compiled_class
			if c /= Void then
				f := c.written_in_features
				from f.start until Result or f.after loop
					Result := f.item.is_external
					f.forth
				end
			end
		end

	is_reused: BOOLEAN is
			-- Is the represented class a reusable component?
		local
			c: CLASS_C
		do
			c := class_i.compiled_class
			if c /= Void then
				Result := c.is_precompiled or else c.cluster.is_library
			end
		end

	is_root_class: BOOLEAN is
			-- Is the represented class a root class?
		do
			Result := class_i.name.is_equal (class_i.System.root_class_name)
		end

feature {LINKABLE_FIGURE_GROUP} -- XML

	xml_element (a_parent: XML_ELEMENT): XML_ELEMENT is
			-- XML representation.
		local
			name_in_lower: STRING
		do
			name_in_lower := clone (class_i.name)
			name_in_lower.to_lower
			create Result.make (a_parent, "CLASS_FIGURE")
			Result.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("NAME", name_in_lower))
			Result.put_last (xml_node (Result, "X_POS", point.x.out))
			Result.put_last (xml_node (Result, "Y_POS", point.y.out))
			Result.put_last (xml_node (Result, "COLOR",
				color.red_8_bit.out + ";" +
				color.green_8_bit.out + ";" +
				color.blue_8_bit.out))
		end

	set_with_xml_element (an_element: XML_ELEMENT) is
			-- Set attributes from XML element.
		require else
			an_element_is_class_figure: an_element.name.is_equal ("CLASS_FIGURE")
			an_element_has_name_attribute: an_element.attributes.has ("NAME")
			an_element_name_is_class_name:
				an_element.attributes.item ("NAME").value.is_equal (class_i.name)
		local
			x_pos, y_pos: INTEGER
			col: EV_COLOR
		do
			x_pos := xml_integer (an_element, "X_POS")
			y_pos := xml_integer (an_element, "Y_POS")
			point.set_position (x_pos, y_pos)
			col := xml_color (an_element, "COLOR")
			if col /= Void then
				set_color (col)
			end
			update
		end

feature -- Element change

	set_generics (a_string: STRING) is
			-- Assign `a_string' to `generics'.
		require
			a_string_not_void: a_string /= Void
		do
			generics := a_string
		ensure
			assigned: generics.is_equal (a_string)
		end

	set_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		ensure
			assigned: color.is_equal (a_color)
		end

	set_name_color (a_color: EV_COLOR) is
			-- Assign `a_color' to class name.
		require
			a_color_not_void: a_color /= Void
		deferred
		end

	set_generics_color (a_color: EV_COLOR) is
			-- Assign `a_color' to formal generics.
		require
			a_color_not_void: a_color /= Void
		deferred
		end

	set_bounds (a_x, a_y, a_width, a_height: INTEGER) is
			-- Assign bounds.
		deferred
		ensure
			x_position_assigned: a_x = x_position
			y_position_assigned: a_y = y_position
			width_assigned: a_width = width
			heigth_assigned: a_height = height
		end

	set_relative_position_and_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Assign bounds.
		deferred
		end

	set_cluster (c: CLUSTER_FIGURE) is
			-- Assign `c' to `cluster_figure'.
		require
			c_not_void: c /= Void
		do
			cluster_figure := c
		ensure
			c_assigned: cluster_figure = c
		end

	remove_from_diagram (exclude_needed: BOOLEAN) is
			-- Remove `Current' from its diagram, exclude it if `exclude_needed'.
		local
			d: CONTEXT_DIAGRAM
			clus_d: CLUSTER_DIAGRAM
			ihf: INHERITANCE_FIGURE
			csf: CLIENT_SUPPLIER_FIGURE
		do
			d := world
			clus_d ?= d

			if (clus_d = Void and Current /= d.center_class) or
				clus_d /= Void then
					from
						descendant_figures.start
					until
						descendant_figures.after
					loop
						ihf := descendant_figures.item
						ihf.descendant.ancestor_figures.prune_all (ihf)
						d.inheritance_layer.prune_all (ihf)
						descendant_figures.forth
					end
					from
						ancestor_figures.start
					until
						ancestor_figures.after
					loop
						ihf := ancestor_figures.item
						ihf.ancestor.descendant_figures.prune_all (ihf)
						d.inheritance_layer.prune_all (ihf)
						ancestor_figures.forth
					end
					from
						client_figures.start
					until
						client_figures.after
					loop
						csf := client_figures.item
						csf.client.supplier_figures.prune_all (csf)
						d.client_supplier_layer.prune_all (csf)
						d.label_mover_layer.prune_all (csf.name_figure_mover)
						client_figures.forth
					end
					from
						supplier_figures.start
					until
						supplier_figures.after
					loop
						csf := supplier_figures.item
						csf.supplier.client_figures.prune_all (csf)
						d.client_supplier_layer.prune_all (csf)
						d.label_mover_layer.prune_all (csf.name_figure_mover)
						supplier_figures.forth
					end
					if exclude_needed then
						d.exclude_class (class_i)
					else
						d.remove_class (class_i)
					end
			end
		end

	put_back_on_diagram (d: CONTEXT_DIAGRAM) is
			-- Put `Current' back on `d'.
		local
			ihf: INHERITANCE_FIGURE
			csf: CLIENT_SUPPLIER_FIGURE
		do
			d.add_class_figure (Current)
			from
				descendant_figures.start
			until
				descendant_figures.after
			loop
				ihf := descendant_figures.item
				if d.has_linkable_figure (ihf.descendant) then
					d.add_inheritance_figure (ihf)
		        end
				descendant_figures.forth
			end
			from
				ancestor_figures.start
			until
				ancestor_figures.after
			loop
				ihf := ancestor_figures.item
				if d.has_linkable_figure (ihf.ancestor) then
					d.add_inheritance_figure (ihf)
				end
				ancestor_figures.forth
			end
			from
				client_figures.start
			until
				client_figures.after
			loop
				csf := client_figures.item
				if d.has_linkable_figure (csf.client) then
					d.add_client_supplier_figure (csf)
				end
				client_figures.forth
			end
			from
				supplier_figures.start
			until
				supplier_figures.after
			loop
				csf := supplier_figures.item        
				if d.has_linkable_figure (csf.supplier) then
					d.add_client_supplier_figure (csf)
				end
				supplier_figures.forth
			end
			d.excluded_figures.prune_all (Current)
		end
	
	change_origin (new_origin: EV_RELATIVE_POINT) is
			-- Set the point this figure is relative to.
			-- Do not change absolute coordinates.
		local
			lf: like links
			link: LINK_FIGURE
		do
			point.change_origin (new_origin)
			lf := links
			from
				lf.start
			until
				lf.after
			loop
				link := lf.item
				if link.source /= link.target then
					link.change_origin (new_origin)
				end
				lf.forth
			end
		end

	change_origin_current_cluster (new_origin: EV_RELATIVE_POINT) is
			-- Set the point this figure is relative to.
			-- Do not change absolute coordinates.
			-- Do not change origin of links relative to parent clusters.
		local
			lf: like links
			csf: CLIENT_SUPPLIER_FIGURE
		do
			point.change_origin (new_origin)
			lf := current_cluster_links
			from
				lf.start
			until
				lf.after
			loop
				csf ?= lf.item
				if csf /= Void and then csf.is_reflexive then
					csf.update_origin
				else
					lf.item.change_origin (new_origin)
				end
				lf.forth
			end
		end

feature {NONE} -- Implementation

	initialize_structure is
			-- Re-initialize structures.
		local
			class_c: CLASS_C
		do
			if name = Void then
				name := clone (class_i.name)
				name.to_upper
			end
			if generics = Void then
				class_c := class_i.compiled_class
				if class_c /= Void then
					generics := class_c.ast.generics_as_string
				end
			elseif generics.is_empty then
				generics := Void
			end
		end

feature {CONTEXT_DIAGRAM, EB_CONTEXT_DIAGRAM_COMMAND, CASE_SUPPLIER, INHERITANCE_FIGURE} -- Generation

	code_generator: CLASS_TEXT_MODIFIER
			-- Associated with `class_i'.

feature {NONE} -- Implementation

	on_class_drop (a_stone: CLASSI_FIGURE_STONE) is
			-- `a_stone' was dropped on `Current'.
		require
	--		no_inheritance_circle_created: drop_allowed (a_stone)
		local
			dial: EV_CONFIRMATION_DIALOG
			class_file: PLAIN_TEXT_FILE
		do
			create class_file.make (a_stone.class_i.file_name)
			if class_file.is_writable and then not a_stone.class_i.cluster.is_library then
				if world.is_link_inheritance then
					if drop_allowed (a_stone) then
						world.add_inheritance_relation (a_stone.source, Current)
					else
						create dial.make_with_text_and_actions (
							"An inheritance circle was created.%N%
								%Do you still want to add this link?",
							<<world~add_inheritance_relation (a_stone.source, Current)>>)
						dial.show_modal_to_window (world.context_editor.development_window.window)
					end
				elseif world.is_link_client then
					world.add_client_supplier_relation (a_stone.source, Current)
				elseif world.is_link_aggregate then
					world.add_aggregate_client_supplier_relation (a_stone.source, Current)
				end
			else
				create error_window.make_with_text ("Class is not editable")
				error_window.show_modal_to_window (world.context_editor.development_window.window)
			end
		end

	drop_allowed (a_stone: CLASSI_FIGURE_STONE): BOOLEAN is
			-- Is `a_stone' droppable on `Current'?
		local
			new_child: CLASS_I
		do
			if world.is_link_inheritance then
				new_child := a_stone.source.class_i
				if new_child.compiled and class_i.compiled then
					Result := not class_i.compiled_class.conform_to (new_child.compiled_class)
				else
					Result := not class_i.name.is_equal ("any")
				end
			else
				Result := True
			end
		end

	on_pebble_request: ANY is
			-- New CLASS_STONE with `Current' as source.
		do
			create {CLASSI_FIGURE_STONE} Result.make (Current)
		end

	Storable_class: CLASS_C is
			-- Compiled class STORABLE.
		local
			cl: LIST [CLASS_I]
		do
			cl := (create {SHARED_EIFFEL_PROJECT}).Eiffel_system.Universe.compiled_classes_with_name ("storable")
			if cl /= Void and then not cl.is_empty then
				Result := cl.i_th (1).compiled_class
			end
		end

feature {CONTEXT_DIAGRAM} -- Synchronizing

	build_queries is
			-- Fill `queries' with all written features of the class
			-- that have a return type.
		local
			f: LIST [E_FEATURE]
			ef: E_FEATURE
		do
			create {LINKED_LIST [CASE_SUPPLIER]} queries.make
			if class_i.compiled then
				f := class_i.compiled_class.written_in_features
				from f.start until f.after loop
					ef := f.item
					if ef.type /= Void and then ef.type.has_associated_class then
						queries.extend (create {CASE_SUPPLIER}.make_compiled (ef))
					end
					f.forth
				end
			end
		end

end -- class CLASS_FIGURE
