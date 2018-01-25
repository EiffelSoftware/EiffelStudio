note
	description: "Summary description for {SSL_AEAD_CIPHER_CONTEXT_IMPL}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_AEAD_CIPHER_CONTEXT_IMPL

inherit

	SSL_CIPHER_CONTEXT
	SSL_AEAD_CIPHER_CONTEXT
	SSL_AEAD_DECRYPTION_CONTEXT
	SSL_SHARED_EXCEPTIONS

create
	make

feature {NONE} -- Initialization

	make (a_ctx: SSL_CIPHER_CONTEXT_EXTERNALS)
		do
			ctx := a_ctx
			bytes_processed := 0
			aad_bytes_processed := 0
			updated := False
		ensure
			ctx_setted: ctx = a_ctx
			updated_setted: updated = False
		end

feature -- Access

	ctx: SSL_CIPHER_CONTEXT_EXTERNALS
			-- cipher context.	

	bytes_processed: INTEGER
			-- number of bytes processed.

	aad_bytes_processed: INTEGER
			-- number of aad bytes processed.

	tag: detachable MANAGED_POINTER

	updated: BOOLEAN

feature -- Status Report

	check_limit (a_data_size: INTEGER)
		local
			l_description: STRING
		do
				-- TODO review this.
			if ctx.finalized then
				raise_exception ("Context was already finalized.")
			else
				updated := True
				bytes_processed := bytes_processed + a_data_size
--				if bytes_processed > ctx.mode.MAX_ENCRYPTED_BYTES then
--					create l_description.make_from_string (ctx.mode.name)
--					l_description.append_string (" has a maximum encrypted byte limit of ")
--					l_description.append_string (ctx.mode.MAX_ENCRYPTED_BYTES)
--					raise_exception (l_description)
--				end
			end
		end

feature -- Update

	update (a_data: MANAGED_POINTER): MANAGED_POINTER
			-- <Precursor>
		do
			check_limit (a_data.count)
			Result := ctx.update (a_data)
		end

   update_into(a_data, a_buf: MANAGED_POINTER): INTEGER
			-- <Precursor>
		do
			check_limit (a_data.count)
			Result := ctx.update_into (a_data, a_buf)
		end

feature -- Finalize

   finalize: MANAGED_POINTER
			-- <Precursor>
		do
			create Result.make (0)
			if ctx.finalized then
				raise_exception ("Context was already finalized.")
			else
				Result := ctx.finalize
				tag := ctx.tag
				ctx.clean_context
			end
		end

	finalize_with_tag (a_tag: MANAGED_POINTER): MANAGED_POINTER
			-- <Precursor>
		do
			create Result.make (0)
			if ctx.finalized then
				raise_exception ("Context was already finalized.")
			else
				Result := ctx.finalize_with_tag (a_tag)
				tag := ctx.tag
				ctx.clean_context
			end
		end

	authenticate_additional_data (a_data: MANAGED_POINTER)
			-- <Precursor>
		local
			l_description: STRING
		do
			if ctx.finalized then
				raise_exception ("Context was already finalized.")
			end
			if updated then
				raise_exception ("Update has been called on this context.")
			end

			aad_bytes_processed := aad_bytes_processed + a_data.count
--			if aad_bytes_processed > ctx.mode.MAX_AAD_BYTES then
--				create l_description.make_from_string (ctx.mode.name)
--				l_description.append_string (" has a maximum AAD byte limit of ")
--				l_description.append_string (ctx.mode.MAX_AAD_BYTES)
--				raise_exception (l_description)
--			end
			ctx.authenticate_additional_data (a_data)
		end

end


