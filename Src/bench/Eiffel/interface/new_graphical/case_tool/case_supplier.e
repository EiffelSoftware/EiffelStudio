indexing
	description:
		"Supplier data necessary for the context tool."
	note:
		"Represents one OR MORE supplier links.%N%
		%See class text for details."
	date: "$Date$"
	revision: "$Revision$"

class
	CASE_SUPPLIER

inherit
	SHARED_API_ROUTINES

	SHARED_WORKBENCH

create
	make_compiled,
	make_new,
	make_default

feature {NONE} -- Initialization

	make_compiled (a_feature: E_FEATURE) is
			-- Create with `a_feature'.
			-- (From compiled system.)
		require
			a_feature_not_void: a_feature /= Void
			a_feature_has_non_formal_type:
				a_feature.type /= Void and then a_feature.type.has_associated_class
		do
			e_feature := a_feature
			feature_as := a_feature.ast
			initialize
		end

	make_new (a_feature: FEATURE_AS) is
			-- Create with `a_feature' and `a_type'.
			-- (Created by user.)
		require
			a_feature_not_void: a_feature /= Void
		do
			feature_as := a_feature
			initialize
		end

	make_default is
			-- Create without any feature.
		do
		end

feature {CLASS_TEXT_MODIFIER} -- Initialization

	initialize is
			-- Build structures.
		do
			create {LINKED_LIST [CLASS_I]} supplier_classes.make
			create type_as_string.make (10)
			add_suppliers (feature_as.body.type)
			type_as_string.to_upper
			create {LINKED_LIST [CLIENT_SUPPLIER_FIGURE]} graphical_links.make
			initialized := True
		ensure
			initialized: initialized
		end

	initialized: BOOLEAN
			-- Has `Current' been properly initialized?
			
feature -- Access

	e_feature: E_FEATURE
			-- Supplier. Void if not compiled.

	feature_as: FEATURE_AS
			-- Supplier AST.

	feature_code: STRING
			-- Code of feature corresponding to `feature_as'.

	insertion_position: INTEGER
			-- Position where `feature_code' has to be inserted.

	supplier_classes: LIST [CLASS_I]
			-- All supplier types.
			-- If the type of the feature returns for example a
			-- LINKED_LIST [CLASS_FIGURE] this list containe
			-- LINKED_LIST and CLASS_FIGURE in that order.

	graphical_links: LIST [CLIENT_SUPPLIER_FIGURE]
			-- Actual graphical objects in diagram.
			
	graphical_link_with_supplier (cf: CLASS_FIGURE): CLIENT_SUPPLIER_FIGURE is
			-- Item in `saved_graphical_links' with `cf' as supplier.
			-- Void if none.
		local
			csf: CLIENT_SUPPLIER_FIGURE
		do
			from
				graphical_links.start
			until
				Result /= Void or else graphical_links.after
			loop
				csf := graphical_links.item
				if csf.supplier = cf then
					Result := csf
				end
				graphical_links.forth
			end
		end
		
	type_as_string: STRING
			-- Dump of feature's return type.

	type_label (a_supplier: CLASS_I): STRING is
			-- Type label with `a_supplier' as ellipsis.
		require
			a_supplier_not_void: a_supplier /= Void
			has_a_supplier: has_supplier (a_supplier)
		local
			up: STRING
		do
			Result := clone (type_as_string)
			up := clone (a_supplier.name)
			up.to_upper
			Result.replace_substring_all (up, "...")
		end

	name: STRING is
			-- Name of feature.
			--| FIXME Multiple names?
		do
			if e_feature /= Void then
				Result := clone (e_feature.name)
				if e_feature.is_once or e_feature.is_constant then
					Result.put ((Result @ 1).upper, 1)
				end
			else
				Result := clone (feature_as.feature_name)
			end
		end

	invariant_insertion_position: INTEGER
			-- Position before the generated invariant clause (if any).

feature -- Element change

	set_feature_as (a_feature: FEATURE_AS) is
			-- Assign `a_feature' to `feature_as'.
		require
			a_feature_not_void: a_feature /= Void
		do
			feature_as := a_feature
		ensure
			a_feature_assigned: feature_as = a_feature
		end

	set_feature_code (code: STRING) is
			-- Assign `code' to `feature_code'.
			-- `code' may be Void if the feature is not in class text.
		do
			if code /= Void then
				feature_code := code
			else
				feature_code := Void
			end
		end

	set_insertion_position (i: INTEGER) is
			-- Assign `i' to `insertion_position'.
		require
			i_positive: i > 0
		do
			insertion_position := i
		ensure
			assigned: insertion_position = i
		end

	set_invariant_insertion_position (i: INTEGER) is
			-- Assign `i' to `invariant_insertion_position'.
		require
			i_positive: i > 0
		do
			invariant_insertion_position := i
		ensure
			assigned: invariant_insertion_position = i
		end

	has_supplier (a_supplier: CLASS_I): BOOLEAN is
			-- Is `a_supplier' one of `supplier_classes'?
		require
			a_supplier_not_void: a_supplier /= Void
		do
			Result := supplier_classes.has (a_supplier)
		end

	extend_graphical_link (csf: CLIENT_SUPPLIER_FIGURE) is
			-- Add `csf' to referring links.
		require
			csf_not_void: csf /= Void
		--	has_csf_as_supplier: has_supplier (csf.supplier.class_i)
		do
			graphical_links.extend (csf)
		end

	restore is
			-- Restore graphical objects.
		local
			client: CLASS_FIGURE
		do
			if not graphical_links.is_empty then
				client ?= graphical_links.first.client
				if client /= Void then
					from
						graphical_links.start
					until
						graphical_links.after
					loop
						graphical_links.item.put_on_diagram (client.world)
						graphical_links.forth
					end
				end
			end
		end

	remove is
			-- Remove graphical objects.
		local
			client: CLASS_FIGURE
		do
			if not graphical_links.is_empty then
				client ?= graphical_links.first.client
				if client /= Void then
					from
						graphical_links.start
					until
						graphical_links.after
					loop
						graphical_links.item.remove_from_diagram
						graphical_links.forth
					end
					client.world.context_editor.projector.project
				end
			end
		end

feature -- Status report

	is_compiled: BOOLEAN is
			-- Is `Current' created from exploration of the system?
		do
			Result := e_feature /= Void
		end

	is_single: BOOLEAN is
			-- Does `Current' consist of only one supplier?
		do
			Result := supplier_classes.count = 1
		end

	is_expanded: BOOLEAN is
			-- Is `Current' declared `expanded'?
		local
			et: EXP_TYPE_AS
			bt: BASIC_TYPE
			ct: CLASS_TYPE_AS
			type_as_class_c: CLASS_C
			class_c_any: CLASS_C
		do
			et ?= feature_as.body.type
			bt ?= feature_as.body.type
			Result := (et /= Void) or (bt /= Void)
			if not Result then
				ct ?= feature_as.body.type
				if ct /= Void then
					if System.any_class.compiled then
						class_c_any := System.any_class.compiled_class
							--| FIXME remove argument from `associated_eiffel_class'.
						type_as_class_c := ct.associated_eiffel_class(class_c_any)
						if type_as_class_c /= Void then
							Result := type_as_class_c.is_expanded
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	add_suppliers (a_type: TYPE) is
			-- Try to extract as good as possible all supplier types
			-- from `a_type'.
		local
			ct: CLASS_TYPE_AS
			bt: BASIC_TYPE
			g: EIFFEL_LIST [TYPE]
		do
			ct ?= a_type
			if ct /= Void then
				add_supplier (class_i_by_name (ct.class_name))
				g := ct.generics
				if g /= Void then
					type_as_string.append (" [")
					from
						g.start
					until
						g.after
					loop
						if not g.isfirst then
							type_as_string.append (", ")
						end
						add_suppliers (g.item)
						g.forth
					end
					type_as_string.append ("]")
				end
			else
				bt ?= a_type
				if bt /= Void then
					add_supplier (bt.actual_type.associated_class.lace_class)
				end
			end
		end

	add_supplier (sup: CLASS_I) is
			-- Add `sup' to `supplier_list' if not yet present and append
			-- to `type_as_string'.
		do
			if sup /= Void then
				type_as_string.append (sup.name)
				if not supplier_classes.has (sup) then
					supplier_classes.extend (sup)
				end
			end
		end

end -- class CASE_SUPPLIER
