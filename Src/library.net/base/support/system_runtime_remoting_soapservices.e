indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.SoapServices"

external class
	SYSTEM_RUNTIME_REMOTING_SOAPSERVICES

create {NONE}

feature -- Access

	frozen get_xml_ns_for_clr_type: STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"get_XmlNsForClrType"
		end

	frozen get_xml_ns_for_clr_type_with_ns: STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"get_XmlNsForClrTypeWithNs"
		end

	frozen get_xml_ns_for_clr_type_with_assembly: STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"get_XmlNsForClrTypeWithAssembly"
		end

	frozen get_xml_ns_for_clr_type_with_ns_and_assembly: STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"get_XmlNsForClrTypeWithNsAndAssembly"
		end

feature -- Basic Operations

	frozen decode_xml_namespace_for_clr_type_namespace (inNamespace: STRING; typeNamespace: STRING; assemblyName: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"DecodeXmlNamespaceForClrTypeNamespace"
		end

	frozen register_soap_action_for_method_base (mb: SYSTEM_REFLECTION_METHODBASE) is
		external
			"IL static signature (System.Reflection.MethodBase): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterSoapActionForMethodBase"
		end

	frozen register_interop_xml_type (xmlType: STRING; xmlTypeNamespace: STRING; type: SYSTEM_TYPE) is
		external
			"IL static signature (System.String, System.String, System.Type): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterInteropXmlType"
		end

	frozen is_clr_type_namespace (namespaceString: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"IsClrTypeNamespace"
		end

	frozen get_soap_action_from_method_base (mb: SYSTEM_REFLECTION_METHODBASE): STRING is
		external
			"IL static signature (System.Reflection.MethodBase): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"GetSoapActionFromMethodBase"
		end

	frozen register_soap_action_for_method_base_method_base_string (mb: SYSTEM_REFLECTION_METHODBASE; soapAction: STRING) is
		external
			"IL static signature (System.Reflection.MethodBase, System.String): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterSoapActionForMethodBase"
		end

	frozen get_xml_namespace_for_method_call (mb: SYSTEM_REFLECTION_METHODBASE): STRING is
		external
			"IL static signature (System.Reflection.MethodBase): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlNamespaceForMethodCall"
		end

	frozen get_interop_field_type_and_name_from_xml_attribute (containingType: SYSTEM_TYPE; xmlAttribute: STRING; xmlNamespace: STRING; type: SYSTEM_TYPE; name: STRING) is
		external
			"IL static signature (System.Type, System.String, System.String, System.Type&, System.String&): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropFieldTypeAndNameFromXmlAttribute"
		end

	frozen get_interop_type_from_xml_Type (xmlType: STRING; xmlTypeNamespace: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.String): System.Type use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropTypeFromXmlType"
		end

	frozen code_xml_namespace_for_clr_type_namespace (typeNamespace: STRING; assemblyName: STRING): STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"CodeXmlNamespaceForClrTypeNamespace"
		end

	frozen get_xml_namespace_for_method_response (mb: SYSTEM_REFLECTION_METHODBASE): STRING is
		external
			"IL static signature (System.Reflection.MethodBase): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlNamespaceForMethodResponse"
		end

	frozen pre_load_assembly_boolean (assembly: SYSTEM_REFLECTION_ASSEMBLY; bServer: BOOLEAN) is
		external
			"IL static signature (System.Reflection.Assembly, System.Boolean): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"PreLoad"
		end

	frozen get_interop_type_from_xml_element (xmlElement: STRING; xmlNamespace: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.String): System.Type use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropTypeFromXmlElement"
		end

	frozen get_xml_type_for_interop_type (type: SYSTEM_TYPE; xmlType: STRING; xmlTypeNamespace: STRING): BOOLEAN is
		external
			"IL static signature (System.Type, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlTypeForInteropType"
		end

	frozen get_type_and_method_name_from_soap_action (soapAction: STRING; typeName: STRING; methodName: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"GetTypeAndMethodNameFromSoapAction"
		end

	frozen pre_load_type (type: SYSTEM_TYPE) is
		external
			"IL static signature (System.Type): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"PreLoad"
		end

	frozen register_interop_xml_element (xmlElement: STRING; xmlNamespace: STRING; type: SYSTEM_TYPE) is
		external
			"IL static signature (System.String, System.String, System.Type): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterInteropXmlElement"
		end

	frozen is_soap_action_valid_for_method_base (soapAction: STRING; mb: SYSTEM_REFLECTION_METHODBASE): BOOLEAN is
		external
			"IL static signature (System.String, System.Reflection.MethodBase): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"IsSoapActionValidForMethodBase"
		end

	frozen pre_load (assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL static signature (System.Reflection.Assembly): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"PreLoad"
		end

	frozen get_xml_element_for_interop_type (type: SYSTEM_TYPE; xmlElement: STRING; xmlNamespace: STRING): BOOLEAN is
		external
			"IL static signature (System.Type, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlElementForInteropType"
		end

	frozen get_interop_field_type_and_name_from_xml_element (containingType: SYSTEM_TYPE; xmlElement: STRING; xmlNamespace: STRING; type: SYSTEM_TYPE; name: STRING) is
		external
			"IL static signature (System.Type, System.String, System.String, System.Type&, System.String&): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropFieldTypeAndNameFromXmlElement"
		end

end -- class SYSTEM_RUNTIME_REMOTING_SOAPSERVICES
