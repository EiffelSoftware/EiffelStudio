note
	description: "Summary description for {TEST_JWT}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_JWT

inherit
	EQA_TEST_SET

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create
		end

feature -- Test

	example
		local
			jwt: JWS
			l_loader: JWT_LOADER
			tok: STRING
		do
			create jwt.make_with_json_payload ("[
					{"iss":"joe", "exp":1200819380,"http://example.com/is_root":true}
					]")
			jwt.set_algorithm_to_hs256
			tok := jwt.encoded_string ("my-secret")

			create l_loader
			if
				attached l_loader.token (tok, Void, "my-secret", Void) as l_tok and then
				not l_tok.has_error
			then
				print (l_tok.claimset.string)
				check verified: not l_tok.has_unverified_token_error end
				check no_error: not l_tok.has_error end
			end
		end


	test_jwt_io
		local
			jwt: JWS
			ut: JWT_UTILITIES
		do
			create jwt
			jwt.set_algorithm ("HS256")
			jwt.claimset.set_subject ("1234567890")
			jwt.claimset.set_claim ("name", "John Doe")
			jwt.claimset.set_claim ("admin", True)
			create ut

			assert ("header", ut.base64url_encode (jwt.header.string).same_string ("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"))
			assert ("payload", ut.base64url_encode (jwt.claimset.string).same_string ("eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9"))
			assert ("signature", jwt.encoded_string ("secret").same_string ("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.pcHcZspUvuiqIPVB_i_qmcvCJv63KLUgIAKIlXI1gY8"))
		end

	test_jwt
		local
			jwt: JWS
			jwt_loader: JWT_LOADER
			payload: STRING
			tok: STRING
		do
			payload := "[
				{"iss":"joe","exp":1300819380,"http://example.com/is_root":true}
				]"

--			payload := "[
--					{"sub":"1234567890","name":"John Doe","admin":true}
--				]"

			create jwt.make_with_json_payload (payload)
			jwt.set_algorithm ("HS256")
			tok := jwt.encoded_string ("secret")

			create jwt_loader

				-- Use header alg!
			if attached jwt_loader.token (tok, Void, "secret", Void) as l_tok then
				assert ("no error", not l_tok.has_error)
				assert ("same payload", l_tok.claimset.string.same_string (payload))
			end

				-- Use given alg!
			if attached jwt_loader.token (tok, jwt.algorithm, "secret", Void) as l_tok then
				assert ("no error", not l_tok.has_error)
				assert ("same payload", l_tok.claimset.string.same_string (payload))
			end
		end

	test_jwt_with_claimset
		local
			jwt: JWS
			jwt_loader: JWT_LOADER
			payload: STRING
			tok: STRING
			now, dt: DATE_TIME
			ctx: JWT_CONTEXT
		do
