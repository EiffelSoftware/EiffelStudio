indexing
	description: "Node for normal class type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_TYPE_AS

inherit
	TYPE_AS
		redefine
			has_formal_generic, has_like, is_loose,
			is_equivalent, start_location, end_location
		end

	CLICKABLE_AST
		redefine
			is_class
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (n: like class_name; g: like generics; a_is_exp, a_is_sep: BOOLEAN; e_as, s_as: KEYWORD_AS) is
			-- Create a new CLASS_TYPE AST node.
		require
			n_not_void: n /= Void
		do
			class_name := n
			class_name.to_upper
			internal_generics := g
			is_expanded := a_is_exp
			is_separate := a_is_sep
			expanded_keyword := e_as
			separate_keyword := s_as
		ensure
			class_name_set: class_name.is_equal (n.as_upper)
			generics_set: generics = g
			is_expanded_set: is_expanded = a_is_exp
			is_separate_st: is_separate = a_is_sep
			expanded_keyword_set: expanded_keyword = e_as
			separate_keyword_set: separate_keyword = s_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_class_type_as (Current)
		end

feature -- Attributes

	class_name: ID_AS
			-- Class type name

	generics: TYPE_LIST_AS is
			-- Possible generical parameters
		do
			if internal_generics = Void or else internal_generics.is_empty then
				Result := Void
			else
				Result := internal_generics
			end
		end

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

	is_expanded: BOOLEAN
			-- Is current type used with `expanded' keyword?

	is_separate: BOOLEAN
			-- Is current type used with `separate' keyword?

feature -- Roundtrip

	expanded_keyword: KEYWORD_AS
			-- Keyword "expanded" associated with this structure.

	separate_keyword: KEYWORD_AS
			-- Keyword "separate" associated with this structure.	

feature -- Roundtrip

	internal_generics: TYPE_LIST_AS
			-- Internal possible generical parameters

feature -- Roundtrip

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := class_name.complete_start_location (a_list)
			else
				if expanded_keyword /= Void then
					Result := expanded_keyword.complete_start_location (a_list)
				elseif separate_keyword /= Void then
					Result := separate_keyword.complete_start_location (a_list)
				else
					Result := class_name.complete_start_location (a_list)
				end
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if generics /= Void then
					Result := generics.complete_end_location (a_list)
				else
					Result := class_name.complete_end_location (a_list)
				end
			else
				if internal_generics /= Void then
					Result := internal_generics.complete_end_location (a_list)
				else
					Result := class_name.complete_end_location (a_list)
				end
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_name, other.class_name) and then
				equivalent (generics, other.generics) and then
				is_expanded = other.is_expanded
		end

feature -- Access

	has_like: BOOLEAN is
			-- Does the type have anchored type in its definition ?
		do
			if generics /= Void then
				from
					generics.start
				until
					generics.after or else Result
				loop
					Result := generics.item.has_like
					generics.forth
				end
			end
		end

	has_formal_generic: BOOLEAN is
			-- Has type a formal generic parameter?
		do
			if generics /= Void then
				from
					generics.start
				until
					generics.after or else Result
				loop
					Result := generics.item.has_formal_generic
					generics.forth
				end
			end
		end

	is_loose: BOOLEAN is
			-- Does type depend on formal generic parameters and/or anchors?
		local
			g: like generics
		do
			g := generics
			if g /= Void then
				from
					g.start
				until
					g.after or else Result
				loop
					Result := g.item.is_loose
					g.forth
				end
			end
		end

feature {COMPILER_EXPORTER} -- Conveniences

	set_class_name (s: like class_name) is
			-- Assign `s' to `class_name'.
		do
			class_name := s
		end

	set_generics (g: like generics) is
			-- Assign `g' to `generics'.
		do
			internal_generics := g
		end

	dump: STRING is
			-- Dumped string
		do
			create Result.make (class_name.count)
			Result.append (class_name)
			if generics /= Void then
				from
					generics.start;
					Result.append (" [")
				until
					generics.after
				loop
					Result.append (generics.item.dump)
					if not generics.islast then
						Result.append (", ")
					end
					generics.forth
				end
				Result.append ("]")
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CLASS_TYPE_AS
