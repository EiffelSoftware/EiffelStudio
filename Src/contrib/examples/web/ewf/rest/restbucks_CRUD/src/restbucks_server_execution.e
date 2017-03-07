note
	description : "REST Buck server"
	date        : "$Date$"
	revision    : "$Revision$"

class RESTBUCKS_SERVER_EXECUTION

inherit
	WSF_ROUTED_SKELETON_EXECUTION
		undefine
			requires_proxy
		end

	WSF_NO_PROXY_POLICY

	SHARED_RESTBUCKS_API

create
	make

feature {NONE} -- Initialization

	setup_router
		local
			doc: WSF_ROUTER_SELF_DOCUMENTATION_HANDLER
		do
			setup_order_handler (router)

			create doc.make_hidden (router)
			router.handle ("/api/doc", doc, router.methods_GET)

				-- Those 2 following routes are not for the REST api, but mainly to make simpler to test this example.
			router.handle ("/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_home), router.methods_GET)
			router.handle ("/new_order", create {WSF_URI_AGENT_HANDLER}.make (agent handle_new_order), router.methods_GET)
		end

	setup_order_handler (a_router: WSF_ROUTER)
		local
			order_handler: ORDER_HANDLER
		do
			create order_handler.make ("orderid", a_router)
			router.handle ("/order", order_handler, router.methods_POST)
			router.handle ("/order/{orderid}", order_handler, router.methods_GET + router.methods_DELETE + router.methods_PUT)
		end

feature -- Handler		

	handle_home (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_page: WSF_HTML_PAGE_RESPONSE
			l_html: STRING
		do
			create l_page.make
			create l_html.make_empty
			l_html.append ("<h1>RESTbucks example (a Create-Read-Update-Delete REST API)</h1>%N")
			l_html.append ("<ul>")
			l_html.append ("<li>To test this example: create <a href=%"/new_order%">new ORDER entry</a> , and get its json representation right away.</li>")
			l_html.append ("<li>See the auto-generated <a href=%"/api/doc%">documentation</a>.</li>")
			l_html.append ("</ul>")
			l_page.set_body (l_html)
			l_page.set_title ("RESTbucks example")
			res.send (l_page)
		end

	handle_new_order (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			o: ORDER
			redir: WSF_REDIRECTION_RESPONSE
		do
			create o.make_empty
			o.set_location ("TakeAway")
			o.add_item (create {ORDER_ITEM}.make ("late", "large", "whole", 1))
			o.add_item (create {ORDER_ITEM}.make ("expresso", "small", "skim", 2))
			submit_order (o)
			create redir.make (req.absolute_script_url ("/order/" + o.id))
			redir.set_content ("Order " + o.id + " created.", Void)
			res.send (redir)
		end

note
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