--			payload := "[
--				{"iss":"joe","exp":1300819380,"http://example.com/is_root":true}
--				]"

			payload := "[
					{"sub":"1234567890","name":"John Doe","admin":true}
				]"

			create jwt.make_with_json_payload (payload)
			jwt.set_algorithm ("HS256")
			create now.make_now_utc
			jwt.claimset.set_issued_at (now)

			dt := duplicated_time (now)
			dt.minute_add (60)
			jwt.claimset.set_expiration_time (dt)

			jwt.claimset.set_issuer ("urn:foo")
			jwt.claimset.set_audience ("urn:foo")

			tok := jwt.encoded_string ("secret")

			payload := jwt.claimset.string

			create jwt_loader

				-- Test with validation + exp
			if attached jwt_loader.token (tok, jwt.algorithm, "secret", Void) as l_tok then
				assert ("no error", not l_tok.has_error)
				assert ("same payload", l_tok.claimset.string.same_string (payload))
			end

			create ctx
			ctx.set_time (now)
			if attached jwt_loader.token (tok, jwt.algorithm, "secret", ctx) as l_tok then
				assert ("no error", not l_tok.has_error)
			end

			dt := duplicated_time (now)
			dt.hour_add (5)
			ctx.set_time (dt)
			if attached jwt_loader.token (tok, jwt.algorithm, "secret", ctx) as l_tok then
				assert ("exp error", l_tok.has_error)
			end

				-- Test with validation + not before

			dt := duplicated_time (now)
			dt.second_add (30)
			jwt.claimset.set_not_before_time (dt)
			tok := jwt.encoded_string ("secret")

			ctx.set_time (now)
			if attached jwt_loader.token (tok, jwt.algorithm, "secret", ctx) as l_tok then
				assert ("has nbf error", l_tok.has_error)
			end

			dt := duplicated_time (now)
			dt.second_add (15)
			ctx.set_time (dt)

			if attached jwt_loader.token (tok, jwt.algorithm, "secret", ctx) as l_tok then
				assert ("has nbf error", l_tok.has_error)
			end

			dt := duplicated_time (now)
			dt.minute_add (45)
			ctx.set_time (dt)

			if attached jwt_loader.token (tok, jwt.algorithm, "secret", ctx) as l_tok then
				assert ("no error", not l_tok.has_error)
			end

				-- Test Issuer
			ctx.set_issuer ("urn:foobar")
			if attached jwt_loader.token (tok, jwt.algorithm, "secret", ctx) as l_tok then
				assert ("has iss error", l_tok.has_error)
			end
			ctx.set_issuer ("urn:foo")
			if attached jwt_loader.token (tok, jwt.algorithm, "secret", ctx) as l_tok then
				assert ("no error", not l_tok.has_error)
			end

				-- Test Audience
			ctx.set_audience ("urn:foobar")
			if attached jwt_loader.token (tok, jwt.algorithm, "secret", ctx) as l_tok then
				assert ("has aud error", l_tok.has_error)
			end
			ctx.set_audience ("urn:foo")
			if attached jwt_loader.token (tok, jwt.algorithm, "secret", ctx) as l_tok then
				assert ("no error", not l_tok.has_error)
			end
		end

	test_mismatched_alg_jwt
		local
			jwt: JWS
			payload: STRING
			tok: STRING
		do
			payload := "[
				{"iss":"joe","exp":1300819380,"http://example.com/is_root":true}
				]"

			create jwt.make_with_json_payload (payload)
			jwt.set_algorithm ("none")
			tok := jwt.encoded_string ("secret")

			if attached (create {JWT_LOADER}).token (tok, "HS256", "secret", Void) as l_tok then
				assert ("error", l_tok.has_error)
				assert ("has_mismatched_alg_error", l_tok.has_mismatched_alg_error)
				assert ("same payload", l_tok.claimset.string.same_string (payload))
			end
		end

	test_unsecured_jwt
		local
			jwt: JWS
			payload: STRING
			tok: STRING
		do
			payload := "[
				{"iss":"joe","exp":1300819380,"http://example.com/is_root":true}
				]"

			create jwt.make_with_json_payload (payload)
			jwt.set_algorithm ("none")
			tok := jwt.encoded_string ("secret")

			if attached (create {JWT_LOADER}).token (tok, "none", "secret", Void) as l_tok then
				assert ("no error", not l_tok.has_error)
				assert ("same payload", l_tok.claimset.string.same_string (payload))
			end
			if attached (create {JWT_LOADER}).token (tok, Void, "secret", Void) as l_tok then
				assert ("no error", not l_tok.has_error)
				assert ("same payload", l_tok.claimset.string.same_string (payload))
			end
		end

	test_additional_alg
		local
			jwt: JWS
			payload: STRING
			tok: STRING
			l_loader: JWT_LOADER
		do
			payload := "[
				{"iss":"joe","exp":1300819380,"http://example.com/is_root":true}
				]"

			create jwt.make_with_json_payload (payload)
			jwt.algorithms.register_algorithm (create {JWT_ALG_TEST})
			jwt.set_algorithm ({JWT_ALG_TEST}.name)
			tok := jwt.encoded_string ("secret")

			create l_loader
			l_loader.algorithms.register_algorithm (create {JWT_ALG_TEST})
			if attached l_loader.token (tok, "test", "secret", Void) as l_tok then
				assert ("no error", not l_tok.has_error)
				assert ("not has_unsupported_alg_error", not l_tok.has_unsupported_alg_error)
				assert ("same payload", l_tok.claimset.string.same_string (payload))
			end
			if attached l_loader.token (tok, Void, "secret", Void) as l_tok then
				assert ("no error", not l_tok.has_error)
				assert ("same payload", l_tok.claimset.string.same_string (payload))
			end

			create l_loader
			if attached l_loader.token (tok, "test", "secret", Void) as l_tok then
				assert ("has error", l_tok.has_error)
				assert ("has_unsupported_alg_error", l_tok.has_unsupported_alg_error)
			end
		end

feature -- Implementation

	duplicated_time (dt: DATE_TIME): DATE_TIME
		do
			Result := dt.deep_twin
		end

end
