indexing
	description: "External controlers."
	date: "$Date$"
	revision: "$Revision$"
	
class
	EXTERNAL_CONTROLERS
	
feature -- Access

	external_ui_handler: IDOC_HOST_UIHANDLER_DISPATCH_IMPL_PROXY
	
	external_dispatch: ECOM_INTERFACE

end -- class EXTERNAL_CONTROLERS
