indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.WellKnownServiceTypeEntry"

external class
	SYSTEM_RUNTIME_REMOTING_WELLKNOWNSERVICETYPEENTRY

inherit
	SYSTEM_RUNTIME_REMOTING_TYPEENTRY
		redefine
			to_string
		end

create
	make_well_known_service_type_entry,
	make_well_known_service_type_entry_1

feature {NONE} -- Initialization

	frozen make_well_known_service_type_entry (typeName2: STRING; assemblyName2: STRING; objectUri2: STRING; mode2: INTEGER) is
			-- Valid values for `mode2' are:
			-- Singleton = 1
			-- SingleCall = 2
		require
			valid_well_known_object_mode: mode2 = 1 or mode2 = 2
		external
			"IL creator signature (System.String, System.String, System.String, enum System.Runtime.Remoting.WellKnownObjectMode) use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		end

	frozen make_well_known_service_type_entry_1 (type: SYSTEM_TYPE; objectUri2: STRING; mode2: INTEGER) is
			-- Valid values for `mode2' are:
			-- Singleton = 1
			-- SingleCall = 2
		require
			valid_well_known_object_mode: mode2 = 1 or mode2 = 2
		external
			"IL creator signature (System.Type, System.String, enum System.Runtime.Remoting.WellKnownObjectMode) use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		end

feature -- Access

	frozen get_object_uri: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_ObjectUri"
		end

	frozen get_object_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_ObjectType"
		end

	frozen get_context_attributes: ARRAY [SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE] is
		external
			"IL signature (): System.Runtime.Remoting.Contexts.IContextAttribute[] use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_ContextAttributes"
		end

	frozen get_mode: INTEGER is
		external
			"IL signature (): enum System.Runtime.Remoting.WellKnownObjectMode use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_Mode"
		ensure
			valid_well_known_object_mode: Result = 1 or Result = 2
		end

feature -- Element Change

	frozen set_context_attributes (value: ARRAY [SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE]) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.IContextAttribute[]): System.Void use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"set_ContextAttributes"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"ToString"
		end

end -- class SYSTEM_RUNTIME_REMOTING_WELLKNOWNSERVICETYPEENTRY
