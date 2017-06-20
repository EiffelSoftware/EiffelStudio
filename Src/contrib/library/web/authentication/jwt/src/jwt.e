note
	description: "JSON Web Token"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JWT

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			create header
			create claimset
		end

feature -- Access

	header: JWT_HEADER

	claimset: JWT_CLAIMSET

feature -- Status report

	is_expired (dt: detachable DATE_TIME): BOOLEAN
			-- Is Current token expired?
			-- See "exp" claim.
		do
			if attached claimset.expiration_time as l_exp_time then
				if dt /= Void then
					Result := dt > l_exp_time
				else
					Result := (create {DATE_TIME}.make_now_utc) > l_exp_time
				end
			end
		end

	is_nbf_validated (dt: detachable DATE_TIME): BOOLEAN
			-- Does `dt` or now verify the "nbf" claim?
			-- See "nbf" claim.
		do
			Result := True
			if attached claimset.not_before_time as l_time then
				if dt /= Void then
					Result := dt >= l_time
				else
					Result := (create {DATE_TIME}.make_now_utc) >= l_time
				end
			end
		end

	is_iss_validated (a_issuer: detachable READABLE_STRING_8): BOOLEAN
		do
			if attached claimset.issuer as iss then
				Result := a_issuer = Void or else a_issuer.same_string (iss)
			end
		end

	is_aud_validated (a_audience: detachable READABLE_STRING_8): BOOLEAN
		do
			if attached claimset.audience as aud then
				Result := a_audience = Void or else a_audience.same_string (aud)
			end
		end

feature -- Conversion

	encoded_string (a_secret: READABLE_STRING_8): STRING
		deferred
		end

feature -- status report

	has_error: BOOLEAN
		do
			Result := attached errors as errs and then not errs.is_empty
		end

	has_unsupported_alg_error: BOOLEAN
		do
			Result := attached errors as errs and then across errs as ic some attached {JWT_UNSUPPORTED_ALG_ERROR} ic.item end
		end

	has_unverified_token_error: BOOLEAN
		do
			Result := attached errors as errs and then across errs as ic some attached {JWT_UNVERIFIED_TOKEN_ERROR} ic.item end
		end

	has_invalid_token_error: BOOLEAN
		do
			Result := attached errors as errs and then across errs as ic some attached {JWT_INVALID_TOKEN_ERROR} ic.item end
		end

	errors: detachable ARRAYED_LIST [JWT_ERROR]

feature {JWT_UTILITIES} -- Error reporting

	reset_error
		do
			errors := Void
		end

	report_error (err: JWT_ERROR)
		local
			l_errors: like errors
		do
			l_errors := errors
			if l_errors = Void then
				create l_errors.make (1)
				errors := l_errors
			end
			l_errors.extend (err)
		end

	report_unsupported_alg_error (alg: READABLE_STRING_8)
		do
			report_error (create {JWT_UNSUPPORTED_ALG_ERROR}.make (alg))
		end

	report_unverified_token_error
		do
			report_error (create {JWT_UNVERIFIED_TOKEN_ERROR})
		end

	report_invalid_token
		do
			report_error (create {JWT_INVALID_TOKEN_ERROR})
		end

	report_claim_validation_error (a_claimname: READABLE_STRING_8)
		do
			report_error (create {JWT_CLAIM_VALIDATION_ERROR}.make (a_claimname))
		end

invariant

end
