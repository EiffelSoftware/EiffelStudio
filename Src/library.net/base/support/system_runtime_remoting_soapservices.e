indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.SoapServices"

external class
	SYSTEM_RUNTIME_REMOTING_SOAPSERVICES

create {NONE}

feature -- Access

	frozen get_xml_ns_for_clr_type_with_ns: STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"get_XmlNsForClrTypeWithNs"
		end

	frozen get_xml_ns_for_clr_type: STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"get_XmlNsForClrType"
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

	frozen get_type_and_method_name_from_soap_action (soap_action: STRING; type_name: STRING; method_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"GetTypeAndMethodNameFromSoapAction"
		end

	frozen get_interop_field_type_and_name_from_xml_attribute (containing_type: SYSTEM_TYPE; xml_attribute: STRING; xml_namespace: STRING; type: SYSTEM_TYPE; name: STRING) is
		external
			"IL static signature (System.Type, System.String, System.String, System.Type&, System.String&): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropFieldTypeAndNameFromXmlAttribute"
		end

	frozen get_xml_namespace_for_method_call (mb: SYSTEM_REFLECTION_METHODBASE): STRING is
		external
			"IL static signature (System.Reflection.MethodBase): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlNamespaceForMethodCall"
		end

	frozen get_interop_type_from_xml_type (xml_type: STRING; xml_type_namespace: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.String): System.Type use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropTypeFromXmlType"
		end

	frozen register_interop_xml_type (xml_type: STRING; xml_type_namespace: STRING; type: SYSTEM_TYPE) is
		external
			"IL static signature (System.String, System.String, System.Type): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterInteropXmlType"
		end

	frozen get_xml_type_for_interop_type (type: SYSTEM_TYPE; xml_type: STRING; xml_type_namespace: STRING): BOOLEAN is
		external
			"IL static signature (System.Type, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlTypeForInteropType"
		end

	frozen get_xml_element_for_interop_type (type: SYSTEM_TYPE; xml_element: STRING; xml_namespace: STRING): BOOLEAN is
		external
			"IL static signature (System.Type, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlElementForInteropType"
		end

	frozen get_interop_field_type_and_name_from_xml_element (containing_type: SYSTEM_TYPE; xml_element: STRING; xml_namespace: STRING; type: SYSTEM_TYPE; name: STRING) is
		external
			"IL static signature (System.Type, System.String, System.String, System.Type&, System.String&): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropFieldTypeAndNameFromXmlElement"
		end

	frozen get_interop_type_from_xml_element (xml_element: STRING; xml_namespace: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.String): System.Type use System.Runtime.Remoting.SoapServices"
		alias
			"GetInteropTypeFromXmlElement"
		end

	frozen register_interop_xml_element (xml_element: STRING; xml_namespace: STRING; type: SYSTEM_TYPE) is
		external
			"IL static signature (System.String, System.String, System.Type): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterInteropXmlElement"
		end

	frozen pre_load_type (type: SYSTEM_TYPE) is
		external
			"IL static signature (System.Type): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"PreLoad"
		end

	frozen register_soap_action_for_method_base (mb: SYSTEM_REFLECTION_METHODBASE) is
		external
			"IL static signature (System.Reflection.MethodBase): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterSoapActionForMethodBase"
		end

	frozen get_xml_namespace_for_method_response (mb: SYSTEM_REFLECTION_METHODBASE): STRING is
		external
			"IL static signature (System.Reflection.MethodBase): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"GetXmlNamespaceForMethodResponse"
		end

	frozen is_clr_type_namespace (namespace_string: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"IsClrTypeNamespace"
		end

	frozen register_soap_action_for_method_base_method_base_string (mb: SYSTEM_REFLECTION_METHODBASE; soap_action: STRING) is
		external
			"IL static signature (System.Reflection.MethodBase, System.String): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"RegisterSoapActionForMethodBase"
		end

	frozen pre_load (assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL static signature (System.Reflection.Assembly): System.Void use System.Runtime.Remoting.SoapServices"
		alias
			"PreLoad"
		end

	frozen get_soap_action_from_method_base (mb: SYSTEM_REFLECTION_METHODBASE): STRING is
		external
			"IL static signature (System.Reflection.MethodBase): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"GetSoapActionFromMethodBase"
		end

	frozen decode_xml_namespace_for_clr_type_namespace (in_namespace: STRING; type_namespace: STRING; assembly_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String&, System.String&): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"DecodeXmlNamespaceForClrTypeNamespace"
		end

	frozen is_soap_action_valid_for_method_base (soap_action: STRING; mb: SYSTEM_REFLECTION_METHODBASE): BOOLEAN is
		external
			"IL static signature (System.String, System.Reflection.MethodBase): System.Boolean use System.Runtime.Remoting.SoapServices"
		alias
			"IsSoapActionValidForMethodBase"
		end

	frozen code_xml_namespace_for_clr_type_namespace (type_namespace: STRING; assembly_name: STRING): STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.Runtime.Remoting.SoapServices"
		alias
			"CodeXmlNamespaceForClrTypeNamespace"
		end

end -- class SYSTEM_RUNTIME_REMOTING_SOAPSERVICES
