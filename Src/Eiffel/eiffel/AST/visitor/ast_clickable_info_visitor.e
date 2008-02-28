indexing
	description: "Given a CLICKABLE_AST node, return the associated CLASS_I instance it represents."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_CLICKABLE_INFO_VISITOR

inherit
	AST_NULL_VISITOR
		redefine
			process_precursor_as,
			process_class_type_as,
			process_generic_class_type_as,
			process_named_tuple_type_as,
			process_class_as
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

feature -- Queries

	associated_eiffel_class (a_class_i: CLASS_I; a_node: CLICKABLE_AST): CLASS_I is
		require
			a_class_i_not_void: a_class_i /= Void
			a_node_not_void: a_node /= Void
			a_node_is_class_or_precursor: a_node.is_class or a_node.is_precursor
		do
			reference_class := a_class_i
			a_node.process (Current)
			Result := last_class
			last_class := Void
			reference_class := Void
		end

feature {NONE} -- Implementation

	reference_class: CLASS_I
			-- Class in which `last_class' will be resolved

	last_class: CLASS_I
			-- Last computed class

	process_precursor_as (l_as: PRECURSOR_AS) is
		do
			check
				reference_class_not_void: reference_class /= Void
			end
			last_class := Universe.safe_class_named (l_as.parent_base_class.class_name.name, reference_class.group)
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
			check
				reference_class_not_void: reference_class /= Void
			end
			last_class := Universe.safe_class_named (l_as.class_name.name, reference_class.group)
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS) is
		do
			process_class_type_as (l_as)
		end

	process_class_as (l_as: CLASS_AS) is
		do
			check
				reference_class_not_void: reference_class /= Void
			end
			last_class := Universe.safe_class_named (l_as.class_name.name, reference_class.group)
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS) is
		do
			check
				reference_class_not_void: reference_class /= Void
			end
			last_class := Universe.safe_class_named (l_as.class_name.name, reference_class.group)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end
