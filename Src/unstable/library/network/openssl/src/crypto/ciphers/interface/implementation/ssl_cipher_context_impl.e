note
	description: "Summary description for {SSL_CIPHER_CONTEXT_IMPL}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_CIPHER_CONTEXT_IMPL

inherit

	SSL_CIPHER_CONTEXT

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

end
