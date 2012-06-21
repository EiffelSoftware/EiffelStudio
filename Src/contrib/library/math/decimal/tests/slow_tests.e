note
	description:
		"All the new features are tested here which run slow and require finalizing of the system."
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class
	SLOW_TESTS
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
			--reset precision to 28
			--reset epsilon to 5
		local
			d: DECIMAL
		do
			-- default is 28 bits
			--default epsilon is 5
			--default has no exceptions disabled
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
				add_boolean_case (agent t2)
			end
		end

	full_suite
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
		end

feature -- tests



	t1: BOOLEAN
		local
			d1,d2: DECIMAL
		do
			comment("t1: test sqrt(x)")
			d1 := "-1.81"
			d2 := d1.sqrt
			Result := d2.to_scientific_string ~ "NaN"
			check Result end
			d1 := "Infinity"
			d2 := d1.sqrt
			Result := d2.to_scientific_string ~ "Infinity"
			check Result end
			d1 := "-Infinity"
			d2 := d1.sqrt
			Result := d2.to_scientific_string ~ "NaN"
			check Result end
			d1 := "asdf"
			d2 := d1.sqrt
			Result := d2.to_scientific_string ~ "NaN"
			check Result end
			d1 := "NaN"
			d2 := d1.sqrt
			Result := d2.to_scientific_string ~ "NaN"
			check Result end
			d1 := "2"
			d2 := d1.sqrt
			Result := d2.to_scientific_string ~ "1.414213562373095048801688724"
			check Result end
			d1 := "9"
			d2 := d1.sqrt
			Result := d2.to_scientific_string ~ "3"
			check Result end
			d1 := "1682.819103"
			d2 := d1.sqrt
			Result := d2 |~ "41.02217818448942381805827691"
			check Result end
			d1 := "3.910E+36"
			d2 := d1.sqrt
			Result := d2 |~ "1977371993328518851.154800230"
			check Result end
			d1 := "0.000000000001527101718"
			d2 := d1.sqrt
			Result := d2 |~ "1.235759571275901548701773452E-6"
			check Result end
			d1 := "9.181E+30"
			d2 := d1.sqrt
			Result := d2 |~ "3030016501605230.532147801"
			check Result end
			d1 := "928.67E-26"
			d2 := d1.sqrt
			Result := d2 |~ "3.047408735302831017334518038E-12"
			check Result end
			d1 := "9.2312313331123E-100"
			d2 := d1.sqrt
			Result := d2 |~ "3.038294148549856915252442729E-50"
			check Result end

			-- 100 Precision
			d1.default_context.set_digits (100)
			d1 := "18291.818283919832981238908891273876178236198273981723091872093810927369871628376198379172893719246801016348716037846178263478012643"
			d2 := d1.sqrt
			Result := d2 |~ "135.2472487110914688467000519844828399713197434206798463107876105820446624801282056335062469021491645"
			check Result end
			d1 := "0.000000000001527101718"
			d2 := d1.sqrt
			Result := d2 |~ "1.23575957127590154870177345178092208849426524094045162858970796824986012889619730246938161709860486E-6"
			check Result end
			d1 := "3030016501605230.532147801"
			d2 := d1.sqrt
			Result := d2 |~ "55045585.66865494376205073651745881927587638824877326905902147146269520050577152570629343606970534112"
			check Result end
			d1 := "9.181E+30"
			d2 := d1.sqrt
			Result := d2 |~ "3030016501605230.532147801000202554609786381885426404782218267785199077659706920471118817741747903163"
			check Result end

			--9 Precision
			d1.default_context.set_digits (9)
			d1 := "1280938190273987987891047"
			d2 := d1.sqrt
			Result := d2 |~ "1.1317854E+12"
			check Result end
			d1 := "52.8E+100"
			d2 := d1.sqrt
			Result := d2 |~ "7.26636085E+50"
			check Result end
			d1 := "0.00000001273"
			d2 := d1.sqrt
			Result := d2 |~ "0.000112827302"
			check Result end
			d1 := "12.1E-50"
			d2 := d1.sqrt
			Result := d2 |~ "3.47850543E-25"
			check Result end
		end

	t2: BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t2: test log10")
			create c.make_default
			d1 := "-0.0000001"
			d2 := d1.log10
			Result := d2.to_scientific_string ~ "NaN"
			check Result end
			d1 := "0"
			d2 := d1.log10
			Result := d2.to_scientific_string ~ "-Infinity"
			check Result end
			d1 := "-Infinity"
			d2 := d1.log10
			Result := d2.to_scientific_string ~ "NaN"
			check Result end
			d1 := "Infinity"
			d2 := d1.log10
			Result := d2.to_scientific_string ~ "Infinity"
			check Result end
			d1 := "NaN"
			d2 := d1.log10
			Result := d2.to_scientific_string ~ "NaN"
			check Result end
			d1 := "ashdf"
			d2 := d1.log10
			Result := d2.to_scientific_string ~ "NaN"
			check Result end
			d1 := "1234.56"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "3.091512201627771681069399777"
			check Result end
			d1 := "0.12"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-0.9208187539523751722774943073"
			check Result end
			d1 := "12345678901234567890"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "19.09151497721269989570648733"
			check Result end
			d1 := "0.25"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-0.6020599913279623904274777894"
			check Result end
			d1 := "0.00000000000012"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-12.92081875395237517227749431"
			check Result end
			d1 := "0.007287"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-2.137451230475207013457398535"
			check Result end
			d1 := "1000"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "3"
			check Result end
			d1 := "0.0002"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-3.698970004336018804786261105"
			check Result end
			d1 := "100.00"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "2"
			check Result end
			d1 := "70"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2  |~ "1.845098040014256830712216259"
			check Result end

