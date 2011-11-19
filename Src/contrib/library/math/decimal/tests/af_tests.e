note
	description:
		"All the new features are tested here which run slow and require finalizing of the system."
	copyright: "Copyright (c) SEL, York University, Toronto and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class
	AF_TESTS

inherit
	ES_TEST
		redefine
			teardown
		end
	
	DCM_MA_DECIMAL_TEST

create
	make

feature {NONE} -- Initialization

	teardown
			--Precision to 28
			--epsilon to 5
		local
			d: DECIMAL
		do
			create d.make_zero
			d.epsilon.set_epsilon (5)
			d.default_context.set_digits (28)
			d.default_context.disable_exception_on_trap
		end

	run_full: BOOLEAN = True

	make
			-- Initialization for `Current'.
		do
			if run_full then
				full_suite
			else
				add_boolean_case (agent t3)
			end
		end

	full_suite
			-- Initialization for `Current'.
	do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)

	end

feature -- tests


t1: BOOLEAN
		local
			d1,d2,d3: DECIMAL
		do
			comment("t1: test power")
			d1 := "0.81729"
			d2 := "26.1739"
			d3 := d1.power (d2)
			Result := d3 |~ "0.005087952305689706695761086793"
			check Result end
			d1 := "3.40206192657387E+29"
			d2 := "2.6789934"
			d3 := d1.power (d2)
			Result := d3 |~ "1.304194857955345505907358030E+79"
			check Result end
			d1 := "0.00000003698"
			d2 := "9.48569"
			d3 := d1.power (d2)
			Result := d3 |~ "3.177152115010034700608142518E-71"
			check Result end
			d1 := "0.000123"
			d2 := "0.000001"
			d3 := d1.power (d2)
			Result := d3 |~ "0.9999909967143272278640420863"
			check Result end
			d1 := "123456675.5"
			d2 := "0.00034"
			d3 := d1.power (d2)
			Result := d3 |~ "1.006354782783379443139450684"
			check Result end
			d1 := "5.6"
			d2 := "4.3"
			d3 := d1.power (d2)
