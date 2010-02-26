note
	description: "Objects that is an inheritance link in eiffel studio."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_INHERITANCE_LINK

inherit
	EM_INHERITANCE_LINK
		redefine
			default_create,
			ancestor,
			descendant
		end

	ES_ITEM
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	default_create
			-- Create a ES_INHERITANCE_LINK
		do
			Precursor {EM_INHERITANCE_LINK}
			is_needed_on_diagram := True
		end

	make (a_descendant, an_ancestor: ES_CLASS; a_synchronize: BOOLEAN)
			-- Create an ES_INHERITANCE_LINK connecting `a_descendant' with `an_ancestor'.
			-- Synchronize with compiler meta-data if `a_synchronize' (for XML deserialization)
		do
			make_directed_with_source_and_target (a_descendant, an_ancestor)
			if a_synchronize then
				synchronize
			end
		end

feature -- Access

	ancestor: ES_CLASS
			-- Ancestor of `descendant'.

	descendant: ES_CLASS
			-- Descendant of `ancestor'

feature -- Element change

	synchronize
			-- Check if descendant is still descendant of ancestor.
			-- Remove `Current' otherwise.
		local
			l: LIST [CLASS_C]
			cl: CLASS_I
			is_still_valid: BOOLEAN
			l_is_non_conforming: BOOLEAN
			l_ancestor_class_c: CLASS_C
		do
			if ancestor.class_i.is_compiled then
				l_ancestor_class_c := ancestor.class_i.compiled_class
				l := l_ancestor_class_c.direct_descendants
				if l /= Void then
					from
						l.start
					until
						is_still_valid or else l.after
					loop
						cl := l.item.original_class
						if cl = descendant.class_i then
							is_still_valid := True
							if not l.item.conforming_parents_classes.has (l_ancestor_class_c) then
									-- Link must be non-conforming
								l_is_non_conforming := True
							end
						end
						l.forth
					end
				end
			end
			if not is_still_valid then
				if graph /= Void then
					graph.remove_link (Current)
				end
			end
				-- Update conformance status
			set_is_non_conforming (l_is_non_conforming)
		end

invariant
	descendant_not_void: descendant /= Void
	ancestor_not_void: ancestor /= Void

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class ES_INHERITANCE_LINK
