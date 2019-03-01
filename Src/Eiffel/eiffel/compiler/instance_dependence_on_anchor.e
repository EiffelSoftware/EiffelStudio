note
	description: "Descriptor of a dependence of a feature (or class invariant) on an anchored type."
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision: ор$"

deferred class
	INSTANCE_DEPENDENCE_ON_ANCHOR

inherit
	INSTANCE_DEPENDENCE
		redefine
			record_new_dependence
		end

	COMPILER_EXPORTER

feature {INSTANCE_DEPENDENCE_GENERATOR} -- Access

	class_id: like {CLASS_C}.class_id
			-- ID of the class with the anchor.

feature -- Status report

	has_removed_class (v: CLASS_ID_VALIDATOR): BOOLEAN
			-- <Precursor>
		do
			Result := not v.is_valid (class_id) or else not v.has (class_id)
		end

feature -- Traversal

	record (r: CLASS_RECORDER)
			-- <Precursor>
		do
				-- Register feature type for all live descendants of the class with ID `class_id`.
			if
				attached workbench.system as s and then
				attached s.class_of_id (class_id) as c
			then
				record_descendants (c, r)
			end
		end

	record_new_dependence (r: CLASS_RECORDER; d: DEPENDENCE_RECORDER)
			-- <Precursor>
		do
			record (r)
			d.request_alive_clases (Current)
		end

feature {NONE} -- Traversal

	anchor_type (c: CLASS_C): detachable TYPE_A
			-- De-anchored type of the anchor in a class `c`.
		deferred
		end

	record_descendants (c: CLASS_C; r: CLASS_RECORDER)
			-- Record, in `r`, classes that can be used to instantiate an object or be instances themselves
			-- for descendants of the class `c`.
		do
			if
				r.is_class_alive (c.class_id) and then
				attached anchor_type (c) as a
			then
				if attached {CL_TYPE_A} a as t then
					record_class_id (t.class_id, r)
				elseif attached {FORMAL_A} a as t then
					record_formal (t.position, c.class_id, r)
				end
			end
			across
				c.direct_descendants as d
			loop
				record_descendants (d.item, r)
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
end
