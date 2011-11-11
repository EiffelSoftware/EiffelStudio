note
	description: "x509v3 TBSCertificate sequence"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Democracy is a pathetic belief in the collective wisdom of individual ignorance. - H.L. Mencken"

class
	TBS_CERTIFICATE

inherit
	DER_ENCODABLE

create
	make

feature
	make (	version_a: INTEGER_32 serial_number_a: INTEGER_X signature_a: ALGORITHM_IDENTIFIER issuer_a: NAME validity_a: VALIDITY
			subject_a: NAME subject_public_key_info_a: SUBJECT_PUBLIC_KEY_INFO issuer_unique_id_a: SPECIAL [NATURAL_8]
			subject_unique_id_a: SPECIAL [NATURAL_8] extensions_a: LIST [EXTENSION])
		require

		do
			version := version_a
			serial_number := serial_number_a
			signature := signature_a
			issuer := issuer_a
			validity := validity_a
			subject := subject_a
			subject_public_key_info := subject_public_key_info_a
			issuer_unique_id := issuer_unique_id_a
			subject_unique_id := subject_unique_id_a
			extensions := extensions_a
		end

feature
	der_encode (target: DER_OCTET_SINK)
		do
			
		end

feature
	version: INTEGER_32
	serial_number: INTEGER_X
	signature: ALGORITHM_IDENTIFIER
	issuer: NAME
	validity: VALIDITY
	subject: NAME
	subject_public_key_info: SUBJECT_PUBLIC_KEY_INFO
	issuer_unique_id: SPECIAL [NATURAL_8]
	subject_unique_id: SPECIAL [NATURAL_8]
	extensions: LIST [EXTENSION]

feature
	valid_version (in: INTEGER_32): BOOLEAN
		do
			result := in = 2
		ensure
			result = (in = 2)
		end

	valid_serial_number (in: INTEGER_X): BOOLEAN
		do
			result := (in >= in.one) and in.bits <= 20 * 8
		ensure
			result = ((in >= in.one) and in.bits <= 20 * 8)
		end

invariant
	valid_version (version)
	valid_serial_number (serial_number)
end
