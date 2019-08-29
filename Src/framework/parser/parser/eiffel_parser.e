note

	description: "Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_PARSER

inherit

	EIFFEL_PARSER_SKELETON

create
	make,
	make_with_factory

feature {NONE} -- Implementation

	yy_build_parser_tables
			-- Build parser tables.
		do
			yytranslate := yytranslate_template
			yyr1 := yyr1_template
			yytypes1 := yytypes1_template
			yytypes2 := yytypes2_template
			yydefact := yydefact_template
			yydefgoto := yydefgoto_template
			yypact := yypact_template
			yypgoto := yypgoto_template
			yytable := yytable_template
			yycheck := yycheck_template
		end

	yy_create_value_stacks
			-- Create value stacks.
		do
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
			create yyspecial_routines3
			yyvsc3 := yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.make (yyvsc3)
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
			create yyspecial_routines8
			yyvsc8 := yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.make (yyvsc8)
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
			create yyspecial_routines10
			yyvsc10 := yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.make (yyvsc10)
			create yyspecial_routines11
			yyvsc11 := yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.make (yyvsc11)
			create yyspecial_routines12
			yyvsc12 := yyInitial_yyvs_size
			yyvs12 := yyspecial_routines12.make (yyvsc12)
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
			create yyspecial_routines14
			yyvsc14 := yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.make (yyvsc14)
			create yyspecial_routines15
			yyvsc15 := yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.make (yyvsc15)
			create yyspecial_routines16
			yyvsc16 := yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.make (yyvsc16)
			create yyspecial_routines17
			yyvsc17 := yyInitial_yyvs_size
			yyvs17 := yyspecial_routines17.make (yyvsc17)
			create yyspecial_routines18
			yyvsc18 := yyInitial_yyvs_size
			yyvs18 := yyspecial_routines18.make (yyvsc18)
			create yyspecial_routines19
			yyvsc19 := yyInitial_yyvs_size
			yyvs19 := yyspecial_routines19.make (yyvsc19)
			create yyspecial_routines20
			yyvsc20 := yyInitial_yyvs_size
			yyvs20 := yyspecial_routines20.make (yyvsc20)
			create yyspecial_routines21
			yyvsc21 := yyInitial_yyvs_size
			yyvs21 := yyspecial_routines21.make (yyvsc21)
			create yyspecial_routines22
			yyvsc22 := yyInitial_yyvs_size
			yyvs22 := yyspecial_routines22.make (yyvsc22)
			create yyspecial_routines23
			yyvsc23 := yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.make (yyvsc23)
			create yyspecial_routines24
			yyvsc24 := yyInitial_yyvs_size
			yyvs24 := yyspecial_routines24.make (yyvsc24)
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
			create yyspecial_routines28
			yyvsc28 := yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.make (yyvsc28)
			create yyspecial_routines29
			yyvsc29 := yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.make (yyvsc29)
			create yyspecial_routines30
			yyvsc30 := yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.make (yyvsc30)
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
			create yyspecial_routines33
			yyvsc33 := yyInitial_yyvs_size
			yyvs33 := yyspecial_routines33.make (yyvsc33)
			create yyspecial_routines34
			yyvsc34 := yyInitial_yyvs_size
			yyvs34 := yyspecial_routines34.make (yyvsc34)
			create yyspecial_routines35
			yyvsc35 := yyInitial_yyvs_size
			yyvs35 := yyspecial_routines35.make (yyvsc35)
			create yyspecial_routines36
			yyvsc36 := yyInitial_yyvs_size
			yyvs36 := yyspecial_routines36.make (yyvsc36)
			create yyspecial_routines37
			yyvsc37 := yyInitial_yyvs_size
			yyvs37 := yyspecial_routines37.make (yyvsc37)
			create yyspecial_routines38
			yyvsc38 := yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.make (yyvsc38)
			create yyspecial_routines39
			yyvsc39 := yyInitial_yyvs_size
			yyvs39 := yyspecial_routines39.make (yyvsc39)
			create yyspecial_routines40
			yyvsc40 := yyInitial_yyvs_size
			yyvs40 := yyspecial_routines40.make (yyvsc40)
			create yyspecial_routines41
			yyvsc41 := yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.make (yyvsc41)
			create yyspecial_routines42
			yyvsc42 := yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.make (yyvsc42)
			create yyspecial_routines43
			yyvsc43 := yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.make (yyvsc43)
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
			create yyspecial_routines46
			yyvsc46 := yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.make (yyvsc46)
			create yyspecial_routines47
			yyvsc47 := yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.make (yyvsc47)
			create yyspecial_routines48
			yyvsc48 := yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.make (yyvsc48)
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
			create yyspecial_routines51
			yyvsc51 := yyInitial_yyvs_size
			yyvs51 := yyspecial_routines51.make (yyvsc51)
			create yyspecial_routines52
			yyvsc52 := yyInitial_yyvs_size
			yyvs52 := yyspecial_routines52.make (yyvsc52)
			create yyspecial_routines53
			yyvsc53 := yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.make (yyvsc53)
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
			create yyspecial_routines56
			yyvsc56 := yyInitial_yyvs_size
			yyvs56 := yyspecial_routines56.make (yyvsc56)
			create yyspecial_routines57
			yyvsc57 := yyInitial_yyvs_size
			yyvs57 := yyspecial_routines57.make (yyvsc57)
			create yyspecial_routines58
			yyvsc58 := yyInitial_yyvs_size
			yyvs58 := yyspecial_routines58.make (yyvsc58)
			create yyspecial_routines59
			yyvsc59 := yyInitial_yyvs_size
			yyvs59 := yyspecial_routines59.make (yyvsc59)
			create yyspecial_routines60
			yyvsc60 := yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.make (yyvsc60)
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
			create yyspecial_routines63
			yyvsc63 := yyInitial_yyvs_size
			yyvs63 := yyspecial_routines63.make (yyvsc63)
			create yyspecial_routines64
			yyvsc64 := yyInitial_yyvs_size
			yyvs64 := yyspecial_routines64.make (yyvsc64)
			create yyspecial_routines65
			yyvsc65 := yyInitial_yyvs_size
			yyvs65 := yyspecial_routines65.make (yyvsc65)
			create yyspecial_routines66
			yyvsc66 := yyInitial_yyvs_size
			yyvs66 := yyspecial_routines66.make (yyvsc66)
			create yyspecial_routines67
			yyvsc67 := yyInitial_yyvs_size
			yyvs67 := yyspecial_routines67.make (yyvsc67)
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
			create yyspecial_routines70
			yyvsc70 := yyInitial_yyvs_size
			yyvs70 := yyspecial_routines70.make (yyvsc70)
			create yyspecial_routines71
			yyvsc71 := yyInitial_yyvs_size
			yyvs71 := yyspecial_routines71.make (yyvsc71)
			create yyspecial_routines72
			yyvsc72 := yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.make (yyvsc72)
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
			create yyspecial_routines74
			yyvsc74 := yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.make (yyvsc74)
			create yyspecial_routines75
			yyvsc75 := yyInitial_yyvs_size
			yyvs75 := yyspecial_routines75.make (yyvsc75)
			create yyspecial_routines76
			yyvsc76 := yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.make (yyvsc76)
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
			create yyspecial_routines80
			yyvsc80 := yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.make (yyvsc80)
			create yyspecial_routines81
			yyvsc81 := yyInitial_yyvs_size
			yyvs81 := yyspecial_routines81.make (yyvsc81)
			create yyspecial_routines82
			yyvsc82 := yyInitial_yyvs_size
			yyvs82 := yyspecial_routines82.make (yyvsc82)
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
			create yyspecial_routines84
			yyvsc84 := yyInitial_yyvs_size
			yyvs84 := yyspecial_routines84.make (yyvsc84)
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
			create yyspecial_routines86
			yyvsc86 := yyInitial_yyvs_size
			yyvs86 := yyspecial_routines86.make (yyvsc86)
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
			create yyspecial_routines88
			yyvsc88 := yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.make (yyvsc88)
			create yyspecial_routines89
			yyvsc89 := yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.make (yyvsc89)
			create yyspecial_routines90
			yyvsc90 := yyInitial_yyvs_size
			yyvs90 := yyspecial_routines90.make (yyvsc90)
			create yyspecial_routines91
			yyvsc91 := yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.make (yyvsc91)
			create yyspecial_routines92
			yyvsc92 := yyInitial_yyvs_size
			yyvs92 := yyspecial_routines92.make (yyvsc92)
			create yyspecial_routines93
			yyvsc93 := yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.make (yyvsc93)
			create yyspecial_routines94
			yyvsc94 := yyInitial_yyvs_size
			yyvs94 := yyspecial_routines94.make (yyvsc94)
			create yyspecial_routines95
			yyvsc95 := yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.make (yyvsc95)
			create yyspecial_routines96
			yyvsc96 := yyInitial_yyvs_size
			yyvs96 := yyspecial_routines96.make (yyvsc96)
			create yyspecial_routines97
			yyvsc97 := yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.make (yyvsc97)
			create yyspecial_routines98
			yyvsc98 := yyInitial_yyvs_size
			yyvs98 := yyspecial_routines98.make (yyvsc98)
			create yyspecial_routines99
			yyvsc99 := yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.make (yyvsc99)
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
			create yyspecial_routines101
			yyvsc101 := yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.make (yyvsc101)
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
			create yyspecial_routines104
			yyvsc104 := yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.make (yyvsc104)
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
			create yyspecial_routines106
			yyvsc106 := yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.make (yyvsc106)
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
			create yyspecial_routines109
			yyvsc109 := yyInitial_yyvs_size
			yyvs109 := yyspecial_routines109.make (yyvsc109)
			create yyspecial_routines110
			yyvsc110 := yyInitial_yyvs_size
			yyvs110 := yyspecial_routines110.make (yyvsc110)
			create yyspecial_routines111
			yyvsc111 := yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.make (yyvsc111)
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
			create yyspecial_routines113
			yyvsc113 := yyInitial_yyvs_size
			yyvs113 := yyspecial_routines113.make (yyvsc113)
			create yyspecial_routines114
			yyvsc114 := yyInitial_yyvs_size
			yyvs114 := yyspecial_routines114.make (yyvsc114)
			create yyspecial_routines115
			yyvsc115 := yyInitial_yyvs_size
			yyvs115 := yyspecial_routines115.make (yyvsc115)
			create yyspecial_routines116
			yyvsc116 := yyInitial_yyvs_size
			yyvs116 := yyspecial_routines116.make (yyvsc116)
			create yyspecial_routines117
			yyvsc117 := yyInitial_yyvs_size
			yyvs117 := yyspecial_routines117.make (yyvsc117)
			create yyspecial_routines118
			yyvsc118 := yyInitial_yyvs_size
			yyvs118 := yyspecial_routines118.make (yyvsc118)
			create yyspecial_routines119
			yyvsc119 := yyInitial_yyvs_size
			yyvs119 := yyspecial_routines119.make (yyvsc119)
			create yyspecial_routines120
			yyvsc120 := yyInitial_yyvs_size
			yyvs120 := yyspecial_routines120.make (yyvsc120)
			create yyspecial_routines121
			yyvsc121 := yyInitial_yyvs_size
			yyvs121 := yyspecial_routines121.make (yyvsc121)
			create yyspecial_routines122
			yyvsc122 := yyInitial_yyvs_size
			yyvs122 := yyspecial_routines122.make (yyvsc122)
			create yyspecial_routines123
			yyvsc123 := yyInitial_yyvs_size
			yyvs123 := yyspecial_routines123.make (yyvsc123)
			create yyspecial_routines124
			yyvsc124 := yyInitial_yyvs_size
			yyvs124 := yyspecial_routines124.make (yyvsc124)
			create yyspecial_routines125
			yyvsc125 := yyInitial_yyvs_size
			yyvs125 := yyspecial_routines125.make (yyvsc125)
			create yyspecial_routines126
			yyvsc126 := yyInitial_yyvs_size
			yyvs126 := yyspecial_routines126.make (yyvsc126)
			create yyspecial_routines127
			yyvsc127 := yyInitial_yyvs_size
			yyvs127 := yyspecial_routines127.make (yyvsc127)
			create yyspecial_routines128
			yyvsc128 := yyInitial_yyvs_size
			yyvs128 := yyspecial_routines128.make (yyvsc128)
			create yyspecial_routines129
			yyvsc129 := yyInitial_yyvs_size
			yyvs129 := yyspecial_routines129.make (yyvsc129)
			create yyspecial_routines130
			yyvsc130 := yyInitial_yyvs_size
			yyvs130 := yyspecial_routines130.make (yyvsc130)
			create yyspecial_routines131
			yyvsc131 := yyInitial_yyvs_size
			yyvs131 := yyspecial_routines131.make (yyvsc131)
			create yyspecial_routines132
			yyvsc132 := yyInitial_yyvs_size
			yyvs132 := yyspecial_routines132.make (yyvsc132)
		end

	yy_init_value_stacks
			-- Initialize value stacks.
		do
			yyvsp1 := -1
			yyvsp2 := -1
			yyvsp3 := -1
			yyvsp4 := -1
			yyvsp5 := -1
			yyvsp6 := -1
			yyvsp7 := -1
			yyvsp8 := -1
			yyvsp9 := -1
			yyvsp10 := -1
			yyvsp11 := -1
			yyvsp12 := -1
			yyvsp13 := -1
			yyvsp14 := -1
			yyvsp15 := -1
			yyvsp16 := -1
			yyvsp17 := -1
			yyvsp18 := -1
			yyvsp19 := -1
			yyvsp20 := -1
			yyvsp21 := -1
			yyvsp22 := -1
			yyvsp23 := -1
			yyvsp24 := -1
			yyvsp25 := -1
			yyvsp26 := -1
			yyvsp27 := -1
			yyvsp28 := -1
			yyvsp29 := -1
			yyvsp30 := -1
			yyvsp31 := -1
			yyvsp32 := -1
			yyvsp33 := -1
			yyvsp34 := -1
			yyvsp35 := -1
			yyvsp36 := -1
			yyvsp37 := -1
			yyvsp38 := -1
			yyvsp39 := -1
			yyvsp40 := -1
			yyvsp41 := -1
			yyvsp42 := -1
			yyvsp43 := -1
			yyvsp44 := -1
			yyvsp45 := -1
			yyvsp46 := -1
			yyvsp47 := -1
			yyvsp48 := -1
			yyvsp49 := -1
			yyvsp50 := -1
			yyvsp51 := -1
			yyvsp52 := -1
			yyvsp53 := -1
			yyvsp54 := -1
			yyvsp55 := -1
			yyvsp56 := -1
			yyvsp57 := -1
			yyvsp58 := -1
			yyvsp59 := -1
			yyvsp60 := -1
			yyvsp61 := -1
			yyvsp62 := -1
			yyvsp63 := -1
			yyvsp64 := -1
			yyvsp65 := -1
			yyvsp66 := -1
			yyvsp67 := -1
			yyvsp68 := -1
			yyvsp69 := -1
			yyvsp70 := -1
			yyvsp71 := -1
			yyvsp72 := -1
			yyvsp73 := -1
			yyvsp74 := -1
			yyvsp75 := -1
			yyvsp76 := -1
			yyvsp77 := -1
			yyvsp78 := -1
			yyvsp79 := -1
			yyvsp80 := -1
			yyvsp81 := -1
			yyvsp82 := -1
			yyvsp83 := -1
			yyvsp84 := -1
			yyvsp85 := -1
			yyvsp86 := -1
			yyvsp87 := -1
			yyvsp88 := -1
			yyvsp89 := -1
			yyvsp90 := -1
			yyvsp91 := -1
			yyvsp92 := -1
			yyvsp93 := -1
			yyvsp94 := -1
			yyvsp95 := -1
			yyvsp96 := -1
			yyvsp97 := -1
			yyvsp98 := -1
			yyvsp99 := -1
			yyvsp100 := -1
			yyvsp101 := -1
			yyvsp102 := -1
			yyvsp103 := -1
			yyvsp104 := -1
			yyvsp105 := -1
			yyvsp106 := -1
			yyvsp107 := -1
			yyvsp108 := -1
			yyvsp109 := -1
			yyvsp110 := -1
			yyvsp111 := -1
			yyvsp112 := -1
			yyvsp113 := -1
			yyvsp114 := -1
			yyvsp115 := -1
			yyvsp116 := -1
			yyvsp117 := -1
			yyvsp118 := -1
			yyvsp119 := -1
			yyvsp120 := -1
			yyvsp121 := -1
			yyvsp122 := -1
			yyvsp123 := -1
			yyvsp124 := -1
			yyvsp125 := -1
			yyvsp126 := -1
			yyvsp127 := -1
			yyvsp128 := -1
			yyvsp129 := -1
			yyvsp130 := -1
			yyvsp131 := -1
			yyvsp132 := -1
		end

	yy_clear_value_stacks
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		do
			yyvs1.keep_head (0)
			yyvs2.keep_head (0)
			yyvs3.keep_head (0)
			yyvs4.keep_head (0)
			yyvs5.keep_head (0)
			yyvs6.keep_head (0)
			yyvs7.keep_head (0)
			yyvs8.keep_head (0)
			yyvs9.keep_head (0)
			yyvs10.keep_head (0)
			yyvs11.keep_head (0)
			yyvs12.keep_head (0)
			yyvs13.keep_head (0)
			yyvs14.keep_head (0)
			yyvs15.keep_head (0)
			yyvs16.keep_head (0)
			yyvs17.keep_head (0)
			yyvs18.keep_head (0)
			yyvs19.keep_head (0)
			yyvs20.keep_head (0)
			yyvs21.keep_head (0)
			yyvs22.keep_head (0)
			yyvs23.keep_head (0)
			yyvs24.keep_head (0)
			yyvs25.keep_head (0)
			yyvs26.keep_head (0)
			yyvs27.keep_head (0)
			yyvs28.keep_head (0)
			yyvs29.keep_head (0)
			yyvs30.keep_head (0)
			yyvs31.keep_head (0)
			yyvs32.keep_head (0)
			yyvs33.keep_head (0)
			yyvs34.keep_head (0)
			yyvs35.keep_head (0)
			yyvs36.keep_head (0)
			yyvs37.keep_head (0)
			yyvs38.keep_head (0)
			yyvs39.keep_head (0)
			yyvs40.keep_head (0)
			yyvs41.keep_head (0)
			yyvs42.keep_head (0)
			yyvs43.keep_head (0)
			yyvs44.keep_head (0)
			yyvs45.keep_head (0)
			yyvs46.keep_head (0)
			yyvs47.keep_head (0)
			yyvs48.keep_head (0)
			yyvs49.keep_head (0)
			yyvs50.keep_head (0)
			yyvs51.keep_head (0)
			yyvs52.keep_head (0)
			yyvs53.keep_head (0)
			yyvs54.keep_head (0)
			yyvs55.keep_head (0)
			yyvs56.keep_head (0)
			yyvs57.keep_head (0)
			yyvs58.keep_head (0)
			yyvs59.keep_head (0)
			yyvs60.keep_head (0)
			yyvs61.keep_head (0)
			yyvs62.keep_head (0)
			yyvs63.keep_head (0)
			yyvs64.keep_head (0)
			yyvs65.keep_head (0)
			yyvs66.keep_head (0)
			yyvs67.keep_head (0)
			yyvs68.keep_head (0)
			yyvs69.keep_head (0)
			yyvs70.keep_head (0)
			yyvs71.keep_head (0)
			yyvs72.keep_head (0)
			yyvs73.keep_head (0)
			yyvs74.keep_head (0)
			yyvs75.keep_head (0)
			yyvs76.keep_head (0)
			yyvs77.keep_head (0)
			yyvs78.keep_head (0)
			yyvs79.keep_head (0)
			yyvs80.keep_head (0)
			yyvs81.keep_head (0)
			yyvs82.keep_head (0)
			yyvs83.keep_head (0)
			yyvs84.keep_head (0)
			yyvs85.keep_head (0)
			yyvs86.keep_head (0)
			yyvs87.keep_head (0)
			yyvs88.keep_head (0)
			yyvs89.keep_head (0)
			yyvs90.keep_head (0)
			yyvs91.keep_head (0)
			yyvs92.keep_head (0)
			yyvs93.keep_head (0)
			yyvs94.keep_head (0)
			yyvs95.keep_head (0)
			yyvs96.keep_head (0)
			yyvs97.keep_head (0)
			yyvs98.keep_head (0)
			yyvs99.keep_head (0)
			yyvs100.keep_head (0)
			yyvs101.keep_head (0)
			yyvs102.keep_head (0)
			yyvs103.keep_head (0)
			yyvs104.keep_head (0)
			yyvs105.keep_head (0)
			yyvs106.keep_head (0)
			yyvs107.keep_head (0)
			yyvs108.keep_head (0)
			yyvs109.keep_head (0)
			yyvs110.keep_head (0)
			yyvs111.keep_head (0)
			yyvs112.keep_head (0)
			yyvs113.keep_head (0)
			yyvs114.keep_head (0)
			yyvs115.keep_head (0)
			yyvs116.keep_head (0)
			yyvs117.keep_head (0)
			yyvs118.keep_head (0)
			yyvs119.keep_head (0)
			yyvs120.keep_head (0)
			yyvs121.keep_head (0)
			yyvs122.keep_head (0)
			yyvs123.keep_head (0)
			yyvs124.keep_head (0)
			yyvs125.keep_head (0)
			yyvs126.keep_head (0)
			yyvs127.keep_head (0)
			yyvs128.keep_head (0)
			yyvs129.keep_head (0)
			yyvs130.keep_head (0)
			yyvs131.keep_head (0)
			yyvs132.keep_head (0)
		end

	yy_push_last_value (yychar1: INTEGER)
			-- Push semantic value associated with token `last_token'
			-- (with internal id `yychar1') on top of corresponding
			-- value stack.
		do
			inspect yytypes2.item (yychar1)
			when 1 then
				yyvsp1 := yyvsp1 + 1
				if yyvsp1 >= yyvsc1 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs1")
					end
					yyvsc1 := yyvsc1 + yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
				end
				yyspecial_routines1.force (yyvs1, last_detachable_any_value, yyvsp1)
			when 4 then
				yyvsp4 := yyvsp4 + 1
				if yyvsp4 >= yyvsc4 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs4")
					end
					yyvsc4 := yyvsc4 + yyInitial_yyvs_size
					yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
				end
				yyspecial_routines4.force (yyvs4, last_detachable_symbol_as_value, yyvsp4)
			when 6 then
				yyvsp6 := yyvsp6 + 1
				if yyvsp6 >= yyvsc6 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs6")
					end
					yyvsc6 := yyvsc6 + yyInitial_yyvs_size
					yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
				end
				yyspecial_routines6.force (yyvs6, last_symbol_id_value, yyvsp6)
			when 14 then
				yyvsp14 := yyvsp14 + 1
				if yyvsp14 >= yyvsc14 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs14")
					end
					yyvsc14 := yyvsc14 + yyInitial_yyvs_size
					yyvs14 := yyspecial_routines14.aliased_resized_area (yyvs14, yyvsc14)
				end
				yyspecial_routines14.force (yyvs14, last_detachable_keyword_as_value, yyvsp14)
			when 2 then
				yyvsp2 := yyvsp2 + 1
				if yyvsp2 >= yyvsc2 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs2")
					end
					yyvsc2 := yyvsc2 + yyInitial_yyvs_size
					yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
				end
				yyspecial_routines2.force (yyvs2, last_detachable_id_as_value, yyvsp2)
			when 3 then
				yyvsp3 := yyvsp3 + 1
				if yyvsp3 >= yyvsc3 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs3")
					end
					yyvsc3 := yyvsc3 + yyInitial_yyvs_size
					yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
				end
				yyspecial_routines3.force (yyvs3, last_detachable_char_as_value, yyvsp3)
			when 7 then
				yyvsp7 := yyvsp7 + 1
				if yyvsp7 >= yyvsc7 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs7")
					end
					yyvsc7 := yyvsc7 + yyInitial_yyvs_size
					yyvs7 := yyspecial_routines7.aliased_resized_area (yyvs7, yyvsc7)
				end
				yyspecial_routines7.force (yyvs7, last_detachable_bool_as_value, yyvsp7)
			when 8 then
				yyvsp8 := yyvsp8 + 1
				if yyvsp8 >= yyvsc8 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs8")
					end
					yyvsc8 := yyvsc8 + yyInitial_yyvs_size
					yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
				end
				yyspecial_routines8.force (yyvs8, last_detachable_result_as_value, yyvsp8)
			when 9 then
				yyvsp9 := yyvsp9 + 1
				if yyvsp9 >= yyvsc9 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs9")
					end
					yyvsc9 := yyvsc9 + yyInitial_yyvs_size
					yyvs9 := yyspecial_routines9.aliased_resized_area (yyvs9, yyvsc9)
				end
				yyspecial_routines9.force (yyvs9, last_detachable_retry_as_value, yyvsp9)
			when 10 then
				yyvsp10 := yyvsp10 + 1
				if yyvsp10 >= yyvsc10 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs10")
					end
					yyvsc10 := yyvsc10 + yyInitial_yyvs_size
					yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
				end
				yyspecial_routines10.force (yyvs10, last_detachable_unique_as_value, yyvsp10)
			when 11 then
				yyvsp11 := yyvsp11 + 1
				if yyvsp11 >= yyvsc11 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs11")
					end
					yyvsc11 := yyvsc11 + yyInitial_yyvs_size
					yyvs11 := yyspecial_routines11.aliased_resized_area (yyvs11, yyvsc11)
				end
				yyspecial_routines11.force (yyvs11, last_detachable_current_as_value, yyvsp11)
			when 12 then
				yyvsp12 := yyvsp12 + 1
				if yyvsp12 >= yyvsc12 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs12")
					end
					yyvsc12 := yyvsc12 + yyInitial_yyvs_size
					yyvs12 := yyspecial_routines12.aliased_resized_area (yyvs12, yyvsc12)
				end
				yyspecial_routines12.force (yyvs12, last_detachable_deferred_as_value, yyvsp12)
			when 13 then
				yyvsp13 := yyvsp13 + 1
				if yyvsp13 >= yyvsc13 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs13")
					end
					yyvsc13 := yyvsc13 + yyInitial_yyvs_size
					yyvs13 := yyspecial_routines13.aliased_resized_area (yyvs13, yyvsc13)
				end
				yyspecial_routines13.force (yyvs13, last_detachable_void_as_value, yyvsp13)
			when 15 then
				yyvsp15 := yyvsp15 + 1
				if yyvsp15 >= yyvsc15 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs15")
					end
					yyvsc15 := yyvsc15 + yyInitial_yyvs_size
					yyvs15 := yyspecial_routines15.aliased_resized_area (yyvs15, yyvsc15)
				end
				yyspecial_routines15.force (yyvs15, last_keyword_id_value, yyvsp15)
			when 16 then
				yyvsp16 := yyvsp16 + 1
				if yyvsp16 >= yyvsc16 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs16")
					end
					yyvsc16 := yyvsc16 + yyInitial_yyvs_size
					yyvs16 := yyspecial_routines16.aliased_resized_area (yyvs16, yyvsc16)
				end
				yyspecial_routines16.force (yyvs16, last_detachable_string_as_value, yyvsp16)
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: not a token type: ")
					std.error.put_integer (yytypes2.item (yychar1))
					std.error.put_new_line
				end
				abort
			end
		end

	yy_push_error_value
			-- Push semantic value associated with token 'error'
			-- on top of corresponding value stack.
		local
			yyval1: detachable ANY
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 then
				debug ("GEYACC")
					std.error.put_line ("Resize yyvs1")
				end
				yyvsc1 := yyvsc1 + yyInitial_yyvs_size
				yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
			end
			yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
		end

	yy_pop_last_value (yystate: INTEGER)
			-- Pop semantic value from stack when in state `yystate'.
		local
			yy_type_id: INTEGER
		do
			yy_type_id := yytypes1.item (yystate)
			inspect yy_type_id
			when 1 then
				yyvsp1 := yyvsp1 - 1
			when 2 then
				yyvsp2 := yyvsp2 - 1
			when 3 then
				yyvsp3 := yyvsp3 - 1
			when 4 then
				yyvsp4 := yyvsp4 - 1
			when 5 then
				yyvsp5 := yyvsp5 - 1
			when 6 then
				yyvsp6 := yyvsp6 - 1
			when 7 then
				yyvsp7 := yyvsp7 - 1
			when 8 then
				yyvsp8 := yyvsp8 - 1
			when 9 then
				yyvsp9 := yyvsp9 - 1
			when 10 then
				yyvsp10 := yyvsp10 - 1
			when 11 then
				yyvsp11 := yyvsp11 - 1
			when 12 then
				yyvsp12 := yyvsp12 - 1
			when 13 then
				yyvsp13 := yyvsp13 - 1
			when 14 then
				yyvsp14 := yyvsp14 - 1
			when 15 then
				yyvsp15 := yyvsp15 - 1
			when 16 then
				yyvsp16 := yyvsp16 - 1
			when 17 then
				yyvsp17 := yyvsp17 - 1
			when 18 then
				yyvsp18 := yyvsp18 - 1
			when 19 then
				yyvsp19 := yyvsp19 - 1
			when 20 then
				yyvsp20 := yyvsp20 - 1
			when 21 then
				yyvsp21 := yyvsp21 - 1
			when 22 then
				yyvsp22 := yyvsp22 - 1
			when 23 then
				yyvsp23 := yyvsp23 - 1
			when 24 then
				yyvsp24 := yyvsp24 - 1
			when 25 then
				yyvsp25 := yyvsp25 - 1
			when 26 then
				yyvsp26 := yyvsp26 - 1
			when 27 then
				yyvsp27 := yyvsp27 - 1
			when 28 then
				yyvsp28 := yyvsp28 - 1
			when 29 then
				yyvsp29 := yyvsp29 - 1
			when 30 then
				yyvsp30 := yyvsp30 - 1
			when 31 then
				yyvsp31 := yyvsp31 - 1
			when 32 then
				yyvsp32 := yyvsp32 - 1
			when 33 then
				yyvsp33 := yyvsp33 - 1
			when 34 then
				yyvsp34 := yyvsp34 - 1
			when 35 then
				yyvsp35 := yyvsp35 - 1
			when 36 then
				yyvsp36 := yyvsp36 - 1
			when 37 then
				yyvsp37 := yyvsp37 - 1
			when 38 then
				yyvsp38 := yyvsp38 - 1
			when 39 then
				yyvsp39 := yyvsp39 - 1
			when 40 then
				yyvsp40 := yyvsp40 - 1
			when 41 then
				yyvsp41 := yyvsp41 - 1
			when 42 then
				yyvsp42 := yyvsp42 - 1
			when 43 then
				yyvsp43 := yyvsp43 - 1
			when 44 then
				yyvsp44 := yyvsp44 - 1
			when 45 then
				yyvsp45 := yyvsp45 - 1
			when 46 then
				yyvsp46 := yyvsp46 - 1
			when 47 then
				yyvsp47 := yyvsp47 - 1
			when 48 then
				yyvsp48 := yyvsp48 - 1
			when 49 then
				yyvsp49 := yyvsp49 - 1
			when 50 then
				yyvsp50 := yyvsp50 - 1
			when 51 then
				yyvsp51 := yyvsp51 - 1
			when 52 then
				yyvsp52 := yyvsp52 - 1
			when 53 then
				yyvsp53 := yyvsp53 - 1
			when 54 then
				yyvsp54 := yyvsp54 - 1
			when 55 then
				yyvsp55 := yyvsp55 - 1
			when 56 then
				yyvsp56 := yyvsp56 - 1
			when 57 then
				yyvsp57 := yyvsp57 - 1
			when 58 then
				yyvsp58 := yyvsp58 - 1
			when 59 then
				yyvsp59 := yyvsp59 - 1
			when 60 then
				yyvsp60 := yyvsp60 - 1
			when 61 then
				yyvsp61 := yyvsp61 - 1
			when 62 then
				yyvsp62 := yyvsp62 - 1
			when 63 then
				yyvsp63 := yyvsp63 - 1
			when 64 then
				yyvsp64 := yyvsp64 - 1
			when 65 then
				yyvsp65 := yyvsp65 - 1
			when 66 then
				yyvsp66 := yyvsp66 - 1
			when 67 then
				yyvsp67 := yyvsp67 - 1
			when 68 then
				yyvsp68 := yyvsp68 - 1
			when 69 then
				yyvsp69 := yyvsp69 - 1
			when 70 then
				yyvsp70 := yyvsp70 - 1
			when 71 then
				yyvsp71 := yyvsp71 - 1
			when 72 then
				yyvsp72 := yyvsp72 - 1
			when 73 then
				yyvsp73 := yyvsp73 - 1
			when 74 then
				yyvsp74 := yyvsp74 - 1
			when 75 then
				yyvsp75 := yyvsp75 - 1
			when 76 then
				yyvsp76 := yyvsp76 - 1
			when 77 then
				yyvsp77 := yyvsp77 - 1
			when 78 then
				yyvsp78 := yyvsp78 - 1
			when 79 then
				yyvsp79 := yyvsp79 - 1
			when 80 then
				yyvsp80 := yyvsp80 - 1
			when 81 then
				yyvsp81 := yyvsp81 - 1
			when 82 then
				yyvsp82 := yyvsp82 - 1
			when 83 then
				yyvsp83 := yyvsp83 - 1
			when 84 then
				yyvsp84 := yyvsp84 - 1
			when 85 then
				yyvsp85 := yyvsp85 - 1
			when 86 then
				yyvsp86 := yyvsp86 - 1
			when 87 then
				yyvsp87 := yyvsp87 - 1
			when 88 then
				yyvsp88 := yyvsp88 - 1
			when 89 then
				yyvsp89 := yyvsp89 - 1
			when 90 then
				yyvsp90 := yyvsp90 - 1
			when 91 then
				yyvsp91 := yyvsp91 - 1
			when 92 then
				yyvsp92 := yyvsp92 - 1
			when 93 then
				yyvsp93 := yyvsp93 - 1
			when 94 then
				yyvsp94 := yyvsp94 - 1
			when 95 then
				yyvsp95 := yyvsp95 - 1
			when 96 then
				yyvsp96 := yyvsp96 - 1
			when 97 then
				yyvsp97 := yyvsp97 - 1
			when 98 then
				yyvsp98 := yyvsp98 - 1
			when 99 then
				yyvsp99 := yyvsp99 - 1
			when 100 then
				yyvsp100 := yyvsp100 - 1
			when 101 then
				yyvsp101 := yyvsp101 - 1
			when 102 then
				yyvsp102 := yyvsp102 - 1
			when 103 then
				yyvsp103 := yyvsp103 - 1
			when 104 then
				yyvsp104 := yyvsp104 - 1
			when 105 then
				yyvsp105 := yyvsp105 - 1
			when 106 then
				yyvsp106 := yyvsp106 - 1
			when 107 then
				yyvsp107 := yyvsp107 - 1
			when 108 then
				yyvsp108 := yyvsp108 - 1
			when 109 then
				yyvsp109 := yyvsp109 - 1
			when 110 then
				yyvsp110 := yyvsp110 - 1
			when 111 then
				yyvsp111 := yyvsp111 - 1
			when 112 then
				yyvsp112 := yyvsp112 - 1
			when 113 then
				yyvsp113 := yyvsp113 - 1
			when 114 then
				yyvsp114 := yyvsp114 - 1
			when 115 then
				yyvsp115 := yyvsp115 - 1
			when 116 then
				yyvsp116 := yyvsp116 - 1
			when 117 then
				yyvsp117 := yyvsp117 - 1
			when 118 then
				yyvsp118 := yyvsp118 - 1
			when 119 then
				yyvsp119 := yyvsp119 - 1
			when 120 then
				yyvsp120 := yyvsp120 - 1
			when 121 then
				yyvsp121 := yyvsp121 - 1
			when 122 then
				yyvsp122 := yyvsp122 - 1
			when 123 then
				yyvsp123 := yyvsp123 - 1
			when 124 then
				yyvsp124 := yyvsp124 - 1
			when 125 then
				yyvsp125 := yyvsp125 - 1
			when 126 then
				yyvsp126 := yyvsp126 - 1
			when 127 then
				yyvsp127 := yyvsp127 - 1
			when 128 then
				yyvsp128 := yyvsp128 - 1
			when 129 then
				yyvsp129 := yyvsp129 - 1
			when 130 then
				yyvsp130 := yyvsp130 - 1
			when 131 then
				yyvsp131 := yyvsp131 - 1
			when 132 then
				yyvsp132 := yyvsp132 - 1
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown type id: ")
					std.error.put_integer (yy_type_id)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_run_geyacc
			-- You must run geyacc to regenerate this class.
		do
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			if yy_act <= 200 then
				yy_do_action_1_200 (yy_act)
			elseif yy_act <= 400 then
				yy_do_action_201_400 (yy_act)
			elseif yy_act <= 600 then
				yy_do_action_401_600 (yy_act)
			elseif yy_act <= 800 then
				yy_do_action_601_800 (yy_act)
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_1_200 (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
			when 1 then
					--|#line <not available> "eiffel.y"
				yy_do_action_1
			when 2 then
					--|#line <not available> "eiffel.y"
				yy_do_action_2
			when 3 then
					--|#line <not available> "eiffel.y"
				yy_do_action_3
			when 4 then
					--|#line <not available> "eiffel.y"
				yy_do_action_4
			when 5 then
					--|#line <not available> "eiffel.y"
				yy_do_action_5
			when 6 then
					--|#line <not available> "eiffel.y"
				yy_do_action_6
			when 7 then
					--|#line <not available> "eiffel.y"
				yy_do_action_7
			when 8 then
					--|#line <not available> "eiffel.y"
				yy_do_action_8
			when 9 then
					--|#line <not available> "eiffel.y"
				yy_do_action_9
			when 10 then
					--|#line <not available> "eiffel.y"
				yy_do_action_10
			when 11 then
					--|#line <not available> "eiffel.y"
				yy_do_action_11
			when 12 then
					--|#line <not available> "eiffel.y"
				yy_do_action_12
			when 13 then
					--|#line <not available> "eiffel.y"
				yy_do_action_13
			when 14 then
					--|#line <not available> "eiffel.y"
				yy_do_action_14
			when 15 then
					--|#line <not available> "eiffel.y"
				yy_do_action_15
			when 16 then
					--|#line <not available> "eiffel.y"
				yy_do_action_16
			when 17 then
					--|#line <not available> "eiffel.y"
				yy_do_action_17
			when 18 then
					--|#line <not available> "eiffel.y"
				yy_do_action_18
			when 19 then
					--|#line <not available> "eiffel.y"
				yy_do_action_19
			when 20 then
					--|#line <not available> "eiffel.y"
				yy_do_action_20
			when 21 then
					--|#line <not available> "eiffel.y"
				yy_do_action_21
			when 22 then
					--|#line <not available> "eiffel.y"
				yy_do_action_22
			when 23 then
					--|#line <not available> "eiffel.y"
				yy_do_action_23
			when 24 then
					--|#line <not available> "eiffel.y"
				yy_do_action_24
			when 25 then
					--|#line <not available> "eiffel.y"
				yy_do_action_25
			when 26 then
					--|#line <not available> "eiffel.y"
				yy_do_action_26
			when 27 then
					--|#line <not available> "eiffel.y"
				yy_do_action_27
			when 28 then
					--|#line <not available> "eiffel.y"
				yy_do_action_28
			when 29 then
					--|#line <not available> "eiffel.y"
				yy_do_action_29
			when 30 then
					--|#line <not available> "eiffel.y"
				yy_do_action_30
			when 31 then
					--|#line <not available> "eiffel.y"
				yy_do_action_31
			when 32 then
					--|#line <not available> "eiffel.y"
				yy_do_action_32
			when 33 then
					--|#line <not available> "eiffel.y"
				yy_do_action_33
			when 34 then
					--|#line <not available> "eiffel.y"
				yy_do_action_34
			when 35 then
					--|#line <not available> "eiffel.y"
				yy_do_action_35
			when 36 then
					--|#line <not available> "eiffel.y"
				yy_do_action_36
			when 37 then
					--|#line <not available> "eiffel.y"
				yy_do_action_37
			when 38 then
					--|#line <not available> "eiffel.y"
				yy_do_action_38
			when 39 then
					--|#line <not available> "eiffel.y"
				yy_do_action_39
			when 40 then
					--|#line <not available> "eiffel.y"
				yy_do_action_40
			when 41 then
					--|#line <not available> "eiffel.y"
				yy_do_action_41
			when 42 then
					--|#line <not available> "eiffel.y"
				yy_do_action_42
			when 43 then
					--|#line <not available> "eiffel.y"
				yy_do_action_43
			when 44 then
					--|#line <not available> "eiffel.y"
				yy_do_action_44
			when 45 then
					--|#line <not available> "eiffel.y"
				yy_do_action_45
			when 46 then
					--|#line <not available> "eiffel.y"
				yy_do_action_46
			when 47 then
					--|#line <not available> "eiffel.y"
				yy_do_action_47
			when 48 then
					--|#line <not available> "eiffel.y"
				yy_do_action_48
			when 49 then
					--|#line <not available> "eiffel.y"
				yy_do_action_49
			when 50 then
					--|#line <not available> "eiffel.y"
				yy_do_action_50
			when 51 then
					--|#line <not available> "eiffel.y"
				yy_do_action_51
			when 52 then
					--|#line <not available> "eiffel.y"
				yy_do_action_52
			when 53 then
					--|#line <not available> "eiffel.y"
				yy_do_action_53
			when 54 then
					--|#line <not available> "eiffel.y"
				yy_do_action_54
			when 55 then
					--|#line <not available> "eiffel.y"
				yy_do_action_55
			when 56 then
					--|#line <not available> "eiffel.y"
				yy_do_action_56
			when 57 then
					--|#line <not available> "eiffel.y"
				yy_do_action_57
			when 58 then
					--|#line <not available> "eiffel.y"
				yy_do_action_58
			when 59 then
					--|#line <not available> "eiffel.y"
				yy_do_action_59
			when 60 then
					--|#line <not available> "eiffel.y"
				yy_do_action_60
			when 61 then
					--|#line <not available> "eiffel.y"
				yy_do_action_61
			when 62 then
					--|#line <not available> "eiffel.y"
				yy_do_action_62
			when 63 then
					--|#line <not available> "eiffel.y"
				yy_do_action_63
			when 64 then
					--|#line <not available> "eiffel.y"
				yy_do_action_64
			when 65 then
					--|#line <not available> "eiffel.y"
				yy_do_action_65
			when 66 then
					--|#line <not available> "eiffel.y"
				yy_do_action_66
			when 67 then
					--|#line <not available> "eiffel.y"
				yy_do_action_67
			when 68 then
					--|#line <not available> "eiffel.y"
				yy_do_action_68
			when 69 then
					--|#line <not available> "eiffel.y"
				yy_do_action_69
			when 70 then
					--|#line <not available> "eiffel.y"
				yy_do_action_70
			when 71 then
					--|#line <not available> "eiffel.y"
				yy_do_action_71
			when 72 then
					--|#line <not available> "eiffel.y"
				yy_do_action_72
			when 73 then
					--|#line <not available> "eiffel.y"
				yy_do_action_73
			when 74 then
					--|#line <not available> "eiffel.y"
				yy_do_action_74
			when 75 then
					--|#line <not available> "eiffel.y"
				yy_do_action_75
			when 76 then
					--|#line <not available> "eiffel.y"
				yy_do_action_76
			when 77 then
					--|#line <not available> "eiffel.y"
				yy_do_action_77
			when 78 then
					--|#line <not available> "eiffel.y"
				yy_do_action_78
			when 79 then
					--|#line <not available> "eiffel.y"
				yy_do_action_79
			when 80 then
					--|#line <not available> "eiffel.y"
				yy_do_action_80
			when 81 then
					--|#line <not available> "eiffel.y"
				yy_do_action_81
			when 82 then
					--|#line <not available> "eiffel.y"
				yy_do_action_82
			when 83 then
					--|#line <not available> "eiffel.y"
				yy_do_action_83
			when 84 then
					--|#line <not available> "eiffel.y"
				yy_do_action_84
			when 85 then
					--|#line <not available> "eiffel.y"
				yy_do_action_85
			when 86 then
					--|#line <not available> "eiffel.y"
				yy_do_action_86
			when 87 then
					--|#line <not available> "eiffel.y"
				yy_do_action_87
			when 88 then
					--|#line <not available> "eiffel.y"
				yy_do_action_88
			when 89 then
					--|#line <not available> "eiffel.y"
				yy_do_action_89
			when 90 then
					--|#line <not available> "eiffel.y"
				yy_do_action_90
			when 91 then
					--|#line <not available> "eiffel.y"
				yy_do_action_91
			when 92 then
					--|#line <not available> "eiffel.y"
				yy_do_action_92
			when 93 then
					--|#line <not available> "eiffel.y"
				yy_do_action_93
			when 94 then
					--|#line <not available> "eiffel.y"
				yy_do_action_94
			when 95 then
					--|#line <not available> "eiffel.y"
				yy_do_action_95
			when 96 then
					--|#line <not available> "eiffel.y"
				yy_do_action_96
			when 97 then
					--|#line <not available> "eiffel.y"
				yy_do_action_97
			when 98 then
					--|#line <not available> "eiffel.y"
				yy_do_action_98
			when 99 then
					--|#line <not available> "eiffel.y"
				yy_do_action_99
			when 100 then
					--|#line <not available> "eiffel.y"
				yy_do_action_100
			when 101 then
					--|#line <not available> "eiffel.y"
				yy_do_action_101
			when 102 then
					--|#line <not available> "eiffel.y"
				yy_do_action_102
			when 103 then
					--|#line <not available> "eiffel.y"
				yy_do_action_103
			when 104 then
					--|#line <not available> "eiffel.y"
				yy_do_action_104
			when 105 then
					--|#line <not available> "eiffel.y"
				yy_do_action_105
			when 106 then
					--|#line <not available> "eiffel.y"
				yy_do_action_106
			when 107 then
					--|#line <not available> "eiffel.y"
				yy_do_action_107
			when 108 then
					--|#line <not available> "eiffel.y"
				yy_do_action_108
			when 109 then
					--|#line <not available> "eiffel.y"
				yy_do_action_109
			when 110 then
					--|#line <not available> "eiffel.y"
				yy_do_action_110
			when 111 then
					--|#line <not available> "eiffel.y"
				yy_do_action_111
			when 112 then
					--|#line <not available> "eiffel.y"
				yy_do_action_112
			when 113 then
					--|#line <not available> "eiffel.y"
				yy_do_action_113
			when 114 then
					--|#line <not available> "eiffel.y"
				yy_do_action_114
			when 115 then
					--|#line <not available> "eiffel.y"
				yy_do_action_115
			when 116 then
					--|#line <not available> "eiffel.y"
				yy_do_action_116
			when 117 then
					--|#line <not available> "eiffel.y"
				yy_do_action_117
			when 118 then
					--|#line <not available> "eiffel.y"
				yy_do_action_118
			when 119 then
					--|#line <not available> "eiffel.y"
				yy_do_action_119
			when 120 then
					--|#line <not available> "eiffel.y"
				yy_do_action_120
			when 121 then
					--|#line <not available> "eiffel.y"
				yy_do_action_121
			when 122 then
					--|#line <not available> "eiffel.y"
				yy_do_action_122
			when 123 then
					--|#line <not available> "eiffel.y"
				yy_do_action_123
			when 124 then
					--|#line <not available> "eiffel.y"
				yy_do_action_124
			when 125 then
					--|#line <not available> "eiffel.y"
				yy_do_action_125
			when 126 then
					--|#line <not available> "eiffel.y"
				yy_do_action_126
			when 127 then
					--|#line <not available> "eiffel.y"
				yy_do_action_127
			when 128 then
					--|#line <not available> "eiffel.y"
				yy_do_action_128
			when 129 then
					--|#line <not available> "eiffel.y"
				yy_do_action_129
			when 130 then
					--|#line <not available> "eiffel.y"
				yy_do_action_130
			when 131 then
					--|#line <not available> "eiffel.y"
				yy_do_action_131
			when 132 then
					--|#line <not available> "eiffel.y"
				yy_do_action_132
			when 133 then
					--|#line <not available> "eiffel.y"
				yy_do_action_133
			when 134 then
					--|#line <not available> "eiffel.y"
				yy_do_action_134
			when 135 then
					--|#line <not available> "eiffel.y"
				yy_do_action_135
			when 136 then
					--|#line <not available> "eiffel.y"
				yy_do_action_136
			when 137 then
					--|#line <not available> "eiffel.y"
				yy_do_action_137
			when 138 then
					--|#line <not available> "eiffel.y"
				yy_do_action_138
			when 139 then
					--|#line <not available> "eiffel.y"
				yy_do_action_139
			when 140 then
					--|#line <not available> "eiffel.y"
				yy_do_action_140
			when 141 then
					--|#line <not available> "eiffel.y"
				yy_do_action_141
			when 142 then
					--|#line <not available> "eiffel.y"
				yy_do_action_142
			when 143 then
					--|#line <not available> "eiffel.y"
				yy_do_action_143
			when 144 then
					--|#line <not available> "eiffel.y"
				yy_do_action_144
			when 145 then
					--|#line <not available> "eiffel.y"
				yy_do_action_145
			when 146 then
					--|#line <not available> "eiffel.y"
				yy_do_action_146
			when 147 then
					--|#line <not available> "eiffel.y"
				yy_do_action_147
			when 148 then
					--|#line <not available> "eiffel.y"
				yy_do_action_148
			when 149 then
					--|#line <not available> "eiffel.y"
				yy_do_action_149
			when 150 then
					--|#line <not available> "eiffel.y"
				yy_do_action_150
			when 151 then
					--|#line <not available> "eiffel.y"
				yy_do_action_151
			when 152 then
					--|#line <not available> "eiffel.y"
				yy_do_action_152
			when 153 then
					--|#line <not available> "eiffel.y"
				yy_do_action_153
			when 154 then
					--|#line <not available> "eiffel.y"
				yy_do_action_154
			when 155 then
					--|#line <not available> "eiffel.y"
				yy_do_action_155
			when 156 then
					--|#line <not available> "eiffel.y"
				yy_do_action_156
			when 157 then
					--|#line <not available> "eiffel.y"
				yy_do_action_157
			when 158 then
					--|#line <not available> "eiffel.y"
				yy_do_action_158
			when 159 then
					--|#line <not available> "eiffel.y"
				yy_do_action_159
			when 160 then
					--|#line <not available> "eiffel.y"
				yy_do_action_160
			when 161 then
					--|#line <not available> "eiffel.y"
				yy_do_action_161
			when 162 then
					--|#line <not available> "eiffel.y"
				yy_do_action_162
			when 163 then
					--|#line <not available> "eiffel.y"
				yy_do_action_163
			when 164 then
					--|#line <not available> "eiffel.y"
				yy_do_action_164
			when 165 then
					--|#line <not available> "eiffel.y"
				yy_do_action_165
			when 166 then
					--|#line <not available> "eiffel.y"
				yy_do_action_166
			when 167 then
					--|#line <not available> "eiffel.y"
				yy_do_action_167
			when 168 then
					--|#line <not available> "eiffel.y"
				yy_do_action_168
			when 169 then
					--|#line <not available> "eiffel.y"
				yy_do_action_169
			when 170 then
					--|#line <not available> "eiffel.y"
				yy_do_action_170
			when 171 then
					--|#line <not available> "eiffel.y"
				yy_do_action_171
			when 172 then
					--|#line <not available> "eiffel.y"
				yy_do_action_172
			when 173 then
					--|#line <not available> "eiffel.y"
				yy_do_action_173
			when 174 then
					--|#line <not available> "eiffel.y"
				yy_do_action_174
			when 175 then
					--|#line <not available> "eiffel.y"
				yy_do_action_175
			when 176 then
					--|#line <not available> "eiffel.y"
				yy_do_action_176
			when 177 then
					--|#line <not available> "eiffel.y"
				yy_do_action_177
			when 178 then
					--|#line <not available> "eiffel.y"
				yy_do_action_178
			when 179 then
					--|#line <not available> "eiffel.y"
				yy_do_action_179
			when 180 then
					--|#line <not available> "eiffel.y"
				yy_do_action_180
			when 181 then
					--|#line <not available> "eiffel.y"
				yy_do_action_181
			when 182 then
					--|#line <not available> "eiffel.y"
				yy_do_action_182
			when 183 then
					--|#line <not available> "eiffel.y"
				yy_do_action_183
			when 184 then
					--|#line <not available> "eiffel.y"
				yy_do_action_184
			when 185 then
					--|#line <not available> "eiffel.y"
				yy_do_action_185
			when 186 then
					--|#line <not available> "eiffel.y"
				yy_do_action_186
			when 187 then
					--|#line <not available> "eiffel.y"
				yy_do_action_187
			when 188 then
					--|#line <not available> "eiffel.y"
				yy_do_action_188
			when 189 then
					--|#line <not available> "eiffel.y"
				yy_do_action_189
			when 190 then
					--|#line <not available> "eiffel.y"
				yy_do_action_190
			when 191 then
					--|#line <not available> "eiffel.y"
				yy_do_action_191
			when 192 then
					--|#line <not available> "eiffel.y"
				yy_do_action_192
			when 193 then
					--|#line <not available> "eiffel.y"
				yy_do_action_193
			when 194 then
					--|#line <not available> "eiffel.y"
				yy_do_action_194
			when 195 then
					--|#line <not available> "eiffel.y"
				yy_do_action_195
			when 196 then
					--|#line <not available> "eiffel.y"
				yy_do_action_196
			when 197 then
					--|#line <not available> "eiffel.y"
				yy_do_action_197
			when 198 then
					--|#line <not available> "eiffel.y"
				yy_do_action_198
			when 199 then
					--|#line <not available> "eiffel.y"
				yy_do_action_199
			when 200 then
					--|#line <not available> "eiffel.y"
				yy_do_action_200
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_201_400 (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
			when 201 then
					--|#line <not available> "eiffel.y"
				yy_do_action_201
			when 202 then
					--|#line <not available> "eiffel.y"
				yy_do_action_202
			when 203 then
					--|#line <not available> "eiffel.y"
				yy_do_action_203
			when 204 then
					--|#line <not available> "eiffel.y"
				yy_do_action_204
			when 205 then
					--|#line <not available> "eiffel.y"
				yy_do_action_205
			when 206 then
					--|#line <not available> "eiffel.y"
				yy_do_action_206
			when 207 then
					--|#line <not available> "eiffel.y"
				yy_do_action_207
			when 208 then
					--|#line <not available> "eiffel.y"
				yy_do_action_208
			when 209 then
					--|#line <not available> "eiffel.y"
				yy_do_action_209
			when 210 then
					--|#line <not available> "eiffel.y"
				yy_do_action_210
			when 211 then
					--|#line <not available> "eiffel.y"
				yy_do_action_211
			when 212 then
					--|#line <not available> "eiffel.y"
				yy_do_action_212
			when 213 then
					--|#line <not available> "eiffel.y"
				yy_do_action_213
			when 214 then
					--|#line <not available> "eiffel.y"
				yy_do_action_214
			when 215 then
					--|#line <not available> "eiffel.y"
				yy_do_action_215
			when 216 then
					--|#line <not available> "eiffel.y"
				yy_do_action_216
			when 217 then
					--|#line <not available> "eiffel.y"
				yy_do_action_217
			when 218 then
					--|#line <not available> "eiffel.y"
				yy_do_action_218
			when 219 then
					--|#line <not available> "eiffel.y"
				yy_do_action_219
			when 220 then
					--|#line <not available> "eiffel.y"
				yy_do_action_220
			when 221 then
					--|#line <not available> "eiffel.y"
				yy_do_action_221
			when 222 then
					--|#line <not available> "eiffel.y"
				yy_do_action_222
			when 223 then
					--|#line <not available> "eiffel.y"
				yy_do_action_223
			when 224 then
					--|#line <not available> "eiffel.y"
				yy_do_action_224
			when 225 then
					--|#line <not available> "eiffel.y"
				yy_do_action_225
			when 226 then
					--|#line <not available> "eiffel.y"
				yy_do_action_226
			when 227 then
					--|#line <not available> "eiffel.y"
				yy_do_action_227
			when 228 then
					--|#line <not available> "eiffel.y"
				yy_do_action_228
			when 229 then
					--|#line <not available> "eiffel.y"
				yy_do_action_229
			when 230 then
					--|#line <not available> "eiffel.y"
				yy_do_action_230
			when 231 then
					--|#line <not available> "eiffel.y"
				yy_do_action_231
			when 232 then
					--|#line <not available> "eiffel.y"
				yy_do_action_232
			when 233 then
					--|#line <not available> "eiffel.y"
				yy_do_action_233
			when 234 then
					--|#line <not available> "eiffel.y"
				yy_do_action_234
			when 235 then
					--|#line <not available> "eiffel.y"
				yy_do_action_235
			when 236 then
					--|#line <not available> "eiffel.y"
				yy_do_action_236
			when 237 then
					--|#line <not available> "eiffel.y"
				yy_do_action_237
			when 238 then
					--|#line <not available> "eiffel.y"
				yy_do_action_238
			when 239 then
					--|#line <not available> "eiffel.y"
				yy_do_action_239
			when 240 then
					--|#line <not available> "eiffel.y"
				yy_do_action_240
			when 241 then
					--|#line <not available> "eiffel.y"
				yy_do_action_241
			when 242 then
					--|#line <not available> "eiffel.y"
				yy_do_action_242
			when 243 then
					--|#line <not available> "eiffel.y"
				yy_do_action_243
			when 244 then
					--|#line <not available> "eiffel.y"
				yy_do_action_244
			when 245 then
					--|#line <not available> "eiffel.y"
				yy_do_action_245
			when 246 then
					--|#line <not available> "eiffel.y"
				yy_do_action_246
			when 247 then
					--|#line <not available> "eiffel.y"
				yy_do_action_247
			when 248 then
					--|#line <not available> "eiffel.y"
				yy_do_action_248
			when 249 then
					--|#line <not available> "eiffel.y"
				yy_do_action_249
			when 250 then
					--|#line <not available> "eiffel.y"
				yy_do_action_250
			when 251 then
					--|#line <not available> "eiffel.y"
				yy_do_action_251
			when 252 then
					--|#line <not available> "eiffel.y"
				yy_do_action_252
			when 253 then
					--|#line <not available> "eiffel.y"
				yy_do_action_253
			when 254 then
					--|#line <not available> "eiffel.y"
				yy_do_action_254
			when 255 then
					--|#line <not available> "eiffel.y"
				yy_do_action_255
			when 256 then
					--|#line <not available> "eiffel.y"
				yy_do_action_256
			when 257 then
					--|#line <not available> "eiffel.y"
				yy_do_action_257
			when 258 then
					--|#line <not available> "eiffel.y"
				yy_do_action_258
			when 259 then
					--|#line <not available> "eiffel.y"
				yy_do_action_259
			when 260 then
					--|#line <not available> "eiffel.y"
				yy_do_action_260
			when 261 then
					--|#line <not available> "eiffel.y"
				yy_do_action_261
			when 262 then
					--|#line <not available> "eiffel.y"
				yy_do_action_262
			when 263 then
					--|#line <not available> "eiffel.y"
				yy_do_action_263
			when 264 then
					--|#line <not available> "eiffel.y"
				yy_do_action_264
			when 265 then
					--|#line <not available> "eiffel.y"
				yy_do_action_265
			when 266 then
					--|#line <not available> "eiffel.y"
				yy_do_action_266
			when 267 then
					--|#line <not available> "eiffel.y"
				yy_do_action_267
			when 268 then
					--|#line <not available> "eiffel.y"
				yy_do_action_268
			when 269 then
					--|#line <not available> "eiffel.y"
				yy_do_action_269
			when 270 then
					--|#line <not available> "eiffel.y"
				yy_do_action_270
			when 271 then
					--|#line <not available> "eiffel.y"
				yy_do_action_271
			when 272 then
					--|#line <not available> "eiffel.y"
				yy_do_action_272
			when 273 then
					--|#line <not available> "eiffel.y"
				yy_do_action_273
			when 274 then
					--|#line <not available> "eiffel.y"
				yy_do_action_274
			when 275 then
					--|#line <not available> "eiffel.y"
				yy_do_action_275
			when 276 then
					--|#line <not available> "eiffel.y"
				yy_do_action_276
			when 277 then
					--|#line <not available> "eiffel.y"
				yy_do_action_277
			when 278 then
					--|#line <not available> "eiffel.y"
				yy_do_action_278
			when 279 then
					--|#line <not available> "eiffel.y"
				yy_do_action_279
			when 280 then
					--|#line <not available> "eiffel.y"
				yy_do_action_280
			when 281 then
					--|#line <not available> "eiffel.y"
				yy_do_action_281
			when 282 then
					--|#line <not available> "eiffel.y"
				yy_do_action_282
			when 283 then
					--|#line <not available> "eiffel.y"
				yy_do_action_283
			when 284 then
					--|#line <not available> "eiffel.y"
				yy_do_action_284
			when 285 then
					--|#line <not available> "eiffel.y"
				yy_do_action_285
			when 286 then
					--|#line <not available> "eiffel.y"
				yy_do_action_286
			when 287 then
					--|#line <not available> "eiffel.y"
				yy_do_action_287
			when 288 then
					--|#line <not available> "eiffel.y"
				yy_do_action_288
			when 289 then
					--|#line <not available> "eiffel.y"
				yy_do_action_289
			when 290 then
					--|#line <not available> "eiffel.y"
				yy_do_action_290
			when 291 then
					--|#line <not available> "eiffel.y"
				yy_do_action_291
			when 292 then
					--|#line <not available> "eiffel.y"
				yy_do_action_292
			when 293 then
					--|#line <not available> "eiffel.y"
				yy_do_action_293
			when 294 then
					--|#line <not available> "eiffel.y"
				yy_do_action_294
			when 295 then
					--|#line <not available> "eiffel.y"
				yy_do_action_295
			when 296 then
					--|#line <not available> "eiffel.y"
				yy_do_action_296
			when 297 then
					--|#line <not available> "eiffel.y"
				yy_do_action_297
			when 298 then
					--|#line <not available> "eiffel.y"
				yy_do_action_298
			when 299 then
					--|#line <not available> "eiffel.y"
				yy_do_action_299
			when 300 then
					--|#line <not available> "eiffel.y"
				yy_do_action_300
			when 301 then
					--|#line <not available> "eiffel.y"
				yy_do_action_301
			when 302 then
					--|#line <not available> "eiffel.y"
				yy_do_action_302
			when 303 then
					--|#line <not available> "eiffel.y"
				yy_do_action_303
			when 304 then
					--|#line <not available> "eiffel.y"
				yy_do_action_304
			when 305 then
					--|#line <not available> "eiffel.y"
				yy_do_action_305
			when 306 then
					--|#line <not available> "eiffel.y"
				yy_do_action_306
			when 307 then
					--|#line <not available> "eiffel.y"
				yy_do_action_307
			when 308 then
					--|#line <not available> "eiffel.y"
				yy_do_action_308
			when 309 then
					--|#line <not available> "eiffel.y"
				yy_do_action_309
			when 310 then
					--|#line <not available> "eiffel.y"
				yy_do_action_310
			when 311 then
					--|#line <not available> "eiffel.y"
				yy_do_action_311
			when 312 then
					--|#line <not available> "eiffel.y"
				yy_do_action_312
			when 313 then
					--|#line <not available> "eiffel.y"
				yy_do_action_313
			when 314 then
					--|#line <not available> "eiffel.y"
				yy_do_action_314
			when 315 then
					--|#line <not available> "eiffel.y"
				yy_do_action_315
			when 316 then
					--|#line <not available> "eiffel.y"
				yy_do_action_316
			when 317 then
					--|#line <not available> "eiffel.y"
				yy_do_action_317
			when 318 then
					--|#line <not available> "eiffel.y"
				yy_do_action_318
			when 319 then
					--|#line <not available> "eiffel.y"
				yy_do_action_319
			when 320 then
					--|#line <not available> "eiffel.y"
				yy_do_action_320
			when 321 then
					--|#line <not available> "eiffel.y"
				yy_do_action_321
			when 322 then
					--|#line <not available> "eiffel.y"
				yy_do_action_322
			when 323 then
					--|#line <not available> "eiffel.y"
				yy_do_action_323
			when 324 then
					--|#line <not available> "eiffel.y"
				yy_do_action_324
			when 325 then
					--|#line <not available> "eiffel.y"
				yy_do_action_325
			when 326 then
					--|#line <not available> "eiffel.y"
				yy_do_action_326
			when 327 then
					--|#line <not available> "eiffel.y"
				yy_do_action_327
			when 328 then
					--|#line <not available> "eiffel.y"
				yy_do_action_328
			when 329 then
					--|#line <not available> "eiffel.y"
				yy_do_action_329
			when 330 then
					--|#line <not available> "eiffel.y"
				yy_do_action_330
			when 331 then
					--|#line <not available> "eiffel.y"
				yy_do_action_331
			when 332 then
					--|#line <not available> "eiffel.y"
				yy_do_action_332
			when 333 then
					--|#line <not available> "eiffel.y"
				yy_do_action_333
			when 334 then
					--|#line <not available> "eiffel.y"
				yy_do_action_334
			when 335 then
					--|#line <not available> "eiffel.y"
				yy_do_action_335
			when 336 then
					--|#line <not available> "eiffel.y"
				yy_do_action_336
			when 337 then
					--|#line <not available> "eiffel.y"
				yy_do_action_337
			when 338 then
					--|#line <not available> "eiffel.y"
				yy_do_action_338
			when 339 then
					--|#line <not available> "eiffel.y"
				yy_do_action_339
			when 340 then
					--|#line <not available> "eiffel.y"
				yy_do_action_340
			when 341 then
					--|#line <not available> "eiffel.y"
				yy_do_action_341
			when 342 then
					--|#line <not available> "eiffel.y"
				yy_do_action_342
			when 343 then
					--|#line <not available> "eiffel.y"
				yy_do_action_343
			when 344 then
					--|#line <not available> "eiffel.y"
				yy_do_action_344
			when 345 then
					--|#line <not available> "eiffel.y"
				yy_do_action_345
			when 346 then
					--|#line <not available> "eiffel.y"
				yy_do_action_346
			when 347 then
					--|#line <not available> "eiffel.y"
				yy_do_action_347
			when 348 then
					--|#line <not available> "eiffel.y"
				yy_do_action_348
			when 349 then
					--|#line <not available> "eiffel.y"
				yy_do_action_349
			when 350 then
					--|#line <not available> "eiffel.y"
				yy_do_action_350
			when 351 then
					--|#line <not available> "eiffel.y"
				yy_do_action_351
			when 352 then
					--|#line <not available> "eiffel.y"
				yy_do_action_352
			when 353 then
					--|#line <not available> "eiffel.y"
				yy_do_action_353
			when 354 then
					--|#line <not available> "eiffel.y"
				yy_do_action_354
			when 355 then
					--|#line <not available> "eiffel.y"
				yy_do_action_355
			when 356 then
					--|#line <not available> "eiffel.y"
				yy_do_action_356
			when 357 then
					--|#line <not available> "eiffel.y"
				yy_do_action_357
			when 358 then
					--|#line <not available> "eiffel.y"
				yy_do_action_358
			when 359 then
					--|#line <not available> "eiffel.y"
				yy_do_action_359
			when 360 then
					--|#line <not available> "eiffel.y"
				yy_do_action_360
			when 361 then
					--|#line <not available> "eiffel.y"
				yy_do_action_361
			when 362 then
					--|#line <not available> "eiffel.y"
				yy_do_action_362
			when 363 then
					--|#line <not available> "eiffel.y"
				yy_do_action_363
			when 364 then
					--|#line <not available> "eiffel.y"
				yy_do_action_364
			when 365 then
					--|#line <not available> "eiffel.y"
				yy_do_action_365
			when 366 then
					--|#line <not available> "eiffel.y"
				yy_do_action_366
			when 367 then
					--|#line <not available> "eiffel.y"
				yy_do_action_367
			when 368 then
					--|#line <not available> "eiffel.y"
				yy_do_action_368
			when 369 then
					--|#line <not available> "eiffel.y"
				yy_do_action_369
			when 370 then
					--|#line <not available> "eiffel.y"
				yy_do_action_370
			when 371 then
					--|#line <not available> "eiffel.y"
				yy_do_action_371
			when 372 then
					--|#line <not available> "eiffel.y"
				yy_do_action_372
			when 373 then
					--|#line <not available> "eiffel.y"
				yy_do_action_373
			when 374 then
					--|#line <not available> "eiffel.y"
				yy_do_action_374
			when 375 then
					--|#line <not available> "eiffel.y"
				yy_do_action_375
			when 376 then
					--|#line <not available> "eiffel.y"
				yy_do_action_376
			when 377 then
					--|#line <not available> "eiffel.y"
				yy_do_action_377
			when 378 then
					--|#line <not available> "eiffel.y"
				yy_do_action_378
			when 379 then
					--|#line <not available> "eiffel.y"
				yy_do_action_379
			when 380 then
					--|#line <not available> "eiffel.y"
				yy_do_action_380
			when 381 then
					--|#line <not available> "eiffel.y"
				yy_do_action_381
			when 382 then
					--|#line <not available> "eiffel.y"
				yy_do_action_382
			when 383 then
					--|#line <not available> "eiffel.y"
				yy_do_action_383
			when 384 then
					--|#line <not available> "eiffel.y"
				yy_do_action_384
			when 385 then
					--|#line <not available> "eiffel.y"
				yy_do_action_385
			when 386 then
					--|#line <not available> "eiffel.y"
				yy_do_action_386
			when 387 then
					--|#line <not available> "eiffel.y"
				yy_do_action_387
			when 388 then
					--|#line <not available> "eiffel.y"
				yy_do_action_388
			when 389 then
					--|#line <not available> "eiffel.y"
				yy_do_action_389
			when 390 then
					--|#line <not available> "eiffel.y"
				yy_do_action_390
			when 391 then
					--|#line <not available> "eiffel.y"
				yy_do_action_391
			when 392 then
					--|#line <not available> "eiffel.y"
				yy_do_action_392
			when 393 then
					--|#line <not available> "eiffel.y"
				yy_do_action_393
			when 394 then
					--|#line <not available> "eiffel.y"
				yy_do_action_394
			when 395 then
					--|#line <not available> "eiffel.y"
				yy_do_action_395
			when 396 then
					--|#line <not available> "eiffel.y"
				yy_do_action_396
			when 397 then
					--|#line <not available> "eiffel.y"
				yy_do_action_397
			when 398 then
					--|#line <not available> "eiffel.y"
				yy_do_action_398
			when 399 then
					--|#line <not available> "eiffel.y"
				yy_do_action_399
			when 400 then
					--|#line <not available> "eiffel.y"
				yy_do_action_400
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_401_600 (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
			when 401 then
					--|#line <not available> "eiffel.y"
				yy_do_action_401
			when 402 then
					--|#line <not available> "eiffel.y"
				yy_do_action_402
			when 403 then
					--|#line <not available> "eiffel.y"
				yy_do_action_403
			when 404 then
					--|#line <not available> "eiffel.y"
				yy_do_action_404
			when 405 then
					--|#line <not available> "eiffel.y"
				yy_do_action_405
			when 406 then
					--|#line <not available> "eiffel.y"
				yy_do_action_406
			when 407 then
					--|#line <not available> "eiffel.y"
				yy_do_action_407
			when 408 then
					--|#line <not available> "eiffel.y"
				yy_do_action_408
			when 409 then
					--|#line <not available> "eiffel.y"
				yy_do_action_409
			when 410 then
					--|#line <not available> "eiffel.y"
				yy_do_action_410
			when 411 then
					--|#line <not available> "eiffel.y"
				yy_do_action_411
			when 412 then
					--|#line <not available> "eiffel.y"
				yy_do_action_412
			when 413 then
					--|#line <not available> "eiffel.y"
				yy_do_action_413
			when 414 then
					--|#line <not available> "eiffel.y"
				yy_do_action_414
			when 415 then
					--|#line <not available> "eiffel.y"
				yy_do_action_415
			when 416 then
					--|#line <not available> "eiffel.y"
				yy_do_action_416
			when 417 then
					--|#line <not available> "eiffel.y"
				yy_do_action_417
			when 418 then
					--|#line <not available> "eiffel.y"
				yy_do_action_418
			when 419 then
					--|#line <not available> "eiffel.y"
				yy_do_action_419
			when 420 then
					--|#line <not available> "eiffel.y"
				yy_do_action_420
			when 421 then
					--|#line <not available> "eiffel.y"
				yy_do_action_421
			when 422 then
					--|#line <not available> "eiffel.y"
				yy_do_action_422
			when 423 then
					--|#line <not available> "eiffel.y"
				yy_do_action_423
			when 424 then
					--|#line <not available> "eiffel.y"
				yy_do_action_424
			when 425 then
					--|#line <not available> "eiffel.y"
				yy_do_action_425
			when 426 then
					--|#line <not available> "eiffel.y"
				yy_do_action_426
			when 427 then
					--|#line <not available> "eiffel.y"
				yy_do_action_427
			when 428 then
					--|#line <not available> "eiffel.y"
				yy_do_action_428
			when 429 then
					--|#line <not available> "eiffel.y"
				yy_do_action_429
			when 430 then
					--|#line <not available> "eiffel.y"
				yy_do_action_430
			when 431 then
					--|#line <not available> "eiffel.y"
				yy_do_action_431
			when 432 then
					--|#line <not available> "eiffel.y"
				yy_do_action_432
			when 433 then
					--|#line <not available> "eiffel.y"
				yy_do_action_433
			when 434 then
					--|#line <not available> "eiffel.y"
				yy_do_action_434
			when 435 then
					--|#line <not available> "eiffel.y"
				yy_do_action_435
			when 436 then
					--|#line <not available> "eiffel.y"
				yy_do_action_436
			when 437 then
					--|#line <not available> "eiffel.y"
				yy_do_action_437
			when 438 then
					--|#line <not available> "eiffel.y"
				yy_do_action_438
			when 439 then
					--|#line <not available> "eiffel.y"
				yy_do_action_439
			when 440 then
					--|#line <not available> "eiffel.y"
				yy_do_action_440
			when 441 then
					--|#line <not available> "eiffel.y"
				yy_do_action_441
			when 442 then
					--|#line <not available> "eiffel.y"
				yy_do_action_442
			when 443 then
					--|#line <not available> "eiffel.y"
				yy_do_action_443
			when 444 then
					--|#line <not available> "eiffel.y"
				yy_do_action_444
			when 445 then
					--|#line <not available> "eiffel.y"
				yy_do_action_445
			when 446 then
					--|#line <not available> "eiffel.y"
				yy_do_action_446
			when 447 then
					--|#line <not available> "eiffel.y"
				yy_do_action_447
			when 448 then
					--|#line <not available> "eiffel.y"
				yy_do_action_448
			when 449 then
					--|#line <not available> "eiffel.y"
				yy_do_action_449
			when 450 then
					--|#line <not available> "eiffel.y"
				yy_do_action_450
			when 451 then
					--|#line <not available> "eiffel.y"
				yy_do_action_451
			when 452 then
					--|#line <not available> "eiffel.y"
				yy_do_action_452
			when 453 then
					--|#line <not available> "eiffel.y"
				yy_do_action_453
			when 454 then
					--|#line <not available> "eiffel.y"
				yy_do_action_454
			when 455 then
					--|#line <not available> "eiffel.y"
				yy_do_action_455
			when 456 then
					--|#line <not available> "eiffel.y"
				yy_do_action_456
			when 457 then
					--|#line <not available> "eiffel.y"
				yy_do_action_457
			when 458 then
					--|#line <not available> "eiffel.y"
				yy_do_action_458
			when 459 then
					--|#line <not available> "eiffel.y"
				yy_do_action_459
			when 460 then
					--|#line <not available> "eiffel.y"
				yy_do_action_460
			when 461 then
					--|#line <not available> "eiffel.y"
				yy_do_action_461
			when 462 then
					--|#line <not available> "eiffel.y"
				yy_do_action_462
			when 463 then
					--|#line <not available> "eiffel.y"
				yy_do_action_463
			when 464 then
					--|#line <not available> "eiffel.y"
				yy_do_action_464
			when 465 then
					--|#line <not available> "eiffel.y"
				yy_do_action_465
			when 466 then
					--|#line <not available> "eiffel.y"
				yy_do_action_466
			when 467 then
					--|#line <not available> "eiffel.y"
				yy_do_action_467
			when 468 then
					--|#line <not available> "eiffel.y"
				yy_do_action_468
			when 469 then
					--|#line <not available> "eiffel.y"
				yy_do_action_469
			when 470 then
					--|#line <not available> "eiffel.y"
				yy_do_action_470
			when 471 then
					--|#line <not available> "eiffel.y"
				yy_do_action_471
			when 472 then
					--|#line <not available> "eiffel.y"
				yy_do_action_472
			when 473 then
					--|#line <not available> "eiffel.y"
				yy_do_action_473
			when 474 then
					--|#line <not available> "eiffel.y"
				yy_do_action_474
			when 475 then
					--|#line <not available> "eiffel.y"
				yy_do_action_475
			when 476 then
					--|#line <not available> "eiffel.y"
				yy_do_action_476
			when 477 then
					--|#line <not available> "eiffel.y"
				yy_do_action_477
			when 478 then
					--|#line <not available> "eiffel.y"
				yy_do_action_478
			when 479 then
					--|#line <not available> "eiffel.y"
				yy_do_action_479
			when 480 then
					--|#line <not available> "eiffel.y"
				yy_do_action_480
			when 481 then
					--|#line <not available> "eiffel.y"
				yy_do_action_481
			when 482 then
					--|#line <not available> "eiffel.y"
				yy_do_action_482
			when 483 then
					--|#line <not available> "eiffel.y"
				yy_do_action_483
			when 484 then
					--|#line <not available> "eiffel.y"
				yy_do_action_484
			when 485 then
					--|#line <not available> "eiffel.y"
				yy_do_action_485
			when 486 then
					--|#line <not available> "eiffel.y"
				yy_do_action_486
			when 487 then
					--|#line <not available> "eiffel.y"
				yy_do_action_487
			when 488 then
					--|#line <not available> "eiffel.y"
				yy_do_action_488
			when 489 then
					--|#line <not available> "eiffel.y"
				yy_do_action_489
			when 490 then
					--|#line <not available> "eiffel.y"
				yy_do_action_490
			when 491 then
					--|#line <not available> "eiffel.y"
				yy_do_action_491
			when 492 then
					--|#line <not available> "eiffel.y"
				yy_do_action_492
			when 493 then
					--|#line <not available> "eiffel.y"
				yy_do_action_493
			when 494 then
					--|#line <not available> "eiffel.y"
				yy_do_action_494
			when 495 then
					--|#line <not available> "eiffel.y"
				yy_do_action_495
			when 496 then
					--|#line <not available> "eiffel.y"
				yy_do_action_496
			when 497 then
					--|#line <not available> "eiffel.y"
				yy_do_action_497
			when 498 then
					--|#line <not available> "eiffel.y"
				yy_do_action_498
			when 499 then
					--|#line <not available> "eiffel.y"
				yy_do_action_499
			when 500 then
					--|#line <not available> "eiffel.y"
				yy_do_action_500
			when 501 then
					--|#line <not available> "eiffel.y"
				yy_do_action_501
			when 502 then
					--|#line <not available> "eiffel.y"
				yy_do_action_502
			when 503 then
					--|#line <not available> "eiffel.y"
				yy_do_action_503
			when 504 then
					--|#line <not available> "eiffel.y"
				yy_do_action_504
			when 505 then
					--|#line <not available> "eiffel.y"
				yy_do_action_505
			when 506 then
					--|#line <not available> "eiffel.y"
				yy_do_action_506
			when 507 then
					--|#line <not available> "eiffel.y"
				yy_do_action_507
			when 508 then
					--|#line <not available> "eiffel.y"
				yy_do_action_508
			when 509 then
					--|#line <not available> "eiffel.y"
				yy_do_action_509
			when 510 then
					--|#line <not available> "eiffel.y"
				yy_do_action_510
			when 511 then
					--|#line <not available> "eiffel.y"
				yy_do_action_511
			when 512 then
					--|#line <not available> "eiffel.y"
				yy_do_action_512
			when 513 then
					--|#line <not available> "eiffel.y"
				yy_do_action_513
			when 514 then
					--|#line <not available> "eiffel.y"
				yy_do_action_514
			when 515 then
					--|#line <not available> "eiffel.y"
				yy_do_action_515
			when 516 then
					--|#line <not available> "eiffel.y"
				yy_do_action_516
			when 517 then
					--|#line <not available> "eiffel.y"
				yy_do_action_517
			when 518 then
					--|#line <not available> "eiffel.y"
				yy_do_action_518
			when 519 then
					--|#line <not available> "eiffel.y"
				yy_do_action_519
			when 520 then
					--|#line <not available> "eiffel.y"
				yy_do_action_520
			when 521 then
					--|#line <not available> "eiffel.y"
				yy_do_action_521
			when 522 then
					--|#line <not available> "eiffel.y"
				yy_do_action_522
			when 523 then
					--|#line <not available> "eiffel.y"
				yy_do_action_523
			when 524 then
					--|#line <not available> "eiffel.y"
				yy_do_action_524
			when 525 then
					--|#line <not available> "eiffel.y"
				yy_do_action_525
			when 526 then
					--|#line <not available> "eiffel.y"
				yy_do_action_526
			when 527 then
					--|#line <not available> "eiffel.y"
				yy_do_action_527
			when 528 then
					--|#line <not available> "eiffel.y"
				yy_do_action_528
			when 529 then
					--|#line <not available> "eiffel.y"
				yy_do_action_529
			when 530 then
					--|#line <not available> "eiffel.y"
				yy_do_action_530
			when 531 then
					--|#line <not available> "eiffel.y"
				yy_do_action_531
			when 532 then
					--|#line <not available> "eiffel.y"
				yy_do_action_532
			when 533 then
					--|#line <not available> "eiffel.y"
				yy_do_action_533
			when 534 then
					--|#line <not available> "eiffel.y"
				yy_do_action_534
			when 535 then
					--|#line <not available> "eiffel.y"
				yy_do_action_535
			when 536 then
					--|#line <not available> "eiffel.y"
				yy_do_action_536
			when 537 then
					--|#line <not available> "eiffel.y"
				yy_do_action_537
			when 538 then
					--|#line <not available> "eiffel.y"
				yy_do_action_538
			when 539 then
					--|#line <not available> "eiffel.y"
				yy_do_action_539
			when 540 then
					--|#line <not available> "eiffel.y"
				yy_do_action_540
			when 541 then
					--|#line <not available> "eiffel.y"
				yy_do_action_541
			when 542 then
					--|#line <not available> "eiffel.y"
				yy_do_action_542
			when 543 then
					--|#line <not available> "eiffel.y"
				yy_do_action_543
			when 544 then
					--|#line <not available> "eiffel.y"
				yy_do_action_544
			when 545 then
					--|#line <not available> "eiffel.y"
				yy_do_action_545
			when 546 then
					--|#line <not available> "eiffel.y"
				yy_do_action_546
			when 547 then
					--|#line <not available> "eiffel.y"
				yy_do_action_547
			when 548 then
					--|#line <not available> "eiffel.y"
				yy_do_action_548
			when 549 then
					--|#line <not available> "eiffel.y"
				yy_do_action_549
			when 550 then
					--|#line <not available> "eiffel.y"
				yy_do_action_550
			when 551 then
					--|#line <not available> "eiffel.y"
				yy_do_action_551
			when 552 then
					--|#line <not available> "eiffel.y"
				yy_do_action_552
			when 553 then
					--|#line <not available> "eiffel.y"
				yy_do_action_553
			when 554 then
					--|#line <not available> "eiffel.y"
				yy_do_action_554
			when 555 then
					--|#line <not available> "eiffel.y"
				yy_do_action_555
			when 556 then
					--|#line <not available> "eiffel.y"
				yy_do_action_556
			when 557 then
					--|#line <not available> "eiffel.y"
				yy_do_action_557
			when 558 then
					--|#line <not available> "eiffel.y"
				yy_do_action_558
			when 559 then
					--|#line <not available> "eiffel.y"
				yy_do_action_559
			when 560 then
					--|#line <not available> "eiffel.y"
				yy_do_action_560
			when 561 then
					--|#line <not available> "eiffel.y"
				yy_do_action_561
			when 562 then
					--|#line <not available> "eiffel.y"
				yy_do_action_562
			when 563 then
					--|#line <not available> "eiffel.y"
				yy_do_action_563
			when 564 then
					--|#line <not available> "eiffel.y"
				yy_do_action_564
			when 565 then
					--|#line <not available> "eiffel.y"
				yy_do_action_565
			when 566 then
					--|#line <not available> "eiffel.y"
				yy_do_action_566
			when 567 then
					--|#line <not available> "eiffel.y"
				yy_do_action_567
			when 568 then
					--|#line <not available> "eiffel.y"
				yy_do_action_568
			when 569 then
					--|#line <not available> "eiffel.y"
				yy_do_action_569
			when 570 then
					--|#line <not available> "eiffel.y"
				yy_do_action_570
			when 571 then
					--|#line <not available> "eiffel.y"
				yy_do_action_571
			when 572 then
					--|#line <not available> "eiffel.y"
				yy_do_action_572
			when 573 then
					--|#line <not available> "eiffel.y"
				yy_do_action_573
			when 574 then
					--|#line <not available> "eiffel.y"
				yy_do_action_574
			when 575 then
					--|#line <not available> "eiffel.y"
				yy_do_action_575
			when 576 then
					--|#line <not available> "eiffel.y"
				yy_do_action_576
			when 577 then
					--|#line <not available> "eiffel.y"
				yy_do_action_577
			when 578 then
					--|#line <not available> "eiffel.y"
				yy_do_action_578
			when 579 then
					--|#line <not available> "eiffel.y"
				yy_do_action_579
			when 580 then
					--|#line <not available> "eiffel.y"
				yy_do_action_580
			when 581 then
					--|#line <not available> "eiffel.y"
				yy_do_action_581
			when 582 then
					--|#line <not available> "eiffel.y"
				yy_do_action_582
			when 583 then
					--|#line <not available> "eiffel.y"
				yy_do_action_583
			when 584 then
					--|#line <not available> "eiffel.y"
				yy_do_action_584
			when 585 then
					--|#line <not available> "eiffel.y"
				yy_do_action_585
			when 586 then
					--|#line <not available> "eiffel.y"
				yy_do_action_586
			when 587 then
					--|#line <not available> "eiffel.y"
				yy_do_action_587
			when 588 then
					--|#line <not available> "eiffel.y"
				yy_do_action_588
			when 589 then
					--|#line <not available> "eiffel.y"
				yy_do_action_589
			when 590 then
					--|#line <not available> "eiffel.y"
				yy_do_action_590
			when 591 then
					--|#line <not available> "eiffel.y"
				yy_do_action_591
			when 592 then
					--|#line <not available> "eiffel.y"
				yy_do_action_592
			when 593 then
					--|#line <not available> "eiffel.y"
				yy_do_action_593
			when 594 then
					--|#line <not available> "eiffel.y"
				yy_do_action_594
			when 595 then
					--|#line <not available> "eiffel.y"
				yy_do_action_595
			when 596 then
					--|#line <not available> "eiffel.y"
				yy_do_action_596
			when 597 then
					--|#line <not available> "eiffel.y"
				yy_do_action_597
			when 598 then
					--|#line <not available> "eiffel.y"
				yy_do_action_598
			when 599 then
					--|#line <not available> "eiffel.y"
				yy_do_action_599
			when 600 then
					--|#line <not available> "eiffel.y"
				yy_do_action_600
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_601_800 (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
			when 601 then
					--|#line <not available> "eiffel.y"
				yy_do_action_601
			when 602 then
					--|#line <not available> "eiffel.y"
				yy_do_action_602
			when 603 then
					--|#line <not available> "eiffel.y"
				yy_do_action_603
			when 604 then
					--|#line <not available> "eiffel.y"
				yy_do_action_604
			when 605 then
					--|#line <not available> "eiffel.y"
				yy_do_action_605
			when 606 then
					--|#line <not available> "eiffel.y"
				yy_do_action_606
			when 607 then
					--|#line <not available> "eiffel.y"
				yy_do_action_607
			when 608 then
					--|#line <not available> "eiffel.y"
				yy_do_action_608
			when 609 then
					--|#line <not available> "eiffel.y"
				yy_do_action_609
			when 610 then
					--|#line <not available> "eiffel.y"
				yy_do_action_610
			when 611 then
					--|#line <not available> "eiffel.y"
				yy_do_action_611
			when 612 then
					--|#line <not available> "eiffel.y"
				yy_do_action_612
			when 613 then
					--|#line <not available> "eiffel.y"
				yy_do_action_613
			when 614 then
					--|#line <not available> "eiffel.y"
				yy_do_action_614
			when 615 then
					--|#line <not available> "eiffel.y"
				yy_do_action_615
			when 616 then
					--|#line <not available> "eiffel.y"
				yy_do_action_616
			when 617 then
					--|#line <not available> "eiffel.y"
				yy_do_action_617
			when 618 then
					--|#line <not available> "eiffel.y"
				yy_do_action_618
			when 619 then
					--|#line <not available> "eiffel.y"
				yy_do_action_619
			when 620 then
					--|#line <not available> "eiffel.y"
				yy_do_action_620
			when 621 then
					--|#line <not available> "eiffel.y"
				yy_do_action_621
			when 622 then
					--|#line <not available> "eiffel.y"
				yy_do_action_622
			when 623 then
					--|#line <not available> "eiffel.y"
				yy_do_action_623
			when 624 then
					--|#line <not available> "eiffel.y"
				yy_do_action_624
			when 625 then
					--|#line <not available> "eiffel.y"
				yy_do_action_625
			when 626 then
					--|#line <not available> "eiffel.y"
				yy_do_action_626
			when 627 then
					--|#line <not available> "eiffel.y"
				yy_do_action_627
			when 628 then
					--|#line <not available> "eiffel.y"
				yy_do_action_628
			when 629 then
					--|#line <not available> "eiffel.y"
				yy_do_action_629
			when 630 then
					--|#line <not available> "eiffel.y"
				yy_do_action_630
			when 631 then
					--|#line <not available> "eiffel.y"
				yy_do_action_631
			when 632 then
					--|#line <not available> "eiffel.y"
				yy_do_action_632
			when 633 then
					--|#line <not available> "eiffel.y"
				yy_do_action_633
			when 634 then
					--|#line <not available> "eiffel.y"
				yy_do_action_634
			when 635 then
					--|#line <not available> "eiffel.y"
				yy_do_action_635
			when 636 then
					--|#line <not available> "eiffel.y"
				yy_do_action_636
			when 637 then
					--|#line <not available> "eiffel.y"
				yy_do_action_637
			when 638 then
					--|#line <not available> "eiffel.y"
				yy_do_action_638
			when 639 then
					--|#line <not available> "eiffel.y"
				yy_do_action_639
			when 640 then
					--|#line <not available> "eiffel.y"
				yy_do_action_640
			when 641 then
					--|#line <not available> "eiffel.y"
				yy_do_action_641
			when 642 then
					--|#line <not available> "eiffel.y"
				yy_do_action_642
			when 643 then
					--|#line <not available> "eiffel.y"
				yy_do_action_643
			when 644 then
					--|#line <not available> "eiffel.y"
				yy_do_action_644
			when 645 then
					--|#line <not available> "eiffel.y"
				yy_do_action_645
			when 646 then
					--|#line <not available> "eiffel.y"
				yy_do_action_646
			when 647 then
					--|#line <not available> "eiffel.y"
				yy_do_action_647
			when 648 then
					--|#line <not available> "eiffel.y"
				yy_do_action_648
			when 649 then
					--|#line <not available> "eiffel.y"
				yy_do_action_649
			when 650 then
					--|#line <not available> "eiffel.y"
				yy_do_action_650
			when 651 then
					--|#line <not available> "eiffel.y"
				yy_do_action_651
			when 652 then
					--|#line <not available> "eiffel.y"
				yy_do_action_652
			when 653 then
					--|#line <not available> "eiffel.y"
				yy_do_action_653
			when 654 then
					--|#line <not available> "eiffel.y"
				yy_do_action_654
			when 655 then
					--|#line <not available> "eiffel.y"
				yy_do_action_655
			when 656 then
					--|#line <not available> "eiffel.y"
				yy_do_action_656
			when 657 then
					--|#line <not available> "eiffel.y"
				yy_do_action_657
			when 658 then
					--|#line <not available> "eiffel.y"
				yy_do_action_658
			when 659 then
					--|#line <not available> "eiffel.y"
				yy_do_action_659
			when 660 then
					--|#line <not available> "eiffel.y"
				yy_do_action_660
			when 661 then
					--|#line <not available> "eiffel.y"
				yy_do_action_661
			when 662 then
					--|#line <not available> "eiffel.y"
				yy_do_action_662
			when 663 then
					--|#line <not available> "eiffel.y"
				yy_do_action_663
			when 664 then
					--|#line <not available> "eiffel.y"
				yy_do_action_664
			when 665 then
					--|#line <not available> "eiffel.y"
				yy_do_action_665
			when 666 then
					--|#line <not available> "eiffel.y"
				yy_do_action_666
			when 667 then
					--|#line <not available> "eiffel.y"
				yy_do_action_667
			when 668 then
					--|#line <not available> "eiffel.y"
				yy_do_action_668
			when 669 then
					--|#line <not available> "eiffel.y"
				yy_do_action_669
			when 670 then
					--|#line <not available> "eiffel.y"
				yy_do_action_670
			when 671 then
					--|#line <not available> "eiffel.y"
				yy_do_action_671
			when 672 then
					--|#line <not available> "eiffel.y"
				yy_do_action_672
			when 673 then
					--|#line <not available> "eiffel.y"
				yy_do_action_673
			when 674 then
					--|#line <not available> "eiffel.y"
				yy_do_action_674
			when 675 then
					--|#line <not available> "eiffel.y"
				yy_do_action_675
			when 676 then
					--|#line <not available> "eiffel.y"
				yy_do_action_676
			when 677 then
					--|#line <not available> "eiffel.y"
				yy_do_action_677
			when 678 then
					--|#line <not available> "eiffel.y"
				yy_do_action_678
			when 679 then
					--|#line <not available> "eiffel.y"
				yy_do_action_679
			when 680 then
					--|#line <not available> "eiffel.y"
				yy_do_action_680
			when 681 then
					--|#line <not available> "eiffel.y"
				yy_do_action_681
			when 682 then
					--|#line <not available> "eiffel.y"
				yy_do_action_682
			when 683 then
					--|#line <not available> "eiffel.y"
				yy_do_action_683
			when 684 then
					--|#line <not available> "eiffel.y"
				yy_do_action_684
			when 685 then
					--|#line <not available> "eiffel.y"
				yy_do_action_685
			when 686 then
					--|#line <not available> "eiffel.y"
				yy_do_action_686
			when 687 then
					--|#line <not available> "eiffel.y"
				yy_do_action_687
			when 688 then
					--|#line <not available> "eiffel.y"
				yy_do_action_688
			when 689 then
					--|#line <not available> "eiffel.y"
				yy_do_action_689
			when 690 then
					--|#line <not available> "eiffel.y"
				yy_do_action_690
			when 691 then
					--|#line <not available> "eiffel.y"
				yy_do_action_691
			when 692 then
					--|#line <not available> "eiffel.y"
				yy_do_action_692
			when 693 then
					--|#line <not available> "eiffel.y"
				yy_do_action_693
			when 694 then
					--|#line <not available> "eiffel.y"
				yy_do_action_694
			when 695 then
					--|#line <not available> "eiffel.y"
				yy_do_action_695
			when 696 then
					--|#line <not available> "eiffel.y"
				yy_do_action_696
			when 697 then
					--|#line <not available> "eiffel.y"
				yy_do_action_697
			when 698 then
					--|#line <not available> "eiffel.y"
				yy_do_action_698
			when 699 then
					--|#line <not available> "eiffel.y"
				yy_do_action_699
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_1
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_2
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				type_node := yyvs85.item (yyvsp85)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp85 := yyvsp85 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_3
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not feature_parser or type_parser or expression_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				feature_node := yyvs52.item (yyvsp52)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp52 := yyvsp52 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_4
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not expression_parser or type_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				expression_node := yyvs48.item (yyvsp48)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_5
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not indexing_parser or type_parser or expression_parser or feature_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				indexing_node := yyvs113.item (yyvsp113)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp113 := yyvsp113 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_6
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not invariant_parser or type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser then
					raise_error
				end
				invariant_node := yyvs66.item (yyvsp66)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp66 := yyvsp66 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_7
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not entity_declaration_parser or type_parser or expression_parser or feature_parser or indexing_parser or invariant_parser then
					raise_error
				end
				entity_declaration_node := Void
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_8
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not entity_declaration_parser or type_parser or expression_parser or feature_parser or indexing_parser or invariant_parser then
					raise_error
				end
				entity_declaration_node := yyvs127.item (yyvsp127)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp14 := yyvsp14 -1
	yyvsp127 := yyvsp127 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_9
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs20.item (yyvsp20 - 1) as l_external then
					temp_string_as1 := l_external.second
				else
					temp_string_as1 := Void
				end
				if attached yyvs20.item (yyvsp20) as l_obsolete then
					temp_string_as2 := l_obsolete.second
				else
					temp_string_as2 := Void
				end
				
				root_node := new_class_description (yyvs2.item (yyvsp2), temp_string_as1,
					is_deferred, is_expanded, is_frozen_class, is_external_class, is_partial_class,
					yyvs113.item (yyvsp113 - 1), yyvs113.item (yyvsp113), yyvs111.item (yyvsp111), yyvs119.item (yyvsp119 - 1), yyvs119.item (yyvsp119), yyvs95.item (yyvsp95), yyvs94.item (yyvsp94), yyvs103.item (yyvsp103), yyvs66.item (yyvsp66), suppliers, temp_string_as2, yyvs14.item (yyvsp14))
				if attached root_node as l_root_node then
					l_root_node.set_text_positions (
						formal_generics_end_position,
						conforming_inheritance_end_position,
						non_conforming_inheritance_end_position,
						features_end_position,
						formal_generics_character_end_position,
						conforming_inheritance_character_end_position,
						non_conforming_inheritance_character_end_position,
						features_character_end_position
					)
					if attached yyvs20.item (yyvsp20 - 1) as l_external then
						l_root_node.set_alias_keyword (l_external.first)
					end
					if attached yyvs20.item (yyvsp20) as l_obsolete then
						l_root_node.set_obsolete_keyword (l_obsolete.first)
					end
					l_root_node.set_header_mark (frozen_keyword, expanded_keyword, deferred_keyword, external_keyword)
					l_root_node.set_class_keyword (yyvs14.item (yyvsp14 - 1))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 19
	yyvsp1 := yyvsp1 -4
	yyvsp113 := yyvsp113 -2
	yyvsp14 := yyvsp14 -2
	yyvsp2 := yyvsp2 -1
	yyvsp111 := yyvsp111 -1
	yyvsp20 := yyvsp20 -2
	yyvsp119 := yyvsp119 -2
	yyvsp95 := yyvsp95 -1
	yyvsp94 := yyvsp94 -1
	yyvsp103 := yyvsp103 -1
	yyvsp66 := yyvsp66 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_10
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

conforming_inheritance_flag := False; non_conforming_inheritance_flag := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_11
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_conforming_inheritance_end_positions; conforming_inheritance_flag := True
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_12
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_non_conforming_inheritance_end_positions
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_13
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_features_end_positions 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_14
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_feature_clause_end_positions 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_15
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp113 := yyvsp113 + 1
	if yyvsp113 >= yyvsc113 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs113")
		end
		yyvsc113 := yyvsc113 + yyInitial_yyvs_size
		yyvs113 := yyspecial_routines113.aliased_resized_area (yyvs113, yyvsc113)
	end
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_16
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs113.item (yyvsp113) as l_list then
					yyval113 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp15 := yyvsp15 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_17
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_indexing_clause_as (0) as l_list then
					yyval113 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp113 := yyvsp113 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp113 >= yyvsc113 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs113")
		end
		yyvsc113 := yyvsc113 + yyInitial_yyvs_size
		yyvs113 := yyspecial_routines113.aliased_resized_area (yyvs113, yyvsc113)
	end
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_18
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs113.item (yyvsp113) as l_list then
					yyval113 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp15 := yyvsp15 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_19
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_indexing_clause_as (0) as l_list then
					yyval113 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp113 := yyvsp113 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp113 >= yyvsc113 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs113")
		end
		yyvsc113 := yyvsc113 + yyInitial_yyvs_size
		yyvs113 := yyspecial_routines113.aliased_resized_area (yyvs113, yyvsc113)
	end
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_20
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp113 := yyvsp113 + 1
	if yyvsp113 >= yyvsc113 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs113")
		end
		yyvsc113 := yyvsc113 + yyInitial_yyvs_size
		yyvs113 := yyspecial_routines113.aliased_resized_area (yyvs113, yyvsc113)
	end
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_21
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_indexing_clause_as (0) as l_list then
						yyval113 := l_list
						l_list.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
						l_list.set_end_keyword (yyvs14.item (yyvsp14))
				end		
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename,
						once "Missing `attribute' keyword before `end' keyword."))
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp113 := yyvsp113 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp113 >= yyvsc113 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs113")
		end
		yyvsc113 := yyvsc113 + yyInitial_yyvs_size
		yyvs113 := yyspecial_routines113.aliased_resized_area (yyvs113, yyvsc113)
	end
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_22
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs113.item (yyvsp113) as l_list then
					yyval113 := l_list
					if attached yyvs15.item (yyvsp15) as l_indexing then
						l_list.set_indexing_keyword (extract_keyword (l_indexing))
					end
					if attached yyvs14.item (yyvsp14) as l_end then
						l_list.set_end_keyword (l_end)
					end
				end				
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename,
						once "Missing `attribute' keyword before `end' keyword."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp15 := yyvsp15 -1
	yyvsp1 := yyvsp1 -2
	yyvsp14 := yyvsp14 -1
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_23
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval113 := ast_factory.new_indexing_clause_as (counter_value + 1)
				if attached yyval113 as l_list and then attached yyvs60.item (yyvsp60) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp113 := yyvsp113 + 1
	yyvsp60 := yyvsp60 -1
	if yyvsp113 >= yyvsc113 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs113")
		end
		yyvsc113 := yyvsc113 + yyInitial_yyvs_size
		yyvs113 := yyspecial_routines113.aliased_resized_area (yyvs113, yyvsc113)
	end
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_24
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval113 := yyvs113.item (yyvsp113)
				if attached yyval113 as l_list and then attached yyvs60.item (yyvsp60) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp60 := yyvsp60 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_25
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval113 := ast_factory.new_indexing_clause_as (counter_value + 1)
				if attached yyval113 as l_list and then attached yyvs60.item (yyvsp60) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp113 := yyvsp113 + 1
	yyvsp60 := yyvsp60 -1
	if yyvsp113 >= yyvsc113 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs113")
		end
		yyvsc113 := yyvsc113 + yyInitial_yyvs_size
		yyvs113 := yyspecial_routines113.aliased_resized_area (yyvs113, yyvsc113)
	end
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_26
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval113 := yyvs113.item (yyvsp113)
				if attached yyval113 as l_list and then attached yyvs60.item (yyvsp60) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp60 := yyvsp60 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_27
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_28
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_29
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval60 := ast_factory.new_index_as (yyvs2.item (yyvsp2), yyvs92.item (yyvsp92), yyvs4.item (yyvsp4 - 1))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp60 := yyvsp60 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp92 := yyvsp92 -1
	if yyvsp60 >= yyvsc60 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs60")
		end
		yyvsc60 := yyvsc60 + yyInitial_yyvs_size
		yyvs60 := yyspecial_routines60.aliased_resized_area (yyvs60, yyvsc60)
	end
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_30
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval60 := ast_factory.new_index_as (Void, yyvs92.item (yyvsp92), Void)
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs92.item (yyvsp92)), token_column (yyvs92.item (yyvsp92)), filename,
						once "Missing `Index' part of `Index_clause'."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp60 := yyvsp60 + 1
	yyvsp92 := yyvsp92 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp60 >= yyvsc60 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs60")
		end
		yyvsc60 := yyvsc60 + yyInitial_yyvs_size
		yyvs60 := yyspecial_routines60.aliased_resized_area (yyvs60, yyvsc60)
	end
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_31
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval60 := ast_factory.new_index_as (yyvs2.item (yyvsp2), yyvs92.item (yyvsp92), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp60 := yyvsp60 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp92 := yyvsp92 -1
	if yyvsp60 >= yyvsc60 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs60")
		end
		yyvsc60 := yyvsc60 + yyInitial_yyvs_size
		yyvs60 := yyspecial_routines60.aliased_resized_area (yyvs60, yyvsc60)
	end
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_32
			--|#line <not available> "eiffel.y"
		local
			yyval92: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval92 := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if attached yyval92 as l_list and then attached yyvs30.item (yyvsp30) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp92 := yyvsp92 + 1
	yyvsp30 := yyvsp30 -1
	if yyvsp92 >= yyvsc92 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs92")
		end
		yyvsc92 := yyvsc92 + yyInitial_yyvs_size
		yyvs92 := yyspecial_routines92.aliased_resized_area (yyvs92, yyvsc92)
	end
	yyspecial_routines92.force (yyvs92, yyval92, yyvsp92)
end
		end

	yy_do_action_33
			--|#line <not available> "eiffel.y"
		local
			yyval92: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval92 := yyvs92.item (yyvsp92)
				if attached yyval92 as l_list and then attached yyvs30.item (yyvsp30) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp30 := yyvsp30 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines92.force (yyvs92, yyval92, yyvsp92)
end
		end

	yy_do_action_34
			--|#line <not available> "eiffel.y"
		local
			yyval92: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval92 := ast_factory.new_eiffel_list_atomic_as (0)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp92 := yyvsp92 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp92 >= yyvsc92 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs92")
		end
		yyvsc92 := yyvsc92 + yyInitial_yyvs_size
		yyvs92 := yyspecial_routines92.aliased_resized_area (yyvs92, yyvsc92)
	end
	yyspecial_routines92.force (yyvs92, yyval92, yyvsp92)
end
		end

	yy_do_action_35
			--|#line <not available> "eiffel.y"
		local
			yyval92: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval92 := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if attached yyval92 as l_list and then attached yyvs30.item (yyvsp30) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp92 := yyvsp92 + 1
	yyvsp30 := yyvsp30 -1
	if yyvsp92 >= yyvsc92 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs92")
		end
		yyvsc92 := yyvsc92 + yyInitial_yyvs_size
		yyvs92 := yyspecial_routines92.aliased_resized_area (yyvs92, yyvsc92)
	end
	yyspecial_routines92.force (yyvs92, yyval92, yyvsp92)
end
		end

	yy_do_action_36
			--|#line <not available> "eiffel.y"
		local
			yyval92: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval92 := yyvs92.item (yyvsp92)
				if attached yyval92 as l_list and then attached yyvs30.item (yyvsp30) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp30 := yyvsp30 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines92.force (yyvs92, yyval92, yyvsp92)
end
		end

	yy_do_action_37
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_38
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs30.item (yyvsp30) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_39
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := ast_factory.new_custom_attribute_as (yyvs42.item (yyvsp42), Void, yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp30 := yyvsp30 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp42 := yyvsp42 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_40
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := ast_factory.new_custom_attribute_as (yyvs42.item (yyvsp42), yyvs84.item (yyvsp84), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp30 := yyvsp30 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp42 := yyvsp42 -1
	yyvsp84 := yyvsp84 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_41
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			is_supplier_recorded := False
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_42
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			is_supplier_recorded := True
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_43
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if not il_parser then
				is_supplier_recorded := False
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_44
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if not il_parser then
				is_supplier_recorded := True
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_45
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_46
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_deferred := True
				deferred_keyword := yyvs12.item (yyvsp12)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_47
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_expanded := True
				expanded_keyword := yyvs14.item (yyvsp14)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp14 := yyvsp14 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_48
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_49
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_frozen_class := True
				frozen_keyword := yyvs14.item (yyvsp14)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_50
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_51
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if il_parser then
					is_external_class := True
					external_keyword := yyvs14.item (yyvsp14)
				else
						-- Trigger a syntax error.
					raise_error
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_52
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval14 := yyvs14.item (yyvsp14);
			is_partial_class := false;
			formal_parameters.wipe_out
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_53
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval14 := yyvs14.item (yyvsp14);
			is_partial_class := true;
			formal_parameters.wipe_out
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_54
			--|#line <not available> "eiffel.y"
		local
			yyval20: detachable PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp20 := yyvsp20 + 1
	if yyvsp20 >= yyvsc20 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs20")
		end
		yyvsc20 := yyvsc20 + yyInitial_yyvs_size
		yyvs20 := yyspecial_routines20.aliased_resized_area (yyvs20, yyvsc20)
	end
	yyspecial_routines20.force (yyvs20, yyval20, yyvsp20)
end
		end

	yy_do_action_55
			--|#line <not available> "eiffel.y"
		local
			yyval20: detachable PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval20 := ast_factory.new_keyword_string_pair (yyvs14.item (yyvsp14), yyvs16.item (yyvsp16))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp20 >= yyvsc20 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs20")
		end
		yyvsc20 := yyvsc20 + yyInitial_yyvs_size
		yyvs20 := yyspecial_routines20.aliased_resized_area (yyvs20, yyvsc20)
	end
	yyspecial_routines20.force (yyvs20, yyval20, yyvsp20)
end
		end

	yy_do_action_56
			--|#line <not available> "eiffel.y"
		local
			yyval103: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp103 := yyvsp103 + 1
	if yyvsp103 >= yyvsc103 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs103")
		end
		yyvsc103 := yyvsc103 + yyInitial_yyvs_size
		yyvs103 := yyspecial_routines103.aliased_resized_area (yyvs103, yyvsc103)
	end
	yyspecial_routines103.force (yyvs103, yyval103, yyvsp103)
end
		end

	yy_do_action_57
			--|#line <not available> "eiffel.y"
		local
			yyval103: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs103.item (yyvsp103) as l_list then
					if l_list.is_empty then
						yyval103 := Void
					else
						yyval103 := l_list
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines103.force (yyvs103, yyval103, yyvsp103)
end
		end

	yy_do_action_58
			--|#line <not available> "eiffel.y"
		local
			yyval103: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval103 := ast_factory.new_eiffel_list_feature_clause_as (counter_value + 1)
				if attached yyval103 as l_list and then attached yyvs53.item (yyvsp53) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp103 := yyvsp103 + 1
	yyvsp53 := yyvsp53 -1
	if yyvsp103 >= yyvsc103 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs103")
		end
		yyvsc103 := yyvsc103 + yyInitial_yyvs_size
		yyvs103 := yyspecial_routines103.aliased_resized_area (yyvs103, yyvsc103)
	end
	yyspecial_routines103.force (yyvs103, yyval103, yyvsp103)
end
		end

	yy_do_action_59
			--|#line <not available> "eiffel.y"
		local
			yyval103: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval103 := yyvs103.item (yyvsp103)
				if attached yyval103 as l_list and then attached yyvs53.item (yyvsp53) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp53 := yyvsp53 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines103.force (yyvs103, yyval103, yyvsp103)
end
		end

	yy_do_action_60
			--|#line <not available> "eiffel.y"
		local
			yyval53: detachable FEATURE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_feature_clause_as (yyvs37.item (yyvsp37),
				ast_factory.new_eiffel_list_feature_as (0), fclause_pos, feature_clause_end_position) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp53 := yyvsp53 + 1
	yyvsp37 := yyvsp37 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp53 >= yyvsc53 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs53")
		end
		yyvsc53 := yyvsc53 + yyInitial_yyvs_size
		yyvs53 := yyspecial_routines53.aliased_resized_area (yyvs53, yyvsc53)
	end
	yyspecial_routines53.force (yyvs53, yyval53, yyvsp53)
end
		end

	yy_do_action_61
			--|#line <not available> "eiffel.y"
		local
			yyval53: detachable FEATURE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_feature_clause_as (yyvs37.item (yyvsp37), yyvs102.item (yyvsp102), fclause_pos, feature_clause_end_position) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp53 := yyvsp53 + 1
	yyvsp37 := yyvsp37 -1
	yyvsp1 := yyvsp1 -3
	yyvsp102 := yyvsp102 -1
	if yyvsp53 >= yyvsc53 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs53")
		end
		yyvsc53 := yyvsc53 + yyInitial_yyvs_size
		yyvs53 := yyspecial_routines53.aliased_resized_area (yyvs53, yyvsc53)
	end
	yyspecial_routines53.force (yyvs53, yyval53, yyvsp53)
end
		end

	yy_do_action_62
			--|#line <not available> "eiffel.y"
		local
			yyval37: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := yyvs37.item (yyvsp37) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 -1
	yyvsp14 := yyvsp14 -1
	yyspecial_routines37.force (yyvs37, yyval37, yyvsp37)
end
		end

	yy_do_action_63
			--|#line <not available> "eiffel.y"
		local
			yyval37: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs14.item (yyvsp14) as l_keyword then
						-- Originally, it was 8, I changed it to 7, delete the following line when fully tested. (Jason)
					l_keyword.set_position (line, column, position, 7, character_column, character_position, 7)
					fclause_pos := l_keyword
				else
						-- Originally, it was 8, I changed it to 7 (Jason)
					fclause_pos := ast_factory.new_feature_keyword_as (line, column, position, 7, character_column, character_position, 7, Current)
				end
				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp37 := yyvsp37 + 1
	if yyvsp37 >= yyvsc37 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs37")
		end
		yyvsc37 := yyvsc37 + yyInitial_yyvs_size
		yyvs37 := yyspecial_routines37.aliased_resized_area (yyvs37, yyvsc37)
	end
	yyspecial_routines37.force (yyvs37, yyval37, yyvsp37)
end
		end

	yy_do_action_64
			--|#line <not available> "eiffel.y"
		local
			yyval37: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp37 := yyvsp37 + 1
	if yyvsp37 >= yyvsc37 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs37")
		end
		yyvsc37 := yyvsc37 + yyInitial_yyvs_size
		yyvs37 := yyspecial_routines37.aliased_resized_area (yyvs37, yyvsc37)
	end
	yyspecial_routines37.force (yyvs37, yyval37, yyvsp37)
end
		end

	yy_do_action_65
			--|#line <not available> "eiffel.y"
		local
			yyval37: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_client_as (yyvs112.item (yyvsp112)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp37 := yyvsp37 + 1
	yyvsp112 := yyvsp112 -1
	if yyvsp37 >= yyvsc37 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs37")
		end
		yyvsc37 := yyvsc37 + yyInitial_yyvs_size
		yyvs37 := yyspecial_routines37.aliased_resized_area (yyvs37, yyvsc37)
	end
	yyspecial_routines37.force (yyvs37, yyval37, yyvsp37)
end
		end

	yy_do_action_66
			--|#line <not available> "eiffel.y"
		local
			yyval112: detachable CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				
					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply consider as {NONE}.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)), filename,
							once "Empty Client_list is not allowed and will be assumed to be {NONE}."))
				end
				yyval112 := ast_factory.new_class_list_as (1)
				if attached yyval112 as l_list and then attached new_none_id as l_none_id then
					l_list.reverse_extend (l_none_id)
					l_list.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_list.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp112 >= yyvsc112 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs112")
		end
		yyvsc112 := yyvsc112 + yyInitial_yyvs_size
		yyvs112 := yyspecial_routines112.aliased_resized_area (yyvs112, yyvsc112)
	end
	yyspecial_routines112.force (yyvs112, yyval112, yyvsp112)
end
		end

	yy_do_action_67
			--|#line <not available> "eiffel.y"
		local
			yyval112: detachable CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs112.item (yyvsp112) as l_list then
					yyval112 := l_list
					l_list.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_list.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyspecial_routines112.force (yyvs112, yyval112, yyvsp112)
end
		end

	yy_do_action_68
			--|#line <not available> "eiffel.y"
		local
			yyval112: detachable CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval112 := ast_factory.new_class_list_as (counter_value + 1)
				if attached yyval112 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val)
					suppliers.insert_light_supplier_id (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp112 := yyvsp112 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp112 >= yyvsc112 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs112")
		end
		yyvsc112 := yyvsc112 + yyInitial_yyvs_size
		yyvs112 := yyspecial_routines112.aliased_resized_area (yyvs112, yyvsc112)
	end
	yyspecial_routines112.force (yyvs112, yyval112, yyvsp112)
end
		end

	yy_do_action_69
			--|#line <not available> "eiffel.y"
		local
			yyval112: detachable CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval112 := yyvs112.item (yyvsp112)
				if attached yyval112 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val)
					suppliers.insert_light_supplier_id (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines112.force (yyvs112, yyval112, yyvsp112)
end
		end

	yy_do_action_70
			--|#line <not available> "eiffel.y"
		local
			yyval102: detachable EIFFEL_LIST [FEATURE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval102 := ast_factory.new_eiffel_list_feature_as (counter_value + 1)
				if attached yyval102 as l_list and then attached yyvs52.item (yyvsp52) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp102 := yyvsp102 + 1
	yyvsp52 := yyvsp52 -1
	if yyvsp102 >= yyvsc102 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs102")
		end
		yyvsc102 := yyvsc102 + yyInitial_yyvs_size
		yyvs102 := yyspecial_routines102.aliased_resized_area (yyvs102, yyvsc102)
	end
	yyspecial_routines102.force (yyvs102, yyval102, yyvsp102)
end
		end

	yy_do_action_71
			--|#line <not available> "eiffel.y"
		local
			yyval102: detachable EIFFEL_LIST [FEATURE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval102 := yyvs102.item (yyvsp102)
				if attached yyval102 as l_list and then attached yyvs52.item (yyvsp52) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp52 := yyvsp52 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines102.force (yyvs102, yyval102, yyvsp102)
end
		end

	yy_do_action_72
			--|#line <not available> "eiffel.y"
		local
			yyval4: detachable SYMBOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp4 := yyvsp4 + 1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_73
			--|#line <not available> "eiffel.y"
		local
			yyval4: detachable SYMBOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_74
			--|#line <not available> "eiffel.y"
		local
			yyval52: detachable FEATURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval52 := ast_factory.new_feature_as (yyvs104.item (yyvsp104), yyvs32.item (yyvsp32), feature_indexes, position)
				if has_syntax_warning then
					if attached feature_indexes as fi and then fi.has_global_once then
						if attached fi.once_status_index_as as fi_tok then
							report_one_warning (
								create {SYNTAX_WARNING}.make (token_line (fi_tok), token_column (fi_tok), filename,
								once "Specifying once_status in indexing note is Obsolete, please use once (%"PROCESS%")."))
						else
							check indexes_has_once_status_index: False end
						end
					end
				end
				if 
					attached (yyval52) as l_feature_as and then 
					attached l_feature_as.once_as as l_once_as
				then
					if l_once_as.has_key_conflict (yyval52) then
						report_one_error (ast_factory.new_vvok1_error (token_line (l_once_as), token_column (l_once_as), filename, yyval52))
					elseif l_once_as.has_invalid_key (yyval52) then
						if attached l_once_as.invalid_key (yyval52) as l_once_invalid_key then
							report_one_error (ast_factory.new_vvok2_error (token_line (l_once_invalid_key), token_column (l_once_invalid_key), filename, yyval52))
						else
							report_one_error (ast_factory.new_vvok2_error (token_line (l_once_as), token_column (l_once_as), filename, yyval52))
						end
					end
				end

				feature_indexes := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp52 := yyvsp52 -1
	yyvsp1 := yyvsp1 -3
	yyvsp104 := yyvsp104 -1
	yyvsp32 := yyvsp32 -1
	yyspecial_routines52.force (yyvs52, yyval52, yyvsp52)
end
		end

	yy_do_action_75
			--|#line <not available> "eiffel.y"
		local
			yyval52: detachable FEATURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

enter_scope
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp52 := yyvsp52 + 1
	if yyvsp52 >= yyvsc52 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs52")
		end
		yyvsc52 := yyvsc52 + yyInitial_yyvs_size
		yyvs52 := yyspecial_routines52.aliased_resized_area (yyvs52, yyvsc52)
	end
	yyspecial_routines52.force (yyvs52, yyval52, yyvsp52)
end
		end

	yy_do_action_76
			--|#line <not available> "eiffel.y"
		local
			yyval52: detachable FEATURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

leave_scope
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp52 := yyvsp52 + 1
	if yyvsp52 >= yyvsc52 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs52")
		end
		yyvsc52 := yyvsc52 + yyInitial_yyvs_size
		yyvs52 := yyspecial_routines52.aliased_resized_area (yyvs52, yyvsc52)
	end
	yyspecial_routines52.force (yyvs52, yyval52, yyvsp52)
end
		end

	yy_do_action_77
			--|#line <not available> "eiffel.y"
		local
			yyval104: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval104 := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if attached yyval104 as l_list and then attached yyvs91.item (yyvsp91) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp104 := yyvsp104 + 1
	yyvsp91 := yyvsp91 -1
	if yyvsp104 >= yyvsc104 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs104")
		end
		yyvsc104 := yyvsc104 + yyInitial_yyvs_size
		yyvs104 := yyspecial_routines104.aliased_resized_area (yyvs104, yyvsc104)
	end
	yyspecial_routines104.force (yyvs104, yyval104, yyvsp104)
end
		end

	yy_do_action_78
			--|#line <not available> "eiffel.y"
		local
			yyval104: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval104 := yyvs104.item (yyvsp104)
				if attached yyval104 as l_list and then attached yyvs91.item (yyvsp91) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp91 := yyvsp91 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines104.force (yyvs104, yyval104, yyvsp104)
end
		end

	yy_do_action_79
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval91 := yyvs91.item (yyvsp91) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_80
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs91.item (yyvsp91) as l_name then
					yyval91 := l_name
					l_name.set_frozen_keyword (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 -1
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_81
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval91 := yyvs91.item (yyvsp91) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_82
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs17.item (yyvsp17) as l_alias then
					yyval91 := ast_factory.new_feature_name_alias_as (yyvs2.item (yyvsp2), l_alias.alias_name, has_convert_mark, l_alias.alias_keyword, l_alias.convert_keyword)
				else
					yyval91 := ast_factory.new_feature_name_alias_as (yyvs2.item (yyvsp2), Void, has_convert_mark, Void, Void)
				end
				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp91 := yyvsp91 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp17 := yyvsp17 -1
	if yyvsp91 >= yyvsc91 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs91")
		end
		yyvsc91 := yyvsc91 + yyInitial_yyvs_size
		yyvs91 := yyspecial_routines91.aliased_resized_area (yyvs91, yyvsc91)
	end
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_83
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval91 := ast_factory.new_feature_name_id_as (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp91 := yyvsp91 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp91 >= yyvsc91 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs91")
		end
		yyvsc91 := yyvsc91 + yyInitial_yyvs_size
		yyvs91 := yyspecial_routines91.aliased_resized_area (yyvs91, yyvsc91)
	end
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_84
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval91 := yyvs91.item (yyvsp91) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_85
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval91 := yyvs91.item (yyvsp91) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_86
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval91 := ast_factory.new_infix_as (yyvs16.item (yyvsp16), yyvs14.item (yyvsp14))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename,
						once "Use the alias form of the infix routine."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp91 := yyvsp91 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp91 >= yyvsc91 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs91")
		end
		yyvsc91 := yyvsc91 + yyInitial_yyvs_size
		yyvs91 := yyspecial_routines91.aliased_resized_area (yyvs91, yyvsc91)
	end
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_87
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval91 := ast_factory.new_prefix_as (yyvs16.item (yyvsp16), yyvs14.item (yyvsp14))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename,
						once "Use the alias form of the prefix routine."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp91 := yyvsp91 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp91 >= yyvsc91 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs91")
		end
		yyvsc91 := yyvsc91 + yyInitial_yyvs_size
		yyvs91 := yyspecial_routines91.aliased_resized_area (yyvs91, yyvsc91)
	end
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_88
			--|#line <not available> "eiffel.y"
		local
			yyval17: detachable ALIAS_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval17 := ast_factory.new_alias_triple (yyvs14.item (yyvsp14 - 1), yyvs16.item (yyvsp16), yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp17 := yyvsp17 + 1
	yyvsp14 := yyvsp14 -2
	yyvsp16 := yyvsp16 -1
	if yyvsp17 >= yyvsc17 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs17")
		end
		yyvsc17 := yyvsc17 + yyInitial_yyvs_size
		yyvs17 := yyspecial_routines17.aliased_resized_area (yyvs17, yyvsc17)
	end
	yyspecial_routines17.force (yyvs17, yyval17, yyvsp17)
end
		end

	yy_do_action_89
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_90
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_91
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_92
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_93
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

has_convert_mark := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp14 := yyvsp14 + 1
	if yyvsp14 >= yyvsc14 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs14")
		end
		yyvsc14 := yyvsc14 + yyInitial_yyvs_size
		yyvs14 := yyspecial_routines14.aliased_resized_area (yyvs14, yyvsc14)
	end
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_94
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

has_convert_mark := True
				yyval14 := yyvs14.item (yyvsp14)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_95
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := Void 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp14 := yyvsp14 + 1
	if yyvsp14 >= yyvsc14 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs14")
		end
		yyvsc14 := yyvsc14 + yyInitial_yyvs_size
		yyvs14 := yyspecial_routines14.aliased_resized_area (yyvs14, yyvsc14)
	end
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_96
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval14 := extract_keyword (yyvs15.item (yyvsp15))
				report_deprecated_use_of_keyword_is (yyval14)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp14 := yyvsp14 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp14 >= yyvsc14 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs14")
		end
		yyvsc14 := yyvsc14 + yyInitial_yyvs_size
		yyvs14 := yyspecial_routines14.aliased_resized_area (yyvs14, yyvsc14)
	end
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_97
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Attribute case
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval32 := ast_factory.new_body_as (Void, yyvs85.item (yyvsp85), l_assigner_mark.second, Void, yyvs4.item (yyvsp4), Void, l_assigner_mark.first, yyvs113.item (yyvsp113))
				else
					yyval32 := ast_factory.new_body_as (Void, yyvs85.item (yyvsp85), Void, Void, yyvs4.item (yyvsp4), Void, Void, yyvs113.item (yyvsp113))
				end				
				feature_indexes := yyvs113.item (yyvsp113)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp32 := yyvsp32 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp85 := yyvsp85 -1
	yyvsp19 := yyvsp19 -1
	yyvsp113 := yyvsp113 -1
	if yyvsp32 >= yyvsc32 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs32")
		end
		yyvsc32 := yyvsc32 + yyInitial_yyvs_size
		yyvs32 := yyspecial_routines32.aliased_resized_area (yyvs32, yyvsc32)
	end
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_98
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Constant case
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval32 := ast_factory.new_body_as (Void, yyvs85.item (yyvsp85), l_assigner_mark.second, yyvs38.item (yyvsp38), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), l_assigner_mark.first, yyvs113.item (yyvsp113))
				else
					yyval32 := ast_factory.new_body_as (Void, yyvs85.item (yyvsp85), Void, yyvs38.item (yyvsp38), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), Void, yyvs113.item (yyvsp113))
				end
				
				feature_indexes := yyvs113.item (yyvsp113)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp32 := yyvsp32 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp85 := yyvsp85 -1
	yyvsp19 := yyvsp19 -1
	yyvsp38 := yyvsp38 -1
	yyvsp113 := yyvsp113 -1
	if yyvsp32 >= yyvsc32 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs32")
		end
		yyvsc32 := yyvsc32 + yyInitial_yyvs_size
		yyvs32 := yyspecial_routines32.aliased_resized_area (yyvs32, yyvsc32)
	end
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_99
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Constant case
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval32 := ast_factory.new_body_as (Void, yyvs85.item (yyvsp85), l_assigner_mark.second, yyvs38.item (yyvsp38), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), l_assigner_mark.first, yyvs113.item (yyvsp113))
				else
					yyval32 := ast_factory.new_body_as (Void, yyvs85.item (yyvsp85), Void, yyvs38.item (yyvsp38), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs113.item (yyvsp113))
				end
				feature_indexes := yyvs113.item (yyvsp113)
				report_deprecated_use_of_keyword_is (extract_keyword (yyvs15.item (yyvsp15)))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp32 := yyvsp32 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp85 := yyvsp85 -1
	yyvsp19 := yyvsp19 -1
	yyvsp15 := yyvsp15 -1
	yyvsp38 := yyvsp38 -1
	yyvsp113 := yyvsp113 -1
	if yyvsp32 >= yyvsc32 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs32")
		end
		yyvsc32 := yyvsc32 + yyInitial_yyvs_size
		yyvs32 := yyspecial_routines32.aliased_resized_area (yyvs32, yyvsc32)
	end
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_100
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- procedure without arguments		
				yyval32 := ast_factory.new_body_as (Void, Void, Void, yyvs80.item (yyvsp80), Void, yyvs14.item (yyvsp14), Void, yyvs113.item (yyvsp113))
				feature_indexes := yyvs113.item (yyvsp113)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp113 := yyvsp113 -1
	yyvsp80 := yyvsp80 -1
	if yyvsp32 >= yyvsc32 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs32")
		end
		yyvsc32 := yyvsc32 + yyInitial_yyvs_size
		yyvs32 := yyspecial_routines32.aliased_resized_area (yyvs32, yyvsc32)
	end
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_101
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function without arguments
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval32 := ast_factory.new_body_as (Void, yyvs85.item (yyvsp85), l_assigner_mark.second, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), l_assigner_mark.first, yyvs113.item (yyvsp113))
				else
					yyval32 := ast_factory.new_body_as (Void, yyvs85.item (yyvsp85), Void, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs113.item (yyvsp113))
				end
				feature_indexes := yyvs113.item (yyvsp113)
				report_deprecated_use_of_keyword_is (extract_keyword (yyvs15.item (yyvsp15)))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp32 := yyvsp32 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp85 := yyvsp85 -1
	yyvsp19 := yyvsp19 -1
	yyvsp15 := yyvsp15 -1
	yyvsp113 := yyvsp113 -1
	yyvsp80 := yyvsp80 -1
	if yyvsp32 >= yyvsc32 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs32")
		end
		yyvsc32 := yyvsc32 + yyInitial_yyvs_size
		yyvs32 := yyspecial_routines32.aliased_resized_area (yyvs32, yyvsc32)
	end
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_102
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function without arguments
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval32 := ast_factory.new_body_as (Void, yyvs85.item (yyvsp85), l_assigner_mark.second, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), Void, l_assigner_mark.first, yyvs113.item (yyvsp113))
				else
					yyval32 := ast_factory.new_body_as (Void, yyvs85.item (yyvsp85), Void, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), Void, Void, yyvs113.item (yyvsp113))
				end
				
				feature_indexes := yyvs113.item (yyvsp113)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp32 := yyvsp32 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp85 := yyvsp85 -1
	yyvsp19 := yyvsp19 -1
	yyvsp113 := yyvsp113 -1
	yyvsp80 := yyvsp80 -1
	if yyvsp32 >= yyvsc32 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs32")
		end
		yyvsc32 := yyvsc32 + yyInitial_yyvs_size
		yyvs32 := yyspecial_routines32.aliased_resized_area (yyvs32, yyvsc32)
	end
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_103
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- procedure with arguments
				yyval32 := ast_factory.new_body_as (yyvs129.item (yyvsp129), Void, Void, yyvs80.item (yyvsp80), Void, yyvs14.item (yyvsp14), Void, yyvs113.item (yyvsp113))
				feature_indexes := yyvs113.item (yyvsp113)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp32 := yyvsp32 + 1
	yyvsp129 := yyvsp129 -1
	yyvsp14 := yyvsp14 -1
	yyvsp113 := yyvsp113 -1
	yyvsp80 := yyvsp80 -1
	if yyvsp32 >= yyvsc32 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs32")
		end
		yyvsc32 := yyvsc32 + yyInitial_yyvs_size
		yyvs32 := yyspecial_routines32.aliased_resized_area (yyvs32, yyvsc32)
	end
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_104
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function with arguments
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval32 := ast_factory.new_body_as (yyvs129.item (yyvsp129), yyvs85.item (yyvsp85), l_assigner_mark.second, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), yyvs14.item (yyvsp14), l_assigner_mark.first, yyvs113.item (yyvsp113))
				else
					yyval32 := ast_factory.new_body_as (yyvs129.item (yyvsp129), yyvs85.item (yyvsp85), Void, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), yyvs14.item (yyvsp14), Void, yyvs113.item (yyvsp113))
				end				
				feature_indexes := yyvs113.item (yyvsp113)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp32 := yyvsp32 + 1
	yyvsp129 := yyvsp129 -1
	yyvsp4 := yyvsp4 -1
	yyvsp85 := yyvsp85 -1
	yyvsp19 := yyvsp19 -1
	yyvsp14 := yyvsp14 -1
	yyvsp113 := yyvsp113 -1
	yyvsp80 := yyvsp80 -1
	if yyvsp32 >= yyvsc32 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs32")
		end
		yyvsc32 := yyvsc32 + yyInitial_yyvs_size
		yyvs32 := yyspecial_routines32.aliased_resized_area (yyvs32, yyvsc32)
	end
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_105
			--|#line <not available> "eiffel.y"
		local
			yyval19: detachable PAIR [KEYWORD_AS, ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval19 := ast_factory.new_assigner_mark_as (Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp19 := yyvsp19 + 1
	if yyvsp19 >= yyvsc19 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs19")
		end
		yyvsc19 := yyvsc19 + yyInitial_yyvs_size
		yyvs19 := yyspecial_routines19.aliased_resized_area (yyvs19, yyvsc19)
	end
	yyspecial_routines19.force (yyvs19, yyval19, yyvsp19)
end
		end

	yy_do_action_106
			--|#line <not available> "eiffel.y"
		local
			yyval19: detachable PAIR [KEYWORD_AS, ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval19 := ast_factory.new_assigner_mark_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp19 := yyvsp19 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp19 >= yyvsc19 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs19")
		end
		yyvsc19 := yyvsc19 + yyInitial_yyvs_size
		yyvs19 := yyspecial_routines19.aliased_resized_area (yyvs19, yyvsc19)
	end
	yyspecial_routines19.force (yyvs19, yyval19, yyvsp19)
end
		end

	yy_do_action_107
			--|#line <not available> "eiffel.y"
		local
			yyval38: detachable CONSTANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval38 := ast_factory.new_constant_as (yyvs30.item (yyvsp30)) 
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp30 := yyvsp30 -1
	if yyvsp38 >= yyvsc38 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs38")
		end
		yyvsc38 := yyvsc38 + yyInitial_yyvs_size
		yyvs38 := yyspecial_routines38.aliased_resized_area (yyvs38, yyvsc38)
	end
	yyspecial_routines38.force (yyvs38, yyval38, yyvsp38)
end
		end

	yy_do_action_108
			--|#line <not available> "eiffel.y"
		local
			yyval38: detachable CONSTANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval38 := ast_factory.new_constant_as (yyvs10.item (yyvsp10)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp10 := yyvsp10 -1
	if yyvsp38 >= yyvsc38 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs38")
		end
		yyvsc38 := yyvsc38 + yyInitial_yyvs_size
		yyvs38 := yyspecial_routines38.aliased_resized_area (yyvs38, yyvsc38)
	end
	yyspecial_routines38.force (yyvs38, yyval38, yyvsp38)
end
		end

	yy_do_action_109
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval119 := Void 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp119 := yyvsp119 + 1
	if yyvsp119 >= yyvsc119 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs119")
		end
		yyvsc119 := yyvsc119 + yyInitial_yyvs_size
		yyvs119 := yyspecial_routines119.aliased_resized_area (yyvs119, yyvsc119)
	end
	yyspecial_routines119.force (yyvs119, yyval119, yyvsp119)
end
		end

	yy_do_action_110
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not conforming_inheritance_flag then
						-- Conforming inheritance
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename,
							once "Use `inherit ANY' or do not specify an empty inherit clause"))
					end
					yyval119 := ast_factory.new_eiffel_list_parent_as (0)
					if attached yyval119 as l_inheritance then
						l_inheritance.set_inheritance_tokens (yyvs14.item (yyvsp14), Void, Void, Void)
					end
				else
						-- Raise error as conforming inheritance has already been specified
					if non_conforming_inheritance_flag then
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename, "Conforming inheritance clause must come before non conforming inheritance clause"))
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename, "Only one conforming inheritance clause allowed per class"))
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp119 := yyvsp119 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp119 >= yyvsc119 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs119")
		end
		yyvsc119 := yyvsc119 + yyInitial_yyvs_size
		yyvs119 := yyspecial_routines119.aliased_resized_area (yyvs119, yyvsc119)
	end
	yyspecial_routines119.force (yyvs119, yyval119, yyvsp119)
end
		end

	yy_do_action_111
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not conforming_inheritance_flag then
						-- Conforming inheritance
					yyval119 := yyvs119.item (yyvsp119)
					if attached yyval119 as l_inheritance then
						l_inheritance.set_inheritance_tokens (yyvs14.item (yyvsp14), Void, Void, Void)
					end
				else
						-- Raise error as conforming inheritance has already been specified
					if non_conforming_inheritance_flag then
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename, "Conforming inheritance clause must come before non conforming inheritance clause"))
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename, "Only one conforming inheritance clause allowed per class"))
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines119.force (yyvs119, yyval119, yyvsp119)
end
		end

	yy_do_action_112
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval119 := yyvs119.item (yyvsp119)
				if attached yyval119 as l_inheritance then
					l_inheritance.set_inheritance_tokens (yyvs14.item (yyvsp14), yyvs4.item (yyvsp4 - 1), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp119 := yyvsp119 -1
	yyvsp14 := yyvsp14 -1
	yyvsp4 := yyvsp4 -2
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines119.force (yyvs119, yyval119, yyvsp119)
end
		end

	yy_do_action_113
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Non conforming inheritance
				
				if not non_conforming_inheritance_flag then
						-- Check to make sure Class_identifier is 'NONE'
						-- An error will be thrown if TYPE_AS is not of type NONE_TYPE_AS
					ast_factory.validate_non_conforming_inheritance_type (Current, new_class_type (yyvs2.item (yyvsp2), Void))

						-- Set flag so that no more inheritance clauses can be added as non-conforming is always the last one.
					non_conforming_inheritance_flag := True
				else
						-- Raise error as non conforming inheritance has already been specified
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename, "Only one non-conforming inheritance clause allowed per class"))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp119 := yyvsp119 + 1
	if yyvsp119 >= yyvsc119 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs119")
		end
		yyvsc119 := yyvsc119 + yyInitial_yyvs_size
		yyvs119 := yyspecial_routines119.aliased_resized_area (yyvs119, yyvsc119)
	end
	yyspecial_routines119.force (yyvs119, yyval119, yyvsp119)
end
		end

	yy_do_action_114
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval119 := ast_factory.new_eiffel_list_parent_as (counter_value + 1)
				if attached yyval119 as l_list and then attached yyvs72.item (yyvsp72) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp119 := yyvsp119 + 1
	yyvsp72 := yyvsp72 -1
	if yyvsp119 >= yyvsc119 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs119")
		end
		yyvsc119 := yyvsc119 + yyInitial_yyvs_size
		yyvs119 := yyspecial_routines119.aliased_resized_area (yyvs119, yyvsc119)
	end
	yyspecial_routines119.force (yyvs119, yyval119, yyvsp119)
end
		end

	yy_do_action_115
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval119 := yyvs119.item (yyvsp119)
				if attached yyval119 as l_list and then attached yyvs72.item (yyvsp72) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp72 := yyvsp72 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines119.force (yyvs119, yyval119, yyvsp119)
end
		end

	yy_do_action_116
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_117
			--|#line <not available> "eiffel.y"
		local
			yyval87: detachable CLASS_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval87 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs125.item (yyvsp125)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp87 := yyvsp87 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp125 := yyvsp125 -1
	if yyvsp87 >= yyvsc87 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs87")
		end
		yyvsc87 := yyvsc87 + yyInitial_yyvs_size
		yyvs87 := yyspecial_routines87.aliased_resized_area (yyvs87, yyvsc87)
	end
	yyspecial_routines87.force (yyvs87, yyval87, yyvsp87)
end
		end

	yy_do_action_118
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := ast_factory.new_parent_as (yyvs87.item (yyvsp87), Void, Void, Void, Void, Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp72 := yyvsp72 + 1
	yyvsp87 := yyvsp87 -1
	if yyvsp72 >= yyvsc72 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs72")
		end
		yyvsc72 := yyvsc72 + yyInitial_yyvs_size
		yyvs72 := yyspecial_routines72.aliased_resized_area (yyvs72, yyvsc72)
	end
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_119
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := ast_factory.new_parent_as (yyvs87.item (yyvsp87), Void, Void, Void, Void, yyvs110.item (yyvsp110), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp72 := yyvsp72 + 1
	yyvsp87 := yyvsp87 -1
	yyvsp110 := yyvsp110 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp72 >= yyvsc72 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs72")
		end
		yyvsc72 := yyvsc72 + yyInitial_yyvs_size
		yyvs72 := yyspecial_routines72.aliased_resized_area (yyvs72, yyvsc72)
	end
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_120
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := ast_factory.new_parent_as (yyvs87.item (yyvsp87), Void, Void, Void, yyvs109.item (yyvsp109), yyvs110.item (yyvsp110), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp72 := yyvsp72 + 1
	yyvsp87 := yyvsp87 -1
	yyvsp109 := yyvsp109 -1
	yyvsp110 := yyvsp110 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp72 >= yyvsc72 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs72")
		end
		yyvsc72 := yyvsc72 + yyInitial_yyvs_size
		yyvs72 := yyspecial_routines72.aliased_resized_area (yyvs72, yyvsc72)
	end
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_121
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := ast_factory.new_parent_as (yyvs87.item (yyvsp87), Void, Void, yyvs108.item (yyvsp108), yyvs109.item (yyvsp109), yyvs110.item (yyvsp110), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp72 := yyvsp72 + 1
	yyvsp87 := yyvsp87 -1
	yyvsp108 := yyvsp108 -1
	yyvsp109 := yyvsp109 -1
	yyvsp110 := yyvsp110 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp72 >= yyvsc72 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs72")
		end
		yyvsc72 := yyvsc72 + yyInitial_yyvs_size
		yyvs72 := yyspecial_routines72.aliased_resized_area (yyvs72, yyvsc72)
	end
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_122
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := ast_factory.new_parent_as (yyvs87.item (yyvsp87), Void, yyvs99.item (yyvsp99), yyvs108.item (yyvsp108), yyvs109.item (yyvsp109), yyvs110.item (yyvsp110), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp72 := yyvsp72 + 1
	yyvsp87 := yyvsp87 -1
	yyvsp99 := yyvsp99 -1
	yyvsp108 := yyvsp108 -1
	yyvsp109 := yyvsp109 -1
	yyvsp110 := yyvsp110 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp72 >= yyvsc72 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs72")
		end
		yyvsc72 := yyvsc72 + yyInitial_yyvs_size
		yyvs72 := yyspecial_routines72.aliased_resized_area (yyvs72, yyvsc72)
	end
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_123
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := ast_factory.new_parent_as (yyvs87.item (yyvsp87), yyvs121.item (yyvsp121), yyvs99.item (yyvsp99), yyvs108.item (yyvsp108), yyvs109.item (yyvsp109), yyvs110.item (yyvsp110), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp72 := yyvsp72 + 1
	yyvsp87 := yyvsp87 -1
	yyvsp121 := yyvsp121 -1
	yyvsp99 := yyvsp99 -1
	yyvsp108 := yyvsp108 -1
	yyvsp109 := yyvsp109 -1
	yyvsp110 := yyvsp110 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp72 >= yyvsc72 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs72")
		end
		yyvsc72 := yyvsc72 + yyInitial_yyvs_size
		yyvs72 := yyspecial_routines72.aliased_resized_area (yyvs72, yyvsc72)
	end
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_124
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable RENAME_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval121 := ast_factory.new_rename_clause_as (Void, yyvs14.item (yyvsp14))
				if is_constraint_renaming then
					report_one_error (
						create {SYNTAX_ERROR}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename,
						"Empty rename clause."))
				else
					report_one_warning (
							create {SYNTAX_WARNING}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename,
							"Remove empty rename clauses."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp121 := yyvsp121 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp121 >= yyvsc121 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs121")
		end
		yyvsc121 := yyvsc121 + yyInitial_yyvs_size
		yyvs121 := yyspecial_routines121.aliased_resized_area (yyvs121, yyvsc121)
	end
	yyspecial_routines121.force (yyvs121, yyval121, yyvsp121)
end
		end

	yy_do_action_125
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable RENAME_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval121 := ast_factory.new_rename_clause_as (yyvs120.item (yyvsp120), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp121 := yyvsp121 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp1 := yyvsp1 -2
	yyvsp120 := yyvsp120 -1
	if yyvsp121 >= yyvsc121 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs121")
		end
		yyvsc121 := yyvsc121 + yyInitial_yyvs_size
		yyvs121 := yyspecial_routines121.aliased_resized_area (yyvs121, yyvsc121)
	end
	yyspecial_routines121.force (yyvs121, yyval121, yyvsp121)
end
		end

	yy_do_action_126
			--|#line <not available> "eiffel.y"
		local
			yyval120: detachable EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval120 := ast_factory.new_eiffel_list_rename_as (counter_value + 1)
				if attached yyval120 as l_list and then attached yyvs76.item (yyvsp76) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp120 := yyvsp120 + 1
	yyvsp76 := yyvsp76 -1
	if yyvsp120 >= yyvsc120 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs120")
		end
		yyvsc120 := yyvsc120 + yyInitial_yyvs_size
		yyvs120 := yyspecial_routines120.aliased_resized_area (yyvs120, yyvsc120)
	end
	yyspecial_routines120.force (yyvs120, yyval120, yyvsp120)
end
		end

	yy_do_action_127
			--|#line <not available> "eiffel.y"
		local
			yyval120: detachable EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval120 := yyvs120.item (yyvsp120)
				if attached yyval120 as l_list and then attached yyvs76.item (yyvsp76) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp76 := yyvsp76 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines120.force (yyvs120, yyval120, yyvsp120)
end
		end

	yy_do_action_128
			--|#line <not available> "eiffel.y"
		local
			yyval76: detachable RENAME_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval76 := ast_factory.new_rename_as (yyvs91.item (yyvsp91 - 1), yyvs91.item (yyvsp91), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp76 := yyvsp76 + 1
	yyvsp91 := yyvsp91 -2
	yyvsp14 := yyvsp14 -1
	if yyvsp76 >= yyvsc76 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs76")
		end
		yyvsc76 := yyvsc76 + yyInitial_yyvs_size
		yyvs76 := yyspecial_routines76.aliased_resized_area (yyvs76, yyvsc76)
	end
	yyspecial_routines76.force (yyvs76, yyval76, yyvsp76)
end
		end

	yy_do_action_129
			--|#line <not available> "eiffel.y"
		local
			yyval99: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp99 := yyvsp99 + 1
	if yyvsp99 >= yyvsc99 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs99")
		end
		yyvsc99 := yyvsc99 + yyInitial_yyvs_size
		yyvs99 := yyspecial_routines99.aliased_resized_area (yyvs99, yyvsc99)
	end
	yyspecial_routines99.force (yyvs99, yyval99, yyvsp99)
end
		end

	yy_do_action_130
			--|#line <not available> "eiffel.y"
		local
			yyval99: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval99 := yyvs99.item (yyvsp99) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines99.force (yyvs99, yyval99, yyvsp99)
end
		end

	yy_do_action_131
			--|#line <not available> "eiffel.y"
		local
			yyval99: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval99 := ast_factory.new_export_clause_as (yyvs98.item (yyvsp98), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp99 := yyvsp99 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp1 := yyvsp1 -2
	yyvsp98 := yyvsp98 -1
	if yyvsp99 >= yyvsc99 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs99")
		end
		yyvsc99 := yyvsc99 + yyInitial_yyvs_size
		yyvs99 := yyspecial_routines99.aliased_resized_area (yyvs99, yyvsc99)
	end
	yyspecial_routines99.force (yyvs99, yyval99, yyvsp99)
end
		end

	yy_do_action_132
			--|#line <not available> "eiffel.y"
		local
			yyval99: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval99 := ast_factory.new_export_clause_as (Void, yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp99 := yyvsp99 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp99 >= yyvsc99 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs99")
		end
		yyvsc99 := yyvsc99 + yyInitial_yyvs_size
		yyvs99 := yyspecial_routines99.aliased_resized_area (yyvs99, yyvsc99)
	end
	yyspecial_routines99.force (yyvs99, yyval99, yyvsp99)
end
		end

	yy_do_action_133
			--|#line <not available> "eiffel.y"
		local
			yyval98: detachable EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval98 := ast_factory.new_eiffel_list_export_item_as (counter_value + 1)
				if attached yyval98 as l_list and then attached yyvs47.item (yyvsp47) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp98 := yyvsp98 + 1
	yyvsp47 := yyvsp47 -1
	if yyvsp98 >= yyvsc98 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs98")
		end
		yyvsc98 := yyvsc98 + yyInitial_yyvs_size
		yyvs98 := yyspecial_routines98.aliased_resized_area (yyvs98, yyvsc98)
	end
	yyspecial_routines98.force (yyvs98, yyval98, yyvsp98)
end
		end

	yy_do_action_134
			--|#line <not available> "eiffel.y"
		local
			yyval98: detachable EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval98 := yyvs98.item (yyvsp98)
				if attached yyval98 as l_list and then attached yyvs47.item (yyvsp47) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp47 := yyvsp47 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines98.force (yyvs98, yyval98, yyvsp98)
end
		end

	yy_do_action_135
			--|#line <not available> "eiffel.y"
		local
			yyval47: detachable EXPORT_ITEM_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs54.item (yyvsp54) = Void then
						-- Per ECMA, this should be rejected. For now we only raise
						-- a warning. And on the compiler side, we will simply ignore them altogether.
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (token_line (yyvs112.item (yyvsp112)), token_column (yyvs112.item (yyvsp112)), filename,
								once "Empty Feature_set is not allowed and will be discarded."))
					end
				end
				yyval47 := ast_factory.new_export_item_as (ast_factory.new_client_as (yyvs112.item (yyvsp112)), yyvs54.item (yyvsp54))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp47 := yyvsp47 + 1
	yyvsp112 := yyvsp112 -1
	yyvsp54 := yyvsp54 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp47 >= yyvsc47 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs47")
		end
		yyvsc47 := yyvsc47 + yyInitial_yyvs_size
		yyvs47 := yyspecial_routines47.aliased_resized_area (yyvs47, yyvsc47)
	end
	yyspecial_routines47.force (yyvs47, yyval47, yyvsp47)
end
		end

	yy_do_action_136
			--|#line <not available> "eiffel.y"
		local
			yyval54: detachable FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp54 := yyvsp54 + 1
	if yyvsp54 >= yyvsc54 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs54")
		end
		yyvsc54 := yyvsc54 + yyInitial_yyvs_size
		yyvs54 := yyspecial_routines54.aliased_resized_area (yyvs54, yyvsc54)
	end
	yyspecial_routines54.force (yyvs54, yyval54, yyvsp54)
end
		end

	yy_do_action_137
			--|#line <not available> "eiffel.y"
		local
			yyval54: detachable FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval54 := ast_factory.new_all_as (yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp54 := yyvsp54 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp54 >= yyvsc54 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs54")
		end
		yyvsc54 := yyvsc54 + yyInitial_yyvs_size
		yyvs54 := yyspecial_routines54.aliased_resized_area (yyvs54, yyvsc54)
	end
	yyspecial_routines54.force (yyvs54, yyval54, yyvsp54)
end
		end

	yy_do_action_138
			--|#line <not available> "eiffel.y"
		local
			yyval54: detachable FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval54 := ast_factory.new_feature_list_as (yyvs104.item (yyvsp104)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp54 := yyvsp54 + 1
	yyvsp104 := yyvsp104 -1
	if yyvsp54 >= yyvsc54 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs54")
		end
		yyvsc54 := yyvsc54 + yyInitial_yyvs_size
		yyvs54 := yyspecial_routines54.aliased_resized_area (yyvs54, yyvsc54)
	end
	yyspecial_routines54.force (yyvs54, yyval54, yyvsp54)
end
		end

	yy_do_action_139
			--|#line <not available> "eiffel.y"
		local
			yyval94: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp94 := yyvsp94 + 1
	if yyvsp94 >= yyvsc94 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs94")
		end
		yyvsc94 := yyvsc94 + yyInitial_yyvs_size
		yyvs94 := yyspecial_routines94.aliased_resized_area (yyvs94, yyvsc94)
	end
	yyspecial_routines94.force (yyvs94, yyval94, yyvsp94)
end
		end

	yy_do_action_140
			--|#line <not available> "eiffel.y"
		local
			yyval94: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if attached yyvs94.item (yyvsp94) as l_list then
				yyval94 := l_list
				l_list.set_convert_keyword (yyvs14.item (yyvsp14))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines94.force (yyvs94, yyval94, yyvsp94)
end
		end

	yy_do_action_141
			--|#line <not available> "eiffel.y"
		local
			yyval94: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval94 := ast_factory.new_eiffel_list_convert (counter_value + 1)
			if attached yyval94 as l_list and then attached yyvs39.item (yyvsp39) as l_val then
				l_list.reverse_extend (l_val)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp94 := yyvsp94 + 1
	yyvsp39 := yyvsp39 -1
	if yyvsp94 >= yyvsc94 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs94")
		end
		yyvsc94 := yyvsc94 + yyInitial_yyvs_size
		yyvs94 := yyspecial_routines94.aliased_resized_area (yyvs94, yyvsc94)
	end
	yyspecial_routines94.force (yyvs94, yyval94, yyvsp94)
end
		end

	yy_do_action_142
			--|#line <not available> "eiffel.y"
		local
			yyval94: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval94 := yyvs94.item (yyvsp94)
			if attached yyval94 as l_list and then attached yyvs39.item (yyvsp39) as l_val then
				l_list.reverse_extend (l_val)
				ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp39 := yyvsp39 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines94.force (yyvs94, yyval94, yyvsp94)
end
		end

	yy_do_action_143
			--|#line <not available> "eiffel.y"
		local
			yyval39: detachable CONVERT_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			yyval39 := ast_factory.new_convert_feat_as (True, yyvs91.item (yyvsp91), yyvs125.item (yyvsp125), yyvs4.item (yyvsp4 - 3), yyvs4.item (yyvsp4), Void, yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp39 := yyvsp39 + 1
	yyvsp91 := yyvsp91 -1
	yyvsp4 := yyvsp4 -4
	yyvsp125 := yyvsp125 -1
	if yyvsp39 >= yyvsc39 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs39")
		end
		yyvsc39 := yyvsc39 + yyInitial_yyvs_size
		yyvs39 := yyspecial_routines39.aliased_resized_area (yyvs39, yyvsc39)
	end
	yyspecial_routines39.force (yyvs39, yyval39, yyvsp39)
end
		end

	yy_do_action_144
			--|#line <not available> "eiffel.y"
		local
			yyval39: detachable CONVERT_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- False because this is not a conversion feature used as a creation
				-- procedure.
			yyval39 := ast_factory.new_convert_feat_as (False, yyvs91.item (yyvsp91), yyvs125.item (yyvsp125), Void, Void, yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp39 := yyvsp39 + 1
	yyvsp91 := yyvsp91 -1
	yyvsp4 := yyvsp4 -3
	yyvsp125 := yyvsp125 -1
	if yyvsp39 >= yyvsc39 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs39")
		end
		yyvsc39 := yyvsc39 + yyInitial_yyvs_size
		yyvs39 := yyspecial_routines39.aliased_resized_area (yyvs39, yyvsc39)
	end
	yyspecial_routines39.force (yyvs39, yyval39, yyvsp39)
end
		end

	yy_do_action_145
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable EIFFEL_LIST [FEAT_NAME_ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval105 := yyvs105.item (yyvsp105) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_146
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable EIFFEL_LIST [FEAT_NAME_ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval105 := ast_factory.new_eiffel_list_feature_name_id (counter_value + 1)
				if
					attached yyval105 as l_list and then
					attached yyvs2.item (yyvsp2) as l_val and then
					attached ast_factory.new_feature_name_id_as (l_val) as l_id
				then
					l_list.reverse_extend (l_id)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp105 := yyvsp105 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp105 >= yyvsc105 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs105")
		end
		yyvsc105 := yyvsc105 + yyInitial_yyvs_size
		yyvs105 := yyspecial_routines105.aliased_resized_area (yyvs105, yyvsc105)
	end
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_147
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable EIFFEL_LIST [FEAT_NAME_ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval105 := yyvs105.item (yyvsp105)
				if
					attached yyval105 as l_list and then
					attached yyvs2.item (yyvsp2) as l_val and then
					attached ast_factory.new_feature_name_id_as (l_val) as l_id
				then
					l_list.reverse_extend (l_id)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_148
			--|#line <not available> "eiffel.y"
		local
			yyval104: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval104 := yyvs104.item (yyvsp104) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines104.force (yyvs104, yyval104, yyvsp104)
end
		end

	yy_do_action_149
			--|#line <not available> "eiffel.y"
		local
			yyval104: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval104 := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if attached yyval104 as l_list and then attached yyvs91.item (yyvsp91) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp104 := yyvsp104 + 1
	yyvsp91 := yyvsp91 -1
	if yyvsp104 >= yyvsc104 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs104")
		end
		yyvsc104 := yyvsc104 + yyInitial_yyvs_size
		yyvs104 := yyspecial_routines104.aliased_resized_area (yyvs104, yyvsc104)
	end
	yyspecial_routines104.force (yyvs104, yyval104, yyvsp104)
end
		end

	yy_do_action_150
			--|#line <not available> "eiffel.y"
		local
			yyval104: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval104 := yyvs104.item (yyvsp104)
				if attached yyval104 as l_list and then attached yyvs91.item (yyvsp91) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp91 := yyvsp91 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines104.force (yyvs104, yyval104, yyvsp104)
end
		end

	yy_do_action_151
			--|#line <not available> "eiffel.y"
		local
			yyval108: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp108 := yyvsp108 + 1
	if yyvsp108 >= yyvsc108 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs108")
		end
		yyvsc108 := yyvsc108 + yyInitial_yyvs_size
		yyvs108 := yyspecial_routines108.aliased_resized_area (yyvs108, yyvsc108)
	end
	yyspecial_routines108.force (yyvs108, yyval108, yyvsp108)
end
		end

	yy_do_action_152
			--|#line <not available> "eiffel.y"
		local
			yyval108: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval108 := yyvs108.item (yyvsp108) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines108.force (yyvs108, yyval108, yyvsp108)
end
		end

	yy_do_action_153
			--|#line <not available> "eiffel.y"
		local
			yyval108: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval108 := ast_factory.new_undefine_clause_as (Void, yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp108 := yyvsp108 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp108 >= yyvsc108 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs108")
		end
		yyvsc108 := yyvsc108 + yyInitial_yyvs_size
		yyvs108 := yyspecial_routines108.aliased_resized_area (yyvs108, yyvsc108)
	end
	yyspecial_routines108.force (yyvs108, yyval108, yyvsp108)
end
		end

	yy_do_action_154
			--|#line <not available> "eiffel.y"
		local
			yyval108: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval108 := ast_factory.new_undefine_clause_as (yyvs104.item (yyvsp104), yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp104 := yyvsp104 -1
	if yyvsp108 >= yyvsc108 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs108")
		end
		yyvsc108 := yyvsc108 + yyInitial_yyvs_size
		yyvs108 := yyspecial_routines108.aliased_resized_area (yyvs108, yyvsc108)
	end
	yyspecial_routines108.force (yyvs108, yyval108, yyvsp108)
end
		end

	yy_do_action_155
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp109 := yyvsp109 + 1
	if yyvsp109 >= yyvsc109 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs109")
		end
		yyvsc109 := yyvsc109 + yyInitial_yyvs_size
		yyvs109 := yyspecial_routines109.aliased_resized_area (yyvs109, yyvsc109)
	end
	yyspecial_routines109.force (yyvs109, yyval109, yyvsp109)
end
		end

	yy_do_action_156
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval109 := yyvs109.item (yyvsp109) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines109.force (yyvs109, yyval109, yyvsp109)
end
		end

	yy_do_action_157
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := ast_factory.new_redefine_clause_as (Void, yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp109 >= yyvsc109 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs109")
		end
		yyvsc109 := yyvsc109 + yyInitial_yyvs_size
		yyvs109 := yyspecial_routines109.aliased_resized_area (yyvs109, yyvsc109)
	end
	yyspecial_routines109.force (yyvs109, yyval109, yyvsp109)
end
		end

	yy_do_action_158
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := ast_factory.new_redefine_clause_as (yyvs104.item (yyvsp104), yyvs14.item (yyvsp14))				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp109 := yyvsp109 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp104 := yyvsp104 -1
	if yyvsp109 >= yyvsc109 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs109")
		end
		yyvsc109 := yyvsc109 + yyInitial_yyvs_size
		yyvs109 := yyspecial_routines109.aliased_resized_area (yyvs109, yyvsc109)
	end
	yyspecial_routines109.force (yyvs109, yyval109, yyvsp109)
end
		end

	yy_do_action_159
			--|#line <not available> "eiffel.y"
		local
			yyval110: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp110 := yyvsp110 + 1
	if yyvsp110 >= yyvsc110 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs110")
		end
		yyvsc110 := yyvsc110 + yyInitial_yyvs_size
		yyvs110 := yyspecial_routines110.aliased_resized_area (yyvs110, yyvsc110)
	end
	yyspecial_routines110.force (yyvs110, yyval110, yyvsp110)
end
		end

	yy_do_action_160
			--|#line <not available> "eiffel.y"
		local
			yyval110: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval110 := yyvs110.item (yyvsp110) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines110.force (yyvs110, yyval110, yyvsp110)
end
		end

	yy_do_action_161
			--|#line <not available> "eiffel.y"
		local
			yyval110: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if non_conforming_inheritance_flag then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)),
						filename, "Non-conforming inheritance may not use select clause"))
				end
				yyval110 := ast_factory.new_select_clause_as (Void, yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp110 := yyvsp110 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp110 >= yyvsc110 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs110")
		end
		yyvsc110 := yyvsc110 + yyInitial_yyvs_size
		yyvs110 := yyspecial_routines110.aliased_resized_area (yyvs110, yyvsc110)
	end
	yyspecial_routines110.force (yyvs110, yyval110, yyvsp110)
end
		end

	yy_do_action_162
			--|#line <not available> "eiffel.y"
		local
			yyval110: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if non_conforming_inheritance_flag and attached yyvs14.item (yyvsp14) as l_keyword then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)),
						filename, "Non-conforming inheritance may not use select clause"))
				end
				yyval110 := ast_factory.new_select_clause_as (yyvs104.item (yyvsp104), yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp110 := yyvsp110 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp104 := yyvsp104 -1
	if yyvsp110 >= yyvsc110 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs110")
		end
		yyvsc110 := yyvsc110 + yyInitial_yyvs_size
		yyvs110 := yyspecial_routines110.aliased_resized_area (yyvs110, yyvsc110)
	end
	yyspecial_routines110.force (yyvs110, yyval110, yyvsp110)
end
		end

	yy_do_action_163
			--|#line <not available> "eiffel.y"
		local
			yyval129: detachable FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)), filename,
						once "Empty formal argument list is not allowed"))
				end
				yyval129 := ast_factory.new_formal_argu_dec_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp129 := yyvsp129 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp129 >= yyvsc129 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs129")
		end
		yyvsc129 := yyvsc129 + yyInitial_yyvs_size
		yyvs129 := yyspecial_routines129.aliased_resized_area (yyvs129, yyvsc129)
	end
	yyspecial_routines129.force (yyvs129, yyval129, yyvsp129)
end
		end

	yy_do_action_164
			--|#line <not available> "eiffel.y"
		local
			yyval129: detachable FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval129 := ast_factory.new_formal_argu_dec_list_as (yyvs126.item (yyvsp126), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp129 := yyvsp129 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp126 := yyvsp126 -1
	if yyvsp129 >= yyvsc129 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs129")
		end
		yyvsc129 := yyvsc129 + yyInitial_yyvs_size
		yyvs129 := yyspecial_routines129.aliased_resized_area (yyvs129, yyvsc129)
	end
	yyspecial_routines129.force (yyvs129, yyval129, yyvsp129)
end
		end

	yy_do_action_165
			--|#line <not available> "eiffel.y"
		local
			yyval126: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval126 := ast_factory.new_eiffel_list_type_dec_as (counter_value + 1)
				if attached yyval126 as l_list and then attached yyvs88.item (yyvsp88) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp126 := yyvsp126 + 1
	yyvsp88 := yyvsp88 -1
	if yyvsp126 >= yyvsc126 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs126")
		end
		yyvsc126 := yyvsc126 + yyInitial_yyvs_size
		yyvs126 := yyspecial_routines126.aliased_resized_area (yyvs126, yyvsc126)
	end
	yyspecial_routines126.force (yyvs126, yyval126, yyvsp126)
end
		end

	yy_do_action_166
			--|#line <not available> "eiffel.y"
		local
			yyval126: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval126 := yyvs126.item (yyvsp126)
				if attached yyval126 as l_list and then attached yyvs88.item (yyvsp88) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp88 := yyvsp88 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines126.force (yyvs126, yyval126, yyvsp126)
end
		end

	yy_do_action_167
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable TYPE_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval88 := ast_factory.new_type_dec_as (yyvs21.item (yyvsp21), yyvs85.item (yyvsp85), yyvs4.item (yyvsp4 - 1))
				if attached yyvs21.item (yyvsp21) as list and then attached list.id_list as identifiers then
					add_scope_arguments (identifiers)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp88 := yyvsp88 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp21 := yyvsp21 -1
	yyvsp4 := yyvsp4 -2
	yyvsp85 := yyvsp85 -1
	if yyvsp88 >= yyvsc88 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs88")
		end
		yyvsc88 := yyvsc88 + yyInitial_yyvs_size
		yyvs88 := yyspecial_routines88.aliased_resized_area (yyvs88, yyvsc88)
	end
	yyspecial_routines88.force (yyvs88, yyval88, yyvsp88)
end
		end

	yy_do_action_168
			--|#line <not available> "eiffel.y"
		local
			yyval127: detachable LIST_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval127 := ast_factory.new_eiffel_list_list_dec_as (counter_value + 1)
				if attached yyval127 as l_list and then attached yyvs89.item (yyvsp89) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp127 := yyvsp127 + 1
	yyvsp89 := yyvsp89 -1
	if yyvsp127 >= yyvsc127 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs127")
		end
		yyvsc127 := yyvsc127 + yyInitial_yyvs_size
		yyvs127 := yyspecial_routines127.aliased_resized_area (yyvs127, yyvsc127)
	end
	yyspecial_routines127.force (yyvs127, yyval127, yyvsp127)
end
		end

	yy_do_action_169
			--|#line <not available> "eiffel.y"
		local
			yyval127: detachable LIST_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval127 := yyvs127.item (yyvsp127)
				if attached yyval127 as l_list and then attached yyvs89.item (yyvsp89) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp89 := yyvsp89 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines127.force (yyvs127, yyval127, yyvsp127)
end
		end

	yy_do_action_170
			--|#line <not available> "eiffel.y"
		local
			yyval89: detachable LIST_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not is_type_inference_supported then
					raise_error
				end
				yyval89 := ast_factory.new_list_dec_as (yyvs21.item (yyvsp21))
				if attached yyvs21.item (yyvsp21) as list and then attached list.id_list as identifiers then
					add_scope_locals (identifiers)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp89 := yyvsp89 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp21 := yyvsp21 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp89 >= yyvsc89 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs89")
		end
		yyvsc89 := yyvsc89 + yyInitial_yyvs_size
		yyvs89 := yyspecial_routines89.aliased_resized_area (yyvs89, yyvsc89)
	end
	yyspecial_routines89.force (yyvs89, yyval89, yyvsp89)
end
		end

	yy_do_action_171
			--|#line <not available> "eiffel.y"
		local
			yyval89: detachable LIST_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval89 := ast_factory.new_type_dec_as (yyvs21.item (yyvsp21), yyvs85.item (yyvsp85), yyvs4.item (yyvsp4 - 1))
				if attached yyvs21.item (yyvsp21) as list and then attached list.id_list as identifiers then
					add_scope_locals (identifiers)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp89 := yyvsp89 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp21 := yyvsp21 -1
	yyvsp4 := yyvsp4 -2
	yyvsp85 := yyvsp85 -1
	if yyvsp89 >= yyvsc89 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs89")
		end
		yyvsc89 := yyvsc89 + yyInitial_yyvs_size
		yyvs89 := yyspecial_routines89.aliased_resized_area (yyvs89, yyvsc89)
	end
	yyspecial_routines89.force (yyvs89, yyval89, yyvsp89)
end
		end

	yy_do_action_172
			--|#line <not available> "eiffel.y"
		local
			yyval21: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval21 := ast_factory.new_identifier_list (counter_value + 1)
				if attached yyval21 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp21 := yyvsp21 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp21 >= yyvsc21 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs21")
		end
		yyvsc21 := yyvsc21 + yyInitial_yyvs_size
		yyvs21 := yyspecial_routines21.aliased_resized_area (yyvs21, yyvsc21)
	end
	yyspecial_routines21.force (yyvs21, yyval21, yyvsp21)
end
		end

	yy_do_action_173
			--|#line <not available> "eiffel.y"
		local
			yyval21: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval21 := yyvs21.item (yyvsp21)
				if attached yyval21 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_val)
					ast_factory.reverse_extend_identifier_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines21.force (yyvs21, yyval21, yyvsp21)
end
		end

	yy_do_action_174
			--|#line <not available> "eiffel.y"
		local
			yyval21: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := ast_factory.new_identifier_list (0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp21 := yyvsp21 + 1
	if yyvsp21 >= yyvsc21 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs21")
		end
		yyvsc21 := yyvsc21 + yyInitial_yyvs_size
		yyvs21 := yyspecial_routines21.aliased_resized_area (yyvs21, yyvsc21)
	end
	yyspecial_routines21.force (yyvs21, yyval21, yyvsp21)
end
		end

	yy_do_action_175
			--|#line <not available> "eiffel.y"
		local
			yyval21: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := yyvs21.item (yyvsp21) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines21.force (yyvs21, yyval21, yyvsp21)
end
		end

	yy_do_action_176
			--|#line <not available> "eiffel.y"
		local
			yyval80: detachable ROUTINE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs20.item (yyvsp20) as l_pair then
					temp_string_as1 := l_pair.second
					temp_keyword_as := l_pair.first
				else
					temp_string_as1 := Void
					temp_keyword_as := Void
				end
				if attached yyvs18.item (yyvsp18) as l_rescue then
					yyval80 := ast_factory.new_routine_as (temp_string_as1, yyvs77.item (yyvsp77), yyvs128.item (yyvsp128), yyvs79.item (yyvsp79), yyvs46.item (yyvsp46), l_rescue.second, yyvs14.item (yyvsp14), once_manifest_string_counter_value, fbody_pos, temp_keyword_as, l_rescue.first, object_test_locals, has_non_object_call, has_non_object_call_in_assertion, has_unqualified_call_in_assertion)
				else
					yyval80 := ast_factory.new_routine_as (temp_string_as1, yyvs77.item (yyvsp77), yyvs128.item (yyvsp128), yyvs79.item (yyvsp79), yyvs46.item (yyvsp46), Void, yyvs14.item (yyvsp14), once_manifest_string_counter_value, fbody_pos, temp_keyword_as, Void, object_test_locals, has_non_object_call, has_non_object_call_in_assertion, has_unqualified_call_in_assertion)
				end
				reset_feature_frame
				object_test_locals := Void
				leave_scope -- For local variables.
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp80 := yyvsp80 -1
	yyvsp20 := yyvsp20 -1
	yyvsp77 := yyvsp77 -1
	yyvsp128 := yyvsp128 -1
	yyvsp79 := yyvsp79 -1
	yyvsp46 := yyvsp46 -1
	yyvsp18 := yyvsp18 -1
	yyvsp14 := yyvsp14 -1
	yyspecial_routines80.force (yyvs80, yyval80, yyvsp80)
end
		end

	yy_do_action_177
			--|#line <not available> "eiffel.y"
		local
			yyval80: detachable ROUTINE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_fbody_pos (position)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp80 := yyvsp80 + 1
	if yyvsp80 >= yyvsc80 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs80")
		end
		yyvsc80 := yyvsc80 + yyInitial_yyvs_size
		yyvs80 := yyspecial_routines80.aliased_resized_area (yyvs80, yyvsc80)
	end
	yyspecial_routines80.force (yyvs80, yyval80, yyvsp80)
end
		end

	yy_do_action_178
			--|#line <not available> "eiffel.y"
		local
			yyval80: detachable ROUTINE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					 -- Start a scope for local variables.
				enter_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp80 := yyvsp80 + 1
	if yyvsp80 >= yyvsc80 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs80")
		end
		yyvsc80 := yyvsc80 + yyInitial_yyvs_size
		yyvs80 := yyspecial_routines80.aliased_resized_area (yyvs80, yyvsc80)
	end
	yyspecial_routines80.force (yyvs80, yyval80, yyvsp80)
end
		end

	yy_do_action_179
			--|#line <not available> "eiffel.y"
		local
			yyval79: detachable ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval79 := yyvs64.item (yyvsp64) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp64 := yyvsp64 -1
	if yyvsp79 >= yyvsc79 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs79")
		end
		yyvsc79 := yyvsc79 + yyInitial_yyvs_size
		yyvs79 := yyspecial_routines79.aliased_resized_area (yyvs79, yyvsc79)
	end
	yyspecial_routines79.force (yyvs79, yyval79, yyvsp79)
end
		end

	yy_do_action_180
			--|#line <not available> "eiffel.y"
		local
			yyval79: detachable ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval79 := yyvs50.item (yyvsp50) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp50 := yyvsp50 -1
	if yyvsp79 >= yyvsc79 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs79")
		end
		yyvsc79 := yyvsc79 + yyInitial_yyvs_size
		yyvs79 := yyspecial_routines79.aliased_resized_area (yyvs79, yyvsc79)
	end
	yyspecial_routines79.force (yyvs79, yyval79, yyvsp79)
end
		end

	yy_do_action_181
			--|#line <not available> "eiffel.y"
		local
			yyval79: detachable ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval79 := yyvs12.item (yyvsp12) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp79 >= yyvsc79 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs79")
		end
		yyvsc79 := yyvsc79 + yyInitial_yyvs_size
		yyvs79 := yyspecial_routines79.aliased_resized_area (yyvs79, yyvsc79)
	end
	yyspecial_routines79.force (yyvs79, yyval79, yyvsp79)
end
		end

	yy_do_action_182
			--|#line <not available> "eiffel.y"
		local
			yyval50: detachable EXTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs51.item (yyvsp51) as l_language and then l_language.is_built_in then
					if attached yyvs20.item (yyvsp20) as l_name then 
						yyval50 := ast_factory.new_built_in_as (l_language, l_name.second, yyvs14.item (yyvsp14), l_name.first)
					else
						yyval50 := ast_factory.new_built_in_as (l_language, Void, yyvs14.item (yyvsp14), Void)
					end
				elseif attached yyvs20.item (yyvsp20) as l_name then
					yyval50 := ast_factory.new_external_as (yyvs51.item (yyvsp51), l_name.second, yyvs14.item (yyvsp14), l_name.first)
				else
					yyval50 := ast_factory.new_external_as (yyvs51.item (yyvsp51), Void, yyvs14.item (yyvsp14), Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp51 := yyvsp51 -1
	yyvsp20 := yyvsp20 -1
	if yyvsp50 >= yyvsc50 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs50")
		end
		yyvsc50 := yyvsc50 + yyInitial_yyvs_size
		yyvs50 := yyspecial_routines50.aliased_resized_area (yyvs50, yyvsc50)
	end
	yyspecial_routines50.force (yyvs50, yyval50, yyvsp50)
end
		end

	yy_do_action_183
			--|#line <not available> "eiffel.y"
		local
			yyval51: detachable EXTERNAL_LANG_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval51 := ast_factory.new_external_lang_as (yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp51 := yyvsp51 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp51 >= yyvsc51 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs51")
		end
		yyvsc51 := yyvsc51 + yyInitial_yyvs_size
		yyvs51 := yyspecial_routines51.aliased_resized_area (yyvs51, yyvsc51)
	end
	yyspecial_routines51.force (yyvs51, yyval51, yyvsp51)
end
		end

	yy_do_action_184
			--|#line <not available> "eiffel.y"
		local
			yyval20: detachable PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp20 := yyvsp20 + 1
	if yyvsp20 >= yyvsc20 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs20")
		end
		yyvsc20 := yyvsc20 + yyInitial_yyvs_size
		yyvs20 := yyspecial_routines20.aliased_resized_area (yyvs20, yyvsc20)
	end
	yyspecial_routines20.force (yyvs20, yyval20, yyvsp20)
end
		end

	yy_do_action_185
			--|#line <not available> "eiffel.y"
		local
			yyval20: detachable PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval20 := ast_factory.new_keyword_string_pair (yyvs14.item (yyvsp14), yyvs16.item (yyvsp16))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp20 >= yyvsc20 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs20")
		end
		yyvsc20 := yyvsc20 + yyInitial_yyvs_size
		yyvs20 := yyspecial_routines20.aliased_resized_area (yyvs20, yyvsc20)
	end
	yyspecial_routines20.force (yyvs20, yyval20, yyvsp20)
end
		end

	yy_do_action_186
			--|#line <not available> "eiffel.y"
		local
			yyval64: detachable INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := ast_factory.new_do_as (yyvs115.item (yyvsp115), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp64 := yyvsp64 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp115 := yyvsp115 -1
	if yyvsp64 >= yyvsc64 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs64")
		end
		yyvsc64 := yyvsc64 + yyInitial_yyvs_size
		yyvs64 := yyspecial_routines64.aliased_resized_area (yyvs64, yyvsc64)
	end
	yyspecial_routines64.force (yyvs64, yyval64, yyvsp64)
end
		end

	yy_do_action_187
			--|#line <not available> "eiffel.y"
		local
			yyval64: detachable INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := ast_factory.new_once_as (yyvs14.item (yyvsp14), yyvs123.item (yyvsp123), yyvs115.item (yyvsp115)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp64 := yyvsp64 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp123 := yyvsp123 -1
	yyvsp115 := yyvsp115 -1
	if yyvsp64 >= yyvsc64 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs64")
		end
		yyvsc64 := yyvsc64 + yyInitial_yyvs_size
		yyvs64 := yyspecial_routines64.aliased_resized_area (yyvs64, yyvsc64)
	end
	yyspecial_routines64.force (yyvs64, yyval64, yyvsp64)
end
		end

	yy_do_action_188
			--|#line <not available> "eiffel.y"
		local
			yyval64: detachable INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := ast_factory.new_attribute_as (yyvs115.item (yyvsp115), extract_keyword (yyvs15.item (yyvsp15))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp64 := yyvsp64 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp115 := yyvsp115 -1
	if yyvsp64 >= yyvsc64 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs64")
		end
		yyvsc64 := yyvsc64 + yyInitial_yyvs_size
		yyvs64 := yyspecial_routines64.aliased_resized_area (yyvs64, yyvsc64)
	end
	yyspecial_routines64.force (yyvs64, yyval64, yyvsp64)
end
		end

	yy_do_action_189
			--|#line <not available> "eiffel.y"
		local
			yyval128: detachable LOCAL_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp128 := yyvsp128 + 1
	if yyvsp128 >= yyvsc128 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs128")
		end
		yyvsc128 := yyvsc128 + yyInitial_yyvs_size
		yyvs128 := yyspecial_routines128.aliased_resized_area (yyvs128, yyvsc128)
	end
	yyspecial_routines128.force (yyvs128, yyval128, yyvsp128)
end
		end

	yy_do_action_190
			--|#line <not available> "eiffel.y"
		local
			yyval128: detachable LOCAL_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval128 := ast_factory.new_local_dec_list_as (ast_factory.new_eiffel_list_type_dec_as (0), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp128 := yyvsp128 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp128 >= yyvsc128 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs128")
		end
		yyvsc128 := yyvsc128 + yyInitial_yyvs_size
		yyvs128 := yyspecial_routines128.aliased_resized_area (yyvs128, yyvsc128)
	end
	yyspecial_routines128.force (yyvs128, yyval128, yyvsp128)
end
		end

	yy_do_action_191
			--|#line <not available> "eiffel.y"
		local
			yyval128: detachable LOCAL_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval128 := ast_factory.new_local_dec_list_as (yyvs127.item (yyvsp127), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp128 := yyvsp128 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp1 := yyvsp1 -2
	yyvsp127 := yyvsp127 -1
	if yyvsp128 >= yyvsc128 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs128")
		end
		yyvsc128 := yyvsc128 + yyInitial_yyvs_size
		yyvs128 := yyspecial_routines128.aliased_resized_area (yyvs128, yyvsc128)
	end
	yyspecial_routines128.force (yyvs128, yyval128, yyvsp128)
end
		end

	yy_do_action_192
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp115 := yyvsp115 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp115 >= yyvsc115 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs115")
		end
		yyvsc115 := yyvsc115 + yyInitial_yyvs_size
		yyvs115 := yyspecial_routines115.aliased_resized_area (yyvs115, yyvsc115)
	end
	yyspecial_routines115.force (yyvs115, yyval115, yyvsp115)
end
		end

	yy_do_action_193
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval115 := yyvs115.item (yyvsp115) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -3
	yyspecial_routines115.force (yyvs115, yyval115, yyvsp115)
end
		end

	yy_do_action_194
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval115 := ast_factory.new_eiffel_list_instruction_as (counter_value + 1)
				if attached yyval115 as l_list and then attached yyvs62.item (yyvsp62) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp115 := yyvsp115 + 1
	yyvsp62 := yyvsp62 -1
	if yyvsp115 >= yyvsc115 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs115")
		end
		yyvsc115 := yyvsc115 + yyInitial_yyvs_size
		yyvs115 := yyspecial_routines115.aliased_resized_area (yyvs115, yyvsc115)
	end
	yyspecial_routines115.force (yyvs115, yyval115, yyvsp115)
end
		end

	yy_do_action_195
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval115 := yyvs115.item (yyvsp115)
				if attached yyval115 as l_list and then attached yyvs62.item (yyvsp62) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines115.force (yyvs115, yyval115, yyvsp115)
end
		end

	yy_do_action_196
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs62.item (yyvsp62) as l_instructions then
					yyval62 := l_instructions
					l_instructions.set_line_pragma (last_line_pragma)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_197
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_198
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_199
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs41.item (yyvsp41) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp41 := yyvsp41 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_200
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_instr_call_as (yyvs34.item (yyvsp34)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp34 := yyvsp34 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_201
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_assigner_call_as (ast_factory.new_expr_call_as (yyvs34.item (yyvsp34)), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp34 := yyvsp34 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_202
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_assigner_call_as (yyvs74.item (yyvsp74), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp74 := yyvsp74 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_203
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_assigner_call_as (yyvs49.item (yyvsp49), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp49 := yyvsp49 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_204
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_assigner_call_as (yyvs49.item (yyvsp49), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp49 := yyvsp49 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_205
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs29.item (yyvsp29) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp29 := yyvsp29 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_206
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs78.item (yyvsp78) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp78 := yyvsp78 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_207
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs58.item (yyvsp58) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp58 := yyvsp58 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_208
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs68.item (yyvsp68) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp68 := yyvsp68 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_209
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp61 := yyvsp61 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_210
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs43.item (yyvsp43) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp43 := yyvsp43 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_211
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs36.item (yyvsp36) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp36 := yyvsp36 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_212
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs57.item (yyvsp57) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp57 := yyvsp57 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_213
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp82 := yyvsp82 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_214
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs9.item (yyvsp9) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp62 >= yyvsc62 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs62")
		end
		yyvsc62 := yyvsc62 + yyInitial_yyvs_size
		yyvs62 := yyspecial_routines62.aliased_resized_area (yyvs62, yyvsc62)
	end
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_215
			--|#line <not available> "eiffel.y"
		local
			yyval77: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp77 := yyvsp77 + 1
	if yyvsp77 >= yyvsc77 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs77")
		end
		yyvsc77 := yyvsc77 + yyInitial_yyvs_size
		yyvs77 := yyspecial_routines77.aliased_resized_area (yyvs77, yyvsc77)
	end
	yyspecial_routines77.force (yyvs77, yyval77, yyvsp77)
end
		end

	yy_do_action_216
			--|#line <not available> "eiffel.y"
		local
			yyval77: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval77 := ast_factory.new_require_as (yyvs124.item (yyvsp124), yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -1
	yyvsp124 := yyvsp124 -1
	yyspecial_routines77.force (yyvs77, yyval77, yyvsp77)
end
		end

	yy_do_action_217
			--|#line <not available> "eiffel.y"
		local
			yyval77: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Precondition_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp77 := yyvsp77 + 1
	if yyvsp77 >= yyvsc77 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs77")
		end
		yyvsc77 := yyvsc77 + yyInitial_yyvs_size
		yyvs77 := yyspecial_routines77.aliased_resized_area (yyvs77, yyvsc77)
	end
	yyspecial_routines77.force (yyvs77, yyval77, yyvsp77)
end
		end

	yy_do_action_218
			--|#line <not available> "eiffel.y"
		local
			yyval77: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval77 := ast_factory.new_require_else_as (yyvs124.item (yyvsp124), yyvs14.item (yyvsp14 - 1), yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -2
	yyvsp124 := yyvsp124 -1
	yyspecial_routines77.force (yyvs77, yyval77, yyvsp77)
end
		end

	yy_do_action_219
			--|#line <not available> "eiffel.y"
		local
			yyval77: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Precondition_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp77 := yyvsp77 + 1
	if yyvsp77 >= yyvsc77 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs77")
		end
		yyvsc77 := yyvsc77 + yyInitial_yyvs_size
		yyvs77 := yyspecial_routines77.aliased_resized_area (yyvs77, yyvsc77)
	end
	yyspecial_routines77.force (yyvs77, yyval77, yyvsp77)
end
		end

	yy_do_action_220
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp46 := yyvsp46 + 1
	if yyvsp46 >= yyvsc46 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs46")
		end
		yyvsc46 := yyvsc46 + yyInitial_yyvs_size
		yyvs46 := yyspecial_routines46.aliased_resized_area (yyvs46, yyvsc46)
	end
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_221
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval46 := ast_factory.new_ensure_as (yyvs124.item (yyvsp124), is_class_feature, yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -1
	yyvsp124 := yyvsp124 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_222
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Postcondition_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp46 := yyvsp46 + 1
	if yyvsp46 >= yyvsc46 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs46")
		end
		yyvsc46 := yyvsc46 + yyInitial_yyvs_size
		yyvs46 := yyspecial_routines46.aliased_resized_area (yyvs46, yyvsc46)
	end
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_223
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval46 := ast_factory.new_ensure_then_as (yyvs124.item (yyvsp124), is_class_feature, yyvs14.item (yyvsp14 - 1), yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -2
	yyvsp124 := yyvsp124 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_224
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Postcondition_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp46 := yyvsp46 + 1
	if yyvsp46 >= yyvsc46 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs46")
		end
		yyvsc46 := yyvsc46 + yyInitial_yyvs_size
		yyvs46 := yyspecial_routines46.aliased_resized_area (yyvs46, yyvsc46)
	end
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_225
			--|#line <not available> "eiffel.y"
		local
			yyval124: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp124 := yyvsp124 + 1
	if yyvsp124 >= yyvsc124 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs124")
		end
		yyvsc124 := yyvsc124 + yyInitial_yyvs_size
		yyvs124 := yyspecial_routines124.aliased_resized_area (yyvs124, yyvsc124)
	end
	yyspecial_routines124.force (yyvs124, yyval124, yyvsp124)
end
		end

	yy_do_action_226
			--|#line <not available> "eiffel.y"
		local
			yyval124: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs124.item (yyvsp124) as l_list then
					if l_list.is_empty then
						yyval124 := Void
					else
						yyval124 := l_list
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines124.force (yyvs124, yyval124, yyvsp124)
end
		end

	yy_do_action_227
			--|#line <not available> "eiffel.y"
		local
			yyval124: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if attached yyvs83.item (yyvsp83) as l_val then
					yyval124 := ast_factory.new_eiffel_list_tagged_as (counter_value + 1)
					if attached yyval124 as l_list then
						l_list.reverse_extend (l_val)
					end
				else
					yyval124 := ast_factory.new_eiffel_list_tagged_as (counter_value)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp124 := yyvsp124 + 1
	yyvsp83 := yyvsp83 -1
	if yyvsp124 >= yyvsc124 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs124")
		end
		yyvsc124 := yyvsc124 + yyInitial_yyvs_size
		yyvs124 := yyspecial_routines124.aliased_resized_area (yyvs124, yyvsc124)
	end
	yyspecial_routines124.force (yyvs124, yyval124, yyvsp124)
end
		end

	yy_do_action_228
			--|#line <not available> "eiffel.y"
		local
			yyval124: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval124 := yyvs124.item (yyvsp124)
				if attached yyval124 as l_list and then attached yyvs83.item (yyvsp83) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp124 := yyvsp124 -1
	yyvsp83 := yyvsp83 -1
	yyspecial_routines124.force (yyvs124, yyval124, yyvsp124)
end
		end

	yy_do_action_229
			--|#line <not available> "eiffel.y"
		local
			yyval124: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Only increment counter when clause is not Void.
				if yyvs83.item (yyvsp83) /= Void then
					increment_counter
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp124 := yyvsp124 + 1
	if yyvsp124 >= yyvsc124 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs124")
		end
		yyvsc124 := yyvsc124 + yyInitial_yyvs_size
		yyvs124 := yyspecial_routines124.aliased_resized_area (yyvs124, yyvsc124)
	end
	yyspecial_routines124.force (yyvs124, yyval124, yyvsp124)
end
		end

	yy_do_action_230
			--|#line <not available> "eiffel.y"
		local
			yyval83: detachable TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := ast_factory.new_tagged_as (Void, yyvs48.item (yyvsp48), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp83 >= yyvsc83 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs83")
		end
		yyvsc83 := yyvsc83 + yyInitial_yyvs_size
		yyvs83 := yyspecial_routines83.aliased_resized_area (yyvs83, yyvsc83)
	end
	yyspecial_routines83.force (yyvs83, yyval83, yyvsp83)
end
		end

	yy_do_action_231
			--|#line <not available> "eiffel.y"
		local
			yyval83: detachable TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if id_level = Postcondition_level then
					yyval83 := ast_factory.new_tagged_as (Void, Void, yyvs14.item (yyvsp14), Void)
					set_is_class_feature (True)
				else
					raise_error
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp83 >= yyvsc83 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs83")
		end
		yyvsc83 := yyvsc83 + yyInitial_yyvs_size
		yyvs83 := yyspecial_routines83.aliased_resized_area (yyvs83, yyvsc83)
	end
	yyspecial_routines83.force (yyvs83, yyval83, yyvsp83)
end
		end

	yy_do_action_232
			--|#line <not available> "eiffel.y"
		local
			yyval83: detachable TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := ast_factory.new_tagged_as (yyvs2.item (yyvsp2), yyvs48.item (yyvsp48), Void, yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp48 := yyvsp48 -1
	if yyvsp83 >= yyvsc83 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs83")
		end
		yyvsc83 := yyvsc83 + yyInitial_yyvs_size
		yyvs83 := yyspecial_routines83.aliased_resized_area (yyvs83, yyvsc83)
	end
	yyspecial_routines83.force (yyvs83, yyval83, yyvsp83)
end
		end

	yy_do_action_233
			--|#line <not available> "eiffel.y"
		local
			yyval83: detachable TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if id_level = Postcondition_level then
					yyval83 := ast_factory.new_tagged_as (yyvs2.item (yyvsp2), Void, yyvs14.item (yyvsp14), yyvs4.item (yyvsp4 - 1))
					set_is_class_feature (True)
				else
					raise_error
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp14 := yyvsp14 -1
	if yyvsp83 >= yyvsc83 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs83")
		end
		yyvsc83 := yyvsc83 + yyInitial_yyvs_size
		yyvs83 := yyspecial_routines83.aliased_resized_area (yyvs83, yyvsc83)
	end
	yyspecial_routines83.force (yyvs83, yyval83, yyvsp83)
end
		end

	yy_do_action_234
			--|#line <not available> "eiffel.y"
		local
			yyval83: detachable TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- Always create an object here for roundtrip parser.
				-- This "fake" assertion will be filtered out later.
			yyval83 := ast_factory.new_tagged_as (yyvs2.item (yyvsp2), Void, Void, yyvs4.item (yyvsp4 - 1))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	if yyvsp83 >= yyvsc83 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs83")
		end
		yyvsc83 := yyvsc83 + yyInitial_yyvs_size
		yyvs83 := yyspecial_routines83.aliased_resized_area (yyvs83, yyvsc83)
	end
	yyspecial_routines83.force (yyvs83, yyval83, yyvsp83)
end
		end

	yy_do_action_235
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_236
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_237
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_238
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_239
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_240
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_241
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_242
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_243
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_244
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_245
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 -1
	yyvsp14 := yyvsp14 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_246
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 -1
	yyvsp14 := yyvsp14 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_247
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -1
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_248
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -1
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_249
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), True, False)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -2
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_250
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_251
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_252
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -1
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_253
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -1
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_254
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), False, True)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -2
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_255
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_256
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_257
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_258
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_259
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := new_class_type (yyvs2.item (yyvsp2), yyvs125.item (yyvsp125)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp125 := yyvsp125 -1
	if yyvsp85 >= yyvsc85 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs85")
		end
		yyvsc85 := yyvsc85 + yyInitial_yyvs_size
		yyvs85 := yyspecial_routines85.aliased_resized_area (yyvs85, yyvsc85)
	end
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_260
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_261
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_262
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_263
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_264
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_265
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_266
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 -1
	yyvsp14 := yyvsp14 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_267
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 -1
	yyvsp14 := yyvsp14 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_268
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -1
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_269
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -1
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_270
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), True, False)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -2
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_271
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_272
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_273
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -1
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_274
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -1
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_275
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), False, True)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -2
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_276
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_277
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_variance_mark and then attached yyval85 as l_type then
					l_type.set_variance_mark (yyvs14.item (yyvsp14 - 1), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
				if attached yyval85 as l_type then
					l_type.set_separate_mark (yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_278
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_279
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs86.item (yyvsp86) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp86 := yyvsp86 -1
	if yyvsp85 >= yyvsc85 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs85")
		end
		yyvsc85 := yyvsc85 + yyInitial_yyvs_size
		yyvs85 := yyspecial_routines85.aliased_resized_area (yyvs85, yyvsc85)
	end
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_280
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := ast_factory.new_like_id_as (yyvs2.item (yyvsp2), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp85 >= yyvsc85 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs85")
		end
		yyvsc85 := yyvsc85 + yyInitial_yyvs_size
		yyvs85 := yyspecial_routines85.aliased_resized_area (yyvs85, yyvsc85)
	end
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_281
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := ast_factory.new_like_current_as (yyvs11.item (yyvsp11), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp11 := yyvsp11 -1
	if yyvsp85 >= yyvsc85 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs85")
		end
		yyvsc85 := yyvsc85 + yyInitial_yyvs_size
		yyvs85 := yyspecial_routines85.aliased_resized_area (yyvs85, yyvsc85)
	end
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_282
			--|#line <not available> "eiffel.y"
		local
			yyval86: detachable QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval86 := ast_factory.new_qualified_anchored_type (yyvs85.item (yyvsp85), yyvs4.item (yyvsp4), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp86 := yyvsp86 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp86 >= yyvsc86 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs86")
		end
		yyvsc86 := yyvsc86 + yyInitial_yyvs_size
		yyvs86 := yyspecial_routines86.aliased_resized_area (yyvs86, yyvsc86)
	end
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_283
			--|#line <not available> "eiffel.y"
		local
			yyval86: detachable QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval86 := ast_factory.new_qualified_anchored_type_with_type (yyvs14.item (yyvsp14), yyvs85.item (yyvsp85), yyvs4.item (yyvsp4), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp86 := yyvsp86 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp86 >= yyvsc86 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs86")
		end
		yyvsc86 := yyvsc86 + yyInitial_yyvs_size
		yyvs86 := yyspecial_routines86.aliased_resized_area (yyvs86, yyvsc86)
	end
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_284
			--|#line <not available> "eiffel.y"
		local
			yyval86: detachable QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval86 := yyvs86.item (yyvsp86)
				if attached yyval86 as q and attached yyvs2.item (yyvsp2) as l_id then
					q.extend (yyvs4.item (yyvsp4), l_id)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_285
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_286
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_287
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_288
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (yyvs4.item (yyvsp4), True, False)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `attached' keyword instead of !."))
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_289
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (yyvs4.item (yyvsp4), False, True)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `detachable' keyword instead of ?."))
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_290
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				ast_factory.set_expanded_class_type (yyval85, True, yyvs14.item (yyvsp14))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename,
						once "Make an expanded version of the base class associated with this type."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_291
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (yyvs4.item (yyvsp4), True, False)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `attached' keyword instead of !."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_292
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if not is_ignoring_attachment_marks and then attached yyval85 as l_type then
					l_type.set_attachment_mark (yyvs4.item (yyvsp4), False, True)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `detachable' keyword instead of ?."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_293
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp125 := yyvsp125 + 1
	if yyvsp125 >= yyvsc125 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs125")
		end
		yyvsc125 := yyvsc125 + yyInitial_yyvs_size
		yyvs125 := yyspecial_routines125.aliased_resized_area (yyvs125, yyvsc125)
	end
	yyspecial_routines125.force (yyvs125, yyval125, yyvsp125)
end
		end

	yy_do_action_294
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval125 := yyvs125.item (yyvsp125)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines125.force (yyvs125, yyval125, yyvsp125)
end
		end

	yy_do_action_295
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs125.item (yyvsp125) as l_list then
					yyval125 := l_list
					l_list.set_positions (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines125.force (yyvs125, yyval125, yyvsp125)
end
		end

	yy_do_action_296
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)), filename,
							once "Empty Type_list is not allowed and will be discarded."))
				end
				if attached ast_factory.new_eiffel_list_type (0) as l_list then
					yyval125 := l_list
					l_list.set_positions (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end	
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp125 := yyvsp125 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp125 >= yyvsc125 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs125")
		end
		yyvsc125 := yyvsc125 + yyInitial_yyvs_size
		yyvs125 := yyspecial_routines125.aliased_resized_area (yyvs125, yyvsc125)
	end
	yyspecial_routines125.force (yyvs125, yyval125, yyvsp125)
end
		end

	yy_do_action_297
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval125 := yyvs125.item (yyvsp125) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines125.force (yyvs125, yyval125, yyvsp125)
end
		end

	yy_do_action_298
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval125 := ast_factory.new_eiffel_list_type (counter_value + 1)
				if attached yyval125 as l_list and then attached yyvs85.item (yyvsp85) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp125 := yyvsp125 + 1
	yyvsp85 := yyvsp85 -1
	if yyvsp125 >= yyvsc125 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs125")
		end
		yyvsc125 := yyvsc125 + yyInitial_yyvs_size
		yyvs125 := yyspecial_routines125.aliased_resized_area (yyvs125, yyvsc125)
	end
	yyspecial_routines125.force (yyvs125, yyval125, yyvsp125)
end
		end

	yy_do_action_299
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval125 := yyvs125.item (yyvsp125)
				if attached yyval125 as l_list and then attached yyvs85.item (yyvsp85) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines125.force (yyvs125, yyval125, yyvsp125)
end
		end

	yy_do_action_300
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp85 >= yyvsc85 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs85")
		end
		yyvsc85 := yyvsc85 + yyInitial_yyvs_size
		yyvs85 := yyspecial_routines85.aliased_resized_area (yyvs85, yyvsc85)
	end
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_301
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)), filename,
							once "Empty Type_list is not allowed and will be discarded."))
				end
				if attached ast_factory.new_eiffel_list_type (0) as l_type_list then
					l_type_list.set_positions (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
					yyval85 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), l_type_list)
				else
					yyval85 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void)
  				end
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -2
	if yyvsp85 >= yyvsc85 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs85")
		end
		yyvsc85 := yyvsc85 + yyInitial_yyvs_size
		yyvs85 := yyspecial_routines85.aliased_resized_area (yyvs85, yyvsc85)
	end
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_302
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs125.item (yyvsp125) as l_list then
					l_list.set_positions (yyvs4.item (yyvsp4), last_rsqure.item)
				end
				yyval85 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs125.item (yyvsp125))
				last_rsqure.remove
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	yyvsp125 := yyvsp125 -1
	if yyvsp85 >= yyvsc85 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs85")
		end
		yyvsc85 := yyvsc85 + yyInitial_yyvs_size
		yyvs85 := yyspecial_routines85.aliased_resized_area (yyvs85, yyvsc85)
	end
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_303
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := ast_factory.new_named_tuple_type_as (
					yyvs2.item (yyvsp2), ast_factory.new_formal_argu_dec_list_as (yyvs126.item (yyvsp126), yyvs4.item (yyvsp4), last_rsqure.item))
				last_rsqure.remove
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	yyvsp126 := yyvsp126 -1
	if yyvsp85 >= yyvsc85 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs85")
		end
		yyvsc85 := yyvsc85 + yyInitial_yyvs_size
		yyvs85 := yyspecial_routines85.aliased_resized_area (yyvs85, yyvsc85)
	end
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_304
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval125 := ast_factory.new_eiffel_list_type (counter_value + 1)
				if attached yyval125 as l_list and then attached yyvs85.item (yyvsp85) as l_val then
					l_list.reverse_extend (l_val)
				end
				last_rsqure.force (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp125 := yyvsp125 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp125 >= yyvsc125 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs125")
		end
		yyvsc125 := yyvsc125 + yyInitial_yyvs_size
		yyvs125 := yyspecial_routines125.aliased_resized_area (yyvs125, yyvsc125)
	end
	yyspecial_routines125.force (yyvs125, yyval125, yyvsp125)
end
		end

	yy_do_action_305
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval125 := yyvs125.item (yyvsp125)
				if
					attached yyval125 as l_list and then attached yyvs2.item (yyvsp2) as l_val and then
					attached new_class_type (l_val, Void) as l_class_type
				then
					l_val.to_upper		
					l_list.reverse_extend (l_class_type)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines125.force (yyvs125, yyval125, yyvsp125)
end
		end

	yy_do_action_306
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval125 := yyvs125.item (yyvsp125)
				if attached yyval125 as l_list and then attached yyvs85.item (yyvsp85) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines125.force (yyvs125, yyval125, yyvsp125)
end
		end

	yy_do_action_307
			--|#line <not available> "eiffel.y"
		local
			yyval126: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval126 := ast_factory.new_eiffel_list_type_dec_as (counter2_value + 1)
				if
					attached yyval126 as l_named_list and then attached yyvs2.item (yyvsp2) as l_name and then
					attached ast_factory.new_identifier_list (counter_value + 1) as l_list and then
					attached ast_factory.new_type_dec_as (l_list, yyvs85.item (yyvsp85), yyvs4.item (yyvsp4 - 1)) as l_type_dec_as
				then
					l_name.to_lower		
					l_list.reverse_extend (l_name.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_name)
					l_named_list.reverse_extend (l_type_dec_as)
				end
				last_rsqure.force (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp126 := yyvsp126 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp85 := yyvsp85 -1
	if yyvsp126 >= yyvsc126 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs126")
		end
		yyvsc126 := yyvsc126 + yyInitial_yyvs_size
		yyvs126 := yyspecial_routines126.aliased_resized_area (yyvs126, yyvsc126)
	end
	yyspecial_routines126.force (yyvs126, yyval126, yyvsp126)
end
		end

	yy_do_action_308
			--|#line <not available> "eiffel.y"
		local
			yyval126: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval126 := yyvs126.item (yyvsp126)
				if
					attached yyval126 as l_named_list and then not l_named_list.is_empty and then
					attached yyvs2.item (yyvsp2) as l_name and then
					attached l_named_list.reversed_first.id_list as l_list
				then
					l_name.to_lower		
					l_list.reverse_extend (l_name.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_name)
					ast_factory.reverse_extend_identifier_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines126.force (yyvs126, yyval126, yyvsp126)
end
		end

	yy_do_action_309
			--|#line <not available> "eiffel.y"
		local
			yyval126: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				remove_counter
				yyval126 := yyvs126.item (yyvsp126)
				if
					attached yyval126 as l_named_list and then attached yyvs2.item (yyvsp2) as l_name and then yyvs85.item (yyvsp85) /= Void and then
					attached ast_factory.new_identifier_list (counter_value + 1) as l_list and then
					attached ast_factory.new_type_dec_as (l_list, yyvs85.item (yyvsp85), yyvs4.item (yyvsp4 - 1)) as l_type_dec_as
				then
					l_name.to_lower		
					l_list.reverse_extend (l_name.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_name)
					l_named_list.reverse_extend (l_type_dec_as)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp85 := yyvsp85 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines126.force (yyvs126, yyval126, yyvsp126)
end
		end

	yy_do_action_310
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- $$ := Void
				set_formal_generics_end_positions (True)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp111 := yyvsp111 + 1
	if yyvsp111 >= yyvsc111 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs111")
		end
		yyvsc111 := yyvsc111 + yyInitial_yyvs_size
		yyvs111 := yyspecial_routines111.aliased_resized_area (yyvs111, yyvsc111)
	end
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_311
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)), filename,
							once "Empty Formal_generic_list is not allowed and will be discarded."))
				end
				set_formal_generics_end_positions (True)
				yyval111 := ast_factory.new_eiffel_list_formal_dec_as (0)
				if attached yyval111 as l_formals then
					l_formals.set_squre_symbols (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp111 := yyvsp111 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp111 >= yyvsc111 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs111")
		end
		yyvsc111 := yyvsc111 + yyInitial_yyvs_size
		yyvs111 := yyspecial_routines111.aliased_resized_area (yyvs111, yyvsc111)
	end
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_312
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_formal_generics_end_positions (False)
				yyval111 := yyvs111.item (yyvsp111)
				if attached yyval111 as l_formals then
					l_formals.transform_class_types_to_formals_and_record_suppliers (ast_factory, suppliers, formal_parameters)
					l_formals.set_squre_symbols (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -4
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_313
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval111 := ast_factory.new_eiffel_list_formal_dec_as (counter_value + 1)
				if attached yyval111 as l_list and then attached yyvs56.item (yyvsp56) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp111 := yyvsp111 + 1
	yyvsp56 := yyvsp56 -1
	if yyvsp111 >= yyvsc111 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs111")
		end
		yyvsc111 := yyvsc111 + yyInitial_yyvs_size
		yyvs111 := yyspecial_routines111.aliased_resized_area (yyvs111, yyvsc111)
	end
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_314
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval111 := yyvs111.item (yyvsp111)
				if attached yyval111 as l_list and then attached yyvs56.item (yyvsp56) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp56 := yyvsp56 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_315
			--|#line <not available> "eiffel.y"
		local
			yyval55: detachable FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_id and then {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval55 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), True, False, False, yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp55 := yyvsp55 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp55 >= yyvsc55 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs55")
		end
		yyvsc55 := yyvsc55 + yyInitial_yyvs_size
		yyvs55 := yyspecial_routines55.aliased_resized_area (yyvs55, yyvsc55)
	end
	yyspecial_routines55.force (yyvs55, yyval55, yyvsp55)
end
		end

	yy_do_action_316
			--|#line <not available> "eiffel.y"
		local
			yyval55: detachable FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_id and then {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval55 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, True, False, yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp55 := yyvsp55 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp55 >= yyvsc55 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs55")
		end
		yyvsc55 := yyvsc55 + yyInitial_yyvs_size
		yyvs55 := yyspecial_routines55.aliased_resized_area (yyvs55, yyvsc55)
	end
	yyspecial_routines55.force (yyvs55, yyval55, yyvsp55)
end
		end

	yy_do_action_317
			--|#line <not available> "eiffel.y"
		local
			yyval55: detachable FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_id and then {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$1' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval55 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, False, True, yyvs14.item (yyvsp14))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp55 := yyvsp55 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp55 >= yyvsc55 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs55")
		end
		yyvsc55 := yyvsc55 + yyInitial_yyvs_size
		yyvs55 := yyspecial_routines55.aliased_resized_area (yyvs55, yyvsc55)
	end
	yyspecial_routines55.force (yyvs55, yyval55, yyvsp55)
end
		end

	yy_do_action_318
			--|#line <not available> "eiffel.y"
		local
			yyval55: detachable FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_id and then {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$1' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval55 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, False, False, Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp55 := yyvsp55 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp55 >= yyvsc55 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs55")
		end
		yyvsc55 := yyvsc55 + yyInitial_yyvs_size
		yyvs55 := yyspecial_routines55.aliased_resized_area (yyvs55, yyvsc55)
	end
	yyspecial_routines55.force (yyvs55, yyval55, yyvsp55)
end
		end

	yy_do_action_319
			--|#line <not available> "eiffel.y"
		local
			yyval56: detachable FORMAL_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs130.item (yyvsp130) as l_constraint then
					if attached l_constraint.creation_constrain as l_creation_constraint then
						yyval56 := ast_factory.new_formal_dec_as (yyvs55.item (yyvsp55), l_constraint.type, l_creation_constraint.feature_list, l_constraint.constrain_symbol, l_creation_constraint.create_keyword, l_creation_constraint.end_keyword)
					else
						yyval56 := ast_factory.new_formal_dec_as (yyvs55.item (yyvsp55), l_constraint.type, Void, l_constraint.constrain_symbol, Void, Void)
					end					
				else
					yyval56 := ast_factory.new_formal_dec_as (yyvs55.item (yyvsp55), Void, Void, Void, Void, Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp55 := yyvsp55 -1
	yyvsp130 := yyvsp130 -1
	yyspecial_routines56.force (yyvs56, yyval56, yyvsp56)
end
		end

	yy_do_action_320
			--|#line <not available> "eiffel.y"
		local
			yyval56: detachable FORMAL_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs55.item (yyvsp55) as l_formal then
						-- Needs to be done here, in case current formal is used in
						-- Constraint.
					formal_parameters.extend (l_formal)
					l_formal.set_position (formal_parameters.count)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp56 := yyvsp56 + 1
	if yyvsp56 >= yyvsc56 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs56")
		end
		yyvsc56 := yyvsc56 + yyInitial_yyvs_size
		yyvs56 := yyspecial_routines56.aliased_resized_area (yyvs56, yyvsc56)
	end
	yyspecial_routines56.force (yyvs56, yyval56, yyvsp56)
end
		end

	yy_do_action_321
			--|#line <not available> "eiffel.y"
		local
			yyval130: detachable CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp130 := yyvsp130 + 1
	if yyvsp130 >= yyvsc130 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs130")
		end
		yyvsc130 := yyvsc130 + yyInitial_yyvs_size
		yyvs130 := yyspecial_routines130.aliased_resized_area (yyvs130, yyvsc130)
	end
	yyspecial_routines130.force (yyvs130, yyval130, yyvsp130)
end
		end

	yy_do_action_322
			--|#line <not available> "eiffel.y"
		local
			yyval130: detachable CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- We do not want Void items in this list.
				if
					attached yyvs132.item (yyvsp132) as l_val and then
					attached ast_factory.new_eiffel_list_constraining_type_as (1) as l_list
				then
					l_list.reverse_extend (l_val)
					yyval130 := ast_factory.new_constraint_triple (yyvs4.item (yyvsp4), l_list, yyvs107.item (yyvsp107))
				else
					yyval130 := ast_factory.new_constraint_triple (yyvs4.item (yyvsp4), Void, yyvs107.item (yyvsp107))
				end

			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp130 := yyvsp130 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp132 := yyvsp132 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp130 >= yyvsc130 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs130")
		end
		yyvsc130 := yyvsc130 + yyInitial_yyvs_size
		yyvs130 := yyspecial_routines130.aliased_resized_area (yyvs130, yyvsc130)
	end
	yyspecial_routines130.force (yyvs130, yyval130, yyvsp130)
end
		end

	yy_do_action_323
			--|#line <not available> "eiffel.y"
		local
			yyval130: detachable CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval130 := ast_factory.new_constraint_triple (yyvs4.item (yyvsp4 - 2), yyvs131.item (yyvsp131), yyvs107.item (yyvsp107))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp130 := yyvsp130 + 1
	yyvsp4 := yyvsp4 -3
	yyvsp1 := yyvsp1 -2
	yyvsp131 := yyvsp131 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp130 >= yyvsc130 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs130")
		end
		yyvsc130 := yyvsc130 + yyInitial_yyvs_size
		yyvs130 := yyspecial_routines130.aliased_resized_area (yyvs130, yyvsc130)
	end
	yyspecial_routines130.force (yyvs130, yyval130, yyvsp130)
end
		end

	yy_do_action_324
			--|#line <not available> "eiffel.y"
		local
			yyval132: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval132 := ast_factory.new_constraining_type (yyvs85.item (yyvsp85), yyvs121.item (yyvsp121), yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp132 := yyvsp132 -1
	yyvsp85 := yyvsp85 -1
	yyvsp121 := yyvsp121 -1
	yyvsp14 := yyvsp14 -1
	yyspecial_routines132.force (yyvs132, yyval132, yyvsp132)
end
		end

	yy_do_action_325
			--|#line <not available> "eiffel.y"
		local
			yyval132: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

is_constraint_renaming := True
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp132 := yyvsp132 + 1
	if yyvsp132 >= yyvsc132 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs132")
		end
		yyvsc132 := yyvsc132 + yyInitial_yyvs_size
		yyvs132 := yyspecial_routines132.aliased_resized_area (yyvs132, yyvsc132)
	end
	yyspecial_routines132.force (yyvs132, yyval132, yyvsp132)
end
		end

	yy_do_action_326
			--|#line <not available> "eiffel.y"
		local
			yyval132: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

is_constraint_renaming := False
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp132 := yyvsp132 + 1
	if yyvsp132 >= yyvsc132 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs132")
		end
		yyvsc132 := yyvsc132 + yyInitial_yyvs_size
		yyvs132 := yyspecial_routines132.aliased_resized_area (yyvs132, yyvsc132)
	end
	yyspecial_routines132.force (yyvs132, yyval132, yyvsp132)
end
		end

	yy_do_action_327
			--|#line <not available> "eiffel.y"
		local
			yyval132: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval132 := ast_factory.new_constraining_type (yyvs85.item (yyvsp85), Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp132 := yyvsp132 + 1
	yyvsp85 := yyvsp85 -1
	if yyvsp132 >= yyvsc132 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs132")
		end
		yyvsc132 := yyvsc132 + yyInitial_yyvs_size
		yyvs132 := yyspecial_routines132.aliased_resized_area (yyvs132, yyvsc132)
	end
	yyspecial_routines132.force (yyvs132, yyval132, yyvsp132)
end
		end

	yy_do_action_328
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if attached yyvs85.item (yyvsp85) as l_type and then l_type.has_anchor then
					report_one_error (ast_factory.new_vtgc1_error (token_line (l_type), token_column (l_type), filename, l_type))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_329
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if attached yyvs85.item (yyvsp85) as l_type and then l_type.has_anchor then
					report_one_error (ast_factory.new_vtgc1_error (token_line (l_type), token_column (l_type), filename, l_type))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_330
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs85.item (yyvsp85) as l_type then
					report_one_error (ast_factory.new_vtgc1_error (token_line (l_type), token_column (l_type), filename, l_type))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_331
			--|#line <not available> "eiffel.y"
		local
			yyval131: detachable CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if attached yyvs132.item (yyvsp132) as l_val then
					yyval131 := ast_factory.new_eiffel_list_constraining_type_as (counter_value + 1)
					if attached yyval131 as l_list then
						l_list.reverse_extend (l_val)
					end
				else
					yyval131 := ast_factory.new_eiffel_list_constraining_type_as (counter_value)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp131 := yyvsp131 + 1
	yyvsp132 := yyvsp132 -1
	if yyvsp131 >= yyvsc131 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs131")
		end
		yyvsc131 := yyvsc131 + yyInitial_yyvs_size
		yyvs131 := yyspecial_routines131.aliased_resized_area (yyvs131, yyvsc131)
	end
	yyspecial_routines131.force (yyvs131, yyval131, yyvsp131)
end
		end

	yy_do_action_332
			--|#line <not available> "eiffel.y"
		local
			yyval131: detachable CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval131 := yyvs131.item (yyvsp131)
				if attached yyval131 as l_list and then attached yyvs132.item (yyvsp132) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp131 := yyvsp131 -1
	yyvsp132 := yyvsp132 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines131.force (yyvs131, yyval131, yyvsp131)
end
		end

	yy_do_action_333
			--|#line <not available> "eiffel.y"
		local
			yyval131: detachable CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Only increment counter when clause is not Void.
				if yyvs132.item (yyvsp132) /= Void then
					increment_counter
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp131 := yyvsp131 + 1
	if yyvsp131 >= yyvsc131 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs131")
		end
		yyvsc131 := yyvsc131 + yyInitial_yyvs_size
		yyvs131 := yyspecial_routines131.aliased_resized_area (yyvs131, yyvsc131)
	end
	yyspecial_routines131.force (yyvs131, yyval131, yyvsp131)
end
		end

	yy_do_action_334
			--|#line <not available> "eiffel.y"
		local
			yyval107: detachable CREATION_CONSTRAIN_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp107 := yyvsp107 + 1
	if yyvsp107 >= yyvsc107 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs107")
		end
		yyvsc107 := yyvsc107 + yyInitial_yyvs_size
		yyvs107 := yyspecial_routines107.aliased_resized_area (yyvs107, yyvsc107)
	end
	yyspecial_routines107.force (yyvs107, yyval107, yyvsp107)
end
		end

	yy_do_action_335
			--|#line <not available> "eiffel.y"
		local
			yyval107: detachable CREATION_CONSTRAIN_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval107 := ast_factory.new_creation_constrain_triple (yyvs105.item (yyvsp105), yyvs14.item (yyvsp14 - 1), yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp107 := yyvsp107 + 1
	yyvsp14 := yyvsp14 -2
	yyvsp105 := yyvsp105 -1
	if yyvsp107 >= yyvsc107 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs107")
		end
		yyvsc107 := yyvsc107 + yyInitial_yyvs_size
		yyvs107 := yyspecial_routines107.aliased_resized_area (yyvs107, yyvsc107)
	end
	yyspecial_routines107.force (yyvs107, yyval107, yyvsp107)
end
		end

	yy_do_action_336
			--|#line <not available> "eiffel.y"
		local
			yyval58: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval58 := ast_factory.new_if_as (yyvs48.item (yyvsp48), yyvs115.item (yyvsp115), Void, Void, yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp58 := yyvsp58 + 1
	yyvsp14 := yyvsp14 -3
	yyvsp48 := yyvsp48 -1
	yyvsp115 := yyvsp115 -1
	if yyvsp58 >= yyvsc58 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs58")
		end
		yyvsc58 := yyvsc58 + yyInitial_yyvs_size
		yyvs58 := yyspecial_routines58.aliased_resized_area (yyvs58, yyvsc58)
	end
	yyspecial_routines58.force (yyvs58, yyval58, yyvsp58)
end
		end

	yy_do_action_337
			--|#line <not available> "eiffel.y"
		local
			yyval58: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval58 := ast_factory.new_if_as (yyvs48.item (yyvsp48), yyvs115.item (yyvsp115 - 1), Void, yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 3), yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp58 := yyvsp58 + 1
	yyvsp14 := yyvsp14 -4
	yyvsp48 := yyvsp48 -1
	yyvsp115 := yyvsp115 -2
	if yyvsp58 >= yyvsc58 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs58")
		end
		yyvsc58 := yyvsc58 + yyInitial_yyvs_size
		yyvs58 := yyspecial_routines58.aliased_resized_area (yyvs58, yyvsc58)
	end
	yyspecial_routines58.force (yyvs58, yyval58, yyvsp58)
end
		end

	yy_do_action_338
			--|#line <not available> "eiffel.y"
		local
			yyval58: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval58 := ast_factory.new_if_as (yyvs48.item (yyvsp48), yyvs115.item (yyvsp115), yyvs96.item (yyvsp96), Void, yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp58 := yyvsp58 + 1
	yyvsp14 := yyvsp14 -3
	yyvsp48 := yyvsp48 -1
	yyvsp115 := yyvsp115 -1
	yyvsp96 := yyvsp96 -1
	if yyvsp58 >= yyvsc58 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs58")
		end
		yyvsc58 := yyvsc58 + yyInitial_yyvs_size
		yyvs58 := yyspecial_routines58.aliased_resized_area (yyvs58, yyvsc58)
	end
	yyspecial_routines58.force (yyvs58, yyval58, yyvsp58)
end
		end

	yy_do_action_339
			--|#line <not available> "eiffel.y"
		local
			yyval58: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval58 := ast_factory.new_if_as (yyvs48.item (yyvsp48), yyvs115.item (yyvsp115 - 1), yyvs96.item (yyvsp96), yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 3), yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp58 := yyvsp58 + 1
	yyvsp14 := yyvsp14 -4
	yyvsp48 := yyvsp48 -1
	yyvsp115 := yyvsp115 -2
	yyvsp96 := yyvsp96 -1
	if yyvsp58 >= yyvsc58 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs58")
		end
		yyvsc58 := yyvsc58 + yyInitial_yyvs_size
		yyvs58 := yyspecial_routines58.aliased_resized_area (yyvs58, yyvsc58)
	end
	yyspecial_routines58.force (yyvs58, yyval58, yyvsp58)
end
		end

	yy_do_action_340
			--|#line <not available> "eiffel.y"
		local
			yyval96: detachable EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval96 := yyvs96.item (yyvsp96) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines96.force (yyvs96, yyval96, yyvsp96)
end
		end

	yy_do_action_341
			--|#line <not available> "eiffel.y"
		local
			yyval96: detachable EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval96 := ast_factory.new_eiffel_list_elseif_as (counter_value + 1)
				if attached yyval96 as l_list and then attached yyvs44.item (yyvsp44) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp96 := yyvsp96 + 1
	yyvsp44 := yyvsp44 -1
	if yyvsp96 >= yyvsc96 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs96")
		end
		yyvsc96 := yyvsc96 + yyInitial_yyvs_size
		yyvs96 := yyspecial_routines96.aliased_resized_area (yyvs96, yyvsc96)
	end
	yyspecial_routines96.force (yyvs96, yyval96, yyvsp96)
end
		end

	yy_do_action_342
			--|#line <not available> "eiffel.y"
		local
			yyval96: detachable EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval96 := yyvs96.item (yyvsp96)
				if attached yyval96 as l_list and then attached yyvs44.item (yyvsp44) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp44 := yyvsp44 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines96.force (yyvs96, yyval96, yyvsp96)
end
		end

	yy_do_action_343
			--|#line <not available> "eiffel.y"
		local
			yyval44: detachable ELSIF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval44 := ast_factory.new_elseif_as (yyvs48.item (yyvsp48), yyvs115.item (yyvsp115), yyvs14.item (yyvsp14 - 1), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp44 := yyvsp44 + 1
	yyvsp14 := yyvsp14 -2
	yyvsp48 := yyvsp48 -1
	yyvsp115 := yyvsp115 -1
	if yyvsp44 >= yyvsc44 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs44")
		end
		yyvsc44 := yyvsc44 + yyInitial_yyvs_size
		yyvs44 := yyspecial_routines44.aliased_resized_area (yyvs44, yyvsc44)
	end
	yyspecial_routines44.force (yyvs44, yyval44, yyvsp44)
end
		end

	yy_do_action_344
			--|#line <not available> "eiffel.y"
		local
			yyval61: detachable INSPECT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := ast_factory.new_inspect_as (yyvs48.item (yyvsp48), yyvs93.item (yyvsp93), Void, yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp61 := yyvsp61 + 1
	yyvsp14 := yyvsp14 -2
	yyvsp48 := yyvsp48 -1
	yyvsp93 := yyvsp93 -1
	if yyvsp61 >= yyvsc61 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs61")
		end
		yyvsc61 := yyvsc61 + yyInitial_yyvs_size
		yyvs61 := yyspecial_routines61.aliased_resized_area (yyvs61, yyvsc61)
	end
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_345
			--|#line <not available> "eiffel.y"
		local
			yyval61: detachable INSPECT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs115.item (yyvsp115) /= Void then
					yyval61 := ast_factory.new_inspect_as (yyvs48.item (yyvsp48), yyvs93.item (yyvsp93), yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1))
				else
					yyval61 := ast_factory.new_inspect_as (yyvs48.item (yyvsp48), yyvs93.item (yyvsp93),
						ast_factory.new_eiffel_list_instruction_as (0), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp61 := yyvsp61 + 1
	yyvsp14 := yyvsp14 -3
	yyvsp48 := yyvsp48 -1
	yyvsp93 := yyvsp93 -1
	yyvsp115 := yyvsp115 -1
	if yyvsp61 >= yyvsc61 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs61")
		end
		yyvsc61 := yyvsc61 + yyInitial_yyvs_size
		yyvs61 := yyspecial_routines61.aliased_resized_area (yyvs61, yyvsc61)
	end
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_346
			--|#line <not available> "eiffel.y"
		local
			yyval93: detachable EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp93 := yyvsp93 + 1
	if yyvsp93 >= yyvsc93 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs93")
		end
		yyvsc93 := yyvsc93 + yyInitial_yyvs_size
		yyvs93 := yyspecial_routines93.aliased_resized_area (yyvs93, yyvsc93)
	end
	yyspecial_routines93.force (yyvs93, yyval93, yyvsp93)
end
		end

	yy_do_action_347
			--|#line <not available> "eiffel.y"
		local
			yyval93: detachable EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval93 := yyvs93.item (yyvsp93) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines93.force (yyvs93, yyval93, yyvsp93)
end
		end

	yy_do_action_348
			--|#line <not available> "eiffel.y"
		local
			yyval93: detachable EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval93 := ast_factory.new_eiffel_list_case_as (counter_value + 1)
				if attached yyval93 as l_list and then attached yyvs35.item (yyvsp35) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp93 := yyvsp93 + 1
	yyvsp35 := yyvsp35 -1
	if yyvsp93 >= yyvsc93 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs93")
		end
		yyvsc93 := yyvsc93 + yyInitial_yyvs_size
		yyvs93 := yyspecial_routines93.aliased_resized_area (yyvs93, yyvsc93)
	end
	yyspecial_routines93.force (yyvs93, yyval93, yyvsp93)
end
		end

	yy_do_action_349
			--|#line <not available> "eiffel.y"
		local
			yyval93: detachable EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval93 := yyvs93.item (yyvsp93)
				if attached yyval93 as l_list and then attached yyvs35.item (yyvsp35) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp35 := yyvsp35 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines93.force (yyvs93, yyval93, yyvsp93)
end
		end

	yy_do_action_350
			--|#line <not available> "eiffel.y"
		local
			yyval35: detachable CASE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_case_as (yyvs116.item (yyvsp116), yyvs115.item (yyvsp115), yyvs14.item (yyvsp14 - 1), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp35 := yyvsp35 + 1
	yyvsp14 := yyvsp14 -2
	yyvsp1 := yyvsp1 -2
	yyvsp116 := yyvsp116 -1
	yyvsp115 := yyvsp115 -1
	if yyvsp35 >= yyvsc35 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs35")
		end
		yyvsc35 := yyvsc35 + yyInitial_yyvs_size
		yyvs35 := yyspecial_routines35.aliased_resized_area (yyvs35, yyvsc35)
	end
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_351
			--|#line <not available> "eiffel.y"
		local
			yyval116: detachable EIFFEL_LIST [INTERVAL_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval116 := ast_factory.new_eiffel_list_interval_as (counter_value + 1)
				if attached yyval116 as l_list and then attached yyvs65.item (yyvsp65) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp116 := yyvsp116 + 1
	yyvsp65 := yyvsp65 -1
	if yyvsp116 >= yyvsc116 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs116")
		end
		yyvsc116 := yyvsc116 + yyInitial_yyvs_size
		yyvs116 := yyspecial_routines116.aliased_resized_area (yyvs116, yyvsc116)
	end
	yyspecial_routines116.force (yyvs116, yyval116, yyvsp116)
end
		end

	yy_do_action_352
			--|#line <not available> "eiffel.y"
		local
			yyval116: detachable EIFFEL_LIST [INTERVAL_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval116 := yyvs116.item (yyvsp116)
				if attached yyval116 as l_list and then attached yyvs65.item (yyvsp65) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp65 := yyvsp65 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines116.force (yyvs116, yyval116, yyvsp116)
end
		end

	yy_do_action_353
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs63.item (yyvsp63), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp63 := yyvsp63 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_354
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs63.item (yyvsp63 - 1), yyvs63.item (yyvsp63), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp63 := yyvsp63 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_355
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_356
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs3.item (yyvsp3 - 1), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp3 := yyvsp3 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_357
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_358
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_359
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs63.item (yyvsp63), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp63 := yyvsp63 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_360
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs63.item (yyvsp63), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_361
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp3 := yyvsp3 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_362
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_363
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs74.item (yyvsp74), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp74 := yyvsp74 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_364
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs74.item (yyvsp74), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp74 := yyvsp74 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_365
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs74.item (yyvsp74), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp74 := yyvsp74 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_366
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs74.item (yyvsp74 - 1), yyvs74.item (yyvsp74), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp74 := yyvsp74 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_367
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs74.item (yyvsp74), yyvs63.item (yyvsp63), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp74 := yyvsp74 -1
	yyvsp4 := yyvsp4 -1
	yyvsp63 := yyvsp63 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_368
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs63.item (yyvsp63), yyvs74.item (yyvsp74), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvsp74 := yyvsp74 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_369
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs74.item (yyvsp74), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp74 := yyvsp74 -1
	yyvsp4 := yyvsp4 -1
	yyvsp3 := yyvsp3 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_370
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), yyvs74.item (yyvsp74), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp4 := yyvsp4 -1
	yyvsp74 := yyvsp74 -1
	if yyvsp65 >= yyvsc65 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs65")
		end
		yyvsc65 := yyvsc65 + yyInitial_yyvs_size
		yyvs65 := yyspecial_routines65.aliased_resized_area (yyvs65, yyvsc65)
	end
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_371
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs90.item (yyvsp90)), token_column (yyvs90.item (yyvsp90)), filename,
						once "Loop variant should appear just before the end keyword of the loop."))
				end
				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					yyval68 := ast_factory.new_loop_as (Void, yyvs115.item (yyvsp115 - 1), l_invariant_pair.second, yyvs90.item (yyvsp90), yyvs48.item (yyvsp48), yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 3), l_invariant_pair.first, yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1), Void, Void)
				else
					yyval68 := ast_factory.new_loop_as (Void, yyvs115.item (yyvsp115 - 1), Void, yyvs90.item (yyvsp90), yyvs48.item (yyvsp48), yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 3), Void, yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1), Void, Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp68 := yyvsp68 + 1
	yyvsp14 := yyvsp14 -4
	yyvsp115 := yyvsp115 -2
	yyvsp22 := yyvsp22 -1
	yyvsp90 := yyvsp90 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp68 >= yyvsc68 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs68")
		end
		yyvsc68 := yyvsc68 + yyInitial_yyvs_size
		yyvs68 := yyspecial_routines68.aliased_resized_area (yyvs68, yyvsc68)
	end
	yyspecial_routines68.force (yyvs68, yyval68, yyvsp68)
end
		end

	yy_do_action_372
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					yyval68 := ast_factory.new_loop_as (Void, yyvs115.item (yyvsp115 - 1), l_invariant_pair.second, yyvs90.item (yyvsp90), yyvs48.item (yyvsp48), yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 3), l_invariant_pair.first, yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1), Void, Void)
				else
					yyval68 := ast_factory.new_loop_as (Void, yyvs115.item (yyvsp115 - 1), Void, yyvs90.item (yyvsp90), yyvs48.item (yyvsp48), yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 3), Void, yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1), Void, Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp68 := yyvsp68 + 1
	yyvsp14 := yyvsp14 -4
	yyvsp115 := yyvsp115 -2
	yyvsp22 := yyvsp22 -1
	yyvsp48 := yyvsp48 -1
	yyvsp90 := yyvsp90 -1
	if yyvsp68 >= yyvsc68 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs68")
		end
		yyvsc68 := yyvsc68 + yyInitial_yyvs_size
		yyvs68 := yyspecial_routines68.aliased_resized_area (yyvs68, yyvsc68)
	end
	yyspecial_routines68.force (yyvs68, yyval68, yyvsp68)
end
		end

	yy_do_action_373
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval68 := ast_factory.new_loop_as (yyvs114.item (yyvsp114), yyvs115.item (yyvsp115 - 1), l_invariant_pair.second, yyvs90.item (yyvsp90), l_until_pair.second, yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 2), l_invariant_pair.first, l_until_pair.first, yyvs14.item (yyvsp14 - 1), Void, Void)
					else
						yyval68 := ast_factory.new_loop_as (yyvs114.item (yyvsp114), yyvs115.item (yyvsp115 - 1), l_invariant_pair.second, yyvs90.item (yyvsp90), Void, yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 2), l_invariant_pair.first, Void, yyvs14.item (yyvsp14 - 1), Void, Void)
					end
				else
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval68 := ast_factory.new_loop_as (yyvs114.item (yyvsp114), yyvs115.item (yyvsp115 - 1), Void, yyvs90.item (yyvsp90), l_until_pair.second, yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 2), Void, l_until_pair.first, yyvs14.item (yyvsp14 - 1), Void, Void)
					else
						yyval68 := ast_factory.new_loop_as (yyvs114.item (yyvsp114), yyvs115.item (yyvsp115 - 1), Void, yyvs90.item (yyvsp90), Void, yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 2), Void, Void, yyvs14.item (yyvsp14 - 1), Void, Void)
					end
				end
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp68 := yyvsp68 + 1
	yyvsp114 := yyvsp114 -1
	yyvsp14 := yyvsp14 -3
	yyvsp115 := yyvsp115 -2
	yyvsp22 := yyvsp22 -1
	yyvsp23 := yyvsp23 -1
	yyvsp90 := yyvsp90 -1
	if yyvsp68 >= yyvsc68 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs68")
		end
		yyvsc68 := yyvsc68 + yyInitial_yyvs_size
		yyvs68 := yyspecial_routines68.aliased_resized_area (yyvs68, yyvsc68)
	end
	yyspecial_routines68.force (yyvs68, yyval68, yyvsp68)
end
		end

	yy_do_action_374
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval68 := ast_factory.new_loop_as (yyvs114.item (yyvsp114), Void, l_invariant_pair.second, yyvs90.item (yyvsp90), l_until_pair.second, yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), Void, l_invariant_pair.first, l_until_pair.first, yyvs14.item (yyvsp14 - 1), Void, Void)
					else
						yyval68 := ast_factory.new_loop_as (yyvs114.item (yyvsp114), Void, l_invariant_pair.second, yyvs90.item (yyvsp90), Void, yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), Void, l_invariant_pair.first, Void, yyvs14.item (yyvsp14 - 1), Void, Void)
					end
				else
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval68 := ast_factory.new_loop_as (yyvs114.item (yyvsp114), Void, Void, yyvs90.item (yyvsp90), l_until_pair.second, yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), Void, Void, l_until_pair.first, yyvs14.item (yyvsp14 - 1), Void, Void)
					else
						yyval68 := ast_factory.new_loop_as (yyvs114.item (yyvsp114), Void, Void, yyvs90.item (yyvsp90), Void, yyvs115.item (yyvsp115), yyvs14.item (yyvsp14), Void, Void, Void, yyvs14.item (yyvsp14 - 1), Void, Void)
					end
				end
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp68 := yyvsp68 + 1
	yyvsp114 := yyvsp114 -1
	yyvsp22 := yyvsp22 -1
	yyvsp23 := yyvsp23 -1
	yyvsp14 := yyvsp14 -2
	yyvsp115 := yyvsp115 -1
	yyvsp90 := yyvsp90 -1
	if yyvsp68 >= yyvsc68 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs68")
		end
		yyvsc68 := yyvsc68 + yyInitial_yyvs_size
		yyvs68 := yyspecial_routines68.aliased_resized_area (yyvs68, yyvsc68)
	end
	yyspecial_routines68.force (yyvs68, yyval68, yyvsp68)
end
		end

	yy_do_action_375
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval68 := ast_factory.new_loop_as (ast_factory.new_symbolic_iteration_as (yyvs2.item (yyvsp2), yyvs4.item (yyvsp4), yyvs48.item (yyvsp48), extract_symbol (yyvs6.item (yyvsp6 - 1))), Void, Void, Void, Void, yyvs115.item (yyvsp115), Void, Void, Void, Void, Void, extract_symbol (yyvs6.item (yyvsp6 - 2)), extract_symbol (yyvs6.item (yyvsp6)))
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp6 := yyvsp6 -3
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	yyvsp115 := yyvsp115 -1
	yyspecial_routines68.force (yyvs68, yyval68, yyvsp68)
end
		end

	yy_do_action_376
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

enter_scope; add_scope_iteration (yyvs2.item (yyvsp2))
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp68 := yyvsp68 + 1
	if yyvsp68 >= yyvsc68 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs68")
		end
		yyvsc68 := yyvsc68 + yyInitial_yyvs_size
		yyvs68 := yyspecial_routines68.aliased_resized_area (yyvs68, yyvsc68)
	end
	yyspecial_routines68.force (yyvs68, yyval68, yyvsp68)
end
		end

	yy_do_action_377
			--|#line <not available> "eiffel.y"
		local
			yyval67: detachable LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval67 := ast_factory.new_loop_expr_as (yyvs114.item (yyvsp114), l_invariant_pair.first, l_invariant_pair.second, l_until_pair.first, l_until_pair.second, yyvs14.item (yyvsp14 - 1), Void, True, yyvs48.item (yyvsp48), yyvs90.item (yyvsp90), yyvs14.item (yyvsp14))
					else
						yyval67 := ast_factory.new_loop_expr_as (yyvs114.item (yyvsp114), l_invariant_pair.first, l_invariant_pair.second, Void, Void, yyvs14.item (yyvsp14 - 1), Void, True, yyvs48.item (yyvsp48), yyvs90.item (yyvsp90), yyvs14.item (yyvsp14))
					end
				else
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval67 := ast_factory.new_loop_expr_as (yyvs114.item (yyvsp114), Void, Void, l_until_pair.first, l_until_pair.second, yyvs14.item (yyvsp14 - 1), Void, True, yyvs48.item (yyvsp48), yyvs90.item (yyvsp90), yyvs14.item (yyvsp14))
					else
						yyval67 := ast_factory.new_loop_expr_as (yyvs114.item (yyvsp114), Void, Void, Void, Void, yyvs14.item (yyvsp14 - 1), Void, True, yyvs48.item (yyvsp48), yyvs90.item (yyvsp90), yyvs14.item (yyvsp14))
					end
				end
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp67 := yyvsp67 + 1
	yyvsp114 := yyvsp114 -1
	yyvsp22 := yyvsp22 -1
	yyvsp23 := yyvsp23 -1
	yyvsp14 := yyvsp14 -2
	yyvsp48 := yyvsp48 -1
	yyvsp90 := yyvsp90 -1
	if yyvsp67 >= yyvsc67 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs67")
		end
		yyvsc67 := yyvsc67 + yyInitial_yyvs_size
		yyvs67 := yyspecial_routines67.aliased_resized_area (yyvs67, yyvsc67)
	end
	yyspecial_routines67.force (yyvs67, yyval67, yyvsp67)
end
		end

	yy_do_action_378
			--|#line <not available> "eiffel.y"
		local
			yyval67: detachable LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval67 := ast_factory.new_loop_expr_as (yyvs114.item (yyvsp114), l_invariant_pair.first, l_invariant_pair.second, l_until_pair.first, l_until_pair.second, extract_keyword (yyvs15.item (yyvsp15)), Void, False, yyvs48.item (yyvsp48), yyvs90.item (yyvsp90), yyvs14.item (yyvsp14))
					else
						yyval67 := ast_factory.new_loop_expr_as (yyvs114.item (yyvsp114), l_invariant_pair.first, l_invariant_pair.second, Void, Void, extract_keyword (yyvs15.item (yyvsp15)), Void, False, yyvs48.item (yyvsp48), yyvs90.item (yyvsp90), yyvs14.item (yyvsp14))
					end
				else
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval67 := ast_factory.new_loop_expr_as (yyvs114.item (yyvsp114), Void, Void, l_until_pair.first, l_until_pair.second, extract_keyword (yyvs15.item (yyvsp15)), Void, False, yyvs48.item (yyvsp48), yyvs90.item (yyvsp90), yyvs14.item (yyvsp14))
					else
						yyval67 := ast_factory.new_loop_expr_as (yyvs114.item (yyvsp114), Void, Void, Void, Void, extract_keyword (yyvs15.item (yyvsp15)), Void, False, yyvs48.item (yyvsp48), yyvs90.item (yyvsp90), yyvs14.item (yyvsp14))
					end
				end
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp67 := yyvsp67 + 1
	yyvsp114 := yyvsp114 -1
	yyvsp22 := yyvsp22 -1
	yyvsp23 := yyvsp23 -1
	yyvsp15 := yyvsp15 -1
	yyvsp48 := yyvsp48 -1
	yyvsp90 := yyvsp90 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp67 >= yyvsc67 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs67")
		end
		yyvsc67 := yyvsc67 + yyInitial_yyvs_size
		yyvs67 := yyspecial_routines67.aliased_resized_area (yyvs67, yyvsc67)
	end
	yyspecial_routines67.force (yyvs67, yyval67, yyvsp67)
end
		end

	yy_do_action_379
			--|#line <not available> "eiffel.y"
		local
			yyval67: detachable LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				insert_supplier ("ITERABLE", yyvs2.item (yyvsp2))
				insert_supplier ("ITERATION_CURSOR", yyvs2.item (yyvsp2))
				yyval67 := ast_factory.new_loop_expr_as
					(ast_factory.new_symbolic_iteration_as (yyvs2.item (yyvsp2), yyvs4.item (yyvsp4 - 1), yyvs48.item (yyvsp48 - 1), yyvs4.item (yyvsp4)), Void, Void, Void, Void, Void, extract_symbol (yyvs6.item (yyvsp6)), True, yyvs48.item (yyvsp48), Void, Void)
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp6 := yyvsp6 -1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp48 := yyvsp48 -2
	yyspecial_routines67.force (yyvs67, yyval67, yyvsp67)
end
		end

	yy_do_action_380
			--|#line <not available> "eiffel.y"
		local
			yyval67: detachable LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

enter_scope; add_scope_iteration (yyvs2.item (yyvsp2))
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp67 := yyvsp67 + 1
	if yyvsp67 >= yyvsc67 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs67")
		end
		yyvsc67 := yyvsc67 + yyInitial_yyvs_size
		yyvs67 := yyspecial_routines67.aliased_resized_area (yyvs67, yyvsc67)
	end
	yyspecial_routines67.force (yyvs67, yyval67, yyvsp67)
end
		end

	yy_do_action_381
			--|#line <not available> "eiffel.y"
		local
			yyval67: detachable LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				insert_supplier ("ITERABLE", yyvs2.item (yyvsp2))
				insert_supplier ("ITERATION_CURSOR", yyvs2.item (yyvsp2))
				yyval67 := ast_factory.new_loop_expr_as
					(ast_factory.new_symbolic_iteration_as (yyvs2.item (yyvsp2), yyvs4.item (yyvsp4 - 1), yyvs48.item (yyvsp48 - 1), yyvs4.item (yyvsp4)), Void, Void, Void, Void, Void, extract_symbol (yyvs6.item (yyvsp6)), False, yyvs48.item (yyvsp48), Void, Void)
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp6 := yyvsp6 -1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp48 := yyvsp48 -2
	yyspecial_routines67.force (yyvs67, yyval67, yyvsp67)
end
		end

	yy_do_action_382
			--|#line <not available> "eiffel.y"
		local
			yyval67: detachable LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

enter_scope; add_scope_iteration (yyvs2.item (yyvsp2))
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp67 := yyvsp67 + 1
	if yyvsp67 >= yyvsc67 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs67")
		end
		yyvsc67 := yyvsc67 + yyInitial_yyvs_size
		yyvs67 := yyspecial_routines67.aliased_resized_area (yyvs67, yyvsc67)
	end
	yyspecial_routines67.force (yyvs67, yyval67, yyvsp67)
end
		end

	yy_do_action_383
			--|#line <not available> "eiffel.y"
		local
			yyval114: detachable ITERATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				insert_supplier ("ITERABLE", yyvs2.item (yyvsp2))
				insert_supplier ("ITERATION_CURSOR", yyvs2.item (yyvsp2))
				yyval114 := ast_factory.new_iteration_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs48.item (yyvsp48), yyvs14.item (yyvsp14), yyvs2.item (yyvsp2), False)
				enter_scope
				add_scope_iteration (yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp114 := yyvsp114 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp48 := yyvsp48 -1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp114 >= yyvsc114 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs114")
		end
		yyvsc114 := yyvsc114 + yyInitial_yyvs_size
		yyvs114 := yyspecial_routines114.aliased_resized_area (yyvs114, yyvsc114)
	end
	yyspecial_routines114.force (yyvs114, yyval114, yyvsp114)
end
		end

	yy_do_action_384
			--|#line <not available> "eiffel.y"
		local
			yyval114: detachable ITERATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				insert_supplier ("ITERABLE", yyvs2.item (yyvsp2))
				insert_supplier ("ITERATION_CURSOR", yyvs2.item (yyvsp2))
				yyval114 := ast_factory.new_iteration_as (extract_keyword (yyvs15.item (yyvsp15 - 1)), yyvs48.item (yyvsp48), extract_keyword (yyvs15.item (yyvsp15)), yyvs2.item (yyvsp2), True)
				enter_scope
				add_scope_iteration (yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp114 := yyvsp114 + 1
	yyvsp15 := yyvsp15 -2
	yyvsp48 := yyvsp48 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp114 >= yyvsc114 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs114")
		end
		yyvsc114 := yyvsc114 + yyInitial_yyvs_size
		yyvs114 := yyspecial_routines114.aliased_resized_area (yyvs114, yyvsc114)
	end
	yyspecial_routines114.force (yyvs114, yyval114, yyvsp114)
end
		end

	yy_do_action_385
			--|#line <not available> "eiffel.y"
		local
			yyval22: detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp22 := yyvsp22 + 1
	if yyvsp22 >= yyvsc22 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs22")
		end
		yyvsc22 := yyvsc22 + yyInitial_yyvs_size
		yyvs22 := yyspecial_routines22.aliased_resized_area (yyvs22, yyvsc22)
	end
	yyspecial_routines22.force (yyvs22, yyval22, yyvsp22)
end
		end

	yy_do_action_386
			--|#line <not available> "eiffel.y"
		local
			yyval22: detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval22 := ast_factory.new_invariant_pair (yyvs14.item (yyvsp14), yyvs124.item (yyvsp124)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp124 := yyvsp124 -1
	if yyvsp22 >= yyvsc22 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs22")
		end
		yyvsc22 := yyvsc22 + yyInitial_yyvs_size
		yyvs22 := yyspecial_routines22.aliased_resized_area (yyvs22, yyvsc22)
	end
	yyspecial_routines22.force (yyvs22, yyval22, yyvsp22)
end
		end

	yy_do_action_387
			--|#line <not available> "eiffel.y"
		local
			yyval66: detachable INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp66 := yyvsp66 + 1
	if yyvsp66 >= yyvsc66 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs66")
		end
		yyvsc66 := yyvsc66 + yyInitial_yyvs_size
		yyvs66 := yyspecial_routines66.aliased_resized_area (yyvs66, yyvsc66)
	end
	yyspecial_routines66.force (yyvs66, yyval66, yyvsp66)
end
		end

	yy_do_action_388
			--|#line <not available> "eiffel.y"
		local
			yyval66: detachable INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval66 := ast_factory.new_invariant_as (yyvs124.item (yyvsp124), once_manifest_string_counter_value, yyvs14.item (yyvsp14), object_test_locals)
				reset_feature_frame
				object_test_locals := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp14 := yyvsp14 -1
	yyvsp124 := yyvsp124 -1
	yyspecial_routines66.force (yyvs66, yyval66, yyvsp66)
end
		end

	yy_do_action_389
			--|#line <not available> "eiffel.y"
		local
			yyval66: detachable INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Invariant_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp66 := yyvsp66 + 1
	if yyvsp66 >= yyvsc66 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs66")
		end
		yyvsc66 := yyvsc66 + yyInitial_yyvs_size
		yyvs66 := yyspecial_routines66.aliased_resized_area (yyvs66, yyvsc66)
	end
	yyspecial_routines66.force (yyvs66, yyval66, yyvsp66)
end
		end

	yy_do_action_390
			--|#line <not available> "eiffel.y"
		local
			yyval23: detachable PAIR [KEYWORD_AS, EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp23 := yyvsp23 + 1
	if yyvsp23 >= yyvsc23 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs23")
		end
		yyvsc23 := yyvsc23 + yyInitial_yyvs_size
		yyvs23 := yyspecial_routines23.aliased_resized_area (yyvs23, yyvsc23)
	end
	yyspecial_routines23.force (yyvs23, yyval23, yyvsp23)
end
		end

	yy_do_action_391
			--|#line <not available> "eiffel.y"
		local
			yyval23: detachable PAIR [KEYWORD_AS, EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval23 := ast_factory.new_exit_condition_pair (yyvs14.item (yyvsp14), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp23 := yyvsp23 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp23 >= yyvsc23 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs23")
		end
		yyvsc23 := yyvsc23 + yyInitial_yyvs_size
		yyvs23 := yyspecial_routines23.aliased_resized_area (yyvs23, yyvsc23)
	end
	yyspecial_routines23.force (yyvs23, yyval23, yyvsp23)
end
		end

	yy_do_action_392
			--|#line <not available> "eiffel.y"
		local
			yyval90: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp90 := yyvsp90 + 1
	if yyvsp90 >= yyvsc90 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs90")
		end
		yyvsc90 := yyvsc90 + yyInitial_yyvs_size
		yyvs90 := yyspecial_routines90.aliased_resized_area (yyvs90, yyvsc90)
	end
	yyspecial_routines90.force (yyvs90, yyval90, yyvsp90)
end
		end

	yy_do_action_393
			--|#line <not available> "eiffel.y"
		local
			yyval90: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval90 := yyvs90.item (yyvsp90) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines90.force (yyvs90, yyval90, yyvsp90)
end
		end

	yy_do_action_394
			--|#line <not available> "eiffel.y"
		local
			yyval90: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval90 := ast_factory.new_variant_as (yyvs2.item (yyvsp2), yyvs48.item (yyvsp48), yyvs14.item (yyvsp14), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp90 := yyvsp90 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp90 >= yyvsc90 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs90")
		end
		yyvsc90 := yyvsc90 + yyInitial_yyvs_size
		yyvs90 := yyspecial_routines90.aliased_resized_area (yyvs90, yyvsc90)
	end
	yyspecial_routines90.force (yyvs90, yyval90, yyvsp90)
end
		end

	yy_do_action_395
			--|#line <not available> "eiffel.y"
		local
			yyval90: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval90 := ast_factory.new_variant_as (Void, yyvs48.item (yyvsp48), yyvs14.item (yyvsp14), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp90 := yyvsp90 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp90 >= yyvsc90 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs90")
		end
		yyvsc90 := yyvsc90 + yyInitial_yyvs_size
		yyvs90 := yyspecial_routines90.aliased_resized_area (yyvs90, yyvsc90)
	end
	yyspecial_routines90.force (yyvs90, yyval90, yyvsp90)
end
		end

	yy_do_action_396
			--|#line <not available> "eiffel.y"
		local
			yyval43: detachable DEBUG_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval43 := ast_factory.new_debug_as (yyvs123.item (yyvsp123), yyvs115.item (yyvsp115), yyvs14.item (yyvsp14 - 1), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp43 := yyvsp43 + 1
	yyvsp14 := yyvsp14 -2
	yyvsp123 := yyvsp123 -1
	yyvsp115 := yyvsp115 -1
	if yyvsp43 >= yyvsc43 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs43")
		end
		yyvsc43 := yyvsc43 + yyInitial_yyvs_size
		yyvs43 := yyspecial_routines43.aliased_resized_area (yyvs43, yyvsc43)
	end
	yyspecial_routines43.force (yyvs43, yyval43, yyvsp43)
end
		end

	yy_do_action_397
			--|#line <not available> "eiffel.y"
		local
			yyval123: detachable KEY_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp123 := yyvsp123 + 1
	if yyvsp123 >= yyvsc123 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs123")
		end
		yyvsc123 := yyvsc123 + yyInitial_yyvs_size
		yyvs123 := yyspecial_routines123.aliased_resized_area (yyvs123, yyvsc123)
	end
	yyspecial_routines123.force (yyvs123, yyval123, yyvsp123)
end
		end

	yy_do_action_398
			--|#line <not available> "eiffel.y"
		local
			yyval123: detachable KEY_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)), filename,
						once "Empty key list is not allowed"))
				end
				yyval123 := ast_factory.new_key_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp123 := yyvsp123 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp123 >= yyvsc123 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs123")
		end
		yyvsc123 := yyvsc123 + yyInitial_yyvs_size
		yyvs123 := yyspecial_routines123.aliased_resized_area (yyvs123, yyvsc123)
	end
	yyspecial_routines123.force (yyvs123, yyval123, yyvsp123)
end
		end

	yy_do_action_399
			--|#line <not available> "eiffel.y"
		local
			yyval123: detachable KEY_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval123 := ast_factory.new_key_list_as (yyvs122.item (yyvsp122), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp123 := yyvsp123 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp122 := yyvsp122 -1
	if yyvsp123 >= yyvsc123 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs123")
		end
		yyvsc123 := yyvsc123 + yyInitial_yyvs_size
		yyvs123 := yyspecial_routines123.aliased_resized_area (yyvs123, yyvsc123)
	end
	yyspecial_routines123.force (yyvs123, yyval123, yyvsp123)
end
		end

	yy_do_action_400
			--|#line <not available> "eiffel.y"
		local
			yyval122: detachable EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval122 := ast_factory.new_eiffel_list_string_as (counter_value + 1)
				if attached yyval122 as l_list and then attached yyvs16.item (yyvsp16) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp122 := yyvsp122 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp122 >= yyvsc122 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs122")
		end
		yyvsc122 := yyvsc122 + yyInitial_yyvs_size
		yyvs122 := yyspecial_routines122.aliased_resized_area (yyvs122, yyvsc122)
	end
	yyspecial_routines122.force (yyvs122, yyval122, yyvsp122)
end
		end

	yy_do_action_401
			--|#line <not available> "eiffel.y"
		local
			yyval122: detachable EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval122 := yyvs122.item (yyvsp122)
				if attached yyval122 as l_list and then attached yyvs16.item (yyvsp16) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp16 := yyvsp16 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines122.force (yyvs122, yyval122, yyvsp122)
end
		end

	yy_do_action_402
			--|#line <not available> "eiffel.y"
		local
			yyval18: detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp18 := yyvsp18 + 1
	if yyvsp18 >= yyvsc18 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs18")
		end
		yyvsc18 := yyvsc18 + yyInitial_yyvs_size
		yyvs18 := yyspecial_routines18.aliased_resized_area (yyvs18, yyvsc18)
	end
	yyspecial_routines18.force (yyvs18, yyval18, yyvsp18)
end
		end

	yy_do_action_403
			--|#line <not available> "eiffel.y"
		local
			yyval18: detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs115.item (yyvsp115) = Void then
					yyval18 := ast_factory.new_keyword_instruction_list_pair (yyvs14.item (yyvsp14), ast_factory.new_eiffel_list_instruction_as (0))
				else
					yyval18 := ast_factory.new_keyword_instruction_list_pair (yyvs14.item (yyvsp14), yyvs115.item (yyvsp115))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp18 := yyvsp18 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp115 := yyvsp115 -1
	if yyvsp18 >= yyvsc18 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs18")
		end
		yyvsc18 := yyvsc18 + yyInitial_yyvs_size
		yyvs18 := yyspecial_routines18.aliased_resized_area (yyvs18, yyvsc18)
	end
	yyspecial_routines18.force (yyvs18, yyval18, yyvsp18)
end
		end

	yy_do_action_404
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable ASSIGN_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_assign_as (ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp29 >= yyvsc29 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs29")
		end
		yyvsc29 := yyvsc29 + yyInitial_yyvs_size
		yyvs29 := yyspecial_routines29.aliased_resized_area (yyvs29, yyvsc29)
	end
	yyspecial_routines29.force (yyvs29, yyval29, yyvsp29)
end
		end

	yy_do_action_405
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable ASSIGN_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_assign_as (yyvs8.item (yyvsp8), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp8 := yyvsp8 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp29 >= yyvsc29 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs29")
		end
		yyvsc29 := yyvsc29 + yyInitial_yyvs_size
		yyvs29 := yyspecial_routines29.aliased_resized_area (yyvs29, yyvsc29)
	end
	yyspecial_routines29.force (yyvs29, yyval29, yyvsp29)
end
		end

	yy_do_action_406
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable REVERSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval78 := ast_factory.new_reverse_as (ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp78 >= yyvsc78 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs78")
		end
		yyvsc78 := yyvsc78 + yyInitial_yyvs_size
		yyvs78 := yyspecial_routines78.aliased_resized_area (yyvs78, yyvsc78)
	end
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_407
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable REVERSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval78 := ast_factory.new_reverse_as (yyvs8.item (yyvsp8), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 + 1
	yyvsp8 := yyvsp8 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp78 >= yyvsc78 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs78")
		end
		yyvsc78 := yyvsc78 + yyInitial_yyvs_size
		yyvs78 := yyspecial_routines78.aliased_resized_area (yyvs78, yyvsc78)
	end
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_408
			--|#line <not available> "eiffel.y"
		local
			yyval95: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp95 := yyvsp95 + 1
	if yyvsp95 >= yyvsc95 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs95")
		end
		yyvsc95 := yyvsc95 + yyInitial_yyvs_size
		yyvs95 := yyspecial_routines95.aliased_resized_area (yyvs95, yyvsc95)
	end
	yyspecial_routines95.force (yyvs95, yyval95, yyvsp95)
end
		end

	yy_do_action_409
			--|#line <not available> "eiffel.y"
		local
			yyval95: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval95 := yyvs95.item (yyvsp95) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines95.force (yyvs95, yyval95, yyvsp95)
end
		end

	yy_do_action_410
			--|#line <not available> "eiffel.y"
		local
			yyval95: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval95 := ast_factory.new_eiffel_list_create_as (counter_value + 1)
				if attached yyval95 as l_list and then attached yyvs40.item (yyvsp40) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp95 := yyvsp95 + 1
	yyvsp40 := yyvsp40 -1
	if yyvsp95 >= yyvsc95 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs95")
		end
		yyvsc95 := yyvsc95 + yyInitial_yyvs_size
		yyvs95 := yyspecial_routines95.aliased_resized_area (yyvs95, yyvsc95)
	end
	yyspecial_routines95.force (yyvs95, yyval95, yyvsp95)
end
		end

	yy_do_action_411
			--|#line <not available> "eiffel.y"
		local
			yyval95: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval95 := yyvs95.item (yyvsp95)
				if attached yyval95 as l_list and then attached yyvs40.item (yyvsp40) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp40 := yyvsp40 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines95.force (yyvs95, yyval95, yyvsp95)
end
		end

	yy_do_action_412
			--|#line <not available> "eiffel.y"
		local
			yyval40: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval40 := ast_factory.new_create_as (Void, Void, yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp40 >= yyvsc40 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs40")
		end
		yyvsc40 := yyvsc40 + yyInitial_yyvs_size
		yyvs40 := yyspecial_routines40.aliased_resized_area (yyvs40, yyvsc40)
	end
	yyspecial_routines40.force (yyvs40, yyval40, yyvsp40)
end
		end

	yy_do_action_413
			--|#line <not available> "eiffel.y"
		local
			yyval40: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval40 := ast_factory.new_create_as (yyvs37.item (yyvsp37), yyvs104.item (yyvsp104), yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp40 := yyvsp40 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp37 := yyvsp37 -1
	yyvsp104 := yyvsp104 -1
	if yyvsp40 >= yyvsc40 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs40")
		end
		yyvsc40 := yyvsc40 + yyInitial_yyvs_size
		yyvs40 := yyspecial_routines40.aliased_resized_area (yyvs40, yyvsc40)
	end
	yyspecial_routines40.force (yyvs40, yyval40, yyvsp40)
end
		end

	yy_do_action_414
			--|#line <not available> "eiffel.y"
		local
			yyval40: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval40 := ast_factory.new_create_as (ast_factory.new_client_as (yyvs112.item (yyvsp112)), Void, yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp40 := yyvsp40 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp112 := yyvsp112 -1
	if yyvsp40 >= yyvsc40 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs40")
		end
		yyvsc40 := yyvsc40 + yyInitial_yyvs_size
		yyvs40 := yyspecial_routines40.aliased_resized_area (yyvs40, yyvsc40)
	end
	yyspecial_routines40.force (yyvs40, yyval40, yyvsp40)
end
		end

	yy_do_action_415
			--|#line <not available> "eiffel.y"
		local
			yyval40: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval40 := ast_factory.new_create_as (Void, Void, yyvs14.item (yyvsp14))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp40 >= yyvsc40 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs40")
		end
		yyvsc40 := yyvsc40 + yyInitial_yyvs_size
		yyvs40 := yyspecial_routines40.aliased_resized_area (yyvs40, yyvsc40)
	end
	yyspecial_routines40.force (yyvs40, yyval40, yyvsp40)
end
		end

	yy_do_action_416
			--|#line <not available> "eiffel.y"
		local
			yyval40: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval40 := ast_factory.new_create_as (yyvs37.item (yyvsp37), yyvs104.item (yyvsp104), yyvs14.item (yyvsp14))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp40 := yyvsp40 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp37 := yyvsp37 -1
	yyvsp104 := yyvsp104 -1
	if yyvsp40 >= yyvsc40 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs40")
		end
		yyvsc40 := yyvsc40 + yyInitial_yyvs_size
		yyvs40 := yyspecial_routines40.aliased_resized_area (yyvs40, yyvsc40)
	end
	yyspecial_routines40.force (yyvs40, yyval40, yyvsp40)
end
		end

	yy_do_action_417
			--|#line <not available> "eiffel.y"
		local
			yyval40: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval40 := ast_factory.new_create_as (ast_factory.new_client_as (yyvs112.item (yyvsp112)), Void, yyvs14.item (yyvsp14))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp40 := yyvsp40 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp112 := yyvsp112 -1
	if yyvsp40 >= yyvsc40 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs40")
		end
		yyvsc40 := yyvsc40 + yyInitial_yyvs_size
		yyvs40 := yyspecial_routines40.aliased_resized_area (yyvs40, yyvsc40)
	end
	yyspecial_routines40.force (yyvs40, yyval40, yyvsp40)
end
		end

	yy_do_action_418
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			inspect id_level when Precondition_level, Postcondition_level then
				set_has_unqualified_call_in_assertion (True)
			else
				-- Nothing to do.
			end
			yyval81 := ast_factory.new_inline_agent_creation_as (
				ast_factory.new_body_as (yyvs129.item (yyvsp129), Void, Void, yyvs80.item (yyvsp80), Void, Void, Void, Void), yyvs118.item (yyvsp118), yyvs14.item (yyvsp14))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp81 := yyvsp81 -1
	yyvsp14 := yyvsp14 -1
	yyvsp129 := yyvsp129 -1
	yyvsp80 := yyvsp80 -1
	yyvsp118 := yyvsp118 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_419
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp81 := yyvsp81 + 1
	if yyvsp81 >= yyvsc81 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs81")
		end
		yyvsc81 := yyvsc81 + yyInitial_yyvs_size
		yyvs81 := yyspecial_routines81.aliased_resized_area (yyvs81, yyvsc81)
	end
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_420
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp81 := yyvsp81 + 1
	if yyvsp81 >= yyvsc81 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs81")
		end
		yyvsc81 := yyvsc81 + yyInitial_yyvs_size
		yyvs81 := yyspecial_routines81.aliased_resized_area (yyvs81, yyvsc81)
	end
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_421
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			inspect id_level when Precondition_level, Postcondition_level then
				set_has_unqualified_call_in_assertion (True)
			else
				-- Nothing to do.
			end
			yyval81 := ast_factory.new_inline_agent_creation_as (
				ast_factory.new_body_as (yyvs129.item (yyvsp129), yyvs85.item (yyvsp85), Void, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), Void, Void, Void), yyvs118.item (yyvsp118), yyvs14.item (yyvsp14))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp81 := yyvsp81 -1
	yyvsp14 := yyvsp14 -1
	yyvsp129 := yyvsp129 -1
	yyvsp4 := yyvsp4 -1
	yyvsp85 := yyvsp85 -1
	yyvsp80 := yyvsp80 -1
	yyvsp118 := yyvsp118 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_422
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp81 := yyvsp81 + 1
	if yyvsp81 >= yyvsc81 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs81")
		end
		yyvsc81 := yyvsc81 + yyInitial_yyvs_size
		yyvs81 := yyspecial_routines81.aliased_resized_area (yyvs81, yyvsc81)
	end
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_423
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp81 := yyvsp81 + 1
	if yyvsp81 >= yyvsc81 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs81")
		end
		yyvsc81 := yyvsc81 + yyInitial_yyvs_size
		yyvs81 := yyspecial_routines81.aliased_resized_area (yyvs81, yyvsc81)
	end
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_424
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			inspect id_level when Precondition_level, Postcondition_level then
				set_has_unqualified_call_in_assertion (True)
			else
				-- Nothing to do.
			end
			yyval81 := ast_factory.new_agent_routine_creation_as (
				Void, yyvs2.item (yyvsp2), yyvs118.item (yyvsp118), False, yyvs14.item (yyvsp14), Void)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp81 := yyvsp81 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	yyvsp118 := yyvsp118 -1
	if yyvsp81 >= yyvsc81 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs81")
		end
		yyvsc81 := yyvsc81 + yyInitial_yyvs_size
		yyvs81 := yyspecial_routines81.aliased_resized_area (yyvs81, yyvsc81)
	end
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_425
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if attached yyvs24.item (yyvsp24) as l_target then
				yyval81 := ast_factory.new_agent_routine_creation_as (l_target.operand, yyvs2.item (yyvsp2), yyvs118.item (yyvsp118), True, yyvs14.item (yyvsp14), yyvs4.item (yyvsp4))
				if attached yyval81 as l_agent then
					l_agent.set_lparan_symbol (l_target.lparan_symbol)
					l_agent.set_rparan_symbol (l_target.rparan_symbol)
				end
			else
				yyval81 := ast_factory.new_agent_routine_creation_as (Void, yyvs2.item (yyvsp2), yyvs118.item (yyvsp118), True, yyvs14.item (yyvsp14), yyvs4.item (yyvsp4))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp81 := yyvsp81 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp24 := yyvsp24 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp118 := yyvsp118 -1
	if yyvsp81 >= yyvsc81 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs81")
		end
		yyvsc81 := yyvsc81 + yyInitial_yyvs_size
		yyvs81 := yyspecial_routines81.aliased_resized_area (yyvs81, yyvsc81)
	end
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_426
			--|#line <not available> "eiffel.y"
		local
			yyval129: detachable FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp129 := yyvsp129 + 1
	if yyvsp129 >= yyvsc129 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs129")
		end
		yyvsc129 := yyvsc129 + yyInitial_yyvs_size
		yyvs129 := yyspecial_routines129.aliased_resized_area (yyvs129, yyvsc129)
	end
	yyspecial_routines129.force (yyvs129, yyval129, yyvsp129)
end
		end

	yy_do_action_427
			--|#line <not available> "eiffel.y"
		local
			yyval129: detachable FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval129 := yyvs129.item (yyvsp129)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines129.force (yyvs129, yyval129, yyvsp129)
end
		end

	yy_do_action_428
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			inspect id_level when Precondition_level, Postcondition_level then
				set_has_unqualified_call_in_assertion (True)
			else
				-- Nothing to do.
			end
			yyval24 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), Void))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp24 := yyvsp24 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp24 >= yyvsc24 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs24")
		end
		yyvsc24 := yyvsc24 + yyInitial_yyvs_size
		yyvs24 := yyspecial_routines24.aliased_resized_area (yyvs24, yyvsc24)
	end
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_429
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_agent_target_triple (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), ast_factory.new_operand_as (Void, Void, yyvs48.item (yyvsp48))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp24 := yyvsp24 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -4
	yyvsp48 := yyvsp48 -1
	if yyvsp24 >= yyvsc24 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs24")
		end
		yyvsc24 := yyvsc24 + yyInitial_yyvs_size
		yyvs24 := yyspecial_routines24.aliased_resized_area (yyvs24, yyvsc24)
	end
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_430
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, yyvs8.item (yyvsp8), Void)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp24 := yyvsp24 + 1
	yyvsp8 := yyvsp8 -1
	if yyvsp24 >= yyvsc24 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs24")
		end
		yyvsc24 := yyvsc24 + yyInitial_yyvs_size
		yyvs24 := yyspecial_routines24.aliased_resized_area (yyvs24, yyvsc24)
	end
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_431
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			inspect id_level when Precondition_level, Postcondition_level then
				set_has_unqualified_call_in_assertion (True)
			else
				-- Nothing to do.
			end
			yyval24 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, yyvs11.item (yyvsp11), Void))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp24 := yyvsp24 + 1
	yyvsp11 := yyvsp11 -1
	if yyvsp24 >= yyvsc24 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs24")
		end
		yyvsc24 := yyvsc24 + yyInitial_yyvs_size
		yyvs24 := yyspecial_routines24.aliased_resized_area (yyvs24, yyvsc24)
	end
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_432
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (yyvs85.item (yyvsp85), Void, Void))
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp24 := yyvsp24 + 1
	yyvsp85 := yyvsp85 -1
	if yyvsp24 >= yyvsc24 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs24")
		end
		yyvsc24 := yyvsc24 + yyInitial_yyvs_size
		yyvs24 := yyspecial_routines24.aliased_resized_area (yyvs24, yyvsc24)
	end
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_433
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if attached ast_factory.new_operand_as (Void, Void, Void) as l_temp_operand_as then
				l_temp_operand_as.set_question_mark_symbol (yyvs4.item (yyvsp4))
				yyval24 := ast_factory.new_agent_target_triple (Void, Void, l_temp_operand_as)
			else
				yyval24 := ast_factory.new_agent_target_triple (Void, Void, Void)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp24 := yyvsp24 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp24 >= yyvsc24 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs24")
		end
		yyvsc24 := yyvsc24 + yyInitial_yyvs_size
		yyvs24 := yyspecial_routines24.aliased_resized_area (yyvs24, yyvsc24)
	end
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_434
			--|#line <not available> "eiffel.y"
		local
			yyval118: detachable DELAYED_ACTUAL_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp118 := yyvsp118 + 1
	if yyvsp118 >= yyvsc118 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs118")
		end
		yyvsc118 := yyvsc118 + yyInitial_yyvs_size
		yyvs118 := yyspecial_routines118.aliased_resized_area (yyvs118, yyvsc118)
	end
	yyspecial_routines118.force (yyvs118, yyval118, yyvsp118)
end
		end

	yy_do_action_435
			--|#line <not available> "eiffel.y"
		local
			yyval118: detachable DELAYED_ACTUAL_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)), filename,
						once "Empty agent actual list is not allowed"))
				end
				yyval118 := ast_factory.new_delayed_actual_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp118 := yyvsp118 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp118 >= yyvsc118 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs118")
		end
		yyvsc118 := yyvsc118 + yyInitial_yyvs_size
		yyvs118 := yyspecial_routines118.aliased_resized_area (yyvs118, yyvsc118)
	end
	yyspecial_routines118.force (yyvs118, yyval118, yyvsp118)
end
		end

	yy_do_action_436
			--|#line <not available> "eiffel.y"
		local
			yyval118: detachable DELAYED_ACTUAL_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval118 := ast_factory.new_delayed_actual_list_as (yyvs117.item (yyvsp117), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp118 := yyvsp118 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp117 := yyvsp117 -1
	if yyvsp118 >= yyvsc118 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs118")
		end
		yyvsc118 := yyvsc118 + yyInitial_yyvs_size
		yyvs118 := yyspecial_routines118.aliased_resized_area (yyvs118, yyvsc118)
	end
	yyspecial_routines118.force (yyvs118, yyval118, yyvsp118)
end
		end

	yy_do_action_437
			--|#line <not available> "eiffel.y"
		local
			yyval117: detachable EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval117 := ast_factory.new_eiffel_list_operand_as (counter_value + 1)
				if attached yyval117 as l_list and then attached yyvs71.item (yyvsp71) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp117 := yyvsp117 + 1
	yyvsp71 := yyvsp71 -1
	if yyvsp117 >= yyvsc117 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs117")
		end
		yyvsc117 := yyvsc117 + yyInitial_yyvs_size
		yyvs117 := yyspecial_routines117.aliased_resized_area (yyvs117, yyvsc117)
	end
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_438
			--|#line <not available> "eiffel.y"
		local
			yyval117: detachable EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval117 := yyvs117.item (yyvsp117)
				if attached yyval117 as l_list and then attached yyvs71.item (yyvsp71) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_439
			--|#line <not available> "eiffel.y"
		local
			yyval71: detachable OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_operand_as (Void, Void, Void)
				if attached yyval71 as l_actual then
					l_actual.set_question_mark_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp71 := yyvsp71 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp71 >= yyvsc71 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs71")
		end
		yyvsc71 := yyvsc71 + yyInitial_yyvs_size
		yyvs71 := yyspecial_routines71.aliased_resized_area (yyvs71, yyvsc71)
	end
	yyspecial_routines71.force (yyvs71, yyval71, yyvsp71)
end
		end

	yy_do_action_440
			--|#line <not available> "eiffel.y"
		local
			yyval71: detachable OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_operand_as (yyvs85.item (yyvsp85), Void, Void)
				if attached yyval71 as l_actual then
					l_actual.set_question_mark_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp71 := yyvsp71 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp71 >= yyvsc71 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs71")
		end
		yyvsc71 := yyvsc71 + yyInitial_yyvs_size
		yyvs71 := yyspecial_routines71.aliased_resized_area (yyvs71, yyvsc71)
	end
	yyspecial_routines71.force (yyvs71, yyval71, yyvsp71)
end
		end

	yy_do_action_441
			--|#line <not available> "eiffel.y"
		local
			yyval71: detachable OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_operand_as (Void, Void, yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp71 := yyvsp71 + 1
	yyvsp48 := yyvsp48 -1
	if yyvsp71 >= yyvsc71 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs71")
		end
		yyvsc71 := yyvsc71 + yyInitial_yyvs_size
		yyvs71 := yyspecial_routines71.aliased_resized_area (yyvs71, yyvsc71)
	end
	yyspecial_routines71.force (yyvs71, yyval71, yyvsp71)
end
		end

	yy_do_action_442
			--|#line <not available> "eiffel.y"
		local
			yyval41: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval41 := ast_factory.new_bang_creation_as (Void, yyvs25.item (yyvsp25), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp41 := yyvsp41 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp25 := yyvsp25 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp41 >= yyvsc41 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs41")
		end
		yyvsc41 := yyvsc41 + yyInitial_yyvs_size
		yyvs41 := yyspecial_routines41.aliased_resized_area (yyvs41, yyvsc41)
	end
	yyspecial_routines41.force (yyvs41, yyval41, yyvsp41)
end
		end

	yy_do_action_443
			--|#line <not available> "eiffel.y"
		local
			yyval41: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval41 := ast_factory.new_bang_creation_as (yyvs85.item (yyvsp85), yyvs25.item (yyvsp25), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp41 := yyvsp41 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp85 := yyvsp85 -1
	yyvsp25 := yyvsp25 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp41 >= yyvsc41 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs41")
		end
		yyvsc41 := yyvsc41 + yyInitial_yyvs_size
		yyvs41 := yyspecial_routines41.aliased_resized_area (yyvs41, yyvsc41)
	end
	yyspecial_routines41.force (yyvs41, yyval41, yyvsp41)
end
		end

	yy_do_action_444
			--|#line <not available> "eiffel.y"
		local
			yyval41: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval41 := ast_factory.new_create_creation_as (yyvs33.item (yyvsp33), Void, yyvs25.item (yyvsp25), yyvs27.item (yyvsp27), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp41 := yyvsp41 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp33 := yyvsp33 -1
	yyvsp25 := yyvsp25 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp41 >= yyvsc41 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs41")
		end
		yyvsc41 := yyvsc41 + yyInitial_yyvs_size
		yyvs41 := yyspecial_routines41.aliased_resized_area (yyvs41, yyvsc41)
	end
	yyspecial_routines41.force (yyvs41, yyval41, yyvsp41)
end
		end

	yy_do_action_445
			--|#line <not available> "eiffel.y"
		local
			yyval41: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval41 := ast_factory.new_create_creation_as (yyvs33.item (yyvsp33), yyvs85.item (yyvsp85), yyvs25.item (yyvsp25), yyvs27.item (yyvsp27), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp41 := yyvsp41 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp33 := yyvsp33 -1
	yyvsp85 := yyvsp85 -1
	yyvsp25 := yyvsp25 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp41 >= yyvsc41 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs41")
		end
		yyvsc41 := yyvsc41 + yyInitial_yyvs_size
		yyvs41 := yyspecial_routines41.aliased_resized_area (yyvs41, yyvsc41)
	end
	yyspecial_routines41.force (yyvs41, yyval41, yyvsp41)
end
		end

	yy_do_action_446
			--|#line <not available> "eiffel.y"
		local
			yyval42: detachable CREATION_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval42 := ast_factory.new_create_creation_expr_as (yyvs33.item (yyvsp33), yyvs85.item (yyvsp85), yyvs27.item (yyvsp27), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp42 := yyvsp42 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp33 := yyvsp33 -1
	yyvsp85 := yyvsp85 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp42 >= yyvsc42 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs42")
		end
		yyvsc42 := yyvsc42 + yyInitial_yyvs_size
		yyvs42 := yyspecial_routines42.aliased_resized_area (yyvs42, yyvsc42)
	end
	yyspecial_routines42.force (yyvs42, yyval42, yyvsp42)
end
		end

	yy_do_action_447
			--|#line <not available> "eiffel.y"
		local
			yyval42: detachable CREATION_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval42 := ast_factory.new_bang_creation_expr_as (yyvs85.item (yyvsp85), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp42 := yyvsp42 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp85 := yyvsp85 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp42 >= yyvsc42 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs42")
		end
		yyvsc42 := yyvsc42 + yyInitial_yyvs_size
		yyvs42 := yyspecial_routines42.aliased_resized_area (yyvs42, yyvsc42)
	end
	yyspecial_routines42.force (yyvs42, yyval42, yyvsp42)
end
		end

	yy_do_action_448
			--|#line <not available> "eiffel.y"
		local
			yyval33: BOOLEAN
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval33 := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp33 := yyvsp33 + 1
	if yyvsp33 >= yyvsc33 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs33")
		end
		yyvsc33 := yyvsc33 + yyInitial_yyvs_size
		yyvs33 := yyspecial_routines33.aliased_resized_area (yyvs33, yyvsc33)
	end
	yyspecial_routines33.force (yyvs33, yyval33, yyvsp33)
end
		end

	yy_do_action_449
			--|#line <not available> "eiffel.y"
		local
			yyval33: BOOLEAN
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval33 := True
				if attached yyvs2.item (yyvsp2) as l_id then
					if {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						yyval33 := False
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs2.item (yyvsp2)), token_column (yyvs2.item (yyvsp2)), filename, "Passive regions should use type specifier %"NONE%"."))
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp33 := yyvsp33 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp2 := yyvsp2 -1
	if yyvsp33 >= yyvsc33 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs33")
		end
		yyvsc33 := yyvsc33 + yyInitial_yyvs_size
		yyvs33 := yyspecial_routines33.aliased_resized_area (yyvs33, yyvsc33)
	end
	yyspecial_routines33.force (yyvs33, yyval33, yyvsp33)
end
		end

	yy_do_action_450
			--|#line <not available> "eiffel.y"
		local
			yyval25: detachable ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval25 := ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp25 := yyvsp25 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp25 >= yyvsc25 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs25")
		end
		yyvsc25 := yyvsc25 + yyInitial_yyvs_size
		yyvs25 := yyspecial_routines25.aliased_resized_area (yyvs25, yyvsc25)
	end
	yyspecial_routines25.force (yyvs25, yyval25, yyvsp25)
end
		end

	yy_do_action_451
			--|#line <not available> "eiffel.y"
		local
			yyval25: detachable ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval25 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp25 := yyvsp25 + 1
	yyvsp8 := yyvsp8 -1
	if yyvsp25 >= yyvsc25 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs25")
		end
		yyvsc25 := yyvsc25 + yyInitial_yyvs_size
		yyvs25 := yyspecial_routines25.aliased_resized_area (yyvs25, yyvsc25)
	end
	yyspecial_routines25.force (yyvs25, yyval25, yyvsp25)
end
		end

	yy_do_action_452
			--|#line <not available> "eiffel.y"
		local
			yyval27: detachable ACCESS_INV_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp27 := yyvsp27 + 1
	if yyvsp27 >= yyvsc27 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs27")
		end
		yyvsc27 := yyvsc27 + yyInitial_yyvs_size
		yyvs27 := yyspecial_routines27.aliased_resized_area (yyvs27, yyvsc27)
	end
	yyspecial_routines27.force (yyvs27, yyval27, yyvsp27)
end
		end

	yy_do_action_453
			--|#line <not available> "eiffel.y"
		local
			yyval27: detachable ACCESS_INV_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_access_inv_as (yyvs2.item (yyvsp2), yyvs101.item (yyvsp101), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp27 := yyvsp27 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp101 := yyvsp101 -1
	if yyvsp27 >= yyvsc27 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs27")
		end
		yyvsc27 := yyvsc27 + yyInitial_yyvs_size
		yyvs27 := yyspecial_routines27.aliased_resized_area (yyvs27, yyvsc27)
	end
	yyspecial_routines27.force (yyvs27, yyval27, yyvsp27)
end
		end

	yy_do_action_454
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := yyvs25.item (yyvsp25) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp34 := yyvsp34 + 1
	yyvsp25 := yyvsp25 -1
	if yyvsp34 >= yyvsc34 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs34")
		end
		yyvsc34 := yyvsc34 + yyInitial_yyvs_size
		yyvs34 := yyspecial_routines34.aliased_resized_area (yyvs34, yyvsc34)
	end
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_455
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := yyvs73.item (yyvsp73) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp34 := yyvsp34 + 1
	yyvsp73 := yyvsp73 -1
	if yyvsp34 >= yyvsc34 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs34")
		end
		yyvsc34 := yyvsc34 + yyInitial_yyvs_size
		yyvs34 := yyspecial_routines34.aliased_resized_area (yyvs34, yyvsc34)
	end
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_456
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := yyvs74.item (yyvsp74) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp34 := yyvsp34 + 1
	yyvsp74 := yyvsp74 -1
	if yyvsp34 >= yyvsc34 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs34")
		end
		yyvsc34 := yyvsc34 + yyInitial_yyvs_size
		yyvs34 := yyspecial_routines34.aliased_resized_area (yyvs34, yyvsc34)
	end
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_457
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := yyvs34.item (yyvsp34) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_458
			--|#line <not available> "eiffel.y"
		local
			yyval36: detachable CHECK_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := ast_factory.new_check_as (yyvs124.item (yyvsp124), yyvs14.item (yyvsp14 - 1), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp36 := yyvsp36 + 1
	yyvsp14 := yyvsp14 -2
	yyvsp124 := yyvsp124 -1
	if yyvsp36 >= yyvsc36 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs36")
		end
		yyvsc36 := yyvsc36 + yyInitial_yyvs_size
		yyvs36 := yyspecial_routines36.aliased_resized_area (yyvs36, yyvsc36)
	end
	yyspecial_routines36.force (yyvs36, yyval36, yyvsp36)
end
		end

	yy_do_action_459
			--|#line <not available> "eiffel.y"
		local
			yyval57: detachable GUARD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := ast_factory.new_guard_as (yyvs14.item (yyvsp14 - 2), yyvs124.item (yyvsp124), yyvs14.item (yyvsp14 - 1), yyvs115.item (yyvsp115), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp57 := yyvsp57 + 1
	yyvsp14 := yyvsp14 -3
	yyvsp124 := yyvsp124 -1
	yyvsp115 := yyvsp115 -1
	if yyvsp57 >= yyvsc57 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs57")
		end
		yyvsc57 := yyvsc57 + yyInitial_yyvs_size
		yyvs57 := yyspecial_routines57.aliased_resized_area (yyvs57, yyvsc57)
	end
	yyspecial_routines57.force (yyvs57, yyval57, yyvsp57)
end
		end

	yy_do_action_460
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable SEPARATE_INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := ast_factory.new_separate_instruction_as (yyvs14.item (yyvsp14 - 2), yyvs106.item (yyvsp106), yyvs14.item (yyvsp14 - 1), yyvs115.item (yyvsp115), yyvs14.item (yyvsp14))
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp14 := yyvsp14 -3
	yyvsp1 := yyvsp1 -2
	yyvsp106 := yyvsp106 -1
	yyvsp115 := yyvsp115 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_461
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable SEPARATE_INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

enter_scope
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp82 := yyvsp82 + 1
	if yyvsp82 >= yyvsc82 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs82")
		end
		yyvsc82 := yyvsc82 + yyInitial_yyvs_size
		yyvs82 := yyspecial_routines82.aliased_resized_area (yyvs82, yyvsc82)
	end
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_462
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable NAMED_EXPRESSION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval69 := ast_factory.new_named_expression_as (yyvs48.item (yyvsp48), yyvs14.item (yyvsp14), yyvs2.item (yyvsp2))
				add_scope_separate (yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp69 := yyvsp69 + 1
	yyvsp48 := yyvsp48 -1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp69 >= yyvsc69 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs69")
		end
		yyvsc69 := yyvsc69 + yyInitial_yyvs_size
		yyvs69 := yyspecial_routines69.aliased_resized_area (yyvs69, yyvsc69)
	end
	yyspecial_routines69.force (yyvs69, yyval69, yyvsp69)
end
		end

	yy_do_action_463
			--|#line <not available> "eiffel.y"
		local
			yyval106: detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval106 := ast_factory.new_eiffel_list_named_expression_as (counter_value + 1)
				if attached yyval106 as l_list and then attached yyvs69.item (yyvsp69) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp106 := yyvsp106 + 1
	yyvsp69 := yyvsp69 -1
	if yyvsp106 >= yyvsc106 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs106")
		end
		yyvsc106 := yyvsc106 + yyInitial_yyvs_size
		yyvs106 := yyspecial_routines106.aliased_resized_area (yyvs106, yyvsc106)
	end
	yyspecial_routines106.force (yyvs106, yyval106, yyvsp106)
end
		end

	yy_do_action_464
			--|#line <not available> "eiffel.y"
		local
			yyval106: detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval106 := yyvs106.item (yyvsp106)
				if attached yyval106 as l_list and then attached yyvs69.item (yyvsp69) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp69 := yyvsp69 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines106.force (yyvs106, yyval106, yyvsp106)
end
		end

	yy_do_action_465
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85)
				if attached yyval85 as l_type then
					l_type.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_type.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_466
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp63 := yyvsp63 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_467
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp75 := yyvsp75 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_468
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_469
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_bin_tilde_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_470
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_bin_not_tilde_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_471
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_bin_eq_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_472
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_bin_ne_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_473
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs31.item (yyvsp31) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp31 := yyvsp31 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_474
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs48.item (yyvsp48))
				yyval48 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs48.item (yyvsp48), Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_475
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs48.item (yyvsp48))
				yyval48 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs48.item (yyvsp48), yyvs14.item (yyvsp14), yyvs2.item (yyvsp2))
				add_scope_test (yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp15 := yyvsp15 -1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_476
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs85.item (yyvsp85) as l_type then
					l_type.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_type.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
				check_object_test_expression (yyvs48.item (yyvsp48))
				yyval48 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs85.item (yyvsp85), yyvs48.item (yyvsp48), Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp15 := yyvsp15 -1
	yyvsp4 := yyvsp4 -2
	yyvsp85 := yyvsp85 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_477
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs85.item (yyvsp85) as l_type then
					l_type.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_type.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
				check_object_test_expression (yyvs48.item (yyvsp48))
				yyval48 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs85.item (yyvsp85), yyvs48.item (yyvsp48), yyvs14.item (yyvsp14), yyvs2.item (yyvsp2))
				if attached yyvs2.item (yyvsp2) as l_name and attached yyvs85.item (yyvsp85) as l_type then
					insert_object_test_locals ([l_name, l_type])
				end
				add_scope_test (yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp15 := yyvsp15 -1
	yyvsp4 := yyvsp4 -2
	yyvsp85 := yyvsp85 -1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_478
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs48.item (yyvsp48))
				yyval48 := ast_factory.new_old_syntax_object_test_as (yyvs4.item (yyvsp4 - 2), yyvs2.item (yyvsp2), yyvs85.item (yyvsp85), yyvs48.item (yyvsp48))
				if attached yyvs2.item (yyvsp2) as l_name and attached yyvs85.item (yyvsp85) as l_type then
					insert_object_test_locals ([l_name, l_type])
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 2)), token_column (yyvs4.item (yyvsp4 - 2)),
							filename, once "Use the new syntax for object test `attached {T} exp as x'."))

				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp4 := yyvsp4 -3
	yyvsp2 := yyvsp2 -1
	yyvsp85 := yyvsp85 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_479
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_plus_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_480
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_minus_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_481
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_star_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_482
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_slash_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_483
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_mod_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_484
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_div_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_485
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_power_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_486
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_and_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp14 := yyvsp14 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_487
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_and_then_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs14.item (yyvsp14 - 1), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp14 := yyvsp14 -2
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_488
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_or_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp14 := yyvsp14 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_489
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_or_else_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48),yyvs14.item (yyvsp14 - 1), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp14 := yyvsp14 -2
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_490
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_implies_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp14 := yyvsp14 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_491
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_xor_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp14 := yyvsp14 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_492
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_ge_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_493
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_gt_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_494
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_le_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_495
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_lt_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_496
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_free_as (yyvs48.item (yyvsp48 - 1), yyvs2.item (yyvsp2), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp2 := yyvsp2 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_497
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_free_as (yyvs48.item (yyvsp48 - 1), extract_id_from_symbol (yyvs6.item (yyvsp6)), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp6 := yyvsp6 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_498
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_free_as (yyvs48.item (yyvsp48 - 1), extract_id_from_symbol (yyvs6.item (yyvsp6)), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp6 := yyvsp6 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_499
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_bin_free_as (yyvs48.item (yyvsp48 - 1), extract_id_from_symbol (yyvs6.item (yyvsp6)), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp6 := yyvsp6 -1
	if yyvsp31 >= yyvsc31 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs31")
		end
		yyvsc31 := yyvsc31 + yyInitial_yyvs_size
		yyvs31 := yyspecial_routines31.aliased_resized_area (yyvs31, yyvsc31)
	end
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_500
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_501
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs28.item (yyvsp28) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp28 := yyvsp28 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_502
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp81 := yyvsp81 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_503
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_old_as (yyvs48.item (yyvsp48), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_504
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_strip_as (yyvs21.item (yyvsp21), yyvs14.item (yyvsp14), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp48 := yyvsp48 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp4 := yyvsp4 -2
	yyvsp21 := yyvsp21 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_505
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				yyval48 := ast_factory.new_address_as (yyvs91.item (yyvsp91), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp91 := yyvsp91 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_506
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				yyval48 := ast_factory.new_address_current_as (yyvs11.item (yyvsp11), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp11 := yyvsp11 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_507
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_address_result_as (yyvs8.item (yyvsp8), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp8 := yyvsp8 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_508
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_509
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_expr_call_as (yyvs34.item (yyvsp34)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp34 := yyvsp34 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_510
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_511
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs59.item (yyvsp59) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp59 := yyvsp59 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_512
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs49.item (yyvsp49) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp49 := yyvsp49 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_513
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs49.item (yyvsp49) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp49 := yyvsp49 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_514
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_minus_as (yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_515
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_plus_as (yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_516
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_not_as (yyvs48.item (yyvsp48), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_517
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_free_as (yyvs2.item (yyvsp2), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_518
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_free_as (extract_id_from_symbol (yyvs6.item (yyvsp6)), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp6 := yyvsp6 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_519
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_free_as (extract_id_from_symbol (yyvs6.item (yyvsp6)), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp6 := yyvsp6 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_520
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_free_as (extract_id_from_symbol (yyvs6.item (yyvsp6)), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp6 := yyvsp6 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_521
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_type_expr_as (yyvs85.item (yyvsp85)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp85 := yyvsp85 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_522
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp63 := yyvsp63 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_523
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp75 := yyvsp75 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_524
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_free then
					l_free.to_lower
				end
				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_525
			--|#line <not available> "eiffel.y"
		local
			yyval49: detachable BRACKET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_bracket_as (yyvs48.item (yyvsp48), yyvs100.item (yyvsp100), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp49 := yyvsp49 + 1
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp100 := yyvsp100 -1
	if yyvsp49 >= yyvsc49 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs49")
		end
		yyvsc49 := yyvsc49 + yyInitial_yyvs_size
		yyvs49 := yyspecial_routines49.aliased_resized_area (yyvs49, yyvsc49)
	end
	yyspecial_routines49.force (yyvs49, yyval49, yyvsp49)
end
		end

	yy_do_action_526
			--|#line <not available> "eiffel.y"
		local
			yyval49: detachable BRACKET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_bracket_as (yyvs49.item (yyvsp49), yyvs100.item (yyvsp100), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp100 := yyvsp100 -1
	yyspecial_routines49.force (yyvs49, yyval49, yyvsp49)
end
		end

	yy_do_action_527
			--|#line <not available> "eiffel.y"
		local
			yyval49: detachable BRACKET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_bracket_as (ast_factory.new_expr_call_as (yyvs34.item (yyvsp34)), yyvs100.item (yyvsp100), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp49 := yyvsp49 + 1
	yyvsp34 := yyvsp34 -1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp100 := yyvsp100 -1
	if yyvsp49 >= yyvsc49 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs49")
		end
		yyvsc49 := yyvsc49 + yyInitial_yyvs_size
		yyvs49 := yyspecial_routines49.aliased_resized_area (yyvs49, yyvsc49)
	end
	yyspecial_routines49.force (yyvs49, yyval49, yyvsp49)
end
		end

	yy_do_action_528
			--|#line <not available> "eiffel.y"
		local
			yyval49: detachable BRACKET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_bracket_as (yyvs49.item (yyvsp49), yyvs100.item (yyvsp100), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp100 := yyvsp100 -1
	yyspecial_routines49.force (yyvs49, yyval49, yyvsp49)
end
		end

	yy_do_action_529
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				yyval34 := ast_factory.new_nested_as (yyvs11.item (yyvsp11), yyvs34.item (yyvsp34), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp11 := yyvsp11 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_530
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := ast_factory.new_nested_as (yyvs8.item (yyvsp8), yyvs34.item (yyvsp34), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp8 := yyvsp8 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_531
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := ast_factory.new_nested_as (yyvs25.item (yyvsp25), yyvs34.item (yyvsp34), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp25 := yyvsp25 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_532
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := ast_factory.new_nested_expr_as (yyvs48.item (yyvsp48), yyvs34.item (yyvsp34), yyvs4.item (yyvsp4), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -3
	yyvsp48 := yyvsp48 -1
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_533
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := ast_factory.new_nested_expr_as (yyvs49.item (yyvsp49), yyvs34.item (yyvsp34), yyvs4.item (yyvsp4), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_534
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := ast_factory.new_nested_expr_as (yyvs49.item (yyvsp49), yyvs34.item (yyvsp34), yyvs4.item (yyvsp4), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_535
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := ast_factory.new_nested_as (yyvs73.item (yyvsp73), yyvs34.item (yyvsp34), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp73 := yyvsp73 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_536
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := ast_factory.new_nested_as (yyvs74.item (yyvsp74), yyvs34.item (yyvsp34), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp74 := yyvsp74 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_537
			--|#line <not available> "eiffel.y"
		local
			yyval73: detachable PRECURSOR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				yyval73 := ast_factory.new_precursor_as (yyvs14.item (yyvsp14), Void, yyvs101.item (yyvsp101))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp73 := yyvsp73 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp101 := yyvsp101 -1
	if yyvsp73 >= yyvsc73 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs73")
		end
		yyvsc73 := yyvsc73 + yyInitial_yyvs_size
		yyvs73 := yyspecial_routines73.aliased_resized_area (yyvs73, yyvsc73)
	end
	yyspecial_routines73.force (yyvs73, yyval73, yyvsp73)
end
		end

	yy_do_action_538
			--|#line <not available> "eiffel.y"
		local
			yyval73: detachable PRECURSOR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				if attached ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void) as l_temp_class_type_as then
					l_temp_class_type_as.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_temp_class_type_as.set_rcurly_symbol (yyvs4.item (yyvsp4))
					yyval73 := ast_factory.new_precursor_as (yyvs14.item (yyvsp14), l_temp_class_type_as, yyvs101.item (yyvsp101))
				else
					yyval73 := ast_factory.new_precursor_as (yyvs14.item (yyvsp14), Void, yyvs101.item (yyvsp101))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp73 := yyvsp73 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp4 := yyvsp4 -2
	yyvsp2 := yyvsp2 -1
	yyvsp101 := yyvsp101 -1
	if yyvsp73 >= yyvsc73 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs73")
		end
		yyvsc73 := yyvsc73 + yyInitial_yyvs_size
		yyvs73 := yyspecial_routines73.aliased_resized_area (yyvs73, yyvsc73)
	end
	yyspecial_routines73.force (yyvs73, yyval73, yyvsp73)
end
		end

	yy_do_action_539
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level
				when Precondition_level, Postcondition_level then
					set_has_non_object_call_in_assertion (True)
				else
					set_has_non_object_call (True)
				end
				yyval74 := yyvs74.item (yyvsp74)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines74.force (yyvs74, yyval74, yyvsp74)
end
		end

	yy_do_action_540
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level
				when Precondition_level, Postcondition_level then
					set_has_non_object_call_in_assertion (True)
				else
					set_has_non_object_call (True)
				end
				yyval74 := yyvs74.item (yyvsp74)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines74.force (yyvs74, yyval74, yyvsp74)
end
		end

	yy_do_action_541
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval74 := ast_factory.new_static_access_as (yyvs85.item (yyvsp85), yyvs2.item (yyvsp2), yyvs101.item (yyvsp101), Void, yyvs4.item (yyvsp4)); 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp74 := yyvsp74 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp101 := yyvsp101 -1
	if yyvsp74 >= yyvsc74 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs74")
		end
		yyvsc74 := yyvsc74 + yyInitial_yyvs_size
		yyvs74 := yyspecial_routines74.aliased_resized_area (yyvs74, yyvsc74)
	end
	yyspecial_routines74.force (yyvs74, yyval74, yyvsp74)
end
		end

	yy_do_action_542
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval74 := ast_factory.new_static_access_as (yyvs85.item (yyvsp85), yyvs2.item (yyvsp2), yyvs101.item (yyvsp101), yyvs14.item (yyvsp14), yyvs4.item (yyvsp4));
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs14.item (yyvsp14)), token_column (yyvs14.item (yyvsp14)),
							filename, once "Remove the `feature' keyword."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp74 := yyvsp74 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp101 := yyvsp101 -1
	if yyvsp74 >= yyvsc74 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs74")
		end
		yyvsc74 := yyvsc74 + yyInitial_yyvs_size
		yyvs74 := yyspecial_routines74.aliased_resized_area (yyvs74, yyvsc74)
	end
	yyspecial_routines74.force (yyvs74, yyval74, yyvsp74)
end
		end

	yy_do_action_543
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := yyvs70.item (yyvsp70) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp34 := yyvsp34 + 1
	yyvsp70 := yyvsp70 -1
	if yyvsp34 >= yyvsc34 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs34")
		end
		yyvsc34 := yyvsc34 + yyInitial_yyvs_size
		yyvs34 := yyspecial_routines34.aliased_resized_area (yyvs34, yyvsc34)
	end
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_544
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := yyvs26.item (yyvsp26) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp34 := yyvsp34 + 1
	yyvsp26 := yyvsp26 -1
	if yyvsp34 >= yyvsc34 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs34")
		end
		yyvsc34 := yyvsc34 + yyInitial_yyvs_size
		yyvs34 := yyspecial_routines34.aliased_resized_area (yyvs34, yyvsc34)
	end
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_545
			--|#line <not available> "eiffel.y"
		local
			yyval70: detachable NESTED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval70 := ast_factory.new_nested_as (yyvs26.item (yyvsp26 - 1), yyvs26.item (yyvsp26), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp70 := yyvsp70 + 1
	yyvsp26 := yyvsp26 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp70 >= yyvsc70 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs70")
		end
		yyvsc70 := yyvsc70 + yyInitial_yyvs_size
		yyvs70 := yyspecial_routines70.aliased_resized_area (yyvs70, yyvsc70)
	end
	yyspecial_routines70.force (yyvs70, yyval70, yyvsp70)
end
		end

	yy_do_action_546
			--|#line <not available> "eiffel.y"
		local
			yyval70: detachable NESTED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval70 := ast_factory.new_nested_as (yyvs26.item (yyvsp26), yyvs70.item (yyvsp70), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp26 := yyvsp26 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines70.force (yyvs70, yyval70, yyvsp70)
end
		end

	yy_do_action_547
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval2 := yyvs2.item (yyvsp2)
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_548
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs91.item (yyvsp91) as l_infix then
					yyval2 := l_infix.internal_name
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp91 := yyvsp91 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_549
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs91.item (yyvsp91) as l_prefix then
					yyval2 := l_prefix.internal_name
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp91 := yyvsp91 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_550
			--|#line <not available> "eiffel.y"
		local
			yyval25: detachable ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level
				when Normal_level then
					yyval25 := ast_factory.new_access_id_as (yyvs2.item (yyvsp2), yyvs101.item (yyvsp101))
				when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
					yyval25 := ast_factory.new_access_assert_as (yyvs2.item (yyvsp2), yyvs101.item (yyvsp101))
				when Invariant_level then
					yyval25 := ast_factory.new_access_inv_as (yyvs2.item (yyvsp2), yyvs101.item (yyvsp101), Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp101 := yyvsp101 -1
	if yyvsp25 >= yyvsc25 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs25")
		end
		yyvsc25 := yyvsc25 + yyInitial_yyvs_size
		yyvs25 := yyspecial_routines25.aliased_resized_area (yyvs25, yyvsc25)
	end
	yyspecial_routines25.force (yyvs25, yyval25, yyvsp25)
end
		end

	yy_do_action_551
			--|#line <not available> "eiffel.y"
		local
			yyval26: detachable ACCESS_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval26 := ast_factory.new_access_feat_as (yyvs2.item (yyvsp2), yyvs101.item (yyvsp101)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp101 := yyvsp101 -1
	if yyvsp26 >= yyvsc26 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs26")
		end
		yyvsc26 := yyvsc26 + yyInitial_yyvs_size
		yyvs26 := yyspecial_routines26.aliased_resized_area (yyvs26, yyvsc26)
	end
	yyspecial_routines26.force (yyvs26, yyval26, yyvsp26)
end
		end

	yy_do_action_552
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs30.item (yyvsp30) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp30 := yyvsp30 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_553
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_554
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs84.item (yyvsp84) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp84 := yyvsp84 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_555
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				yyval48 := ast_factory.new_expr_call_as (yyvs11.item (yyvsp11))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp11 := yyvsp11 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_556
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_expr_call_as (yyvs8.item (yyvsp8)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp8 := yyvsp8 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_557
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_expr_call_as (yyvs42.item (yyvsp42)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp42 := yyvsp42 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_558
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs67.item (yyvsp67) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp67 := yyvsp67 -1
	if yyvsp48 >= yyvsc48 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs48")
		end
		yyvsc48 := yyvsc48 + yyInitial_yyvs_size
		yyvs48 := yyspecial_routines48.aliased_resized_area (yyvs48, yyvsc48)
	end
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_559
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_paran_as (yyvs48.item (yyvsp48), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_560
			--|#line <not available> "eiffel.y"
		local
			yyval101: detachable PARAMETER_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp101 := yyvsp101 + 1
	if yyvsp101 >= yyvsc101 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs101")
		end
		yyvsc101 := yyvsc101 + yyInitial_yyvs_size
		yyvs101 := yyspecial_routines101.aliased_resized_area (yyvs101, yyvsc101)
	end
	yyspecial_routines101.force (yyvs101, yyval101, yyvsp101)
end
		end

	yy_do_action_561
			--|#line <not available> "eiffel.y"
		local
			yyval101: detachable PARAMETER_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)), filename,
						once "Empty parameter list are not allowed"))
				end
				yyval101 := ast_factory.new_parameter_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp101 := yyvsp101 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp101 >= yyvsc101 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs101")
		end
		yyvsc101 := yyvsc101 + yyInitial_yyvs_size
		yyvs101 := yyspecial_routines101.aliased_resized_area (yyvs101, yyvsc101)
	end
	yyspecial_routines101.force (yyvs101, yyval101, yyvsp101)
end
		end

	yy_do_action_562
			--|#line <not available> "eiffel.y"
		local
			yyval101: detachable PARAMETER_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval101 := ast_factory.new_parameter_list_as (yyvs100.item (yyvsp100), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp101 := yyvsp101 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp100 := yyvsp100 -1
	if yyvsp101 >= yyvsc101 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs101")
		end
		yyvsc101 := yyvsc101 + yyInitial_yyvs_size
		yyvs101 := yyspecial_routines101.aliased_resized_area (yyvs101, yyvsc101)
	end
	yyspecial_routines101.force (yyvs101, yyval101, yyvsp101)
end
		end

	yy_do_action_563
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_564
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_expr_address_as (yyvs48.item (yyvsp48), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -3
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_565
			--|#line <not available> "eiffel.y"
		local
			yyval100: detachable EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval100 := ast_factory.new_eiffel_list_expr_as (counter_value + 1)
				if attached yyval100 as l_list and then attached yyvs48.item (yyvsp48) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp100 := yyvsp100 + 1
	yyvsp48 := yyvsp48 -1
	if yyvsp100 >= yyvsc100 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs100")
		end
		yyvsc100 := yyvsc100 + yyInitial_yyvs_size
		yyvs100 := yyspecial_routines100.aliased_resized_area (yyvs100, yyvsc100)
	end
	yyspecial_routines100.force (yyvs100, yyval100, yyvsp100)
end
		end

	yy_do_action_566
			--|#line <not available> "eiffel.y"
		local
			yyval100: detachable EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval100 := yyvs100.item (yyvsp100)
				if attached yyval100 as l_list and then attached yyvs48.item (yyvsp48) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines100.force (yyvs100, yyval100, yyvsp100)
end
		end

	yy_do_action_567
			--|#line <not available> "eiffel.y"
		local
			yyval100: detachable EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval100 := ast_factory.new_eiffel_list_expr_as (counter_value + 1)
				if attached yyval100 as l_list and then attached yyvs48.item (yyvsp48) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp100 := yyvsp100 + 1
	yyvsp48 := yyvsp48 -1
	if yyvsp100 >= yyvsc100 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs100")
		end
		yyvsc100 := yyvsc100 + yyInitial_yyvs_size
		yyvs100 := yyspecial_routines100.aliased_resized_area (yyvs100, yyvsc100)
	end
	yyspecial_routines100.force (yyvs100, yyval100, yyvsp100)
end
		end

	yy_do_action_568
			--|#line <not available> "eiffel.y"
		local
			yyval100: detachable EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval100 := yyvs100.item (yyvsp100)
				if attached yyval100 as l_list and then attached yyvs48.item (yyvsp48) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines100.force (yyvs100, yyval100, yyvsp100)
end
		end

	yy_do_action_569
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_570
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval2 := yyvs2.item (yyvsp2);
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_571
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_id then
					l_id.to_upper		
					yyval2 := l_id
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_572
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_573
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_574
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_575
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_576
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_577
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_578
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_tuple then
					l_tuple.to_upper
					yyval2 := l_tuple
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_579
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_id then
					l_id.to_lower
					yyval2 := l_id
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_580
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_tuple then
					l_tuple.to_lower
					yyval2 := l_tuple
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_581
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_582
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_583
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_584
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_585
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable IF_EXPRESSION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := ast_factory.new_if_expression_as (yyvs48.item (yyvsp48 - 2), yyvs48.item (yyvsp48 - 1), Void, yyvs48.item (yyvsp48), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 3), yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp59 := yyvsp59 + 1
	yyvsp14 := yyvsp14 -4
	yyvsp48 := yyvsp48 -3
	if yyvsp59 >= yyvsc59 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs59")
		end
		yyvsc59 := yyvsc59 + yyInitial_yyvs_size
		yyvs59 := yyspecial_routines59.aliased_resized_area (yyvs59, yyvsc59)
	end
	yyspecial_routines59.force (yyvs59, yyval59, yyvsp59)
end
		end

	yy_do_action_586
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable IF_EXPRESSION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := ast_factory.new_if_expression_as (yyvs48.item (yyvsp48 - 2), yyvs48.item (yyvsp48 - 1), yyvs97.item (yyvsp97), yyvs48.item (yyvsp48), yyvs14.item (yyvsp14), yyvs14.item (yyvsp14 - 3), yyvs14.item (yyvsp14 - 2), yyvs14.item (yyvsp14 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp59 := yyvsp59 + 1
	yyvsp14 := yyvsp14 -4
	yyvsp48 := yyvsp48 -3
	yyvsp97 := yyvsp97 -1
	if yyvsp59 >= yyvsc59 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs59")
		end
		yyvsc59 := yyvsc59 + yyInitial_yyvs_size
		yyvs59 := yyspecial_routines59.aliased_resized_area (yyvs59, yyvsc59)
	end
	yyspecial_routines59.force (yyvs59, yyval59, yyvsp59)
end
		end

	yy_do_action_587
			--|#line <not available> "eiffel.y"
		local
			yyval97: detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval97 := yyvs97.item (yyvsp97) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines97.force (yyvs97, yyval97, yyvsp97)
end
		end

	yy_do_action_588
			--|#line <not available> "eiffel.y"
		local
			yyval97: detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval97 := ast_factory.new_eiffel_list_elseif_expression_as (counter_value + 1)
				if attached yyval97 as l_list and then attached yyvs45.item (yyvsp45) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp97 := yyvsp97 + 1
	yyvsp45 := yyvsp45 -1
	if yyvsp97 >= yyvsc97 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs97")
		end
		yyvsc97 := yyvsc97 + yyInitial_yyvs_size
		yyvs97 := yyspecial_routines97.aliased_resized_area (yyvs97, yyvsc97)
	end
	yyspecial_routines97.force (yyvs97, yyval97, yyvsp97)
end
		end

	yy_do_action_589
			--|#line <not available> "eiffel.y"
		local
			yyval97: detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval97 := yyvs97.item (yyvsp97)
				if attached yyval97 as l_list and then attached yyvs45.item (yyvsp45) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp45 := yyvsp45 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines97.force (yyvs97, yyval97, yyvsp97)
end
		end

	yy_do_action_590
			--|#line <not available> "eiffel.y"
		local
			yyval45: detachable ELSIF_EXPRESSION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval45 := ast_factory.new_elseif_expression_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs14.item (yyvsp14 - 1), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp45 := yyvsp45 + 1
	yyvsp14 := yyvsp14 -2
	yyvsp48 := yyvsp48 -2
	if yyvsp45 >= yyvsc45 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs45")
		end
		yyvsc45 := yyvsc45 + yyInitial_yyvs_size
		yyvs45 := yyspecial_routines45.aliased_resized_area (yyvs45, yyvsc45)
	end
	yyspecial_routines45.force (yyvs45, yyval45, yyvsp45)
end
		end

	yy_do_action_591
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_592
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_593
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp63 := yyvsp63 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_594
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp63 := yyvsp63 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_595
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp75 := yyvsp75 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_596
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp75 := yyvsp75 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_597
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_598
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_599
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_600
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp63 := yyvsp63 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_601
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp75 := yyvsp75 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_602
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_603
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_604
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp63 := yyvsp63 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_605
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp63 := yyvsp63 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_606
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp75 := yyvsp75 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_607
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp75 := yyvsp75 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_608
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_609
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_610
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs16.item (yyvsp16) as l_string then
					l_string.set_is_once_string (True)
					l_string.set_once_string_keyword (yyvs14.item (yyvsp14))
				end
				increment_once_manifest_string_counter
				yyval30 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp30 := yyvsp30 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp30 >= yyvsc30 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs30")
		end
		yyvsc30 := yyvsc30 + yyInitial_yyvs_size
		yyvs30 := yyspecial_routines30.aliased_resized_area (yyvs30, yyvsc30)
	end
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_611
			--|#line <not available> "eiffel.y"
		local
			yyval7: detachable BOOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval7 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
		end

	yy_do_action_612
			--|#line <not available> "eiffel.y"
		local
			yyval7: detachable BOOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval7 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
		end

	yy_do_action_613
			--|#line <not available> "eiffel.y"
		local
			yyval3: detachable CHAR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval3 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
		end

	yy_do_action_614
			--|#line <not available> "eiffel.y"
		local
			yyval3: detachable CHAR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval3 := ast_factory.new_typed_char_as (yyvs85.item (yyvsp85), yyvs3.item (yyvsp3))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
		end

	yy_do_action_615
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_616
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_617
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_618
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval63 := ast_factory.new_integer_value (Current, '+', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp63 := yyvsp63 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp63 >= yyvsc63 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs63")
		end
		yyvsc63 := yyvsc63 + yyInitial_yyvs_size
		yyvs63 := yyspecial_routines63.aliased_resized_area (yyvs63, yyvsc63)
	end
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_619
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval63 := ast_factory.new_integer_value (Current, '-', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp63 := yyvsp63 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp63 >= yyvsc63 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs63")
		end
		yyvsc63 := yyvsc63 + yyInitial_yyvs_size
		yyvs63 := yyspecial_routines63.aliased_resized_area (yyvs63, yyvsc63)
	end
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_620
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval63 := ast_factory.new_integer_value (Current, '%U', Void, token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp63 := yyvsp63 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp63 >= yyvsc63 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs63")
		end
		yyvsc63 := yyvsc63 + yyInitial_yyvs_size
		yyvs63 := yyspecial_routines63.aliased_resized_area (yyvs63, yyvsc63)
	end
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_621
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_622
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_623
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval63 := ast_factory.new_integer_value (Current, '%U', yyvs85.item (yyvsp85), token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp63 := yyvsp63 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp63 >= yyvsc63 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs63")
		end
		yyvsc63 := yyvsc63 + yyInitial_yyvs_size
		yyvs63 := yyspecial_routines63.aliased_resized_area (yyvs63, yyvsc63)
	end
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_624
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval63 := ast_factory.new_integer_value (Current, '+', yyvs85.item (yyvsp85), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp63 >= yyvsc63 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs63")
		end
		yyvsc63 := yyvsc63 + yyInitial_yyvs_size
		yyvs63 := yyspecial_routines63.aliased_resized_area (yyvs63, yyvsc63)
	end
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_625
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval63 := ast_factory.new_integer_value (Current, '-', yyvs85.item (yyvsp85), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp63 >= yyvsc63 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs63")
		end
		yyvsc63 := yyvsc63 + yyInitial_yyvs_size
		yyvs63 := yyspecial_routines63.aliased_resized_area (yyvs63, yyvsc63)
	end
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_626
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_627
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_628
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_629
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, False, '%U', Void, token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp75 := yyvsp75 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp75 >= yyvsc75 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs75")
		end
		yyvsc75 := yyvsc75 + yyInitial_yyvs_size
		yyvs75 := yyspecial_routines75.aliased_resized_area (yyvs75, yyvsc75)
	end
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_630
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, True, '+', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp75 := yyvsp75 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp75 >= yyvsc75 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs75")
		end
		yyvsc75 := yyvsc75 + yyInitial_yyvs_size
		yyvs75 := yyspecial_routines75.aliased_resized_area (yyvs75, yyvsc75)
	end
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_631
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, True, '-', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp75 := yyvsp75 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp75 >= yyvsc75 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs75")
		end
		yyvsc75 := yyvsc75 + yyInitial_yyvs_size
		yyvs75 := yyspecial_routines75.aliased_resized_area (yyvs75, yyvsc75)
	end
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_632
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_633
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_634
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, False, '%U', yyvs85.item (yyvsp85), token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp75 := yyvsp75 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp75 >= yyvsc75 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs75")
		end
		yyvsc75 := yyvsc75 + yyInitial_yyvs_size
		yyvs75 := yyspecial_routines75.aliased_resized_area (yyvs75, yyvsc75)
	end
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_635
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, True, '+', yyvs85.item (yyvsp85), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp75 := yyvsp75 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp75 >= yyvsc75 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs75")
		end
		yyvsc75 := yyvsc75 + yyInitial_yyvs_size
		yyvs75 := yyspecial_routines75.aliased_resized_area (yyvs75, yyvsc75)
	end
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_636
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, True, '-', yyvs85.item (yyvsp85), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp75 := yyvsp75 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp75 >= yyvsc75 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs75")
		end
		yyvsc75 := yyvsc75 + yyInitial_yyvs_size
		yyvs75 := yyspecial_routines75.aliased_resized_area (yyvs75, yyvsc75)
	end
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_637
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_638
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_639
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_640
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_641
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_642
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval16 := yyvs16.item (yyvsp16)
				if attached yyval16 as l_string then
					l_string.set_type (yyvs85.item (yyvsp85))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 -1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_643
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_644
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_645
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_646
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_647
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_648
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_649
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_650
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_651
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_652
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_653
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_654
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_655
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_656
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_657
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_658
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_659
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_660
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_661
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_662
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_663
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_664
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_665
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_666
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_667
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_668
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_not then
					l_str_not.value.to_lower
					yyval16 := l_str_not
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_669
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_free then
					l_str_free.value.to_lower
					yyval16 := l_str_free
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_670
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_671
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_672
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_673
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_674
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_675
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_676
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_677
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_678
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_679
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_680
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_681
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_and then
					l_str_and.value.to_lower
					yyval16 := l_str_and
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_682
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_and_then then
					l_str_and_then.value.to_lower
					yyval16 := l_str_and_then
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_683
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_implies then 
					l_str_implies.value.to_lower
					yyval16 := l_str_implies
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_684
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_or then
					l_str_or.value.to_lower
					yyval16 := l_str_or
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_685
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_or_else then
					l_str_or_else.value.to_lower
					yyval16 := l_str_or_else
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_686
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_xor then
					l_str_xor.value.to_lower
					yyval16 := l_str_xor
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_687
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_free then
					l_str_free.value.to_lower
					yyval16 := l_str_free
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_688
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := ast_factory.new_array_as (ast_factory.new_eiffel_list_expr_as (0), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp28 := yyvsp28 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp28 >= yyvsc28 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs28")
		end
		yyvsc28 := yyvsc28 + yyInitial_yyvs_size
		yyvs28 := yyspecial_routines28.aliased_resized_area (yyvs28, yyvsc28)
	end
	yyspecial_routines28.force (yyvs28, yyval28, yyvsp28)
end
		end

	yy_do_action_689
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval28 := ast_factory.new_array_as (ast_factory.new_eiffel_list_expr_as (0), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if attached yyval28 as a then
					a.set_type (yyvs85.item (yyvsp85))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp28 := yyvsp28 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -2
	if yyvsp28 >= yyvsc28 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs28")
		end
		yyvsc28 := yyvsc28 + yyInitial_yyvs_size
		yyvs28 := yyspecial_routines28.aliased_resized_area (yyvs28, yyvsc28)
	end
	yyspecial_routines28.force (yyvs28, yyval28, yyvsp28)
end
		end

	yy_do_action_690
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := ast_factory.new_array_as (yyvs100.item (yyvsp100), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp28 := yyvsp28 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp100 := yyvsp100 -1
	if yyvsp28 >= yyvsc28 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs28")
		end
		yyvsc28 := yyvsc28 + yyInitial_yyvs_size
		yyvs28 := yyspecial_routines28.aliased_resized_area (yyvs28, yyvsc28)
	end
	yyspecial_routines28.force (yyvs28, yyval28, yyvsp28)
end
		end

	yy_do_action_691
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval28 := ast_factory.new_array_as (yyvs100.item (yyvsp100), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if attached yyval28 as a then
					a.set_type (yyvs85.item (yyvsp85))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp28 := yyvsp28 + 1
	yyvsp85 := yyvsp85 -1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp100 := yyvsp100 -1
	if yyvsp28 >= yyvsc28 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs28")
		end
		yyvsc28 := yyvsc28 + yyInitial_yyvs_size
		yyvs28 := yyspecial_routines28.aliased_resized_area (yyvs28, yyvsc28)
	end
	yyspecial_routines28.force (yyvs28, yyval28, yyvsp28)
end
		end

	yy_do_action_692
			--|#line <not available> "eiffel.y"
		local
			yyval84: detachable TUPLE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval84 := ast_factory.new_tuple_as (ast_factory.new_eiffel_list_expr_as (0), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp84 := yyvsp84 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp84 >= yyvsc84 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs84")
		end
		yyvsc84 := yyvsc84 + yyInitial_yyvs_size
		yyvs84 := yyspecial_routines84.aliased_resized_area (yyvs84, yyvsc84)
	end
	yyspecial_routines84.force (yyvs84, yyval84, yyvsp84)
end
		end

	yy_do_action_693
			--|#line <not available> "eiffel.y"
		local
			yyval84: detachable TUPLE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval84 := ast_factory.new_tuple_as (yyvs100.item (yyvsp100), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp84 := yyvsp84 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp100 := yyvsp100 -1
	if yyvsp84 >= yyvsc84 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs84")
		end
		yyvsc84 := yyvsc84 + yyInitial_yyvs_size
		yyvs84 := yyspecial_routines84.aliased_resized_area (yyvs84, yyvsc84)
	end
	yyspecial_routines84.force (yyvs84, yyval84, yyvsp84)
end
		end

	yy_do_action_694
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				add_counter
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_695
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_696
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter2 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_697
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_698
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter2 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_699
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_counter 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_error_action (yy_act: INTEGER)
			-- Execute error action.
		do
			if yy_act <= 199 then
				yy_do_error_action_0_199 (yy_act)
			elseif yy_act <= 399 then
				yy_do_error_action_200_399 (yy_act)
			elseif yy_act <= 599 then
				yy_do_error_action_400_599 (yy_act)
			elseif yy_act <= 799 then
				yy_do_error_action_600_799 (yy_act)
			elseif yy_act <= 999 then
				yy_do_error_action_800_999 (yy_act)
			elseif yy_act <= 1199 then
				yy_do_error_action_1000_1199 (yy_act)
			elseif yy_act <= 1399 then
				yy_do_error_action_1200_1399 (yy_act)
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_0_199 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_200_399 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_400_599 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_600_799 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_800_999 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_1000_1199 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_1200_1399 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			when 1275 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER]
			-- Template for `yytranslate'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 399)
			yytranslate_template_1 (an_array)
			yytranslate_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytranslate_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yytranslate'.
		do
			yyarray_subcopy (an_array, <<
			    0,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2, yyDummy>>,
			1, 200, 0)
		end

	yytranslate_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytranslate'.
		do
			yyarray_subcopy (an_array, <<
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    1,    2,    3,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,

			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,
			   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,
			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  138,  139,  140,  141,  142,  143,  144, yyDummy>>,
			1, 200, 200)
		end

	yyr1_template: SPECIAL [INTEGER]
			-- Template for `yyr1'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 699)
			yyr1_template_1 (an_array)
			yyr1_template_2 (an_array)
			yyr1_template_3 (an_array)
			yyr1_template_4 (an_array)
			Result := yyfixed_array (an_array)
		end

	yyr1_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yyr1'.
		do
			yyarray_subcopy (an_array, <<
			    0,  358,  358,  358,  358,  358,  358,  358,  358,  359,
			  363,  364,  365,  366,  367,  326,  326,  326,  326,  326,
			  329,  329,  329,  327,  327,  328,  328,  215,  217,  216,
			  216,  218,  288,  288,  288,  289,  289,  164,  164,  164,
			  164,  372,  373,  370,  371,  362,  362,  362,  374,  374,
			  375,  375,  178,  178,  152,  152,  307,  307,  308,  308,
			  202,  202,  180,  376,  179,  179,  324,  324,  325,  325,
			  306,  306,  145,  145,  201,  377,  379,  311,  311,  287,
			  287,  286,  286,  285,  285,  285,  283,  284,  148,  260,
			  260,  260,  260,  146,  146,  147,  147,  169,  169,  169,

			  169,  169,  169,  169,  169,  150,  150,  181,  181,  336,
			  336,  336,  336,  380,  337,  337,  236,  278,  237,  237,
			  237,  237,  237,  237,  339,  339,  338,  338,  248,  302,
			  302,  301,  301,  300,  300,  190,  203,  203,  203,  293,
			  293,  292,  292,  182,  182,  312,  313,  313,  309,  310,
			  310,  317,  317,  316,  316,  319,  319,  318,  318,  321,
			  321,  320,  320,  353,  353,  349,  349,  279,  351,  351,
			  280,  280,  153,  153,  154,  154,  252,  381,  382,  251,
			  251,  251,  199,  200,  151,  151,  228,  228,  228,  352,
			  352,  352,  331,  331,  332,  332,  220,  378,  378,  221, yyDummy>>,
			1, 200, 0)
		end

	yyr1_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yyr1'.
		do
			yyarray_subcopy (an_array, <<
			  221,  221,  221,  221,  221,  221,  221,  221,  221,  221,
			  221,  221,  221,  221,  221,  249,  249,  383,  249,  384,
			  189,  189,  385,  189,  386,  342,  342,  343,  343,  387,
			  262,  262,  262,  262,  262,  264,  264,  264,  264,  267,
			  267,  267,  267,  267,  267,  267,  267,  267,  267,  267,
			  267,  267,  267,  267,  267,  267,  267,  271,  271,  268,
			  265,  265,  265,  265,  265,  265,  265,  265,  265,  265,
			  265,  265,  265,  265,  265,  265,  265,  265,  270,  270,
			  272,  272,  277,  277,  277,  274,  274,  274,  276,  276,
			  275,  275,  275,  345,  345,  344,  344,  346,  347,  347,

			  269,  269,  269,  269,  348,  348,  348,  350,  350,  350,
			  322,  322,  322,  323,  323,  204,  204,  204,  204,  205,
			  390,  355,  355,  355,  357,  391,  392,  357,  273,  273,
			  273,  356,  356,  393,  315,  315,  213,  213,  213,  213,
			  296,  297,  297,  187,  219,  219,  290,  290,  291,  291,
			  175,  333,  333,  229,  229,  229,  229,  229,  229,  229,
			  229,  229,  229,  229,  229,  229,  229,  229,  229,  229,
			  229,  232,  232,  232,  232,  232,  394,  231,  231,  231,
			  395,  231,  396,  330,  330,  155,  155,  230,  230,  397,
			  156,  156,  282,  282,  281,  281,  186,  341,  341,  341, yyDummy>>,
			1, 200, 200)
		end

	yyr1_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yyr1'.
		do
			yyarray_subcopy (an_array, <<
			  340,  340,  149,  149,  163,  163,  250,  250,  294,  294,
			  295,  295,  183,  183,  183,  183,  183,  183,  253,  398,
			  399,  253,  400,  401,  253,  253,  354,  354,  157,  157,
			  157,  157,  157,  157,  335,  335,  335,  334,  334,  235,
			  235,  235,  184,  184,  184,  184,  185,  185,  171,  171,
			  159,  159,  161,  161,  172,  172,  172,  172,  177,  206,
			  261,  402,  233,  314,  314,  266,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  168,
			  168,  168,  168,  168,  168,  168,  168,  168,  168,  168,
			  168,  168,  168,  168,  168,  168,  168,  168,  168,  168,

			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  194,  194,  194,  194,  194,  194,  194,  194,
			  194,  195,  195,  195,  211,  197,  197,  198,  198,  174,
			  174,  174,  174,  174,  174,  174,  174,  238,  238,  239,
			  239,  241,  240,  173,  173,  234,  234,  212,  212,  212,
			  158,  160,  191,  191,  191,  191,  191,  191,  191,  191,
			  305,  305,  305,  196,  196,  304,  304,  303,  303,  207,
			  207,  208,  208,  208,  208,  208,  208,  208,  209,  210,
			  210,  210,  210,  210,  210,  214,  214,  298,  299,  299,
			  188,  167,  167,  167,  167,  167,  167,  167,  165,  165, yyDummy>>,
			1, 200, 400)
		end

	yyr1_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yyr1'.
		do
			yyarray_subcopy (an_array, <<
			  165,  165,  165,  166,  166,  166,  166,  166,  166,  166,
			  166,  170,  170,  176,  176,  222,  222,  222,  223,  223,
			  224,  225,  225,  226,  227,  227,  242,  242,  242,  244,
			  243,  243,  245,  245,  246,  247,  247,  254,  254,  256,
			  256,  256,  257,  255,  255,  255,  255,  255,  255,  255,
			  255,  255,  255,  255,  255,  255,  255,  255,  255,  255,
			  255,  255,  255,  255,  255,  255,  259,  259,  259,  259,
			  258,  258,  258,  258,  258,  258,  258,  258,  258,  258,
			  258,  258,  258,  258,  258,  258,  258,  258,  162,  162,
			  162,  162,  263,  263,  368,  360,  388,  369,  389,  361, yyDummy>>,
			1, 100, 600)
		end

	yytypes1_template: SPECIAL [INTEGER]
			-- Template for `yytypes1'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1277)
			yytypes1_template_1 (an_array)
			yytypes1_template_2 (an_array)
			yytypes1_template_3 (an_array)
			yytypes1_template_4 (an_array)
			yytypes1_template_5 (an_array)
			yytypes1_template_6 (an_array)
			yytypes1_template_7 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytypes1_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    1,   15,   15,   15,   15,   15,   15,   14,   14,   14,
			   14,    2,    2,    2,  113,    1,    1,    1,    1,   14,
			   66,   52,    1,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   15,   15,
			   14,   14,   14,   14,   14,   14,   14,   14,   13,   11,
			    8,    7,    7,    4,    4,    4,    4,    4,    3,    1,
			    1,    4,   14,   14,   14,    2,    4,    4,    6,    6,
			    6,   25,   28,   30,   31,    7,   34,   34,    3,   42,
			   48,   48,   48,   48,   48,   49,   49,    2,    2,    2,

			   59,   63,   63,   63,   63,   67,   73,   74,   74,   74,
			   75,   75,   75,   75,   81,   16,   16,   16,   16,   84,
			   85,   91,   91,  114,   15,   15,   15,   15,   15,   15,
			   14,   14,   14,   14,   14,    4,    4,    2,    2,    2,
			    2,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   86,   14,   12,    1,    1,   60,  113,    1,   60,
			  113,    1,   89,  127,    1,   66,   14,    2,   91,   91,
			   91,   91,   91,  104,    4,   48,   48,    4,   16,   85,
			   48,   85,    4,   33,   11,    8,    4,    4,   24,    2,
			    2,   85,  129,  129,   16,   16,   16,   16,   16,    4, yyDummy>>,
			1, 200, 0)
		end

	yytypes1_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    4,  101,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,    4,    4,   15,   15,    4,    4,   85,   85,   85,
			   85,   15,   15,   15,   15,    2,    2,    2,   85,    4,
			    1,   11,    8,    2,   91,    4,    1,   48,   48,    4,
			   48,    1,    1,   48,    1,    1,   48,   48,    2,   48,
			    2,   48,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			   14,   14,   14,   14,    6,    6,    6,    2,    4,    4,
			    4,    4,   48,  101,    4,    4,    4,    3,    1,    1,

			    4,    4,    4,   16,   14,   22,   14,   85,   85,   14,
			   85,   85,   15,   15,   14,   85,   85,   85,   85,   11,
			    2,   85,   85,   15,   15,   14,   85,   85,   14,   85,
			   85,   85,   85,    4,  125,  125,    1,    4,    4,   14,
			    1,   14,   14,   14,   14,    1,    4,    4,    1,    2,
			   60,    1,    1,    4,    4,    4,   30,   30,    7,    3,
			    2,   60,   63,   63,   63,   63,   63,   63,   75,   75,
			   75,   75,   75,   75,   16,   85,   92,    1,    1,    1,
			   21,    2,  124,    1,   91,   14,   17,    4,    1,   85,
			   14,   15,   14,   14,    4,    2,   85,    4,    1,    4, yyDummy>>,
			1, 200, 200)
		end

	yytypes1_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    4,  118,    4,   81,    2,    4,    1,   26,   34,    2,
			   70,   34,    4,    4,    4,   48,  100,  100,    4,   21,
			    1,    4,    4,   34,    1,    1,   48,   48,   48,   48,
			   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,
			   48,   14,   48,   48,   14,   48,   48,   48,   48,   48,
			   48,    1,   34,    1,   34,   34,   34,    4,    1,    2,
			    1,    1,    1,    1,  124,   14,   23,   85,   85,   85,
			   85,   14,   85,   85,   14,   85,   85,   85,   85,    4,
			   14,   85,   85,   14,   85,   85,   85,   85,    4,  125,
			    1,    1,    2,    2,    2,    2,    2,    1,    1,    4,

			    1,  113,    4,    4,    1,    4,   42,  127,    1,    4,
			   14,   48,    2,   83,  124,   16,   16,   16,   16,   16,
			    1,   52,    4,    2,    2,    2,   48,    2,    4,    4,
			   27,   88,  126,    1,    2,    4,    1,   85,   14,   20,
			   80,    4,    4,   48,   48,  100,    4,  101,   27,   85,
			    4,    1,    1,    4,    4,   21,   48,   48,  100,  100,
			   48,   48,  100,  100,  100,  101,   48,   15,   14,   85,
			   85,   85,   85,    2,   85,   85,   85,   85,    4,   85,
			  125,    4,    4,  111,  113,   30,    2,   92,    1,   92,
			   14,   84,    4,    4,    1,    4,    4,    4,  124,    1, yyDummy>>,
			1, 200, 400)
		end

	yytypes1_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			   14,   14,  104,   15,    4,    4,   14,   32,  129,   48,
			   14,   97,    1,  101,    2,    1,    1,   21,   48,    2,
			  118,    4,   48,   71,   85,  117,   81,   16,   80,   81,
			  101,    4,    4,    1,   26,   70,    4,    1,    4,    4,
			   34,    1,    4,    4,    1,    1,    1,    1,    1,   48,
			   48,    4,    1,    4,    2,   85,  125,  126,    4,    1,
			   14,   20,    4,   92,    4,    1,   14,   85,   21,   14,
			    4,   48,  124,   85,    1,  113,   52,    4,   14,   14,
			   48,   14,   14,   45,   97,  101,  126,    1,    4,    1,
			    1,    4,    4,    1,   80,   14,   77,  118,   48,    1,

			    4,   48,  100,   67,   67,    4,    4,    4,    4,    4,
			   14,   90,   90,   90,    1,    4,    4,    4,    4,    1,
			   16,   20,    1,    1,    4,    4,    4,   15,   19,   80,
			    1,   85,  113,    2,   14,   48,   48,    1,    1,    4,
			    1,    1,    4,   81,   14,   77,   80,    4,  100,   48,
			   48,   48,    2,   14,   14,  125,    1,   85,    1,   14,
			   14,   14,   55,   56,    2,  111,    1,   92,    2,   15,
			   15,    4,  113,  113,    4,   19,   80,   14,   14,   97,
			   85,    4,  117,  118,   77,  124,   14,  128,    4,  125,
			  126,    4,    4,    2,  125,    2,    2,    2,   56,    4, yyDummy>>,
			1, 200, 600)
		end

	yytypes1_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    1,   14,  119,   10,    3,   30,    7,   38,   63,   63,
			   75,   75,   16,  113,   14,    1,   38,   80,   14,   48,
			    4,  124,    1,   15,   14,   14,   14,   12,   50,   64,
			   79,   48,    1,    4,    4,  130,    1,    1,    4,    4,
			    1,    1,   15,  113,   80,  113,  113,  113,  127,  115,
			    1,    4,  123,   51,   16,  115,   14,   46,    1,    1,
			    4,    4,    4,   85,   85,   85,   85,  132,  111,    4,
			    2,    2,   72,   72,   87,  119,  119,    1,    1,   80,
			    1,    1,    4,    1,  115,   20,   14,   46,   14,   18,
			    2,  126,    1,  132,   14,  107,    4,  125,    1,    4,

			   14,   14,   14,   14,   14,   99,  108,  109,  110,  121,
			    1,    1,  113,   14,   14,   14,   14,   14,   14,   14,
			   14,    9,    8,    4,    6,    6,    6,   29,   34,   34,
			   36,   41,   43,   48,   49,   49,   57,    2,   58,   61,
			   62,   62,   68,   74,   78,   82,   85,  114,  115,   16,
			  122,   46,  124,  115,   14,    4,  131,  132,  121,  105,
			    1,  119,  119,  104,    1,  104,    1,  104,    4,    1,
			  108,  108,  109,  109,  110,  110,   14,   99,   99,   95,
			    1,    1,   82,   48,   48,  115,  123,   33,  124,    4,
			    4,    4,   85,    2,    2,    2,    4,    4,    4,    4, yyDummy>>,
			1, 200, 800)
		end

	yytypes1_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    4,    1,    1,    4,   14,   22,    1,    4,    1,  124,
			    1,    1,    4,  132,   14,    2,  105,    1,   91,  104,
			   76,   91,  120,    4,   47,   98,  112,  109,  110,   14,
			  108,   14,   94,   14,   14,   40,   95,    1,   93,    1,
			   14,   22,  115,    8,   25,    2,   85,   14,   14,   48,
			   48,   25,    4,    4,   48,   48,   48,   48,   48,  115,
			   48,  115,   23,    1,    4,    4,  131,   14,    4,    1,
			  119,    4,    1,    4,   14,    1,    4,    1,    1,    1,
			   14,   54,  104,  110,   14,  109,    1,  103,    1,   37,
			  112,   37,  112,    1,    1,   48,   69,  106,   14,   14,

			   14,   35,   93,  115,   14,   90,   14,   27,   25,  115,
			   27,   25,   48,   22,   14,  122,  107,  131,    1,    1,
			    1,    1,   91,    2,  112,   98,    4,   14,  110,   39,
			   91,   94,    1,   14,   37,   53,  103,  104,  104,   95,
			   14,    4,    1,  115,    1,    1,    1,   14,   14,   96,
			    1,   48,   14,   27,   14,   27,    6,   23,  115,  105,
			  104,  120,    4,    1,   14,    4,    4,    4,    1,   66,
			   37,    1,    1,    1,    1,    2,    1,   14,   14,    4,
			    4,    3,    2,   63,   65,   74,   85,  116,   93,  115,
			   14,   14,   14,   44,   96,   14,   48,   68,   14,   90, yyDummy>>,
			1, 200, 1000)
		end

	yytypes1_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    1,    4,    1,    4,    4,  113,   37,  112,   52,  102,
			  103,  106,  115,    4,    4,    4,    4,    4,    4,    4,
			    1,   14,  115,   48,    1,    1,  115,   14,  115,  115,
			   14,  112,   94,  125,  125,   14,    1,    1,   14,    3,
			    2,   74,   85,    3,    2,   63,   74,    2,   63,   74,
			   85,    1,    3,    2,   63,   74,   14,   14,   14,   96,
			   90,  115,    6,   90,    4,    4,  102,    1,  116,  115,
			  115,   14,   14,   14,    4,    1,    1,    1, yyDummy>>,
			1, 78, 1200)
		end

	yytypes2_template: SPECIAL [INTEGER]
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    4,    6,    6,    6,    4,   14,   14,
			   14,   14,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    2,   14,   14,
			   14,    4,    4,    6,    2,    2,    1,    1,    3,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    6,    7,    7,    8,    9,
			   10,   11,   12,   13,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,

			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   15,   15,   15,   15,   15,   15,   15,   15,   15,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER]
			-- Template for `yydefact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1277)
			yydefact_template_1 (an_array)
			yydefact_template_2 (an_array)
			yydefact_template_3 (an_array)
			yydefact_template_4 (an_array)
			yydefact_template_5 (an_array)
			yydefact_template_6 (an_array)
			yydefact_template_7 (an_array)
			Result := yyfixed_array (an_array)
		end

	yydefact_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			   15,  694,  694,  584,  583,  582,  581,  695,  387,  695,
			    0,  580,  579,    0,   48,    1,  695,  695,  695,  389,
			    6,    3,    0,  657,  656,  665,  664,  663,  662,  661,
			  660,  659,  658,  655,  654,  653,  652,  651,  650,  649,
			  648,  647,  646,  645,  641,  644,  640,  643,  583,  581,
			    0,    0,    0,  448,  426,    0,  560,    0,  500,  555,
			  556,  612,  611,    0,    0,  695,    0,  695,  613,  629,
			  620,    0,    0,    0,    0,  524,    0,    0,    0,    0,
			    0,  454,  501,  552,  473,  603,  509,  457,  608,  557,
			  508,    4,  468,  510,  553,  512,  513,  547,    0,  560,

			  511,  604,  466,  522,  605,  558,  455,  456,  540,  539,
			  606,  467,  523,  607,  502,  609,  639,  637,  638,  554,
			  521,  548,  549,  385,  577,  576,  575,  574,  573,  572,
			    0,    0,    0,    0,    0,    0,    0,  578,  571,  293,
			  695,    2,  236,  235,  257,  258,  260,  239,  278,  237,
			  238,  279,   49,   50,    0,   50,   72,  699,    0,  697,
			  699,   43,  697,  699,    0,  695,    0,   83,   84,   85,
			   81,   79,   77,  699,    0,  474,    0,    0,  610,    0,
			    0,    0,    0,    0,  431,  430,  433,  695,    0,  547,
			  434,  432,  427,  419,  669,  668,  667,  666,   87,    0, yyDummy>>,
			1, 200, 0)
		end

	yydefact_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  695,  537,  687,  686,  685,  684,  683,  682,  681,  680,
			  679,  678,  677,  676,  675,  674,  673,  672,  671,  670,
			   86,    0,    0,  576,  575,    0,    0,  286,  285,    0,
			  287,  584,  583,  582,  581,  580,  579,    0,    0,  688,
			    0,  506,  507,   83,  505,  692,    0,    0,  503,  695,
			  516,  631,  619,  514,  630,  618,  515,  518,  547,  519,
			  547,  520,    0,  695,  695,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  695,    0,
			  695,    0,  517,  550,    0,    0,  695,  614,  634,  623,

			    0,    0,    0,  642,  695,  390,    0,  262,  240,    0,
			  261,  241,  576,  575,    0,  264,  243,  265,  244,  281,
			  280,    0,  290,  576,  575,    0,  263,  242,    0,  289,
			  292,  288,  291,  695,  294,  259,  696,    0,    0,   51,
			   46,   52,   53,    0,   50,   45,   73,  697,   18,    0,
			  699,  695,   16,   34,    0,    0,   32,   38,  598,  599,
			   37,  699,  600,  615,  616,  617,  621,  622,  601,  626,
			  627,  628,  632,  633,  602,    0,   72,    0,  695,    8,
			  699,  172,  388,    0,   80,    0,   82,  697,   75,    0,
			    0,    0,    0,    0,    0,    0,  452,  163,  695,    0, yyDummy>>,
			1, 200, 200)
		end

	yydefact_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  695,  424,    0,   54,    0,  561,    0,  544,  529,  560,
			  543,  530,  452,    0,  465,  567,  699,  699,  559,    0,
			    0,    0,    0,  531,    0,    0,  485,  484,  483,  482,
			  481,  480,  479,  492,  494,  493,  495,  471,  472,  470,
			  469,    0,  486,  491,    0,  488,  490,  497,  498,  499,
			  496,    0,  533,    0,  534,  535,  536,  689,    0,  560,
			  636,  625,  635,  624,  386,    0,    0,  267,  245,  266,
			  246,    0,  274,  252,    0,  273,  253,  275,  254,    0,
			    0,  269,  247,    0,  268,  248,  270,  249,  296,    0,
			    0,    0,  282,  284,  310,  570,  569,   47,  695,   43,

			   28,   24,  697,   43,   27,   30,    0,  169,   72,  697,
			   72,   72,  547,  229,  699,   92,   91,   90,   89,   93,
			    0,   95,  465,  475,  384,  383,  695,  560,  449,    0,
			  446,  697,  699,    0,  434,  435,    0,  422,    0,  177,
			  420,  560,    0,  563,  565,  699,    0,  551,  447,    0,
			  697,    0,    0,    0,  504,  699,    0,    0,  699,  699,
			  487,  489,  699,  699,  699,  541,  391,    0,    0,  277,
			  255,  276,  256,  283,  272,  250,  271,  251,  295,  298,
			  699,    0,  695,  184,   26,   35,   37,   31,   43,   72,
			   44,    0,    0,  170,    0,  231,  230,   72,    0,  226, yyDummy>>,
			1, 200, 400)
		end

	yydefact_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			   94,   88,   78,   96,    0,  695,   15,   76,   95,  476,
			    0,    0,    0,  542,  560,  695,    0,  699,  699,  547,
			  425,  439,  441,  437,  521,  699,   54,   55,  215,  434,
			  538,    0,  697,    0,  545,  546,    0,    0,  690,  693,
			  532,  175,  382,  380,    0,    0,    0,    0,    0,  392,
			  392,  697,  297,  301,  571,    0,  302,  303,  311,   41,
			    0,   54,  697,   33,   29,   39,   44,   72,  173,   72,
			  234,   72,  228,  105,  695,   54,  197,    0,   15,    0,
			    0,    0,    0,  697,  699,  453,  166,    0,  164,    0,
			  699,  697,  440,    0,  423,  217,  178,  418,    0,    0,

			  562,  478,  568,    0,    0,  527,  525,  526,  528,  691,
			    0,  393,    0,    0,    0,  697,    0,  697,  304,    0,
			  185,   10,   43,   40,  171,  233,  232,    0,   20,  100,
			   74,  105,   54,  477,  585,    0,    0,    0,  587,    0,
			    0,    0,  436,  434,  219,  695,  189,  564,  566,  381,
			  379,  395,  547,  378,  377,  299,    0,   72,    0,    0,
			    0,    0,  320,  313,  318,   42,  109,   36,  106,   15,
			  694,    0,   54,   97,  198,   95,  103,  586,    0,  589,
			   72,  429,  438,  421,  695,  216,  695,    0,    0,  305,
			  308,  307,  698,  571,  306,  315,  316,  317,  321,  697, yyDummy>>,
			1, 200, 600)
		end

	yydefact_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  699,  695,   11,  108,  592,  107,  591,   20,  593,  594,
			  595,  596,  597,   54,   21,  695,   20,  102,   15,  590,
			  167,  218,  695,  197,  397,    0,  197,  181,  180,  179,
			  220,  394,  695,  697,    0,  319,    0,    0,    0,  110,
			    0,  109,  694,   99,  101,  699,   98,   54,  699,  188,
			  695,  695,  197,  184,  183,  186,  222,  402,    0,    0,
			    0,    0,  695,  330,  328,  327,  329,  334,  314,  312,
			    0,  293,  697,   72,  118,  699,   12,  695,   16,  104,
			  191,    0,  398,    0,  187,  182,  224,  695,  197,    0,
			    0,  309,    0,    0,  695,  322,  113,  117,    0,  116,

			  695,  695,  695,  695,  695,  151,  155,  159,    0,  129,
			  111,  695,  699,   22,  461,    0,    0,  197,  397,  448,
			  695,  214,  556,    0,    0,    0,    0,  205,  200,  457,
			  211,  199,  210,    0,    0,    0,  212,  547,  207,  209,
			  697,  197,  208,  456,  206,  213,  521,  385,  699,  400,
			  699,  695,  221,  403,  176,  697,  699,  331,  326,    0,
			    0,  695,  115,  154,    0,  162,    0,  158,  132,    0,
			  152,  155,  156,  159,  160,    0,  119,  130,  151,  139,
			    0,    0,  695,  695,    0,  385,  197,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, yyDummy>>,
			1, 200, 800)
		end

	yydefact_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,  196,    0,  197,  390,  193,  697,    0,  223,
			    0,    0,  333,    0,  335,  146,  699,    0,  149,  699,
			  126,    0,  699,  695,  697,  699,  695,  159,    0,  120,
			  155,  695,  695,  412,  415,  697,  699,    0,    0,    0,
			  197,    0,    0,  451,  452,  450,  452,  197,  458,  407,
			  405,  452,  452,    0,  201,  203,  204,  406,  404,  195,
			  202,  385,    0,    0,  399,  334,    0,  324,  697,  145,
			  699,  697,  148,  697,    0,  125,   66,    0,    0,  131,
			  137,   72,  138,    0,  121,  159,    0,   13,    0,  695,
			  414,  695,  417,    0,  409,    0,  463,  699,  197,  344,

			  695,  697,  699,  695,    0,    0,  396,  444,  452,    0,
			  442,  452,    0,  390,  197,  401,  323,  332,    0,  112,
			    0,    0,  128,   68,  699,  134,  135,  122,    0,  141,
			    0,  699,  387,   63,  695,  697,  699,  413,  416,  411,
			    0,  697,    0,    0,    0,    0,  347,  197,  336,    0,
			    0,    0,    0,  445,  459,  443,  376,    0,  392,  147,
			  150,  127,  697,    0,  123,  697,    0,    0,  140,   15,
			   64,  695,   60,    0,   57,  462,    0,  197,  345,    0,
			    0,  355,  357,  353,  351,  363,    0,  699,  349,    0,
			  197,  338,    0,  697,  699,  197,    0,  197,  197,    0, yyDummy>>,
			1, 200, 1000)
		end

	yydefact_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			    0,   67,    0,  695,  695,    0,   62,   65,  697,  699,
			   59,  464,    0,    0,    0,    0,  697,    0,    0,    0,
			    0,  337,    0,    0,    0,  340,  392,  197,    0,  392,
			  374,   69,  142,    0,    0,    9,  695,   14,  460,  356,
			  362,  370,    0,  361,  358,  359,  365,  360,  354,  368,
			    0,    0,  369,  364,  367,  366,  197,  339,  197,  342,
			    0,    0,  375,    0,  144,    0,   71,   61,  352,  350,
			  343,  372,  371,  373,  143,    0,    0,    0, yyDummy>>,
			1, 78, 1200)
		end

	yydefgoto_template: SPECIAL [INTEGER]
			-- Template for `yydefgoto'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 257)
			yydefgoto_template_1 (an_array)
			yydefgoto_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yydefgoto_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yydefgoto'.
		do
			yyarray_subcopy (an_array, <<
			  347,  601,  606,  386,  889,  728,  661,  539,  617,  419,
			  305,  466,  188,   81, 1044,  407,  530,   82,  927,  356,
			  357,   83,  805,   84,  607,   85,  183,   86,  408,   87,
			 1101,   88,  930,  343, 1089, 1134,  807, 1129, 1035,  931,
			   89,  932, 1193,  683,  857, 1024,   90,  415,   92,   93,
			   94,  544,   95,   96,  828,  853, 1208, 1135, 1081,  762,
			  763,  936, 1123,  139,  140,   97,   98,   99,  938,  100,
			  159,  361,  156,  350,  939,  940,  941,  362,  101,  102,
			  365,  103,  104,  829, 1184,   20,  105,  942, 1096,  410,
			  623,  872,  873,  106,  107,  108,  109,  368,  110,  111,

			  371,  112,  113, 1020,  696,  944,  830,  540,  114,  115,
			  116,  117,  118,  220,  198,  519,  945,  513,  119,  655,
			  142,  120,  143,  144,  145,  146,  147,  148,  865,  229,
			  149,  150,  151,  874,  531,  162,  711,  712,  121,  122,
			  170,  171,  172,  376,  587, 1038, 1102, 1131, 1032,  979,
			 1036, 1149, 1194,  611,  684, 1025,  905,  978,  416,  545,
			  201, 1209, 1087, 1136,  963, 1019,  173,  959, 1016, 1097,
			  895,  970,  971,  972,  973,  974,  975,  583,  765, 1026,
			 1124,   14,  160,  157,  773,  123,  849,  948, 1187,  625,
			  401,  802,  875, 1022,  909,  950,  852,  382,  514,  334, yyDummy>>,
			1, 200, 0)
		end

	yydefgoto_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yydefgoto'.
		do
			yyarray_subcopy (an_array, <<
			  335,  489,  580,  789,  532,  790,  163,  787,  192,  193,
			  835,  956,  957, 1275,   15,  383,  348,  154,  766,  841,
			  911, 1132, 1172,   16,  351,  377,  665,  719,  800,  155,
			  340, 1170,  521,  850,  676,  961,  628,  746,  745,  784,
			  887,  951,  598,  491,  832,  798,  893, 1013, 1066, 1197,
			  704,  703,  165,  403,  629,  626,  743,  982, yyDummy>>,
			1, 58, 200)
		end

	yypact_template: SPECIAL [INTEGER]
			-- Template for `yypact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1277)
			yypact_template_1 (an_array)
			yypact_template_2 (an_array)
			yypact_template_3 (an_array)
			yypact_template_4 (an_array)
			yypact_template_5 (an_array)
			yypact_template_6 (an_array)
			yypact_template_7 (an_array)
			Result := yyfixed_array (an_array)
		end

	yypact_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			  665, 1354,  916, -32768, -32768, -32768, -32768, 1057,  477, -32768,
			 2881, -32768, -32768, 2031,   82, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  808, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 3445, 2881,
			 4647, 2881,  969,  740, 4808,  801,  329, 5359, -32768, 1018,
			 1012, -32768, -32768, 1391, 3574,  996, 2355, 1001, -32768, -32768,
			 -32768, 2881, 2881, 1007, 2881, -32768, 3304, 3163, 2881, 2881,
			 2881, 1006, -32768, -32768, -32768, -32768,  706, -32768, -32768, -32768,
			  700, 5414, -32768, -32768, -32768,  429,  257, -32768, 2881,  863,

			 -32768, -32768, -32768, -32768, -32768, -32768, 1000,  999, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 3917, -32768, -32768,  546, -32768, 2055, 1944, -32768, -32768, -32768,
			 1666, 1288, 1371,  378, 1643, 1854, 1854, -32768, -32768,  728,
			 4643, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  995, -32768,
			 -32768,  992, -32768,  902,  204,  319,  735, -32768,  199,  774,
			 -32768, 1683,   74, -32768,  199,  105,  939,  952, -32768, -32768,
			 -32768, -32768,  971, -32768, 3574,  945, 1287, 2031, -32768, 5224,
			 4156,  985,  378,  969, -32768, -32768, -32768,  865,  983,  980,
			  796, -32768, -32768,  958, -32768, -32768, -32768, -32768, -32768,  378, yyDummy>>,
			1, 200, 0)
		end

	yypact_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			  962, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  939,  939, -32768, -32768,  912,  912, -32768, -32768,  955,
			 -32768, 4300, 4212, 4558, 4473,  196, 4388,  954,  946, -32768,
			 2881, -32768, -32768, -32768, -32768, -32768, 2881, 5272, -32768,  953,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, 5455,  667, 5455,
			  661, 5390,  939, -32768, -32768, 2881, 2881, 2881, 2881, 2881,
			 2881, 2881, 2881, 2881, 2881, 2881, 2881, 2881, 2881, 2881,
			 2740, 2881, 2599, 2881, 2881, 2881, 2881, 2881, -32768,  939,
			 -32768,  939, -32768, -32768,  939,  939,  951, -32768, -32768, -32768,

			  199,  666,  649, -32768,  677,  470, 1288, -32768, -32768, 1288,
			 -32768, -32768, 1458, 1254, 1288, -32768, -32768, -32768, -32768, -32768,
			 -32768,  959, -32768,  822,  552, 1288, -32768, -32768,  448, -32768,
			 -32768, -32768, -32768,  949, -32768, -32768, -32768,  199,  199, -32768,
			 -32768, -32768, -32768, 1164,  902, -32768, -32768, -32768, -32768,  936,
			 -32768, -32768, -32768, -32768,  647,  641,  932, -32768, -32768, -32768,
			  927, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, 4067,  561,  194, -32768, -32768,
			 -32768,  925, -32768, 2458, -32768, 5318, -32768, -32768, -32768,  928,
			  199,  199,  199, 2881,  199,  948,  550, -32768, -32768,  939, yyDummy>>,
			1, 200, 200)
		end

	yypact_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			  917, -32768, 2031,  708,  922, -32768, 3022,  853, -32768,  863,
			 -32768, -32768,  550, 2031, -32768, 5148, -32768, -32768,  930,  914,
			  199, 2881, 2881, -32768, 2881, 2881,  634,  634,  634,  634,
			  634, 1205, 1205,  924,  924,  924,  924,  924,  924,  924,
			  924, 2881, 4912, 3768, 2881, 5210, 5168, 5455, 5455, 5390,
			 -32768, 2881, -32768, 2881, -32768, -32768, -32768, -32768, 2881,  863,
			 -32768, -32768, -32768, -32768, -32768, 2881,  140, -32768, -32768, -32768,
			 -32768, 1288, -32768, -32768, 1288, -32768, -32768, -32768, -32768,  199,
			 1288, -32768, -32768, 1288, -32768, -32768, -32768, -32768, -32768,  915,
			 2031,  919, -32768, -32768,  918, -32768, -32768, -32768, -32768, 3711,

			 -32768, -32768, -32768, 1683, -32768, -32768,  147, -32768,  609, -32768,
			  561, 5192,  890,  652, -32768, -32768, -32768, -32768, -32768,  875,
			  808,  120, 2881, -32768, -32768, -32768, 4950,  863, -32768,  199,
			 -32768,  893, -32768, 2881,  796, -32768, 2317, -32768, 5224, -32768,
			 -32768,  863, 3857, 5414,  880, -32768,  939, -32768, -32768,  885,
			 -32768,  884,  881,  939, -32768, -32768, 5124, 5079, -32768, -32768,
			 4912, 5210, -32768, -32768, -32768, -32768, 5414, 2881, 2881, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  866,
			 -32768, 1829,  872,  723, -32768,  857, -32768, -32768, 1683,  561,
			 -32768,  850, 2031, -32768,  199, -32768, -32768, 2176, 2458, -32768, yyDummy>>,
			1, 200, 400)
		end

	yypact_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 -32768, -32768, -32768, -32768, 2031,  865,  246, -32768,   26,  833,
			 2881,  816,  753, -32768,  863, -32768,  848, -32768, 5414,  568,
			 -32768, -32768, 5414,  841, 3892, -32768,  708, -32768,  788,  796,
			 -32768, 2881, -32768,  844,  853, -32768, 2881, 2881, -32768, -32768,
			 -32768, -32768, -32768, -32768,  843,  840,  837,  823,  818, 1522,
			 1522, -32768, -32768, -32768,  563,  207, -32768, -32768, -32768, -32768,
			 5224,  708, -32768, -32768, -32768, -32768, -32768,  561, -32768,  561,
			 -32768, 5192, -32768,  732, -32768,  708, -32768, 2031,  246,  199,
			 5055, 2881, 2881,  780, -32768, -32768, -32768,  199, -32768,  809,
			 -32768, -32768, -32768,  806, -32768,  760, -32768, -32768, 5234, 3022,

			 -32768, -32768, -32768, 2881, 2881, -32768, -32768, -32768, -32768, -32768,
			 2881, -32768,  791,  781, 2031, -32768, 2031, -32768, -32768,  453,
			 -32768, -32768, 3711, -32768, -32768, -32768, -32768,  199, 1124, -32768,
			  645,  732,  708, -32768, -32768, 4998, 4131,  753, -32768, 2031,
			  785, 2317, -32768,  796, -32768,  418,  731, -32768, -32768, 5414,
			 5414, 5414,  777, -32768, -32768, -32768, 1999,  287, 1677,  378,
			  378,  378, -32768,  775, -32768, -32768,  712, -32768, -32768, 3740,
			 1061, 3865,  708, -32768, -32768,  701, -32768, -32768, 2881, -32768,
			  561, -32768, -32768, -32768,  418, -32768,  422,  237, 2881, -32768,
			 -32768, -32768, -32768,  765, -32768, -32768, -32768, -32768,  761, -32768, yyDummy>>,
			1, 200, 600)
		end

	yypact_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 -32768, 4177, -32768, -32768, -32768, -32768, -32768,  704, -32768, -32768,
			 -32768, -32768, -32768,  708, -32768, -32768,  704, -32768,  246, 5414,
			 -32768, -32768, -32768, -32768,  719, 5249, -32768, -32768, -32768, -32768,
			  729, 5414, -32768, -32768, 1916, -32768,  453,  770,  378, -32768,
			  378,  712,  734, -32768, -32768, -32768, -32768,  708, -32768, -32768,
			 1817,  749, -32768,  723, -32768, -32768,  676,  688,  656, 1677,
			 1164, 1164, -32768, -32768, -32768,  672, -32768,  556, -32768, -32768,
			  722,  728, 1814,  561,  787, -32768, -32768, -32768,  655, -32768,
			 -32768, 3586, -32768, 5249, -32768, -32768, -32768,   30, -32768,  702,
			  499, -32768, 3705,  662, -32768, -32768, -32768, -32768,  378, -32768,

			   42,  698,  331,  174,  113,  619,  544,  524,  690,  679,
			 -32768,  605, -32768, -32768, -32768, 2881, 2881, -32768,  719,  740,
			  134, -32768,  222,  694,  199,  199,  199, -32768,  706,  738,
			 -32768, -32768, -32768,  700,  376,  357, -32768,   98, -32768, -32768,
			 2456, -32768, -32768,  302, -32768, -32768, 3942,  238, -32768,  686,
			 -32768,   30, -32768, -32768, -32768, -32768, -32768,  680, -32768,  670,
			  199, -32768, -32768, -32768,  939, -32768,  939, -32768, -32768,  476,
			 -32768,  544, -32768,  524, -32768,  669, -32768, -32768,  619,  638,
			   59,  655, -32768, 4876, 4107,  546, -32768,  678,   47, 2881,
			 2881, 1959,  653,  667,  661,  648, 2881, 2881, 2881, 2881, yyDummy>>,
			1, 200, 800)
		end

	yypact_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 2881, 3586,  645, 2881, -32768,  470, -32768, -32768,  651, -32768,
			  656,  628, -32768,  624, -32768,  622, -32768,  378,  611, -32768,
			  604,  579, -32768,  603,   11, -32768,  320,  524,  582, -32768,
			  544, -32768,  252, 1594, 1594,  538, -32768, 2881,  350,  433,
			 -32768,  416,  577, -32768,  550, -32768,  521, -32768, -32768, 5414,
			 5390,  550,  521, 2881, 5390, 5390, 5390, 5414, 5390, -32768,
			 5390,  546,   29, 5249, -32768,  556, 3705, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  939, -32768, -32768, 1164,  476, -32768,
			 -32768,  561, -32768,  525, -32768,  524,  939, -32768,  424, -32768,
			 1446, -32768, 1446,   59, -32768, 4974,  534, -32768, -32768, -32768,

			 -32768,  340, -32768,  292, 2881,  495, -32768, -32768,  550,  519,
			 -32768,  550, 5310,  470, -32768, -32768, -32768, -32768,  199, -32768,
			  939,  939, -32768,  522, -32768, -32768, -32768, -32768,  507,  506,
			  172, -32768,  477, -32768,  782,   39, -32768, -32768, -32768, -32768,
			  199, -32768,  466,  475,  210,  433, -32768, -32768, -32768,  284,
			  260, 4812, 2881, -32768, -32768, -32768, -32768,  441,  197, -32768,
			 -32768, -32768, -32768,  467, -32768, -32768,  484,  481, -32768,  246,
			  476, -32768, -32768,  424, -32768, -32768, 2881, -32768, -32768,  471,
			  465,  488,  478,  457,  411,  446,  485, -32768, -32768,  385,
			 -32768, -32768, 2881,  248, -32768, -32768, 4788, -32768, -32768,  380, yyDummy>>,
			1, 200, 1000)
		end

	yypact_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 1164, -32768,  939, -32768, -32768,  375, -32768, -32768,  483, -32768,
			 -32768, -32768,  370,  933,  210,  311, -32768,  210,  382,  372,
			  283, -32768,  313, 1833,  260, -32768,  197, -32768,  297,  197,
			 -32768, -32768, -32768,  256,  137, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  419, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  591,  210, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  209,  203, -32768,   87, -32768,   85, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  114,  108, -32768, yyDummy>>,
			1, 78, 1200)
		end

	yypgoto_template: SPECIAL [INTEGER]
			-- Template for `yypgoto'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 257)
			yypgoto_template_1 (an_array)
			yypgoto_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yypgoto_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yypgoto'.
		do
			yyarray_subcopy (an_array, <<
			 -328, -32768, -551, -32768, -32768,  458,  335,  526, -129, -32768,
			 -847, -945, -32768, -32768, -879,  639, -404, -32768, -32768, -458,
			 -32768, -32768, -32768, -32768, -32768, -132,  265, -795,  -99, -796,
			 -32768,  -71, -32768, -32768, -982, -32768,  412, -32768, -32768, -32768,
			  805, -32768, -32768, -32768, -32768, -32768, -798,  987,  632, -32768,
			 -32768, -32768, -800, -810, -32768, -32768, 1172, -32768, -32768, -32768,
			 -32768, -32768,  836, -168, -333,    0,  903,  -12, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -999, -127, -145,
			 -32768, -102, -117, -32768, -32768,   46, -32768, -32768, -32768,  630,
			 -32768, -32768, -32768, -32768, -804, -32768, -32768, -32768, -140, -148,

			 -32768, -118, -125, -32768, -32768, -32768, -32768, -553, -32768,  -27,
			 -779,  -80, -32768,  790, -32768, -32768, -32768, -32768,  671,    4,
			 -764,  -48, -773, 1039, -32768,   -5,  -38, -109, -32768,  247,
			  -58, -785, -32768, -32768, -32768, -32768,  127, -620,    6,  -10,
			  -65, -163, -32768, -423,  449, -32768,   16,  -43, -32768, -32768,
			   63, -32768,  -70, -32768,  415,   70,  236, -32768, -196,  439,
			  -60, -101, -32768,  -42, -850,   13,  612, -32768,   10,  -47,
			   57,  245,  139,  242, -880,  240, -878, -32768,  273, -971,
			  -93, -569, -319,  610, -370, -816,  468,  102, -147,  360,
			 -489,  258, -809,  -32,  202,   31,  163, -271,  486, -32768, yyDummy>>,
			1, 200, 0)
		end

	yypgoto_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yypgoto'.
		do
			yyarray_subcopy (an_array, <<
			  211, -498,  363, -526,  456, -543, -363, -32768,  547, -32768,
			 -32768,    9,  229, -32768, -32768,    2, 1062, -32768, -32768, -32768,
			 -32768, -32768, -175,    5,  968, -32768,  394, -32768, -32768, -32768,
			 -108, -32768, -32768, -652, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, yyDummy>>,
			1, 58, 200)
		end

	yytable_template: SPECIAL [INTEGER]
			-- Template for `yytable'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 5501)
			yytable_template_1 (an_array)
			yytable_template_2 (an_array)
			yytable_template_3 (an_array)
			yytable_template_4 (an_array)
			yytable_template_5 (an_array)
			yytable_template_6 (an_array)
			yytable_template_7 (an_array)
			yytable_template_8 (an_array)
			yytable_template_9 (an_array)
			yytable_template_10 (an_array)
			yytable_template_11 (an_array)
			yytable_template_12 (an_array)
			yytable_template_13 (an_array)
			yytable_template_14 (an_array)
			yytable_template_15 (an_array)
			yytable_template_16 (an_array)
			yytable_template_17 (an_array)
			yytable_template_18 (an_array)
			yytable_template_19 (an_array)
			yytable_template_20 (an_array)
			yytable_template_21 (an_array)
			yytable_template_22 (an_array)
			yytable_template_23 (an_array)
			yytable_template_24 (an_array)
			yytable_template_25 (an_array)
			yytable_template_26 (an_array)
			yytable_template_27 (an_array)
			yytable_template_28 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytable_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   13,  244,  179,  384,  181,  230,  191,   17,  548,   18,
			  496,   22,  169,  370,  395,  507,  364,  141,  158,  161,
			  164,  369,  167,  178,  730,  228,  330,  332,  168,  358,
			  713,  404,  501,  464,  363,  380,  373,  675,  657,  293,
			  303,  585,  190,  372,  367,  620,  854,  345,  505,  866,
			  417,  965, 1091,  967,  189,  656,  169,  678,  227,  366,
			 1062,  864, 1090, 1092,  237,  947,  243,  240,  238,  246,
			  863,  935,  168,  694, -168, -133,  677,  943,  258,  260,
			  589,  934,   -5,  933,  321,  929,  928,  308,  311,  962,
			  359, 1027,  316,  318, -225, 1028,  327,  329,  331,  303,

			 1005, 1000,  568,  -58,  949, -225, -153,  866, 1277,  732,
			 -133, 1048, 1051,  375, 1276, -133,  330,  332, -133,  864,
			  307,  310,  729,  411, 1114,  315,  317, 1034,  863,  326,
			 1274,  -58,  320, -225,  374,  396, -168, 1033, 1041,  999,
			  697, -153,  336,  603,  153, 1183, -153,  152,  567, 1083,
			 1085, 1273,  605, 1047, -168,  -58,  169,  -58,  349,  772,
			 -168,  360,  346,  423,  381,  663,  167, 1108, 1157, -225,
			  604, -168,  168, 1111,  237,  495, 1082,  -72,  389,  776,
			  593,  238,  595,  596, 1265,  947,   67, -168, 1206,  398,
			  452,  935,  454,  308,  311,  455,  456,  943, -225, 1207, yyDummy>>,
			1, 200, 0)
		end

	yytable_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  813,  934,  406,  933, 1167,  929,  928, 1128, 1070,  409,
			  409,  590,  -72,  568, 1113, 1245, 1248,  -72, 1254,  817,
			  -72, -225, 1166, -225,  818,  990,  307,  310,  558,  559,
			 1180, 1179,  794,   12,   11, -578,  497,  603, -157, 1137,
			 -225, 1138,   63, -578,   12,   11,   70,  718,   68,  847,
			  409,  420, 1183,  222,  783,  562,  177,  563,  717,  567,
			  844,  664,  564,  989,  585,  424,  425, 1272,  468,  670,
			  342,  470,   53, 1271,  473,  476,  478,  409, -157,  409,
			  341,  866,  409,  409,  949,  482,  485,  487,  291, 1002,
			  451,  555,  453,  864,  879,  303,  290,   52,  458,  827,

			  459,  467,  863, 1264,  469, 1003,  710,  472,  475,  477,
			    6,    5, -341,    4,    3,  891,  -56,  826,  481,  484,
			  486,    6,    5,  825,    4,    3, 1004,  791,  320, -341,
			  304, 1180, 1179,  295,  824,  490,  346,  492,  493,  724,
			 1185,  725, 1192,  726,  -56,   12,   11,   70, 1191,  547,
			  823,  370, 1262,  161,  364,  370, 1148,  177,  364,  369,
			  998,  200,    2,  369,    1, 1190, -136,  358,  -56, -136,
			  -56,  358,  363, 1147,  373,  199,  363, 1257,  373,  997,
			  164,  372,  367,  512, -136,  372,  367,  534,  291, 1256,
			  523,  524,  525, 1080,  527, -124,  290,  366,   52,  565, yyDummy>>,
			1, 200, 200)
		end

	yytable_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  533,  366,  536,  344, -348,  339,  537,  289,  463, 1241,
			 1246, 1249,  138, 1255, 1099,  288, -124,  549,  461, -136,
			  381, -348,    6,    5, -136,    4,    3, -136,  359,  792,
			 -124, 1098,  359,  570, 1238, -124,  572,  843, -124, 1235,
			  370,  702,  575,  364, 1230,  577,  846, 1185,  369, 1221,
			  300,  375,  820, 1217,  640,  375,  358,  297,  627,  848,
			  289,  363, 1216,  373, 1215,  668,  569,  613,  288,  571,
			  372,  367,  374,  839,  785,  574,  374,  244,  576,  573,
			 -225,  630,   12,   11, -190, 1214,  366,  138,  624,  129,
			  128,  127,  224,  223,  579, 1213,  845,  124, -225,  586,

			  158,  255, -190,  586, -225, 1219, 1218,  252, -190,  319,
			  169, 1133, -225,  821, 1201, -225,  300,  359,  761, -190,
			  167,  299, 1023,  297, 1104,  710,  168, 1204,  612,  614,
			 1203, -225,  169,  619,  409, -190, 1198,  760, 1199, 1178,
			  375,  409,  243, 1100,  303,  899, 1177,  -70,  168,  716,
			  955,  764,  529,  759,  685,   12,   11, 1165,  912,    6,
			    5,  374,    4,    3,  129,  128,  127,  224,  223,   19,
			  -70, 1164,  124, 1162,  370,  -70,  968,  364,  465, 1043,
			  720,  529,  369, 1154,  659, 1141,  138,  137,  586, 1127,
			  358,  795,  796,  797,  381,  363,  667,  373,  512,  -70, yyDummy>>,
			1, 200, 400)
		end

	yytable_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 1205,  -70, -410, 1152,  372,  367, 1260,  674,  673, 1263,
			  346, 1219, 1218,  716,  715, -410,  952,  687, -172,  509,
			  366,  811,  300,  811,  809, -410,  809,  299,  901,  810,
			 -410,  810,    6,    5,  894,    4,    3,  806,  304,  806,
			 1107, 1106,  808,  903,  808,  132, 1084, 1110,  548,  988,
			 1076,  359, -227, 1074, -410, 1073, -410,  483,  346,  592,
			  265,   75, 1071,  129,  128,  127,  224,  223,  764, -408,
			  870,  124,  871, 1068,  375, 1065,  687,  255,  254,  733,
			 1009,  731, -408,  252,  251,  463,  462,  381, 1067,  812,
			  890,  812, -408,  624,  774,  374, 1064, -408, 1053,   12,

			   11, 1052,  461,  460, 1153, 1233, 1234, 1155,  253,  256,
			  752,  422,   12,   11, -227, 1031, -227,  421,  579,  913,
			  757, -408,  586, -408,  177, -227,  900,  768,  138,  137,
			  871, 1012, -227, 1029, 1014,  -25, 1043, 1007, -227,  264,
			   10,  996,  991,  780,  496,  263, -227, -227,  225, -227,
			 -225,  851,    9, 1126,  976, -227,  182,    8, -227,    7,
			 -227, -227, -161,  902,  904, -227,  954,  333, -227,  896,
			 -227, -227, -225, -325,  -23,  815,    6,    5,  133,    4,
			    3,    2,  886,    1,  346, -225, -225,  132,  822,    6,
			    5,  888,    4,    3,  882,  660, -225,  -25,  814,  -25, yyDummy>>,
			1, 200, 600)
		end

	yytable_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  -25,  -25,  801,  840,  538,  129,  128,  127,  224,  223,
			  869,  -25,  856,  124,  834,  -25,  833,  161,  603,  -25,
			  842,  -25,  329,  331,  164,  786,  799,  788,  400,  -25,
			  781,  -25,  -25,  946,  858,  682,  -23,  -25,  -23,  -23,
			  -23,  744,   12,   11,  727,  754,  -14,  877,  -25,  871,
			  -23,  742,  881,  883,  -23,  753,  138,  137,  -23,  739,
			  -23, -588,  709,  708,  892,  230,  303,  496,  -23,  -14,
			  -23,  -23,  904,  166,  -14,   57,  -23,  707,   55,  161,
			  706,  937,  332,  705,  546,  228,  903,  -23,  902,  700,
			  695,  901,  691,  688,  900,  200,  960,  681,  -14, 1018,

			  -14, 1021,  964,  964,  966,  964,  969,  679,  662,  495,
			  397, 1122,  658,  980,  666,  132,  -17,  651,  227,    6,
			    5,  639,    4,    3,  993,  994,  995,  480,  638,  197,
			  196,  632,  636,  129,  128,  127,  224,  223, -165, 1046,
			  597,  124,  195,  194,  271,  270,  269,  268,  267,  266,
			  265,   75,  600,  946,  169,  578,  169,  582,  581,  554,
			 1015,  553,  535, 1017,  243,  528,  243,   12,   11,  541,
			  168,   68,  168,   12,   11,  522,  509,  503,  -17,  177,
			  -17,  -17,  -17,  502, 1037, 1039,  499, 1045,  339,  488,
			  479, 1045,  -17,  414,  287,  457,  -17,   91, -174,  364, yyDummy>>,
			1, 200, 800)
		end

	yytable_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  -17,  937,  -17,  412,  413,  328,   57,  405,  402,   55,
			  -17, -428,  -17,  -17,  399,  177,  394,  363,  -17,  390,
			   52, 1130,  387,  338,  385, 1077,  337,  367,  964,  -17,
			  295,  294,  495, 1086, 1088,  175,  176,  262,  180,  249,
			  239,  245,  366,  222,    6,    5, 1045,    4,    3,  221,
			    6,    5, 1045,    4,    3, 1018, 1021,   -7,  247,  248,
			  723,  250, 1267,  867,  169,  257,  259,  261,  608,  364,
			  364,  686,  364, 1181,  167, 1117,  169,  755,  287,  287,
			  168,  986,  897,  287,  672,  292,  243,  363,  363, 1161,
			  363,  964,  168,  964, 1115,  958, 1186,  367,  367,  876,

			  367,  782, 1144, 1059, 1268, 1150,  364, 1231,  584,  868,
			  169,  169,  366,  366,  908,  366,  907, 1030, 1015,  906,
			  243,  243, 1116,  -17,  363,  814,  168,  168, 1159, 1211,
			  378, 1210,  602, 1160,  367, 1266, 1171, 1130,  748,  771,
			 1175,  -17, 1239, 1243, 1182,  977, 1252,  -17, 1125,  366,
			  287,  287,  779,  287, 1259,  -17, 1139,  -17,  -17, 1232,
			  287, 1188,  287,  -17,  287, 1242, 1186, 1250, 1105, 1186,
			  992,  767,  322,   22,  -17,  518,  635,  591, 1169,  494,
			 1181,   21,  506,  816,  987,  634,  -15,  721,  885,  775,
			    0,    0,  169,    0,    0,  287,    0,    0,  138,  137, yyDummy>>,
			1, 200, 1000)
		end

	yytable_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,  243, 1186,  -15,  490,  490,    0,  168,    0,
			  -15,    0,    0, 1240, 1244, 1247,    0, 1253,  -15,    0,
			  -15,  -15,  352,    0,    0,  379,  -15,  269,  268,  267,
			  266,  265,   75,    0,    0,  388,    0,  -15,   22,    0,
			  770,  769,    1,    0,    0,    0,    0,    0,    0,    0,
			    0, 1182,  426,  427,  428,  429,  430,  431,  432,  433,
			  434,  435,  436,  437,  438,  439,  440,  442,  443,  445,
			  446,  447,  448,  449,  450,  129,  128,  127,  224,  223,
			    0,    0,    0,  124,    0,    0,    0,    0,  138,  137,
			    0,  286,  285,  284,  855,  283,  282,  281,  280,  279,

			  278,  277,  276,  275,  274,  273,  272,  271,  270,  269,
			  268,  267,  266,  265,   75,  498,    0,    0,  287,    0,
			  884,    0,  138,  137,    0,    0,    0,    0,    0,  287,
			  287,  287,  287,  287,  287,  287,  287,  287,  287,  287,
			  287,  287,  287,  287,    0,  287,  287,  132,  287,  287,
			  287,  287,  287,  287,  -19,  520,  953,    0,    0,  474,
			    0,  392,    0,    0,    0,  129,  128,  127,  224,  223,
			  511,    0,    0,  124,    0,    0,    0,    0,    0,    0,
			  526,  132,    0,    0,    0,  985,    0,    0,    0,    0,
			    0,    0,    0,  543,    0,    0,    0,    0,    0,  129, yyDummy>>,
			1, 200, 1200)
		end

	yytable_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  128,  127,  224,  223,  391,   12,   11,  124,  556,  557,
			    0,    0,  500,    0,  287,    0,  -19,  177,  -19,  -19,
			  -19,    0,    0,  504,    0,  138,  137,    0,  560,  287,
			  -19,  561,  319,    0,  -19,    0,    0,    0,  -19,  226,
			  -19,    0,  508,    0,    0,  225,  287,    0,  -19,    0,
			  -19,  -19,  566,    0, 1042,    0,  -19,    0,    0,  287,
			  287,    0,    0,  287,  287,    0,    0,  -19,    0,  287,
			  588,    0, 1061,    0,    0,  133,    0,  594,  551,  552,
			  -65,  -65,    6,    5,  132,    4,    3,    0,    0,    0,
			    0,    0,  138,  137,    0,    0,    0,    0,    0,  615,

			    0,    0,  129,  128,  127,  224,  223,    0, 1103,  609,
			  124,    0,  287,  -65,    0, 1109,  -65,    0,  637,    0,
			  618,  287,    0,  622,    0,  287,  286,  285,  284,    0,
			  283,  282,  281,  280,  279,  278,  277,  276,  275,  274,
			  273,  272,  271,  270,  269,  268,  267,  266,  265,   75,
			    0,  132,  287,  287,  649,  650,    0,  -65,  -65,    0,
			  -65,  -65,    0,  471,    0,    0, 1143,    0,    0,  129,
			  128,  127,  224,  223,  287,    0,  599,  124,    0,    0,
			    0,    0, 1158,  287,  671,  511,    0,    0,    0,    0,
			    0,    0,    0,    0,  616,    0,    0,  680,    0,    0, yyDummy>>,
			1, 200, 1400)
		end

	yytable_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  699,  287,    0,    0,  287,    0,    0,  633,    0,    0,
			    0,    0,    0,    0,    0, 1189,    0,  641,  698,  714,
			  644,  645,    0,  701,  646,  647,  648,    0,  -64,  -64,
			  722,  710,    0,    0,    0,    0,    0,    0,  287,  287,
			 1023,    0,  652,    0,    0, 1212,    0,    0,    0,    0,
			    0,  737,  287,  287,  287,    0,    0,    0, 1222,  741,
			    0,  -64,    0, 1226,  -64, 1228, 1229,    0,  735,  736,
			    0,    0,    0,    0,    0,    0,    0,  138,  137,  689,
			  690,    0,    0,  756,    0,  758,  543,  693,    0,    0,
			  749,  750,    0,    0,    0, 1261,    0,  751,    0,    0,

			  138,  137,    0,  355,  354,  -64,  -64,    0,  -64,  -64,
			    0,  793,  137,    0,    0,    0,    0,   12,   11,   70,
			   69,   68,  287,    0, 1269,  136, 1270,    0,  622,  177,
			    0,  135,  353,    0,  287,    0,  132,    0,    0,   62,
			   61,    0,  134,    0,    0,    0,  738,    0,  325,    0,
			    0,    0,  740,    0,  129,  128,  127,  324,  323,  132,
			    0,  133,  124,    0,    0,  819,    0,  836,    0,    0,
			  132,  314,    0,    0,    0,  831,    0,  129,  128,  127,
			  313,  312,  131,    0,    0,  124,  130,    0,  129,  128,
			  127,  126,  125,    0,    6,    5,  124,    4,    3,    0, yyDummy>>,
			1, 200, 1600)
		end

	yytable_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,  859,    0,   47,   46,   45,   44,   43,   42,   41,
			   40,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  286,  285,  284,
			  898,  283,  282,  281,  280,  279,  278,  277,  276,  275,
			  274,  273,  272,  271,  270,  269,  268,  267,  266,  265,
			   75,    0,  837,  654,  137,    0,  774,    0,    0,  653,
			    0,    0, -192,    0,    0,    0,    0,  136, -114,    0,
			    0, -192, -114,  135,    0,    0,  287,  287,  138,  137,
			    0, -114, -114,    0,  134,    0,    0,    0, -192, -192,

			 -192, -114,  983,  984, -114,    0, -114,  878, 1001, -192,
			  880,    0, -192,  133,    0,    0,    0,    0,    0,    0,
			 -192,    0,  132, 1010,    0, -192, -192, -192,    0,    0,
			 -114,    0, -114,    0,  131,    0,    0,  910,  130, 1258,
			  129,  128,  127,  126,  125,    0,    0,  328,  124,    0,
			  138,  137,  287,  287,    0,    0,    0,  287,  287,  287,
			  287,  287,  862,  287,  861,  129,  128,  127,  224,  223,
			  860,    0,    0,  124,  981, 1063, 1049, 1050,  138,  137,
			    0,  134,    0, 1054, 1055, 1056, 1057, 1058,    0,    0,
			 1060,    0, 1078,   12,   11,    0,    0,    0,  287,    0, yyDummy>>,
			1, 200, 1800)
		end

	yytable_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,    0, 1093,    0,    0,    0,    0,    0,  132,
			 1006,    0, 1008,    0,    0,  287,    0, 1043, 1011,    0,
			    0,  131,    0,    0, 1095,  130,    0,  129,  128,  127,
			  126,  125,    0,  654,  137,  124, 1118,  132,    0, 1120,
			 1112, 1121,    0,    0,    0,    0,    0,  136,    0,  309,
			    0,    0,  328,  135,  287,  129,  128,  127,  224,  223,
			    0,    0,    0,  124,  134,  138,  137,    0,    0, 1145,
			    6,    5,    0,    4,    3,    0,    0,    0, 1069,  136,
			    0, 1072,    0,  133, 1075,  135,    0, 1079,    0,  138,
			  137, 1151,  132,    0,    0,    0,  134,    0, 1094,  287,

			    0,    0,    0, 1173,  131,    0,    0,    0,  130, 1176,
			  129,  128,  127,  126,  125,  133,    0,    0,  124,    0,
			    0,    0,    0,    0,  132,    0,  287,    0,    0,    0,
			 1200,    0, 1119, 1202,    0,    0,  131,    0,    0, 1196,
			  130,    0,  129,  128,  127,  126,  125,    0,  132,    0,
			  124,    0,    0,    0,    0,    0,    0,    0,    0, 1142,
			  306, 1224,    0, 1095, 1146,    0,  129,  128,  127,  224,
			  223,    0,    0,    0,  124,    0, 1236,    0,    0, 1223,
			   80,   79,   78,    0, 1251,    0, 1163,    0,    0,    0,
			    0,    0,    0, 1168,    0,    0,   77,   76, 1174,    0, yyDummy>>,
			1, 200, 2000)
		end

	yytable_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,    0,   75,   74,   73,   72,    0,   71,    0,
			   12,   11,   70,   69,   68,   67,    0,    0,   66,   65,
			    0,    0,   64,    0,   63,  346,    0,    0,    0,    0,
			    0,    0,   62,   61,   60,    0,    0,   59,    0,   58,
			    0,    0,    0,   57,    0,   56,   55,   54,    0, 1220,
			    0,    0,  669,    0,   53,    0, 1225,    0,    0,    0,
			    0,    0,    0,   52,    0,   51,    0,    0,    0,    0,
			    0, 1237,    0,    0,   50,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   49,    5,    0,
			   48,    3,    0,    0,    0,    0,   47,   46,   45,   44,

			   43,   42,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   80,   79,   78,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   77,   76,    0,
			    0,    0,    0,    0,   75,   74,   73,   72,    0,   71,
			    0,   12,   11,   70,   69,   68,   67,    0,    0,   66,
			   65,    0,    0,   64,    0,   63,    0,    0,    0,    0,
			    0,  621,    0,   62,   61,   60,    0,    0,   59,    0,
			   58,    0,    0,    0,   57,    0,   56,   55,   54,   12,
			   11,    0,    0,    0,    0,   53,    0,    0,    0,    0, yyDummy>>,
			1, 200, 2200)
		end

	yytable_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,    0,    0,   52,    0,   51,    0,    0,    0,
			    0,    0,    0,  242,    0,   50,  241,    0,    0,    0,
			    0,    0,   57,    0,    0,   55,    0,    0,   49,    5,
			    0,   48,    3,    0,    0,    0,    0,   47,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   80,   79,   78,    0,    6,    5,    0,    4,
			    3,    0,    0,    0,    0,    0,    0,    0,   77,   76,
			    0,    0,    0,    0,    0,   75,   74,   73,   72,    0,
			   71,    0,   12,   11,   70,   69,   68,   67,    0,    0,

			   66,   65,    0,    0,   64,    0,   63,    0,    0,    0,
			    0, -194,    0,    0,   62,   61,   60,    0,    0,   59,
			 -194,   58,    0,    0,    0,   57,    0,   56,   55,   54,
			    0,    0,    0,    0,  510,    0,   53, -194, -194, -194,
			    0,    0,    0,    0,    0,   52,    0,   51, -194,    0,
			    0, -194,    0,    0,    0,    0,   50,    0,    0, -194,
			    0,    0,    0,    0, -194, -194, -194,    0,    0,   49,
			    5,    0,   48,    3,    0,    0,    0,    0,   47,   46,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26, yyDummy>>,
			1, 200, 2400)
		end

	yytable_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   25,   24,   23,   80,   79,   78,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   77,
			   76,    0,    0,    0,    0,    0,   75,   74,   73,   72,
			    0,   71,    0,   12,   11,   70,   69,   68,   67,    0,
			    0,   66,   65,    0,    0,   64,    0,   63,    0,    0,
			    0,    0,    0,    0,    0,   62,   61,   60,    0,    0,
			   59,    0,   58,    0,    0,    0,   57,    0,   56,   55,
			   54,    0,    0,    0,    0,    0,    0,   53,    0,    0,
			  444,    0,    0,    0,    0,    0,   52,    0,   51,    0,
			    0,    0,    0,    0,    0,    0,    0,   50,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   49,    5,    0,   48,    3,    0,    0,    0,    0,   47,
			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   80,   79,   78,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   77,   76,    0,    0,    0,    0,    0,   75,   74,   73,
			   72,    0,   71,    0,   12,   11,   70,   69,   68,   67,
			    0,    0,   66,   65,    0,    0,   64,    0,   63,    0,
			    0,    0,    0,    0,    0,    0,   62,   61,   60,    0, yyDummy>>,
			1, 200, 2600)
		end

	yytable_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,   59,    0,   58,    0,    0,    0,   57,    0,   56,
			   55,   54,    0,    0,    0,    0,    0,    0,   53,    0,
			    0,    0,    0,    0,    0,    0,    0,   52,    0,   51,
			    0,    0,    0,    0,    0,    0,    0,    0,   50,    0,
			    0,    0,    0,    0,    0,    0,  441,    0,    0,    0,
			    0,   49,    5,    0,   48,    3,    0,    0,    0,    0,
			   47,   46,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   80,   79,   78,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,   77,   76,    0,    0,    0,    0,    0,   75,   74,
			   73,   72,    0,   71,    0,   12,   11,   70,   69,   68,
			   67,    0,    0,   66,   65,    0,    0,   64,    0,   63,
			    0,    0,    0,    0,    0,    0,    0,   62,   61,   60,
			    0,    0,   59,    0,   58,    0,    0,    0,   57,    0,
			   56,   55,   54,    0,    0,    0,    0,    0,    0,   53,
			    0,    0,    0,    0,    0,    0,    0,    0,   52,    0,
			   51,    0,    0,    0,    0,    0,    0,    0,    0,   50,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   49,    5,    0,   48,    3,    0,    0,    0, yyDummy>>,
			1, 200, 2800)
		end

	yytable_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,   47,   46,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   80,   79,   78,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   77,   76,    0,    0,    0,    0,    0,   75,
			   74,   73,   72,    0,   71,    0,   12,   11,   70,   69,
			   68,   67,    0,    0,  542,   65,    0,    0,   64,    0,
			   63,    0,    0,    0,    0,    0,    0,    0,   62,   61,
			   60,    0,    0,   59,    0,   58,    0,    0,    0,   57,
			    0,   56,   55,   54,    0,    0,    0,    0,    0,    0,

			   53,    0,    0,    0,    0,    0,    0,    0,    0,   52,
			    0,   51,    0,    0,    0,    0,    0,    0,    0,    0,
			   50,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   49,    5,    0,   48,    3,    0,    0,
			    0,    0,   47,   46,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   80,   79,   78,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   77,   76,    0,    0,    0,    0,    0,
			   75,   74,   73,   72,    0,   71,    0,   12,   11,  255, yyDummy>>,
			1, 200, 3000)
		end

	yytable_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  254,   68,   67,    0,    0,   66,   65,    0,    0,  177,
			    0,   63,    0,    0,    0,    0,    0,    0,    0,   62,
			   61,   60,    0,    0,   59,    0,   58,    0,    0,    0,
			   57,    0,   56,   55,   54,    0,    0,    0,    0,    0,
			    0,   53,    0,    0,    0,    0,    0,    0,    0,    0,
			   52,    0,   51,    0,    0,    0,    0,    0,    0,    0,
			    0,   50,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   49,    5,    0,    4,    3,    0,
			    0,    0,    0,   47,   46,   45,   44,   43,   42,   41,
			   40,   39,   38,   37,   36,   35,   34,   33,   32,   31,

			   30,   29,   28,   27,   26,   25,   24,   23,   80,   79,
			   78,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   77,   76,    0,    0,    0,    0,
			    0,   75,   74,   73,   72,    0,   71,    0,   12,   11,
			  252,  251,   68,   67,    0,    0,   66,   65,    0,    0,
			  177,    0,   63,    0,    0,    0,    0,    0,    0,    0,
			   62,   61,   60,    0,    0,   59,    0,   58,    0,    0,
			    0,   57,    0,   56,   55,   54,    0,    0,    0,    0,
			    0,    0,   53,    0,    0,    0,    0,    0,    0,    0,
			    0,   52,    0,   51,    0,    0,    0,    0,    0,    0, yyDummy>>,
			1, 200, 3200)
		end

	yytable_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,   50,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   49,    5,    0,    4,    3,
			    0,    0,    0,    0,   47,   46,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   80,
			   79,   78,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   77,   76,    0,    0,    0,
			    0,    0,   75,   74,   73,   72,    0,   71,    0,   12,
			   11,   70,   69,   68,   67,    0,    0,   66,   65,    0,
			    0,  174,    0,   63,    0,    0,    0,    0,    0,    0,

			    0,   62,   61,   60,    0,    0,   59,    0,   58,    0,
			    0,    0,   57,    0,   56,   55,   54,    0,    0,    0,
			    0,    0,    0,   53,    0,    0,    0,    0,    0,    0,
			    0,    0,   52,    0,   51,    0,    0,    0,    0,    0,
			    0,    0,    0,   50,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   49,    5,    0,   48,
			    3,    0,    0,    0,    0,   47,   46,   45,   44,   43,
			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			  926,  925,  924,    0,    0,    0,    0,    0,    0,    0, yyDummy>>,
			1, 200, 3400)
		end

	yytable_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,  355,  354,  236,  235,
			    0,    0,    0,    0,    0,    0,    0,    0,   71,    0,
			   12,   11,  136,    0,   68,   67,    0,    0,  135,    0,
			    0,    0,  177,    0,  923,    0,    0,    0,    0,  134,
			    0,    0,   62,   61,  922,  921,    0,   59,    0,    0,
			    0,    0,    0,   57,    0,   56,   55,    0,  133,    0,
			    0,  920,    0,    0,  919,  918,    0,  132,    0,    0,
			    0,    0,    0,   52,  917,  916,    0,  915,    0,  131,
			    0,    0,    0,  130,   50,  234,  233,  127,  232,  231,
			    0,  914,    0,  124,    0,    0,    0,   49,    5,    0,

			    4,    3,    0,    0,    0,    0,   47,   46,   45,   44,
			   43,   42,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,  355,  354,    0,    0,    0,    0,    0,    0,  138,
			  137,    0,    0,    0,    0,   12,   11,   70,   69,   68,
			    0,    0,    0,  861,    0,    0,    0,  177,    0,  860,
			  355,  354,    0,    0,    0,    0,    0,   62,   61,    0,
			  134,    0,    0,    0,    0,    0,   70,   69,  804,  280,
			  279,  278,  277,  276,  275,  274,  273,  272,  271,  270,
			  269,  268,  267,  266,  265,   75,   62,   61,  132,    0, yyDummy>>,
			1, 200, 3600)
		end

	yytable_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  803,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  131,    0,    0,    0,  130,    0,  129,  128,  127,  126,
			  125,    0,    6,    5,  124,    4,    3,    0,    0,    0,
			    0,   47,   46,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,    2,    0,    1,    0,
			   47,   46,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,  355,  354,    0,    0,  631,
			    0,   12,   11,    0,    0,    0,    0,    0,    0,    0,

			    0,   70,   69,  804,    0,    0,    0,    0,    0,    0,
			    0,    0,  302,  301,    0,  242,    0,    0,  241,    0,
			    0,   62,   61,  300,   57,  803,    0,   55,  299,  298,
			  297,    0,    0,    0,    0,  296,    0,  302,  301,    0,
			    0,    0,    0,    0,    0,    0,  692,    0,  300,    0,
			    0,    0,    0,  299,  298,  297,    0,    0,    0,    0,
			  296,    0,  302,  301,    0,    0,    0,    0,    6,    5,
			    0,    4,    3,  300,    0,    0,    0,    0,  299,  298,
			  297,    0,    0,    0,    0,   47,   46,   45,   44,   43,
			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33, yyDummy>>,
			1, 200, 3800)
		end

	yytable_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			    0,    0,   47,   46,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   47,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   47,   46,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,  302,  301,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,  299,  298,  297,    0,    0,    0,    0,
			    0,  286,  285,  284,    0,  283,  282,  281,  280,  279,
			  278,  277,  276,  275,  274,  273,  272,  271,  270,  269,
			  268,  267,  266,  265,   75,  286,  285,  284,    0,  283,
			  282,  281,  280,  279,  278,  277,  276,  275,  274,  273,
			  272,  271,  270,  269,  268,  267,  266,  265,   75,    0,
			  286,  285,  284,    0,  283,  282,  281,  280,  279,  278,
			  277,  276,  275,  274,  273,  272,  271,  270,  269,  268,
			  267,  266,  265,   75,    0,    0,    0,   47,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35, yyDummy>>,
			1, 200, 4000)
		end

	yytable_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23, -575, 1040,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  838,    0,    0,  346, -575,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  778,    0,    0,
			    0,  -72,    0,    0,    0,  -72,  138,  137,    0,    0,
			    0, -575, -575,    0,  -72,  -72,    0, -575,    0, -575,
			 -575, -575,  393, -575,  -72,    0,    0,  -72,    0,  -72,
			    0,    0,    0,    0, -575,    0, -575, -575,    0, -575,
			    0,    0, -575,    0,    0,    0,    0,    0,    0,    0,
			 -575,    0, -575,  -72,    0,  -72,    0,    0, -575, -575,

			 -576,    0,    0,    0, -575,  132, -575,    0, -575, -575,
			    0,    0,    0, -575, -575, -576,    0,  309,    0,    0,
			    0,    0,    0,  129,  128,  127,  224,  223, -575, -575,
			 -575,  124,    0,    0,  138,  137,    0,    0,    0, -576,
			 -576,    0,    0,    0,    0, -576,    0, -576, -576, -576,
			    0, -576,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0, -576,    0, -576, -576,    0, -576,    0,    0,
			 -576,    0,    0,    0,    0,    0,    0,    0, -576,    0,
			 -576,    0,    0,    0,    0,    0, -576, -576, -571,    0,
			    0,    0, -576,  132, -576,    0, -576, -576,    0,    0, yyDummy>>,
			1, 200, 4200)
		end

	yytable_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0, -576, -576, -571,    0,  306,    0,    0,    0,    0,
			    0,  129,  128,  127,  224,  223, -576, -576, -576,  124,
			    0,    0, -571, -571,    0,    0,    0, -571, -571,    0,
			    0,    0,    0, -571,    0, -571, -571, -571,    0, -571,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			 -571,    0, -571, -571,    0, -571,    0,    0, -571,    0,
			    0,    0,    0,    0,    0,    0, -571,    0, -571,    0,
			    0,    0,    0, -572, -571, -571,    0,    0,    0,    0,
			 -571,    0, -571,    0, -571, -571,    0,    0, -572, -571,
			 -571,    0,    0,    0,    0,    0,    0,    0,    0, -571,

			 -571, -571, -571, -571, -571, -571, -571, -572, -572,    0,
			    0,    0, -572, -572,    0,    0,    0,    0, -572,    0,
			 -572, -572, -572,    0, -572,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0, -572,    0, -572, -572,    0,
			 -572,    0,    0, -572,    0,    0,    0,    0,    0,    0,
			    0, -572,    0, -572,    0,    0,    0,    0, -573, -572,
			 -572,    0,    0,    0,    0, -572,    0, -572,    0, -572,
			 -572,    0,    0, -573, -572, -572,    0,    0,    0,    0,
			    0,    0,    0,    0, -572, -572, -572, -572, -572, -572,
			 -572, -572, -573, -573,    0,    0,    0, -573, -573,    0, yyDummy>>,
			1, 200, 4400)
		end

	yytable_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,    0, -573,    0, -573, -573, -573,    0, -573,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			 -573,    0, -573, -573,    0, -573,    0,    0, -573,    0,
			    0,    0,    0,    0,    0,    0, -573,    0, -573,    0,
			    0,    0,    0, -300, -573, -573,    0,    0,    0,    0,
			 -573,    0, -573,    0, -573, -573,    0,    0, -300, -573,
			 -573,    0,    0,    0,    0,    0,    0,    0,    0, -573,
			 -573, -573, -573, -573, -573, -573, -573, -300, -300,    0,
			    0,    0,    0, -300,    0,    0,    0,    0, -300,    0,
			 -300, -300, -300,  177, -300,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0, -300,    0, -300, -300,    0,
			 -300,    0,    0, -300,    0,    0,    0,    0,    0,    0,
			    0, -300,    0, -300,    0,    0,    0,    0,    0, -300,
			 -300,    0,    0,    0,    0, -300,    0, -300,    0, -300,
			 -300,    0,    0,    0, -300, -300,    0,    0,    0,    0,
			    0,    0,    0,    0, -300, -300, -300, -300, -300, -300,
			 -300, -300,    0,    0,    0,    0,    0,   47,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,  286,  285,  284,    0,  283,  282,  281,  280, yyDummy>>,
			1, 200, 4600)
		end

	yytable_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  279,  278,  277,  276,  275,  274,  273,  272,  271,  270,
			  269,  268,  267,  266,  265,   75,  286,  285,  284,    0,
			  283,  282,  281,  280,  279,  278,  277,  276,  275,  274,
			  273,  272,  271,  270,  269,  268,  267,  266,  265,   75,
			  187,    0,   12,   11,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  177,    0,    0,    0,    0,    0,
			    0,    0,  186,    0,    0,    0,  185,    0,    0,  184,
			    0,    0,    0,    0,    0,   57,    0,    0,   55,    0,
			  286,  285,  284, 1227,  283,  282,  281,  280,  279,  278,
			  277,  276,  275,  274,  273,  272,  271,  270,  269,  268,

			  267,  266,  265,   75,    0,    0,    0, 1195,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    6,
			    5,    0,    4,    3,  279,  278,  277,  276,  275,  274,
			  273,  272,  271,  270,  269,  268,  267,  266,  265,   75,
			 -346,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  286,  285,  284, -346,  283,  282,
			  281,  280,  279,  278,  277,  276,  275,  274,  273,  272,
			  271,  270,  269,  268,  267,  266,  265,   75,  286,  285,
			  284,    0,  283,  282,  281,  280,  279,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266, yyDummy>>,
			1, 200, 4800)
		end

	yytable_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  265,   75,  286,  285,  284,    0,  283,  282,  281,  280,
			  279,  278,  277,  276,  275,  274,  273,  272,  271,  270,
			  269,  268,  267,  266,  265,   75,    0,    0,    0,    0,
			    0,  610,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0, 1140,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  286,
			  285,  284,  777,  283,  282,  281,  280,  279,  278,  277,
			  276,  275,  274,  273,  272,  271,  270,  269,  268,  267,
			  266,  265,   75,  286,  285,  284,    0,  283,  282,  281,
			  280,  279,  278,  277,  276,  275,  274,  273,  272,  271,

			  270,  269,  268,  267,  266,  265,   75,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  734,
			    0,    0,    0,    0,    0,    0,    0,    0,  286,  285,
			  284,  643,  283,  282,  281,  280,  279,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,   75,  286,  285,  284,    0,  283,  282,  281,  280,
			  279,  278,  277,  276,  275,  274,  273,  272,  271,  270,
			  269,  268,  267,  266,  265,   75,  642,  282,  281,  280,
			  279,  278,  277,  276,  275,  274,  273,  272,  271,  270,
			  269,  268,  267,  266,  265,   75,  286,  285,  284,  550, yyDummy>>,
			1, 200, 5000)
		end

	yytable_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  283,  282,  281,  280,  279,  278,  277,  276,  275,  274,
			  273,  272,  271,  270,  269,  268,  267,  266,  265,   75,
			  281,  280,  279,  278,  277,  276,  275,  274,  273,  272,
			  271,  270,  269,  268,  267,  266,  265,   75,  286,  285,
			  284,  346,  283,  282,  281,  280,  279,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,   75,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  286,  285,  284,  747,
			  283,  282,  281,  280,  279,  278,  277,  276,  275,  274,
			  273,  272,  271,  270,  269,  268,  267,  266,  265,   75,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  286,  285,  284,  418,  283,  282,
			  281,  280,  279,  278,  277,  276,  275,  274,  273,  272,
			  271,  270,  269,  268,  267,  266,  265,   75,    0,    0,
			    0,    0,    0, 1156,   47,   46,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   47,
			    0,   45,    0,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23, -32768,  285,  284,    0,  283,  282, yyDummy>>,
			1, 200, 5200)
		end

	yytable_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  281,  280,  279,  278,  277,  276,  275,  274,  273,  272,
			  271,  270,  269,  268,  267,  266,  265,   75,  286,  285,
			  284,    0,  283,  282,  281,  280,  279,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,   75,  219,  218,  217,  216,  215,  214,  213,  212,
			  211,  210,  209,  208,  207,  206,  205,  204,  203,  517,
			  202,  516,  515,  283,  282,  281,  280,  279,  278,  277,
			  276,  275,  274,  273,  272,  271,  270,  269,  268,  267,
			  266,  265,   75,  219,  218,  217,  216,  215,  214,  213,
			  212,  211,  210,  209,  208,  207,  206,  205,  204,  203,

			    0,  202, yyDummy>>,
			1, 102, 5400)
		end

	yycheck_template: SPECIAL [INTEGER]
			-- Template for `yycheck'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 5501)
			yycheck_template_1 (an_array)
			yycheck_template_2 (an_array)
			yycheck_template_3 (an_array)
			yycheck_template_4 (an_array)
			yycheck_template_5 (an_array)
			yycheck_template_6 (an_array)
			yycheck_template_7 (an_array)
			yycheck_template_8 (an_array)
			yycheck_template_9 (an_array)
			yycheck_template_10 (an_array)
			yycheck_template_11 (an_array)
			yycheck_template_12 (an_array)
			yycheck_template_13 (an_array)
			yycheck_template_14 (an_array)
			yycheck_template_15 (an_array)
			yycheck_template_16 (an_array)
			yycheck_template_17 (an_array)
			yycheck_template_18 (an_array)
			yycheck_template_19 (an_array)
			yycheck_template_20 (an_array)
			yycheck_template_21 (an_array)
			yycheck_template_22 (an_array)
			yycheck_template_23 (an_array)
			yycheck_template_24 (an_array)
			yycheck_template_25 (an_array)
			yycheck_template_26 (an_array)
			yycheck_template_27 (an_array)
			yycheck_template_28 (an_array)
			Result := yyfixed_array (an_array)
		end

	yycheck_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			    0,   66,   50,  166,   52,   63,   54,    2,  412,    7,
			  343,    9,   22,  161,  182,  378,  161,   13,   16,   17,
			   18,  161,   22,   50,  676,   63,  135,  136,   22,  161,
			  650,  199,  351,  304,  161,  164,  161,  606,  581,   99,
			  120,  499,   54,  161,  161,  534,  825,  155,  376,  834,
			  246,  901, 1034,  903,   54,  581,   66,  608,   63,  161,
			 1005,  834, 1033, 1034,   64,  881,   66,   65,   64,   67,
			  834,  881,   66,  626,    0,   64,   50,  881,   78,   79,
			  503,  881,    0,  881,  132,  881,  881,  125,  126,  898,
			  161,  971,  130,  131,   64,  973,  134,  135,  136,  179,

			  947,    3,   73,   64,  883,    0,   64,  892,    0,  678,
			   99,   64,  991,  161,    0,  104,  225,  226,  107,  892,
			  125,  126,  675,  222,   95,  130,  131,   68,  892,  134,
			   45,   92,  132,  103,  161,  183,   62,   78,  985,   41,
			  629,   99,  140,  117,   62, 1144,  104,   65,  119, 1027,
			 1030,   64,   32,  106,   80,  116,  166,  118,  158,  728,
			   86,  161,   49,  262,  164,  588,  166, 1046, 1113,   64,
			   50,   97,  166, 1052,  174,  343, 1026,   64,  174,  732,
			  508,  177,  510,  511,   47, 1001,   39,  113, 1170,  187,
			  289, 1001,  291,  231,  232,  294,  295, 1001,   64, 1170, yyDummy>>,
			1, 200, 0)
		end

	yycheck_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  769, 1001,  200, 1001,   32, 1001, 1001, 1085, 1017,  221,
			  222,   64,   99,   73, 1061, 1214, 1215,  104, 1217,  772,
			  107,  116,   50,  118,  775,    3,  231,  232,  424,  425,
			   20,   21,  758,   34,   35,   39,  344,  117,   64, 1089,
			  106, 1091,   48,   47,   34,   35,   36,   40,   38,  818,
			  262,  249, 1251,   31,  743,  451,   46,  453,   51,  119,
			  813,  589,  458,   41,  722,  263,  264,   64,  306,  597,
			   66,  309,   78,   64,  312,  313,  314,  289,  104,  291,
			   76, 1066,  294,  295, 1063,  323,  324,  325,   31,  941,
			  288,  420,  290, 1066,  847,  375,   39,   87,  296,   62,

			  300,  306, 1066,   47,  309,    3,  109,  312,  313,  314,
			  111,  112,   64,  114,  115,  858,   64,   80,  323,  324,
			  325,  111,  112,   86,  114,  115,   88,   40,  328,   81,
			   92,   20,   21,   31,   97,  333,   49,  337,  338,  667,
			 1144,  669,   82,  671,   92,   34,   35,   36,   64,  409,
			  113,  499,   55,  351,  499,  503,   64,   46,  503,  499,
			    3,   32,  116,  503,  118,   81,   46,  499,  116,   49,
			  118,  503,  499,   81,  499,   46,  503,   64,  503,    3,
			  378,  499,  499,  383,   64,  503,  503,  399,   31,  106,
			  390,  391,  392,   73,  394,   64,   39,  499,   87,  459, yyDummy>>,
			1, 200, 200)
		end

	yycheck_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  398,  503,  400,   84,   64,   86,  402,   31,   36, 1213,
			 1214, 1215,   34, 1217,   64,   39,   85,  413,   36,   99,
			  420,   81,  111,  112,  104,  114,  115,  107,  499,  757,
			   99,   81,  503,  471,   64,  104,  474,  807,  107,   64,
			  588,  637,  480,  588,   64,  483,  816, 1251,  588,   64,
			   31,  499,  780,    7,  553,  503,  588,   38,  538,  822,
			   31,  588,   51,  588,    7,  594,  471,  527,   39,  474,
			  588,  588,  499,  801,  745,  480,  503,  542,  483,  479,
			   62,  541,   34,   35,   62,    7,  588,   34,  536,  111,
			  112,  113,  114,  115,  490,    7,  815,  119,   80,  499,

			  498,   36,   80,  503,   86,   20,   21,   36,   86,   61,
			  520,   87,   94,  784,   47,   97,   31,  588,   65,   97,
			  520,   36,   46,   38,  108,  109,  520,   46,  526,  529,
			   46,  113,  542,  533,  546,  113,   95,   84, 1158,   64,
			  588,  553,  542,  110,  624,  873,   80,   64,  542,   50,
			   51,  719,   31,  100,  614,   34,   35,   51,  877,  111,
			  112,  588,  114,  115,  111,  112,  113,  114,  115,   92,
			   87,   64,  119,   51,  722,   92,  904,  722,  108,   58,
			  660,   31,  722,   64,  582,   51,   34,   35,  588,   64,
			  722,  759,  760,  761,  594,  722,  592,  722,  598,  116, yyDummy>>,
			1, 200, 400)
		end

	yycheck_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			 1169,  118,   64,  108,  722,  722, 1226,  605,  604, 1229,
			   49,   20,   21,   50,   51,   77,  887,  615,   50,   51,
			  722,  769,   31,  771,  769,   87,  771,   36,  104,  769,
			   92,  771,  111,  112,   78,  114,  115,  769,   92,  771,
			 1044,   64,  769,   99,  771,   93,   64, 1051, 1052,  920,
			   47,  722,    0,   74,  116,   51,  118,  105,   49,   50,
			   26,   27,   51,  111,  112,  113,  114,  115,  836,   64,
			  838,  119,  840,   51,  722,   47,  674,   36,   37,  679,
			  951,  677,   77,   36,   37,   36,   37,  687,   64,  769,
			   34,  771,   87,  741,   49,  722,   45,   92,   50,   34,

			   35,   48,   36,   37, 1108, 1203, 1204, 1111,   76,   77,
			  710,   50,   34,   35,   62,   77,   64,   50,  714,   64,
			  716,  116,  722,  118,   46,   73,  107,  727,   34,   35,
			  898,   51,   80,   64,   64,    0,   58,   51,   86,   39,
			   75,    3,   48,  739, 1077,   39,   94,   95,   54,   97,
			   73,   32,   87, 1081,   64,  103,   16,   92,  106,   94,
			  108,  109,   64,  101,   85,  113,   64,   39,  116,   47,
			  118,  119,   95,  101,    0,  770,  111,  112,   84,  114,
			  115,  116,  106,  118,   49,  108,  109,   93,  786,  111,
			  112,  103,  114,  115,   45,   72,  119,   62,   64,   64, yyDummy>>,
			1, 200, 600)
		end

	yycheck_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   65,   66,   90,  801,   96,  111,  112,  113,  114,  115,
			   40,   76,   83,  119,   53,   80,   51,  815,  117,   84,
			  116,   86,  860,  861,  822,   94,   51,   50,   32,   94,
			   45,   96,   97,  881,  832,   82,   62,  102,   64,   65,
			   66,   81,   34,   35,  112,   64,   64,  842,  113, 1017,
			   76,   45,  850,  851,   80,   64,   34,   35,   84,   50,
			   86,   81,   44,   40,  862,  923,  946, 1200,   94,   87,
			   96,   97,   85,   65,   92,   67,  102,   40,   70,  877,
			   40,  881,  991,   40,   31,  923,   99,  113,  101,   45,
			  102,  104,   51,   45,  107,   32,  894,   81,  116,  964,

			  118,  966,  900,  901,  902,  903,  904,   74,   51, 1077,
			   45, 1074,   40,  911,   64,   93,    0,   51,  923,  111,
			  112,   40,  114,  115,  924,  925,  926,  105,   44,  128,
			  129,   51,   47,  111,  112,  113,  114,  115,   45,  987,
			   50,  119,  141,  142,   20,   21,   22,   23,   24,   25,
			   26,   27,   77, 1001,  964,   40,  966,   39,   39,   45,
			  960,   31,   45,  961,  964,   17,  966,   34,   35,   47,
			  964,   38,  966,   34,   35,   47,   51,   50,   62,   46,
			   64,   65,   66,   51,  982,  983,   50,  987,   86,   40,
			   31,  991,   76,   47,   91,   44,   80,   10,   45, 1144, yyDummy>>,
			1, 200, 800)
		end

	yycheck_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   84, 1001,   86,   48,   50,   93,   67,   45,   50,   70,
			   94,   31,   96,   97,   31,   46,   31, 1144,  102,   74,
			   87, 1086,   51,   31,   72, 1023,   31, 1144, 1026,  113,
			   31,   31, 1200, 1031, 1032,   48,   49,   31,   51,   32,
			   44,   40, 1144,   31,  111,  112, 1046,  114,  115,   31,
			  111,  112, 1052,  114,  115, 1120, 1121,    0,   71,   72,
			  666,   74, 1237,  834, 1074,   78,   79,   80,  521, 1214,
			 1215,  615, 1217, 1144, 1074, 1066, 1086,  714,  175,  176,
			 1074,  918,  871,  180,  598,   98, 1086, 1214, 1215, 1121,
			 1217, 1089, 1086, 1091, 1063,  893, 1144, 1214, 1215,  841,

			 1217,  741, 1100, 1001, 1251, 1103, 1251, 1200,  498,  836,
			 1120, 1121, 1214, 1215,  874, 1217,  874,  978, 1118,  874,
			 1120, 1121, 1065,   62, 1251,   64, 1120, 1121, 1118, 1176,
			  162, 1173,  520, 1120, 1251, 1236, 1134, 1202,  699,   15,
			 1140,   80, 1213, 1214, 1144,  909, 1217,   86, 1078, 1251,
			  247,  248,  737,  250, 1224,   94, 1093,   96,   97, 1202,
			  257, 1145,  259,  102,  261, 1213, 1214, 1215, 1041, 1217,
			  923,  722,  133, 1171,  113,  385,  546,  506, 1132,  343,
			 1251,    9,  377,  771,  919,  546,   62,  661,  853,  731,
			   -1,   -1, 1202,   -1,   -1,  292,   -1,   -1,   34,   35, yyDummy>>,
			1, 200, 1000)
		end

	yycheck_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1, 1202, 1251,   80, 1203, 1204,   -1, 1202,   -1,
			   86,   -1,   -1, 1213, 1214, 1215,   -1, 1217,   94,   -1,
			   96,   97,  160,   -1,   -1,  163,  102,   22,   23,   24,
			   25,   26,   27,   -1,   -1,  173,   -1,  113, 1236,   -1,
			  116,  117,  118,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1, 1251,  265,  266,  267,  268,  269,  270,  271,  272,
			  273,  274,  275,  276,  277,  278,  279,  280,  281,  282,
			  283,  284,  285,  286,  287,  111,  112,  113,  114,  115,
			   -1,   -1,   -1,  119,   -1,   -1,   -1,   -1,   34,   35,
			   -1,    4,    5,    6,  826,    8,    9,   10,   11,   12,

			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,   25,   26,   27,  347,   -1,   -1,  415,   -1,
			  852,   -1,   34,   35,   -1,   -1,   -1,   -1,   -1,  426,
			  427,  428,  429,  430,  431,  432,  433,  434,  435,  436,
			  437,  438,  439,  440,   -1,  442,  443,   93,  445,  446,
			  447,  448,  449,  450,    0,  387,  888,   -1,   -1,  105,
			   -1,   74,   -1,   -1,   -1,  111,  112,  113,  114,  115,
			  383,   -1,   -1,  119,   -1,   -1,   -1,   -1,   -1,   -1,
			  393,   93,   -1,   -1,   -1,  917,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  406,   -1,   -1,   -1,   -1,   -1,  111, yyDummy>>,
			1, 200, 1200)
		end

	yycheck_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  112,  113,  114,  115,  117,   34,   35,  119,  421,  422,
			   -1,   -1,  350,   -1,  511,   -1,   62,   46,   64,   65,
			   66,   -1,   -1,  361,   -1,   34,   35,   -1,  441,  526,
			   76,  444,   61,   -1,   80,   -1,   -1,   -1,   84,   48,
			   86,   -1,  380,   -1,   -1,   54,  543,   -1,   94,   -1,
			   96,   97,  465,   -1,  986,   -1,  102,   -1,   -1,  556,
			  557,   -1,   -1,  560,  561,   -1,   -1,  113,   -1,  566,
			  502,   -1, 1004,   -1,   -1,   84,   -1,  509,  416,  417,
			   34,   35,  111,  112,   93,  114,  115,   -1,   -1,   -1,
			   -1,   -1,   34,   35,   -1,   -1,   -1,   -1,   -1,  531,

			   -1,   -1,  111,  112,  113,  114,  115,   -1, 1040,  522,
			  119,   -1,  609,   67,   -1, 1047,   70,   -1,  550,   -1,
			  533,  618,   -1,  536,   -1,  622,    4,    5,    6,   -1,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,   25,   26,   27,
			   -1,   93,  649,  650,  567,  568,   -1,  111,  112,   -1,
			  114,  115,   -1,  105,   -1,   -1, 1098,   -1,   -1,  111,
			  112,  113,  114,  115,  671,   -1,  514,  119,   -1,   -1,
			   -1,   -1, 1114,  680,  597,  598,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  532,   -1,   -1,  610,   -1,   -1, yyDummy>>,
			1, 200, 1400)
		end

	yycheck_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  632,  698,   -1,   -1,  701,   -1,   -1,  545,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1, 1147,   -1,  555,  631,  651,
			  558,  559,   -1,  636,  562,  563,  564,   -1,   34,   35,
			  662,  109,   -1,   -1,   -1,   -1,   -1,   -1,  735,  736,
			   46,   -1,  580,   -1,   -1, 1177,   -1,   -1,   -1,   -1,
			   -1,  683,  749,  750,  751,   -1,   -1,   -1, 1190,  691,
			   -1,   67,   -1, 1195,   70, 1197, 1198,   -1,  681,  682,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   34,   35,  617,
			  618,   -1,   -1,  715,   -1,  717,  699,  625,   -1,   -1,
			  703,  704,   -1,   -1,   -1, 1227,   -1,  710,   -1,   -1,

			   34,   35,   -1,   20,   21,  111,  112,   -1,  114,  115,
			   -1,   34,   35,   -1,   -1,   -1,   -1,   34,   35,   36,
			   37,   38,  819,   -1, 1256,   48, 1258,   -1,  741,   46,
			   -1,   54,   49,   -1,  831,   -1,   93,   -1,   -1,   56,
			   57,   -1,   65,   -1,   -1,   -1,  684,   -1,  105,   -1,
			   -1,   -1,  690,   -1,  111,  112,  113,  114,  115,   93,
			   -1,   84,  119,   -1,   -1,  778,   -1,  799,   -1,   -1,
			   93,  105,   -1,   -1,   -1,  788,   -1,  111,  112,  113,
			  114,  115,  105,   -1,   -1,  119,  109,   -1,  111,  112,
			  113,  114,  115,   -1,  111,  112,  119,  114,  115,   -1, yyDummy>>,
			1, 200, 1600)
		end

	yycheck_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,  833,   -1,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  137,  138,  139,  140,  141,  142,  143,  144,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,    4,    5,    6,
			  872,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   22,   23,   24,   25,   26,
			   27,   -1,  800,   34,   35,   -1,   49,   -1,   -1,   40,
			   -1,   -1,   55,   -1,   -1,   -1,   -1,   48,   64,   -1,
			   -1,   64,   68,   54,   -1,   -1,  983,  984,   34,   35,
			   -1,   77,   78,   -1,   65,   -1,   -1,   -1,   81,   82,

			   83,   87,  915,  916,   90,   -1,   92,  845,  940,   92,
			  848,   -1,   95,   84,   -1,   -1,   -1,   -1,   -1,   -1,
			  103,   -1,   93,  955,   -1,  108,  109,  110,   -1,   -1,
			  116,   -1,  118,   -1,  105,   -1,   -1,  875,  109,  106,
			  111,  112,  113,  114,  115,   -1,   -1,   93,  119,   -1,
			   34,   35, 1049, 1050,   -1,   -1,   -1, 1054, 1055, 1056,
			 1057, 1058,   46, 1060,   48,  111,  112,  113,  114,  115,
			   54,   -1,   -1,  119,  912, 1007,  989,  990,   34,   35,
			   -1,   65,   -1,  996,  997,  998,  999, 1000,   -1,   -1,
			 1003,   -1, 1024,   34,   35,   -1,   -1,   -1, 1095,   -1, yyDummy>>,
			1, 200, 1800)
		end

	yycheck_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   -1, 1035,   -1,   -1,   -1,   -1,   -1,   93,
			  948,   -1,  950,   -1,   -1, 1112,   -1,   58,  956,   -1,
			   -1,  105,   -1,   -1, 1037,  109,   -1,  111,  112,  113,
			  114,  115,   -1,   34,   35,  119, 1068,   93,   -1, 1071,
			 1053, 1073,   -1,   -1,   -1,   -1,   -1,   48,   -1,  105,
			   -1,   -1,   93,   54, 1151,  111,  112,  113,  114,  115,
			   -1,   -1,   -1,  119,   65,   34,   35,   -1,   -1, 1101,
			  111,  112,   -1,  114,  115,   -1,   -1,   -1, 1016,   48,
			   -1, 1019,   -1,   84, 1022,   54,   -1, 1025,   -1,   34,
			   35, 1104,   93,   -1,   -1,   -1,   65,   -1, 1036, 1196,

			   -1,   -1,   -1, 1135,  105,   -1,   -1,   -1,  109, 1141,
			  111,  112,  113,  114,  115,   84,   -1,   -1,  119,   -1,
			   -1,   -1,   -1,   -1,   93,   -1, 1223,   -1,   -1,   -1,
			 1162,   -1, 1070, 1165,   -1,   -1,  105,   -1,   -1, 1152,
			  109,   -1,  111,  112,  113,  114,  115,   -1,   93,   -1,
			  119,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1, 1097,
			  105, 1193,   -1, 1176, 1102,   -1,  111,  112,  113,  114,
			  115,   -1,   -1,   -1,  119,   -1, 1208,   -1,   -1, 1192,
			    4,    5,    6,   -1, 1216,   -1, 1124,   -1,   -1,   -1,
			   -1,   -1,   -1, 1131,   -1,   -1,   20,   21, 1136,   -1, yyDummy>>,
			1, 200, 2000)
		end

	yycheck_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   -1,   27,   28,   29,   30,   -1,   32,   -1,
			   34,   35,   36,   37,   38,   39,   -1,   -1,   42,   43,
			   -1,   -1,   46,   -1,   48,   49,   -1,   -1,   -1,   -1,
			   -1,   -1,   56,   57,   58,   -1,   -1,   61,   -1,   63,
			   -1,   -1,   -1,   67,   -1,   69,   70,   71,   -1, 1187,
			   -1,   -1,   76,   -1,   78,   -1, 1194,   -1,   -1,   -1,
			   -1,   -1,   -1,   87,   -1,   89,   -1,   -1,   -1,   -1,
			   -1, 1209,   -1,   -1,   98,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  111,  112,   -1,
			  114,  115,   -1,   -1,   -1,   -1,  120,  121,  122,  123,

			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  137,  138,  139,  140,  141,  142,  143,
			  144,    4,    5,    6,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   20,   21,   -1,
			   -1,   -1,   -1,   -1,   27,   28,   29,   30,   -1,   32,
			   -1,   34,   35,   36,   37,   38,   39,   -1,   -1,   42,
			   43,   -1,   -1,   46,   -1,   48,   -1,   -1,   -1,   -1,
			   -1,   54,   -1,   56,   57,   58,   -1,   -1,   61,   -1,
			   63,   -1,   -1,   -1,   67,   -1,   69,   70,   71,   34,
			   35,   -1,   -1,   -1,   -1,   78,   -1,   -1,   -1,   -1, yyDummy>>,
			1, 200, 2200)
		end

	yycheck_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   -1,   -1,   87,   -1,   89,   -1,   -1,   -1,
			   -1,   -1,   -1,   58,   -1,   98,   61,   -1,   -1,   -1,
			   -1,   -1,   67,   -1,   -1,   70,   -1,   -1,  111,  112,
			   -1,  114,  115,   -1,   -1,   -1,   -1,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,  138,  139,  140,  141,  142,
			  143,  144,    4,    5,    6,   -1,  111,  112,   -1,  114,
			  115,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   20,   21,
			   -1,   -1,   -1,   -1,   -1,   27,   28,   29,   30,   -1,
			   32,   -1,   34,   35,   36,   37,   38,   39,   -1,   -1,

			   42,   43,   -1,   -1,   46,   -1,   48,   -1,   -1,   -1,
			   -1,   55,   -1,   -1,   56,   57,   58,   -1,   -1,   61,
			   64,   63,   -1,   -1,   -1,   67,   -1,   69,   70,   71,
			   -1,   -1,   -1,   -1,   76,   -1,   78,   81,   82,   83,
			   -1,   -1,   -1,   -1,   -1,   87,   -1,   89,   92,   -1,
			   -1,   95,   -1,   -1,   -1,   -1,   98,   -1,   -1,  103,
			   -1,   -1,   -1,   -1,  108,  109,  110,   -1,   -1,  111,
			  112,   -1,  114,  115,   -1,   -1,   -1,   -1,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,  137,  138,  139,  140,  141, yyDummy>>,
			1, 200, 2400)
		end

	yycheck_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  142,  143,  144,    4,    5,    6,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   20,
			   21,   -1,   -1,   -1,   -1,   -1,   27,   28,   29,   30,
			   -1,   32,   -1,   34,   35,   36,   37,   38,   39,   -1,
			   -1,   42,   43,   -1,   -1,   46,   -1,   48,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   56,   57,   58,   -1,   -1,
			   61,   -1,   63,   -1,   -1,   -1,   67,   -1,   69,   70,
			   71,   -1,   -1,   -1,   -1,   -1,   -1,   78,   -1,   -1,
			   81,   -1,   -1,   -1,   -1,   -1,   87,   -1,   89,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   98,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  111,  112,   -1,  114,  115,   -1,   -1,   -1,   -1,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,  138,  139,  140,
			  141,  142,  143,  144,    4,    5,    6,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   20,   21,   -1,   -1,   -1,   -1,   -1,   27,   28,   29,
			   30,   -1,   32,   -1,   34,   35,   36,   37,   38,   39,
			   -1,   -1,   42,   43,   -1,   -1,   46,   -1,   48,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   56,   57,   58,   -1, yyDummy>>,
			1, 200, 2600)
		end

	yycheck_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   61,   -1,   63,   -1,   -1,   -1,   67,   -1,   69,
			   70,   71,   -1,   -1,   -1,   -1,   -1,   -1,   78,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   87,   -1,   89,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   98,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  106,   -1,   -1,   -1,
			   -1,  111,  112,   -1,  114,  115,   -1,   -1,   -1,   -1,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,  137,  138,  139,
			  140,  141,  142,  143,  144,    4,    5,    6,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   20,   21,   -1,   -1,   -1,   -1,   -1,   27,   28,
			   29,   30,   -1,   32,   -1,   34,   35,   36,   37,   38,
			   39,   -1,   -1,   42,   43,   -1,   -1,   46,   -1,   48,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,   57,   58,
			   -1,   -1,   61,   -1,   63,   -1,   -1,   -1,   67,   -1,
			   69,   70,   71,   -1,   -1,   -1,   -1,   -1,   -1,   78,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   87,   -1,
			   89,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   98,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  111,  112,   -1,  114,  115,   -1,   -1,   -1, yyDummy>>,
			1, 200, 2800)
		end

	yycheck_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  138,
			  139,  140,  141,  142,  143,  144,    4,    5,    6,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   20,   21,   -1,   -1,   -1,   -1,   -1,   27,
			   28,   29,   30,   -1,   32,   -1,   34,   35,   36,   37,
			   38,   39,   -1,   -1,   42,   43,   -1,   -1,   46,   -1,
			   48,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,   57,
			   58,   -1,   -1,   61,   -1,   63,   -1,   -1,   -1,   67,
			   -1,   69,   70,   71,   -1,   -1,   -1,   -1,   -1,   -1,

			   78,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   87,
			   -1,   89,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   98,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  111,  112,   -1,  114,  115,   -1,   -1,
			   -1,   -1,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,  137,
			  138,  139,  140,  141,  142,  143,  144,    4,    5,    6,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   20,   21,   -1,   -1,   -1,   -1,   -1,
			   27,   28,   29,   30,   -1,   32,   -1,   34,   35,   36, yyDummy>>,
			1, 200, 3000)
		end

	yycheck_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   37,   38,   39,   -1,   -1,   42,   43,   -1,   -1,   46,
			   -1,   48,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   58,   -1,   -1,   61,   -1,   63,   -1,   -1,   -1,
			   67,   -1,   69,   70,   71,   -1,   -1,   -1,   -1,   -1,
			   -1,   78,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   87,   -1,   89,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   98,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  111,  112,   -1,  114,  115,   -1,
			   -1,   -1,   -1,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,

			  137,  138,  139,  140,  141,  142,  143,  144,    4,    5,
			    6,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   20,   21,   -1,   -1,   -1,   -1,
			   -1,   27,   28,   29,   30,   -1,   32,   -1,   34,   35,
			   36,   37,   38,   39,   -1,   -1,   42,   43,   -1,   -1,
			   46,   -1,   48,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   56,   57,   58,   -1,   -1,   61,   -1,   63,   -1,   -1,
			   -1,   67,   -1,   69,   70,   71,   -1,   -1,   -1,   -1,
			   -1,   -1,   78,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   87,   -1,   89,   -1,   -1,   -1,   -1,   -1,   -1, yyDummy>>,
			1, 200, 3200)
		end

	yycheck_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   98,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  111,  112,   -1,  114,  115,
			   -1,   -1,   -1,   -1,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,  137,  138,  139,  140,  141,  142,  143,  144,    4,
			    5,    6,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   20,   21,   -1,   -1,   -1,
			   -1,   -1,   27,   28,   29,   30,   -1,   32,   -1,   34,
			   35,   36,   37,   38,   39,   -1,   -1,   42,   43,   -1,
			   -1,   46,   -1,   48,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   56,   57,   58,   -1,   -1,   61,   -1,   63,   -1,
			   -1,   -1,   67,   -1,   69,   70,   71,   -1,   -1,   -1,
			   -1,   -1,   -1,   78,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   87,   -1,   89,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   98,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  111,  112,   -1,  114,
			  115,   -1,   -1,   -1,   -1,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  138,  139,  140,  141,  142,  143,  144,
			    4,    5,    6,   -1,   -1,   -1,   -1,   -1,   -1,   -1, yyDummy>>,
			1, 200, 3400)
		end

	yycheck_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   -1,   -1,   -1,   -1,   20,   21,   34,   35,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   32,   -1,
			   34,   35,   48,   -1,   38,   39,   -1,   -1,   54,   -1,
			   -1,   -1,   46,   -1,   48,   -1,   -1,   -1,   -1,   65,
			   -1,   -1,   56,   57,   58,   59,   -1,   61,   -1,   -1,
			   -1,   -1,   -1,   67,   -1,   69,   70,   -1,   84,   -1,
			   -1,   75,   -1,   -1,   78,   79,   -1,   93,   -1,   -1,
			   -1,   -1,   -1,   87,   88,   89,   -1,   91,   -1,  105,
			   -1,   -1,   -1,  109,   98,  111,  112,  113,  114,  115,
			   -1,  105,   -1,  119,   -1,   -1,   -1,  111,  112,   -1,

			  114,  115,   -1,   -1,   -1,   -1,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  137,  138,  139,  140,  141,  142,  143,
			  144,   20,   21,   -1,   -1,   -1,   -1,   -1,   -1,   34,
			   35,   -1,   -1,   -1,   -1,   34,   35,   36,   37,   38,
			   -1,   -1,   -1,   48,   -1,   -1,   -1,   46,   -1,   54,
			   20,   21,   -1,   -1,   -1,   -1,   -1,   56,   57,   -1,
			   65,   -1,   -1,   -1,   -1,   -1,   36,   37,   38,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   23,   24,   25,   26,   27,   56,   57,   93,   -1, yyDummy>>,
			1, 200, 3600)
		end

	yycheck_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   60,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  105,   -1,   -1,   -1,  109,   -1,  111,  112,  113,  114,
			  115,   -1,  111,  112,  119,  114,  115,   -1,   -1,   -1,
			   -1,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  138,
			  139,  140,  141,  142,  143,  144,  116,   -1,  118,   -1,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,  137,  138,  139,
			  140,  141,  142,  143,  144,   20,   21,   -1,   -1,   32,
			   -1,   34,   35,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   36,   37,   38,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   20,   21,   -1,   58,   -1,   -1,   61,   -1,
			   -1,   56,   57,   31,   67,   60,   -1,   70,   36,   37,
			   38,   -1,   -1,   -1,   -1,   43,   -1,   20,   21,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   54,   -1,   31,   -1,
			   -1,   -1,   -1,   36,   37,   38,   -1,   -1,   -1,   -1,
			   43,   -1,   20,   21,   -1,   -1,   -1,   -1,  111,  112,
			   -1,  114,  115,   31,   -1,   -1,   -1,   -1,   36,   37,
			   38,   -1,   -1,   -1,   -1,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134, yyDummy>>,
			1, 200, 3800)
		end

	yycheck_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  135,  136,  137,  138,  139,  140,  141,  142,  143,  144,
			   -1,   -1,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,  137,
			  138,  139,  140,  141,  142,  143,  144,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,  138,  139,  140,  141,  142,
			  143,  144,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,  137,
			  138,  139,  140,  141,  142,  143,  144,   20,   21,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   36,   37,   38,   -1,   -1,   -1,   -1,
			   -1,    4,    5,    6,   -1,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,   25,   26,   27,    4,    5,    6,   -1,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   22,   23,   24,   25,   26,   27,   -1,
			    4,    5,    6,   -1,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   22,   23,
			   24,   25,   26,   27,   -1,   -1,   -1,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132, yyDummy>>,
			1, 200, 4000)
		end

	yycheck_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  133,  134,  135,  136,  137,  138,  139,  140,  141,  142,
			  143,  144,    0,  106,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   46,   -1,   -1,   49,   15,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  106,   -1,   -1,
			   -1,   64,   -1,   -1,   -1,   68,   34,   35,   -1,   -1,
			   -1,   39,   40,   -1,   77,   78,   -1,   45,   -1,   47,
			   48,   49,  106,   51,   87,   -1,   -1,   90,   -1,   92,
			   -1,   -1,   -1,   -1,   62,   -1,   64,   65,   -1,   67,
			   -1,   -1,   70,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   78,   -1,   80,  116,   -1,  118,   -1,   -1,   86,   87,

			    0,   -1,   -1,   -1,   92,   93,   94,   -1,   96,   97,
			   -1,   -1,   -1,  101,  102,   15,   -1,  105,   -1,   -1,
			   -1,   -1,   -1,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,   -1,   -1,   34,   35,   -1,   -1,   -1,   39,
			   40,   -1,   -1,   -1,   -1,   45,   -1,   47,   48,   49,
			   -1,   51,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   62,   -1,   64,   65,   -1,   67,   -1,   -1,
			   70,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   78,   -1,
			   80,   -1,   -1,   -1,   -1,   -1,   86,   87,    0,   -1,
			   -1,   -1,   92,   93,   94,   -1,   96,   97,   -1,   -1, yyDummy>>,
			1, 200, 4200)
		end

	yycheck_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,  101,  102,   15,   -1,  105,   -1,   -1,   -1,   -1,
			   -1,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			   -1,   -1,   34,   35,   -1,   -1,   -1,   39,   40,   -1,
			   -1,   -1,   -1,   45,   -1,   47,   48,   49,   -1,   51,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   62,   -1,   64,   65,   -1,   67,   -1,   -1,   70,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   78,   -1,   80,   -1,
			   -1,   -1,   -1,    0,   86,   87,   -1,   -1,   -1,   -1,
			   92,   -1,   94,   -1,   96,   97,   -1,   -1,   15,  101,
			  102,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  111,

			  112,  113,  114,  115,  116,  117,  118,   34,   35,   -1,
			   -1,   -1,   39,   40,   -1,   -1,   -1,   -1,   45,   -1,
			   47,   48,   49,   -1,   51,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   62,   -1,   64,   65,   -1,
			   67,   -1,   -1,   70,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   78,   -1,   80,   -1,   -1,   -1,   -1,    0,   86,
			   87,   -1,   -1,   -1,   -1,   92,   -1,   94,   -1,   96,
			   97,   -1,   -1,   15,  101,  102,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  111,  112,  113,  114,  115,  116,
			  117,  118,   34,   35,   -1,   -1,   -1,   39,   40,   -1, yyDummy>>,
			1, 200, 4400)
		end

	yycheck_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   -1,   45,   -1,   47,   48,   49,   -1,   51,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   62,   -1,   64,   65,   -1,   67,   -1,   -1,   70,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   78,   -1,   80,   -1,
			   -1,   -1,   -1,    0,   86,   87,   -1,   -1,   -1,   -1,
			   92,   -1,   94,   -1,   96,   97,   -1,   -1,   15,  101,
			  102,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  111,
			  112,  113,  114,  115,  116,  117,  118,   34,   35,   -1,
			   -1,   -1,   -1,   40,   -1,   -1,   -1,   -1,   45,   -1,
			   47,   48,   49,   46,   51,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   62,   -1,   64,   65,   -1,
			   67,   -1,   -1,   70,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   78,   -1,   80,   -1,   -1,   -1,   -1,   -1,   86,
			   87,   -1,   -1,   -1,   -1,   92,   -1,   94,   -1,   96,
			   97,   -1,   -1,   -1,  101,  102,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  111,  112,  113,  114,  115,  116,
			  117,  118,   -1,   -1,   -1,   -1,   -1,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,  138,  139,  140,  141,  142,
			  143,  144,    4,    5,    6,   -1,    8,    9,   10,   11, yyDummy>>,
			1, 200, 4600)
		end

	yycheck_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   23,   24,   25,   26,   27,    4,    5,    6,   -1,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,   25,   26,   27,
			   32,   -1,   34,   35,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   46,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   54,   -1,   -1,   -1,   58,   -1,   -1,   61,
			   -1,   -1,   -1,   -1,   -1,   67,   -1,   -1,   70,   -1,
			    4,    5,    6,   95,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   22,   23,

			   24,   25,   26,   27,   -1,   -1,   -1,   95,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  111,
			  112,   -1,  114,  115,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,   25,   26,   27,
			   64,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,    4,    5,    6,   81,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   22,   23,   24,   25,   26,   27,    4,    5,
			    6,   -1,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   22,   23,   24,   25, yyDummy>>,
			1, 200, 4800)
		end

	yycheck_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   26,   27,    4,    5,    6,   -1,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   23,   24,   25,   26,   27,   -1,   -1,   -1,   -1,
			   -1,   81,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   74,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,    4,
			    5,    6,   64,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,    4,    5,    6,   -1,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,

			   21,   22,   23,   24,   25,   26,   27,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   64,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,    4,    5,
			    6,   52,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   22,   23,   24,   25,
			   26,   27,    4,    5,    6,   -1,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   23,   24,   25,   26,   27,   52,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   23,   24,   25,   26,   27,    4,    5,    6,   51, yyDummy>>,
			1, 200, 5000)
		end

	yycheck_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,   25,   26,   27,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   22,   23,   24,   25,   26,   27,    4,    5,
			    6,   49,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   22,   23,   24,   25,
			   26,   27,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,    4,    5,    6,   45,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,   25,   26,   27,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,    4,    5,    6,   45,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   22,   23,   24,   25,   26,   27,   -1,   -1,
			   -1,   -1,   -1,   33,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,  137,  138,  139,  140,  141,  142,  143,  144,  120,
			   -1,  122,   -1,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,  138,  139,  140,
			  141,  142,  143,  144,    4,    5,    6,   -1,    8,    9, yyDummy>>,
			1, 200, 5200)
		end

	yycheck_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   22,   23,   24,   25,   26,   27,    4,    5,
			    6,   -1,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   22,   23,   24,   25,
			   26,   27,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,  137,  138,  139,  140,  141,
			  142,  143,  144,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,  138,  139,  140,

			   -1,  142, yyDummy>>,
			1, 102, 5400)
		end

feature {NONE} -- Semantic value stacks

	yyvs1: SPECIAL [detachable ANY]
			-- Stack for semantic values of type detachable ANY

	yyvsc1: INTEGER
			-- Capacity of semantic value stack `yyvs1'

	yyvsp1: INTEGER
			-- Top of semantic value stack `yyvs1'

	yyspecial_routines1: KL_SPECIAL_ROUTINES [detachable ANY]
			-- Routines that ought to be in SPECIAL [detachable ANY]

	yyvs2: SPECIAL [detachable ID_AS]
			-- Stack for semantic values of type detachable ID_AS

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [detachable ID_AS]
			-- Routines that ought to be in SPECIAL [detachable ID_AS]

	yyvs3: SPECIAL [detachable CHAR_AS]
			-- Stack for semantic values of type detachable CHAR_AS

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [detachable CHAR_AS]
			-- Routines that ought to be in SPECIAL [detachable CHAR_AS]

	yyvs4: SPECIAL [detachable SYMBOL_AS]
			-- Stack for semantic values of type detachable SYMBOL_AS

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [detachable SYMBOL_AS]
			-- Routines that ought to be in SPECIAL [detachable SYMBOL_AS]

	yyvs5: SPECIAL [AST_FACTORY]
			-- Stack for semantic values of type AST_FACTORY

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [AST_FACTORY]
			-- Routines that ought to be in SPECIAL [AST_FACTORY]

	yyvs6: SPECIAL [detachable like {AST_FACTORY}.symbol_id_type]
			-- Stack for semantic values of type detachable like {AST_FACTORY}.symbol_id_type

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [detachable like {AST_FACTORY}.symbol_id_type]
			-- Routines that ought to be in SPECIAL [detachable like {AST_FACTORY}.symbol_id_type]

	yyvs7: SPECIAL [detachable BOOL_AS]
			-- Stack for semantic values of type detachable BOOL_AS

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [detachable BOOL_AS]
			-- Routines that ought to be in SPECIAL [detachable BOOL_AS]

	yyvs8: SPECIAL [detachable RESULT_AS]
			-- Stack for semantic values of type detachable RESULT_AS

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [detachable RESULT_AS]
			-- Routines that ought to be in SPECIAL [detachable RESULT_AS]

	yyvs9: SPECIAL [detachable RETRY_AS]
			-- Stack for semantic values of type detachable RETRY_AS

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [detachable RETRY_AS]
			-- Routines that ought to be in SPECIAL [detachable RETRY_AS]

	yyvs10: SPECIAL [detachable UNIQUE_AS]
			-- Stack for semantic values of type detachable UNIQUE_AS

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [detachable UNIQUE_AS]
			-- Routines that ought to be in SPECIAL [detachable UNIQUE_AS]

	yyvs11: SPECIAL [detachable CURRENT_AS]
			-- Stack for semantic values of type detachable CURRENT_AS

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: KL_SPECIAL_ROUTINES [detachable CURRENT_AS]
			-- Routines that ought to be in SPECIAL [detachable CURRENT_AS]

	yyvs12: SPECIAL [detachable DEFERRED_AS]
			-- Stack for semantic values of type detachable DEFERRED_AS

	yyvsc12: INTEGER
			-- Capacity of semantic value stack `yyvs12'

	yyvsp12: INTEGER
			-- Top of semantic value stack `yyvs12'

	yyspecial_routines12: KL_SPECIAL_ROUTINES [detachable DEFERRED_AS]
			-- Routines that ought to be in SPECIAL [detachable DEFERRED_AS]

	yyvs13: SPECIAL [detachable VOID_AS]
			-- Stack for semantic values of type detachable VOID_AS

	yyvsc13: INTEGER
			-- Capacity of semantic value stack `yyvs13'

	yyvsp13: INTEGER
			-- Top of semantic value stack `yyvs13'

	yyspecial_routines13: KL_SPECIAL_ROUTINES [detachable VOID_AS]
			-- Routines that ought to be in SPECIAL [detachable VOID_AS]

	yyvs14: SPECIAL [detachable KEYWORD_AS]
			-- Stack for semantic values of type detachable KEYWORD_AS

	yyvsc14: INTEGER
			-- Capacity of semantic value stack `yyvs14'

	yyvsp14: INTEGER
			-- Top of semantic value stack `yyvs14'

	yyspecial_routines14: KL_SPECIAL_ROUTINES [detachable KEYWORD_AS]
			-- Routines that ought to be in SPECIAL [detachable KEYWORD_AS]

	yyvs15: SPECIAL [detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: READABLE_STRING_GENERAL]]
			-- Stack for semantic values of type detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: READABLE_STRING_GENERAL]

	yyvsc15: INTEGER
			-- Capacity of semantic value stack `yyvs15'

	yyvsp15: INTEGER
			-- Top of semantic value stack `yyvs15'

	yyspecial_routines15: KL_SPECIAL_ROUTINES [detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: READABLE_STRING_GENERAL]]
			-- Routines that ought to be in SPECIAL [detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: READABLE_STRING_GENERAL]]

	yyvs16: SPECIAL [detachable STRING_AS]
			-- Stack for semantic values of type detachable STRING_AS

	yyvsc16: INTEGER
			-- Capacity of semantic value stack `yyvs16'

	yyvsp16: INTEGER
			-- Top of semantic value stack `yyvs16'

	yyspecial_routines16: KL_SPECIAL_ROUTINES [detachable STRING_AS]
			-- Routines that ought to be in SPECIAL [detachable STRING_AS]

	yyvs17: SPECIAL [detachable ALIAS_TRIPLE]
			-- Stack for semantic values of type detachable ALIAS_TRIPLE

	yyvsc17: INTEGER
			-- Capacity of semantic value stack `yyvs17'

	yyvsp17: INTEGER
			-- Top of semantic value stack `yyvs17'

	yyspecial_routines17: KL_SPECIAL_ROUTINES [detachable ALIAS_TRIPLE]
			-- Routines that ought to be in SPECIAL [detachable ALIAS_TRIPLE]

	yyvs18: SPECIAL [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]

	yyvsc18: INTEGER
			-- Capacity of semantic value stack `yyvs18'

	yyvsp18: INTEGER
			-- Top of semantic value stack `yyvs18'

	yyspecial_routines18: KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]]
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]]

	yyvs19: SPECIAL [detachable PAIR [KEYWORD_AS, ID_AS]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, ID_AS]

	yyvsc19: INTEGER
			-- Capacity of semantic value stack `yyvs19'

	yyvsp19: INTEGER
			-- Top of semantic value stack `yyvs19'

	yyspecial_routines19: KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, ID_AS]]
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, ID_AS]]

	yyvs20: SPECIAL [detachable PAIR [KEYWORD_AS, STRING_AS]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, STRING_AS]

	yyvsc20: INTEGER
			-- Capacity of semantic value stack `yyvs20'

	yyvsp20: INTEGER
			-- Top of semantic value stack `yyvs20'

	yyspecial_routines20: KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, STRING_AS]]
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, STRING_AS]]

	yyvs21: SPECIAL [detachable IDENTIFIER_LIST]
			-- Stack for semantic values of type detachable IDENTIFIER_LIST

	yyvsc21: INTEGER
			-- Capacity of semantic value stack `yyvs21'

	yyvsp21: INTEGER
			-- Top of semantic value stack `yyvs21'

	yyspecial_routines21: KL_SPECIAL_ROUTINES [detachable IDENTIFIER_LIST]
			-- Routines that ought to be in SPECIAL [detachable IDENTIFIER_LIST]

	yyvs22: SPECIAL [detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]

	yyvsc22: INTEGER
			-- Capacity of semantic value stack `yyvs22'

	yyvsp22: INTEGER
			-- Top of semantic value stack `yyvs22'

	yyspecial_routines22: KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]]
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]]

	yyvs23: SPECIAL [detachable PAIR [KEYWORD_AS, EXPR_AS]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, EXPR_AS]

	yyvsc23: INTEGER
			-- Capacity of semantic value stack `yyvs23'

	yyvsp23: INTEGER
			-- Top of semantic value stack `yyvs23'

	yyspecial_routines23: KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, EXPR_AS]]
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, EXPR_AS]]

	yyvs24: SPECIAL [detachable AGENT_TARGET_TRIPLE]
			-- Stack for semantic values of type detachable AGENT_TARGET_TRIPLE

	yyvsc24: INTEGER
			-- Capacity of semantic value stack `yyvs24'

	yyvsp24: INTEGER
			-- Top of semantic value stack `yyvs24'

	yyspecial_routines24: KL_SPECIAL_ROUTINES [detachable AGENT_TARGET_TRIPLE]
			-- Routines that ought to be in SPECIAL [detachable AGENT_TARGET_TRIPLE]

	yyvs25: SPECIAL [detachable ACCESS_AS]
			-- Stack for semantic values of type detachable ACCESS_AS

	yyvsc25: INTEGER
			-- Capacity of semantic value stack `yyvs25'

	yyvsp25: INTEGER
			-- Top of semantic value stack `yyvs25'

	yyspecial_routines25: KL_SPECIAL_ROUTINES [detachable ACCESS_AS]
			-- Routines that ought to be in SPECIAL [detachable ACCESS_AS]

	yyvs26: SPECIAL [detachable ACCESS_FEAT_AS]
			-- Stack for semantic values of type detachable ACCESS_FEAT_AS

	yyvsc26: INTEGER
			-- Capacity of semantic value stack `yyvs26'

	yyvsp26: INTEGER
			-- Top of semantic value stack `yyvs26'

	yyspecial_routines26: KL_SPECIAL_ROUTINES [detachable ACCESS_FEAT_AS]
			-- Routines that ought to be in SPECIAL [detachable ACCESS_FEAT_AS]

	yyvs27: SPECIAL [detachable ACCESS_INV_AS]
			-- Stack for semantic values of type detachable ACCESS_INV_AS

	yyvsc27: INTEGER
			-- Capacity of semantic value stack `yyvs27'

	yyvsp27: INTEGER
			-- Top of semantic value stack `yyvs27'

	yyspecial_routines27: KL_SPECIAL_ROUTINES [detachable ACCESS_INV_AS]
			-- Routines that ought to be in SPECIAL [detachable ACCESS_INV_AS]

	yyvs28: SPECIAL [detachable ARRAY_AS]
			-- Stack for semantic values of type detachable ARRAY_AS

	yyvsc28: INTEGER
			-- Capacity of semantic value stack `yyvs28'

	yyvsp28: INTEGER
			-- Top of semantic value stack `yyvs28'

	yyspecial_routines28: KL_SPECIAL_ROUTINES [detachable ARRAY_AS]
			-- Routines that ought to be in SPECIAL [detachable ARRAY_AS]

	yyvs29: SPECIAL [detachable ASSIGN_AS]
			-- Stack for semantic values of type detachable ASSIGN_AS

	yyvsc29: INTEGER
			-- Capacity of semantic value stack `yyvs29'

	yyvsp29: INTEGER
			-- Top of semantic value stack `yyvs29'

	yyspecial_routines29: KL_SPECIAL_ROUTINES [detachable ASSIGN_AS]
			-- Routines that ought to be in SPECIAL [detachable ASSIGN_AS]

	yyvs30: SPECIAL [detachable ATOMIC_AS]
			-- Stack for semantic values of type detachable ATOMIC_AS

	yyvsc30: INTEGER
			-- Capacity of semantic value stack `yyvs30'

	yyvsp30: INTEGER
			-- Top of semantic value stack `yyvs30'

	yyspecial_routines30: KL_SPECIAL_ROUTINES [detachable ATOMIC_AS]
			-- Routines that ought to be in SPECIAL [detachable ATOMIC_AS]

	yyvs31: SPECIAL [detachable BINARY_AS]
			-- Stack for semantic values of type detachable BINARY_AS

	yyvsc31: INTEGER
			-- Capacity of semantic value stack `yyvs31'

	yyvsp31: INTEGER
			-- Top of semantic value stack `yyvs31'

	yyspecial_routines31: KL_SPECIAL_ROUTINES [detachable BINARY_AS]
			-- Routines that ought to be in SPECIAL [detachable BINARY_AS]

	yyvs32: SPECIAL [detachable BODY_AS]
			-- Stack for semantic values of type detachable BODY_AS

	yyvsc32: INTEGER
			-- Capacity of semantic value stack `yyvs32'

	yyvsp32: INTEGER
			-- Top of semantic value stack `yyvs32'

	yyspecial_routines32: KL_SPECIAL_ROUTINES [detachable BODY_AS]
			-- Routines that ought to be in SPECIAL [detachable BODY_AS]

	yyvs33: SPECIAL [BOOLEAN]
			-- Stack for semantic values of type BOOLEAN

	yyvsc33: INTEGER
			-- Capacity of semantic value stack `yyvs33'

	yyvsp33: INTEGER
			-- Top of semantic value stack `yyvs33'

	yyspecial_routines33: KL_SPECIAL_ROUTINES [BOOLEAN]
			-- Routines that ought to be in SPECIAL [BOOLEAN]

	yyvs34: SPECIAL [detachable CALL_AS]
			-- Stack for semantic values of type detachable CALL_AS

	yyvsc34: INTEGER
			-- Capacity of semantic value stack `yyvs34'

	yyvsp34: INTEGER
			-- Top of semantic value stack `yyvs34'

	yyspecial_routines34: KL_SPECIAL_ROUTINES [detachable CALL_AS]
			-- Routines that ought to be in SPECIAL [detachable CALL_AS]

	yyvs35: SPECIAL [detachable CASE_AS]
			-- Stack for semantic values of type detachable CASE_AS

	yyvsc35: INTEGER
			-- Capacity of semantic value stack `yyvs35'

	yyvsp35: INTEGER
			-- Top of semantic value stack `yyvs35'

	yyspecial_routines35: KL_SPECIAL_ROUTINES [detachable CASE_AS]
			-- Routines that ought to be in SPECIAL [detachable CASE_AS]

	yyvs36: SPECIAL [detachable CHECK_AS]
			-- Stack for semantic values of type detachable CHECK_AS

	yyvsc36: INTEGER
			-- Capacity of semantic value stack `yyvs36'

	yyvsp36: INTEGER
			-- Top of semantic value stack `yyvs36'

	yyspecial_routines36: KL_SPECIAL_ROUTINES [detachable CHECK_AS]
			-- Routines that ought to be in SPECIAL [detachable CHECK_AS]

	yyvs37: SPECIAL [detachable CLIENT_AS]
			-- Stack for semantic values of type detachable CLIENT_AS

	yyvsc37: INTEGER
			-- Capacity of semantic value stack `yyvs37'

	yyvsp37: INTEGER
			-- Top of semantic value stack `yyvs37'

	yyspecial_routines37: KL_SPECIAL_ROUTINES [detachable CLIENT_AS]
			-- Routines that ought to be in SPECIAL [detachable CLIENT_AS]

	yyvs38: SPECIAL [detachable CONSTANT_AS]
			-- Stack for semantic values of type detachable CONSTANT_AS

	yyvsc38: INTEGER
			-- Capacity of semantic value stack `yyvs38'

	yyvsp38: INTEGER
			-- Top of semantic value stack `yyvs38'

	yyspecial_routines38: KL_SPECIAL_ROUTINES [detachable CONSTANT_AS]
			-- Routines that ought to be in SPECIAL [detachable CONSTANT_AS]

	yyvs39: SPECIAL [detachable CONVERT_FEAT_AS]
			-- Stack for semantic values of type detachable CONVERT_FEAT_AS

	yyvsc39: INTEGER
			-- Capacity of semantic value stack `yyvs39'

	yyvsp39: INTEGER
			-- Top of semantic value stack `yyvs39'

	yyspecial_routines39: KL_SPECIAL_ROUTINES [detachable CONVERT_FEAT_AS]
			-- Routines that ought to be in SPECIAL [detachable CONVERT_FEAT_AS]

	yyvs40: SPECIAL [detachable CREATE_AS]
			-- Stack for semantic values of type detachable CREATE_AS

	yyvsc40: INTEGER
			-- Capacity of semantic value stack `yyvs40'

	yyvsp40: INTEGER
			-- Top of semantic value stack `yyvs40'

	yyspecial_routines40: KL_SPECIAL_ROUTINES [detachable CREATE_AS]
			-- Routines that ought to be in SPECIAL [detachable CREATE_AS]

	yyvs41: SPECIAL [detachable CREATION_AS]
			-- Stack for semantic values of type detachable CREATION_AS

	yyvsc41: INTEGER
			-- Capacity of semantic value stack `yyvs41'

	yyvsp41: INTEGER
			-- Top of semantic value stack `yyvs41'

	yyspecial_routines41: KL_SPECIAL_ROUTINES [detachable CREATION_AS]
			-- Routines that ought to be in SPECIAL [detachable CREATION_AS]

	yyvs42: SPECIAL [detachable CREATION_EXPR_AS]
			-- Stack for semantic values of type detachable CREATION_EXPR_AS

	yyvsc42: INTEGER
			-- Capacity of semantic value stack `yyvs42'

	yyvsp42: INTEGER
			-- Top of semantic value stack `yyvs42'

	yyspecial_routines42: KL_SPECIAL_ROUTINES [detachable CREATION_EXPR_AS]
			-- Routines that ought to be in SPECIAL [detachable CREATION_EXPR_AS]

	yyvs43: SPECIAL [detachable DEBUG_AS]
			-- Stack for semantic values of type detachable DEBUG_AS

	yyvsc43: INTEGER
			-- Capacity of semantic value stack `yyvs43'

	yyvsp43: INTEGER
			-- Top of semantic value stack `yyvs43'

	yyspecial_routines43: KL_SPECIAL_ROUTINES [detachable DEBUG_AS]
			-- Routines that ought to be in SPECIAL [detachable DEBUG_AS]

	yyvs44: SPECIAL [detachable ELSIF_AS]
			-- Stack for semantic values of type detachable ELSIF_AS

	yyvsc44: INTEGER
			-- Capacity of semantic value stack `yyvs44'

	yyvsp44: INTEGER
			-- Top of semantic value stack `yyvs44'

	yyspecial_routines44: KL_SPECIAL_ROUTINES [detachable ELSIF_AS]
			-- Routines that ought to be in SPECIAL [detachable ELSIF_AS]

	yyvs45: SPECIAL [detachable ELSIF_EXPRESSION_AS]
			-- Stack for semantic values of type detachable ELSIF_EXPRESSION_AS

	yyvsc45: INTEGER
			-- Capacity of semantic value stack `yyvs45'

	yyvsp45: INTEGER
			-- Top of semantic value stack `yyvs45'

	yyspecial_routines45: KL_SPECIAL_ROUTINES [detachable ELSIF_EXPRESSION_AS]
			-- Routines that ought to be in SPECIAL [detachable ELSIF_EXPRESSION_AS]

	yyvs46: SPECIAL [detachable ENSURE_AS]
			-- Stack for semantic values of type detachable ENSURE_AS

	yyvsc46: INTEGER
			-- Capacity of semantic value stack `yyvs46'

	yyvsp46: INTEGER
			-- Top of semantic value stack `yyvs46'

	yyspecial_routines46: KL_SPECIAL_ROUTINES [detachable ENSURE_AS]
			-- Routines that ought to be in SPECIAL [detachable ENSURE_AS]

	yyvs47: SPECIAL [detachable EXPORT_ITEM_AS]
			-- Stack for semantic values of type detachable EXPORT_ITEM_AS

	yyvsc47: INTEGER
			-- Capacity of semantic value stack `yyvs47'

	yyvsp47: INTEGER
			-- Top of semantic value stack `yyvs47'

	yyspecial_routines47: KL_SPECIAL_ROUTINES [detachable EXPORT_ITEM_AS]
			-- Routines that ought to be in SPECIAL [detachable EXPORT_ITEM_AS]

	yyvs48: SPECIAL [detachable EXPR_AS]
			-- Stack for semantic values of type detachable EXPR_AS

	yyvsc48: INTEGER
			-- Capacity of semantic value stack `yyvs48'

	yyvsp48: INTEGER
			-- Top of semantic value stack `yyvs48'

	yyspecial_routines48: KL_SPECIAL_ROUTINES [detachable EXPR_AS]
			-- Routines that ought to be in SPECIAL [detachable EXPR_AS]

	yyvs49: SPECIAL [detachable BRACKET_AS]
			-- Stack for semantic values of type detachable BRACKET_AS

	yyvsc49: INTEGER
			-- Capacity of semantic value stack `yyvs49'

	yyvsp49: INTEGER
			-- Top of semantic value stack `yyvs49'

	yyspecial_routines49: KL_SPECIAL_ROUTINES [detachable BRACKET_AS]
			-- Routines that ought to be in SPECIAL [detachable BRACKET_AS]

	yyvs50: SPECIAL [detachable EXTERNAL_AS]
			-- Stack for semantic values of type detachable EXTERNAL_AS

	yyvsc50: INTEGER
			-- Capacity of semantic value stack `yyvs50'

	yyvsp50: INTEGER
			-- Top of semantic value stack `yyvs50'

	yyspecial_routines50: KL_SPECIAL_ROUTINES [detachable EXTERNAL_AS]
			-- Routines that ought to be in SPECIAL [detachable EXTERNAL_AS]

	yyvs51: SPECIAL [detachable EXTERNAL_LANG_AS]
			-- Stack for semantic values of type detachable EXTERNAL_LANG_AS

	yyvsc51: INTEGER
			-- Capacity of semantic value stack `yyvs51'

	yyvsp51: INTEGER
			-- Top of semantic value stack `yyvs51'

	yyspecial_routines51: KL_SPECIAL_ROUTINES [detachable EXTERNAL_LANG_AS]
			-- Routines that ought to be in SPECIAL [detachable EXTERNAL_LANG_AS]

	yyvs52: SPECIAL [detachable FEATURE_AS]
			-- Stack for semantic values of type detachable FEATURE_AS

	yyvsc52: INTEGER
			-- Capacity of semantic value stack `yyvs52'

	yyvsp52: INTEGER
			-- Top of semantic value stack `yyvs52'

	yyspecial_routines52: KL_SPECIAL_ROUTINES [detachable FEATURE_AS]
			-- Routines that ought to be in SPECIAL [detachable FEATURE_AS]

	yyvs53: SPECIAL [detachable FEATURE_CLAUSE_AS]
			-- Stack for semantic values of type detachable FEATURE_CLAUSE_AS

	yyvsc53: INTEGER
			-- Capacity of semantic value stack `yyvs53'

	yyvsp53: INTEGER
			-- Top of semantic value stack `yyvs53'

	yyspecial_routines53: KL_SPECIAL_ROUTINES [detachable FEATURE_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable FEATURE_CLAUSE_AS]

	yyvs54: SPECIAL [detachable FEATURE_SET_AS]
			-- Stack for semantic values of type detachable FEATURE_SET_AS

	yyvsc54: INTEGER
			-- Capacity of semantic value stack `yyvs54'

	yyvsp54: INTEGER
			-- Top of semantic value stack `yyvs54'

	yyspecial_routines54: KL_SPECIAL_ROUTINES [detachable FEATURE_SET_AS]
			-- Routines that ought to be in SPECIAL [detachable FEATURE_SET_AS]

	yyvs55: SPECIAL [detachable FORMAL_AS]
			-- Stack for semantic values of type detachable FORMAL_AS

	yyvsc55: INTEGER
			-- Capacity of semantic value stack `yyvs55'

	yyvsp55: INTEGER
			-- Top of semantic value stack `yyvs55'

	yyspecial_routines55: KL_SPECIAL_ROUTINES [detachable FORMAL_AS]
			-- Routines that ought to be in SPECIAL [detachable FORMAL_AS]

	yyvs56: SPECIAL [detachable FORMAL_DEC_AS]
			-- Stack for semantic values of type detachable FORMAL_DEC_AS

	yyvsc56: INTEGER
			-- Capacity of semantic value stack `yyvs56'

	yyvsp56: INTEGER
			-- Top of semantic value stack `yyvs56'

	yyspecial_routines56: KL_SPECIAL_ROUTINES [detachable FORMAL_DEC_AS]
			-- Routines that ought to be in SPECIAL [detachable FORMAL_DEC_AS]

	yyvs57: SPECIAL [detachable GUARD_AS]
			-- Stack for semantic values of type detachable GUARD_AS

	yyvsc57: INTEGER
			-- Capacity of semantic value stack `yyvs57'

	yyvsp57: INTEGER
			-- Top of semantic value stack `yyvs57'

	yyspecial_routines57: KL_SPECIAL_ROUTINES [detachable GUARD_AS]
			-- Routines that ought to be in SPECIAL [detachable GUARD_AS]

	yyvs58: SPECIAL [detachable IF_AS]
			-- Stack for semantic values of type detachable IF_AS

	yyvsc58: INTEGER
			-- Capacity of semantic value stack `yyvs58'

	yyvsp58: INTEGER
			-- Top of semantic value stack `yyvs58'

	yyspecial_routines58: KL_SPECIAL_ROUTINES [detachable IF_AS]
			-- Routines that ought to be in SPECIAL [detachable IF_AS]

	yyvs59: SPECIAL [detachable IF_EXPRESSION_AS]
			-- Stack for semantic values of type detachable IF_EXPRESSION_AS

	yyvsc59: INTEGER
			-- Capacity of semantic value stack `yyvs59'

	yyvsp59: INTEGER
			-- Top of semantic value stack `yyvs59'

	yyspecial_routines59: KL_SPECIAL_ROUTINES [detachable IF_EXPRESSION_AS]
			-- Routines that ought to be in SPECIAL [detachable IF_EXPRESSION_AS]

	yyvs60: SPECIAL [detachable INDEX_AS]
			-- Stack for semantic values of type detachable INDEX_AS

	yyvsc60: INTEGER
			-- Capacity of semantic value stack `yyvs60'

	yyvsp60: INTEGER
			-- Top of semantic value stack `yyvs60'

	yyspecial_routines60: KL_SPECIAL_ROUTINES [detachable INDEX_AS]
			-- Routines that ought to be in SPECIAL [detachable INDEX_AS]

	yyvs61: SPECIAL [detachable INSPECT_AS]
			-- Stack for semantic values of type detachable INSPECT_AS

	yyvsc61: INTEGER
			-- Capacity of semantic value stack `yyvs61'

	yyvsp61: INTEGER
			-- Top of semantic value stack `yyvs61'

	yyspecial_routines61: KL_SPECIAL_ROUTINES [detachable INSPECT_AS]
			-- Routines that ought to be in SPECIAL [detachable INSPECT_AS]

	yyvs62: SPECIAL [detachable INSTRUCTION_AS]
			-- Stack for semantic values of type detachable INSTRUCTION_AS

	yyvsc62: INTEGER
			-- Capacity of semantic value stack `yyvs62'

	yyvsp62: INTEGER
			-- Top of semantic value stack `yyvs62'

	yyspecial_routines62: KL_SPECIAL_ROUTINES [detachable INSTRUCTION_AS]
			-- Routines that ought to be in SPECIAL [detachable INSTRUCTION_AS]

	yyvs63: SPECIAL [detachable INTEGER_AS]
			-- Stack for semantic values of type detachable INTEGER_AS

	yyvsc63: INTEGER
			-- Capacity of semantic value stack `yyvs63'

	yyvsp63: INTEGER
			-- Top of semantic value stack `yyvs63'

	yyspecial_routines63: KL_SPECIAL_ROUTINES [detachable INTEGER_AS]
			-- Routines that ought to be in SPECIAL [detachable INTEGER_AS]

	yyvs64: SPECIAL [detachable INTERNAL_AS]
			-- Stack for semantic values of type detachable INTERNAL_AS

	yyvsc64: INTEGER
			-- Capacity of semantic value stack `yyvs64'

	yyvsp64: INTEGER
			-- Top of semantic value stack `yyvs64'

	yyspecial_routines64: KL_SPECIAL_ROUTINES [detachable INTERNAL_AS]
			-- Routines that ought to be in SPECIAL [detachable INTERNAL_AS]

	yyvs65: SPECIAL [detachable INTERVAL_AS]
			-- Stack for semantic values of type detachable INTERVAL_AS

	yyvsc65: INTEGER
			-- Capacity of semantic value stack `yyvs65'

	yyvsp65: INTEGER
			-- Top of semantic value stack `yyvs65'

	yyspecial_routines65: KL_SPECIAL_ROUTINES [detachable INTERVAL_AS]
			-- Routines that ought to be in SPECIAL [detachable INTERVAL_AS]

	yyvs66: SPECIAL [detachable INVARIANT_AS]
			-- Stack for semantic values of type detachable INVARIANT_AS

	yyvsc66: INTEGER
			-- Capacity of semantic value stack `yyvs66'

	yyvsp66: INTEGER
			-- Top of semantic value stack `yyvs66'

	yyspecial_routines66: KL_SPECIAL_ROUTINES [detachable INVARIANT_AS]
			-- Routines that ought to be in SPECIAL [detachable INVARIANT_AS]

	yyvs67: SPECIAL [detachable LOOP_EXPR_AS]
			-- Stack for semantic values of type detachable LOOP_EXPR_AS

	yyvsc67: INTEGER
			-- Capacity of semantic value stack `yyvs67'

	yyvsp67: INTEGER
			-- Top of semantic value stack `yyvs67'

	yyspecial_routines67: KL_SPECIAL_ROUTINES [detachable LOOP_EXPR_AS]
			-- Routines that ought to be in SPECIAL [detachable LOOP_EXPR_AS]

	yyvs68: SPECIAL [detachable LOOP_AS]
			-- Stack for semantic values of type detachable LOOP_AS

	yyvsc68: INTEGER
			-- Capacity of semantic value stack `yyvs68'

	yyvsp68: INTEGER
			-- Top of semantic value stack `yyvs68'

	yyspecial_routines68: KL_SPECIAL_ROUTINES [detachable LOOP_AS]
			-- Routines that ought to be in SPECIAL [detachable LOOP_AS]

	yyvs69: SPECIAL [detachable NAMED_EXPRESSION_AS]
			-- Stack for semantic values of type detachable NAMED_EXPRESSION_AS

	yyvsc69: INTEGER
			-- Capacity of semantic value stack `yyvs69'

	yyvsp69: INTEGER
			-- Top of semantic value stack `yyvs69'

	yyspecial_routines69: KL_SPECIAL_ROUTINES [detachable NAMED_EXPRESSION_AS]
			-- Routines that ought to be in SPECIAL [detachable NAMED_EXPRESSION_AS]

	yyvs70: SPECIAL [detachable NESTED_AS]
			-- Stack for semantic values of type detachable NESTED_AS

	yyvsc70: INTEGER
			-- Capacity of semantic value stack `yyvs70'

	yyvsp70: INTEGER
			-- Top of semantic value stack `yyvs70'

	yyspecial_routines70: KL_SPECIAL_ROUTINES [detachable NESTED_AS]
			-- Routines that ought to be in SPECIAL [detachable NESTED_AS]

	yyvs71: SPECIAL [detachable OPERAND_AS]
			-- Stack for semantic values of type detachable OPERAND_AS

	yyvsc71: INTEGER
			-- Capacity of semantic value stack `yyvs71'

	yyvsp71: INTEGER
			-- Top of semantic value stack `yyvs71'

	yyspecial_routines71: KL_SPECIAL_ROUTINES [detachable OPERAND_AS]
			-- Routines that ought to be in SPECIAL [detachable OPERAND_AS]

	yyvs72: SPECIAL [detachable PARENT_AS]
			-- Stack for semantic values of type detachable PARENT_AS

	yyvsc72: INTEGER
			-- Capacity of semantic value stack `yyvs72'

	yyvsp72: INTEGER
			-- Top of semantic value stack `yyvs72'

	yyspecial_routines72: KL_SPECIAL_ROUTINES [detachable PARENT_AS]
			-- Routines that ought to be in SPECIAL [detachable PARENT_AS]

	yyvs73: SPECIAL [detachable PRECURSOR_AS]
			-- Stack for semantic values of type detachable PRECURSOR_AS

	yyvsc73: INTEGER
			-- Capacity of semantic value stack `yyvs73'

	yyvsp73: INTEGER
			-- Top of semantic value stack `yyvs73'

	yyspecial_routines73: KL_SPECIAL_ROUTINES [detachable PRECURSOR_AS]
			-- Routines that ought to be in SPECIAL [detachable PRECURSOR_AS]

	yyvs74: SPECIAL [detachable STATIC_ACCESS_AS]
			-- Stack for semantic values of type detachable STATIC_ACCESS_AS

	yyvsc74: INTEGER
			-- Capacity of semantic value stack `yyvs74'

	yyvsp74: INTEGER
			-- Top of semantic value stack `yyvs74'

	yyspecial_routines74: KL_SPECIAL_ROUTINES [detachable STATIC_ACCESS_AS]
			-- Routines that ought to be in SPECIAL [detachable STATIC_ACCESS_AS]

	yyvs75: SPECIAL [detachable REAL_AS]
			-- Stack for semantic values of type detachable REAL_AS

	yyvsc75: INTEGER
			-- Capacity of semantic value stack `yyvs75'

	yyvsp75: INTEGER
			-- Top of semantic value stack `yyvs75'

	yyspecial_routines75: KL_SPECIAL_ROUTINES [detachable REAL_AS]
			-- Routines that ought to be in SPECIAL [detachable REAL_AS]

	yyvs76: SPECIAL [detachable RENAME_AS]
			-- Stack for semantic values of type detachable RENAME_AS

	yyvsc76: INTEGER
			-- Capacity of semantic value stack `yyvs76'

	yyvsp76: INTEGER
			-- Top of semantic value stack `yyvs76'

	yyspecial_routines76: KL_SPECIAL_ROUTINES [detachable RENAME_AS]
			-- Routines that ought to be in SPECIAL [detachable RENAME_AS]

	yyvs77: SPECIAL [detachable REQUIRE_AS]
			-- Stack for semantic values of type detachable REQUIRE_AS

	yyvsc77: INTEGER
			-- Capacity of semantic value stack `yyvs77'

	yyvsp77: INTEGER
			-- Top of semantic value stack `yyvs77'

	yyspecial_routines77: KL_SPECIAL_ROUTINES [detachable REQUIRE_AS]
			-- Routines that ought to be in SPECIAL [detachable REQUIRE_AS]

	yyvs78: SPECIAL [detachable REVERSE_AS]
			-- Stack for semantic values of type detachable REVERSE_AS

	yyvsc78: INTEGER
			-- Capacity of semantic value stack `yyvs78'

	yyvsp78: INTEGER
			-- Top of semantic value stack `yyvs78'

	yyspecial_routines78: KL_SPECIAL_ROUTINES [detachable REVERSE_AS]
			-- Routines that ought to be in SPECIAL [detachable REVERSE_AS]

	yyvs79: SPECIAL [detachable ROUT_BODY_AS]
			-- Stack for semantic values of type detachable ROUT_BODY_AS

	yyvsc79: INTEGER
			-- Capacity of semantic value stack `yyvs79'

	yyvsp79: INTEGER
			-- Top of semantic value stack `yyvs79'

	yyspecial_routines79: KL_SPECIAL_ROUTINES [detachable ROUT_BODY_AS]
			-- Routines that ought to be in SPECIAL [detachable ROUT_BODY_AS]

	yyvs80: SPECIAL [detachable ROUTINE_AS]
			-- Stack for semantic values of type detachable ROUTINE_AS

	yyvsc80: INTEGER
			-- Capacity of semantic value stack `yyvs80'

	yyvsp80: INTEGER
			-- Top of semantic value stack `yyvs80'

	yyspecial_routines80: KL_SPECIAL_ROUTINES [detachable ROUTINE_AS]
			-- Routines that ought to be in SPECIAL [detachable ROUTINE_AS]

	yyvs81: SPECIAL [detachable ROUTINE_CREATION_AS]
			-- Stack for semantic values of type detachable ROUTINE_CREATION_AS

	yyvsc81: INTEGER
			-- Capacity of semantic value stack `yyvs81'

	yyvsp81: INTEGER
			-- Top of semantic value stack `yyvs81'

	yyspecial_routines81: KL_SPECIAL_ROUTINES [detachable ROUTINE_CREATION_AS]
			-- Routines that ought to be in SPECIAL [detachable ROUTINE_CREATION_AS]

	yyvs82: SPECIAL [detachable SEPARATE_INSTRUCTION_AS]
			-- Stack for semantic values of type detachable SEPARATE_INSTRUCTION_AS

	yyvsc82: INTEGER
			-- Capacity of semantic value stack `yyvs82'

	yyvsp82: INTEGER
			-- Top of semantic value stack `yyvs82'

	yyspecial_routines82: KL_SPECIAL_ROUTINES [detachable SEPARATE_INSTRUCTION_AS]
			-- Routines that ought to be in SPECIAL [detachable SEPARATE_INSTRUCTION_AS]

	yyvs83: SPECIAL [detachable TAGGED_AS]
			-- Stack for semantic values of type detachable TAGGED_AS

	yyvsc83: INTEGER
			-- Capacity of semantic value stack `yyvs83'

	yyvsp83: INTEGER
			-- Top of semantic value stack `yyvs83'

	yyspecial_routines83: KL_SPECIAL_ROUTINES [detachable TAGGED_AS]
			-- Routines that ought to be in SPECIAL [detachable TAGGED_AS]

	yyvs84: SPECIAL [detachable TUPLE_AS]
			-- Stack for semantic values of type detachable TUPLE_AS

	yyvsc84: INTEGER
			-- Capacity of semantic value stack `yyvs84'

	yyvsp84: INTEGER
			-- Top of semantic value stack `yyvs84'

	yyspecial_routines84: KL_SPECIAL_ROUTINES [detachable TUPLE_AS]
			-- Routines that ought to be in SPECIAL [detachable TUPLE_AS]

	yyvs85: SPECIAL [detachable TYPE_AS]
			-- Stack for semantic values of type detachable TYPE_AS

	yyvsc85: INTEGER
			-- Capacity of semantic value stack `yyvs85'

	yyvsp85: INTEGER
			-- Top of semantic value stack `yyvs85'

	yyspecial_routines85: KL_SPECIAL_ROUTINES [detachable TYPE_AS]
			-- Routines that ought to be in SPECIAL [detachable TYPE_AS]

	yyvs86: SPECIAL [detachable QUALIFIED_ANCHORED_TYPE_AS]
			-- Stack for semantic values of type detachable QUALIFIED_ANCHORED_TYPE_AS

	yyvsc86: INTEGER
			-- Capacity of semantic value stack `yyvs86'

	yyvsp86: INTEGER
			-- Top of semantic value stack `yyvs86'

	yyspecial_routines86: KL_SPECIAL_ROUTINES [detachable QUALIFIED_ANCHORED_TYPE_AS]
			-- Routines that ought to be in SPECIAL [detachable QUALIFIED_ANCHORED_TYPE_AS]

	yyvs87: SPECIAL [detachable CLASS_TYPE_AS]
			-- Stack for semantic values of type detachable CLASS_TYPE_AS

	yyvsc87: INTEGER
			-- Capacity of semantic value stack `yyvs87'

	yyvsp87: INTEGER
			-- Top of semantic value stack `yyvs87'

	yyspecial_routines87: KL_SPECIAL_ROUTINES [detachable CLASS_TYPE_AS]
			-- Routines that ought to be in SPECIAL [detachable CLASS_TYPE_AS]

	yyvs88: SPECIAL [detachable TYPE_DEC_AS]
			-- Stack for semantic values of type detachable TYPE_DEC_AS

	yyvsc88: INTEGER
			-- Capacity of semantic value stack `yyvs88'

	yyvsp88: INTEGER
			-- Top of semantic value stack `yyvs88'

	yyspecial_routines88: KL_SPECIAL_ROUTINES [detachable TYPE_DEC_AS]
			-- Routines that ought to be in SPECIAL [detachable TYPE_DEC_AS]

	yyvs89: SPECIAL [detachable LIST_DEC_AS]
			-- Stack for semantic values of type detachable LIST_DEC_AS

	yyvsc89: INTEGER
			-- Capacity of semantic value stack `yyvs89'

	yyvsp89: INTEGER
			-- Top of semantic value stack `yyvs89'

	yyspecial_routines89: KL_SPECIAL_ROUTINES [detachable LIST_DEC_AS]
			-- Routines that ought to be in SPECIAL [detachable LIST_DEC_AS]

	yyvs90: SPECIAL [detachable VARIANT_AS]
			-- Stack for semantic values of type detachable VARIANT_AS

	yyvsc90: INTEGER
			-- Capacity of semantic value stack `yyvs90'

	yyvsp90: INTEGER
			-- Top of semantic value stack `yyvs90'

	yyspecial_routines90: KL_SPECIAL_ROUTINES [detachable VARIANT_AS]
			-- Routines that ought to be in SPECIAL [detachable VARIANT_AS]

	yyvs91: SPECIAL [detachable FEATURE_NAME]
			-- Stack for semantic values of type detachable FEATURE_NAME

	yyvsc91: INTEGER
			-- Capacity of semantic value stack `yyvs91'

	yyvsp91: INTEGER
			-- Top of semantic value stack `yyvs91'

	yyspecial_routines91: KL_SPECIAL_ROUTINES [detachable FEATURE_NAME]
			-- Routines that ought to be in SPECIAL [detachable FEATURE_NAME]

	yyvs92: SPECIAL [detachable EIFFEL_LIST [ATOMIC_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [ATOMIC_AS]

	yyvsc92: INTEGER
			-- Capacity of semantic value stack `yyvs92'

	yyvsp92: INTEGER
			-- Top of semantic value stack `yyvs92'

	yyspecial_routines92: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [ATOMIC_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [ATOMIC_AS]]

	yyvs93: SPECIAL [detachable EIFFEL_LIST [CASE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [CASE_AS]

	yyvsc93: INTEGER
			-- Capacity of semantic value stack `yyvs93'

	yyvsp93: INTEGER
			-- Top of semantic value stack `yyvs93'

	yyspecial_routines93: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [CASE_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [CASE_AS]]

	yyvs94: SPECIAL [detachable CONVERT_FEAT_LIST_AS]
			-- Stack for semantic values of type detachable CONVERT_FEAT_LIST_AS

	yyvsc94: INTEGER
			-- Capacity of semantic value stack `yyvs94'

	yyvsp94: INTEGER
			-- Top of semantic value stack `yyvs94'

	yyspecial_routines94: KL_SPECIAL_ROUTINES [detachable CONVERT_FEAT_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable CONVERT_FEAT_LIST_AS]

	yyvs95: SPECIAL [detachable EIFFEL_LIST [CREATE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [CREATE_AS]

	yyvsc95: INTEGER
			-- Capacity of semantic value stack `yyvs95'

	yyvsp95: INTEGER
			-- Top of semantic value stack `yyvs95'

	yyspecial_routines95: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [CREATE_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [CREATE_AS]]

	yyvs96: SPECIAL [detachable EIFFEL_LIST [ELSIF_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [ELSIF_AS]

	yyvsc96: INTEGER
			-- Capacity of semantic value stack `yyvs96'

	yyvsp96: INTEGER
			-- Top of semantic value stack `yyvs96'

	yyspecial_routines96: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [ELSIF_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [ELSIF_AS]]

	yyvs97: SPECIAL [detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]

	yyvsc97: INTEGER
			-- Capacity of semantic value stack `yyvs97'

	yyvsp97: INTEGER
			-- Top of semantic value stack `yyvs97'

	yyspecial_routines97: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]]

	yyvs98: SPECIAL [detachable EIFFEL_LIST [EXPORT_ITEM_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [EXPORT_ITEM_AS]

	yyvsc98: INTEGER
			-- Capacity of semantic value stack `yyvs98'

	yyvsp98: INTEGER
			-- Top of semantic value stack `yyvs98'

	yyspecial_routines98: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [EXPORT_ITEM_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [EXPORT_ITEM_AS]]

	yyvs99: SPECIAL [detachable EXPORT_CLAUSE_AS]
			-- Stack for semantic values of type detachable EXPORT_CLAUSE_AS

	yyvsc99: INTEGER
			-- Capacity of semantic value stack `yyvs99'

	yyvsp99: INTEGER
			-- Top of semantic value stack `yyvs99'

	yyspecial_routines99: KL_SPECIAL_ROUTINES [detachable EXPORT_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable EXPORT_CLAUSE_AS]

	yyvs100: SPECIAL [detachable EIFFEL_LIST [EXPR_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [EXPR_AS]

	yyvsc100: INTEGER
			-- Capacity of semantic value stack `yyvs100'

	yyvsp100: INTEGER
			-- Top of semantic value stack `yyvs100'

	yyspecial_routines100: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [EXPR_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [EXPR_AS]]

	yyvs101: SPECIAL [detachable PARAMETER_LIST_AS]
			-- Stack for semantic values of type detachable PARAMETER_LIST_AS

	yyvsc101: INTEGER
			-- Capacity of semantic value stack `yyvs101'

	yyvsp101: INTEGER
			-- Top of semantic value stack `yyvs101'

	yyspecial_routines101: KL_SPECIAL_ROUTINES [detachable PARAMETER_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable PARAMETER_LIST_AS]

	yyvs102: SPECIAL [detachable EIFFEL_LIST [FEATURE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [FEATURE_AS]

	yyvsc102: INTEGER
			-- Capacity of semantic value stack `yyvs102'

	yyvsp102: INTEGER
			-- Top of semantic value stack `yyvs102'

	yyspecial_routines102: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [FEATURE_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [FEATURE_AS]]

	yyvs103: SPECIAL [detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]

	yyvsc103: INTEGER
			-- Capacity of semantic value stack `yyvs103'

	yyvsp103: INTEGER
			-- Top of semantic value stack `yyvs103'

	yyspecial_routines103: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]]

	yyvs104: SPECIAL [detachable EIFFEL_LIST [FEATURE_NAME]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [FEATURE_NAME]

	yyvsc104: INTEGER
			-- Capacity of semantic value stack `yyvs104'

	yyvsp104: INTEGER
			-- Top of semantic value stack `yyvs104'

	yyspecial_routines104: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [FEATURE_NAME]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [FEATURE_NAME]]

	yyvs105: SPECIAL [detachable EIFFEL_LIST [FEAT_NAME_ID_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [FEAT_NAME_ID_AS]

	yyvsc105: INTEGER
			-- Capacity of semantic value stack `yyvs105'

	yyvsp105: INTEGER
			-- Top of semantic value stack `yyvs105'

	yyspecial_routines105: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [FEAT_NAME_ID_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [FEAT_NAME_ID_AS]]

	yyvs106: SPECIAL [detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]

	yyvsc106: INTEGER
			-- Capacity of semantic value stack `yyvs106'

	yyvsp106: INTEGER
			-- Top of semantic value stack `yyvs106'

	yyspecial_routines106: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]]

	yyvs107: SPECIAL [detachable CREATION_CONSTRAIN_TRIPLE]
			-- Stack for semantic values of type detachable CREATION_CONSTRAIN_TRIPLE

	yyvsc107: INTEGER
			-- Capacity of semantic value stack `yyvs107'

	yyvsp107: INTEGER
			-- Top of semantic value stack `yyvs107'

	yyspecial_routines107: KL_SPECIAL_ROUTINES [detachable CREATION_CONSTRAIN_TRIPLE]
			-- Routines that ought to be in SPECIAL [detachable CREATION_CONSTRAIN_TRIPLE]

	yyvs108: SPECIAL [detachable UNDEFINE_CLAUSE_AS]
			-- Stack for semantic values of type detachable UNDEFINE_CLAUSE_AS

	yyvsc108: INTEGER
			-- Capacity of semantic value stack `yyvs108'

	yyvsp108: INTEGER
			-- Top of semantic value stack `yyvs108'

	yyspecial_routines108: KL_SPECIAL_ROUTINES [detachable UNDEFINE_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable UNDEFINE_CLAUSE_AS]

	yyvs109: SPECIAL [detachable REDEFINE_CLAUSE_AS]
			-- Stack for semantic values of type detachable REDEFINE_CLAUSE_AS

	yyvsc109: INTEGER
			-- Capacity of semantic value stack `yyvs109'

	yyvsp109: INTEGER
			-- Top of semantic value stack `yyvs109'

	yyspecial_routines109: KL_SPECIAL_ROUTINES [detachable REDEFINE_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable REDEFINE_CLAUSE_AS]

	yyvs110: SPECIAL [detachable SELECT_CLAUSE_AS]
			-- Stack for semantic values of type detachable SELECT_CLAUSE_AS

	yyvsc110: INTEGER
			-- Capacity of semantic value stack `yyvs110'

	yyvsp110: INTEGER
			-- Top of semantic value stack `yyvs110'

	yyspecial_routines110: KL_SPECIAL_ROUTINES [detachable SELECT_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable SELECT_CLAUSE_AS]

	yyvs111: SPECIAL [detachable FORMAL_GENERIC_LIST_AS]
			-- Stack for semantic values of type detachable FORMAL_GENERIC_LIST_AS

	yyvsc111: INTEGER
			-- Capacity of semantic value stack `yyvs111'

	yyvsp111: INTEGER
			-- Top of semantic value stack `yyvs111'

	yyspecial_routines111: KL_SPECIAL_ROUTINES [detachable FORMAL_GENERIC_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable FORMAL_GENERIC_LIST_AS]

	yyvs112: SPECIAL [detachable CLASS_LIST_AS]
			-- Stack for semantic values of type detachable CLASS_LIST_AS

	yyvsc112: INTEGER
			-- Capacity of semantic value stack `yyvs112'

	yyvsp112: INTEGER
			-- Top of semantic value stack `yyvs112'

	yyspecial_routines112: KL_SPECIAL_ROUTINES [detachable CLASS_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable CLASS_LIST_AS]

	yyvs113: SPECIAL [detachable INDEXING_CLAUSE_AS]
			-- Stack for semantic values of type detachable INDEXING_CLAUSE_AS

	yyvsc113: INTEGER
			-- Capacity of semantic value stack `yyvs113'

	yyvsp113: INTEGER
			-- Top of semantic value stack `yyvs113'

	yyspecial_routines113: KL_SPECIAL_ROUTINES [detachable INDEXING_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable INDEXING_CLAUSE_AS]

	yyvs114: SPECIAL [detachable ITERATION_AS]
			-- Stack for semantic values of type detachable ITERATION_AS

	yyvsc114: INTEGER
			-- Capacity of semantic value stack `yyvs114'

	yyvsp114: INTEGER
			-- Top of semantic value stack `yyvs114'

	yyspecial_routines114: KL_SPECIAL_ROUTINES [detachable ITERATION_AS]
			-- Routines that ought to be in SPECIAL [detachable ITERATION_AS]

	yyvs115: SPECIAL [detachable EIFFEL_LIST [INSTRUCTION_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [INSTRUCTION_AS]

	yyvsc115: INTEGER
			-- Capacity of semantic value stack `yyvs115'

	yyvsp115: INTEGER
			-- Top of semantic value stack `yyvs115'

	yyspecial_routines115: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [INSTRUCTION_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [INSTRUCTION_AS]]

	yyvs116: SPECIAL [detachable EIFFEL_LIST [INTERVAL_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [INTERVAL_AS]

	yyvsc116: INTEGER
			-- Capacity of semantic value stack `yyvs116'

	yyvsp116: INTEGER
			-- Top of semantic value stack `yyvs116'

	yyspecial_routines116: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [INTERVAL_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [INTERVAL_AS]]

	yyvs117: SPECIAL [detachable EIFFEL_LIST [OPERAND_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [OPERAND_AS]

	yyvsc117: INTEGER
			-- Capacity of semantic value stack `yyvs117'

	yyvsp117: INTEGER
			-- Top of semantic value stack `yyvs117'

	yyspecial_routines117: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [OPERAND_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [OPERAND_AS]]

	yyvs118: SPECIAL [detachable DELAYED_ACTUAL_LIST_AS]
			-- Stack for semantic values of type detachable DELAYED_ACTUAL_LIST_AS

	yyvsc118: INTEGER
			-- Capacity of semantic value stack `yyvs118'

	yyvsp118: INTEGER
			-- Top of semantic value stack `yyvs118'

	yyspecial_routines118: KL_SPECIAL_ROUTINES [detachable DELAYED_ACTUAL_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable DELAYED_ACTUAL_LIST_AS]

	yyvs119: SPECIAL [detachable PARENT_LIST_AS]
			-- Stack for semantic values of type detachable PARENT_LIST_AS

	yyvsc119: INTEGER
			-- Capacity of semantic value stack `yyvs119'

	yyvsp119: INTEGER
			-- Top of semantic value stack `yyvs119'

	yyspecial_routines119: KL_SPECIAL_ROUTINES [detachable PARENT_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable PARENT_LIST_AS]

	yyvs120: SPECIAL [detachable EIFFEL_LIST [RENAME_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [RENAME_AS]

	yyvsc120: INTEGER
			-- Capacity of semantic value stack `yyvs120'

	yyvsp120: INTEGER
			-- Top of semantic value stack `yyvs120'

	yyspecial_routines120: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [RENAME_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [RENAME_AS]]

	yyvs121: SPECIAL [detachable RENAME_CLAUSE_AS]
			-- Stack for semantic values of type detachable RENAME_CLAUSE_AS

	yyvsc121: INTEGER
			-- Capacity of semantic value stack `yyvs121'

	yyvsp121: INTEGER
			-- Top of semantic value stack `yyvs121'

	yyspecial_routines121: KL_SPECIAL_ROUTINES [detachable RENAME_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable RENAME_CLAUSE_AS]

	yyvs122: SPECIAL [detachable EIFFEL_LIST [STRING_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [STRING_AS]

	yyvsc122: INTEGER
			-- Capacity of semantic value stack `yyvs122'

	yyvsp122: INTEGER
			-- Top of semantic value stack `yyvs122'

	yyspecial_routines122: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [STRING_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [STRING_AS]]

	yyvs123: SPECIAL [detachable KEY_LIST_AS]
			-- Stack for semantic values of type detachable KEY_LIST_AS

	yyvsc123: INTEGER
			-- Capacity of semantic value stack `yyvs123'

	yyvsp123: INTEGER
			-- Top of semantic value stack `yyvs123'

	yyspecial_routines123: KL_SPECIAL_ROUTINES [detachable KEY_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable KEY_LIST_AS]

	yyvs124: SPECIAL [detachable EIFFEL_LIST [TAGGED_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [TAGGED_AS]

	yyvsc124: INTEGER
			-- Capacity of semantic value stack `yyvs124'

	yyvsp124: INTEGER
			-- Top of semantic value stack `yyvs124'

	yyspecial_routines124: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [TAGGED_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [TAGGED_AS]]

	yyvs125: SPECIAL [detachable TYPE_LIST_AS]
			-- Stack for semantic values of type detachable TYPE_LIST_AS

	yyvsc125: INTEGER
			-- Capacity of semantic value stack `yyvs125'

	yyvsp125: INTEGER
			-- Top of semantic value stack `yyvs125'

	yyspecial_routines125: KL_SPECIAL_ROUTINES [detachable TYPE_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable TYPE_LIST_AS]

	yyvs126: SPECIAL [detachable TYPE_DEC_LIST_AS]
			-- Stack for semantic values of type detachable TYPE_DEC_LIST_AS

	yyvsc126: INTEGER
			-- Capacity of semantic value stack `yyvs126'

	yyvsp126: INTEGER
			-- Top of semantic value stack `yyvs126'

	yyspecial_routines126: KL_SPECIAL_ROUTINES [detachable TYPE_DEC_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable TYPE_DEC_LIST_AS]

	yyvs127: SPECIAL [detachable LIST_DEC_LIST_AS]
			-- Stack for semantic values of type detachable LIST_DEC_LIST_AS

	yyvsc127: INTEGER
			-- Capacity of semantic value stack `yyvs127'

	yyvsp127: INTEGER
			-- Top of semantic value stack `yyvs127'

	yyspecial_routines127: KL_SPECIAL_ROUTINES [detachable LIST_DEC_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable LIST_DEC_LIST_AS]

	yyvs128: SPECIAL [detachable LOCAL_DEC_LIST_AS]
			-- Stack for semantic values of type detachable LOCAL_DEC_LIST_AS

	yyvsc128: INTEGER
			-- Capacity of semantic value stack `yyvs128'

	yyvsp128: INTEGER
			-- Top of semantic value stack `yyvs128'

	yyspecial_routines128: KL_SPECIAL_ROUTINES [detachable LOCAL_DEC_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable LOCAL_DEC_LIST_AS]

	yyvs129: SPECIAL [detachable FORMAL_ARGU_DEC_LIST_AS]
			-- Stack for semantic values of type detachable FORMAL_ARGU_DEC_LIST_AS

	yyvsc129: INTEGER
			-- Capacity of semantic value stack `yyvs129'

	yyvsp129: INTEGER
			-- Top of semantic value stack `yyvs129'

	yyspecial_routines129: KL_SPECIAL_ROUTINES [detachable FORMAL_ARGU_DEC_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable FORMAL_ARGU_DEC_LIST_AS]

	yyvs130: SPECIAL [detachable CONSTRAINT_TRIPLE]
			-- Stack for semantic values of type detachable CONSTRAINT_TRIPLE

	yyvsc130: INTEGER
			-- Capacity of semantic value stack `yyvs130'

	yyvsp130: INTEGER
			-- Top of semantic value stack `yyvs130'

	yyspecial_routines130: KL_SPECIAL_ROUTINES [detachable CONSTRAINT_TRIPLE]
			-- Routines that ought to be in SPECIAL [detachable CONSTRAINT_TRIPLE]

	yyvs131: SPECIAL [detachable CONSTRAINT_LIST_AS]
			-- Stack for semantic values of type detachable CONSTRAINT_LIST_AS

	yyvsc131: INTEGER
			-- Capacity of semantic value stack `yyvs131'

	yyvsp131: INTEGER
			-- Top of semantic value stack `yyvs131'

	yyspecial_routines131: KL_SPECIAL_ROUTINES [detachable CONSTRAINT_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable CONSTRAINT_LIST_AS]

	yyvs132: SPECIAL [detachable CONSTRAINING_TYPE_AS]
			-- Stack for semantic values of type detachable CONSTRAINING_TYPE_AS

	yyvsc132: INTEGER
			-- Capacity of semantic value stack `yyvs132'

	yyvsp132: INTEGER
			-- Top of semantic value stack `yyvs132'

	yyspecial_routines132: KL_SPECIAL_ROUTINES [detachable CONSTRAINING_TYPE_AS]
			-- Routines that ought to be in SPECIAL [detachable CONSTRAINING_TYPE_AS]

feature {NONE} -- Constants

	yyFinal: INTEGER = 1277
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 145
			-- Number of tokens

	yyLast: INTEGER = 5501
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 399
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 403
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
