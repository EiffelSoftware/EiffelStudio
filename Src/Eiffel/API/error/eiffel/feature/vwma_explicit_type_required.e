note
	description: "[
		Manifest array may need to be specified with an explicit type.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class VWMA_EXPLICIT_TYPE_REQUIRED

inherit
	VWMA
		rename
			class_c as associated_class,
			make as make_parent
		undefine
			has_associated_file,
			process_issue
		redefine
			error_string
		end

	EIFFEL_WARNING
		undefine
			build_explain,
			file_name,
			process_issue,
			trace,
			trace_primary_context,
			trace_single_line
		redefine
			error_string
		end

	FIX_PROVIDER_FOR_MANIFEST_ARRAY_TYPE
		rename
			source_feature as e_feature,
			type_to_add as target_array_type
		end

	SHARED_WORKBENCH

feature {NONE} -- Creation

	make (c: AST_CONTEXT; i, t: TYPE_A; a: ARRAY_AS; e: BOOLEAN)
			-- Initialize error object for implicit element type `i` and target element type `t`
			-- of a manifest array `a` in the context `c` with the error indicator `e`
			-- when the manifest array type is different from the target type.
			--
			-- `e`: `True` - Error, `False` - Warning.
		require
			c_attached: attached c
			i_attached: attached i
			t_attached: attached t
			a_attached: attached a
		do
			implicit_element_type := i
			target_element_type := t
			is_error := e
			array := a
			make_parent (c, a.first_token (system.match_list_server.item (c.written_class.class_id)))
		ensure
			implicit_element_type_set: implicit_element_type = i
			target_element_type_set: target_element_type = t
			is_error_set: is_error = e
			array_set: array = a
		end

feature -- Access

	error_string: STRING
			-- <Precursor>
		do
			Result := if is_error then Precursor {VWMA} else Precursor {EIFFEL_WARNING} end
		end

feature {FIX_FEATURE} -- Access

	target_array_type: GEN_TYPE_A
			-- Type of a target.
		do
			create Result.make (system.array_id, create {like {GEN_TYPE_A}.generics}.make_from_array (<<target_element_type>>))
		end

	array: ARRAY_AS
			-- Manifest array AST node.

feature -- Access: fixing

	source_class: CLASS_I
			-- <Precursor>
		do
			Result := written_class.lace_class
		end

feature {NONE} -- Access

	implicit_element_type: TYPE_A
			-- Implicit element type.

	target_element_type: TYPE_A
			-- Type of a target element.

	is_error: BOOLEAN
			-- Does current represent an error?

;note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

end
