indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.ToolboxItem"

external class
	SYSTEM_DRAWING_DESIGN_TOOLBOXITEM

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			finalize,
			get_hash_code,
			equals_object,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data,
			equals as equals_object
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Design.ToolboxItem"
		end

	frozen make_1 (tool_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Drawing.Design.ToolboxItem"
		end

feature -- Access

	frozen get_type_name: STRING is
		external
			"IL signature (): System.String use System.Drawing.Design.ToolboxItem"
		alias
			"get_TypeName"
		end

	frozen get_filter: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Drawing.Design.ToolboxItem"
		alias
			"get_Filter"
		end

	frozen get_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL signature (): System.Reflection.AssemblyName use System.Drawing.Design.ToolboxItem"
		alias
			"get_AssemblyName"
		end

	frozen get_bitmap: SYSTEM_DRAWING_BITMAP is
		external
			"IL signature (): System.Drawing.Bitmap use System.Drawing.Design.ToolboxItem"
		alias
			"get_Bitmap"
		end

	frozen get_display_name: STRING is
		external
			"IL signature (): System.String use System.Drawing.Design.ToolboxItem"
		alias
			"get_DisplayName"
		end

feature -- Element Change

	frozen set_filter (value: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL signature (System.Collections.ICollection): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"set_Filter"
		end

	frozen remove_components_created (value: SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATEDEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatedEventHandler): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"remove_ComponentsCreated"
		end

	frozen add_components_creating (value: SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATINGEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatingEventHandler): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"add_ComponentsCreating"
		end

	frozen set_display_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"set_DisplayName"
		end

	frozen remove_components_creating (value: SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATINGEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatingEventHandler): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"remove_ComponentsCreating"
		end

	frozen set_bitmap (value: SYSTEM_DRAWING_BITMAP) is
		external
			"IL signature (System.Drawing.Bitmap): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"set_Bitmap"
		end

	frozen set_assembly_name (value: SYSTEM_REFLECTION_ASSEMBLYNAME) is
		external
			"IL signature (System.Reflection.AssemblyName): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"set_AssemblyName"
		end

	frozen set_type_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"set_TypeName"
		end

	frozen add_components_created (value: SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATEDEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatedEventHandler): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"add_ComponentsCreated"
		end

feature -- Basic Operations

	frozen create_components_idesigner_host (host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST): ARRAY [SYSTEM_COMPONENTMODEL_ICOMPONENT] is
		external
			"IL signature (System.ComponentModel.Design.IDesignerHost): System.ComponentModel.IComponent[] use System.Drawing.Design.ToolboxItem"
		alias
			"CreateComponents"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Design.ToolboxItem"
		alias
			"GetHashCode"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Design.ToolboxItem"
		alias
			"Equals"
		end

	initialize (type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"Initialize"
		end

	frozen lock is
		external
			"IL signature (): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"Lock"
		end

	frozen create_components: ARRAY [SYSTEM_COMPONENTMODEL_ICOMPONENT] is
		external
			"IL signature (): System.ComponentModel.IComponent[] use System.Drawing.Design.ToolboxItem"
		alias
			"CreateComponents"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Design.ToolboxItem"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	on_components_creating (args: SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATINGEVENTARGS) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatingEventArgs): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"OnComponentsCreating"
		end

	serialize (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"Serialize"
		end

	get_type_idesigner_host (host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST; assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME; type_name: STRING; reference: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.ComponentModel.Design.IDesignerHost, System.Reflection.AssemblyName, System.String, System.Boolean): System.Type use System.Drawing.Design.ToolboxItem"
		alias
			"GetType"
		end

	on_components_created (args: SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATEDEVENTARGS) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatedEventArgs): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"OnComponentsCreated"
		end

	deserialize (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"Deserialize"
		end

	frozen check_unlocked is
		external
			"IL signature (): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"CheckUnlocked"
		end

	create_components_core (host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST): ARRAY [SYSTEM_COMPONENTMODEL_ICOMPONENT] is
		external
			"IL signature (System.ComponentModel.Design.IDesignerHost): System.ComponentModel.IComponent[] use System.Drawing.Design.ToolboxItem"
		alias
			"CreateComponentsCore"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"Finalize"
		end

	frozen get_locked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Design.ToolboxItem"
		alias
			"get_Locked"
		end

end -- class SYSTEM_DRAWING_DESIGN_TOOLBOXITEM
