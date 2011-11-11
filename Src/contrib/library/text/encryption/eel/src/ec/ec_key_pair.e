note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "A nation of sheep will beget a government of wolves. - Edward R. Murrow"

class
	EC_KEY_PAIR

inherit
	DEBUG_OUTPUT

create
	make,
	make_p192,
	make_p224,
	make_p256,
	make_p384,
	make_p521,
	make_k163,
	make_k233,
	make_k283,
	make_k409,
	make_k571,
	make_b163,
	make_b233,
	make_b283,
	make_b409,
	make_b571,
	make_sec_p112r1,
	make_sec_p112r2,
	make_sec_p128r1,
	make_sec_p128r2,
	make_sec_p160k1,
	make_sec_p160r1,
	make_sec_p160r2,
	make_sec_p192k1,
	make_sec_p192r1,
	make_sec_p224k1,
	make_sec_p224r1,
	make_sec_p256k1,
	make_sec_p256r1,
	make_sec_p384r1,
	make_sec_p521r1,
	make_sec_t113r1,
	make_sec_t113r2,
	make_sec_t131r1,
	make_sec_t131r2,
	make_sec_t163k1,
	make_sec_t163r1,
	make_sec_t163r2,
	make_sec_t193r1,
	make_sec_t193r2,
	make_sec_t233k1,
	make_sec_t233r1,
	make_sec_t239k1,
	make_sec_t283k1,
	make_sec_t283r1,
	make_sec_t409k1,
	make_sec_t409r1,
	make_sec_t571k1,
	make_sec_t571r1

feature
	make (params: EC_DOMAIN_PARAMETERS)
		local
			d: INTEGER_X
			q: EC_POINT
		do
			from
				create d.make_random_max (params.n)
			until
				not d.is_zero
			loop
				create d.make_random_max (params.n)
			end
			q := params.g.product_value (d, params.curve)
			create public.make_q_parameters (q, params)
			create private.make_d_params (d, params)
		end

feature --SEC recommended prime curves
	make_sec_p112r1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p112r1)
		end

	make_sec_p112r2
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p112r2)
		end

	make_sec_p128r1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p128r1)
		end

	make_sec_p128r2
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p128r2)
		end

	make_sec_p160k1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p160k1)
		end

	make_sec_p160r1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p160r1)
		end

	make_sec_p160r2
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p160r2)
		end

	make_sec_p192k1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p192k1)
		end

	make_sec_p192r1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p192r1)
		end

	make_sec_p224k1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p224k1)
		end

	make_sec_p224r1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p224r1)
		end

	make_sec_p256k1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p256k1)
		end

	make_sec_p256r1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p256r1)
		end

	make_sec_p384r1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p384r1)
		end

	make_sec_p521r1
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_sec_p521r1)
		end

feature --SEC recommended polynomial curves
	make_sec_t113r1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t113r1)
		end

	make_sec_t113r2
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t113r2)
		end

	make_sec_t131r1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t131r1)
		end

	make_sec_t131r2
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t131r2)
		end

	make_sec_t163k1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t163k1)
		end

	make_sec_t163r1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t163r1)
		end

	make_sec_t163r2
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t163r2)
		end

	make_sec_t193r1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t193r1)
		end

	make_sec_t193r2
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t193r2)
		end

	make_sec_t233k1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t233k1)
		end

	make_sec_t233r1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t233r1)
		end

	make_sec_t239k1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t239k1)
		end

	make_sec_t283k1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t283k1)
		end

	make_sec_t283r1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t283r1)
		end

	make_sec_t409k1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t409k1)
		end

	make_sec_t409r1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t409r1)
		end

	make_sec_t571k1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t571k1)
		end

	make_sec_t571r1
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_sec_t571r1)
		end

feature --FIPS curves
	make_p192
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_p192)
		end

	make_p224
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_p224)
		end

	make_p256
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_p256)
		end

	make_p384
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_p384)
		end

	make_p521
		do
			make (create {EC_DOMAIN_PARAMETERS_FP}.make_p521)
		end

	make_k163
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_k163)
		end

	make_k233
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_k233)
		end

	make_k283
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_k283)
		end

	make_k409
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_k409)
		end

	make_k571
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_k571)
		end

	make_b163
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_b163)
		end

	make_b233
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_b233)
		end

	make_b283
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_b283)
		end

	make_b409
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_b409)
		end

	make_b571
		do
			make (create {EC_DOMAIN_PARAMETERS_F2M}.make_b571)
		end

	public: EC_PUBLIC_KEY
	private: EC_PRIVATE_KEY

feature {DEBUG_OUTPUT} -- {DEBUG_OUTPUT}
	debug_output: STRING
		do
			result := "Public:%N" + public.debug_output + "%NPrivate:%N" + private.debug_output
		end
end
