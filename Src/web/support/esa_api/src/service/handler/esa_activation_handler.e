note
	description: "Activation handler."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ACTIVATION_HANDLER

inherit

	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end

	WSF_FILTER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
			execute_next (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_activation_view: ESA_ACTIVATION_VIEW
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
					-- Get request to /activation?email=&token=
		    	if attached {WSF_STRING} req.query_parameter ("email") and then
				   attached {WSF_STRING} req.query_parameter ("token") then
					l_activation_view := build_view (req)
					if l_activation_view.is_valid_form and then
						attached l_activation_view.email as l_email and then
						attached l_activation_view.token as l_token and then
		    			api_service.activation_valid (l_email, l_token) then
		    					-- Activation was ok
							l_rhf.new_representation_handler (esa_config,l_type,media_type_variants (req)).activation_confirmation_page (req, res)
		    		else
		    				-- Activation failed
		    			l_activation_view.set_error_message ("Activation failed, check activation code and e-mail.")
						l_rhf.new_representation_handler (esa_config,l_type,media_type_variants (req)).activation_page (req, res, l_activation_view)
					end
				else
						-- Get request to /activation
					l_rhf.new_representation_handler (esa_config,l_type,media_type_variants (req)).activation_page (req, res, Void)
				end
			else
				l_rhf.new_representation_handler (esa_config,"",media_type_variants (req)).activation_page (req, res, Void)
			end
		end


	build_view (req: WSF_REQUEST) : ESA_ACTIVATION_VIEW
			-- Create a new activation view object based on request parameters, if any
		do
			create Result
			if attached {WSF_STRING} req.query_parameter ("email") as l_email and then
			   attached {WSF_STRING} req.query_parameter ("token") as l_token then
			   	Result.set_token (l_token.value)
			   	Result.set_email (l_email.value)
			end
		end
end
