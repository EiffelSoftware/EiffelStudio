indexing
	description: "Objects that provide attributes for all examples."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMON_TEST
feature -- Access

	widget: EV_WIDGET
		-- Widget into which example is built.
		-- Simply insert into your Vision2 interface, for
		-- testing purposes.

invariant
	widget_not_void: Widget /= Void

end -- class COMMON_TEST
