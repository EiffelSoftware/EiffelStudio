note
	description: "Summary description for {SSL_CIPHER_CONTEXT_IMPL}."
	author: ""
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

feature -- Access

	ctx: SSL_CIPHER_CONTEXT_EXTERNALS

feature -- Update

	update (a_data: MANAGED_POINTER): MANAGED_POINTER
			-- <Precursor>.
		local
			l_expection: DEVELOPER_EXCEPTION
		do
			create Result.make (0)
			if ctx.finalized then
				raise_exception ("Context was already finalized")
			else
		      	Result := ctx.update(a_data)
		    end
		end

   update_into(a_data, a_buf: MANAGED_POINTER): INTEGER
			-- <Precursor>	
		do
			if ctx.finalized then
					-- Context was already finalized
				raise_exception ("Context was already finalized")
			else
		      	Result := ctx.update_into(a_data, a_buf)
		    end
		end

feature -- Finalize

   finalize: MANAGED_POINTER
			-- <Precursor>
		do
			create Result.make (0)
			if ctx.finalized then
				raise_exception ("Context was already finalized")
			end
			Result := ctx.finalize
			ctx.clean_context
		end
end
