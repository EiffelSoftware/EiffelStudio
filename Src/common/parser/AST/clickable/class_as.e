indexing
	description: "Abstract description of an Eiffel class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_AS

inherit
	AST_EIFFEL

	CLICKABLE_AST
		redefine
			is_class
		end
		
	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (n: like class_name;
			ext_name: STRING;
			is_d, is_e, is_s, is_fc, is_ex: BOOLEAN;
			top_ind: like top_indexes;
			bottom_ind: like bottom_indexes;
			g: like generics;
			p: like parents;
			c: like creators;
			co: like convertors;
			f: like features;
			inv: like invariant_part;
			s: like suppliers;
			o: like obsolete_message;
			he: like has_externals;
			ed: like end_keyword)
		is
			-- Create a new CLASS AST node.
		require
			n_not_void: n /= Void
			s_not_void: s /= Void
			co_valid: co /= Void implies not co.is_empty
			ed_not_void: ed /= Void
		do
			class_name := n
			external_class_name := ext_name
			is_deferred := is_d
			is_expanded := is_e
			is_separate := is_s
			is_frozen := is_fc
			is_external := is_ex
			top_indexes := top_ind
			bottom_indexes := bottom_ind
			generics := g
			parents := p
			creators := c
			convertors := co
			features := f
			invariant_part := inv
			has_externals := he
			if
				invariant_part /= Void and then
				invariant_part.assertion_list = Void
			then
					-- The keyword `invariant' followed by no assertion
					-- at all is not significant.
				invariant_part := Void
				has_empty_invariant := True
			end
			suppliers := s
			obsolete_message := o

			end_keyword := ed
		ensure
			class_name_set: class_name = n
			external_class_name_set: external_class_name = ext_name
			is_deferred_set: is_deferred = is_d
			is_expanded_set: is_expanded = is_e
			is_separate_set: is_separate = is_s
			is_frozen_set: is_frozen = is_fc
			is_external_set: is_external = is_ex
			top_indexes_set: top_indexes = top_ind
			bottom_indexes_set: bottom_indexes = bottom_ind
			generics_set: generics = g
			parents_set: parents = p
			creators_set: creators = c
			convertors_set: convertors = co
			features_set: features = f
			empty_invariant_part: invariant_part = Void implies inv = Void or else inv.assertion_list = Void
			invariant_part_set: invariant_part /= Void implies invariant_part = inv
			suppliers_set: suppliers = s
			obsolete_message_set: obsolete_message = o
			has_externals_set: has_externals = he
			end_keyword_not_void: end_keyword = ed
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_class_as (Current)
		end

feature -- Attributes

	class_name: ID_AS
			-- Class name

	external_class_name: STRING
			-- External_name of class if `is_external'.

	obsolete_message: STRING_AS
			-- Obsolete message clause 
			-- (Void if was not present)

	top_indexes: INDEXING_CLAUSE_AS
			-- Indexing clause at top of class.

	bottom_indexes: INDEXING_CLAUSE_AS
			-- Indexing clause at bottom of class.

	generics: EIFFEL_LIST [FORMAL_DEC_AS]
			-- Formal generic parameter list

	parents: EIFFEL_LIST [PARENT_AS]
			-- Inheritance clause

	creators: EIFFEL_LIST [CREATE_AS]
			-- Creators

	convertors: EIFFEL_LIST [CONVERT_FEAT_AS]
			-- Convertors

	features: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			-- Feature list

	invariant_part: INVARIANT_AS
			-- Class invariant

	suppliers: SUPPLIERS_AS
			-- Supplier types

	is_deferred: BOOLEAN
			-- Is the class deferred ?

	is_expanded: BOOLEAN
			-- Is the class expanded ?

	is_separate: BOOLEAN
			-- Is the class separate ?

	is_frozen: BOOLEAN
			-- Is class frozen, ie we cannot inherit from it.

	is_external: BOOLEAN
			-- Is class just an encapsulation of an already generated class.

	click_list: CLICK_LIST is
		local
			l_clicklist_visitor: AST_CLICKABLE_VISITOR
		do
			Result := internal_click_list
			if Result = Void then
				create l_clicklist_visitor
				Result := l_clicklist_visitor.click_list (Current)
				internal_click_list := Result
			end
		end

	internal_click_list: CLICK_LIST
			-- Clickable AST items for current class.

	end_keyword: LOCATION_AS
			-- Position of last end keyword

	feature_clause_insert_position: INTEGER
			-- Position at end of features

	inherit_clause_insert_position: INTEGER
			-- Position at end of inherit clause.

	generics_start_position: INTEGER
			-- Position at start of formal generics.

	generics_end_position: INTEGER
			-- Position at end of formal generics.

	invariant_insertion_position: INTEGER is
			-- Position where new invariant can be inserted (at the end of an invariant
			-- clause if any, otherwise before the indexing or end keyword).
		do
			if invariant_part /= Void then
				Result := invariant_part.end_location.final_position + 1
			elseif bottom_indexes /= Void then
				Result := bottom_indexes.start_position
			else
				Result := end_keyword.position
			end
		end

	has_empty_invariant: BOOLEAN
			-- Does class have an empty invariant clause?
			
	has_externals: BOOLEAN
			-- Does current class have an external declaration?

