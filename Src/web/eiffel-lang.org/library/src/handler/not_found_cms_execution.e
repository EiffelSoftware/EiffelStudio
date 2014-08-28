note
	description: "[
				This class implements the web service

				It inherits from WSF_DEFAULT_SERVICE to get default EWF connector ready
				And from WSF_URI_TEMPLATE_ROUTED_SERVICE to use the router service

				`initialize' can be redefine to provide custom options if needed.
			]"

class
	NOT_FOUND_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
		do
			status_code := {HTTP_STATUS_CODE}.not_found
			create b.make_empty
			set_title ("Page Not Found")
			b.append ("<em>The requested page could not be found.</em>%N")
			set_main_content (b)
		end

end
