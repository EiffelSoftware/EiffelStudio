note
	description: "Summary description for {SSL_CIPHER_CONTEXT}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_CIPHER_CONTEXT

inherit
	SSL_CIPHER_CONTEXT_I

	SSL_SHARED_EXCEPTIONS

create
	make

feature {NONE} -- Initialization

	make (a_ctx: SSL_CIPHER_CONTEXT_EXTERNALS)
		do
			ctx := a_ctx
		ensure
			ctx_set: ctx = a_ctx
		end

feature {NONE} -- Implementation

	ctx: SSL_CIPHER_CONTEXT_EXTERNALS

feature -- Update

	update_with_hex_string (a_data: READABLE_STRING_8)
			-- <Precursor>.
		do
			if ctx.finalized then
				raise_exception ("Context was already finalized")
			else
		      	ctx.update_with_hex_string(a_data)
		    end
		end

feature -- Status Report

	is_finalized: BOOLEAN
			-- Is the context finalized?		
		do
			Result := ctx.finalized
		end

feature -- Finalize

	finalize
			-- <Precursor>
		do
			if ctx.finalized then
				raise_exception ("Context was already finalized")
			end
			ctx.finalize
			ctx.clean_context
		end

feature -- Results

	hex_string: STRING
			-- <Precursor>
		do
			Result := ctx.hex_string
		end

	string: STRING
			-- <Precursor>
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