feature -- Status report

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if top_indexes /= Void then
				Result := top_indexes.start_location
			else
				Result := class_name.start_location
			end
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := end_keyword
		end

feature {EIFFEL_PARSER} -- Element change

	set_text_positions (ge, ip, fp: INTEGER) is
			-- Set positions in class text.
		require
			ge_positive_or_not_present: ge >= 0
			ip_positive: ip >= 0 and ip >= ge
			fp_positive: fp > 0 and fp >= ip
		do
			generics_end_position := ge
			inherit_clause_insert_position := ip
			feature_clause_insert_position := fp
		ensure
			generics_end_position: generics_end_position = ge
			inherit_clause_insert_position_set: inherit_clause_insert_position = ip
			feature_clause_insert_position_set: feature_clause_insert_position = fp
		end

feature -- Access

	feature_with_name (n: STRING): FEATURE_AS is
			-- Feature AST with internal name `n'.
		require
			n_not_void: n /= Void
		local
			cur: CURSOR
		do
			if features /= Void then
				cur := features.cursor
				from
					features.start
				until
					features.after or else Result /= Void
				loop
					Result := features.item.feature_with_name (n)
					features.forth
				end
				features.go_to (cur)
			end
		end

	parent_with_name (n: STRING): PARENT_AS is
			-- Parent AST with class name `n'.
		require
			n_not_void: n /= Void
		local
			cur: CURSOR
			pn: STRING
		do
			if parents /= Void then
				cur := parents.cursor
				from
					parents.start
				until
					parents.after or else Result /= Void
				loop
					pn := parents.item.type.class_name
					if pn.is_equal (n) then
						Result := parents.item
					end
					parents.forth
				end
				parents.go_to (cur)
			end
		end

	clickable_item (a_clickable: CLICKABLE_AST): CLICK_AST is
			-- Corresponding click-item for `a_clickable'.
			-- `Void' if not in `click_list'.
		require
			a_clickable_not_void: a_clickable /= Void
		local
			l_click_list: CLICK_LIST
		do
			l_click_list := click_list
			if l_click_list /= Void then
				Result := l_click_list.item_by_node (a_clickable)
			end
		ensure
			correct_item: Result /= Void implies Result.node = a_clickable
		end

	click_ast: CLICK_AST is
			-- Position of class name.
		do
			Result := clickable_item (Current)
		ensure
			not_void: Result /= Void
			correct_item: Result.node = Current
		end

	generics_as_string: STRING is
			-- Output `formal_decs' as string to `generics'.
			-- `Void' if `generics' `Void'.
		local
			i: INTEGER
		do
			if generics /= Void then
				create Result.make (3)
				Result.extend ('[')
				from i := 1 until i > generics.count loop
					if i > 1 then
						Result.append (", ")
					end
					Result.append (generics.i_th (i).constraint_string)
					i := i + 1
				end
				Result.extend (']')
			end
		end

	custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Custom attributse of current class if any.
		do
			if top_indexes /= Void then
				Result := top_indexes.custom_attributes
			end
		end

	class_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Custom attributes of current class if any.
		do
			if top_indexes /= Void then
				Result := top_indexes.class_custom_attributes
			end
		end

	interface_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Custom attributes of current class if any.
		do
			if top_indexes /= Void then
				Result := top_indexes.interface_custom_attributes
			end
		end
		
	assembly_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Custom attributes of current class if any.
		do
			if top_indexes /= Void then
				Result := top_indexes.assembly_custom_attributes
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_name, other.class_name) and then
				equivalent (creators, other.creators) and then
				equivalent (generics, other.generics) and then
				equivalent (top_indexes, other.top_indexes) and then
				equivalent (bottom_indexes, other.bottom_indexes) and then
				equivalent (invariant_part, other.invariant_part) and then
				equivalent (obsolete_message, other.obsolete_message) and then
				equivalent (parents, other.parents) and then
				equivalent (features, other.features) and then
				is_deferred = other.is_deferred and then
				is_expanded = other.is_expanded and then
				is_separate = other.is_separate 
		end

feature {CLASS_C} -- Update

	assign_unique_values (counter: COUNTER; values: HASH_TABLE [INTEGER, STRING]) is
			-- Assign values to Unique features defined in the current class
		require
			valid_args: counter /= Void and values /= Void
		do
			from
				features.start
			until
				features.after
			loop
				features.item.assign_unique_values (counter, values)
				features.forth
			end
		end

feature {COMPILER_EXPORTER} -- Setting

	set_top_indexes (i: like top_indexes) is
		do
			top_indexes := i
		end

invariant
	convertors_valid: convertors /= Void implies not convertors.is_empty

end -- class CLASS_AS
