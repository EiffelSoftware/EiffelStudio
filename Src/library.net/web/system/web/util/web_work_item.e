indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Util.WorkItem"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_WORK_ITEM

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Util.WorkItem"
		end

feature -- Basic Operations

	frozen post (callback: WEB_WORK_ITEM_CALLBACK) is
		external
			"IL static signature (System.Web.Util.WorkItemCallback): System.Void use System.Web.Util.WorkItem"
		alias
			"Post"
		end

end -- class WEB_WORK_ITEM
