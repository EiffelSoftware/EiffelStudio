indexing
	description: "Retrieves children from an instance of `ISE_REFLECTION_EIFFELCLASS'."
	external_name: "ISE.AssemblyManager.ParentsHandler"

class
	PARENTS_HANDLER
	
create
	make

feature {NONE} -- Initialization

	make (a_class: like eiffel_class; an_assembly_descriptor: like assembly_descriptor) is
		indexing
			description: "Set `eiffel_class' with `a_class'. Set `assembly_descriptor' with `an_assembly_descriptor'."
			external_name: "Make"
		require
			non_void_class: a_class /= Void
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		do
			eiffel_class := a_class
			assembly_descriptor := an_assembly_descriptor
			build_features_table
		ensure
			eiffel_class_set: eiffel_class = a_class
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			non_void_features_table: features_table /= Void
		end

feature -- Access

	eiffel_class: ISE_REFLECTION_EIFFELCLASS
		indexing
			description: "Eiffel class"
			external_name: "EiffelClass"
		end
	
	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
		indexing
			description: "Assembly descriptor"
			external_name: "AssemblyDescriptor"
		end
		
feature -- Status Setting

	is_inherited_feature (a_feature_name: STRING): BOOLEAN is
		indexing
			description: "Is feature with name `a_feature_name' inherited?"
			external_name: "IsInheritedFeature"
		require
			non_void_feature_name: a_feature_name /= Void
			not_empty_feature_name: a_feature_name.length > 0
		do
			if features_table.contains (a_feature_name) then
				Result ?= features_table.item (a_feature_name)
			else
				Result := True
			end
		end

feature {NONE} -- Implementation

	features_table: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: Instance of `ISE_REFLECTION_EIFFELFEATURE'
			-- Value: Boolean: Is feature inherited?
		indexing
			description: "Table associating eiffel features with a boolean specifying whether the feature is inherited"
			external_name: "FeaturesTable"
		end
		
	build_features_table is
		indexing
			description: "Build `features_table'."
			external_name: "BuildFeaturesTable"
		local
			conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			an_assembly: SYSTEM_REFLECTION_ASSEMBLY
			a_type: SYSTEM_TYPE
			members: ARRAY [SYSTEM_REFLECTION_MEMBERINFO]
			a_method_info: SYSTEM_REFLECTION_METHODINFO
			a_field_info: SYSTEM_REFLECTION_FIELDINFO
			a_property_info: SYSTEM_REFLECTION_PROPERTYINFO
			a_get_method_info: SYSTEM_REFLECTION_METHODINFO
			a_set_method_info: SYSTEM_REFLECTION_METHODINFO
			i: INTEGER
			a_feature: ISE_REFLECTION_EIFFELFEATURE
			a_get_feature: ISE_REFLECTION_EIFFELFEATURE
			a_set_feature: ISE_REFLECTION_EIFFELFEATURE
			is_inherited: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				create features_table.make
				create conversion_support.make_conversionsupport
				assembly_name := conversion_support.assemblynamefromdescriptor (assembly_descriptor)
				an_assembly := assembly_factory.load (assembly_name)
				a_type := an_assembly.gettype_string (eiffel_class.fullexternalname)
				members := a_type.getmembers
				from
				until
					i = members.count
				loop
					a_method_info ?= members.item (i)
					if a_method_info /= Void then
						a_feature := eiffel_class.routinefrominfo (a_method_info)
						is_inherited := not (a_method_info.basetype.assemblyqualifiedname.tolower.equals_string (a_type.assemblyqualifiedname.tolower))
						if a_feature /= Void and then not features_table.contains (a_feature) then
							features_table.add (a_feature.eiffelname, is_inherited)
						end
					else
						a_field_info ?= members.item (i)
						if a_field_info /= Void then
							a_feature := eiffel_class.attributefrominfo (a_field_info)
							is_inherited := not (a_field_info.basetype.assemblyqualifiedname.tolower.equals_string (a_type.assemblyqualifiedname.tolower))
							if a_feature /= Void and then not features_table.contains (a_feature) then
								features_table.add (a_feature.eiffelname, is_inherited)
							end
						else
							a_property_info ?= members.item (i)
							if a_property_info /= Void then
								a_get_method_info := a_property_info.getgetmethod
								if a_get_method_info /= Void then
									a_get_feature := eiffel_class.routinefrominfo (a_get_method_info)
									is_inherited := not (a_get_method_info.basetype.assemblyqualifiedname.tolower.equals_string (a_type.assemblyqualifiedname.tolower))
									if a_get_feature /= Void and then not features_table.contains (a_get_feature) then
										features_table.add (a_get_feature.eiffelname, is_inherited)
									end
								end
								a_set_method_info := a_property_info.getsetmethod
								if a_set_method_info /= Void then
									a_set_feature := eiffel_class.routinefrominfo (a_set_method_info)
									is_inherited := not (a_set_method_info.basetype.assemblyqualifiedname.tolower.equals_string (a_type.assemblyqualifiedname.tolower))
									if a_set_feature /= Void and then not features_table.contains (a_set_feature) then
										features_table.add (a_set_feature.eiffelname, is_inherited)
									end
								end
							end
						end
					end
					i := i + 1
				end
			end
		ensure
			non_void_features_table: features_table /= Void
		rescue
			retried := True
			retry
		end
	
	assembly_factory: SYSTEM_REFLECTION_ASSEMBLY
		indexing
			description: "Static needed to load assemblies"
			external_name: "AssemblyFactory"
		end

invariant
	non_void_eiffel_class: eiffel_class /= Void
	non_void_assembly_descriptor: assembly_descriptor /= Void
	non_void_features_table: features_table /= Void
	
end -- class PARENTS_HANDLER