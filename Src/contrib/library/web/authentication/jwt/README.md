JSON Web Token (JWT)

http://jwt.io/

Note: supporting only HS256 and none algorithm for signature, but could be extend with your own algorithm via `JWT_ALGORITHMS` (see `JWT.algorithms`, and `JWT_LOADER.algorithms`).

# How to use
```eiffel

	example
		local
			jwt: JWS
			tok: STRING
			l_loader: JWT_LOADER
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
	end
```

