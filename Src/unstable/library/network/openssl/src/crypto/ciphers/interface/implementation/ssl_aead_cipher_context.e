note
	description: "Summary description for {SSL_AEAD_CIPHER_CONTEXT}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_AEAD_CIPHER_CONTEXT

inherit

	SSL_AEAD_DECRYPTION_CONTEXT_I

	SSL_AEAD_CIPHER_CONTEXT_I

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

feature {NONE} -- Implementation

	ctx: SSL_CIPHER_CONTEXT_EXTERNALS
			-- cipher context.	

feature -- Access

	bytes_processed: INTEGER
			-- number of bytes processed.

	aad_bytes_processed: INTEGER
			-- number of aad bytes processed.

	updated: BOOLEAN

	tag_hex_string: detachable STRING
			-- <Precursor>
		local
			l_byte_array: BYTE_ARRAY_CONVERTER
		do
			if attached tag as l_tag then
				create l_byte_array.make (l_tag.count)
				l_byte_array.append_bytes (l_tag.read_array (0, l_tag.count))
				Result := l_byte_array.to_hex_string
				Result.to_lower
			end
		end

feature -- Status Report

	is_finalized: BOOLEAN
			-- <Precursor>		
		do
			Result := ctx.finalized
		end

	check_limit (a_data_size: INTEGER)
		do
				-- TODO review this.
			if ctx.finalized then
				raise_exception ("Context was already finalized.")
			else
				updated := True
				bytes_processed := bytes_processed + a_data_size
				-- TODO: test the following validation.
--				if bytes_processed > ctx.mode.MAX_ENCRYPTED_BYTES then
--					create l_description.make_from_string (ctx.mode.name)
--					l_description.append_string (" has a maximum encrypted byte limit of ")
--					l_description.append_string (ctx.mode.MAX_ENCRYPTED_BYTES)
--					raise_exception (l_description)
--				end
			end
		end

feature -- Update

	update_with_hex_string (a_data: READABLE_STRING_8)
			-- <Precursor>
		do
			check_limit (a_data.count // 2)
			ctx.update_with_hex_string (a_data)
		end

feature {NONE} -- Tag implementation

	tag: detachable MANAGED_POINTER
			-- tag value as bytes. This is only available after encryption is finalized.

feature -- Finalize

	finalize
			-- <Precursor>
		do
			if ctx.finalized then
				raise_exception ("Context was already finalized.")
			else
				ctx.finalize
				tag := ctx.tag
				ctx.clean_context
			end
		end

	finalize_with_tag_hex_string (a_tag: READABLE_STRING_8)
			-- <Precursor>
		do
			if ctx.finalized then
				raise_exception ("Context was already finalized.")
			else
				ctx.finalize_with_tag_hex_string (a_tag)
				tag := ctx.tag
				ctx.clean_context
			end
		end

	authenticate_additional_data_hex_string (a_data: READABLE_STRING_8)
			-- <Precursor>
		do
			if ctx.finalized then
				raise_exception ("Context was already finalized.")
			end
			if updated then
				raise_exception ("Update has been called on this context.")
			end

			aad_bytes_processed := aad_bytes_processed + (a_data.count // 2)
			-- TODO: test the following validation.
--			if aad_bytes_processed > ctx.mode.MAX_AAD_BYTES then
--				create l_description.make_from_string (ctx.mode.name)
--				l_description.append_string (" has a maximum AAD byte limit of ")
--				l_description.append_string (ctx.mode.MAX_AAD_BYTES)
--				raise_exception (l_description)
--			end
			ctx.aad_hex_string (a_data)
		end

feature -- Results

	hex_string: STRING
			-- <Precursor>
		do
			Result := ctx.hex_string
		end

	string: STRING
		do
			Result := ctx.string
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


