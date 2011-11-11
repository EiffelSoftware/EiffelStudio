note
	description: "ASN.1 OIDs"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote:
	"[
		Virtually all reasonable laws are obeyed, not because they are the law, but because reasonable people would do that anyway.
		If you obey a law simply because it is the law, that's a pretty likely sign that it shouldn't be a law. - Unknown
	]"

class
	OBJECT_IDENTIFIER

inherit
	ANY
		redefine
			is_equal
		end

create
	make_md2,
	make_md5,
	make_id_sha1,
	make_md2_with_rsa_encryption,
	make_md5_with_rsa_encryption,
	make_sha_1_with_rsa_encryption,
	make_id_dsa_with_sha1,
	make_ecdsa_with_sha1,
	make_pkcs_1

feature
	make_md2
		do
			id := "1.2.840.113549.2.2"
		end

	make_md5
		do
			id := "1.2.840.113549.2.5"
		end

	make_id_sha1
		do
			id := "1.3.14.3.2.26"
		end

	make_md2_with_rsa_encryption
		do
			id := "1.2.840.113549.1.1.2"
		end

	make_md5_with_rsa_encryption
		do
			id := "1.2.840.113549.1.1.4"
		end

	make_sha_1_with_rsa_encryption
		do
			id := "1.2.840.113549.1.1.5"
		end

	make_id_dsa_with_sha1
		do
			id := "1.2.840.10040.4.3"
		end

	make_ecdsa_with_sha1
		do
			id := "1.2.840.10045.4.1"
		end

	make_pkcs_1
		do
			id := "1.2.840.113549.1"
		end

	make_sha_224_with_rsa_encryption
		do
			id := "1.2.840.113549.1.14"
		end

	make_sha_256_with_rsa_encryption
		do
			id := "1.2.840.113549.1.11"
		end

	make_sha_384_with_rsa_encryption
		do
			id := "1.2.840.113549.1.12"
		end

	make_sha_512_with_rsa_encryption
		do
			id := "1.2.840.113549.1.13"
		end

feature
	is_equal (other: like Current): BOOLEAN
		do
			result := id ~ other.id
		ensure then
			id ~ other.id
		end

feature
	id: STRING
end
