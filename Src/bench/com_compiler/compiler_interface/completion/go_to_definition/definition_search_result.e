indexing
	description: "Results of definition located when parsing Eiffel source text"
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
			cluster_i := a_class.cluster
			assembly_i ?= cluster_i
			if assembly_i /= Void then
				module_name := clone (assembly_i.assembly_name)
				if a_class.is_external_class then
					if a_class.compiled_class /= Void then
						dot_pos := a_class.compiled_class.external_name.last_index_of ('.', a_class.compiled_class.external_name.count)
						if dot_pos > 1  then
							namespace := a_class.compiled_class.external_name.substring (1, dot_pos - 1)
						end		
					end		
				else
					namespace := clone (cluster_i.cluster_name)
				end
			else
				module_name := clone (a_class.name)
				namespace := clone (cluster_i.cluster_name)
			end
			class_i := a_class
			create {CLASS_DESCRIPTOR}class_descriptor.make_with_class_i (a_class)
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

end -- class DEFINITION_SEARCH_RESULT
