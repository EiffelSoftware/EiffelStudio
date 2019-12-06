note
	description: "Summary description for {STRIPE_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_CONFIG

create
	make

feature {NONE} -- Initialization

	make (a_public_key, a_secret_key: READABLE_STRING_8)
		do
			public_key := a_public_key
			secret_key := a_secret_key
			base_path := default_base_path
		end

feature -- Access

	public_key: IMMUTABLE_STRING_8

	secret_key: IMMUTABLE_STRING_8

	is_testing: BOOLEAN

	base_path: IMMUTABLE_STRING_8

	default_base_path: STRING = "/checkout"

	is_valid: BOOLEAN
		local
			p,s: IMMUTABLE_STRING_8
		do
			p := public_key
			s := secret_key
			Result := 	not p.is_whitespace and then not p.starts_with_general ("FILL_") and then
						not s.is_whitespace and then not s.starts_with_general ("FILL_")
		end

feature -- Element change

	set_base_path (p: READABLE_STRING_8)
		do
			base_path := p
		end

	enable_testing
		do
			is_testing := True
		end

end
