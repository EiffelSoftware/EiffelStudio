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
		local
			jp: JSON_PARSER
		do
			create jp.make_with_string (j)
			jp.parse_content
			if jp.is_valid and then attached jp.parsed_json_object as jo then
				across
					jo as ic
				loop
					json.put (ic.item, ic.key)
				end
			end
		end

feature -- Access

	claim alias "[]" (a_name: READABLE_STRING_GENERAL): detachable ANY
		do
			if attached json.item (a_name) as jv then
				if attached {JSON_STRING} jv as js then
					Result := js.unescaped_string_32
				elseif attached {JSON_BOOLEAN} jv as jb then
					Result := jb.item
				elseif attached {JSON_NUMBER} jv as jnum then
					if jnum.is_integer then
						Result := jnum.integer_64_item
					elseif jnum.is_natural then
						Result := jnum.natural_64_item
					elseif jnum.is_real then
						Result := jnum.real_64_item
					else
						Result := jnum.item
					end
				end
			end
		end

	string_32_claim (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			if attached json.item (a_name) as jv then
				if attached {JSON_STRING} jv as js then
					Result := js.unescaped_string_32
				elseif attached {JSON_BOOLEAN} jv as jb then
					Result := jb.item.out
				elseif attached {JSON_NUMBER} jv as jnum then
					Result := jnum.item.to_string_32
				end
			end
		end

	string_8_claim (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
		do
			if attached json.item (a_name) as jv then
				if attached {JSON_STRING} jv as js then
					Result := js.unescaped_string_8
				elseif attached {JSON_BOOLEAN} jv as jb then
					Result := jb.item.out
				elseif attached {JSON_NUMBER} jv as jnum then
					Result := jnum.item
				end
			end
		end

	issuer: detachable READABLE_STRING_8 assign set_issuer
		do
			Result := string_8_claim ("iss")
		end

	subjet: detachable READABLE_STRING_32 assign set_subject
		do
			Result := string_32_claim ("sub")
		end

	audience: detachable READABLE_STRING_8 assign set_audience
		do
			Result := string_8_claim ("aud")
		end

	expiration_time: detachable DATE_TIME assign set_expiration_time
		do
			if attached {INTEGER_64} claim ("exp") as i64 then
				Result := numeric_date_value_to_datetime (i64)
			end
		end

	not_before_time: detachable DATE_TIME assign set_not_before_time
		do
			if attached {INTEGER_64} claim ("nbf") as i64 then
				Result := numeric_date_value_to_datetime (i64)
			end
		end

	issued_at: detachable DATE_TIME assign set_issued_at
		do
			if attached {INTEGER_64} claim ("iat") as i then
				Result := numeric_date_value_to_datetime (i)
			end
		end

	jwd_id: detachable READABLE_STRING_8 assign set_jwt_id
		do
			Result := string_8_claim ("jti")
		end

feature -- Conversion

	json: JSON_OBJECT

	string: STRING
		do
			Result := json.representation
		end

feature -- Element change

	set_claim (a_name: READABLE_STRING_GENERAL; a_val: detachable ANY)
		do
			if a_val = Void then
				json.remove (a_name)
			elseif attached {READABLE_STRING_GENERAL} a_val as str then
				json.put_string (str, a_name)
			elseif attached {BOOLEAN} a_val as b then
				json.put_boolean (b, a_name)
			elseif attached {DATE_TIME} a_val as dt then
				json.put_integer (datetime_to_numeric_date_value (dt), a_name)
			elseif attached {DATE} a_val as d then
				json.put_integer (datetime_to_numeric_date_value (create {DATE_TIME}.make_by_date (d)), a_name)
			elseif attached {NUMERIC} a_val as num then
				if attached {INTEGER_64} num as i64 then
					json.put_integer (i64, a_name)
				elseif attached {INTEGER_32} num as i32 then
					json.put_integer (i32.to_integer_64, a_name)
				elseif attached {NATURAL_64} num as n64 then
					json.put_natural (n64, a_name)
				elseif attached {INTEGER_32} num as n32 then
					json.put_natural (n32.to_natural_64, a_name)
				elseif attached {REAL_64} num as r64 then
					json.put_real (r64, a_name)
				elseif attached {REAL_32} num as r32 then
					json.put_real (r32, a_name)
				else
					json.put_string (a_val.out, a_name)
				end
			else
				json.put_string (a_val.out, a_name)
			end
		end

	set_issuer (iss: detachable READABLE_STRING_8)
			-- The "iss" (issuer) claim identifies the principal that issued the
			-- JWT.  The processing of this claim is generally application specific.
			-- The "iss" value is a case-sensitive string containing a StringOrURI
			-- value.  Use of this claim is OPTIONAL.	
		do
			set_claim ("iss", iss)
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
			set_claim ("sub", sub)
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
			set_claim ("aud", aud)
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
    		if exp = Void then
    			set_claim ("exp", Void)
    		else
    			set_claim ("exp", datetime_to_numeric_date_value (exp))
    		end
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
			if nbf = Void then
				set_claim ("nbf", Void)
			else
				set_claim ("nbf", datetime_to_numeric_date_value (nbf))
			end
		end

	set_issued_at (iat: detachable DATE_TIME)
			--   The "iat" (issued at) claim identifies the time at which the JWT was
			--   issued.  This claim can be used to determine the age of the JWT.  Its
			--   value MUST be a number containing a NumericDate value.  Use of this
			--   claim is OPTIONAL.	
		do
			if iat = Void then
				set_claim ("iat", Void)
			else
				set_claim ("iat", datetime_to_numeric_date_value (iat))
			end
		end

	set_issued_at_now_utc
		do
			set_issued_at (create {DATE_TIME}.make_now_utc)
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
			set_claim ("jti", jti)
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

end
