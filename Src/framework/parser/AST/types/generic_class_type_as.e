indexing
	description: "Representation of generic classes."
	date: "$Date$"
	revision: "$Revision$"

class
	GENERIC_CLASS_TYPE_AS

inherit
	CLASS_TYPE_AS
		rename
			initialize as class_type_initialize
		redefine
			process, generics, last_token, dump
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (n: like class_name; g: like generics; m: SYMBOL_AS; a: like has_attached_mark; d: like has_detachable_mark) is
			-- Create a new CLASS_TYPE AST node.
		require
			n_not_void: n /= Void
			g_not_void: g /= Void
			n_upper: n.name.is_equal (n.name.as_upper)
			correct_attachment_status: not (a and d)
		do
			class_type_initialize (n, m, a, d)
			internal_generics := g
		ensure
			class_name_set: class_name.name.is_equal (n.name)
			internal_generics_set: internal_generics = g
			attachment_mark_set: m /= Void implies attachment_mark_index = m.index
			has_attached_mark_set: has_attached_mark = a
			has_detachable_mark_set: has_detachable_mark = d
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Process current element.
		do
			v.process_generic_class_type_as (Current)
		end

feature -- Access

	generics: TYPE_LIST_AS is
			-- Possible generical parameters
		do
			Result := internal_generics
			if Result.is_empty then
				Result := Void
			end
		end

feature -- Roundtrip

	internal_generics: like generics
			-- Internal actual generic parameters.

feature -- Roundtrip/Token

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := internal_generics.last_token (a_list)
				if Result = Void then
					Result := class_name.last_token (a_list)
				end
			end
		end

feature -- Conveniences

	dump: STRING is
			-- Dumped string
		do
			Result := Precursor {CLASS_TYPE_AS}
			from
				internal_generics.start;
				Result.append (" [")
			until
				internal_generics.after
			loop
				Result.append (internal_generics.item.dump)
				if not internal_generics.islast then
					Result.append (", ")
				end
				internal_generics.forth
			end
			Result.append ("]")
		end

invariant
	internal_generics_not_void: internal_generics /= Void

end
