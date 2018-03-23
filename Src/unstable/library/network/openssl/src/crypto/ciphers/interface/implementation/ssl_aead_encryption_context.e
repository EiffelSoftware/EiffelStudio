note
	description: "Summary description for {SSL_AEAD_ENCRYPTION_CONTEXT}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_AEAD_ENCRYPTION_CONTEXT

inherit

	SSL_AEAD_CIPHER_CONTEXT
		rename
			tag as tag_value
		end

	SSL_AEAD_ENCRYPTION_CONTEXT_I

create
	make

end
