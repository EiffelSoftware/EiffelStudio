note
	description:
		"All the new features are tested here which run slow and require finalizing of the system."

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
			-- Precision to 28.
			-- epsilon to 5.
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
				add_boolean_case (agent t5)
			end
		end

	full_suite
			-- Initialization for `Current'.
	do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			add_boolean_case (agent t6)
			add_boolean_case (agent t7)
			add_boolean_case (agent t8)
			add_boolean_case (agent t9)
			add_boolean_case (agent t10)
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
			comment("t2: Test exp")
			create c.make_default
			d1 := "19.3"
			d2 := d1.exp
			Result := d2 |~ ("240925905.9515892662026647699")
			check Result end
			d1 := "1"
--			d1.default_context.set_digits (9)
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
			Result := d2 |~ ("1628986053413661453565382.76") -- off by 2 ULP
			check Result end
			d1 := "2468932.1819849"
			d2 := d1.exp
			Result := d2 |~ ("4.195941235177984249593274081E+1072243")
			check Result end
			create d1.make_from_string_ctx ("0", c)
			d2 := d1.exp_wrt_ctx (c)
			Result := d2.to_scientific_string ~ "1"
			check Result end
			Result := d2.out_tuple ~ "[0,1,0]"
			check Result end
			create d1.make_from_string_ctx ("1", c)
			d2 := d1.exp_wrt_ctx (c)
			Result := d2.to_scientific_string ~ "2.718281828459045235360287471"
			check Result end
			Result := d2.out_tuple ~ "[0,2718281828459045235360287471,-27]"
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
			Result := d2 |~ ("7960481.134288552652212165787")  -- off by 2 ULP
			check Result end
		    d1 := "55.75"
			d2 := d1.exp
			Result := d2 |~ ("1628986053413661453565382.76")
			check Result end
			d1 := "10467.7118193028"
			d2 := d1.exp
			Result := d2 |~ ("1.173495089569205321166599833E+4546")  -- off by 3 ULP
			check Result end
			d1 := "2468932.1819849"
			d2 := d1.exp
			Result := d2 |~ ("4.195941235177984249593274081E+1072243") -- off by 3 ULP
			check Result end
			d1 := "5.5"
			d2 := d1.exp
			Result := d2 |~ ("244.6919322642203879151889495")
			check Result end
			d1 := "10.5"
			d2 := d1.exp
			Result := d2 |~ ("36315.5026742466377389120269")
			check Result end
			d1 := "42"
			d2 := d1.exp
			Result := d2 |~ ("1739274941520501047.394681304")
			check Result end
			d1 := "19.3"
			d2 := d1.exp
			Result := d2 |~ ("240925905.9515892662026647699")
			check Result end
			d1 := "0.11111"
			d2 := d1.exp
			Result := d2 |~ ("1.117517827054699317325935338")
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
			Result := d2 |~ ("7.22597377E+86")    -- off by 2 ULP
			check Result end
				d1.default_context.set_digits (9)
			d1 := "0.0023"
			d2 := d1.exp
			Result := d2 |~ ("1.00230265")
			check Result end
			d1.default_context.set_digits (9)
			d1 := "1.0"
			d2 := d1.exp
			Result := d2 |~ ("2.71828183")
			check Result end
			d1.default_context.set_digits (9)
			d1 := "14684.78"
			d2 := d1.exp
			Result := d2 |~ ("3.30310183E+6377")  -- off by 3 ULP
			check Result end
			-- IBM Dec Tests Begin
			-- Change Precision to 7
			d1.default_context.set_digits (7)
			d1 := "0.1"
			d2 := d1.exp
			Result := d2 |~ ("1.105171")
			check Result end
			d1 := "0.01"
			d2 := d1.exp
			Result := d2 |~ ("1.010050")
			check Result end
			d1 := "0.001"
			d2 := d1.exp
			Result := d2 |~ ("1.001001")
			check Result end
			d1 := "0.0001"
			d2 := d1.exp
			Result := d2 |~ ("1.000100")
			check Result end
			d1 := "0.00001"
			d2 := d1.exp
			Result := d2 |~ ("1.000010")
			check Result end
			d1 := "0.000001"
			d2 := d1.exp
			Result := d2 |~ ("1.000001")
			check Result end
			d1 := "0.0000001"
			d2 := d1.exp
			Result := d2 |~ ("1.000000")
			check Result end
			d1 := "0.0000003"
			d2 := d1.exp
			Result := d2 |~ ("1.000000")
			check Result end
			d1 := "0.0000004"
			d2 := d1.exp
			Result := d2 |~ ("1.000000") -- off by 2 ULP
			check Result end
			d1 := "0.0000005"
			d2 := d1.exp
			Result := d2 |~ ("1.000001")
			check Result end
			d1 := "0.0000008"
			d2 := d1.exp
			Result := d2 |~ ("1.000001") -- off by 2 ULP
			check Result end
			d1 := "0.0000009"
			d2 := d1.exp
			Result := d2 |~ ("1.000001")
			check Result end
			d1 := "0.0000010"
			d2 := d1.exp
			Result := d2 |~ ("1.000001")
			check Result end
			d1 := "0.0000011"
			d2 := d1.exp
			Result := d2 |~ ("1.000001")
			check Result end
			d1 := "0.00000009"
			d2 := d1.exp
			Result := d2 |~ ("1.000000")
			check Result end
			d1 := "0.00000005"
			d2 := d1.exp
			Result := d2 |~ ("1.000000")
			check Result end
			d1 := "0.00000004"
			d2 := d1.exp
			Result := d2 |~ ("1.000000")
			check Result end
			d1 := "0.00000001"
			d2 := d1.exp
			Result := d2 |~ ("1.000000")
			check Result end
			-- Change precision to 34
			d1.default_context.set_digits (34)
			d1 := "309.5948855821510212996700645087188"
			d2 := d1.exp
			Result := d2 |~ ("2.853319692901387521201738015050724E134") -- off by 3 ULP
			check Result end
			d1 := "9.936543068706211420422803962680164"
			d2 := d1.exp
			Result := d2 |~ ("20672.15839203171877476511093276022")
			check Result end
			d1 := "6.307870323881505684429839491707908"
			d2 := d1.exp
			Result := d2 |~ ("548.8747777054637296137277391754665")
			check Result end
			d1 := "0.0003543281389438420535201308282503"
			d2 := d1.exp
			Result := d2 |~ ("1.000354390920573746164733350843155")
			check Result end
			d1 := "0.0000037087453363918375598394920229"
			d2 := d1.exp
			Result := d2 |~ ("1.000003708752213796324841920189323")
			check Result end
			d1 := "0.0020432312687512438040222444116585"
			d2 := d1.exp
			Result := d2 |~ ("1.002045320088164826013561630975308")
			check Result end
			d1 := "6.856313340032177672550343216129586"
			d2 := d1.exp
			Result := d2 |~ ("949.8587981604144147983589660524396")
			check Result end
			d1 := "0.0049610784722412117632647003545839"
			d2 := d1.exp
			Result := d2 |~ ("1.004973404997901987039589029277833")
			check Result end
			d1 := "0.0000891471883724066909746786702686"
			d2 := d1.exp
			Result := d2 |~ ("1.000089151162101085412780088266699")
			check Result end
			d1 := "08.59979170376061890684723211112566"
			d2 := d1.exp
			Result := d2 |~ ("5430.528314920905714615339273738097")
			check Result end
			d1 := "9.473117039341003854872778112752590"
			d2 := d1.exp
			Result := d2 |~ ("13005.36234331224953460055897913917") -- off by 2 ULP
			check Result end
			d1 := "0.0999060724692207648429969999310118"
			d2 := d1.exp
			Result := d2 |~ ("1.105067116975190602296052700726802")
			check Result end
			d1 := "0.0376578583872889916298772818265677"
			d2 := d1.exp
			Result := d2 |~ ("1.038375900489771946477857818447556")
			check Result end
			d1 := "261.6896411697539524911536116712307"
			d2 := d1.exp
			Result := d2 |~ ("4.470613562127465095241600174941460E113") -- off by 3 ULP
			check Result end
			d1 := "0.0709997423269162980875824213889626"
			d2 := d1.exp
			Result := d2 |~ ("1.073580949235407949417814485533172")
			check Result end
			d1 := "0.0000000444605583295169895235658731"
			d2 := d1.exp
			Result := d2 |~ ("1.000000044460559317887627657593900")
			check Result end
			d1 := "0.0000021224072854777512281369815185"
			d2 := d1.exp
			Result := d2 |~ ("1.000002122409537785687390631070906")
			check Result end
			d1 := "547.5174462574156885473558485475052"
			d2 := d1.exp
			Result := d2 |~ ("6.078629247383807942612114579728672E237") -- off by 3 ULP
			check Result end
			d1 := "0.0000009067598041615192002339844670"
			d2 := d1.exp
			Result := d2 |~ ("1.000000906760215268314680115374387")
			check Result end
			d1 := "0.0316476500308065365803455533244603"
			d2 := d1.exp
			Result := d2 |~ ("1.032153761880187977658387961769034")
			check Result end
			d1 := "84.46160530377645101833996706384473"
			d2 := d1.exp
			Result := d2 |~ ("4.799644995897968383503269871697856E36") -- off by 2 ULP
			check Result end
			d1 := "0.0000000000520599740290848018904145"
			d2 := d1.exp
			Result := d2 |~ ("1.000000000052059974030439922338393")
			check Result end
			d1 := "0.0000006748530640093620665651726708"
			d2 := d1.exp
			Result := d2 |~ ("1.000000674853291722742292331812997")
			check Result end
			d1 := "0.0000000116853119761042020507916169"
			d2 := d1.exp
			Result := d2 |~ ("1.000000011685312044377460306165203")
			check Result end
			d1 := "0.0022593818094258636727616886693280"
			d2 := d1.exp
			Result := d2 |~ ("1.002261936135876893707094845543461")
			check Result end
			d1 := "0.0029398857673478912249856509667517"
			d2 := d1.exp
			Result := d2 |~ ("1.002944211469495086813087651287012")
			check Result end
			d1 := "0.7511480029928802775376270557636963"
			d2 := d1.exp
			Result := d2 |~ ("2.119431734510320169806976569366789")
			check Result end
			d1 := "174.9431952176750671150886423048447"
			d2 := d1.exp
			Result := d2 |~ ("9.481222305374955011464619468044051E75 ")
			check Result end
			d1 := "0.0000810612451694136129199895164424"
			d2 := d1.exp
			Result := d2 |~ ("1.000081064530720924186615149646920")
			check Result end
			d1 := "51.06888989702669288180946272499035"
			d2 := d1.exp
			Result := d2 |~ ("15098613888619165073959.89896018749") -- off by 2 ULP
			check Result end
			d1 := "0.0000000005992887599437093651494510"
			d2 := d1.exp
			Result := d2 |~ ("1.000000000599288760123282874082758")
			check Result end
			d1 := "714.8549046761054856311108828903972"
			d2 := d1.exp
			Result := d2 |~ ("2.867744544891081117381595080480784E310") -- off by 3 ULP
			check Result end
			d1 := "0.0000000004468247802990643645607110"
			d2 := d1.exp
			Result := d2 |~ ("1.000000000446824780398890556720233")
			check Result end
			d1 := "831.5818151589890366323551672043709"
			d2 := d1.exp
			Result := d2 |~ ("1.417077409182624969435938062261655E361") -- off by 4 ULP
			check Result end
			d1 := "0.0000000006868323825179605747108044"
			d2 := d1.exp
			Result := d2 |~ ("1.000000000686832382753829935602454")
			check Result end
			d1 := "0.0000001306740266408976840228440255"
			d2 := d1.exp
			Result := d2 |~ ("1.000000130674035178748675187648098")
			check Result end
			d1 := "0.3182210609022267704811502412335163"
			d2 := d1.exp
			Result := d2 |~ ("1.374680115667798185758927247894859")
			check Result end
			d1 := "0.0147741234179104437440264644295501"
			d2 := d1.exp
			Result := d2 |~ ("1.014883800239950682628277534839222")
			check Result end
			-- Change Precision to 50
			d1.default_context.set_digits (50)
			d1 := "656.35397950590285612266095596539934213943872885728"
			d2 := d1.exp
			Result := d2 |~ ("1.1243757610640319783611178528839652672062820040314E+285") -- off by 3 ULP
			check Result end
			d1 := "0.93620571093652800225038550600780322831236082781471"
			d2 := d1.exp
			Result := d2 |~ ("2.5502865130986176689199711857825771311178046842009")
			check Result end
			d1 := "0.00000000000000008340785856601514714183373874105791"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000000000000834078585660151506202691740252512")
			check Result end
			d1 := "0.00009174057262887789625745574686545163168788456203"
			d2 := d1.exp
			Result := d2 |~ ("1.0000917447809239005146722341251524081006051473273")
			check Result end
			d1 := "33.909116897973797735657751591014926629051117541243"
			d2 := d1.exp
			Result := d2 |~ ("532773181025002.03543618901306726495870476617232229 ")
			check Result end
			d1 := "0.00000740470413004406592124575295278456936809587311"
			d2 := d1.exp
			Result := d2 |~ ("1.0000074047315449333590066395670306135567889210814")
			check Result end
			d1 := "0.00000000000124854922222108802453746922483071445492"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000000012485492222218674621176239911424968263")
			check Result end
			d1 := "4.1793280674155659794286951159430651258356014391382"
			d2 := d1.exp
			Result := d2 |~ ("65.321946520147199404199787811336860087975118278185")
			check Result end
			d1 := "485.43595745460655893746179890255529919221550201686"
			d2 := d1.exp
			Result := d2 |~ ("6.6398403920459617255950476953129377459845366585463E210") -- off by 3 ULP
			check Result end
			d1 := "0.00000000003547259806590856032527875157830328156597"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000000354725980665377129320589406715000685515")
			check Result end
			d1 := "0.00000000000000759621497339104047930616478635042678"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000000000075962149733910693305471257715463887")
			check Result end
			d1 := "9.7959168821760339304571595474480640286072720233796"
			d2 := d1.exp
			Result := d2 |~ ("17960.261146042955179164303653412650751681436352437")
			check Result end
			d1 := "0.00000000566642006258290526783901451194943164535581"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000056664200786370634609832438815665249347650")
			check Result end
			d1 := "741.29888791134298194088827572374718940925820027354"
			d2 := d1.exp
			Result := d2 |~ ("8.7501694006317332808128946666402622432064923198731E321") -- off by 3 ULP
			check Result end
			d1 := "032.75573003552517668808529099897153710887014947935"
			d2 := d1.exp
			Result := d2 |~ ("168125196578678.17725841108617955904425345631092339")
			check Result end
			d1 := "42.333700726429333308594265553422902463737399437644"
			d2 := d1.exp
			Result := d2 |~ ("2428245675864172475.4681119493045657797309369672012")
			check Result end
			d1 := "0.00000000000000559682616876491888197609158802835798"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000000000055968261687649345442076732739577049")
			check Result end
			d1 := "0.00000000000080703688668280193584758300973549486312"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000000008070368866831275901158164321867914342")
			check Result end
			d1 := "640.72396012796509482382712891709072570653606838251"
			d2 := d1.exp
			Result := d2 |~ ("1.8318094990683394229304133068983914236995326891045E278") -- off by 4 ULP
			check Result end
			d1 := "0.00000000000000509458922167631071416948112219512224"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000000000050945892216763236915891499324358556")
			check Result end
			d1 := "6.7670394314315206378625221583973414660727960241395"
			d2 := d1.exp
			Result := d2 |~ ("868.73613012822031367806248697092884415119568271315")
			check Result end
			d1 := "04.823217407412963506638267226891024138054783122548"
			d2 := d1.exp
			Result := d2 |~ ("124.36457929588837129731821077586705505565904205366")
			check Result end
			d1 := "193.51307878701196403991208482520115359690106143615"
			d2 := d1.exp
			Result := d2 |~ ("1.1006830872854715677390914655452261550768957576034E84")
			check Result end
			d1 := "5.7307749038303650539200345901210497015617393970463"
			d2 := d1.exp
			Result := d2 |~ ("308.20800743106843083522721523715645950574866495196")
			check Result end
			d1 := "0.00000000000095217825199797965200541169123743500267"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000000009521782519984329737172007991390381273")
			check Result end
			d1 := "0.00027131440949183370966393682617930153495028919140"
			d2 := d1.exp
			Result := d2 |~ ("1.0002713512185751022906058160480606598754913607364")
			check Result end
			d1 := "0.00000000064503059114680682343002315662069272707123"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000006450305913548390552323517403613135496633")
			check Result end
			d1 := "0.00000000000000095616643506527288866235238548440593"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000000000009561664350652733457894781582009094")
			check Result end
			d1 := "0.00000000000000086449942811678650244459550252743433"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000000000008644994281167868761242261096529986")
			check Result end
			d1 := "0.06223488355635359965683053157729204988381887621850"
			d2 := d1.exp
			Result := d2 |~ ("1.0642122813392406657789688931838919323826250630831")
			check Result end
			d1 := "0.00000400710807804429435502657131912308680674057053"
			d2 := d1.exp
			Result := d2 |~ ("1.0000040071161065125925620890019319832127863559260")
			check Result end
			d1 := "85.522796894744576211573232055494551429297878413017"
			d2 := d1.exp
			Result := d2 |~ ("13870073686404228452757799770251085177.853337368935")
			check Result end
			d1 := "9.1496720811363678696938036379756663548353399954363"
			d2 := d1.exp
			Result := d2 |~ ("9411.3537122832743386783597629161763057370034495157")
			check Result end
			d1 := "8.2215705240788294472944382056330516738577785177942"
			d2 := d1.exp
			Result := d2 |~ ("3720.3406813383076953899654701615084425598377758189")
			check Result end
			d1 := "0.0000000001577206456964061314282320372682107623956"
			d2 := d1.exp
			Result := d2 |~ ("1.0000000001577206457088440324683315788358926129830")
			check Result end
			d1 := "0.58179346473959531432624153576883440625538017532480"
			d2 := d1.exp
			Result := d2 |~ ("1.7892445018275360163797022372655837188423194863605")
			check Result end
			d1 := "33.555726197149525061455517784870570470833498096559"
			d2 := d1.exp
			Result := d2 |~ ("374168069896324.62578073148993526626307095854407952")
			check Result end
			d1 := "89.157697327174521542502447953032536541038636966347"
			d2 := d1.exp
			Result := d2 |~ ("525649152320166503771224149330448089550.67293829227")
			check Result end
			d1 := "25.022947600123328912029051897171319573322888514885"
			d2 := d1.exp
			Result := d2 |~ ("73676343442.952517824345431437683153304645851960524")
			check Result end
			-- Change Precision to 16
			d1.default_context.set_digits (16)
			d1 := "8.473011527013724"
			d2 := d1.exp
			Result := d2 |~ ("4783.900643969246")
			check Result end
			d1 := "0.0000055753022764"
			d2 := d1.exp
			Result := d2 |~ ("1.000005575317818")
			check Result end
			d1 := "0.0000323474114482"
			d2 := d1.exp
			Result := d2 |~ ("1.000032347934631")
			check Result end
			d1 := "64.54374138544166"
			d2 := d1.exp
			Result := d2 |~ ("1.073966476173531E28")
			check Result end
			d1 := "90.47203246416569"
			d2 := d1.exp
			Result := d2 |~ ("1.956610887250643E39")
			check Result end
			d1 := "9.299931532342757 "
			d2 := d1.exp
			Result := d2 |~ ("10937.27033325227")
			check Result end
			d1 := "8.759678437852203"
			d2 := d1.exp
			Result := d2 |~ ("6372.062234495381")
			check Result end
			d1 := "0.0000931755127172 "
			d2 := d1.exp
			Result := d2 |~ ("1.000093179853690")
			check Result end
			d1 := "0.0000028101158373 "
			d2 := d1.exp
			Result := d2 |~ ("1.000002810119786")
			check Result end
			d1 := "0.0000008008130919 "
			d2 := d1.exp
			Result := d2 |~ ("1.000000800813413")
			check Result end
			d1 := "8.339771722299049 "
			d2 := d1.exp
			Result := d2 |~ ("4187.133803081878")
			check Result end
			d1 := "0.0026140497995474 "
			d2 := d1.exp
			Result := d2 |~ ("1.002617469406750")
			check Result end
			d1 := "0.7478033356261771 "
			d2 := d1.exp
			Result := d2 |~ ("2.112354781975418")
			check Result end
			d1 := "51.77663761827966 "
			d2 := d1.exp
			Result := d2 |~ ("3.064135801120365E22") -- off by 2 ULP
			check Result end
			d1 := "0.1524989783061012 "
			d2 := d1.exp
			Result := d2 |~ ("1.164741272084955")
			check Result end
			d1 := "0.0066298798669219 "
			d2 := d1.exp
			Result := d2 |~ ("1.006651906170791")
			check Result end
			d1 := "9.955141865534960 "
			d2 := d1.exp
			Result := d2 |~ ("21060.23334287038")
			check Result end
			d1 := "92.34503059198483 "
			d2 := d1.exp
			Result := d2 |~ ("1.273318993481226E40") -- off by 2 ULP
			check Result end
			d1 := "9.299931532342757 "
			d2 := d1.exp
			Result := d2 |~ ("10937.27033325227")
			check Result end
			d1 := "0.0000709388677346 "
			d2 := d1.exp
			Result := d2 |~ ("1.000070941383956")
			check Result end
			d1 := "79.12883036433204 "
			d2 := d1.exp
			Result := d2 |~ ("2.318538899389243E34")
			check Result end
			d1 := "0.0000090881548873"
			d2 := d1.exp
			Result := d2 |~ ("1.000009088196185")
			check Result end
			d1 := "0.0424828809603411 "
			d2 := d1.exp
			Result := d2 |~ ("1.043398194245720")
			check Result end
			d1 := "0.8009035891427416"
			d2 := d1.exp
			Result := d2 |~ ("2.227552811933310")
			check Result end
			d1 := "8.825786167283102 "
			d2 := d1.exp
			Result := d2 |~ ("6807.540455289995")
			check Result end
			d1 := "1.535457249746275 "
			d2 := d1.exp
			Result := d2 |~ ("4.643448260146849")
			check Result end
			d1 := "69.02254254355800 "
			d2 := d1.exp
			Result := d2 |~ ("9.464754500670653E29")
			check Result end
			d1 := "0.0007050554368713"
			d2 := d1.exp
			Result := d2 |~ ("1.000705304046880")
			check Result end
			d1 := "0.0000081206549504 "
			d2 := d1.exp
			Result := d2 |~ ("1.000008120687923")
			check Result end
			d1 := "0.621774854641137 "
			d2 := d1.exp
			Result := d2 |~ (" 1.862230298554903")
			check Result end
			d1 := "3.847629031404354 "
			d2 := d1.exp
			Result := d2 |~ ("46.88177613568203")
			check Result end
			d1 := "24.81250184697732  "
			d2 := d1.exp
			Result := d2 |~ ("59694268456.19966")
			check Result end
			d1 := "5.107546500516044"
			d2 := d1.exp
			Result := d2 |~ ("165.2643809755670")
			check Result end
			d1 := "79.17810943951986 "
			d2 := d1.exp
			Result := d2 |~ ("2.435656372541360E34") -- off by 2 ULP
			check Result end
			d1 := "0.0051394695667015 "
			d2 := d1.exp
			Result := d2 |~ ("1.005152699295301")
			check Result end
			d1 := "57.44504488501725 "
			d2 := d1.exp
			Result := d2 |~ ("8.872908566929688E24") -- off by 2 ULP
			check Result end
			d1 := "0.0000508388968036 "
			d2 := d1.exp
			Result := d2 |~ ("1.000050840189122")
			check Result end
			d1 := "69.71309932148997 "
			d2 := d1.exp
			Result := d2 |~ ("1.888053740693541E30")
			check Result end
			d1 := "0.0064183412981502 "
			d2 := d1.exp
			Result := d2 |~ ("1.006438982988835")
			check Result end
			d1 := "9.346991220814677 "
			d2 := d1.exp
			Result := d2 |~ ("11464.27802035082")
			check Result end
			d1 := "33.09087139999152 "
			d2 := d1.exp
			Result := d2 |~ ("235062229168763.5")
			check Result end
			-- change precision to 7
			d1.default_context.set_digits (7)
			d1 := "2.395441"
			d2 := d1.exp
			Result := d2 |~ ("10.97304")
			check Result end
			d1 := "0.6406779"
			d2 := d1.exp
			Result := d2 |~ ("1.897767")
			check Result end
			d1 := "0.5618218"
			d2 := d1.exp
			Result := d2 |~ ("1.753865")
			check Result end
			d1 := "3.055120"
			d2 := d1.exp
			Result := d2 |~ ("21.22373")
			check Result end
			d1 := "1.536792"
			d2 := d1.exp
			Result := d2 |~ ("4.649650")
			check Result end
			d1 := "0.0801591"
			d2 := d1.exp
			Result := d2 |~ ("1.083459")
			check Result end
			d1 := "0.0966875"
			d2 := d1.exp
			Result := d2 |~ ("1.101516")
			check Result end
			d1 := "0.0646761"
			d2 := d1.exp
			Result := d2 |~ ("1.066813")
			check Result end
			d1 := "0.0095670"
			d2 := d1.exp
			Result := d2 |~ ("1.009613")
			check Result end
			d1 := "2.956859"
			d2 := d1.exp
			Result := d2 |~ ("19.23745")
			check Result end
			d1 := "7.504679"
			d2 := d1.exp
			Result := d2 |~ ("1816.522")
			check Result end
			d1 := "0.0045259"
			d2 := d1.exp
			Result := d2 |~ ("1.004536")
			check Result end
			d1 := "3.810071"
			d2 := d1.exp
			Result := d2 |~ ("45.15364") -- off by 2 ULP
			check Result end
			d1 := "1.502390"
			d2 := d1.exp
			Result := d2 |~ ("4.492413")
			check Result end
			d1 := "0.0321523"
			d2 := d1.exp
			Result := d2 |~ ("1.032675")
			check Result end
			d1 := "0.0057214"
			d2 := d1.exp
			Result := d2 |~ ("1.005738")
			check Result end
			d1 := "9.811445"
			d2 := d1.exp
			Result := d2 |~ ("18241.33")
			check Result end
			d1 := "3.245249"
			d2 := d1.exp
			Result := d2 |~ ("25.66810")
			check Result end
			d1 := "0.3189742"
			d2 := d1.exp
			Result := d2 |~ ("1.375716")
			check Result end
			d1 := "0.8621610"
			d2 := d1.exp
			Result := d2 |~ ("2.368273")
			check Result end
			d1 := "0.0122511"
			d2 := d1.exp
			Result := d2 |~ ("1.012326")
			check Result end
			d1 := "2.202088"
			d2 := d1.exp
			Result := d2 |~ ("9.043877")
			check Result end
			d1 := "8.778203"
			d2 := d1.exp
			Result := d2 |~ ("6491.202") -- off by 2 ULP
			d1 := "0.1896279"
			d2 := d1.exp
			Result := d2 |~ ("1.208800")
			d1 := "0.4510947"
			d2 := d1.exp
			Result := d2 |~ ("1.570030")
			d1 := "0.276413"
			d2 := d1.exp
			Result := d2 |~ ("1.318392")
			d1 := "4.490067"
			d2 := d1.exp
			Result := d2 |~ ("1.753865")
			d1 := "0.5618218"
			d2 := d1.exp
			Result := d2 |~ ("89.12742")
			d1 := "0.0439786"
			d2 := d1.exp
			Result := d2 |~ ("1.044960")
			d1 := "0.8168245"
			d2 := d1.exp
			Result := d2 |~ ("2.263301")
			d1 := "0.0391658"
			d2 := d1.exp
			Result := d2 |~ ("1.039943")
			d1 := "9.261816"
			d2 := d1.exp
			Result := d2 |~ ("10528.24")
			d1 := "9.611186"
			d2 := d1.exp
			Result := d2 |~ ("14930.87")
			d1 := "9.118125"
			d2 := d1.exp
			Result := d2 |~ ("9119.087")
			check Result end
			d1 := "9.469083"
			d2 := d1.exp
			Result := d2 |~ ("12953.00")
			check Result end
			d1 := "0.0499983"
			d2 := d1.exp
			Result := d2 |~ ("1.051269")
			check Result end
			d1 := "0.0050746"
			d2 := d1.exp
			Result := d2 |~ ("1.005087")
			check Result end
			d1 := "0.0014696"
			d2 := d1.exp
			Result := d2 |~ ("1.001471") -- off by 2 ULP
			check Result end
			d1 := "9.138494"
			d2 := d1.exp
			Result := d2 |~ ("9306.739")
			check Result end
			d1 := "0.0065436"
			d2 := d1.exp
			Result := d2 |~ ("1.006565")
			check Result end
			d1 := "0.7284803"
			d2 := d1.exp
			Result := d2 |~ ("2.071930")
			check Result end
			-- Change precision to 40
			d1.default_context.set_digits (40)
			d1 := "1.2"
			d2 := d1.exp
			Result := d2 |~ ("3.320116922736547489530767429601644320074")
			check Result end
			d1 := "0.00000121"
			d2 := d1.exp
			Result := d2 |~ ("1.000001210000732050295260255982888697858") -- off by 2 ULP
			check Result end
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
			Result := d2 |~ ("2.96762838402366706896629680528947009056986046017072782713629019382661490260609722025271069451017557E+2171") -- off by 5 ULP
			check Result end
			d1.default_context.set_digits (100)
			d1 := "350"
			d2 := d1.exp
			Result := d2 |~ ("1.007090887028079759823375862957008934750807691523463949591733165265104584422741902386611822721170146e152") -- off by 4 ULP
			check Result end
			d1.default_context.set_digits (100)
			d1 := "40.8675"
			d2 := d1.exp
			Result := d2 |~ ("560440793351738556.6375023298501116747558018595398419884517821051716081305064300592310541992771159926")
			check Result end
			d1.default_context.set_digits (100)
			d1 := "0.0000023"
			d2 := d1.exp
			Result := d2 |~ ("1.000002300002645002027834499338036362122272135611635434277106600186640759357295809240614694694330455")
			check Result end
			d1.default_context.set_digits (100)
			d1 := "90.1234567"
			d2 := d1.exp
			Result := d2 |~ ("1380765524457469385762746703256674401055.406886634257806066991329784602427246104288854000271725913621")
			check Result end
			d1.default_context.set_digits (100)
			d1 := "12345.678910"
			d2 := d1.exp
			Result := d2 |~ ("4.573260733575855081791110241330996171100345291391873010919078267432259432242052552994285819844043374E+5361") -- off by 3 ULP
		    check Result end
		end

	t3:	BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t3: Test log2")
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
			comment("t4:  Test 40 bit precision")
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

	t5: BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t5:  Test Sin function")
			-- default is 28 bits
			create c.make_default
			d1 := "20"
			d2 := d1.sin
			Result := d2 |~ "0.3420201433256687330440996146"
			check Result end
			d1 := "9"
			d2 := d1.sin
			Result := d2 |~ "0.1564344650402308690101053195"
			check Result end
			d1 := "120"
			d2 := d1.sin
			Result := d2 |~ "0.8660254037844386467637231712"
			check Result end
			d1 := "80.56"
			d2 := d1.sin
			Result := d2 |~ "0.9864578981627842106923167631"
			check Result end
			d1 := "170"
			d2 := d1.sin
			Result := d2 |~ "0.1736481776669303488517166267"
			check Result end
			d1 := "1.223"
			d2 := d1.sin
			Result := d2 |~ "0.02134375587388299411614010254"
			check Result end
			d1 := "0.6854"
			d2 := d1.sin
			Result := d2 |~ "0.01196220138773391958717928805"
			check Result end
			d1 := "100"
			d2 := d1.sin
			Result := d2 |~ "0.9848077530122080593667430246"
			check Result end
			d1 := "100.5"
			d2 := d1.sin
			Result := d2 |~ "0.9832549075639545845546320564"
			check Result end
		end

	t6: BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t6:  Test Cos Function")
			-- default is 28 bits
			create c.make_default
			d1 := "20"
			d2 := d1.cos
			Result := d2 |~ "0.9396926207859083840541092774"
			check Result end
			d1 := "9"
			d2 := d1.cos
			Result := d2 |~ "0.9876883405951377261900402477"
			check Result end
			d1 := "110"
			d2 := d1.cos
			Result := d2 |~ "-0.342020143325668733044099614"
			check Result end
			d1 := "80.56"
			d2 := d1.cos
			Result := d2 |~ "0.1640146796852710234845537435"
			check Result end
			d1 := "180"
			d2 := d1.cos
			Result := d2 |~ "-1"
			check Result end
			d1 := "1.223"
			d2 := d1.cos
			Result := d2 |~ "0.9997721960952885416994962794"
			check Result end
			d1 := "0.6854"
			d2 := d1.cos
			Result := d2 |~ "0.9999284503093005287492101256"
			check Result end
			d1 := "100"
			d2 := d1.cos
			Result := d2 |~ "-0.173648177666930348851716626"
			check Result end
			d1 := "100.5"
			d2 := d1.cos
			Result := d2 |~ "-0.182235525492147456602573371"
			check Result end
		end

	t7: BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t7:  Test Tan Function")
			-- default is 28 bits
			create c.make_default
			d1 := "20"
			d2 := d1.tan
			Result := d2 |~ "0.3639702342662023613510478827"
			check Result end
			d1 := "9"
			d2 := d1.tan
			Result := d2 |~ "0.1583844403245362938388830927"
			check Result end
			d1 := "110"
			d2 := d1.tan
			Result := d2 |~ "-2.747477419454622278761664032"
			check Result end
			d1 := "80.56"
			d2 := d1.tan
			Result := d2 |~ "6.014448828944491645080433734"
			check Result end
			d1 := "170"
			d2 := d1.tan
			Result := d2 |~ "-0.1763269807084649734710903867"
			check Result end
			d1 := "1.223"
			d2 := d1.tan
			Result := d2 |~ "0.02134861917269073096715373754"
			check Result end
			d1 := "0.6854"
			d2 := d1.tan
			Result := d2 |~ "0.01196305734078647289835278950"
			check Result end
			d1 := "100"
			d2 := d1.tan
			Result := d2 |~ "-5.671281819617709530994418465"
			check Result end
		end

	t8: BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t8:  Test Cot Function")
			-- default is 28 bits
			create c.make_default
			d1 := "20"
			d2 := d1.cot
			Result := d2 |~ "2.747477419454622278761664027"
			check Result end
			d1 := "9"
			d2 := d1.cot
			Result := d2 |~ "6.313751514675043098979464243"
			check Result end
			d1 := "110"
			d2 := d1.cot
			Result := d2 |~ "-0.3639702342662023613510478821"
			check Result end
			d1 := "80.56"
			d2 := d1.cot
			Result := d2 |~ "0.1662662745067357139495706097"
			check Result end
		end

		t9: BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t9:  Test Sec Function")
			-- default is 28 bits
			create c.make_default
			d1 := "20"
			d2 := d1.sec
			Result := d2 |~ "1.064177772475912140809570602"
			check Result end
			d1 := "9"
			d2 := d1.sec
			Result := d2 |~ "1.012465125788002931361743983"
			check Result end
			d1 := "110"
			d2 := d1.sec
			Result := d2 |~ "-2.923804400163087252232754419"
			check Result end
			d1 := "80.56"
			d2 := d1.sec
			Result := d2 |~ "6.097015230093473115738218397"
			check Result end
		end

	t10: BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t10:  Test Csc Function")
			-- default is 28 bits
			create c.make_default
			d1 := "20"
			d2 := d1.csc
			Result := d2 |~ "2.923804400163087252232754414"
			check Result end
			d1 := "9"
			d2 := d1.csc
			Result := d2 |~ "6.392453221499661547042215733"
			check Result end
			d1 := "110"
			d2 := d1.csc
			Result := d2 |~ "1.064177772475912140809570603"
			check Result end
			d1 := "80.56"
			d2 := d1.csc
			Result := d2 |~ "1.013728007918469812255785957"
			check Result end
		end

note
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	copyright: "Copyright (c) 2017 Eiffel Software."
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
	details: "[
			See class DECIMAL.
			Originally developed by Jonathan Ostroff, Moksh Khurana, and Alex Fevga.
			Revised by Alexander Kogtenkov.
		]"

end
