indexing
	description: "[
		Objects that represent an EiffelBuild constant. Note that `value' is only defined
		in descendents, as for an INTEGER constant, it is an expanded type, and we cannot
		define it as deferred here.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_CONSTANT

inherit
	GB_CONSTANTS

	GB_XML_UTILITIES
		export
			{NONE} all
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

	INTERNAL
		export
			{NONE} all
		end

feature -- Access

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	type: STRING is
			-- Type of `Current'.
		deferred
		end

	name: STRING
			-- Name of `Current'.

	value_as_string: STRING is
			-- Value represented by `Current' as a STRING.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	small_pixmap: EV_PIXMAP
			-- Representation of `Current' as a small pixmap. Used in representations
			-- of `Current'. May be Void for some descendents.

	as_multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW is
			-- Representation of `Current' as a multi column list row.
		deferred
		ensure
			Result_not_void: Result /= Void
			data_points_to_current: Result.data = Current
		end

	referers: ARRAYED_LIST [GB_CONSTANT_CONTEXT]
			-- All contexts in which `Current' is specified.

feature -- Element change

	set_name (a_name: STRING) is
			-- Assign  `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and not a_name.is_empty
		do
			name := a_name
		ensure
			name_assigned: name = a_name
		end

	add_referer (referer: GB_CONSTANT_CONTEXT) is
			-- Add `referer' to `referers'.
		require
			referer_not_void: referer /= Void
		do
			referers.extend (referer)
		ensure
			has_referer: referers.has (referer)
		end

	remove_referer (referer: GB_CONSTANT_CONTEXT) is
			-- Remove `referer' from `referers'.
		require
			referer_not_void: referer /= Void
		do
			referers.prune_all (referer)
		ensure
			not_has_referer: not referers.has (referer)
		end

feature -- Miscellaneous

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XM representation of `Current' in `element'.
		require
			element_not_void: element /= Void
		do
			add_element_containing_string (element, type_string, type)
			add_element_containing_string (element, constant_name_string, name)
			add_element_containing_string (element, Constant_value_string, value_as_string)
		end

feature {NONE} -- Implementation

	new_gb_ev_any (constant_context: GB_CONSTANT_CONTEXT): GB_EV_ANY is
			-- `Result' is new instance of GB_EV_ANY representing object properties
			-- referenced by `constant_context'.
		require
			constant_context_not_void: constant_context /= Void
		local
			display_object: GB_DISPLAY_OBJECT
		do
			Result ?= new_instance_of (dynamic_type_from_string ("GB_" + constant_context.property))
			Result.default_create
			Result.set_components (components)
			Result.set_object (constant_context.object)
			check
				Result_exists: Result /= Void
			end
			Result.add_object (constant_context.object.object)

				-- We need to check that the display_object is not of type `GB_DISPLAY_OBJECT'.
				-- If it is, we must add its child, as this is the object that must be modified.
			display_object ?= constant_context.object.display_object
			if display_object /= Void then
				Result.add_object (display_object.child)
			else
				Result.add_object (constant_context.object.display_object)
			end
		ensure
			Result_not_void: Result /= Void
		end

invariant
	name_not_void: name /= Void and not name.is_empty
	type_not_void: type /= Void and not type.is_empty
	referers_not_void: referers /= Void

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


end -- class GB_CONSTANT
