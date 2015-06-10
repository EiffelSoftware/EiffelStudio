note
	description : "REST Buck server"
	date        : "$Date$"
	revision    : "$Revision$"

class RESTBUCKS_SERVER_EXECUTION

inherit

	WSF_ROUTED_SKELETON_EXECUTION
		undefine
			requires_proxy
		redefine
			initialize
		end

	WSF_ROUTED_URI_TEMPLATE_HELPER

	WSF_HANDLER_HELPER

	WSF_NO_PROXY_POLICY

create
	make

feature {NONE} -- Initialization

	initialize
		do
			Precursor
			initialize_router
		end

	setup_router
		local
			order_handler: ORDER_HANDLER
			doc: WSF_ROUTER_SELF_DOCUMENTATION_HANDLER
		do
			create order_handler.make_with_router (router)
			router.handle ("/order", order_handler, router.methods_POST)
			router.handle ("/order/{orderid}", order_handler, router.methods_GET + router.methods_DELETE + router.methods_PUT)
			create doc.make_hidden (router)
			router.handle ("/api/doc", doc, router.methods_GET)
		end


note
	copyright: "2011-2015, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
