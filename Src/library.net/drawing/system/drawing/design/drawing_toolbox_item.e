indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.ToolboxItem"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_TOOLBOX_ITEM

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Design.ToolboxItem"
		end

	frozen make_1 (tool_type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Drawing.Design.ToolboxItem"
		end

feature -- Access

	frozen get_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Design.ToolboxItem"
		alias
			"get_TypeName"
		end

	frozen get_filter: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Drawing.Design.ToolboxItem"
		alias
			"get_Filter"
		end

	frozen get_assembly_name: ASSEMBLY_NAME is
		external
			"IL signature (): System.Reflection.AssemblyName use System.Drawing.Design.ToolboxItem"
		alias
			"get_AssemblyName"
		end

	frozen get_bitmap: DRAWING_BITMAP is
		external
			"IL signature (): System.Drawing.Bitmap use System.Drawing.Design.ToolboxItem"
		alias
			"get_Bitmap"
		end

	frozen get_display_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Design.ToolboxItem"
		alias
			"get_DisplayName"
		end

feature -- Element Change

	frozen set_filter (value: ICOLLECTION) is
		external
			"IL signature (System.Collections.ICollection): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"set_Filter"
		end

	frozen remove_components_created (value: DRAWING_TOOLBOX_COMPONENTS_CREATED_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatedEventHandler): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"remove_ComponentsCreated"
		end

	frozen add_components_creating (value: DRAWING_TOOLBOX_COMPONENTS_CREATING_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatingEventHandler): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"add_ComponentsCreating"
		end

	frozen set_display_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"set_DisplayName"
		end

	frozen remove_components_creating (value: DRAWING_TOOLBOX_COMPONENTS_CREATING_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatingEventHandler): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"remove_ComponentsCreating"
		end

	frozen set_bitmap (value: DRAWING_BITMAP) is
		external
			"IL signature (System.Drawing.Bitmap): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"set_Bitmap"
		end

	frozen set_assembly_name (value: ASSEMBLY_NAME) is
		external
			"IL signature (System.Reflection.AssemblyName): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"set_AssemblyName"
		end

	frozen set_type_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"set_TypeName"
		end

	frozen add_components_created (value: DRAWING_TOOLBOX_COMPONENTS_CREATED_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatedEventHandler): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"add_ComponentsCreated"
		end

feature -- Basic Operations

	frozen create_components_idesigner_host (host: SYSTEM_DLL_IDESIGNER_HOST): NATIVE_ARRAY [SYSTEM_DLL_ICOMPONENT] is
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

	initialize (type: TYPE) is
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

	frozen create_components: NATIVE_ARRAY [SYSTEM_DLL_ICOMPONENT] is
		external
			"IL signature (): System.ComponentModel.IComponent[] use System.Drawing.Design.ToolboxItem"
		alias
			"CreateComponents"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Design.ToolboxItem"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Design.ToolboxItem"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	on_components_creating (args: DRAWING_TOOLBOX_COMPONENTS_CREATING_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatingEventArgs): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"OnComponentsCreating"
		end

	serialize (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"Serialize"
		end

	get_type_idesigner_host (host: SYSTEM_DLL_IDESIGNER_HOST; assembly_name: ASSEMBLY_NAME; type_name: SYSTEM_STRING; reference: BOOLEAN): TYPE is
		external
			"IL signature (System.ComponentModel.Design.IDesignerHost, System.Reflection.AssemblyName, System.String, System.Boolean): System.Type use System.Drawing.Design.ToolboxItem"
		alias
			"GetType"
		end

	on_components_created (args: DRAWING_TOOLBOX_COMPONENTS_CREATED_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Design.ToolboxComponentsCreatedEventArgs): System.Void use System.Drawing.Design.ToolboxItem"
		alias
			"OnComponentsCreated"
		end

	deserialize (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
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

	create_components_core (host: SYSTEM_DLL_IDESIGNER_HOST): NATIVE_ARRAY [SYSTEM_DLL_ICOMPONENT] is
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

end -- class DRAWING_TOOLBOX_ITEM
