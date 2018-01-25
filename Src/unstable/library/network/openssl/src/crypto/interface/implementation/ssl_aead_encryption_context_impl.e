note
	description: "Summary description for {SSL_AEAD_ENCRYPTION_CONTEXT_IMPL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_AEAD_ENCRYPTION_CONTEXT_IMPL

inherit

	SSL_AEAD_CIPHER_CONTEXT_IMPL
		rename
			tag as tag_value
		end

	SSL_AEAD_ENCRYPTION_CONTEXT

create
	make

feature -- ACCESS


	tag: detachable MANAGED_POINTER
			-- <Precursor>
		do
			if not ctx.finalized then
				raise_exception ("You must finalize encryption before getting the tag")
			end
			Result := tag_value
       	end

end
