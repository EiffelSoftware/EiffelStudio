note
	description: "Object representing a JWT claim set"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=JWT claims", "src=https://tools.ietf.org/html/rfc7519#section-4", "protocol=uri"
class
	JWT_CLAIMSET

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

convert
	string: {READABLE_STRING_8, STRING_8}

feature {NONE} -- Initialization

	default_create
		do
			create json.make_empty
		end

feature -- Element change

	import_json (j: READABLE_STRING_8)
		do
		end

feature -- Access

	claim alias "[]" (a_name: READABLE_STRING_GENERAL): detachable ANY
		do
		end

	string_32_claim (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
		end

	string_8_claim (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
		do
		end

	issuer: detachable READABLE_STRING_8 assign set_issuer
		do
		end

	subjet: detachable READABLE_STRING_32 assign set_subject
		do
		end

	audience: detachable READABLE_STRING_8 assign set_audience
		do
		end

	expiration_time: detachable DATE_TIME assign set_expiration_time
		do
		end

	not_before_time: detachable DATE_TIME assign set_not_before_time
		do
		end

	issued_at: detachable DATE_TIME assign set_issued_at
		do
		end

	jwd_id: detachable READABLE_STRING_8 assign set_jwt_id
		do
		end

feature -- Conversion

	json: STRING

	string: STRING
		do
			Result := ""
		end

feature -- Element change

	set_claim (a_name: READABLE_STRING_GENERAL; a_val: detachable ANY)
		do
		end

	set_issuer (iss: detachable READABLE_STRING_8)
			-- The "iss" (issuer) claim identifies the principal that issued the
			-- JWT.  The processing of this claim is generally application specific.
			-- The "iss" value is a case-sensitive string containing a StringOrURI
			-- value.  Use of this claim is OPTIONAL.	
		do
		end

	set_subject (sub: detachable READABLE_STRING_32)
		   -- The "sub" (subject) claim identifies the principal that is the
		   -- subject of the JWT.  The claims in a JWT are normally statements
		   -- about the subject.  The subject value MUST either be scoped to be
		   -- locally unique in the context of the issuer or be globally unique.
		   -- The processing of this claim is generally application specific.  The
		   -- "sub" value is a case-sensitive string containing a StringOrURI
		   -- value.  Use of this claim is OPTIONAL.	
		do
		end

	set_audience (aud: detachable READABLE_STRING_8)
			--   The "aud" (audience) claim identifies the recipients that the JWT is
			--   intended for.  Each principal intended to process the JWT MUST
			--   identify itself with a value in the audience claim.  If the principal
			--   processing the claim does not identify itself with a value in the
			--   "aud" claim when this claim is present, then the JWT MUST be
			--   rejected.  In the general case, the "aud" value is an array of case-
			--   sensitive strings, each containing a StringOrURI value.  In the
			--   special case when the JWT has one audience, the "aud" value MAY be a
			--   single case-sensitive string containing a StringOrURI value.  The
			--   interpretation of audience values is generally application specific.
			--   Use of this claim is OPTIONAL.
   		do
		end

	set_expiration_time (exp: detachable DATE_TIME)
			--   The "exp" (expiration time) claim identifies the expiration time on
			--   or after which the JWT MUST NOT be accepted for processing.  The
			--   processing of the "exp" claim requires that the current date/time
			--   MUST be before the expiration date/time listed in the "exp" claim.
			--   Implementers MAY provide for some small leeway, usually no more than
			--   a few minutes, to account for clock skew.  Its value MUST be a number
			--   containing a NumericDate value.  Use of this claim is OPTIONAL.
    	do
		end

	set_not_before_time (nbf: detachable DATE_TIME)
			--   The "nbf" (not before) claim identifies the time before which the JWT
			--   MUST NOT be accepted for processing.  The processing of the "nbf"
			--   claim requires that the current date/time MUST be after or equal to
			--   the not-before date/time listed in the "nbf" claim.  Implementers MAY
			--   provide for some small leeway, usually no more than a few minutes, to
			--   account for clock skew.  Its value MUST be a number containing a
			--   NumericDate value.  Use of this claim is OPTIONAL.
		do
		end

	set_issued_at (iat: detachable DATE_TIME)
			--   The "iat" (issued at) claim identifies the time at which the JWT was
			--   issued.  This claim can be used to determine the age of the JWT.  Its
			--   value MUST be a number containing a NumericDate value.  Use of this
			--   claim is OPTIONAL.	
		do
		end

	set_issued_at_now_utc
		do
		end

	set_jwt_id (jti: detachable READABLE_STRING_8)
			--   The "jti" (JWT ID) claim provides a unique identifier for the JWT.
			--   The identifier value MUST be assigned in a manner that ensures that
			--   there is a negligible probability that the same value will be
			--   accidentally assigned to a different data object; if the application
			--   uses multiple issuers, collisions MUST be prevented among values
			--   produced by different issuers as well.  The "jti" claim can be used
			--   to prevent the JWT from being replayed.  The "jti" value is a case-
			--   sensitive string.  Use of this claim is OPTIONAL.	
		do
		end

feature {NONE} -- Implementation

	numeric_date_value_to_datetime (v: INTEGER_64): DATE_TIME
		do
			create Result.make_from_epoch (v.to_integer_32)
		end

	datetime_to_numeric_date_value (dt: DATE_TIME): INTEGER_64
		do
			Result := dt.definite_duration (create {DATE_TIME}.make_from_epoch (0)).seconds_count
		end

note
	copyright: "2013-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
