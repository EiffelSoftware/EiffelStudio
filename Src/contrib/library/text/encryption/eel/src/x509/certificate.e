note
	description: "x509v3 Certificate sequence."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Everyone thinks about changing the world, but no one thinks about changing himself. - Leo Tolstoy"

class
	CERTIFICATE

create
	make

feature
	make (tbs_certificate_a: TBS_CERTIFICATE signature_algorithm_a: ALGORITHM_IDENTIFIER signature_value_a: SPECIAL [NATURAL_8])
		do
			tbs_certificate := tbs_certificate_a
			signature_algorithm := signature_algorithm_a
			signature_value := signature_value_a
		end

feature
	tbs_certificate: TBS_CERTIFICATE
	signature_algorithm: ALGORITHM_IDENTIFIER
	signature_value: SPECIAL [NATURAL_8]

invariant
	mismatched_algorithms: signature_algorithm ~ tbs_certificate.signature
end
