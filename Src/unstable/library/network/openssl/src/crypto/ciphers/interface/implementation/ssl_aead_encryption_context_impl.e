note
	description: "Summary description for {SSL_AEAD_ENCRYPTION_CONTEXT_IMPL}."
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

end