--			supposed to be: 1648.953907346264565306510387 (accpording to calc)
            Result := d3.to_scientific_string ~ "1648.953907346264565306510389"
            check Result end
			Result := d3 |~ "1648.953907346264565306510387"
			check Result end
			d1 := "-1.928"
			d2 := "9.19"
			d3 := d1.power (d2)
			Result := d3.to_scientific_string ~ "NaN"
			check Result end
			d1 := "0.81729"
			d2 := "26.1739"
			d3 := d1.power (d2)
			Result := d3 |~ "0.005087952305689706695761086793"
			check Result end
			d1 := "3.40206192657387E+29"
			d2 := "2.6789934"
			d3 := d1.power (d2)
			Result := d3 |~ "1.304194857955345505907358030E+79"
			check Result end
			d1 := "0.00000003698"
			d2 := "9.48569"
			d3 := d1.power (d2)
			Result := d3 |~ "3.177152115010034700608142518E-71"
			check Result end
			--change precision to 9
			d1.default_context.set_digits (9)
			d1 := "0.1486"
			d2 := "14.1"
			d3 := d1.power (d2)
			Result := d3 |~ "2.11575421E-12"
			check Result end
			d1.default_context.set_digits (9)
			d1 := "9.1234"
			d2 := "0.001"
			d3 := d1.power (d2)
			Result := d3 |~ "1.00221329"
			check Result end
			d1.default_context.set_digits (9)
			d1 := "1246810.5"
			d2 := "9.5"
			d3 := d1.power (d2)
			Result := d3 |~ "8.1302572E+57"
			check Result end
			--change precision to 100
			d1.default_context.set_digits (100)
			d1 := "9.1234"
			d2 := "0.001"
			d3 := d1.power (d2)
			Result := d3 |~ "1.002213288256031489869552068746677869541340023113803300557079602259010678008300104555019596306411229"
			check Result end
			d1.default_context.set_digits (100)
			d1 := "1246810.5"
			d2 := "9.5"
			d3 := d1.power (d2)
			Result := d3 |~ "8130257201257690992203233855633535872637792936943657270532.369091969068599786332542278552005734206197"
			check Result end
			d1.default_context.set_digits (100)
			d1 := "0.00000002"
			d2 := "0.00000002"
			d3 := d1.power (d2)
			Result := d3 |~ "0.999999645449391585233416785414656877789234357020085613517929147684573770123597988673173444498038833"
			check Result end


		end

	t2: BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t2: test exp")
			create c.make_default
			check Result end
			d1 := "1"
			d2 := d1.exp
			Result := d2 |~ ("2.718281828459045235360287471")
			check Result end
			d1 := "1.72689"
			d2 := d1.exp
			Result := d2 |~ ("5.623138725000720165715793355")
			check Result end
			d1 := "-7.75"
			d2 := d1.exp
			Result := d2 |~ ("0.000430742540575687536852402278")
			check Result end
			d1 := "15.89"
			d2 := d1.exp
			Result := d2 |~ ("7960481.134288552652212165787")
			check Result end
		    d1 := "55.75"
			d2 := d1.exp
			Result := d2 |~ ("1628986053413661453565382.76")
			check Result end
			d1 := "10467.7118193028"
			d2 := d1.exp
			Result := d2 |~ ("1.173495089569205321166599833E+4546")
			check Result end
			d1 := "2468932.1819849"
			d2 := d1.exp
			Result := d2 |~ ("4.195941235177984249593274081E+1072243")
			check Result end
			create d1.make_from_string_ctx ("0", c)
			d2 := d1.exp_wrt_ctx (c)
			Result := d2.to_scientific_string ~ "1"
			check Result end
			Result := d2.out ~ "[0,1,0]"
			check Result end
			create d1.make_from_string_ctx ("1", c)
			d2 := d1.exp_wrt_ctx (c)
			Result := d2.to_scientific_string ~ "2.718281828459045235360287471"
			check Result end
			Result := d2.out ~ "[0,2718281828459045235360287471,-27]"
			check Result end
			create d1.make_from_string_ctx ("3", c)
			d2 := d1.exp_wrt_ctx (c)
			Result := d2 |~ "20.08553692318766774092852965"
			check Result end
			create d1.make_from_string_ctx ("2", c)
			d2 := d1.exp_wrt_ctx (c)
			Result := d2 |~ ("7.389056098930650227230427461")
			check Result end
			d1 := "1.72689"
			d2 := d1.exp
			Result := d2 |~ ("5.623138725000720165715793355")
			check Result end
			d1 := "-7.75"
			d2 := d1.exp
			Result := d2 |~ ("0.000430742540575687536852402278")
			check Result end
			d1 := "-0.0085"
			d2 := d1.exp
			Result := d2 |~ ("0.9915360228629667062562978987")
			check Result end
			d1 := "-0.454"
			d2 := d1.exp
			Result := d2 |~ ("0.6350827332459281530076608424")
			check Result end
			d1 := "15.89"
			d2 := d1.exp
			Result := d2 |~ ("7960481.134288552652212165787")
			check Result end
		    d1 := "55.75"
			d2 := d1.exp
			Result := d2 |~ ("1628986053413661453565382.76")
			check Result end
			d1 := "10467.7118193028"
			d2 := d1.exp
			Result := d2 |~ ("1.173495089569205321166599833E+4546")
			check Result end
			d1 := "2468932.1819849"
			d2 := d1.exp
			Result := d2 |~ ("4.195941235177984249593274081E+1072243")
			check Result end
			-- Change precision to 9
			d1.default_context.set_digits (9)
	     	d1 := "-0.454"
			d2 := d1.exp
			Result := d2 |~ ("0.635082733")
			check Result end
			d1.default_context.set_digits (9)
			d1 := "15.89"
			d2 := d1.exp
			Result := d2 |~ ("7960481.13")
			check Result end
			d1.default_context.set_digits (9)
			d1 := "1.72689"
			d2 := d1.exp
			Result := d2 |~ ("5.62313873")
			check Result end
			d1.default_context.set_digits (9)
			d1 := "200"
			d2 := d1.exp
			Result := d2 |~ ("7.22597377E+86")
			Check Result end
				d1.default_context.set_digits (9)
			d1 := "0.0023"
			d2 := d1.exp
			Result := d2 |~ ("1.00230265")
			Check Result end
			d1.default_context.set_digits (9)
			d1 := "1.0"
			d2 := d1.exp
			Result := d2 |~ ("2.71828183")
			Check Result end
			d1.default_context.set_digits (9)
			d1 := "14684.78"
			d2 := d1.exp
			Result := d2 |~ ("3.30310183E+6377")
			Check Result end
			-- Change precision to 100
			d1.default_context.set_digits (100)
	     	d1 := "0.0005"
			d2 := d1.exp
			Result := d2 |~ ("1.000500125020835937760438369605751648487716767772005667654052528513185499225469269404161288162290263")
			check Result end
			d1.default_context.set_digits (100)
			d1 := "20.5"
			d2 := d1.exp
			Result := d2 |~ ("799902177.4755054067045988372839900834544008348341993838717556666953858600627660680107180421628891604")
			check Result end
			d1.default_context.set_digits (100)
			d1 := "150"
			d2 := d1.exp
			Result := d2 |~ ("139370958066637969731834193714145747747369006140218438233756444835.6808193101011089322807094591075308")
			check Result end
			d1.default_context.set_digits (100)
			d1 := "5000"
			d2 := d1.exp
			Result := d2 |~ ("2.96762838402366706896629680528947009056986046017072782713629019382661490260609722025271069451017557E+2171")
			Check Result end
			d1.default_context.set_digits (100)
			d1 := "350"
			d2 := d1.exp
			Result := d2 |~ ("1.007090887028079759823375862957008934750807691523463949591733165265104584422741902386611822721170146e152")
			Check Result end
			d1.default_context.set_digits (100)
			d1 := "40.8675"
			d2 := d1.exp
			Result := d2 |~ ("560440793351738556.6375023298501116747558018595398419884517821051716081305064300592310541992771159926")
			Check Result end
			d1.default_context.set_digits (100)
			d1 := "0.0000023"
			d2 := d1.exp
			Result := d2 |~ ("1.000002300002645002027834499338036362122272135611635434277106600186640759357295809240614694694330455")
			Check Result end
			d1.default_context.set_digits (100)
			d1 := "90.1234567"
			d2 := d1.exp
			Result := d2 |~ ("1380765524457469385762746703256674401055.406886634257806066991329784602427246104288854000271725913621")
			Check Result end
			d1.default_context.set_digits (100)
			d1 := "12345.678910"
			d2 := d1.exp
			Result := d2 |~ ("4.573260733575855081791110241330996171100345291391873010919078267432259432242052552994285819844043374E+5361")
		    Check Result end
		end


		t3:	BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t3: test log2")
			create c.make_default
			d1 := "-0.0000001"
			d2 := d1.log2
			Result := d2.to_scientific_string ~ "NaN"
			check Result end
			d1 := "0"
			d2 := d1.log2
			Result := d2.to_scientific_string ~ "-Infinity"
			check Result end
			d1 := "-Infinity"
			d2 := d1.log2
			Result := d2.to_scientific_string ~ "NaN"
			check Result end
			d1 := "Infinity"
			d2 := d1.log2
			Result := d2.to_scientific_string ~ "Infinity"
			check Result end
			d1 := "3"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "1.584962500721156181453738944"
			check Result end
			d1 := "1234567891011121314"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "60.09871188291567647144598144"
			check Result end
			d1 := "0.35"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "-1.514573172829758240428350112"
			check Result end
			d1 := "0.00000000000014"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "-42.6996384063654687627425027"
			check Result end
			d1 := "0.007287"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "-7.100459293967152890802751222"
			check Result end
			d1 := "1000"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "9.965784284662087043610958288"
			check Result end
			d1 := "0.0005"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "-10.96578428466208704361095829"
			check Result end
			d1 := "100.00"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "6.643856189774724695740638859"
			check Result end
			--Change precision to 9 digits
			c.set_digits (9)
			d1 := "1234.56"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "10.2697812"
			check Result end
			d1 := "0.00010"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "-13.2877124"
			check Result end
			d1 := "9.1000"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "3.18586655"
			check Result end
			d1 := "4.2"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "2.07038933"
			check Result end
			d1 := "162.781E+8819"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "29303.4307"
			check Result end
			--Change precision to 41 digits
        	c.set_digits (41)
        	d1.default_context.set_digits (41)
			d1 := "1234.56"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "10.269781238274378803668206918033262081119"
			check Result end
			d1.default_context.set_digits (41)
			d1 := "1.2"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "0.26303440583379383358341951445842633289498"
           	check Result end
			d1.default_context.set_digits (41)
			d1 := "0.004"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "-7.9657842846620870436109582884681705275945"
           	check Result end
            --Change Precision to 100 digits
            c.set_digits (100)
            d1.default_context.set_digits (100)
	        d1 := "1.2"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "0.2630344058337938335834195144584263328949830146679004484009962587251634511857333466721407315587180867"
			check Result end
	        c.set_digits (100)
	        d1.default_context.set_digits (100)
 	        d1 := "0.000000000005"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2  |~ "-37.54120904376098582657351372438329193451314532327038673260232035397528254269487737435153717695307171"
			check Result end
			c.set_digits (100)
			d1.default_context.set_digits (100)
 	        d1 := "100"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "6.64385618977472469574063885897878035172966278604916122410951279163186955321725043170027948671874031"
			check Result end
			c.set_digits (100)
			d1.default_context.set_digits (100)
 	        d1 := "1000"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "9.965784284662087043610958288468170527594494179073741836164269187447804329825875647550419230078110465"
			check Result end
			c.set_digits (100)
			d1.default_context.set_digits (100)
 	        d1 := "1000000"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "19.93156856932417408722191657693634105518898835814748367232853837489560865965175129510083846015622093"
			check Result end
	     	c.set_digits (100)
	     	d1.default_context.set_digits (100)
 	        d1 := "15000000"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "23.83845916493269261654597495037354773981363415886454534483904742525264166405473507347325867843367933"
			check Result end
	        c.set_digits (100)
	        d1.default_context.set_digits (100)
 	        d1 := "1523456789000.259112345"
			d2 := d1.log2_wrt_ctx (c)
			Result := d2 |~ "40.470485718962124455869661390454931709593848514271370013965639515087626749409100290762541166524119598"
			check Result end
end

	t4: BOOLEAN
		local
			d1, d2, d3, d4, d5, d6: DECIMAL
		do
			comment("t4:  test 40 bit precision")
			-- default is 28 bits
			create d1.make_zero
			d1.default_context.set_digits (40)
			d1 := "0.6666666666666666666666666666666666666666" -- 40 bits
			d2 := "45.485698745874283873573573657356753673674298189178467216814647164127"
			d3 := d1/d2
			Result := d3 ~ "0.01465662142273093531468184203551043025793"
			check Result end
			d4 := "7896789456738930303030074267247642742674264726427874292849248.476247624764274642762474267426762472462746427642724627478889"
			d5 := d3*d4
			Result := d5 ~ "1.15740253522435590427293260449842333068E+59"
			check Result end
			d6 := d5.sqrt
			Result := d6 ~ "340206192657387690925882213614.999536766"
			check Result end

		end


note
	copyright: "Copyright (c) SEL, York University, Toronto and others"
	license: "MIT license"
	details: "[
			Originally developed by Jonathan Ostroff, Moksh Khurana, and Alex Fevga. See class DECIMAL.
		]"

end
