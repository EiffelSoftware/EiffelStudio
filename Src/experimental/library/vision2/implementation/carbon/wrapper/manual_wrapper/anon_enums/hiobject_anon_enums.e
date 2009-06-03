note
	description: "wrapper for anynymous enums from file hiobject.h "

class
	HIOBJECT_ANON_ENUMS

feature -- Carbon constants

	frozen hiObjectClassExistsErr: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"hiObjectClassExistsErr"
	end

	frozen hiObjectClassHasInstancesErr: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"hiObjectClassHasInstancesErr"
	end

	frozen hiObjectClassHasSubclassesErr: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"hiObjectClassHasSubclassesErr"
	end

	frozen hiObjectClassIsAbstractErr: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"hiObjectClassIsAbstractErr"
	end

	frozen kEventClassHIObject: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventClassHIObject"
	end

	frozen kEventParamHIObjectInstance: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventParamHIObjectInstance"
	end

	frozen kEventParamHIArchive: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventParamHIArchive"
	end

	frozen typeHIObjectRef: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"typeHIObjectRef"
	end

	frozen kEventHIObjectConstruct: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectConstruct"
	end

	frozen kEventHIObjectInitialize: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectInitialize"
	end

	frozen kEventHIObjectDestruct: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectDestruct"
	end

	frozen kEventHIObjectIsEqual: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectIsEqual"
	end

	frozen kEventHIObjectPrintDebugInfo: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectPrintDebugInfo"
	end

	frozen kEventHIObjectEncode: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectEncode"
	end

end
