indexing
	description: "Include all the information needed to generate xml assembly description file"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class 
	EIFFEL_ASSEMBLY_IMP

inherit
	SUPPORT_IMP
		rename
			interface as support_interface
		end
	GLOBAL_CONVERSATION [EIFFEL_CLASS]
		
create
	make, make_from_interface

feature {NONE} -- Initialization

	make (a_descriptor: like assembly_descriptor; a_path: like eiffel_cluster_path; a_number: like emitter_version_number) is
		indexing
			description: "[
						Set `assembly_descriptor' with `a_descriptor'.
						Set `eiffel_cluster_path' with `a_path'.
						Set `emitter_version_number' with `a_number'.
					  ]"
		do
			create class_interface.make_from_implementation (Current, a_descriptor, to_eiffel_string(a_path), to_eiffel_string(a_number))
		end
		
	make_from_interface (a_interface: like class_interface) is
		do
			class_interface := a_interface
			class_interface.set_implementation (Current)
		end
		
	class_interface: EIFFEL_ASSEMBLY

feature -- Access

	assembly_descriptor: ASSEMBLY_DESCRIPTOR is
		indexing
			description: "Assembly descriptor"
		do
			Result := class_interface.assembly_descriptor
		end
		
	eiffel_cluster_path: SYSTEM_STRING is
		indexing
			description: "Path to cluster where Eiffel classes will be generated"
		do
			Result := from_eiffel_string (class_interface.eiffel_cluster_path)
		end
		
	emitter_version_number: SYSTEM_STRING is
		indexing
			description: "Emitter version number"
		do
			Result := from_eiffel_string (class_interface.emitter_version_number)
		end

	Types_retrieval_failed: SYSTEM_STRING is 
		indexing
			description: "Error name: types retrieval has failed"
		do
			Result := from_eiffel_string (class_interface.Types_retrieval_failed)
		end
	
	Types_retrieval_failed_message: SYSTEM_STRING is 
		indexing
			description: "Error message when types retrieval has failed"
		do
			Result := from_eiffel_string (class_interface.Types_retrieval_failed_message)
		end	
		
	types: ARRAY_LIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			description: "Assembly types"
		do
			result := from_eiffel_linked_list (class_interface.types)
		end

end -- class EIFFEL_ASSEMBLY
