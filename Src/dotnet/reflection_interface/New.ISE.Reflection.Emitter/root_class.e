indexing
	description: "Root Class"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end
		
class
	ROOT_CLASS
		
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
		do
		end
		
feature -- Access

	ise_reflection_eiffel_components: EIFFEL_COMPONENTS
		indexing
			description: "ISE Reflection Eiffel Components"
		end
		
	ise_reflection_eiffel_assembly_cache_notifier: NOTIFIER_HANDLE
		indexing
			description: "ISE Reflection Eiffel Assembly Cache Notifier"
		end
		
	ise_reflection_support: SUPPORTS
		indexing
			description: "ISE Reflection Eiffel Assembly Cache Notifier"
		end
		
	ise_reflection_eiffel_assembly_cache_handler: EIFFEL_ASSEMBLY_CACHE_HANDLER
		indexing
			description: "ISE Reflection Eiffel Assembly Cache Handler"
		end
		
	ise_reflection_code_generator: GENERATOR
		indexing
			description: "ISE Reflection Code Generator"
		end
		
	ise_reflection_reflection_interface: REFLECTION_INTERFACE
		indexing
			description: "ISE Reflection Reflection Interface";
			external_name: "ise_reflection_reflection_interface"
		end
		
end -- class ROOT_CLASS
