JSON Web Token (JWT)

http://jwt.io/

Note: supporting only HS256 and none algorithm for signature.

# How to use
```eiffel
	local
		jwt: JWT
	do
		create jwt
		tok := jwt.encoded_string ("[
			{"iss":"joe", "exp":1200819380,"http://example.com/is_root":true}
			]", "secret", "HS256")
		if
			attached jwt.decoded_string (tok, "secret", Void) as l_tok_payload and
			not jwt.has_error
		then
			check verified: not jwt.has_unverified_token_error end
			check no_error: not jwt.has_error end
			print (l_tok_payload)
		end
	end
```