--			-- Change precision to 28
			c.set_digits (28)
			d1 := "162.781E+8819"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "8821.211603712121329654650904"
			check Result end
			d1 := "7181.1E-25"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-21.14380902548759112313993463"
			check Result end
			d1 := "0.12"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-0.9208187539523751722774943073"
			check Result end
			d1 := "0.25"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-0.6020599913279623904274777894"
			check Result end
			d1 := "0.00000000000012"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-12.92081875395237517227749431"
			check Result end
			d1 := "0.007287"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-2.137451230475207013457398535"
			check Result end
			d1 := "0.0002"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-3.698970004336018804786261105"
			check Result end
			d1 := "0.0000000005"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-9.301029995663981195213738895"
			check Result end

			--Change precision to 9 digits
			c.set_digits (9)
			d1 := "9.1000"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "0.959041392"
			check Result end
			d1 := "9876.12"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "3.99458636"
			check Result end
			d1 := "10003960.5"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "7.00017197"
			check Result end
			d1 := "1234.56"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "3.09151220"
			check Result end
			d1 := "0.0001"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-4"
			check Result end
			d1 := "9.1000"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "0.959041392"
			check Result end
			d1 := "9876.12"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "3.99458636"
			check Result end
			d1 := "17.1E-1400"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-1398.767"
			check Result end

--			--Change precision to 100 digits
			c.set_digits (100)
			d1.default_context.set_digits (100)
			d1 := "7198347928.172394871239847198237491870347109347198023740917340981634861283467891273480913412739812637896123786198236718926386612783"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "9.857232834208190558788261013783707796776425951539544161886274132468231654143967061351946521969673362"
			check Result end
			d1 := "17892.12678"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "4.252661966834586726135751532812407613654137095265510872306402919674633754619768526986007586303412195"
			check Result end
			d1 := "0.00000000000000000009821"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-19.00784428895738325653425811539885290755553781222653419315041061598968669370138935306344991695691093"
			check Result end
			d1 := "18291.818283919832981238908891273876178236198273981723091872093810927369871628376198379172893719246801016348716037846178263478012643"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "4.262256878326242888417379087297027551710109898337427205247813936999307684816742923874018395040581535"
			check Result end
			d1 := "0.000000000001527101718"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-11.81613203426326262972320724090089549416761929151716336679455906263625434187486497308664541473432082"
			check Result end
			d1 := "3030016501605230.532147801"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "15.48144499369589558523355880995254258589062644205213117833490129721957473871745530151299703137915529"
			check Result end
			d1 := "9.181E+30"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "30.96288998739179117046711761996314977259625737550235405730717102347638510688941955147407173984330556"
			check Result end
			d1 := "72.71E-100"
			d2 := d1.log10_wrt_ctx (c)
			Result := d2 |~ "-98.13840585535613472260322813107688335584576825312277416430328466267780924516388473906235055184306062"
			check Result end

		end

	t3: BOOLEAN

		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment ("t3: test nth_root")
			create ctx.make_default
			d1 := "NaN"
			d2 := "1"
			Result := d1.nth_root (d2) ~ "NaN"
			check Result end
			d1 := "4"
			d2 := "NaN"
			Result := d1.nth_root (d2) ~ "NaN"
			check Result end
			d1 := "Infinity"
			d2 := "1"
			Result := d1.nth_root (d2) ~ "NaN"
			check Result end
			d1 := "4"
			d2 := "Infinity"
			Result := d1.nth_root (d2) ~ "NaN"
			check Result end
			d1 := "-Infinity"
			d2 := "1"
			Result := d1.nth_root (d2) ~ "NaN"
			check Result end
			d1 := "4"
			d2 := "-Infinity"
			Result := d1.nth_root (d2) ~ "NaN"
			check Result end
			d1 := "NaN"
			d2 := "NaN"
			Result := d1.nth_root (d2) ~ "NaN"
			check Result end
			d1 := "-Infinity"
			d2 := "-Infinity"
			Result := d1.nth_root (d2) ~ "NaN"
			check Result end
			d1 := "Infinity"
			d2 := "Infinity"
			Result := d1.nth_root (d2) ~ "NaN"
			check Result end
			d1 := "271.813"
			d2 := "5"
			Result := d1.nth_root (d2) |~ "3.06799074222238672757425488"
			check Result end
			d1 := "0.00172"
			d2 := "7"
			d3 := d1.nth_root (d2)
			Result := d3 |~ "0.4027870437900313644439395821"
			check Result end
			d1 := "27"
			d2 := "3"
			d3 := d1.nth_root_wrt_ctx (d2, ctx)
			Result := d3 |~ "3"
			check Result end
			d1 := "7.1E-18"
			d2 := "9"
			d3 := d1.nth_root_wrt_ctx (d2, ctx)
			Result := d3 |~ "0.0124332383971261902263610716"
			check Result end
		end

note
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT license"
	details: "[
			Originally developed by Jonathan Ostroff, and Moksh Khurana. See class DECIMAL.
		]"
end

