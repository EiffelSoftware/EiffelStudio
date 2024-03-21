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

	signing_secret: detachable IMMUTABLE_STRING_8

	base_path: IMMUTABLE_STRING_8

	default_base_path: STRING = "/checkout"

feature -- Status report

	is_testing: BOOLEAN
			-- Is in test mode? Default=True
		do
			Result := not is_live_mode
		end

	is_live_mode: BOOLEAN
			-- Is in live mode? Default=False

	is_remote_invoice_source: BOOLEAN
			-- Temporary hack to always get invoices from stripe api
			-- when displaying the billing

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

	set_signing_secret (v: detachable READABLE_STRING_8)
		do
			if v = Void then
				signing_secret := Void
			else
				create signing_secret.make_from_string (v)
			end
		end

	enable_live_mode
		do
			is_live_mode := True
		end

	disable_live_mode
		do
			is_live_mode := False
		end

	enable_testing
		do
			disable_live_mode
		end

	set_remote_invoice_source
		do
			is_remote_invoice_source := True
		end

invariant

	is_live_mode /= is_testing

end
