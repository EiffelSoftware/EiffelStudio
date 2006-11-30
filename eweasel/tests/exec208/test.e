class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			p: $EXPANDED_TYPE POINT
		do
			p.set_x (5)
			print ("p.x                   = " + p.x.out                     + "%N")

			print ("conforms_to           = " + p.conforms_to (p).out       + "%N")
			print ("deep_equal            = " + p.deep_equal (p, p).out     + "%N")
			print ("same_type             = " + p.same_type (p).out         + "%N")
			print ("standard_equal        = " + p.standard_equal (p, p).out + "%N")
			print ("standard_is_equal     = " + p.standard_is_equal (p).out + "%N")
			print ("default               = " + p.default.out               + "%N")
			print ("default_pointer       = " + p.default_pointer.out       + "%N")
			p.do_nothing
			p.io.put_string ("io                    = OK%N")
			print ("operating_environment = " + p.operating_environment.out + "%N")
			print ("generating_type       = " + p.generating_type.out       + "%N")
			print ("generator             = " + p.generator.out             + "%N")
			print ("out                   = " + p.out                       + "%N")
			print ("tagged_out            = " + p.tagged_out                + "%N")
			print ("clone                 = " + p.clone (p).out             + "%N")
			print ("deep_clone            = " + p.deep_clone (p).out        + "%N")
			print ("standard_clone        = " + p.standard_clone (p).out    + "%N")
			p.copy (p)
			p.deep_copy (p)
			p.standard_copy (p)
			print ("deep_twin             = " + p.deep_twin.out             + "%N")
			print ("standard_twin         = " + p.standard_twin.out         + "%N")
			print ("twin                  = " + p.twin.out                  + "%N")
			print ("equal                 = " + p.equal (p, p).out          + "%N")
			print ("is_equal              = " + p.is_equal (p).out          + "%N")
			p.default_create
			p.default_rescue
		end

end
