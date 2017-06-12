note
	description: "Summary description for {CMS_OAUTH_CONSUMER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_CONSUMER

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_id

feature {NONE} -- Initialization

	make_with_id (a_id: like id)
		do
			id := a_id
			default_create
		end

	default_create
		do
			set_endpoint ("")
			set_authorize_url ("")
			set_extractor ("")
			set_callback_name ("")
			set_protected_resource_url ("")
			set_scope ("")
			set_api_key ("")
			set_api_secret ("")
			set_name ("")
		end

feature -- Status report

	has_id: BOOLEAN
		do
			Result := id > 0
		end

feature -- Access

	id: INTEGER_64
			-- unique identifier.

	endpoint: READABLE_STRING_8
			-- 	Url that receives the access token request.

	authorize_url: READABLE_STRING_8
			--

	extractor: READABLE_STRING_8
			-- text, json		


	callback_name: READABLE_STRING_8
			-- consumer callback name

	protected_resource_url: READABLE_STRING_8
			-- consumer resource url

	scope: READABLE_STRING_8
			-- consumer scope

	api_key: READABLE_STRING_8
			-- consumer public key

	api_secret: READABLE_STRING_8
			-- consumer secret.

	name: READABLE_STRING_32
			-- consumer name.

feature -- Element change

	set_extractor (a_extractor: like extractor)
			-- Assign `extractor' with `a_extractor'.
		do
			extractor := a_extractor
		ensure
			extractor_assigned: extractor = a_extractor
		end

	set_authorize_url (a_authorize_url: like authorize_url)
			-- Assign `authorize_url' with `a_authorize_url'.
		do
			authorize_url := a_authorize_url
		ensure
			authorize_url_assigned: authorize_url = a_authorize_url
		end

	set_endpoint (a_endpoint: like endpoint)
			-- Assign `endpoint' with `a_endpoint'.
		do
			endpoint := a_endpoint
		ensure
			endpoint_assigned: endpoint = a_endpoint
		end

	set_callback_name (a_callback_name: like callback_name)
			-- Assign `callback_name' with `a_callback_name'.
		do
			callback_name := a_callback_name
		ensure
			callback_name_assigned: callback_name = a_callback_name
		end

	set_protected_resource_url (a_protected_resource_url: like protected_resource_url)
			-- Assign `protected_resource_url' with `a_protected_resource_url'.
		do
			protected_resource_url := a_protected_resource_url
		ensure
			protected_resource_url_assigned: protected_resource_url = a_protected_resource_url
		end

	set_scope (a_scope: like scope)
			-- Assign `scope' with `a_scope'.
		do
			scope := a_scope
		ensure
			scope_assigned: scope = a_scope
		end

	set_api_key (an_api_key: like api_key)
			-- Assign `api_key' with `an_api_key'.
		do
			api_key := an_api_key
		ensure
			api_key_assigned: api_key = an_api_key
		end

	set_api_secret (an_api_secret: like api_secret)
			-- Assign `api_secret' with `an_api_secret'.
		do
			api_secret := an_api_secret
		ensure
			api_secret_assigned: api_secret = an_api_secret
		end

	set_name (a_name: like name)
			-- Assign `name' with `a_name'.
		do
			name := a_name
		ensure
			name_assigned: name = a_name
		end

	set_id (an_id: like id)
			-- Assign `id' with `an_id'.
		do
			id := an_id
		ensure
			id_assigned: id = an_id
		end

end
