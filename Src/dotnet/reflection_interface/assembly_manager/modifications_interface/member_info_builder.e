indexing
	description: "Provides support to build an instance of `SYSTEM_REFLECTION_MEMBERINFO'."
	external_name: "ISE.AssemblyManager.MemberInfoBuilder"

class
	MEMBER_INFO_BUILDER

create
	make
	
feature {NONE} -- Initialization

	make (a_descriptor: like assembly_descriptor) is
			-- Set `assembly_descriptor' with `a_descriptor'.
		indexing
			external_name: "Make"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		do
			assembly_descriptor := a_descriptor
		ensure
			assembly_descriptor_set: assembly_descriptor = a_descriptor
		end
	
feature -- Access
	
	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			-- Assembly descriptor
		indexing
			external_name: "AssemblyDescriptor"
		end
		
	type_external_name: STRING
			-- Type external name
		indexing
			external_name: "TypeExternalName"
		end
		
	feature_external_name: STRING
			-- Feature external name
		indexing
			external_name: "FeatureExternalName"
		end
	
	arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Feature arguments 
			-- | An argument is represented by its argument type external name.
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			external_name: "Arguments"
		end

	field_info: SYSTEM_REFLECTION_FIELDINFO is
			-- Field info from `feature_external_name'
		indexing
			external_name: "FieldInfo"
		require
			is_ready: is_ready
		local
			convert: ISE_REFLECTION_CONVERSIONSUPPORT
			an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			an_assembly: SYSTEM_REFLECTION_ASSEMBLY			
			a_type: SYSTEM_TYPE
			retried: BOOLEAN
		do
			if not retried then
				create convert
				an_assembly_name := convert.assemblynamefromdescriptor (assembly_descriptor)
				an_assembly := assembly_factory.load (assembly_name)
				a_type := an_assembly.gettype (type_external_name)
				if a_type /= Void then
					Result := a_type.getfield (feature_external_name)
				end
			end
		rescue
			retried := True
			retry
		end

	method_info: SYSTEM_REFLECTION_METHODINFO is
			-- Field info from `feature_external_name'
		indexing
			external_name: "MethodInfo"
		require
			is_ready: is_ready
		local
			convert: ISE_REFLECTION_CONVERSIONSUPPORT
			an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			an_assembly: SYSTEM_REFLECTION_ASSEMBLY		
			a_type: SYSTEM_TYPE
			arguments_types: ARRAY [SYSTEM_TYPE]
			i: INTEGER
			an_argument: STRING
			an_argument_type: SYSTEM_TYPE
			retried: BOOLEAN
		do
			if not retried then
				create convert
				an_assembly_name := convert.assemblynamefromdescriptor (assembly_descriptor)
				an_assembly := assembly_factory.load (assembly_name)
				a_type := an_assembly.gettype (type_external_name)
				if a_type /= Void then
					if arguments /= Void and then arguments.count > 0 then
						from
							create arguments_types.make (arguments.count)
						until
							i = arguments.count
						loop
							an_argument ?= arguments.item (i)
							if an_argument /= void then
								an_argument_type := type_factory.gettype_string (an_argument)
								if an_argument_type /= Void then
									arguments_types.put (i, an_argument_type)
								end
							end
							i := i + 1
						end
						Result := a_type.getmethod (feature_external_name, arguments_types)
					else
						Result := a_type.getmethod (feature_external_name)
					end
				end
			end
		end

feature -- Status Report

	is_ready: BOOLEAN is
			-- Is builder ready to generate a member info?
		indexing
			external_name: "IsReady"
		do
			Result := assembly_descriptor and (type_external_name /= Void and then type_external_name.length > 0) and (feature_external_name /= Void and then feature_external_name.length > 0)
		end

feature -- Status Setting

	set_type_external_name (a_name: like type_external_name) is
			-- Set `type_external_name' with `a_name'.
		indexing
			external_name: "SetTypeExternalName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.length > 0
		do
			type_external_name := a_name
		ensure
			type_external_name_set: type_external_name.equals_string (a_name)
		end

	set_feature_external_name (a_name: like feature_external_name) is
			-- Set `feature_external_name' with `a_name'.
		indexing
			external_name: "SetFeatureExternalName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.length > 0
		do
			feature_external_name := a_name
		ensure
			feature_external_name_set: feature_external_name.equals_string (a_name)
		end

	set_arguments (an_arry: like arguments) is
			-- Set `arguments' with `an_array'.
		indexing
			external_name: "SetArguments"
		require
			non_void_array: an_array /= Void
		do
			arguments := an_array
		ensure
			arguments_set: arguments = an_array
		end

feature {NONE} -- Implementation

	assembly_factory: SYSTEM_REFLECTION_ASSEMBLY
			-- Static needed to load assemblies
		indexing
			external_name: "AssemblyFactory"
		end
				
end -- class MEMBER_INFO_BUILDER