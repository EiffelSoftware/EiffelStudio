note
	description: "[
		Object responsible to perfom encryption/decryption
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_CIPHER

create
	make

feature {NONE} -- Initialization

	make (a_algo: SSL_ALGORITHM; a_mode: SSL_MODE)
			-- Create an object with algorithm `a_algo' and mode `a_mode'
		do
			algorithm := a_algo
			mode := a_mode
		ensure
			valid_mode: a_mode.is_valid_for_algorithm (a_algo)
		end

feature -- Access

	algorithm: SSL_ALGORITHM
			--  cryptographic algorithm.

	mode: SSL_MODE
			-- mode to be used by the crypto algorithm.

feature -- Encryptor

	encryptor: SSL_CIPHER_CONTEXT
			-- get a encryption cipher context instance.
		local
				l_ctx: SSL_CIPHER_CONTEXT_EXTERNALS
		do
			create l_ctx.make (algorithm, mode, {SSL_CIPHER_CONTEXT_EXTERNALS}.encrypt_mode)
			Result := wrap_context (l_ctx, True)
		end

feature -- Decryptor

	decryptor: SSL_CIPHER_CONTEXT
			-- get a decryption cipher context instance.
		local
			l_ctx: SSL_CIPHER_CONTEXT_EXTERNALS
		do
			create l_ctx.make (algorithm, mode, {SSL_CIPHER_CONTEXT_EXTERNALS}.decrypt_mode)
			Result := wrap_context (l_ctx, False)
		end

feature {NONE} -- Implementation

	wrap_context (a_ctx: SSL_CIPHER_CONTEXT_EXTERNALS; a_encrypt: BOOLEAN): SSL_CIPHER_CONTEXT
		do
			if attached {SSL_MODE_WITH_AUTHENTICATION_TAG} mode as l_mode then
				if a_encrypt then
					create {SSL_AEAD_ENCRYPTION_CONTEXT_IMPL} Result.make (a_ctx)
				else
					create {SSL_AEAD_CIPHER_CONTEXT_IMPL} Result.make (a_ctx)
				end
			else
				create {SSL_CIPHER_CONTEXT_IMPL} Result.make (a_ctx)
			end
		end
end
