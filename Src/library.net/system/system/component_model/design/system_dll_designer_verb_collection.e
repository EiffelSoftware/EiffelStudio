indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.DesignerVerbCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_DESIGNER_VERB_COLLECTION

inherit
	COLLECTION_BASE
		redefine
			on_validate,
			on_remove,
			on_clear,
			on_insert,
			on_set
		end
	ILIST
		rename
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			remove as system_collections_ilist_remove,
			add as system_collections_ilist_add,
			contains as system_collections_ilist_contains,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

create
	make_system_dll_designer_verb_collection_1,
	make_system_dll_designer_verb_collection

feature {NONE} -- Initialization

	frozen make_system_dll_designer_verb_collection_1 (value: NATIVE_ARRAY [SYSTEM_DLL_DESIGNER_VERB]) is
		external
			"IL creator signature (System.ComponentModel.Design.DesignerVerb[]) use System.ComponentModel.Design.DesignerVerbCollection"
		end

	frozen make_system_dll_designer_verb_collection is
		external
			"IL creator use System.ComponentModel.Design.DesignerVerbCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DLL_DESIGNER_VERB is
		external
			"IL signature (System.Int32): System.ComponentModel.Design.DesignerVerb use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_DLL_DESIGNER_VERB) is
		external
			"IL signature (System.Int32, System.ComponentModel.Design.DesignerVerb): System.Void use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: SYSTEM_DLL_DESIGNER_VERB) is
		external
			"IL signature (System.Int32, System.ComponentModel.Design.DesignerVerb): System.Void use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_DLL_DESIGNER_VERB]; index: INTEGER) is
		external
			"IL signature (System.ComponentModel.Design.DesignerVerb[], System.Int32): System.Void use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_DLL_DESIGNER_VERB): INTEGER is
		external
			"IL signature (System.ComponentModel.Design.DesignerVerb): System.Int32 use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_DLL_DESIGNER_VERB) is
		external
			"IL signature (System.ComponentModel.Design.DesignerVerb): System.Void use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_DLL_DESIGNER_VERB): BOOLEAN is
		external
			"IL signature (System.ComponentModel.Design.DesignerVerb): System.Boolean use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_DLL_DESIGNER_VERB_COLLECTION) is
		external
			"IL signature (System.ComponentModel.Design.DesignerVerbCollection): System.Void use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_DLL_DESIGNER_VERB): INTEGER is
		external
			"IL signature (System.ComponentModel.Design.DesignerVerb): System.Int32 use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"Add"
		end

	frozen add_range_array_designer_verb (value: NATIVE_ARRAY [SYSTEM_DLL_DESIGNER_VERB]) is
		external
			"IL signature (System.ComponentModel.Design.DesignerVerb[]): System.Void use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"AddRange"
		end

feature {NONE} -- Implementation

	on_remove (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"OnRemove"
		end

	on_clear is
		external
			"IL signature (): System.Void use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"OnClear"
		end

	on_validate (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"OnValidate"
		end

	on_set (index: INTEGER; old_value: SYSTEM_OBJECT; new_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"OnSet"
		end

	on_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.ComponentModel.Design.DesignerVerbCollection"
		alias
			"OnInsert"
		end

end -- class SYSTEM_DLL_DESIGNER_VERB_COLLECTION
