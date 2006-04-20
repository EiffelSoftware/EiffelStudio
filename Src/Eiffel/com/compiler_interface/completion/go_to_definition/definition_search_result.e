indexing
	description: "Results of definition located when parsing Eiffel source text"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEFINITION_SEARCH_RESULT

inherit
	IEIFFEL_DEFINITION_RESULT_IMPL_STUB
		redefine
			module_name,
			namespace,
			class_descriptor
		end
		
	COMPILER_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (a_class: CLASS_I) is
			-- create instance using `class_i'
		require
			non_void_class_i: a_class /= Void
		local
			assembly_i: ASSEMBLY_I
			cluster_i: CLUSTER_I
			dot_pos: INTEGER
		do
			create {CLASS_DESCRIPTOR}class_descriptor.make_with_class_i (a_class)
			cluster_i := a_class.cluster
			assembly_i ?= cluster_i
			if assembly_i /= Void then
				module_name := clone (assembly_i.assembly_name)
				if class_descriptor.is_true_external then
					dot_pos := a_class.external_name.last_index_of ('.', a_class.external_name.count)
					if dot_pos > 1  then
						namespace := a_class.external_name.substring (1, dot_pos - 1)
					end	
				else
					namespace := clone (cluster_i.cluster_name)
				end
			else
				module_name := clone (a_class.name)
				namespace := clone (cluster_i.cluster_name)
			end
			class_i := a_class
		end

feature -- Access

	module_name: STRING
			-- name of cluster or assembly
	
	namespace: STRING
			-- full cluster name or assembly namespace
			
	class_descriptor: CLASS_DESCRIPTOR
			-- name of class where definition was located
			
	class_i: CLASS_I
			-- class corresponding to located definition
	
invariant
	non_void_module_name: module_name /= Void
	valid_module_name: not module_name.is_empty
	non_void_namespace: namespace /= Void
	non_void_class_descriptor: class_descriptor /= Void
	non_void_class_i: class_i /= Void

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
end -- class DEFINITION_SEARCH_RESULT
