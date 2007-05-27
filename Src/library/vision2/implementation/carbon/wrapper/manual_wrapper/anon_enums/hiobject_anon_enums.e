indexing
	description: "wrapper for anynymous enums from file hiobject.h "

class
	HIOBJECT_ANON_ENUMS

feature -- Carbon constants

	frozen hiObjectClassExistsErr: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"hiObjectClassExistsErr"
	end

	frozen hiObjectClassHasInstancesErr: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"hiObjectClassHasInstancesErr"
	end

	frozen hiObjectClassHasSubclassesErr: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"hiObjectClassHasSubclassesErr"
	end

	frozen hiObjectClassIsAbstractErr: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"hiObjectClassIsAbstractErr"
	end

	frozen kEventClassHIObject: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventClassHIObject"
	end

	frozen kEventParamHIObjectInstance: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventParamHIObjectInstance"
	end

	frozen kEventParamHIArchive: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventParamHIArchive"
	end

	frozen typeHIObjectRef: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"typeHIObjectRef"
	end

	frozen kEventHIObjectConstruct: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectConstruct"
	end

	frozen kEventHIObjectInitialize: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectInitialize"
	end

	frozen kEventHIObjectDestruct: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectDestruct"
	end

	frozen kEventHIObjectIsEqual: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectIsEqual"
	end

	frozen kEventHIObjectPrintDebugInfo: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectPrintDebugInfo"
	end

	frozen kEventHIObjectEncode: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventHIObjectEncode"
	end

end
