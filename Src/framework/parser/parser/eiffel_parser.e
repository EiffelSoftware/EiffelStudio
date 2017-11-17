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
			when 12 then
				yyvsp12 := yyvsp12 + 1
				if yyvsp12 >= yyvsc12 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs12")
					end
					yyvsc12 := yyvsc12 + yyInitial_yyvs_size
					yyvs12 := yyspecial_routines12.aliased_resized_area (yyvs12, yyvsc12)
				end
				yyspecial_routines12.force (yyvs12, last_detachable_keyword_as_value, yyvsp12)
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
			when 5 then
				yyvsp5 := yyvsp5 + 1
				if yyvsp5 >= yyvsc5 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs5")
					end
					yyvsc5 := yyvsc5 + yyInitial_yyvs_size
					yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
				end
				yyspecial_routines5.force (yyvs5, last_detachable_bool_as_value, yyvsp5)
			when 6 then
				yyvsp6 := yyvsp6 + 1
				if yyvsp6 >= yyvsc6 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs6")
					end
					yyvsc6 := yyvsc6 + yyInitial_yyvs_size
					yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
				end
				yyspecial_routines6.force (yyvs6, last_detachable_result_as_value, yyvsp6)
			when 7 then
				yyvsp7 := yyvsp7 + 1
				if yyvsp7 >= yyvsc7 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs7")
					end
					yyvsc7 := yyvsc7 + yyInitial_yyvs_size
					yyvs7 := yyspecial_routines7.aliased_resized_area (yyvs7, yyvsc7)
				end
				yyspecial_routines7.force (yyvs7, last_detachable_retry_as_value, yyvsp7)
			when 8 then
				yyvsp8 := yyvsp8 + 1
				if yyvsp8 >= yyvsc8 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs8")
					end
					yyvsc8 := yyvsc8 + yyInitial_yyvs_size
					yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
				end
				yyspecial_routines8.force (yyvs8, last_detachable_unique_as_value, yyvsp8)
			when 9 then
				yyvsp9 := yyvsp9 + 1
				if yyvsp9 >= yyvsc9 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs9")
					end
					yyvsc9 := yyvsc9 + yyInitial_yyvs_size
					yyvs9 := yyspecial_routines9.aliased_resized_area (yyvs9, yyvsc9)
				end
				yyspecial_routines9.force (yyvs9, last_detachable_current_as_value, yyvsp9)
			when 10 then
				yyvsp10 := yyvsp10 + 1
				if yyvsp10 >= yyvsc10 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs10")
					end
					yyvsc10 := yyvsc10 + yyInitial_yyvs_size
					yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
				end
				yyspecial_routines10.force (yyvs10, last_detachable_deferred_as_value, yyvsp10)
			when 11 then
				yyvsp11 := yyvsp11 + 1
				if yyvsp11 >= yyvsc11 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs11")
					end
					yyvsc11 := yyvsc11 + yyInitial_yyvs_size
					yyvs11 := yyspecial_routines11.aliased_resized_area (yyvs11, yyvsc11)
				end
				yyspecial_routines11.force (yyvs11, last_detachable_void_as_value, yyvsp11)
			when 13 then
				yyvsp13 := yyvsp13 + 1
				if yyvsp13 >= yyvsc13 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs13")
					end
					yyvsc13 := yyvsc13 + yyInitial_yyvs_size
					yyvs13 := yyspecial_routines13.aliased_resized_area (yyvs13, yyvsc13)
				end
				yyspecial_routines13.force (yyvs13, last_keyword_id_value, yyvsp13)
			when 14 then
				yyvsp14 := yyvsp14 + 1
				if yyvsp14 >= yyvsc14 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs14")
					end
					yyvsc14 := yyvsc14 + yyInitial_yyvs_size
					yyvs14 := yyspecial_routines14.aliased_resized_area (yyvs14, yyvsc14)
				end
				yyspecial_routines14.force (yyvs14, last_detachable_string_as_value, yyvsp14)
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
				type_node := yyvs82.item (yyvsp82)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp82 := yyvsp82 -1
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
				feature_node := yyvs49.item (yyvsp49)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp49 := yyvsp49 -1
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
				expression_node := yyvs46.item (yyvsp46)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp46 := yyvsp46 -1
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
				indexing_node := yyvs109.item (yyvsp109)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp109 := yyvsp109 -1
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
				invariant_node := yyvs63.item (yyvsp63)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp63 := yyvsp63 -1
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
	yyvsp12 := yyvsp12 -1
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
				entity_declaration_node := yyvs123.item (yyvsp123)
				formal_parameters.wipe_out
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp12 := yyvsp12 -1
	yyvsp123 := yyvsp123 -1
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

				if attached yyvs18.item (yyvsp18 - 1) as l_external then
					temp_string_as1 := l_external.second
				else
					temp_string_as1 := Void
				end
				if attached yyvs18.item (yyvsp18) as l_obsolete then
					temp_string_as2 := l_obsolete.second
				else
					temp_string_as2 := Void
				end
				
				root_node := new_class_description (yyvs2.item (yyvsp2), temp_string_as1,
					is_deferred, is_expanded, is_frozen_class, is_external_class, is_partial_class,
					yyvs109.item (yyvsp109 - 1), yyvs109.item (yyvsp109), yyvs107.item (yyvsp107), yyvs115.item (yyvsp115 - 1), yyvs115.item (yyvsp115), yyvs92.item (yyvsp92), yyvs91.item (yyvsp91), yyvs100.item (yyvsp100), yyvs63.item (yyvsp63), suppliers, temp_string_as2, yyvs12.item (yyvsp12))
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
					if attached yyvs18.item (yyvsp18 - 1) as l_external then
						l_root_node.set_alias_keyword (l_external.first)
					end
					if attached yyvs18.item (yyvsp18) as l_obsolete then
						l_root_node.set_obsolete_keyword (l_obsolete.first)
					end
					l_root_node.set_header_mark (frozen_keyword, expanded_keyword, deferred_keyword, external_keyword)
					l_root_node.set_class_keyword (yyvs12.item (yyvsp12 - 1))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 19
	yyvsp1 := yyvsp1 -4
	yyvsp109 := yyvsp109 -2
	yyvsp12 := yyvsp12 -2
	yyvsp2 := yyvsp2 -1
	yyvsp107 := yyvsp107 -1
	yyvsp18 := yyvsp18 -2
	yyvsp115 := yyvsp115 -2
	yyvsp92 := yyvsp92 -1
	yyvsp91 := yyvsp91 -1
	yyvsp100 := yyvsp100 -1
	yyvsp63 := yyvsp63 -1
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
			yyval109: detachable INDEXING_CLAUSE_AS
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

	yy_do_action_16
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs109.item (yyvsp109) as l_list then
					yyval109 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs13.item (yyvsp13)))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines109.force (yyvs109, yyval109, yyvsp109)
end
		end

	yy_do_action_17
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_indexing_clause_as (0) as l_list then
					yyval109 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs13.item (yyvsp13)))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_18
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs109.item (yyvsp109) as l_list then
					yyval109 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs13.item (yyvsp13)))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines109.force (yyvs109, yyval109, yyvsp109)
end
		end

	yy_do_action_19
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_indexing_clause_as (0) as l_list then
					yyval109 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs13.item (yyvsp13)))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_20
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable INDEXING_CLAUSE_AS
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

	yy_do_action_21
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_indexing_clause_as (0) as l_list then
						yyval109 := l_list
						l_list.set_indexing_keyword (extract_keyword (yyvs13.item (yyvsp13)))
						l_list.set_end_keyword (yyvs12.item (yyvsp12))
				end		
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Missing `attribute' keyword before `end' keyword."))
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp109 := yyvsp109 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_22
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs109.item (yyvsp109) as l_list then
					yyval109 := l_list
					if attached yyvs13.item (yyvsp13) as l_indexing then
						l_list.set_indexing_keyword (extract_keyword (l_indexing))
					end
					if attached yyvs12.item (yyvsp12) as l_end then
						l_list.set_end_keyword (l_end)
					end
				end				
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Missing `attribute' keyword before `end' keyword."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp13 := yyvsp13 -1
	yyvsp1 := yyvsp1 -2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines109.force (yyvs109, yyval109, yyvsp109)
end
		end

	yy_do_action_23
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := ast_factory.new_indexing_clause_as (counter_value + 1)
				if attached yyval109 as l_list and then attached yyvs57.item (yyvsp57) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp57 := yyvsp57 -1
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

	yy_do_action_24
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := yyvs109.item (yyvsp109)
				if attached yyval109 as l_list and then attached yyvs57.item (yyvsp57) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp57 := yyvsp57 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines109.force (yyvs109, yyval109, yyvsp109)
end
		end

	yy_do_action_25
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := ast_factory.new_indexing_clause_as (counter_value + 1)
				if attached yyval109 as l_list and then attached yyvs57.item (yyvsp57) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp57 := yyvsp57 -1
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

	yy_do_action_26
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := yyvs109.item (yyvsp109)
				if attached yyval109 as l_list and then attached yyvs57.item (yyvsp57) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp57 := yyvsp57 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines109.force (yyvs109, yyval109, yyvsp109)
end
		end

	yy_do_action_27
			--|#line <not available> "eiffel.y"
		local
			yyval57: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := yyvs57.item (yyvsp57) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines57.force (yyvs57, yyval57, yyvsp57)
end
		end

	yy_do_action_28
			--|#line <not available> "eiffel.y"
		local
			yyval57: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := yyvs57.item (yyvsp57) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines57.force (yyvs57, yyval57, yyvsp57)
end
		end

	yy_do_action_29
			--|#line <not available> "eiffel.y"
		local
			yyval57: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval57 := ast_factory.new_index_as (yyvs2.item (yyvsp2), yyvs89.item (yyvsp89), yyvs4.item (yyvsp4 - 1))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp57 := yyvsp57 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_30
			--|#line <not available> "eiffel.y"
		local
			yyval57: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval57 := ast_factory.new_index_as (Void, yyvs89.item (yyvsp89), Void)
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs89.item (yyvsp89)), token_column (yyvs89.item (yyvsp89)), filename,
						once "Missing `Index' part of `Index_clause'."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp57 := yyvsp57 + 1
	yyvsp89 := yyvsp89 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_31
			--|#line <not available> "eiffel.y"
		local
			yyval57: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval57 := ast_factory.new_index_as (yyvs2.item (yyvsp2), yyvs89.item (yyvsp89), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp57 := yyvsp57 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_32
			--|#line <not available> "eiffel.y"
		local
			yyval89: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval89 := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if attached yyval89 as l_list and then attached yyvs28.item (yyvsp28) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp89 := yyvsp89 + 1
	yyvsp28 := yyvsp28 -1
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

	yy_do_action_33
			--|#line <not available> "eiffel.y"
		local
			yyval89: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval89 := yyvs89.item (yyvsp89)
				if attached yyval89 as l_list and then attached yyvs28.item (yyvsp28) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp28 := yyvsp28 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines89.force (yyvs89, yyval89, yyvsp89)
end
		end

	yy_do_action_34
			--|#line <not available> "eiffel.y"
		local
			yyval89: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval89 := ast_factory.new_eiffel_list_atomic_as (0)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp89 := yyvsp89 + 1
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

	yy_do_action_35
			--|#line <not available> "eiffel.y"
		local
			yyval89: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval89 := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if attached yyval89 as l_list and then attached yyvs28.item (yyvsp28) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp89 := yyvsp89 + 1
	yyvsp28 := yyvsp28 -1
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

	yy_do_action_36
			--|#line <not available> "eiffel.y"
		local
			yyval89: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval89 := yyvs89.item (yyvsp89)
				if attached yyval89 as l_list and then attached yyvs28.item (yyvsp28) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp28 := yyvsp28 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines89.force (yyvs89, yyval89, yyvsp89)
end
		end

	yy_do_action_37
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_38
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs28.item (yyvsp28) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines28.force (yyvs28, yyval28, yyvsp28)
end
		end

	yy_do_action_39
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := ast_factory.new_custom_attribute_as (yyvs40.item (yyvsp40), Void, yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp28 := yyvsp28 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp40 := yyvsp40 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_40
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := ast_factory.new_custom_attribute_as (yyvs40.item (yyvsp40), yyvs81.item (yyvsp81), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp28 := yyvsp28 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp40 := yyvsp40 -1
	yyvsp81 := yyvsp81 -1
	yyvsp12 := yyvsp12 -1
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
				deferred_keyword := yyvs10.item (yyvsp10)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp10 := yyvsp10 -1
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
				expanded_keyword := yyvs12.item (yyvsp12)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp12 := yyvsp12 -1
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
				frozen_keyword := yyvs12.item (yyvsp12)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
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
					external_keyword := yyvs12.item (yyvsp12)
				else
						-- Trigger a syntax error.
					raise_error
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
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
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval12 := yyvs12.item (yyvsp12);
			is_partial_class := false;
			formal_parameters.wipe_out
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_53
			--|#line <not available> "eiffel.y"
		local
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval12 := yyvs12.item (yyvsp12);
			is_partial_class := true;
			formal_parameters.wipe_out
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_54
			--|#line <not available> "eiffel.y"
		local
			yyval18: detachable PAIR [KEYWORD_AS, STRING_AS]
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

	yy_do_action_55
			--|#line <not available> "eiffel.y"
		local
			yyval18: detachable PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval18 := ast_factory.new_keyword_string_pair (yyvs12.item (yyvsp12), yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp18 := yyvsp18 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp14 := yyvsp14 -1
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

	yy_do_action_56
			--|#line <not available> "eiffel.y"
		local
			yyval100: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp100 := yyvsp100 + 1
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

	yy_do_action_57
			--|#line <not available> "eiffel.y"
		local
			yyval100: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs100.item (yyvsp100) as l_list then
					if l_list.is_empty then
						yyval100 := Void
					else
						yyval100 := l_list
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines100.force (yyvs100, yyval100, yyvsp100)
end
		end

	yy_do_action_58
			--|#line <not available> "eiffel.y"
		local
			yyval100: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval100 := ast_factory.new_eiffel_list_feature_clause_as (counter_value + 1)
				if attached yyval100 as l_list and then attached yyvs50.item (yyvsp50) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp100 := yyvsp100 + 1
	yyvsp50 := yyvsp50 -1
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

	yy_do_action_59
			--|#line <not available> "eiffel.y"
		local
			yyval100: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval100 := yyvs100.item (yyvsp100)
				if attached yyval100 as l_list and then attached yyvs50.item (yyvsp50) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines100.force (yyvs100, yyval100, yyvsp100)
end
		end

	yy_do_action_60
			--|#line <not available> "eiffel.y"
		local
			yyval50: detachable FEATURE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval50 := ast_factory.new_feature_clause_as (yyvs35.item (yyvsp35),
				ast_factory.new_eiffel_list_feature_as (0), fclause_pos, feature_clause_end_position) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp50 := yyvsp50 + 1
	yyvsp35 := yyvsp35 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_61
			--|#line <not available> "eiffel.y"
		local
			yyval50: detachable FEATURE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval50 := ast_factory.new_feature_clause_as (yyvs35.item (yyvsp35), yyvs99.item (yyvsp99), fclause_pos, feature_clause_end_position) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp50 := yyvsp50 + 1
	yyvsp35 := yyvsp35 -1
	yyvsp1 := yyvsp1 -3
	yyvsp99 := yyvsp99 -1
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

	yy_do_action_62
			--|#line <not available> "eiffel.y"
		local
			yyval35: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs35.item (yyvsp35) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp35 := yyvsp35 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_63
			--|#line <not available> "eiffel.y"
		local
			yyval35: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs12.item (yyvsp12) as l_keyword then
						-- Originally, it was 8, I changed it to 7, delete the following line when fully tested. (Jason)
					l_keyword.set_position (line, column, position, 7, character_column, character_position, 7)
					fclause_pos := l_keyword
				else
						-- Originally, it was 8, I changed it to 7 (Jason)
					fclause_pos := ast_factory.new_feature_keyword_as (line, column, position, 7, character_column, character_position, 7, Current)
				end
				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp35 := yyvsp35 + 1
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

	yy_do_action_64
			--|#line <not available> "eiffel.y"
		local
			yyval35: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp35 := yyvsp35 + 1
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

	yy_do_action_65
			--|#line <not available> "eiffel.y"
		local
			yyval35: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_client_as (yyvs108.item (yyvsp108)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp108 := yyvsp108 -1
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

	yy_do_action_66
			--|#line <not available> "eiffel.y"
		local
			yyval108: detachable CLASS_LIST_AS
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
				yyval108 := ast_factory.new_class_list_as (1)
				if attached yyval108 as l_list and then attached new_none_id as l_none_id then
					l_list.reverse_extend (l_none_id)
					l_list.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_list.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_67
			--|#line <not available> "eiffel.y"
		local
			yyval108: detachable CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs108.item (yyvsp108) as l_list then
					yyval108 := l_list
					l_list.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_list.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyspecial_routines108.force (yyvs108, yyval108, yyvsp108)
end
		end

	yy_do_action_68
			--|#line <not available> "eiffel.y"
		local
			yyval108: detachable CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval108 := ast_factory.new_class_list_as (counter_value + 1)
				if attached yyval108 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val)
					suppliers.insert_light_supplier_id (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp108 := yyvsp108 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_69
			--|#line <not available> "eiffel.y"
		local
			yyval108: detachable CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval108 := yyvs108.item (yyvsp108)
				if attached yyval108 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val)
					suppliers.insert_light_supplier_id (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines108.force (yyvs108, yyval108, yyvsp108)
end
		end

	yy_do_action_70
			--|#line <not available> "eiffel.y"
		local
			yyval99: detachable EIFFEL_LIST [FEATURE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval99 := ast_factory.new_eiffel_list_feature_as (counter_value + 1)
				if attached yyval99 as l_list and then attached yyvs49.item (yyvsp49) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp99 := yyvsp99 + 1
	yyvsp49 := yyvsp49 -1
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

	yy_do_action_71
			--|#line <not available> "eiffel.y"
		local
			yyval99: detachable EIFFEL_LIST [FEATURE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval99 := yyvs99.item (yyvsp99)
				if attached yyval99 as l_list and then attached yyvs49.item (yyvsp49) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines99.force (yyvs99, yyval99, yyvsp99)
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
			yyval49: detachable FEATURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval49 := ast_factory.new_feature_as (yyvs101.item (yyvsp101), yyvs30.item (yyvsp30), feature_indexes, position)
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
					attached (yyval49) as l_feature_as and then 
					attached l_feature_as.once_as as l_once_as
				then
					if l_once_as.has_key_conflict (yyval49) then
						report_one_error (ast_factory.new_vvok1_error (token_line (l_once_as), token_column (l_once_as), filename, yyval49))
					elseif l_once_as.has_invalid_key (yyval49) then
						if attached l_once_as.invalid_key (yyval49) as l_once_invalid_key then
							report_one_error (ast_factory.new_vvok2_error (token_line (l_once_invalid_key), token_column (l_once_invalid_key), filename, yyval49))
						else
							report_one_error (ast_factory.new_vvok2_error (token_line (l_once_as), token_column (l_once_as), filename, yyval49))
						end
					end
				end

				feature_indexes := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp49 := yyvsp49 -1
	yyvsp1 := yyvsp1 -3
	yyvsp101 := yyvsp101 -1
	yyvsp30 := yyvsp30 -1
	yyspecial_routines49.force (yyvs49, yyval49, yyvsp49)
end
		end

	yy_do_action_75
			--|#line <not available> "eiffel.y"
		local
			yyval49: detachable FEATURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

enter_scope
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp49 := yyvsp49 + 1
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

	yy_do_action_76
			--|#line <not available> "eiffel.y"
		local
			yyval49: detachable FEATURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

leave_scope
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp49 := yyvsp49 + 1
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

	yy_do_action_77
			--|#line <not available> "eiffel.y"
		local
			yyval101: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval101 := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if attached yyval101 as l_list and then attached yyvs88.item (yyvsp88) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp101 := yyvsp101 + 1
	yyvsp88 := yyvsp88 -1
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

	yy_do_action_78
			--|#line <not available> "eiffel.y"
		local
			yyval101: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval101 := yyvs101.item (yyvsp101)
				if attached yyval101 as l_list and then attached yyvs88.item (yyvsp88) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp88 := yyvsp88 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines101.force (yyvs101, yyval101, yyvsp101)
end
		end

	yy_do_action_79
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval88 := yyvs88.item (yyvsp88) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines88.force (yyvs88, yyval88, yyvsp88)
end
		end

	yy_do_action_80
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs88.item (yyvsp88) as l_name then
					yyval88 := l_name
					l_name.set_frozen_keyword (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines88.force (yyvs88, yyval88, yyvsp88)
end
		end

	yy_do_action_81
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval88 := yyvs88.item (yyvsp88) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines88.force (yyvs88, yyval88, yyvsp88)
end
		end

	yy_do_action_82
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs15.item (yyvsp15) as l_alias then
					yyval88 := ast_factory.new_feature_name_alias_as (yyvs2.item (yyvsp2), l_alias.alias_name, has_convert_mark, l_alias.alias_keyword, l_alias.convert_keyword)
				else
					yyval88 := ast_factory.new_feature_name_alias_as (yyvs2.item (yyvsp2), Void, has_convert_mark, Void, Void)
				end
				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp88 := yyvsp88 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
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

	yy_do_action_83
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval88 := ast_factory.new_feature_name_id_as (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp88 := yyvsp88 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_84
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval88 := yyvs88.item (yyvsp88) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines88.force (yyvs88, yyval88, yyvsp88)
end
		end

	yy_do_action_85
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval88 := yyvs88.item (yyvsp88) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines88.force (yyvs88, yyval88, yyvsp88)
end
		end

	yy_do_action_86
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval88 := ast_factory.new_infix_as (yyvs14.item (yyvsp14), yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use the alias form of the infix routine."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp88 := yyvsp88 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp14 := yyvsp14 -1
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

	yy_do_action_87
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval88 := ast_factory.new_prefix_as (yyvs14.item (yyvsp14), yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use the alias form of the prefix routine."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp88 := yyvsp88 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp14 := yyvsp14 -1
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

	yy_do_action_88
			--|#line <not available> "eiffel.y"
		local
			yyval15: detachable ALIAS_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval15 := ast_factory.new_alias_triple (yyvs12.item (yyvsp12 - 1), yyvs14.item (yyvsp14), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp14 := yyvsp14 -1
	if yyvsp15 >= yyvsc15 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs15")
		end
		yyvsc15 := yyvsc15 + yyInitial_yyvs_size
		yyvs15 := yyspecial_routines15.aliased_resized_area (yyvs15, yyvsc15)
	end
	yyspecial_routines15.force (yyvs15, yyval15, yyvsp15)
end
		end

	yy_do_action_89
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_90
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_91
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_92
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_93
			--|#line <not available> "eiffel.y"
		local
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

has_convert_mark := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp12 := yyvsp12 + 1
	if yyvsp12 >= yyvsc12 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs12")
		end
		yyvsc12 := yyvsc12 + yyInitial_yyvs_size
		yyvs12 := yyspecial_routines12.aliased_resized_area (yyvs12, yyvsc12)
	end
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_94
			--|#line <not available> "eiffel.y"
		local
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

has_convert_mark := True
				yyval12 := yyvs12.item (yyvsp12)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_95
			--|#line <not available> "eiffel.y"
		local
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval12 := Void 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp12 := yyvsp12 + 1
	if yyvsp12 >= yyvsc12 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs12")
		end
		yyvsc12 := yyvsc12 + yyInitial_yyvs_size
		yyvs12 := yyspecial_routines12.aliased_resized_area (yyvs12, yyvsc12)
	end
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_96
			--|#line <not available> "eiffel.y"
		local
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval12 := extract_keyword (yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp12 := yyvsp12 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp12 >= yyvsc12 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs12")
		end
		yyvsc12 := yyvsc12 + yyInitial_yyvs_size
		yyvs12 := yyspecial_routines12.aliased_resized_area (yyvs12, yyvsc12)
	end
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_97
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Attribute case
				if attached yyvs17.item (yyvsp17) as l_assigner_mark then
					yyval30 := ast_factory.new_body_as (Void, yyvs82.item (yyvsp82), l_assigner_mark.second, Void, yyvs4.item (yyvsp4), Void, l_assigner_mark.first, yyvs109.item (yyvsp109))
				else
					yyval30 := ast_factory.new_body_as (Void, yyvs82.item (yyvsp82), Void, Void, yyvs4.item (yyvsp4), Void, Void, yyvs109.item (yyvsp109))
				end				
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp30 := yyvsp30 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp82 := yyvsp82 -1
	yyvsp17 := yyvsp17 -1
	yyvsp109 := yyvsp109 -1
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

	yy_do_action_98
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Constant case
				if attached yyvs17.item (yyvsp17) as l_assigner_mark then
					yyval30 := ast_factory.new_body_as (Void, yyvs82.item (yyvsp82), l_assigner_mark.second, yyvs36.item (yyvsp36), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), l_assigner_mark.first, yyvs109.item (yyvsp109))
				else
					yyval30 := ast_factory.new_body_as (Void, yyvs82.item (yyvsp82), Void, yyvs36.item (yyvsp36), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), Void, yyvs109.item (yyvsp109))
				end
				
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp30 := yyvsp30 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp82 := yyvsp82 -1
	yyvsp17 := yyvsp17 -1
	yyvsp36 := yyvsp36 -1
	yyvsp109 := yyvsp109 -1
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

	yy_do_action_99
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Constant case
				if attached yyvs17.item (yyvsp17) as l_assigner_mark then
					yyval30 := ast_factory.new_body_as (Void, yyvs82.item (yyvsp82), l_assigner_mark.second, yyvs36.item (yyvsp36), yyvs4.item (yyvsp4), extract_keyword (yyvs13.item (yyvsp13)), l_assigner_mark.first, yyvs109.item (yyvsp109))
				else
					yyval30 := ast_factory.new_body_as (Void, yyvs82.item (yyvsp82), Void, yyvs36.item (yyvsp36), yyvs4.item (yyvsp4), extract_keyword (yyvs13.item (yyvsp13)), Void, yyvs109.item (yyvsp109))
				end
				
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp30 := yyvsp30 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp82 := yyvsp82 -1
	yyvsp17 := yyvsp17 -1
	yyvsp13 := yyvsp13 -1
	yyvsp36 := yyvsp36 -1
	yyvsp109 := yyvsp109 -1
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

	yy_do_action_100
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- procedure without arguments		
				yyval30 := ast_factory.new_body_as (Void, Void, Void, yyvs77.item (yyvsp77), Void, yyvs12.item (yyvsp12), Void, yyvs109.item (yyvsp109))
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp30 := yyvsp30 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp109 := yyvsp109 -1
	yyvsp77 := yyvsp77 -1
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

	yy_do_action_101
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function without arguments
				if attached yyvs17.item (yyvsp17) as l_assigner_mark then
					yyval30 := ast_factory.new_body_as (Void, yyvs82.item (yyvsp82), l_assigner_mark.second, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), extract_keyword (yyvs13.item (yyvsp13)), l_assigner_mark.first, yyvs109.item (yyvsp109))
				else
					yyval30 := ast_factory.new_body_as (Void, yyvs82.item (yyvsp82), Void, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), extract_keyword (yyvs13.item (yyvsp13)), Void, yyvs109.item (yyvsp109))
				end
				
				feature_indexes := yyvs109.item (yyvsp109)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp30 := yyvsp30 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp82 := yyvsp82 -1
	yyvsp17 := yyvsp17 -1
	yyvsp13 := yyvsp13 -1
	yyvsp109 := yyvsp109 -1
	yyvsp77 := yyvsp77 -1
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

	yy_do_action_102
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function without arguments
				if attached yyvs17.item (yyvsp17) as l_assigner_mark then
					yyval30 := ast_factory.new_body_as (Void, yyvs82.item (yyvsp82), l_assigner_mark.second, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), Void, l_assigner_mark.first, yyvs109.item (yyvsp109))
				else
					yyval30 := ast_factory.new_body_as (Void, yyvs82.item (yyvsp82), Void, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), Void, Void, yyvs109.item (yyvsp109))
				end
				
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp30 := yyvsp30 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp82 := yyvsp82 -1
	yyvsp17 := yyvsp17 -1
	yyvsp109 := yyvsp109 -1
	yyvsp77 := yyvsp77 -1
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

	yy_do_action_103
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- procedure with arguments
				yyval30 := ast_factory.new_body_as (yyvs125.item (yyvsp125), Void, Void, yyvs77.item (yyvsp77), Void, yyvs12.item (yyvsp12), Void, yyvs109.item (yyvsp109))
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp30 := yyvsp30 + 1
	yyvsp125 := yyvsp125 -1
	yyvsp12 := yyvsp12 -1
	yyvsp109 := yyvsp109 -1
	yyvsp77 := yyvsp77 -1
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

	yy_do_action_104
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function with arguments
				if attached yyvs17.item (yyvsp17) as l_assigner_mark then
					yyval30 := ast_factory.new_body_as (yyvs125.item (yyvsp125), yyvs82.item (yyvsp82), l_assigner_mark.second, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), yyvs12.item (yyvsp12), l_assigner_mark.first, yyvs109.item (yyvsp109))
				else
					yyval30 := ast_factory.new_body_as (yyvs125.item (yyvsp125), yyvs82.item (yyvsp82), Void, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), yyvs12.item (yyvsp12), Void, yyvs109.item (yyvsp109))
				end				
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp30 := yyvsp30 + 1
	yyvsp125 := yyvsp125 -1
	yyvsp4 := yyvsp4 -1
	yyvsp82 := yyvsp82 -1
	yyvsp17 := yyvsp17 -1
	yyvsp12 := yyvsp12 -1
	yyvsp109 := yyvsp109 -1
	yyvsp77 := yyvsp77 -1
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

	yy_do_action_105
			--|#line <not available> "eiffel.y"
		local
			yyval17: detachable PAIR [KEYWORD_AS, ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval17 := ast_factory.new_assigner_mark_as (Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp17 := yyvsp17 + 1
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

	yy_do_action_106
			--|#line <not available> "eiffel.y"
		local
			yyval17: detachable PAIR [KEYWORD_AS, ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval17 := ast_factory.new_assigner_mark_as (extract_keyword (yyvs13.item (yyvsp13)), yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp17 := yyvsp17 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_107
			--|#line <not available> "eiffel.y"
		local
			yyval36: detachable CONSTANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval36 := ast_factory.new_constant_as (yyvs28.item (yyvsp28)) 
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp28 := yyvsp28 -1
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

	yy_do_action_108
			--|#line <not available> "eiffel.y"
		local
			yyval36: detachable CONSTANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := ast_factory.new_constant_as (yyvs8.item (yyvsp8)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp8 := yyvsp8 -1
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

	yy_do_action_109
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval115 := Void 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp115 := yyvsp115 + 1
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

	yy_do_action_110
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not conforming_inheritance_flag then
						-- Conforming inheritance
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
							once "Use `inherit ANY' or do not specify an empty inherit clause"))
					end
					yyval115 := ast_factory.new_eiffel_list_parent_as (0)
					if attached yyval115 as l_inheritance then
						l_inheritance.set_inheritance_tokens (yyvs12.item (yyvsp12), Void, Void, Void)
					end
				else
						-- Raise error as conforming inheritance has already been specified
					if non_conforming_inheritance_flag then
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename, "Conforming inheritance clause must come before non conforming inheritance clause"))
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename, "Only one conforming inheritance clause allowed per class"))
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp115 := yyvsp115 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_111
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not conforming_inheritance_flag then
						-- Conforming inheritance
					yyval115 := yyvs115.item (yyvsp115)
					if attached yyval115 as l_inheritance then
						l_inheritance.set_inheritance_tokens (yyvs12.item (yyvsp12), Void, Void, Void)
					end
				else
						-- Raise error as conforming inheritance has already been specified
					if non_conforming_inheritance_flag then
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename, "Conforming inheritance clause must come before non conforming inheritance clause"))
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename, "Only one conforming inheritance clause allowed per class"))
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines115.force (yyvs115, yyval115, yyvsp115)
end
		end

	yy_do_action_112
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval115 := yyvs115.item (yyvsp115)
				if attached yyval115 as l_inheritance then
					l_inheritance.set_inheritance_tokens (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4 - 1), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp115 := yyvsp115 -1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -2
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines115.force (yyvs115, yyval115, yyvsp115)
end
		end

	yy_do_action_113
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable PARENT_LIST_AS
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
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename, "Only one non-conforming inheritance clause allowed per class"))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp115 := yyvsp115 + 1
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

	yy_do_action_114
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval115 := ast_factory.new_eiffel_list_parent_as (counter_value + 1)
				if attached yyval115 as l_list and then attached yyvs69.item (yyvsp69) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp115 := yyvsp115 + 1
	yyvsp69 := yyvsp69 -1
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

	yy_do_action_115
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval115 := yyvs115.item (yyvsp115)
				if attached yyval115 as l_list and then attached yyvs69.item (yyvsp69) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp69 := yyvsp69 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines115.force (yyvs115, yyval115, yyvsp115)
end
		end

	yy_do_action_116
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := yyvs69.item (yyvsp69) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines69.force (yyvs69, yyval69, yyvsp69)
end
		end

	yy_do_action_117
			--|#line <not available> "eiffel.y"
		local
			yyval84: detachable CLASS_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval84 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs121.item (yyvsp121)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp84 := yyvsp84 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp121 := yyvsp121 -1
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

	yy_do_action_118
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs84.item (yyvsp84), Void, Void, Void, Void, Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp69 := yyvsp69 + 1
	yyvsp84 := yyvsp84 -1
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

	yy_do_action_119
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs84.item (yyvsp84), Void, Void, Void, Void, yyvs106.item (yyvsp106), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp69 := yyvsp69 + 1
	yyvsp84 := yyvsp84 -1
	yyvsp106 := yyvsp106 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_120
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs84.item (yyvsp84), Void, Void, Void, yyvs105.item (yyvsp105), yyvs106.item (yyvsp106), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp69 := yyvsp69 + 1
	yyvsp84 := yyvsp84 -1
	yyvsp105 := yyvsp105 -1
	yyvsp106 := yyvsp106 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_121
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs84.item (yyvsp84), Void, Void, yyvs104.item (yyvsp104), yyvs105.item (yyvsp105), yyvs106.item (yyvsp106), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp69 := yyvsp69 + 1
	yyvsp84 := yyvsp84 -1
	yyvsp104 := yyvsp104 -1
	yyvsp105 := yyvsp105 -1
	yyvsp106 := yyvsp106 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_122
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs84.item (yyvsp84), Void, yyvs96.item (yyvsp96), yyvs104.item (yyvsp104), yyvs105.item (yyvsp105), yyvs106.item (yyvsp106), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp69 := yyvsp69 + 1
	yyvsp84 := yyvsp84 -1
	yyvsp96 := yyvsp96 -1
	yyvsp104 := yyvsp104 -1
	yyvsp105 := yyvsp105 -1
	yyvsp106 := yyvsp106 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_123
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs84.item (yyvsp84), yyvs117.item (yyvsp117), yyvs96.item (yyvsp96), yyvs104.item (yyvsp104), yyvs105.item (yyvsp105), yyvs106.item (yyvsp106), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp69 := yyvsp69 + 1
	yyvsp84 := yyvsp84 -1
	yyvsp117 := yyvsp117 -1
	yyvsp96 := yyvsp96 -1
	yyvsp104 := yyvsp104 -1
	yyvsp105 := yyvsp105 -1
	yyvsp106 := yyvsp106 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_124
			--|#line <not available> "eiffel.y"
		local
			yyval117: detachable RENAME_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval117 := ast_factory.new_rename_clause_as (Void, yyvs12.item (yyvsp12))
				if is_constraint_renaming then
					report_one_error (
						create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						"Empty rename clause."))
				else
					report_one_warning (
							create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
							"Remove empty rename clauses."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp117 := yyvsp117 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_125
			--|#line <not available> "eiffel.y"
		local
			yyval117: detachable RENAME_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval117 := ast_factory.new_rename_clause_as (yyvs116.item (yyvsp116), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp117 := yyvsp117 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyvsp116 := yyvsp116 -1
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

	yy_do_action_126
			--|#line <not available> "eiffel.y"
		local
			yyval116: detachable EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval116 := ast_factory.new_eiffel_list_rename_as (counter_value + 1)
				if attached yyval116 as l_list and then attached yyvs73.item (yyvsp73) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp116 := yyvsp116 + 1
	yyvsp73 := yyvsp73 -1
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

	yy_do_action_127
			--|#line <not available> "eiffel.y"
		local
			yyval116: detachable EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval116 := yyvs116.item (yyvsp116)
				if attached yyval116 as l_list and then attached yyvs73.item (yyvsp73) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp73 := yyvsp73 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines116.force (yyvs116, yyval116, yyvsp116)
end
		end

	yy_do_action_128
			--|#line <not available> "eiffel.y"
		local
			yyval73: detachable RENAME_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval73 := ast_factory.new_rename_as (yyvs88.item (yyvsp88 - 1), yyvs88.item (yyvsp88), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp73 := yyvsp73 + 1
	yyvsp88 := yyvsp88 -2
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_129
			--|#line <not available> "eiffel.y"
		local
			yyval96: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp96 := yyvsp96 + 1
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

	yy_do_action_130
			--|#line <not available> "eiffel.y"
		local
			yyval96: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval96 := yyvs96.item (yyvsp96) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines96.force (yyvs96, yyval96, yyvsp96)
end
		end

	yy_do_action_131
			--|#line <not available> "eiffel.y"
		local
			yyval96: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval96 := ast_factory.new_export_clause_as (yyvs95.item (yyvsp95), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp96 := yyvsp96 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyvsp95 := yyvsp95 -1
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

	yy_do_action_132
			--|#line <not available> "eiffel.y"
		local
			yyval96: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval96 := ast_factory.new_export_clause_as (Void, yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp96 := yyvsp96 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_133
			--|#line <not available> "eiffel.y"
		local
			yyval95: detachable EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval95 := ast_factory.new_eiffel_list_export_item_as (counter_value + 1)
				if attached yyval95 as l_list and then attached yyvs45.item (yyvsp45) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp95 := yyvsp95 + 1
	yyvsp45 := yyvsp45 -1
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

	yy_do_action_134
			--|#line <not available> "eiffel.y"
		local
			yyval95: detachable EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval95 := yyvs95.item (yyvsp95)
				if attached yyval95 as l_list and then attached yyvs45.item (yyvsp45) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp45 := yyvsp45 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines95.force (yyvs95, yyval95, yyvsp95)
end
		end

	yy_do_action_135
			--|#line <not available> "eiffel.y"
		local
			yyval45: detachable EXPORT_ITEM_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs51.item (yyvsp51) = Void then
						-- Per ECMA, this should be rejected. For now we only raise
						-- a warning. And on the compiler side, we will simply ignore them altogether.
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (token_line (yyvs108.item (yyvsp108)), token_column (yyvs108.item (yyvsp108)), filename,
								once "Empty Feature_set is not allowed and will be discarded."))
					end
				end
				yyval45 := ast_factory.new_export_item_as (ast_factory.new_client_as (yyvs108.item (yyvsp108)), yyvs51.item (yyvsp51))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp45 := yyvsp45 + 1
	yyvsp108 := yyvsp108 -1
	yyvsp51 := yyvsp51 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_136
			--|#line <not available> "eiffel.y"
		local
			yyval51: detachable FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp51 := yyvsp51 + 1
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

	yy_do_action_137
			--|#line <not available> "eiffel.y"
		local
			yyval51: detachable FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval51 := ast_factory.new_all_as (yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp51 := yyvsp51 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_138
			--|#line <not available> "eiffel.y"
		local
			yyval51: detachable FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval51 := ast_factory.new_feature_list_as (yyvs101.item (yyvsp101)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp51 := yyvsp51 + 1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_139
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp91 := yyvsp91 + 1
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

	yy_do_action_140
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if attached yyvs91.item (yyvsp91) as l_list then
				yyval91 := l_list
				l_list.set_convert_keyword (yyvs12.item (yyvsp12))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_141
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval91 := ast_factory.new_eiffel_list_convert (counter_value + 1)
			if attached yyval91 as l_list and then attached yyvs37.item (yyvsp37) as l_val then
				l_list.reverse_extend (l_val)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp91 := yyvsp91 + 1
	yyvsp37 := yyvsp37 -1
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

	yy_do_action_142
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval91 := yyvs91.item (yyvsp91)
			if attached yyval91 as l_list and then attached yyvs37.item (yyvsp37) as l_val then
				l_list.reverse_extend (l_val)
				ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp37 := yyvsp37 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_143
			--|#line <not available> "eiffel.y"
		local
			yyval37: detachable CONVERT_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			yyval37 := ast_factory.new_convert_feat_as (True, yyvs88.item (yyvsp88), yyvs121.item (yyvsp121), yyvs4.item (yyvsp4 - 3), yyvs4.item (yyvsp4), Void, yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp37 := yyvsp37 + 1
	yyvsp88 := yyvsp88 -1
	yyvsp4 := yyvsp4 -4
	yyvsp121 := yyvsp121 -1
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

	yy_do_action_144
			--|#line <not available> "eiffel.y"
		local
			yyval37: detachable CONVERT_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- False because this is not a conversion feature used as a creation
				-- procedure.
			yyval37 := ast_factory.new_convert_feat_as (False, yyvs88.item (yyvsp88), yyvs121.item (yyvsp121), Void, Void, yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp37 := yyvsp37 + 1
	yyvsp88 := yyvsp88 -1
	yyvsp4 := yyvsp4 -3
	yyvsp121 := yyvsp121 -1
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

	yy_do_action_145
			--|#line <not available> "eiffel.y"
		local
			yyval101: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval101 := yyvs101.item (yyvsp101) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines101.force (yyvs101, yyval101, yyvsp101)
end
		end

	yy_do_action_146
			--|#line <not available> "eiffel.y"
		local
			yyval101: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval101 := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if attached yyval101 as l_list and then attached yyvs88.item (yyvsp88) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp101 := yyvsp101 + 1
	yyvsp88 := yyvsp88 -1
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

	yy_do_action_147
			--|#line <not available> "eiffel.y"
		local
			yyval101: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval101 := yyvs101.item (yyvsp101)
				if attached yyval101 as l_list and then attached yyvs88.item (yyvsp88) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp88 := yyvsp88 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines101.force (yyvs101, yyval101, yyvsp101)
end
		end

	yy_do_action_148
			--|#line <not available> "eiffel.y"
		local
			yyval104: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp104 := yyvsp104 + 1
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

	yy_do_action_149
			--|#line <not available> "eiffel.y"
		local
			yyval104: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval104 := yyvs104.item (yyvsp104) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines104.force (yyvs104, yyval104, yyvsp104)
end
		end

	yy_do_action_150
			--|#line <not available> "eiffel.y"
		local
			yyval104: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval104 := ast_factory.new_undefine_clause_as (Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp104 := yyvsp104 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_151
			--|#line <not available> "eiffel.y"
		local
			yyval104: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval104 := ast_factory.new_undefine_clause_as (yyvs101.item (yyvsp101), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp104 := yyvsp104 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_152
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp105 := yyvsp105 + 1
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

	yy_do_action_153
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval105 := yyvs105.item (yyvsp105) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_154
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval105 := ast_factory.new_redefine_clause_as (Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp105 := yyvsp105 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_155
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval105 := ast_factory.new_redefine_clause_as (yyvs101.item (yyvsp101), yyvs12.item (yyvsp12))				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp105 := yyvsp105 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_156
			--|#line <not available> "eiffel.y"
		local
			yyval106: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp106 := yyvsp106 + 1
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

	yy_do_action_157
			--|#line <not available> "eiffel.y"
		local
			yyval106: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval106 := yyvs106.item (yyvsp106) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines106.force (yyvs106, yyval106, yyvsp106)
end
		end

	yy_do_action_158
			--|#line <not available> "eiffel.y"
		local
			yyval106: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if non_conforming_inheritance_flag then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)),
						filename, "Non-conforming inheritance may not use select clause"))
				end
				yyval106 := ast_factory.new_select_clause_as (Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp106 := yyvsp106 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_159
			--|#line <not available> "eiffel.y"
		local
			yyval106: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if non_conforming_inheritance_flag and attached yyvs12.item (yyvsp12) as l_keyword then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)),
						filename, "Non-conforming inheritance may not use select clause"))
				end
				yyval106 := ast_factory.new_select_clause_as (yyvs101.item (yyvsp101), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp106 := yyvsp106 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_160
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable FORMAL_ARGU_DEC_LIST_AS
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
				yyval125 := ast_factory.new_formal_argu_dec_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
			
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

	yy_do_action_161
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval125 := ast_factory.new_formal_argu_dec_list_as (yyvs122.item (yyvsp122), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp125 := yyvsp125 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp122 := yyvsp122 -1
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

	yy_do_action_162
			--|#line <not available> "eiffel.y"
		local
			yyval122: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval122 := ast_factory.new_eiffel_list_type_dec_as (counter_value + 1)
				if attached yyval122 as l_list and then attached yyvs85.item (yyvsp85) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp122 := yyvsp122 + 1
	yyvsp85 := yyvsp85 -1
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

	yy_do_action_163
			--|#line <not available> "eiffel.y"
		local
			yyval122: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval122 := yyvs122.item (yyvsp122)
				if attached yyval122 as l_list and then attached yyvs85.item (yyvsp85) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp85 := yyvsp85 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines122.force (yyvs122, yyval122, yyvsp122)
end
		end

	yy_do_action_164
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable TYPE_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := ast_factory.new_type_dec_as (yyvs19.item (yyvsp19), yyvs82.item (yyvsp82), yyvs4.item (yyvsp4 - 1))
				if attached yyvs19.item (yyvsp19) as list and then attached list.id_list as identifiers then
					add_scope_arguments (identifiers)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp85 := yyvsp85 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp19 := yyvsp19 -1
	yyvsp4 := yyvsp4 -2
	yyvsp82 := yyvsp82 -1
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

	yy_do_action_165
			--|#line <not available> "eiffel.y"
		local
			yyval123: detachable LIST_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval123 := ast_factory.new_eiffel_list_list_dec_as (counter_value + 1)
				if attached yyval123 as l_list and then attached yyvs86.item (yyvsp86) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp123 := yyvsp123 + 1
	yyvsp86 := yyvsp86 -1
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

	yy_do_action_166
			--|#line <not available> "eiffel.y"
		local
			yyval123: detachable LIST_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval123 := yyvs123.item (yyvsp123)
				if attached yyval123 as l_list and then attached yyvs86.item (yyvsp86) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp86 := yyvsp86 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines123.force (yyvs123, yyval123, yyvsp123)
end
		end

	yy_do_action_167
			--|#line <not available> "eiffel.y"
		local
			yyval86: detachable LIST_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not is_type_inference_supported then
					raise_error
				end
				yyval86 := ast_factory.new_list_dec_as (yyvs19.item (yyvsp19))
				if attached yyvs19.item (yyvsp19) as list and then attached list.id_list as identifiers then
					add_scope_locals (identifiers)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp86 := yyvsp86 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp19 := yyvsp19 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_168
			--|#line <not available> "eiffel.y"
		local
			yyval86: detachable LIST_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval86 := ast_factory.new_type_dec_as (yyvs19.item (yyvsp19), yyvs82.item (yyvsp82), yyvs4.item (yyvsp4 - 1))
				if attached yyvs19.item (yyvsp19) as list and then attached list.id_list as identifiers then
					add_scope_locals (identifiers)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp86 := yyvsp86 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp19 := yyvsp19 -1
	yyvsp4 := yyvsp4 -2
	yyvsp82 := yyvsp82 -1
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

	yy_do_action_169
			--|#line <not available> "eiffel.y"
		local
			yyval19: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval19 := ast_factory.new_identifier_list (counter_value + 1)
				if attached yyval19 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp19 := yyvsp19 + 1
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

	yy_do_action_170
			--|#line <not available> "eiffel.y"
		local
			yyval19: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval19 := yyvs19.item (yyvsp19)
				if attached yyval19 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_val)
					ast_factory.reverse_extend_identifier_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines19.force (yyvs19, yyval19, yyvsp19)
end
		end

	yy_do_action_171
			--|#line <not available> "eiffel.y"
		local
			yyval19: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval19 := ast_factory.new_identifier_list (0) 
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

	yy_do_action_172
			--|#line <not available> "eiffel.y"
		local
			yyval19: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval19 := yyvs19.item (yyvsp19) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines19.force (yyvs19, yyval19, yyvsp19)
end
		end

	yy_do_action_173
			--|#line <not available> "eiffel.y"
		local
			yyval77: detachable ROUTINE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs18.item (yyvsp18) as l_pair then
					temp_string_as1 := l_pair.second
					temp_keyword_as := l_pair.first
				else
					temp_string_as1 := Void
					temp_keyword_as := Void
				end
				if attached yyvs16.item (yyvsp16) as l_rescue then
					yyval77 := ast_factory.new_routine_as (temp_string_as1, yyvs74.item (yyvsp74), yyvs124.item (yyvsp124), yyvs76.item (yyvsp76), yyvs44.item (yyvsp44), l_rescue.second, yyvs12.item (yyvsp12), once_manifest_string_counter_value, fbody_pos, temp_keyword_as, l_rescue.first, object_test_locals)
				else
					yyval77 := ast_factory.new_routine_as (temp_string_as1, yyvs74.item (yyvsp74), yyvs124.item (yyvsp124), yyvs76.item (yyvsp76), yyvs44.item (yyvsp44), Void, yyvs12.item (yyvsp12), once_manifest_string_counter_value, fbody_pos, temp_keyword_as, Void, object_test_locals)
				end
				reset_once_manifest_string_counter
				object_test_locals := Void
				leave_scope -- For local variables.
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp77 := yyvsp77 -1
	yyvsp18 := yyvsp18 -1
	yyvsp74 := yyvsp74 -1
	yyvsp124 := yyvsp124 -1
	yyvsp76 := yyvsp76 -1
	yyvsp44 := yyvsp44 -1
	yyvsp16 := yyvsp16 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines77.force (yyvs77, yyval77, yyvsp77)
end
		end

	yy_do_action_174
			--|#line <not available> "eiffel.y"
		local
			yyval77: detachable ROUTINE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_fbody_pos (position)
			
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

	yy_do_action_175
			--|#line <not available> "eiffel.y"
		local
			yyval77: detachable ROUTINE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					 -- Start a scope for local variables.
				enter_scope
			
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

	yy_do_action_176
			--|#line <not available> "eiffel.y"
		local
			yyval76: detachable ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval76 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp76 := yyvsp76 + 1
	yyvsp61 := yyvsp61 -1
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

	yy_do_action_177
			--|#line <not available> "eiffel.y"
		local
			yyval76: detachable ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval76 := yyvs47.item (yyvsp47) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp76 := yyvsp76 + 1
	yyvsp47 := yyvsp47 -1
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

	yy_do_action_178
			--|#line <not available> "eiffel.y"
		local
			yyval76: detachable ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval76 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp76 := yyvsp76 + 1
	yyvsp10 := yyvsp10 -1
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

	yy_do_action_179
			--|#line <not available> "eiffel.y"
		local
			yyval47: detachable EXTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs48.item (yyvsp48) as l_language and then l_language.is_built_in then
					if attached yyvs18.item (yyvsp18) as l_name then 
						yyval47 := ast_factory.new_built_in_as (l_language, l_name.second, yyvs12.item (yyvsp12), l_name.first)
					else
						yyval47 := ast_factory.new_built_in_as (l_language, Void, yyvs12.item (yyvsp12), Void)
					end
				elseif attached yyvs18.item (yyvsp18) as l_name then
					yyval47 := ast_factory.new_external_as (yyvs48.item (yyvsp48), l_name.second, yyvs12.item (yyvsp12), l_name.first)
				else
					yyval47 := ast_factory.new_external_as (yyvs48.item (yyvsp48), Void, yyvs12.item (yyvsp12), Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp47 := yyvsp47 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp48 := yyvsp48 -1
	yyvsp18 := yyvsp18 -1
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

	yy_do_action_180
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXTERNAL_LANG_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_external_lang_as (yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp14 := yyvsp14 -1
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

	yy_do_action_181
			--|#line <not available> "eiffel.y"
		local
			yyval18: detachable PAIR [KEYWORD_AS, STRING_AS]
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

	yy_do_action_182
			--|#line <not available> "eiffel.y"
		local
			yyval18: detachable PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval18 := ast_factory.new_keyword_string_pair (yyvs12.item (yyvsp12), yyvs14.item (yyvsp14))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp18 := yyvsp18 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp14 := yyvsp14 -1
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

	yy_do_action_183
			--|#line <not available> "eiffel.y"
		local
			yyval61: detachable INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := ast_factory.new_do_as (yyvs111.item (yyvsp111), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp111 := yyvsp111 -1
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

	yy_do_action_184
			--|#line <not available> "eiffel.y"
		local
			yyval61: detachable INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := ast_factory.new_once_as (yyvs12.item (yyvsp12), yyvs119.item (yyvsp119), yyvs111.item (yyvsp111)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp119 := yyvsp119 -1
	yyvsp111 := yyvsp111 -1
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

	yy_do_action_185
			--|#line <not available> "eiffel.y"
		local
			yyval61: detachable INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := ast_factory.new_attribute_as (yyvs111.item (yyvsp111), extract_keyword (yyvs13.item (yyvsp13))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp111 := yyvsp111 -1
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

	yy_do_action_186
			--|#line <not available> "eiffel.y"
		local
			yyval124: detachable LOCAL_DEC_LIST_AS
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

	yy_do_action_187
			--|#line <not available> "eiffel.y"
		local
			yyval124: detachable LOCAL_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval124 := ast_factory.new_local_dec_list_as (ast_factory.new_eiffel_list_type_dec_as (0), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp124 := yyvsp124 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_188
			--|#line <not available> "eiffel.y"
		local
			yyval124: detachable LOCAL_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval124 := ast_factory.new_local_dec_list_as (yyvs123.item (yyvsp123), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp124 := yyvsp124 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyvsp123 := yyvsp123 -1
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

	yy_do_action_189
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp111 := yyvsp111 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_190
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval111 := yyvs111.item (yyvsp111) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -3
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_191
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval111 := ast_factory.new_eiffel_list_instruction_as (counter_value + 1)
				if attached yyval111 as l_list and then attached yyvs59.item (yyvsp59) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp111 := yyvsp111 + 1
	yyvsp59 := yyvsp59 -1
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

	yy_do_action_192
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval111 := yyvs111.item (yyvsp111)
				if attached yyval111 as l_list and then attached yyvs59.item (yyvsp59) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp59 := yyvsp59 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_193
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs59.item (yyvsp59) as l_instructions then
					yyval59 := l_instructions
					l_instructions.set_line_pragma (last_line_pragma)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines59.force (yyvs59, yyval59, yyvsp59)
end
		end

	yy_do_action_194
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

	yy_do_action_195
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

	yy_do_action_196
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := yyvs39.item (yyvsp39) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp39 := yyvsp39 -1
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

	yy_do_action_197
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := ast_factory.new_instr_call_as (yyvs32.item (yyvsp32)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp32 := yyvsp32 -1
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

	yy_do_action_198
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := ast_factory.new_assigner_call_as (ast_factory.new_expr_call_as (yyvs32.item (yyvsp32)), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp59 := yyvsp59 + 1
	yyvsp32 := yyvsp32 -1
	yyvsp4 := yyvsp4 -1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_199
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := ast_factory.new_assigner_call_as (yyvs71.item (yyvsp71), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp59 := yyvsp59 + 1
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_200
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := ast_factory.new_assigner_call_as (ast_factory.new_bracket_as (yyvs46.item (yyvsp46 - 1), yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp59 := yyvsp59 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -3
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_201
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := ast_factory.new_assigner_call_as (ast_factory.new_bracket_as (ast_factory.new_expr_call_as (yyvs32.item (yyvsp32)), yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp59 := yyvsp59 + 1
	yyvsp32 := yyvsp32 -1
	yyvsp4 := yyvsp4 -3
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_202
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := yyvs27.item (yyvsp27) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_203
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp75 := yyvsp75 -1
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

	yy_do_action_204
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := yyvs55.item (yyvsp55) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp55 := yyvsp55 -1
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

	yy_do_action_205
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := yyvs65.item (yyvsp65) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp65 := yyvsp65 -1
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

	yy_do_action_206
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := yyvs58.item (yyvsp58) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp58 := yyvsp58 -1
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

	yy_do_action_207
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := yyvs41.item (yyvsp41) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp41 := yyvsp41 -1
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

	yy_do_action_208
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := yyvs34.item (yyvsp34) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp34 := yyvsp34 -1
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

	yy_do_action_209
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := yyvs54.item (yyvsp54) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp54 := yyvsp54 -1
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

	yy_do_action_210
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := yyvs79.item (yyvsp79) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp79 := yyvsp79 -1
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

	yy_do_action_211
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp7 := yyvsp7 -1
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

	yy_do_action_212
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp74 := yyvsp74 + 1
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

	yy_do_action_213
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval74 := ast_factory.new_require_as (yyvs120.item (yyvsp120), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp120 := yyvsp120 -1
	yyspecial_routines74.force (yyvs74, yyval74, yyvsp74)
end
		end

	yy_do_action_214
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp74 := yyvsp74 + 1
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

	yy_do_action_215
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval74 := ast_factory.new_require_else_as (yyvs120.item (yyvsp120), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp120 := yyvsp120 -1
	yyspecial_routines74.force (yyvs74, yyval74, yyvsp74)
end
		end

	yy_do_action_216
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp74 := yyvsp74 + 1
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

	yy_do_action_217
			--|#line <not available> "eiffel.y"
		local
			yyval44: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp44 := yyvsp44 + 1
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

	yy_do_action_218
			--|#line <not available> "eiffel.y"
		local
			yyval44: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval44 := ast_factory.new_ensure_as (yyvs120.item (yyvsp120), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp120 := yyvsp120 -1
	yyspecial_routines44.force (yyvs44, yyval44, yyvsp44)
end
		end

	yy_do_action_219
			--|#line <not available> "eiffel.y"
		local
			yyval44: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp44 := yyvsp44 + 1
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

	yy_do_action_220
			--|#line <not available> "eiffel.y"
		local
			yyval44: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval44 := ast_factory.new_ensure_then_as (yyvs120.item (yyvsp120), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp120 := yyvsp120 -1
	yyspecial_routines44.force (yyvs44, yyval44, yyvsp44)
end
		end

	yy_do_action_221
			--|#line <not available> "eiffel.y"
		local
			yyval44: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp44 := yyvsp44 + 1
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

	yy_do_action_222
			--|#line <not available> "eiffel.y"
		local
			yyval120: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp120 := yyvsp120 + 1
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

	yy_do_action_223
			--|#line <not available> "eiffel.y"
		local
			yyval120: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs120.item (yyvsp120) as l_list then
					if l_list.is_empty then
						yyval120 := Void
					else
						yyval120 := l_list
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines120.force (yyvs120, yyval120, yyvsp120)
end
		end

	yy_do_action_224
			--|#line <not available> "eiffel.y"
		local
			yyval120: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if attached yyvs80.item (yyvsp80) as l_val then
					yyval120 := ast_factory.new_eiffel_list_tagged_as (counter_value + 1)
					if attached yyval120 as l_list then
						l_list.reverse_extend (l_val)
					end
				else
					yyval120 := ast_factory.new_eiffel_list_tagged_as (counter_value)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp120 := yyvsp120 + 1
	yyvsp80 := yyvsp80 -1
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

	yy_do_action_225
			--|#line <not available> "eiffel.y"
		local
			yyval120: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval120 := yyvs120.item (yyvsp120)
				if attached yyval120 as l_list and then attached yyvs80.item (yyvsp80) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp120 := yyvsp120 -1
	yyvsp80 := yyvsp80 -1
	yyspecial_routines120.force (yyvs120, yyval120, yyvsp120)
end
		end

	yy_do_action_226
			--|#line <not available> "eiffel.y"
		local
			yyval120: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Only increment counter when clause is not Void.
				if yyvs80.item (yyvsp80) /= Void then
					increment_counter
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp120 := yyvsp120 + 1
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

	yy_do_action_227
			--|#line <not available> "eiffel.y"
		local
			yyval80: detachable TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval80 := ast_factory.new_tagged_as (Void, yyvs46.item (yyvsp46), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp80 := yyvsp80 + 1
	yyvsp46 := yyvsp46 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_228
			--|#line <not available> "eiffel.y"
		local
			yyval80: detachable TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval80 := ast_factory.new_tagged_as (yyvs2.item (yyvsp2), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp80 := yyvsp80 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_229
			--|#line <not available> "eiffel.y"
		local
			yyval80: detachable TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			-- Always create an object here for roundtrip parser.
			-- This "fake" assertion will be filtered out later.
			yyval80 := ast_factory.new_tagged_as (yyvs2.item (yyvsp2), Void, yyvs4.item (yyvsp4 - 1))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp80 := yyvsp80 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_230
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_231
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_232
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_233
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_234
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_235
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_236
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_237
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_238
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_239
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_240
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp13 := yyvsp13 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_241
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp13 := yyvsp13 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_242
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_243
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_244
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), True, False)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -2
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_245
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_246
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_247
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_248
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_249
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), False, True)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -2
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_250
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_251
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_252
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_253
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_254
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := new_class_type (yyvs2.item (yyvsp2), yyvs121.item (yyvsp121)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp82 := yyvsp82 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp121 := yyvsp121 -1
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

	yy_do_action_255
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_256
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_257
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_258
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_259
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_260
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_261
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp13 := yyvsp13 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_262
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp13 := yyvsp13 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_263
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_264
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_265
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), True, False)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -2
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_266
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_267
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), True, False)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_268
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_269
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_270
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), False, True)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -2
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_271
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), True, False)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_272
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_variance_mark and then attached yyval82 as l_type then
					l_type.set_variance_mark (yyvs12.item (yyvsp12 - 1), False, True)
				end
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs13.item (yyvsp13)), False, True)
				end
				if attached yyval82 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_273
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_274
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp82 := yyvsp82 + 1
	yyvsp83 := yyvsp83 -1
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

	yy_do_action_275
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := ast_factory.new_like_id_as (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp82 := yyvsp82 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_276
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := ast_factory.new_like_current_as (yyvs9.item (yyvsp9), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp82 := yyvsp82 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp9 := yyvsp9 -1
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

	yy_do_action_277
			--|#line <not available> "eiffel.y"
		local
			yyval83: detachable QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := ast_factory.new_qualified_anchored_type (yyvs82.item (yyvsp82), yyvs4.item (yyvsp4), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp83 := yyvsp83 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_278
			--|#line <not available> "eiffel.y"
		local
			yyval83: detachable QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := ast_factory.new_qualified_anchored_type_with_type (yyvs12.item (yyvsp12), yyvs82.item (yyvsp82), yyvs4.item (yyvsp4), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp83 := yyvsp83 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_279
			--|#line <not available> "eiffel.y"
		local
			yyval83: detachable QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if attached yyval83 as q and attached yyvs2.item (yyvsp2) as l_id then
					q.extend (yyvs4.item (yyvsp4), l_id)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines83.force (yyvs83, yyval83, yyvsp83)
end
		end

	yy_do_action_280
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_281
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_282
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_283
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
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
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_284
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
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
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_285
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				ast_factory.set_expanded_class_type (yyval82, True, yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Make an expanded version of the base class associated with this type."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_286
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
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
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_287
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if not is_ignoring_attachment_marks and then attached yyval82 as l_type then
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
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_288
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp121 := yyvsp121 + 1
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

	yy_do_action_289
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval121 := yyvs121.item (yyvsp121)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines121.force (yyvs121, yyval121, yyvsp121)
end
		end

	yy_do_action_290
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs121.item (yyvsp121) as l_list then
					yyval121 := l_list
					l_list.set_positions (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines121.force (yyvs121, yyval121, yyvsp121)
end
		end

	yy_do_action_291
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable TYPE_LIST_AS
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
					yyval121 := l_list
					l_list.set_positions (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end	
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp121 := yyvsp121 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_292
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval121 := yyvs121.item (yyvsp121) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines121.force (yyvs121, yyval121, yyvsp121)
end
		end

	yy_do_action_293
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval121 := ast_factory.new_eiffel_list_type (counter_value + 1)
				if attached yyval121 as l_list and then attached yyvs82.item (yyvsp82) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp121 := yyvsp121 + 1
	yyvsp82 := yyvsp82 -1
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

	yy_do_action_294
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval121 := yyvs121.item (yyvsp121)
				if attached yyval121 as l_list and then attached yyvs82.item (yyvsp82) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines121.force (yyvs121, yyval121, yyvsp121)
end
		end

	yy_do_action_295
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp82 := yyvsp82 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_296
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
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
					yyval82 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), l_type_list)
				else
					yyval82 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void)
  				end
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp82 := yyvsp82 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_297
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs121.item (yyvsp121) as l_list then
					l_list.set_positions (yyvs4.item (yyvsp4), last_rsqure.item)
				end
				yyval82 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs121.item (yyvsp121))
				last_rsqure.remove
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp82 := yyvsp82 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	yyvsp121 := yyvsp121 -1
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

	yy_do_action_298
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := ast_factory.new_named_tuple_type_as (
					yyvs2.item (yyvsp2), ast_factory.new_formal_argu_dec_list_as (yyvs122.item (yyvsp122), yyvs4.item (yyvsp4), last_rsqure.item))
				last_rsqure.remove
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp82 := yyvsp82 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	yyvsp122 := yyvsp122 -1
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

	yy_do_action_299
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval121 := ast_factory.new_eiffel_list_type (counter_value + 1)
				if attached yyval121 as l_list and then attached yyvs82.item (yyvsp82) as l_val then
					l_list.reverse_extend (l_val)
				end
				last_rsqure.force (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp121 := yyvsp121 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_300
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval121 := yyvs121.item (yyvsp121)
				if
					attached yyval121 as l_list and then attached yyvs2.item (yyvsp2) as l_val and then
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
	yyspecial_routines121.force (yyvs121, yyval121, yyvsp121)
end
		end

	yy_do_action_301
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval121 := yyvs121.item (yyvsp121)
				if attached yyval121 as l_list and then attached yyvs82.item (yyvsp82) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines121.force (yyvs121, yyval121, yyvsp121)
end
		end

	yy_do_action_302
			--|#line <not available> "eiffel.y"
		local
			yyval122: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval122 := ast_factory.new_eiffel_list_type_dec_as (counter2_value + 1)
				if
					attached yyval122 as l_named_list and then attached yyvs2.item (yyvsp2) as l_name and then
					attached ast_factory.new_identifier_list (counter_value + 1) as l_list and then
					attached ast_factory.new_type_dec_as (l_list, yyvs82.item (yyvsp82), yyvs4.item (yyvsp4 - 1)) as l_type_dec_as
				then
					l_name.to_lower		
					l_list.reverse_extend (l_name.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_name)
					l_named_list.reverse_extend (l_type_dec_as)
				end
				last_rsqure.force (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp122 := yyvsp122 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp82 := yyvsp82 -1
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

	yy_do_action_303
			--|#line <not available> "eiffel.y"
		local
			yyval122: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval122 := yyvs122.item (yyvsp122)
				if
					attached yyval122 as l_named_list and then not l_named_list.is_empty and then
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
	yyspecial_routines122.force (yyvs122, yyval122, yyvsp122)
end
		end

	yy_do_action_304
			--|#line <not available> "eiffel.y"
		local
			yyval122: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				remove_counter
				yyval122 := yyvs122.item (yyvsp122)
				if
					attached yyval122 as l_named_list and then attached yyvs2.item (yyvsp2) as l_name and then yyvs82.item (yyvsp82) /= Void and then
					attached ast_factory.new_identifier_list (counter_value + 1) as l_list and then
					attached ast_factory.new_type_dec_as (l_list, yyvs82.item (yyvsp82), yyvs4.item (yyvsp4 - 1)) as l_type_dec_as
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
	yyvsp82 := yyvsp82 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines122.force (yyvs122, yyval122, yyvsp122)
end
		end

	yy_do_action_305
			--|#line <not available> "eiffel.y"
		local
			yyval107: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- $$ := Void
				set_formal_generics_end_positions (True)
			
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

	yy_do_action_306
			--|#line <not available> "eiffel.y"
		local
			yyval107: detachable FORMAL_GENERIC_LIST_AS
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
				yyval107 := ast_factory.new_eiffel_list_formal_dec_as (0)
				if attached yyval107 as l_formals then
					l_formals.set_squre_symbols (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp107 := yyvsp107 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_307
			--|#line <not available> "eiffel.y"
		local
			yyval107: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_formal_generics_end_positions (False)
				yyval107 := yyvs107.item (yyvsp107)
				if attached yyval107 as l_formals then
					l_formals.transform_class_types_to_formals_and_record_suppliers (ast_factory, suppliers, formal_parameters)
					l_formals.set_squre_symbols (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -4
	yyspecial_routines107.force (yyvs107, yyval107, yyvsp107)
end
		end

	yy_do_action_308
			--|#line <not available> "eiffel.y"
		local
			yyval107: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval107 := ast_factory.new_eiffel_list_formal_dec_as (counter_value + 1)
				if attached yyval107 as l_list and then attached yyvs53.item (yyvsp53) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp107 := yyvsp107 + 1
	yyvsp53 := yyvsp53 -1
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

	yy_do_action_309
			--|#line <not available> "eiffel.y"
		local
			yyval107: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval107 := yyvs107.item (yyvsp107)
				if attached yyval107 as l_list and then attached yyvs53.item (yyvsp53) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp53 := yyvsp53 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines107.force (yyvs107, yyval107, yyvsp107)
end
		end

	yy_do_action_310
			--|#line <not available> "eiffel.y"
		local
			yyval52: detachable FORMAL_AS
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
					yyval52 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), True, False, False, yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp52 := yyvsp52 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_311
			--|#line <not available> "eiffel.y"
		local
			yyval52: detachable FORMAL_AS
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
					yyval52 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, True, False, yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp52 := yyvsp52 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_312
			--|#line <not available> "eiffel.y"
		local
			yyval52: detachable FORMAL_AS
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
					yyval52 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, False, True, yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp52 := yyvsp52 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_313
			--|#line <not available> "eiffel.y"
		local
			yyval52: detachable FORMAL_AS
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
					yyval52 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, False, False, Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp52 := yyvsp52 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_314
			--|#line <not available> "eiffel.y"
		local
			yyval53: detachable FORMAL_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs126.item (yyvsp126) as l_constraint then
					if attached l_constraint.creation_constrain as l_creation_constraint then
						yyval53 := ast_factory.new_formal_dec_as (yyvs52.item (yyvsp52), l_constraint.type, l_creation_constraint.feature_list, l_constraint.constrain_symbol, l_creation_constraint.create_keyword, l_creation_constraint.end_keyword)
					else
						yyval53 := ast_factory.new_formal_dec_as (yyvs52.item (yyvsp52), l_constraint.type, Void, l_constraint.constrain_symbol, Void, Void)
					end					
				else
					yyval53 := ast_factory.new_formal_dec_as (yyvs52.item (yyvsp52), Void, Void, Void, Void, Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp52 := yyvsp52 -1
	yyvsp126 := yyvsp126 -1
	yyspecial_routines53.force (yyvs53, yyval53, yyvsp53)
end
		end

	yy_do_action_315
			--|#line <not available> "eiffel.y"
		local
			yyval53: detachable FORMAL_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs52.item (yyvsp52) as l_formal then
						-- Needs to be done here, in case current formal is used in
						-- Constraint.
					formal_parameters.extend (l_formal)
					l_formal.set_position (formal_parameters.count)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp53 := yyvsp53 + 1
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

	yy_do_action_316
			--|#line <not available> "eiffel.y"
		local
			yyval126: detachable CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp126 := yyvsp126 + 1
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

	yy_do_action_317
			--|#line <not available> "eiffel.y"
		local
			yyval126: detachable CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- We do not want Void items in this list.
				if
					attached yyvs128.item (yyvsp128) as l_val and then
					attached ast_factory.new_eiffel_list_constraining_type_as (1) as l_list
				then
					l_list.reverse_extend (l_val)
					yyval126 := ast_factory.new_constraint_triple (yyvs4.item (yyvsp4), l_list, yyvs103.item (yyvsp103))
				else
					yyval126 := ast_factory.new_constraint_triple (yyvs4.item (yyvsp4), Void, yyvs103.item (yyvsp103))
				end

			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp126 := yyvsp126 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp128 := yyvsp128 -1
	yyvsp103 := yyvsp103 -1
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

	yy_do_action_318
			--|#line <not available> "eiffel.y"
		local
			yyval126: detachable CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval126 := ast_factory.new_constraint_triple (yyvs4.item (yyvsp4 - 2), yyvs127.item (yyvsp127), yyvs103.item (yyvsp103))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp126 := yyvsp126 + 1
	yyvsp4 := yyvsp4 -3
	yyvsp1 := yyvsp1 -2
	yyvsp127 := yyvsp127 -1
	yyvsp103 := yyvsp103 -1
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

	yy_do_action_319
			--|#line <not available> "eiffel.y"
		local
			yyval128: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval128 := ast_factory.new_constraining_type (yyvs82.item (yyvsp82), yyvs117.item (yyvsp117), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp128 := yyvsp128 -1
	yyvsp82 := yyvsp82 -1
	yyvsp117 := yyvsp117 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines128.force (yyvs128, yyval128, yyvsp128)
end
		end

	yy_do_action_320
			--|#line <not available> "eiffel.y"
		local
			yyval128: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

is_constraint_renaming := True
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

	yy_do_action_321
			--|#line <not available> "eiffel.y"
		local
			yyval128: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

is_constraint_renaming := False
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

	yy_do_action_322
			--|#line <not available> "eiffel.y"
		local
			yyval128: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval128 := ast_factory.new_constraining_type (yyvs82.item (yyvsp82), Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp128 := yyvsp128 + 1
	yyvsp82 := yyvsp82 -1
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

	yy_do_action_323
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if attached yyvs82.item (yyvsp82) as l_type and then l_type.has_anchor then
					report_one_error (ast_factory.new_vtgc1_error (token_line (l_type), token_column (l_type), filename, l_type))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_324
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if attached yyvs82.item (yyvsp82) as l_type and then l_type.has_anchor then
					report_one_error (ast_factory.new_vtgc1_error (token_line (l_type), token_column (l_type), filename, l_type))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_325
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs82.item (yyvsp82) as l_type then
					report_one_error (ast_factory.new_vtgc1_error (token_line (l_type), token_column (l_type), filename, l_type))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_326
			--|#line <not available> "eiffel.y"
		local
			yyval127: detachable CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if attached yyvs128.item (yyvsp128) as l_val then
					yyval127 := ast_factory.new_eiffel_list_constraining_type_as (counter_value + 1)
					if attached yyval127 as l_list then
						l_list.reverse_extend (l_val)
					end
				else
					yyval127 := ast_factory.new_eiffel_list_constraining_type_as (counter_value)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp127 := yyvsp127 + 1
	yyvsp128 := yyvsp128 -1
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

	yy_do_action_327
			--|#line <not available> "eiffel.y"
		local
			yyval127: detachable CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval127 := yyvs127.item (yyvsp127)
				if attached yyval127 as l_list and then attached yyvs128.item (yyvsp128) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp127 := yyvsp127 -1
	yyvsp128 := yyvsp128 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines127.force (yyvs127, yyval127, yyvsp127)
end
		end

	yy_do_action_328
			--|#line <not available> "eiffel.y"
		local
			yyval127: detachable CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Only increment counter when clause is not Void.
				if yyvs128.item (yyvsp128) /= Void then
					increment_counter
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp127 := yyvsp127 + 1
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

	yy_do_action_329
			--|#line <not available> "eiffel.y"
		local
			yyval103: detachable CREATION_CONSTRAIN_TRIPLE
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

	yy_do_action_330
			--|#line <not available> "eiffel.y"
		local
			yyval103: detachable CREATION_CONSTRAIN_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval103 := ast_factory.new_creation_constrain_triple (yyvs101.item (yyvsp101), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp103 := yyvsp103 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_331
			--|#line <not available> "eiffel.y"
		local
			yyval55: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval55 := ast_factory.new_if_as (yyvs46.item (yyvsp46), yyvs111.item (yyvsp111), Void, Void, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp55 := yyvsp55 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp46 := yyvsp46 -1
	yyvsp111 := yyvsp111 -1
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

	yy_do_action_332
			--|#line <not available> "eiffel.y"
		local
			yyval55: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval55 := ast_factory.new_if_as (yyvs46.item (yyvsp46), yyvs111.item (yyvsp111 - 1), Void, yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp55 := yyvsp55 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp46 := yyvsp46 -1
	yyvsp111 := yyvsp111 -2
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

	yy_do_action_333
			--|#line <not available> "eiffel.y"
		local
			yyval55: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval55 := ast_factory.new_if_as (yyvs46.item (yyvsp46), yyvs111.item (yyvsp111), yyvs93.item (yyvsp93), Void, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp55 := yyvsp55 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp46 := yyvsp46 -1
	yyvsp111 := yyvsp111 -1
	yyvsp93 := yyvsp93 -1
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

	yy_do_action_334
			--|#line <not available> "eiffel.y"
		local
			yyval55: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval55 := ast_factory.new_if_as (yyvs46.item (yyvsp46), yyvs111.item (yyvsp111 - 1), yyvs93.item (yyvsp93), yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp55 := yyvsp55 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp46 := yyvsp46 -1
	yyvsp111 := yyvsp111 -2
	yyvsp93 := yyvsp93 -1
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

	yy_do_action_335
			--|#line <not available> "eiffel.y"
		local
			yyval93: detachable EIFFEL_LIST [ELSIF_AS]
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

	yy_do_action_336
			--|#line <not available> "eiffel.y"
		local
			yyval93: detachable EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval93 := ast_factory.new_eiffel_list_elseif_as (counter_value + 1)
				if attached yyval93 as l_list and then attached yyvs42.item (yyvsp42) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp93 := yyvsp93 + 1
	yyvsp42 := yyvsp42 -1
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

	yy_do_action_337
			--|#line <not available> "eiffel.y"
		local
			yyval93: detachable EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval93 := yyvs93.item (yyvsp93)
				if attached yyval93 as l_list and then attached yyvs42.item (yyvsp42) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp42 := yyvsp42 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines93.force (yyvs93, yyval93, yyvsp93)
end
		end

	yy_do_action_338
			--|#line <not available> "eiffel.y"
		local
			yyval42: detachable ELSIF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval42 := ast_factory.new_elseif_as (yyvs46.item (yyvsp46), yyvs111.item (yyvsp111), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp42 := yyvsp42 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp46 := yyvsp46 -1
	yyvsp111 := yyvsp111 -1
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

	yy_do_action_339
			--|#line <not available> "eiffel.y"
		local
			yyval58: detachable INSPECT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval58 := ast_factory.new_inspect_as (yyvs46.item (yyvsp46), yyvs90.item (yyvsp90), Void, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp58 := yyvsp58 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp46 := yyvsp46 -1
	yyvsp90 := yyvsp90 -1
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
			yyval58: detachable INSPECT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs111.item (yyvsp111) /= Void then
					yyval58 := ast_factory.new_inspect_as (yyvs46.item (yyvsp46), yyvs90.item (yyvsp90), yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				else
					yyval58 := ast_factory.new_inspect_as (yyvs46.item (yyvsp46), yyvs90.item (yyvsp90),
						ast_factory.new_eiffel_list_instruction_as (0), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp58 := yyvsp58 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp46 := yyvsp46 -1
	yyvsp90 := yyvsp90 -1
	yyvsp111 := yyvsp111 -1
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

	yy_do_action_341
			--|#line <not available> "eiffel.y"
		local
			yyval90: detachable EIFFEL_LIST [CASE_AS]
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

	yy_do_action_342
			--|#line <not available> "eiffel.y"
		local
			yyval90: detachable EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval90 := yyvs90.item (yyvsp90) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines90.force (yyvs90, yyval90, yyvsp90)
end
		end

	yy_do_action_343
			--|#line <not available> "eiffel.y"
		local
			yyval90: detachable EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval90 := ast_factory.new_eiffel_list_case_as (counter_value + 1)
				if attached yyval90 as l_list and then attached yyvs33.item (yyvsp33) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp90 := yyvsp90 + 1
	yyvsp33 := yyvsp33 -1
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

	yy_do_action_344
			--|#line <not available> "eiffel.y"
		local
			yyval90: detachable EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval90 := yyvs90.item (yyvsp90)
				if attached yyval90 as l_list and then attached yyvs33.item (yyvsp33) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp33 := yyvsp33 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines90.force (yyvs90, yyval90, yyvsp90)
end
		end

	yy_do_action_345
			--|#line <not available> "eiffel.y"
		local
			yyval33: detachable CASE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval33 := ast_factory.new_case_as (yyvs112.item (yyvsp112), yyvs111.item (yyvsp111), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp33 := yyvsp33 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp1 := yyvsp1 -2
	yyvsp112 := yyvsp112 -1
	yyvsp111 := yyvsp111 -1
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

	yy_do_action_346
			--|#line <not available> "eiffel.y"
		local
			yyval112: detachable EIFFEL_LIST [INTERVAL_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval112 := ast_factory.new_eiffel_list_interval_as (counter_value + 1)
				if attached yyval112 as l_list and then attached yyvs62.item (yyvsp62) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp112 := yyvsp112 + 1
	yyvsp62 := yyvsp62 -1
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

	yy_do_action_347
			--|#line <not available> "eiffel.y"
		local
			yyval112: detachable EIFFEL_LIST [INTERVAL_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval112 := yyvs112.item (yyvsp112)
				if attached yyval112 as l_list and then attached yyvs62.item (yyvsp62) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp62 := yyvsp62 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines112.force (yyvs112, yyval112, yyvsp112)
end
		end

	yy_do_action_348
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs60.item (yyvsp60), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_349
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs60.item (yyvsp60 - 1), yyvs60.item (yyvsp60), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp60 := yyvsp60 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_350
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_351
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs3.item (yyvsp3 - 1), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp3 := yyvsp3 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_352
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_353
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_354
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs60.item (yyvsp60), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_355
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs60.item (yyvsp60), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp60 := yyvsp60 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_356
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_357
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_358
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs71.item (yyvsp71), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp71 := yyvsp71 -1
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

	yy_do_action_359
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs71.item (yyvsp71), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_360
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs71.item (yyvsp71), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp71 := yyvsp71 -1
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

	yy_do_action_361
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs71.item (yyvsp71 - 1), yyvs71.item (yyvsp71), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp71 := yyvsp71 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_362
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs71.item (yyvsp71), yyvs60.item (yyvsp60), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_363
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs60.item (yyvsp60), yyvs71.item (yyvsp71), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp60 := yyvsp60 -1
	yyvsp4 := yyvsp4 -1
	yyvsp71 := yyvsp71 -1
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

	yy_do_action_364
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs71.item (yyvsp71), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_365
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), yyvs71.item (yyvsp71), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp4 := yyvsp4 -1
	yyvsp71 := yyvsp71 -1
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

	yy_do_action_366
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs87.item (yyvsp87)), token_column (yyvs87.item (yyvsp87)), filename,
						once "Loop variant should appear just before the end keyword of the loop."))
				end
				if attached yyvs20.item (yyvsp20) as l_invariant_pair then
					yyval65 := ast_factory.new_loop_as (Void, yyvs111.item (yyvsp111 - 1), l_invariant_pair.second, yyvs87.item (yyvsp87), yyvs46.item (yyvsp46), yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), l_invariant_pair.first, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				else
					yyval65 := ast_factory.new_loop_as (Void, yyvs111.item (yyvsp111 - 1), Void, yyvs87.item (yyvsp87), yyvs46.item (yyvsp46), yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), Void, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp65 := yyvsp65 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp111 := yyvsp111 -2
	yyvsp20 := yyvsp20 -1
	yyvsp87 := yyvsp87 -1
	yyvsp46 := yyvsp46 -1
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
			yyval65: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs20.item (yyvsp20) as l_invariant_pair then
					yyval65 := ast_factory.new_loop_as (Void, yyvs111.item (yyvsp111 - 1), l_invariant_pair.second, yyvs87.item (yyvsp87), yyvs46.item (yyvsp46), yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), l_invariant_pair.first, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				else
					yyval65 := ast_factory.new_loop_as (Void, yyvs111.item (yyvsp111 - 1), Void, yyvs87.item (yyvsp87), yyvs46.item (yyvsp46), yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), Void, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp65 := yyvsp65 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp111 := yyvsp111 -2
	yyvsp20 := yyvsp20 -1
	yyvsp46 := yyvsp46 -1
	yyvsp87 := yyvsp87 -1
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
			yyval65: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs20.item (yyvsp20) as l_invariant_pair then
					if attached yyvs21.item (yyvsp21) as l_until_pair then
						yyval65 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), yyvs111.item (yyvsp111 - 1), l_invariant_pair.second, yyvs87.item (yyvsp87), l_until_pair.second, yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), l_invariant_pair.first, l_until_pair.first, yyvs12.item (yyvsp12 - 1))
					else
						yyval65 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), yyvs111.item (yyvsp111 - 1), l_invariant_pair.second, yyvs87.item (yyvsp87), Void, yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), l_invariant_pair.first, Void, yyvs12.item (yyvsp12 - 1))
					end
				else
					if attached yyvs21.item (yyvsp21) as l_until_pair then
						yyval65 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), yyvs111.item (yyvsp111 - 1), Void, yyvs87.item (yyvsp87), l_until_pair.second, yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), Void, l_until_pair.first, yyvs12.item (yyvsp12 - 1))
					else
						yyval65 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), yyvs111.item (yyvsp111 - 1), Void, yyvs87.item (yyvsp87), Void, yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), Void, Void, yyvs12.item (yyvsp12 - 1))
					end
				end
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp65 := yyvsp65 + 1
	yyvsp110 := yyvsp110 -1
	yyvsp12 := yyvsp12 -3
	yyvsp111 := yyvsp111 -2
	yyvsp20 := yyvsp20 -1
	yyvsp21 := yyvsp21 -1
	yyvsp87 := yyvsp87 -1
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
			yyval65: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs20.item (yyvsp20) as l_invariant_pair then
					if attached yyvs21.item (yyvsp21) as l_until_pair then
						yyval65 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), Void, l_invariant_pair.second, yyvs87.item (yyvsp87), l_until_pair.second, yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), Void, l_invariant_pair.first, l_until_pair.first, yyvs12.item (yyvsp12 - 1))
					else
						yyval65 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), Void, l_invariant_pair.second, yyvs87.item (yyvsp87), Void, yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), Void, l_invariant_pair.first, Void, yyvs12.item (yyvsp12 - 1))
					end
				else
					if attached yyvs21.item (yyvsp21) as l_until_pair then
						yyval65 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), Void, Void, yyvs87.item (yyvsp87), l_until_pair.second, yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), Void, Void, l_until_pair.first, yyvs12.item (yyvsp12 - 1))
					else
						yyval65 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), Void, Void, yyvs87.item (yyvsp87), Void, yyvs111.item (yyvsp111), yyvs12.item (yyvsp12), Void, Void, Void, yyvs12.item (yyvsp12 - 1))
					end
				end
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp65 := yyvsp65 + 1
	yyvsp110 := yyvsp110 -1
	yyvsp20 := yyvsp20 -1
	yyvsp21 := yyvsp21 -1
	yyvsp12 := yyvsp12 -2
	yyvsp111 := yyvsp111 -1
	yyvsp87 := yyvsp87 -1
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
			yyval64: detachable LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs20.item (yyvsp20) as l_invariant_pair then
					if attached yyvs21.item (yyvsp21) as l_until_pair then
						yyval64 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), l_invariant_pair.first, l_invariant_pair.second, l_until_pair.first, l_until_pair.second, yyvs12.item (yyvsp12 - 1), True, yyvs46.item (yyvsp46), yyvs87.item (yyvsp87), yyvs12.item (yyvsp12))
					else
						yyval64 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), l_invariant_pair.first, l_invariant_pair.second, Void, Void, yyvs12.item (yyvsp12 - 1), True, yyvs46.item (yyvsp46), yyvs87.item (yyvsp87), yyvs12.item (yyvsp12))
					end
				else
					if attached yyvs21.item (yyvsp21) as l_until_pair then
						yyval64 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), Void, Void, l_until_pair.first, l_until_pair.second, yyvs12.item (yyvsp12 - 1), True, yyvs46.item (yyvsp46), yyvs87.item (yyvsp87), yyvs12.item (yyvsp12))
					else
						yyval64 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), Void, Void, Void, Void, yyvs12.item (yyvsp12 - 1), True, yyvs46.item (yyvsp46), yyvs87.item (yyvsp87), yyvs12.item (yyvsp12))
					end
				end
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp64 := yyvsp64 + 1
	yyvsp110 := yyvsp110 -1
	yyvsp20 := yyvsp20 -1
	yyvsp21 := yyvsp21 -1
	yyvsp12 := yyvsp12 -2
	yyvsp46 := yyvsp46 -1
	yyvsp87 := yyvsp87 -1
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

	yy_do_action_371
			--|#line <not available> "eiffel.y"
		local
			yyval64: detachable LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs20.item (yyvsp20) as l_invariant_pair then
					if attached yyvs21.item (yyvsp21) as l_until_pair then
						yyval64 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), l_invariant_pair.first, l_invariant_pair.second, l_until_pair.first, l_until_pair.second, extract_keyword (yyvs13.item (yyvsp13)), False, yyvs46.item (yyvsp46), yyvs87.item (yyvsp87), yyvs12.item (yyvsp12))
					else
						yyval64 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), l_invariant_pair.first, l_invariant_pair.second, Void, Void, extract_keyword (yyvs13.item (yyvsp13)), False, yyvs46.item (yyvsp46), yyvs87.item (yyvsp87), yyvs12.item (yyvsp12))
					end
				else
					if attached yyvs21.item (yyvsp21) as l_until_pair then
						yyval64 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), Void, Void, l_until_pair.first, l_until_pair.second, extract_keyword (yyvs13.item (yyvsp13)), False, yyvs46.item (yyvsp46), yyvs87.item (yyvsp87), yyvs12.item (yyvsp12))
					else
						yyval64 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), Void, Void, Void, Void, extract_keyword (yyvs13.item (yyvsp13)), False, yyvs46.item (yyvsp46), yyvs87.item (yyvsp87), yyvs12.item (yyvsp12))
					end
				end
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp64 := yyvsp64 + 1
	yyvsp110 := yyvsp110 -1
	yyvsp20 := yyvsp20 -1
	yyvsp21 := yyvsp21 -1
	yyvsp13 := yyvsp13 -1
	yyvsp46 := yyvsp46 -1
	yyvsp87 := yyvsp87 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_372
			--|#line <not available> "eiffel.y"
		local
			yyval110: detachable ITERATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				insert_supplier ("ITERABLE", yyvs2.item (yyvsp2))
				insert_supplier ("ITERATION_CURSOR", yyvs2.item (yyvsp2))
				yyval110 := ast_factory.new_iteration_as (extract_keyword (yyvs13.item (yyvsp13)), yyvs46.item (yyvsp46), yyvs12.item (yyvsp12), yyvs2.item (yyvsp2))
				enter_scope
				add_scope_iteration (yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp110 := yyvsp110 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp46 := yyvsp46 -1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_373
			--|#line <not available> "eiffel.y"
		local
			yyval20: detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]
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

	yy_do_action_374
			--|#line <not available> "eiffel.y"
		local
			yyval20: detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval20 := ast_factory.new_invariant_pair (yyvs12.item (yyvsp12), yyvs120.item (yyvsp120)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp120 := yyvsp120 -1
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

	yy_do_action_375
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp63 := yyvsp63 + 1
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

	yy_do_action_376
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval63 := ast_factory.new_invariant_as (yyvs120.item (yyvsp120), once_manifest_string_counter_value, yyvs12.item (yyvsp12), object_test_locals)
				reset_once_manifest_string_counter
				object_test_locals := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp120 := yyvsp120 -1
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_377
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Invariant_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp63 := yyvsp63 + 1
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

	yy_do_action_378
			--|#line <not available> "eiffel.y"
		local
			yyval21: detachable PAIR [KEYWORD_AS, EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


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

	yy_do_action_379
			--|#line <not available> "eiffel.y"
		local
			yyval21: detachable PAIR [KEYWORD_AS, EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := ast_factory.new_exit_condition_pair (yyvs12.item (yyvsp12), yyvs46.item (yyvsp46)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp21 := yyvsp21 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_380
			--|#line <not available> "eiffel.y"
		local
			yyval87: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp87 := yyvsp87 + 1
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

	yy_do_action_381
			--|#line <not available> "eiffel.y"
		local
			yyval87: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval87 := yyvs87.item (yyvsp87) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines87.force (yyvs87, yyval87, yyvsp87)
end
		end

	yy_do_action_382
			--|#line <not available> "eiffel.y"
		local
			yyval87: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval87 := ast_factory.new_variant_as (yyvs2.item (yyvsp2), yyvs46.item (yyvsp46), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp87 := yyvsp87 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_383
			--|#line <not available> "eiffel.y"
		local
			yyval87: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval87 := ast_factory.new_variant_as (Void, yyvs46.item (yyvsp46), yyvs12.item (yyvsp12), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp87 := yyvsp87 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_384
			--|#line <not available> "eiffel.y"
		local
			yyval41: detachable DEBUG_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval41 := ast_factory.new_debug_as (yyvs119.item (yyvsp119), yyvs111.item (yyvsp111), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp41 := yyvsp41 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp119 := yyvsp119 -1
	yyvsp111 := yyvsp111 -1
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

	yy_do_action_385
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable KEY_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_386
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable KEY_LIST_AS
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
				yyval119 := ast_factory.new_key_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp119 := yyvsp119 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_387
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable KEY_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval119 := ast_factory.new_key_list_as (yyvs118.item (yyvsp118), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp119 := yyvsp119 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp118 := yyvsp118 -1
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

	yy_do_action_388
			--|#line <not available> "eiffel.y"
		local
			yyval118: detachable EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval118 := ast_factory.new_eiffel_list_string_as (counter_value + 1)
				if attached yyval118 as l_list and then attached yyvs14.item (yyvsp14) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp118 := yyvsp118 + 1
	yyvsp14 := yyvsp14 -1
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

	yy_do_action_389
			--|#line <not available> "eiffel.y"
		local
			yyval118: detachable EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval118 := yyvs118.item (yyvsp118)
				if attached yyval118 as l_list and then attached yyvs14.item (yyvsp14) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp14 := yyvsp14 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines118.force (yyvs118, yyval118, yyvsp118)
end
		end

	yy_do_action_390
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp16 := yyvsp16 + 1
	if yyvsp16 >= yyvsc16 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs16")
		end
		yyvsc16 := yyvsc16 + yyInitial_yyvs_size
		yyvs16 := yyspecial_routines16.aliased_resized_area (yyvs16, yyvsc16)
	end
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_391
			--|#line <not available> "eiffel.y"
		local
			yyval16: detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs111.item (yyvsp111) = Void then
					yyval16 := ast_factory.new_keyword_instruction_list_pair (yyvs12.item (yyvsp12), ast_factory.new_eiffel_list_instruction_as (0))
				else
					yyval16 := ast_factory.new_keyword_instruction_list_pair (yyvs12.item (yyvsp12), yyvs111.item (yyvsp111))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp16 := yyvsp16 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp111 := yyvsp111 -1
	if yyvsp16 >= yyvsc16 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs16")
		end
		yyvsc16 := yyvsc16 + yyInitial_yyvs_size
		yyvs16 := yyspecial_routines16.aliased_resized_area (yyvs16, yyvsc16)
	end
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_392
			--|#line <not available> "eiffel.y"
		local
			yyval27: detachable ASSIGN_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_assign_as (ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp27 := yyvsp27 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_393
			--|#line <not available> "eiffel.y"
		local
			yyval27: detachable ASSIGN_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_assign_as (yyvs6.item (yyvsp6), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp27 := yyvsp27 + 1
	yyvsp6 := yyvsp6 -1
	yyvsp4 := yyvsp4 -1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_394
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REVERSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := ast_factory.new_reverse_as (ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp75 := yyvsp75 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_395
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REVERSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := ast_factory.new_reverse_as (yyvs6.item (yyvsp6), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp75 := yyvsp75 + 1
	yyvsp6 := yyvsp6 -1
	yyvsp4 := yyvsp4 -1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_396
			--|#line <not available> "eiffel.y"
		local
			yyval92: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp92 := yyvsp92 + 1
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

	yy_do_action_397
			--|#line <not available> "eiffel.y"
		local
			yyval92: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval92 := yyvs92.item (yyvsp92) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines92.force (yyvs92, yyval92, yyvsp92)
end
		end

	yy_do_action_398
			--|#line <not available> "eiffel.y"
		local
			yyval92: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval92 := ast_factory.new_eiffel_list_create_as (counter_value + 1)
				if attached yyval92 as l_list and then attached yyvs38.item (yyvsp38) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp92 := yyvsp92 + 1
	yyvsp38 := yyvsp38 -1
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

	yy_do_action_399
			--|#line <not available> "eiffel.y"
		local
			yyval92: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval92 := yyvs92.item (yyvsp92)
				if attached yyval92 as l_list and then attached yyvs38.item (yyvsp38) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp38 := yyvsp38 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines92.force (yyvs92, yyval92, yyvsp92)
end
		end

	yy_do_action_400
			--|#line <not available> "eiffel.y"
		local
			yyval38: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval38 := ast_factory.new_create_as (Void, Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_401
			--|#line <not available> "eiffel.y"
		local
			yyval38: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval38 := ast_factory.new_create_as (yyvs35.item (yyvsp35), yyvs101.item (yyvsp101), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp38 := yyvsp38 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp35 := yyvsp35 -1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_402
			--|#line <not available> "eiffel.y"
		local
			yyval38: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval38 := ast_factory.new_create_as (ast_factory.new_client_as (yyvs108.item (yyvsp108)), Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp38 := yyvsp38 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp108 := yyvsp108 -1
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

	yy_do_action_403
			--|#line <not available> "eiffel.y"
		local
			yyval38: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval38 := ast_factory.new_create_as (Void, Void, yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_404
			--|#line <not available> "eiffel.y"
		local
			yyval38: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval38 := ast_factory.new_create_as (yyvs35.item (yyvsp35), yyvs101.item (yyvsp101), yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp38 := yyvsp38 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp35 := yyvsp35 -1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_405
			--|#line <not available> "eiffel.y"
		local
			yyval38: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval38 := ast_factory.new_create_as (ast_factory.new_client_as (yyvs108.item (yyvsp108)), Void, yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp38 := yyvsp38 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp108 := yyvsp108 -1
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

	yy_do_action_406
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval78 := ast_factory.new_inline_agent_creation_as (
				ast_factory.new_body_as (yyvs125.item (yyvsp125), Void, Void, yyvs77.item (yyvsp77), Void, Void, Void, Void), yyvs114.item (yyvsp114), yyvs12.item (yyvsp12))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp78 := yyvsp78 -1
	yyvsp12 := yyvsp12 -1
	yyvsp125 := yyvsp125 -1
	yyvsp77 := yyvsp77 -1
	yyvsp114 := yyvsp114 -1
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_407
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
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
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
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

	yy_do_action_409
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval78 := ast_factory.new_inline_agent_creation_as (
				ast_factory.new_body_as (yyvs125.item (yyvsp125), yyvs82.item (yyvsp82), Void, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), Void, Void, Void), yyvs114.item (yyvsp114), yyvs12.item (yyvsp12))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp78 := yyvsp78 -1
	yyvsp12 := yyvsp12 -1
	yyvsp125 := yyvsp125 -1
	yyvsp4 := yyvsp4 -1
	yyvsp82 := yyvsp82 -1
	yyvsp77 := yyvsp77 -1
	yyvsp114 := yyvsp114 -1
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_410
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
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

	yy_do_action_411
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
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

	yy_do_action_412
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval78 := ast_factory.new_agent_routine_creation_as (
				Void, yyvs2.item (yyvsp2), yyvs114.item (yyvsp114), False, yyvs12.item (yyvsp12), Void)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyvsp114 := yyvsp114 -1
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

	yy_do_action_413
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if attached yyvs22.item (yyvsp22) as l_target then
				yyval78 := ast_factory.new_agent_routine_creation_as (l_target.operand, yyvs2.item (yyvsp2), yyvs114.item (yyvsp114), True, yyvs12.item (yyvsp12), yyvs4.item (yyvsp4))
				if attached yyval78 as l_agent then
					l_agent.set_lparan_symbol (l_target.lparan_symbol)
					l_agent.set_rparan_symbol (l_target.rparan_symbol)
				end
			else
				yyval78 := ast_factory.new_agent_routine_creation_as (Void, yyvs2.item (yyvsp2), yyvs114.item (yyvsp114), True, yyvs12.item (yyvsp12), yyvs4.item (yyvsp4))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp78 := yyvsp78 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp22 := yyvsp22 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp114 := yyvsp114 -1
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

	yy_do_action_414
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable FORMAL_ARGU_DEC_LIST_AS
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

	yy_do_action_415
			--|#line <not available> "eiffel.y"
		local
			yyval125: detachable FORMAL_ARGU_DEC_LIST_AS
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

	yy_do_action_416
			--|#line <not available> "eiffel.y"
		local
			yyval22: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval22 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), Void)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp22 := yyvsp22 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_417
			--|#line <not available> "eiffel.y"
		local
			yyval22: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval22 := ast_factory.new_agent_target_triple (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), ast_factory.new_operand_as (Void, Void, yyvs46.item (yyvsp46))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp22 := yyvsp22 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -4
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_418
			--|#line <not available> "eiffel.y"
		local
			yyval22: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval22 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, yyvs6.item (yyvsp6), Void)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp22 := yyvsp22 + 1
	yyvsp6 := yyvsp6 -1
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

	yy_do_action_419
			--|#line <not available> "eiffel.y"
		local
			yyval22: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval22 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, yyvs9.item (yyvsp9), Void)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp22 := yyvsp22 + 1
	yyvsp9 := yyvsp9 -1
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

	yy_do_action_420
			--|#line <not available> "eiffel.y"
		local
			yyval22: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval22 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (yyvs82.item (yyvsp82), Void, Void))
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp22 := yyvsp22 + 1
	yyvsp82 := yyvsp82 -1
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

	yy_do_action_421
			--|#line <not available> "eiffel.y"
		local
			yyval22: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if attached ast_factory.new_operand_as (Void, Void, Void) as l_temp_operand_as then
				l_temp_operand_as.set_question_mark_symbol (yyvs4.item (yyvsp4))
				yyval22 := ast_factory.new_agent_target_triple (Void, Void, l_temp_operand_as)
			else
				yyval22 := ast_factory.new_agent_target_triple (Void, Void, Void)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp22 := yyvsp22 + 1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_422
			--|#line <not available> "eiffel.y"
		local
			yyval114: detachable DELAYED_ACTUAL_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp114 := yyvsp114 + 1
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

	yy_do_action_423
			--|#line <not available> "eiffel.y"
		local
			yyval114: detachable DELAYED_ACTUAL_LIST_AS
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
				yyval114 := ast_factory.new_delayed_actual_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp114 := yyvsp114 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_424
			--|#line <not available> "eiffel.y"
		local
			yyval114: detachable DELAYED_ACTUAL_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval114 := ast_factory.new_delayed_actual_list_as (yyvs113.item (yyvsp113), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp114 := yyvsp114 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp113 := yyvsp113 -1
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

	yy_do_action_425
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval113 := ast_factory.new_eiffel_list_operand_as (counter_value + 1)
				if attached yyval113 as l_list and then attached yyvs68.item (yyvsp68) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp113 := yyvsp113 + 1
	yyvsp68 := yyvsp68 -1
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

	yy_do_action_426
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval113 := yyvs113.item (yyvsp113)
				if attached yyval113 as l_list and then attached yyvs68.item (yyvsp68) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp68 := yyvsp68 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_427
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := ast_factory.new_operand_as (Void, Void, Void)
				if attached yyval68 as l_actual then
					l_actual.set_question_mark_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp68 := yyvsp68 + 1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_428
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := ast_factory.new_operand_as (yyvs82.item (yyvsp82), Void, Void)
				if attached yyval68 as l_actual then
					l_actual.set_question_mark_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_429
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := ast_factory.new_operand_as (Void, Void, yyvs46.item (yyvsp46)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp68 := yyvsp68 + 1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_430
			--|#line <not available> "eiffel.y"
		local
			yyval39: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval39 := ast_factory.new_bang_creation_as (Void, yyvs23.item (yyvsp23), yyvs25.item (yyvsp25), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp39 := yyvsp39 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp23 := yyvsp23 -1
	yyvsp25 := yyvsp25 -1
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

	yy_do_action_431
			--|#line <not available> "eiffel.y"
		local
			yyval39: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval39 := ast_factory.new_bang_creation_as (yyvs82.item (yyvsp82), yyvs23.item (yyvsp23), yyvs25.item (yyvsp25), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp39 := yyvsp39 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp82 := yyvsp82 -1
	yyvsp23 := yyvsp23 -1
	yyvsp25 := yyvsp25 -1
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

	yy_do_action_432
			--|#line <not available> "eiffel.y"
		local
			yyval39: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval39 := ast_factory.new_create_creation_as (yyvs31.item (yyvsp31), Void, yyvs23.item (yyvsp23), yyvs25.item (yyvsp25), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp39 := yyvsp39 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp31 := yyvsp31 -1
	yyvsp23 := yyvsp23 -1
	yyvsp25 := yyvsp25 -1
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

	yy_do_action_433
			--|#line <not available> "eiffel.y"
		local
			yyval39: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval39 := ast_factory.new_create_creation_as (yyvs31.item (yyvsp31), yyvs82.item (yyvsp82), yyvs23.item (yyvsp23), yyvs25.item (yyvsp25), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp39 := yyvsp39 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp31 := yyvsp31 -1
	yyvsp82 := yyvsp82 -1
	yyvsp23 := yyvsp23 -1
	yyvsp25 := yyvsp25 -1
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

	yy_do_action_434
			--|#line <not available> "eiffel.y"
		local
			yyval40: detachable CREATION_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := ast_factory.new_create_creation_expr_as (yyvs31.item (yyvsp31), yyvs82.item (yyvsp82), yyvs25.item (yyvsp25), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp40 := yyvsp40 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp31 := yyvsp31 -1
	yyvsp82 := yyvsp82 -1
	yyvsp25 := yyvsp25 -1
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

	yy_do_action_435
			--|#line <not available> "eiffel.y"
		local
			yyval40: detachable CREATION_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval40 := ast_factory.new_bang_creation_expr_as (yyvs82.item (yyvsp82), yyvs25.item (yyvsp25), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp40 := yyvsp40 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp82 := yyvsp82 -1
	yyvsp25 := yyvsp25 -1
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

	yy_do_action_436
			--|#line <not available> "eiffel.y"
		local
			yyval31: BOOLEAN
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp31 := yyvsp31 + 1
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

	yy_do_action_437
			--|#line <not available> "eiffel.y"
		local
			yyval31: BOOLEAN
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval31 := True
				if attached yyvs2.item (yyvsp2) as l_id then
					if {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						yyval31 := False
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs2.item (yyvsp2)), token_column (yyvs2.item (yyvsp2)), filename, "Passive regions should use type specifier %"NONE%"."))
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_438
			--|#line <not available> "eiffel.y"
		local
			yyval23: detachable ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval23 := ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp23 := yyvsp23 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_439
			--|#line <not available> "eiffel.y"
		local
			yyval23: detachable ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval23 := yyvs6.item (yyvsp6) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp23 := yyvsp23 + 1
	yyvsp6 := yyvsp6 -1
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

	yy_do_action_440
			--|#line <not available> "eiffel.y"
		local
			yyval25: detachable ACCESS_INV_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp25 := yyvsp25 + 1
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

	yy_do_action_441
			--|#line <not available> "eiffel.y"
		local
			yyval25: detachable ACCESS_INV_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval25 := ast_factory.new_access_inv_as (yyvs2.item (yyvsp2), yyvs98.item (yyvsp98), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp25 := yyvsp25 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_442
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := yyvs23.item (yyvsp23) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp32 := yyvsp32 + 1
	yyvsp23 := yyvsp23 -1
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

	yy_do_action_443
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := yyvs70.item (yyvsp70) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp32 := yyvsp32 + 1
	yyvsp70 := yyvsp70 -1
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

	yy_do_action_444
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := yyvs71.item (yyvsp71) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp32 := yyvsp32 + 1
	yyvsp71 := yyvsp71 -1
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

	yy_do_action_445
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := yyvs32.item (yyvsp32) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_446
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable CHECK_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := ast_factory.new_check_as (yyvs120.item (yyvsp120), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp34 := yyvsp34 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp120 := yyvsp120 -1
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

	yy_do_action_447
			--|#line <not available> "eiffel.y"
		local
			yyval54: detachable GUARD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval54 := ast_factory.new_guard_as (yyvs12.item (yyvsp12 - 2), yyvs120.item (yyvsp120), yyvs12.item (yyvsp12 - 1), yyvs111.item (yyvsp111), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp54 := yyvsp54 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp120 := yyvsp120 -1
	yyvsp111 := yyvsp111 -1
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

	yy_do_action_448
			--|#line <not available> "eiffel.y"
		local
			yyval79: detachable SEPARATE_INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval79 := ast_factory.new_separate_instruction_as (yyvs12.item (yyvsp12 - 2), yyvs102.item (yyvsp102), yyvs12.item (yyvsp12 - 1), yyvs111.item (yyvsp111), yyvs12.item (yyvsp12))
				leave_scope
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp12 := yyvsp12 -3
	yyvsp1 := yyvsp1 -2
	yyvsp102 := yyvsp102 -1
	yyvsp111 := yyvsp111 -1
	yyspecial_routines79.force (yyvs79, yyval79, yyvsp79)
end
		end

	yy_do_action_449
			--|#line <not available> "eiffel.y"
		local
			yyval79: detachable SEPARATE_INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

enter_scope
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp79 := yyvsp79 + 1
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

	yy_do_action_450
			--|#line <not available> "eiffel.y"
		local
			yyval66: detachable NAMED_EXPRESSION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval66 := ast_factory.new_named_expression_as (yyvs46.item (yyvsp46), yyvs12.item (yyvsp12), yyvs2.item (yyvsp2))
				add_scope_separate (yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp46 := yyvsp46 -1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_451
			--|#line <not available> "eiffel.y"
		local
			yyval102: detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval102 := ast_factory.new_eiffel_list_named_expression_as (counter_value + 1)
				if attached yyval102 as l_list and then attached yyvs66.item (yyvsp66) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp102 := yyvsp102 + 1
	yyvsp66 := yyvsp66 -1
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

	yy_do_action_452
			--|#line <not available> "eiffel.y"
		local
			yyval102: detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval102 := yyvs102.item (yyvsp102)
				if attached yyval102 as l_list and then attached yyvs66.item (yyvsp66) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp66 := yyvsp66 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines102.force (yyvs102, yyval102, yyvsp102)
end
		end

	yy_do_action_453
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := yyvs82.item (yyvsp82)
				if attached yyval82 as l_type then
					l_type.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_type.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_454
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_455
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp72 := yyvsp72 -1
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

	yy_do_action_456
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs46.item (yyvsp46) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_457
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_bin_tilde_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp46 := yyvsp46 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_458
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_bin_not_tilde_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp46 := yyvsp46 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_459
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_bin_eq_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp46 := yyvsp46 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_460
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_bin_ne_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp46 := yyvsp46 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_461
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs29.item (yyvsp29) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp29 := yyvsp29 -1
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

	yy_do_action_462
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs46.item (yyvsp46))
				yyval46 := ast_factory.new_object_test_as (extract_keyword (yyvs13.item (yyvsp13)), Void, yyvs46.item (yyvsp46), Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp13 := yyvsp13 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_463
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs46.item (yyvsp46))
				yyval46 := ast_factory.new_object_test_as (extract_keyword (yyvs13.item (yyvsp13)), Void, yyvs46.item (yyvsp46), yyvs12.item (yyvsp12), yyvs2.item (yyvsp2))
				add_scope_test (yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_464
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs82.item (yyvsp82) as l_type then
					l_type.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_type.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
				check_object_test_expression (yyvs46.item (yyvsp46))
				yyval46 := ast_factory.new_object_test_as (extract_keyword (yyvs13.item (yyvsp13)), yyvs82.item (yyvsp82), yyvs46.item (yyvsp46), Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp13 := yyvsp13 -1
	yyvsp4 := yyvsp4 -2
	yyvsp82 := yyvsp82 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_465
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs82.item (yyvsp82) as l_type then
					l_type.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_type.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
				check_object_test_expression (yyvs46.item (yyvsp46))
				yyval46 := ast_factory.new_object_test_as (extract_keyword (yyvs13.item (yyvsp13)), yyvs82.item (yyvsp82), yyvs46.item (yyvsp46), yyvs12.item (yyvsp12), yyvs2.item (yyvsp2))
				if attached yyvs2.item (yyvsp2) as l_name and attached yyvs82.item (yyvsp82) as l_type then
					insert_object_test_locals ([l_name, l_type])
				end
				add_scope_test (yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp13 := yyvsp13 -1
	yyvsp4 := yyvsp4 -2
	yyvsp82 := yyvsp82 -1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_466
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs46.item (yyvsp46))
				yyval46 := ast_factory.new_old_syntax_object_test_as (yyvs4.item (yyvsp4 - 2), yyvs2.item (yyvsp2), yyvs82.item (yyvsp82), yyvs46.item (yyvsp46))
				if attached yyvs2.item (yyvsp2) as l_name and attached yyvs82.item (yyvsp82) as l_type then
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
	yyvsp82 := yyvsp82 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_467
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_plus_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_468
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_minus_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_469
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_star_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_470
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_slash_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_471
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_mod_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_472
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_div_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_473
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_power_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_474
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_and_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_475
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_and_then_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp12 := yyvsp12 -2
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

	yy_do_action_476
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_or_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_477
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_or_else_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46),yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp12 := yyvsp12 -2
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

	yy_do_action_478
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_implies_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_479
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_xor_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_480
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_ge_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_481
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_gt_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_482
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_le_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_483
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_lt_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_484
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_bin_free_as (yyvs46.item (yyvsp46 - 1), yyvs2.item (yyvsp2), yyvs46.item (yyvsp46)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp46 := yyvsp46 -2
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_485
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs11.item (yyvsp11) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp11 := yyvsp11 -1
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

	yy_do_action_486
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs26.item (yyvsp26) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp26 := yyvsp26 -1
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

	yy_do_action_487
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs78.item (yyvsp78) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp78 := yyvsp78 -1
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

	yy_do_action_488
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_un_old_as (yyvs46.item (yyvsp46), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_489
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_un_strip_as (yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp46 := yyvsp46 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -2
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_490
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_address_as (yyvs88.item (yyvsp88), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp46 := yyvsp46 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp88 := yyvsp88 -1
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

	yy_do_action_491
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_address_current_as (yyvs9.item (yyvsp9), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp46 := yyvsp46 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp9 := yyvsp9 -1
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

	yy_do_action_492
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_address_result_as (yyvs6.item (yyvsp6), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp46 := yyvsp46 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp6 := yyvsp6 -1
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

	yy_do_action_493
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs46.item (yyvsp46) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_494
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_expr_call_as (yyvs32.item (yyvsp32)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp32 := yyvsp32 -1
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

	yy_do_action_495
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs46.item (yyvsp46) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_496
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs56.item (yyvsp56) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp56 := yyvsp56 -1
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

	yy_do_action_497
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_bracket_as (yyvs46.item (yyvsp46), yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_498
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_bracket_as (ast_factory.new_expr_call_as (yyvs32.item (yyvsp32)), yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp46 := yyvsp46 + 1
	yyvsp32 := yyvsp32 -1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
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

	yy_do_action_499
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_un_minus_as (yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_500
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_un_plus_as (yyvs46.item (yyvsp46), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_501
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_un_not_as (yyvs46.item (yyvsp46), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_502
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_un_free_as (yyvs2.item (yyvsp2), yyvs46.item (yyvsp46)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_503
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_type_expr_as (yyvs82.item (yyvsp82)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp82 := yyvsp82 -1
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

	yy_do_action_504
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_505
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp72 := yyvsp72 -1
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

	yy_do_action_506
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

	yy_do_action_507
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_nested_as (yyvs9.item (yyvsp9), yyvs32.item (yyvsp32), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp9 := yyvsp9 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_508
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_nested_as (yyvs6.item (yyvsp6), yyvs32.item (yyvsp32), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp6 := yyvsp6 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_509
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_nested_as (yyvs23.item (yyvsp23), yyvs32.item (yyvsp32), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp23 := yyvsp23 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_510
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_nested_expr_as (yyvs46.item (yyvsp46), yyvs32.item (yyvsp32), yyvs4.item (yyvsp4), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -3
	yyvsp46 := yyvsp46 -1
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_511
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_nested_expr_as (ast_factory.new_bracket_as (yyvs46.item (yyvsp46), yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)), yyvs32.item (yyvsp32), yyvs4.item (yyvsp4), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp46 := yyvsp46 -1
	yyvsp4 := yyvsp4 -3
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_512
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_nested_expr_as (ast_factory.new_bracket_as (ast_factory.new_expr_call_as (yyvs32.item (yyvsp32 - 1)), yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)), yyvs32.item (yyvsp32), yyvs4.item (yyvsp4), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp32 := yyvsp32 -1
	yyvsp4 := yyvsp4 -3
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_513
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_nested_as (yyvs70.item (yyvsp70), yyvs32.item (yyvsp32), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp70 := yyvsp70 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_514
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_nested_as (yyvs71.item (yyvsp71), yyvs32.item (yyvsp32), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_515
			--|#line <not available> "eiffel.y"
		local
			yyval70: detachable PRECURSOR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval70 := ast_factory.new_precursor_as (yyvs12.item (yyvsp12), Void, yyvs98.item (yyvsp98)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_516
			--|#line <not available> "eiffel.y"
		local
			yyval70: detachable PRECURSOR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void) as l_temp_class_type_as then
					l_temp_class_type_as.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_temp_class_type_as.set_rcurly_symbol (yyvs4.item (yyvsp4))
					yyval70 := ast_factory.new_precursor_as (yyvs12.item (yyvsp12), l_temp_class_type_as, yyvs98.item (yyvsp98))
				else
					yyval70 := ast_factory.new_precursor_as (yyvs12.item (yyvsp12), Void, yyvs98.item (yyvsp98))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp70 := yyvsp70 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -2
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_517
			--|#line <not available> "eiffel.y"
		local
			yyval71: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := yyvs71.item (yyvsp71) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines71.force (yyvs71, yyval71, yyvsp71)
end
		end

	yy_do_action_518
			--|#line <not available> "eiffel.y"
		local
			yyval71: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := yyvs71.item (yyvsp71) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines71.force (yyvs71, yyval71, yyvsp71)
end
		end

	yy_do_action_519
			--|#line <not available> "eiffel.y"
		local
			yyval71: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_static_access_as (yyvs82.item (yyvsp82), yyvs2.item (yyvsp2), yyvs98.item (yyvsp98), Void, yyvs4.item (yyvsp4)); 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp71 := yyvsp71 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_520
			--|#line <not available> "eiffel.y"
		local
			yyval71: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval71 := ast_factory.new_static_access_as (yyvs82.item (yyvsp82), yyvs2.item (yyvsp2), yyvs98.item (yyvsp98), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4));
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)),
							filename, once "Remove the `feature' keyword."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp71 := yyvsp71 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_521
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := yyvs67.item (yyvsp67) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp32 := yyvsp32 + 1
	yyvsp67 := yyvsp67 -1
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

	yy_do_action_522
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := yyvs24.item (yyvsp24) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp32 := yyvsp32 + 1
	yyvsp24 := yyvsp24 -1
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

	yy_do_action_523
			--|#line <not available> "eiffel.y"
		local
			yyval67: detachable NESTED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval67 := ast_factory.new_nested_as (yyvs24.item (yyvsp24 - 1), yyvs24.item (yyvsp24), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp67 := yyvsp67 + 1
	yyvsp24 := yyvsp24 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_524
			--|#line <not available> "eiffel.y"
		local
			yyval67: detachable NESTED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval67 := ast_factory.new_nested_as (yyvs24.item (yyvsp24), yyvs67.item (yyvsp67), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp24 := yyvsp24 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines67.force (yyvs67, yyval67, yyvsp67)
end
		end

	yy_do_action_525
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

	yy_do_action_526
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs88.item (yyvsp88) as l_infix then
					yyval2 := l_infix.internal_name
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp88 := yyvsp88 -1
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

	yy_do_action_527
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs88.item (yyvsp88) as l_prefix then
					yyval2 := l_prefix.internal_name
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp88 := yyvsp88 -1
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

	yy_do_action_528
			--|#line <not available> "eiffel.y"
		local
			yyval23: detachable ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level
				when Normal_level then
					yyval23 := ast_factory.new_access_id_as (yyvs2.item (yyvsp2), yyvs98.item (yyvsp98))
				when Assert_level then
					yyval23 := ast_factory.new_access_assert_as (yyvs2.item (yyvsp2), yyvs98.item (yyvsp98))
				when Invariant_level then
					yyval23 := ast_factory.new_access_inv_as (yyvs2.item (yyvsp2), yyvs98.item (yyvsp98), Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp23 := yyvsp23 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_529
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable ACCESS_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_access_feat_as (yyvs2.item (yyvsp2), yyvs98.item (yyvsp98)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp24 := yyvsp24 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_530
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs28.item (yyvsp28) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp28 := yyvsp28 -1
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

	yy_do_action_531
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs46.item (yyvsp46) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_532
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp81 := yyvsp81 -1
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

	yy_do_action_533
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_expr_call_as (yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp9 := yyvsp9 -1
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

	yy_do_action_534
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_expr_call_as (yyvs6.item (yyvsp6)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp6 := yyvsp6 -1
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

	yy_do_action_535
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_expr_call_as (yyvs40.item (yyvsp40)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp40 := yyvsp40 -1
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

	yy_do_action_536
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs64.item (yyvsp64) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp64 := yyvsp64 -1
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

	yy_do_action_537
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_paran_as (yyvs46.item (yyvsp46), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_538
			--|#line <not available> "eiffel.y"
		local
			yyval98: detachable PARAMETER_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp98 := yyvsp98 + 1
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

	yy_do_action_539
			--|#line <not available> "eiffel.y"
		local
			yyval98: detachable PARAMETER_LIST_AS
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
				yyval98 := ast_factory.new_parameter_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp98 := yyvsp98 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_540
			--|#line <not available> "eiffel.y"
		local
			yyval98: detachable PARAMETER_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval98 := ast_factory.new_parameter_list_as (yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp98 := yyvsp98 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
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

	yy_do_action_541
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs46.item (yyvsp46) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_542
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := ast_factory.new_expr_address_as (yyvs46.item (yyvsp46), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -3
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_543
			--|#line <not available> "eiffel.y"
		local
			yyval97: detachable EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval97 := ast_factory.new_eiffel_list_expr_as (counter_value + 1)
				if attached yyval97 as l_list and then attached yyvs46.item (yyvsp46) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp97 := yyvsp97 + 1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_544
			--|#line <not available> "eiffel.y"
		local
			yyval97: detachable EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval97 := yyvs97.item (yyvsp97)
				if attached yyval97 as l_list and then attached yyvs46.item (yyvsp46) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp46 := yyvsp46 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines97.force (yyvs97, yyval97, yyvsp97)
end
		end

	yy_do_action_545
			--|#line <not available> "eiffel.y"
		local
			yyval97: detachable EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval97 := ast_factory.new_eiffel_list_expr_as (counter_value + 1)
				if attached yyval97 as l_list and then attached yyvs46.item (yyvsp46) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp97 := yyvsp97 + 1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_546
			--|#line <not available> "eiffel.y"
		local
			yyval97: detachable EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval97 := yyvs97.item (yyvsp97)
				if attached yyval97 as l_list and then attached yyvs46.item (yyvsp46) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp46 := yyvsp46 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines97.force (yyvs97, yyval97, yyvsp97)
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

				yyval2 := yyvs2.item (yyvsp2);
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
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

				if attached yyvs2.item (yyvsp2) as l_id then
					l_id.to_upper		
					yyval2 := l_id
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_550
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs13.item (yyvsp13))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_551
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs13.item (yyvsp13))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_552
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs13.item (yyvsp13))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_553
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs13.item (yyvsp13))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_554
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs13.item (yyvsp13))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_555
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs13.item (yyvsp13))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_556
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

	yy_do_action_557
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

	yy_do_action_558
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

	yy_do_action_559
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs13.item (yyvsp13))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_560
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs13.item (yyvsp13))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_561
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs13.item (yyvsp13))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_562
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs13.item (yyvsp13))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_563
			--|#line <not available> "eiffel.y"
		local
			yyval56: detachable IF_EXPRESSION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval56 := ast_factory.new_if_expression_as (yyvs46.item (yyvsp46 - 2), yyvs46.item (yyvsp46 - 1), Void, yyvs46.item (yyvsp46), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp56 := yyvsp56 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp46 := yyvsp46 -3
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

	yy_do_action_564
			--|#line <not available> "eiffel.y"
		local
			yyval56: detachable IF_EXPRESSION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval56 := ast_factory.new_if_expression_as (yyvs46.item (yyvsp46 - 2), yyvs46.item (yyvsp46 - 1), yyvs94.item (yyvsp94), yyvs46.item (yyvsp46), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp56 := yyvsp56 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp46 := yyvsp46 -3
	yyvsp94 := yyvsp94 -1
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

	yy_do_action_565
			--|#line <not available> "eiffel.y"
		local
			yyval94: detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval94 := yyvs94.item (yyvsp94) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines94.force (yyvs94, yyval94, yyvsp94)
end
		end

	yy_do_action_566
			--|#line <not available> "eiffel.y"
		local
			yyval94: detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval94 := ast_factory.new_eiffel_list_elseif_expression_as (counter_value + 1)
				if attached yyval94 as l_list and then attached yyvs43.item (yyvsp43) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp94 := yyvsp94 + 1
	yyvsp43 := yyvsp43 -1
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

	yy_do_action_567
			--|#line <not available> "eiffel.y"
		local
			yyval94: detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval94 := yyvs94.item (yyvsp94)
				if attached yyval94 as l_list and then attached yyvs43.item (yyvsp43) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp43 := yyvsp43 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines94.force (yyvs94, yyval94, yyvsp94)
end
		end

	yy_do_action_568
			--|#line <not available> "eiffel.y"
		local
			yyval43: detachable ELSIF_EXPRESSION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval43 := ast_factory.new_elseif_expression_as (yyvs46.item (yyvsp46 - 1), yyvs46.item (yyvsp46), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp43 := yyvsp43 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp46 := yyvsp46 -2
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

	yy_do_action_569
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp5 := yyvsp5 -1
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

	yy_do_action_570
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_571
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_572
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_573
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp72 := yyvsp72 -1
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

	yy_do_action_574
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp72 := yyvsp72 -1
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

	yy_do_action_575
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp14 := yyvsp14 -1
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

	yy_do_action_576
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp5 := yyvsp5 -1
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

	yy_do_action_577
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_578
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_579
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp72 := yyvsp72 -1
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

	yy_do_action_580
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp14 := yyvsp14 -1
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

	yy_do_action_581
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp5 := yyvsp5 -1
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

	yy_do_action_582
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_583
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_584
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp72 := yyvsp72 -1
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

	yy_do_action_585
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp72 := yyvsp72 -1
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

	yy_do_action_586
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_587
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp14 := yyvsp14 -1
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

	yy_do_action_588
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs14.item (yyvsp14) as l_string then
					l_string.set_is_once_string (True)
					l_string.set_once_string_keyword (yyvs12.item (yyvsp12))
				end
				increment_once_manifest_string_counter
				yyval28 := yyvs14.item (yyvsp14)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp28 := yyvsp28 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp14 := yyvsp14 -1
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

	yy_do_action_589
			--|#line <not available> "eiffel.y"
		local
			yyval5: detachable BOOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_590
			--|#line <not available> "eiffel.y"
		local
			yyval5: detachable BOOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_591
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

	yy_do_action_592
			--|#line <not available> "eiffel.y"
		local
			yyval3: detachable CHAR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval3 := ast_factory.new_typed_char_as (yyvs82.item (yyvsp82), yyvs3.item (yyvsp3))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp82 := yyvsp82 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
		end

	yy_do_action_593
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_594
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_595
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_596
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval60 := ast_factory.new_integer_value (Current, '+', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp60 := yyvsp60 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_597
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval60 := ast_factory.new_integer_value (Current, '-', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp60 := yyvsp60 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_598
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval60 := ast_factory.new_integer_value (Current, '%U', Void, token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_599
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_600
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_601
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval60 := ast_factory.new_integer_value (Current, '%U', yyvs82.item (yyvsp82), token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp60 := yyvsp60 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_602
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval60 := ast_factory.new_integer_value (Current, '+', yyvs82.item (yyvsp82), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp60 := yyvsp60 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_603
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval60 := ast_factory.new_integer_value (Current, '-', yyvs82.item (yyvsp82), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp60 := yyvsp60 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_604
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_605
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_606
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_607
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, False, '%U', Void, token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp72 := yyvsp72 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_608
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, True, '+', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp72 := yyvsp72 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_609
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, True, '-', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp72 := yyvsp72 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_610
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_611
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_612
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, False, '%U', yyvs82.item (yyvsp82), token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp72 := yyvsp72 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_613
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, True, '+', yyvs82.item (yyvsp82), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp72 := yyvsp72 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_614
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, True, '-', yyvs82.item (yyvsp82), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp72 := yyvsp72 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_615
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_616
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_617
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_618
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_619
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_620
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval14 := yyvs14.item (yyvsp14)
				if attached yyval14 as l_string then
					l_string.set_type (yyvs82.item (yyvsp82))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp82 := yyvsp82 -1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_621
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_622
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_623
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_624
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_625
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_626
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_627
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_628
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_629
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_630
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_631
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_632
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_633
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_634
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_635
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_636
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_637
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_638
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_639
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_640
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_641
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_642
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_643
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_644
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_645
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_646
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs14.item (yyvsp14) as l_str_not then
					l_str_not.value.to_lower
					yyval14 := l_str_not
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_647
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs14.item (yyvsp14) as l_str_free then
					l_str_free.value.to_lower
					yyval14 := l_str_free
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_648
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_649
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_650
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_651
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_652
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_653
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_654
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_655
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_656
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_657
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_658
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_659
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs14.item (yyvsp14) as l_str_and then
					l_str_and.value.to_lower
					yyval14 := l_str_and
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_660
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs14.item (yyvsp14) as l_str_and_then then
					l_str_and_then.value.to_lower
					yyval14 := l_str_and_then
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_661
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs14.item (yyvsp14) as l_str_implies then 
					l_str_implies.value.to_lower
					yyval14 := l_str_implies
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_662
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs14.item (yyvsp14) as l_str_or then
					l_str_or.value.to_lower
					yyval14 := l_str_or
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_663
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs14.item (yyvsp14) as l_str_or_else then
					l_str_or_else.value.to_lower
					yyval14 := l_str_or_else
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_664
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs14.item (yyvsp14) as l_str_xor then
					l_str_xor.value.to_lower
					yyval14 := l_str_xor
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_665
			--|#line <not available> "eiffel.y"
		local
			yyval14: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs14.item (yyvsp14) as l_str_free then
					l_str_free.value.to_lower
					yyval14 := l_str_free
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
		end

	yy_do_action_666
			--|#line <not available> "eiffel.y"
		local
			yyval26: detachable ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval26 := ast_factory.new_array_as (ast_factory.new_eiffel_list_expr_as (0), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_667
			--|#line <not available> "eiffel.y"
		local
			yyval26: detachable ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval26 := ast_factory.new_array_as (ast_factory.new_eiffel_list_expr_as (0), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if attached yyval26 as a then
					a.set_type (yyvs82.item (yyvsp82))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp26 := yyvsp26 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_668
			--|#line <not available> "eiffel.y"
		local
			yyval26: detachable ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval26 := ast_factory.new_array_as (yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp26 := yyvsp26 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
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

	yy_do_action_669
			--|#line <not available> "eiffel.y"
		local
			yyval26: detachable ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval26 := ast_factory.new_array_as (yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if attached yyval26 as a then
					a.set_type (yyvs82.item (yyvsp82))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp26 := yyvsp26 + 1
	yyvsp82 := yyvsp82 -1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
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

	yy_do_action_670
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TUPLE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := ast_factory.new_tuple_as (ast_factory.new_eiffel_list_expr_as (0), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp81 := yyvsp81 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_671
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TUPLE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := ast_factory.new_tuple_as (yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp81 := yyvsp81 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
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

	yy_do_action_672
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

	yy_do_action_673
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

	yy_do_action_674
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

	yy_do_action_675
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

	yy_do_action_676
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

	yy_do_action_677
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
			when 1222 then
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
			create an_array.make_filled (0, 0, 393)
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
			  135,  136,  137,  138, yyDummy>>,
			1, 194, 200)
		end

	yyr1_template: SPECIAL [INTEGER]
			-- Template for `yyr1'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 677)
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
			    0,  348,  348,  348,  348,  348,  348,  348,  348,  349,
			  353,  354,  355,  356,  357,  316,  316,  316,  316,  316,
			  319,  319,  319,  317,  317,  318,  318,  207,  209,  208,
			  208,  210,  280,  280,  280,  281,  281,  158,  158,  158,
			  158,  362,  363,  360,  361,  352,  352,  352,  364,  364,
			  365,  365,  172,  172,  146,  146,  299,  299,  300,  300,
			  194,  194,  174,  366,  173,  173,  314,  314,  315,  315,
			  298,  298,  139,  139,  193,  367,  369,  303,  303,  279,
			  279,  278,  278,  277,  277,  277,  275,  276,  142,  252,
			  252,  252,  252,  140,  140,  141,  141,  163,  163,  163,

			  163,  163,  163,  163,  163,  144,  144,  175,  175,  326,
			  326,  326,  326,  370,  327,  327,  228,  270,  229,  229,
			  229,  229,  229,  229,  329,  329,  328,  328,  240,  294,
			  294,  293,  293,  292,  292,  184,  195,  195,  195,  285,
			  285,  284,  284,  176,  176,  301,  302,  302,  307,  307,
			  306,  306,  309,  309,  308,  308,  311,  311,  310,  310,
			  343,  343,  339,  339,  271,  341,  341,  272,  272,  147,
			  147,  148,  148,  244,  371,  372,  243,  243,  243,  191,
			  192,  145,  145,  220,  220,  220,  342,  342,  342,  321,
			  321,  322,  322,  212,  368,  368,  213,  213,  213,  213, yyDummy>>,
			1, 200, 0)
		end

	yyr1_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yyr1'.
		do
			yyarray_subcopy (an_array, <<
			  213,  213,  213,  213,  213,  213,  213,  213,  213,  213,
			  213,  213,  241,  241,  373,  241,  374,  183,  183,  375,
			  183,  376,  332,  332,  333,  333,  377,  254,  254,  254,
			  256,  256,  256,  256,  259,  259,  259,  259,  259,  259,
			  259,  259,  259,  259,  259,  259,  259,  259,  259,  259,
			  259,  259,  263,  263,  260,  257,  257,  257,  257,  257,
			  257,  257,  257,  257,  257,  257,  257,  257,  257,  257,
			  257,  257,  257,  262,  262,  264,  264,  269,  269,  269,
			  266,  266,  266,  268,  268,  267,  267,  267,  335,  335,
			  334,  334,  336,  337,  337,  261,  261,  261,  261,  338,

			  338,  338,  340,  340,  340,  312,  312,  312,  313,  313,
			  196,  196,  196,  196,  197,  380,  345,  345,  345,  347,
			  381,  382,  347,  265,  265,  265,  346,  346,  383,  305,
			  305,  205,  205,  205,  205,  288,  289,  289,  181,  211,
			  211,  282,  282,  283,  283,  169,  323,  323,  221,  221,
			  221,  221,  221,  221,  221,  221,  221,  221,  221,  221,
			  221,  221,  221,  221,  221,  221,  224,  224,  224,  224,
			  223,  223,  320,  149,  149,  222,  222,  384,  150,  150,
			  274,  274,  273,  273,  180,  331,  331,  331,  330,  330,
			  143,  143,  157,  157,  242,  242,  286,  286,  287,  287, yyDummy>>,
			1, 200, 200)
		end

	yyr1_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yyr1'.
		do
			yyarray_subcopy (an_array, <<
			  177,  177,  177,  177,  177,  177,  245,  385,  386,  245,
			  387,  388,  245,  245,  344,  344,  151,  151,  151,  151,
			  151,  151,  325,  325,  325,  324,  324,  227,  227,  227,
			  178,  178,  178,  178,  179,  179,  165,  165,  153,  153,
			  155,  155,  166,  166,  166,  166,  171,  198,  253,  389,
			  225,  304,  304,  258,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  187,  187,  187,  187,  187,
			  187,  187,  187,  187,  187,  187,  187,  188,  188,  188,

			  188,  188,  188,  189,  189,  189,  203,  168,  168,  168,
			  168,  168,  168,  168,  168,  230,  230,  231,  231,  233,
			  232,  167,  167,  226,  226,  204,  204,  204,  152,  154,
			  185,  185,  185,  185,  185,  185,  185,  185,  297,  297,
			  297,  190,  190,  296,  296,  295,  295,  199,  199,  200,
			  200,  200,  200,  200,  200,  200,  201,  202,  202,  202,
			  202,  202,  202,  206,  206,  290,  291,  291,  182,  161,
			  161,  161,  161,  161,  161,  161,  159,  159,  159,  159,
			  159,  160,  160,  160,  160,  160,  160,  160,  160,  164,
			  164,  170,  170,  214,  214,  214,  215,  215,  216,  217, yyDummy>>,
			1, 200, 400)
		end

	yyr1_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yyr1'.
		do
			yyarray_subcopy (an_array, <<
			  217,  218,  219,  219,  234,  234,  234,  236,  235,  235,
			  237,  237,  238,  239,  239,  246,  246,  248,  248,  248,
			  249,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  251,  251,  251,  251,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  156,  156,  156,  156,
			  255,  255,  358,  350,  378,  359,  379,  351, yyDummy>>,
			1, 78, 600)
		end

	yytypes1_template: SPECIAL [INTEGER]
			-- Template for `yytypes1'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1224)
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
			    1,   13,   13,   13,   13,   13,   13,   12,   12,   12,
			   12,    2,    2,    2,  109,    1,    1,    1,    1,   12,
			   63,   49,    1,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   13,   13,
			   12,   12,   12,   12,   12,   12,   12,   12,   11,    9,
			    6,    5,    5,    4,    4,    4,    4,    4,    3,    1,
			    1,    4,   12,   12,   12,    2,    4,    4,   23,   26,
			   28,   29,    5,   32,   32,    3,   40,   46,   46,   46,
			   46,   46,    2,    2,    2,   56,   60,   60,   60,   60,

			   64,   70,   71,   71,   71,   72,   72,   72,   72,   78,
			   14,   14,   14,   14,   81,   82,   88,   88,  110,   13,
			   13,   13,   13,   13,   13,   12,   12,   12,   12,   12,
			    4,    4,    2,    2,    2,    2,   82,   82,   82,   82,
			   82,   82,   82,   82,   82,   82,   83,   12,   10,    1,
			    1,   57,  109,    1,   57,  109,    1,   86,  123,    1,
			   63,   12,    2,   88,   88,   88,   88,   88,  101,    4,
			   46,   46,    4,   14,   82,   46,   82,    4,   31,    9,
			    6,    4,    4,   22,    2,    2,   82,  125,  125,   14,
			   14,   14,   14,   14,    4,    4,   98,   14,   14,   14, yyDummy>>,
			1, 200, 0)
		end

	yytypes1_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,    4,    4,   13,   13,
			    4,    4,   82,   82,   82,   82,   13,   13,   13,   13,
			    2,    2,    2,   82,    4,    1,    9,    6,    2,   88,
			    4,    1,   46,   46,    4,   46,    1,    1,   46,    1,
			    1,   46,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			   12,   12,   12,   12,    2,   46,   98,    4,    4,    4,
			    3,    1,    1,    4,    4,    4,   14,   12,   20,   12,
			   82,   82,   12,   82,   82,   13,   13,   12,   82,   82,

			   82,   82,    9,    2,   82,   82,   13,   13,   12,   82,
			   82,   12,   82,   82,   82,   82,    4,  121,  121,    1,
			    4,    4,   12,    1,   12,   12,   12,   12,    1,    4,
			    4,    1,    2,   57,    1,    1,    4,    4,    4,   28,
			   28,    5,    3,    2,   57,   60,   60,   60,   60,   60,
			   60,   72,   72,   72,   72,   72,   72,   14,   82,   89,
			    1,    1,    1,   19,    2,  120,    1,   88,   12,   15,
			    4,    1,   82,   12,   12,   12,    4,    2,   82,    4,
			    1,    4,    4,  114,    4,   78,    2,    4,    1,   24,
			   32,    2,   67,   32,    4,    4,    4,   46,   97,   97, yyDummy>>,
			1, 200, 200)
		end

	yytypes1_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    4,   19,    1,   32,    1,    1,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   12,   46,   46,   12,   46,   46,   46,   32,   32,
			    4,    1,    2,    1,    1,    1,    1,  120,   12,   21,
			   82,   82,   82,   82,   12,   82,   82,   12,   82,   82,
			   82,   82,    4,   12,   82,   82,   12,   82,   82,   82,
			   82,    4,  121,    1,    1,    2,    2,    2,    2,    2,
			    1,    1,    4,    1,  109,    4,    4,    1,    4,   40,
			  123,    1,    4,   46,    2,   80,  120,   14,   14,   14,
			   14,   14,    1,   49,    4,    2,    2,   46,    2,    4,

			    4,   25,   85,  122,    1,    2,    4,    1,   82,   12,
			   18,   77,    4,    4,   46,   46,   97,    4,   98,   25,
			   82,    4,    1,    1,    4,    4,   19,   97,   97,   46,
			   46,   97,   98,   46,   13,   12,   82,   82,   82,   82,
			    2,   82,   82,   82,   82,    4,   82,  121,    4,    4,
			  107,  109,   28,    2,   89,    1,   89,   12,   81,    4,
			    4,    1,    4,    4,  120,    1,   12,   12,  101,   13,
			    4,    4,   12,   30,  125,   46,   12,   94,    1,   98,
			    2,    1,    1,   19,   46,    2,  114,    4,   46,   68,
			   82,  113,   78,   14,   77,   78,   98,    4,    4,    1, yyDummy>>,
			1, 200, 400)
		end

	yytypes1_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			   24,   67,    4,    1,    4,    4,   32,    1,    1,    1,
			    1,   46,   46,    4,    1,    4,    2,   82,  121,  122,
			    4,    1,   12,   18,    4,   89,    4,    1,   12,   82,
			   19,    4,   46,  120,   82,    1,  109,   49,    4,   12,
			   12,   46,   12,   12,   43,   94,   98,  122,    1,    4,
			    1,    1,    4,    4,    1,   77,   12,   74,  114,   46,
			    1,    4,   46,   97,    4,    4,    4,   12,   87,   87,
			   87,    1,    4,    4,    4,    4,    1,   14,   18,    1,
			    1,    4,    4,   13,   17,   77,    1,   82,  109,    2,
			   12,   46,   46,    1,    1,    4,    1,    1,    4,   78,

			   12,   74,   77,    4,   97,    4,    4,   46,    2,   12,
			   12,  121,    1,   82,    1,   12,   12,   12,   52,   53,
			    2,  107,    1,   89,    2,   13,   13,    4,  109,  109,
			    4,   17,   77,   12,   12,   94,   82,    4,  113,  114,
			   74,  120,   12,  124,   32,   32,    4,  121,  122,    4,
			    4,    2,  121,    2,    2,    2,   53,    4,    1,   12,
			  115,    8,    3,   28,    5,   36,   60,   60,   72,   72,
			   14,  109,   12,    1,   36,   77,   12,   46,    4,  120,
			    1,   13,   12,   12,   12,   10,   47,   61,   76,   46,
			    1,    4,    4,  126,    1,    1,    4,    4,    1,    1, yyDummy>>,
			1, 200, 600)
		end

	yytypes1_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			   13,  109,   77,  109,  109,  109,  123,  111,    1,    4,
			  119,   48,   14,  111,   12,   44,    1,    1,    4,    4,
			    4,   82,   82,   82,   82,  128,  107,    4,    2,    2,
			   69,   69,   84,  115,  115,    1,    1,   77,    1,    1,
			    4,    1,  111,   18,   12,   44,   12,   16,    2,  122,
			    1,  128,   12,  103,    4,  121,    1,    4,   12,   12,
			   12,   12,   12,   96,  104,  105,  106,  117,    1,    1,
			  109,   12,   12,   12,   12,   12,   12,   12,   12,    7,
			    6,    4,   27,   32,   32,   34,   39,   41,   46,   54,
			    2,   55,   58,   59,   59,   65,   71,   75,   79,   82,

			  110,  111,   14,  118,   44,  120,  111,   12,    4,  127,
			  128,  117,  101,    1,  115,  115,  101,  101,    1,  101,
			    4,    1,  104,  104,  105,  105,  106,  106,   12,   96,
			   96,   92,    1,    1,   79,   46,   46,  111,  119,   31,
			  120,    4,    4,    4,   82,    4,    4,    4,    4,    4,
			    1,    1,    4,   12,   20,    1,    4,    1,  120,    1,
			    1,    4,  128,   12,   88,  101,    1,   73,   88,  116,
			    4,   45,   95,  108,  105,  106,   12,  104,   12,   91,
			   12,   12,   38,   92,    1,   90,    1,   12,   20,  111,
			    6,   23,    2,   82,   12,   12,   46,   46,   23,    4, yyDummy>>,
			1, 200, 800)
		end

	yytypes1_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    1,   46,    1,   46,   46,  111,   46,  111,   21,    1,
			    4,    4,  127,   12,    4,    1,  115,    4,   12,    1,
			    4,    1,    1,    1,   12,   51,  101,  106,   12,  105,
			    1,  100,    1,   35,  108,   35,  108,    1,    1,   46,
			   66,  102,   12,   12,   12,   33,   90,  111,   12,   87,
			   12,   25,   23,  111,   25,   23,   97,   97,   20,   12,
			  118,  103,  127,    1,    1,    1,   88,    2,  108,   95,
			    4,   12,  106,   37,   88,   91,    1,   12,   35,   50,
			  100,  101,  101,   92,   12,    4,    1,  111,    1,    1,
			    1,   12,   12,   93,    1,   46,   12,   25,   12,   25,

			    1,    1,   21,  111,  101,  116,    4,    1,   12,    4,
			    4,    4,    1,   63,   35,    1,    1,    1,    1,    2,
			    1,   12,   12,    4,    4,    3,    2,   60,   62,   71,
			   82,  112,   90,  111,   12,   12,   12,   42,   93,   12,
			   46,    4,    4,   12,   87,    1,    4,    1,    4,    4,
			  109,   35,  108,   49,   99,  100,  102,  111,    4,    4,
			    4,    4,    4,    4,    4,    1,   12,  111,   46,    1,
			    1,  111,   12,    4,    4,  111,   12,  108,   91,  121,
			  121,   12,    1,    1,   12,    3,    2,   71,   82,    3,
			    2,   60,   71,    2,   60,   71,   82,    1,    3,    2, yyDummy>>,
			1, 200, 1000)
		end

	yytypes1_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			   60,   71,   12,   12,   12,   93,   87,  111,   46,   46,
			   87,    4,    4,   99,    1,  112,  111,  111,   12,   12,
			   12,    4,    1,    1,    1, yyDummy>>,
			1, 25, 1200)
		end

	yytypes2_template: SPECIAL [INTEGER]
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    4,    4,   12,   12,   12,   12,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    2,   12,   12,   12,    4,    4,
			    2,    2,    1,    1,    3,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    5,    5,    6,    7,    8,    9,   10,   11,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,

			   12,   12,   12,   12,   12,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER]
			-- Template for `yydefact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1224)
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
			   15,  672,  672,  562,  561,  560,  559,  673,  375,  673,
			    0,  558,  557,    0,   48,    1,  673,  673,  673,  377,
			    6,    3,    0,  635,  634,  643,  642,  641,  640,  639,
			  638,  637,  636,  633,  632,  631,  630,  629,  628,  627,
			  626,  625,  624,  623,  619,  622,  618,  621,  561,  559,
			    0,    0,    0,  436,  414,    0,  538,    0,  485,  533,
			  534,  590,  589,    0,    0,  673,    0,  673,  591,  607,
			  598,    0,    0,    0,    0,  506,    0,    0,  442,  486,
			  530,  461,  581,  494,  445,  586,  535,  493,    4,  456,
			  495,  531,  525,    0,  538,  496,  582,  454,  504,  583,

			  536,  443,  444,  518,  517,  584,  455,  505,  585,  487,
			  587,  617,  615,  616,  532,  503,  526,  527,  373,  555,
			  554,  553,  552,  551,  550,    0,    0,    0,    0,    0,
			    0,    0,  556,  549,  288,  673,    2,  231,  230,  252,
			  253,  255,  234,  273,  232,  233,  274,   49,   50,    0,
			   50,   72,  677,    0,  675,  677,   43,  675,  677,    0,
			  673,    0,   83,   84,   85,   81,   79,   77,  677,    0,
			  462,    0,    0,  588,    0,    0,    0,    0,    0,  419,
			  418,  421,  673,    0,  525,  422,  420,  415,  407,  647,
			  646,  645,  644,   87,    0,  673,  515,  665,  664,  663, yyDummy>>,
			1, 200, 0)
		end

	yydefact_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  662,  661,  660,  659,  658,  657,  656,  655,  654,  653,
			  652,  651,  650,  649,  648,   86,    0,    0,  554,  553,
			    0,    0,  281,  280,    0,  282,  562,  561,  560,  559,
			  558,  557,    0,    0,  666,    0,  491,  492,   83,  490,
			  670,    0,    0,  488,  673,  501,  609,  597,  499,  608,
			  596,  500,    0,  673,  673,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  502,  528,    0,    0,  673,
			  592,  612,  601,    0,    0,    0,  620,  673,  378,    0,
			  257,  235,    0,  256,  236,  554,  553,    0,  259,  238,

			  260,  239,  276,  275,    0,  285,  554,  553,    0,  258,
			  237,    0,  284,  287,  283,  286,  673,  289,  254,  674,
			    0,    0,   51,   46,   52,   53,    0,   50,   45,   73,
			  675,   18,    0,  677,  673,   16,   34,    0,    0,   32,
			   38,  576,  577,   37,  677,  578,  593,  594,  595,  599,
			  600,  579,  604,  605,  606,  610,  611,  580,    0,   72,
			    0,  673,    8,  677,  169,  376,    0,   80,    0,   82,
			  675,   75,    0,    0,    0,    0,    0,    0,  440,  160,
			  673,    0,  673,  412,    0,   54,    0,  539,    0,  522,
			  507,  538,  521,  508,  440,    0,  453,  545,  677,  677, yyDummy>>,
			1, 200, 200)
		end

	yydefact_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  537,    0,    0,  509,    0,    0,  473,  472,  471,  470,
			  469,  468,  467,  480,  482,  481,  483,  459,  460,  458,
			  457,    0,  474,  479,    0,  476,  478,  484,  513,  514,
			  667,    0,  538,  614,  603,  613,  602,  374,    0,    0,
			  262,  240,  261,  241,    0,  269,  247,    0,  268,  248,
			  270,  249,    0,    0,  264,  242,    0,  263,  243,  265,
			  244,  291,    0,    0,    0,  277,  279,  305,  548,  547,
			   47,  673,   43,   28,   24,  675,   43,   27,   30,    0,
			  166,   72,  675,   72,  525,  226,  677,   92,   91,   90,
			   89,   93,    0,   95,  453,  463,  372,  673,  538,  437,

			    0,  434,  675,  677,    0,  422,  423,    0,  410,    0,
			  174,  408,  538,    0,  541,  543,  677,    0,  529,  435,
			    0,  675,    0,    0,    0,  489,  677,  677,  677,  475,
			  477,  677,  519,  379,    0,    0,  272,  250,  271,  251,
			  278,  267,  245,  266,  246,  290,  293,  677,    0,  673,
			  181,   26,   35,   37,   31,   43,   72,   44,    0,    0,
			  167,    0,  227,   72,    0,  223,   94,   88,   78,   96,
			    0,  673,   15,   76,   95,  464,    0,    0,    0,  520,
			  538,  673,    0,  677,  677,  525,  413,  427,  429,  425,
			  503,  677,   54,   55,  212,  422,  516,    0,  675,    0, yyDummy>>,
			1, 200, 400)
		end

	yydefact_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  523,  524,    0,    0,  668,  671,  510,  172,    0,    0,
			    0,  380,  380,  675,  292,  296,  549,    0,  297,  298,
			  306,   41,    0,   54,  675,   33,   29,   39,   44,   72,
			  170,  229,   72,  225,  105,  673,   54,  194,    0,   15,
			    0,    0,    0,    0,  675,  677,  441,  163,    0,  161,
			    0,  677,  675,  428,    0,  411,  214,  175,  406,    0,
			    0,  540,  466,  546,  498,  497,  669,    0,  381,    0,
			    0,    0,  675,    0,  675,  299,    0,  182,   10,   43,
			   40,  168,  228,    0,   20,  100,   74,  105,   54,  465,
			  563,    0,    0,    0,  565,    0,    0,    0,  424,  422,

			  216,  673,  186,  542,  544,    0,    0,  383,  525,  371,
			  370,  294,    0,   72,    0,    0,    0,    0,  315,  308,
			  313,   42,  109,   36,  106,   15,  672,    0,   54,   97,
			  195,   95,  103,  564,    0,  567,   72,  417,  426,  409,
			  673,  213,  673,    0,  512,  511,    0,  300,  303,  302,
			  676,  549,  301,  310,  311,  312,  316,  675,  677,  673,
			   11,  108,  570,  107,  569,   20,  571,  572,  573,  574,
			  575,   54,   21,  673,   20,  102,   15,  568,  164,  215,
			  673,  194,  385,    0,  194,  178,  177,  176,  217,  382,
			  673,  675,    0,  314,    0,    0,    0,  110,    0,  109, yyDummy>>,
			1, 200, 600)
		end

	yydefact_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  672,   99,  101,  677,   98,   54,  677,  185,  673,  673,
			  194,  181,  180,  183,  219,  390,    0,    0,    0,    0,
			  673,  325,  323,  322,  324,  329,  309,  307,    0,  288,
			  675,   72,  118,  677,   12,  673,   16,  104,  188,    0,
			  386,    0,  184,  179,  221,  673,  194,    0,    0,  304,
			    0,    0,  673,  317,  113,  117,    0,  116,  673,  673,
			  673,  673,  673,  148,  152,  156,    0,  129,  111,  673,
			  677,   22,  449,    0,    0,  194,  385,  436,  673,  211,
			  534,    0,  202,  197,  445,  208,  196,  207,    0,  209,
			  525,  204,  206,  675,  194,  205,  444,  203,  210,  503,

			  373,  677,  388,  677,  673,  218,  391,  173,  675,  677,
			  326,  321,    0,    0,  673,  115,  151,  159,    0,  155,
			  132,    0,  149,  152,  153,  156,  157,    0,  119,  130,
			  148,  139,    0,    0,  673,  673,    0,  373,  194,    0,
			    0,    0,    0,    0,    0,  673,    0,  673,    0,    0,
			    0,  193,    0,  194,  378,  190,  675,    0,  220,    0,
			    0,  328,    0,  330,  146,  677,    0,  126,    0,  677,
			  673,  675,  677,  673,  156,    0,  120,  152,  673,  673,
			  400,  403,  675,  677,    0,    0,    0,  194,    0,    0,
			  439,  440,  438,  440,  194,  446,  395,  393,  440,  440, yyDummy>>,
			1, 200, 800)
		end

	yydefact_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			    0,  198,    0,  394,  392,  192,  199,  373,    0,    0,
			  387,  329,    0,  319,  675,  145,  677,  675,    0,  125,
			   66,    0,    0,  131,  137,   72,  138,    0,  121,  156,
			    0,   13,    0,  673,  402,  673,  405,    0,  397,    0,
			  451,  677,  194,  339,  673,  675,  677,  673,    0,    0,
			  384,  432,  440,    0,  430,  440,  677,  677,  378,  194,
			  389,  318,  327,    0,  112,    0,  128,   68,  677,  134,
			  135,  122,    0,  141,    0,  677,  375,   63,  673,  675,
			  677,  401,  404,  399,    0,  675,    0,    0,    0,    0,
			  342,  194,  331,    0,    0,    0,    0,  433,  447,  431,

			    0,    0,    0,  380,  147,  127,  675,    0,  123,  675,
			    0,    0,  140,   15,   64,  673,   60,    0,   57,  450,
			    0,  194,  340,    0,    0,  350,  352,  348,  346,  358,
			    0,  677,  344,    0,  194,  333,    0,  675,  677,  194,
			    0,    0,    0,  194,    0,    0,   67,    0,  673,  673,
			    0,   62,   65,  675,  677,   59,  452,    0,    0,    0,
			    0,  675,    0,    0,    0,    0,  332,    0,    0,    0,
			  335,  380,  194,    0,    0,  380,  369,   69,  142,    0,
			    0,    9,  673,   14,  448,  351,  357,  365,    0,  356,
			  353,  354,  360,  355,  349,  363,    0,    0,  364,  359, yyDummy>>,
			1, 200, 1000)
		end

	yydefact_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  362,  361,  194,  334,  194,  337,    0,    0,  201,  200,
			    0,  144,    0,   71,   61,  347,  345,  338,  367,  366,
			  368,  143,    0,    0,    0, yyDummy>>,
			1, 25, 1200)
		end

	yydefgoto_template: SPECIAL [INTEGER]
			-- Template for `yydefgoto'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 250)
			yydefgoto_template_1 (an_array)
			yydefgoto_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yydefgoto_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yydefgoto'.
		do
			yyarray_subcopy (an_array, <<
			  330,  567,  572,  369,  847,  684,  623,  510,  583,  401,
			  288,  439,  183,   78,  991,  389,  501,   79,  882,  339,
			  340,   80,  763,   81,  573,   82,  178,   83,  390,   84,
			 1045,   85,  885,  326, 1033, 1078,  765, 1073,  982,  886,
			   86,  887, 1137,  644,  815,  971,   87,  397,   89,   90,
			   91,  515,  786,  811, 1153, 1079, 1025,  718,  719,  889,
			 1067,  134,  135,   92,   93,   94,  891,   95,  154,  344,
			  151,  333,  892,  893,  894,  345,   96,   97,  348,   98,
			   99,  787, 1128,   20,  100,  895, 1040,  392,  589,  830,
			  831,  101,  102,  103,  104,  351,  105,  106,  354,  107,

			  108,  967,  657,  897,  788,  511,  109,  110,  111,  112,
			  113,  215,  193,  491,  898,  485,  114,  617,  137,  115,
			  138,  139,  140,  141,  142,  143,  823,  224,  144,  145,
			  146,  832,  502,  157,  668,  669,  116,  117,  165,  166,
			  167,  359,  554,  985, 1046, 1075,  979,  931,  983, 1093,
			 1138,  577,  645,  972,  863,  930,  398,  516,  196, 1154,
			 1031, 1080,  912,  965,  168, 1041,  853,  922,  923,  924,
			  925,  926,  927,  550,  721,  973, 1068,   14,  155,  152,
			  729,  118,  807,  901, 1131,  591,  383,  760,  833,  969,
			  867,  903,  810,  365,  486,  317,  318,  462,  547,  747, yyDummy>>,
			1, 200, 0)
		end

	yydefgoto_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yydefgoto'.
		do
			yyarray_subcopy (an_array, <<
			  503,  748,  158,  743,  187,  188,  793,  909,  910, 1222,
			   15,  366,  331,  149,  722,  799,  869, 1076, 1116,   16,
			  334,  360,  627,  676,  758,  150,  323, 1114,  493,  808,
			  637,  914,  594,  702,  701,  740,  845,  904,  564,  464,
			  790,  756,  851,  962, 1012,  160,  385,  595,  592,  699,
			  934, yyDummy>>,
			1, 51, 200)
		end

	yypact_template: SPECIAL [INTEGER]
			-- Template for `yypact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1224)
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
			 1918, 1506, 1462, -32768, -32768, -32768, -32768, 1061,  492, -32768,
			 2315, -32768, -32768, 4237,   86, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 1066, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2803, 2315,
			 3963, 2315,  959,  669, 1305,  361,  317, 4454, -32768, 1025,
			 1016, -32768, -32768,  964, 4270, 1003, 2351, 1004, -32768, -32768,
			 -32768, 2315, 2315, 1000, 2315, -32768, 2681, 2559, 1006, -32768,
			 -32768, -32768, -32768, 1001, -32768, -32768, -32768,  998, 4825, -32768,
			 -32768, -32768, -32768, 2315,  824, -32768, -32768, -32768, -32768, -32768,

			 -32768,  999,  994, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, 3248, -32768, -32768,  530, -32768,
			 2182, 2042, -32768, -32768, -32768, 1822, 1177,  285,  640, 1659,
			 1404, 1404, -32768, -32768,  661, 3959, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  993, -32768, -32768,  989, -32768,  877,  305,
			  307, 1409, -32768,  182, 1233, -32768, 1760,   58, -32768,  182,
			   71,  605,  950, -32768, -32768, -32768, -32768,  967, -32768, 4270,
			  939, 4523, 4237, -32768, 4645, 3476,  977,  640,  959, -32768,
			 -32768, -32768,  818,  970,  969,  749, -32768, -32768,  946, -32768,
			 -32768, -32768, -32768, -32768,  640,  948, -32768, -32768, -32768, -32768, yyDummy>>,
			1, 200, 0)
		end

	yypact_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  605,  605, -32768, -32768,
			  901,  901, -32768, -32768,  940, -32768, 3619, 3534, 3874, 3789,
			  335, 3704,  931,  935, -32768, 2315, -32768, -32768, -32768, -32768,
			 -32768, 2315, 4717, -32768,  938, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  605, -32768, -32768, 2315, 2315, 2315, 2315, 2315,
			 2315, 2315, 2315, 2315, 2315, 2315, 2315, 2315, 2315, 2315,
			 2193, 2315, 2071, 2315, 2315, -32768, -32768,  605,  605,  934,
			 -32768, -32768, -32768,  182,  504,  490, -32768,  258,  489, 1177,
			 -32768, -32768, 1177, -32768, -32768, 1588, 1560, 1177, -32768, -32768,

			 -32768, -32768, -32768, -32768,  936, -32768, 1269,  514, 1177, -32768,
			 -32768,  668, -32768, -32768, -32768, -32768,  937, -32768, -32768, -32768,
			  182,  182, -32768, -32768, -32768, -32768,  164,  877, -32768, -32768,
			 -32768, -32768,  917, -32768, -32768, -32768, -32768,  482,  477,  911,
			 -32768, -32768, -32768,  910, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 3395,  567,
			   95, -32768, -32768, -32768,  899, -32768, 2315, -32768, 4691, -32768,
			 -32768, -32768,  902,  182,  182, 2315,  182,  928,  564, -32768,
			 -32768,  605,  884, -32768, 4237,  645,  888, -32768, 2437,  819,
			 -32768,  824, -32768, -32768,  564, 4237, -32768, 4617, -32768, -32768, yyDummy>>,
			1, 200, 200)
		end

	yypact_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			  893,  883,  182, -32768, 2315, 2315,  479,  479,  479,  479,
			  479, 1397, 1397, 1721, 1721, 1721, 1721, 1721, 1721, 1721,
			 1721, 2315, 4462, 4860, 2315, 4843, 4482, -32768, -32768, -32768,
			 -32768, 2315,  824, -32768, -32768, -32768, -32768, -32768, 2315,   34,
			 -32768, -32768, -32768, -32768, 1177, -32768, -32768, 1177, -32768, -32768,
			 -32768, -32768,  182, 1177, -32768, -32768, 1177, -32768, -32768, -32768,
			 -32768, -32768,  878, 4237,  882, -32768, -32768,  880, -32768, -32768,
			 -32768, -32768, 3047, -32768, -32768, -32768, 1760, -32768, -32768,  196,
			 -32768,  443, -32768, 4660,  843, 1348, -32768, -32768, -32768, -32768,
			 -32768,  838, 1066,   51, 2315, -32768, -32768, 4432,  824, -32768,

			  182, -32768,  864, -32768, 2315,  749, -32768, 1599, -32768, 4645,
			 -32768, -32768,  824, 2841, 4825,  840, -32768,  605, -32768, -32768,
			  853, -32768,  845,  848,  605, -32768, -32768, -32768, -32768, 4462,
			 4843, -32768, -32768, 4825, 2315, 2315, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  834, -32768, 4112,  844,
			  660, -32768,  828, -32768, -32768, 1760,  567, -32768,  810, 4237,
			 -32768,  182, -32768, 1933, 2315, -32768, -32768, -32768, -32768, -32768,
			 4237,  818,  116, -32768,   24,  805, 2315,  791,  715, -32768,
			  824, -32768,  816, -32768, 4825,  364, -32768, -32768, 4825,  803,
			 3223, -32768,  645, -32768,  744,  749, -32768, 2315, -32768,  801, yyDummy>>,
			1, 200, 400)
		end

	yypact_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			  819, -32768, 2315, 2315, -32768, -32768, -32768, -32768,  800,  799,
			  790, 1821, 1821, -32768, -32768, -32768,  352,  260, -32768, -32768,
			 -32768, -32768, 4645,  645, -32768, -32768, -32768, -32768, -32768,  567,
			 -32768, -32768, 4660, -32768,  687, -32768,  645, -32768, 4237,  116,
			  182, 4597, 2315, 2315,  751, -32768, -32768, -32768,  182, -32768,
			  778, -32768, -32768, -32768,  779, -32768,  739, -32768, -32768, 4680,
			 2437, -32768, -32768, -32768,  784,  775, -32768, 2315, -32768,  740,
			  737, 4237, -32768, 4237, -32768, -32768,  236, -32768, -32768, 3047,
			 -32768, -32768, -32768,  182,  629, -32768,  601,  687,  645, -32768,
			 -32768, 4543, 3455,  715, -32768, 4237,  748, 1599, -32768,  749,

			 -32768,  706,  700, -32768, -32768,  605,  605, 4825,  722, -32768,
			 -32768, -32768, 4204,   68, 4123,  640,  640,  640, -32768,  719,
			 -32768, -32768,  666, -32768, -32768, 3076, 2905, 3198,  645, -32768,
			 -32768,  653, -32768, -32768, 2315, -32768,  567, -32768, -32768, -32768,
			  706, -32768, 1248,  879, -32768, -32768, 2315, -32768, -32768, -32768,
			 -32768,  711, -32768, -32768, -32768, -32768,  708, -32768, -32768,  757,
			 -32768, -32768, -32768, -32768, -32768,  644, -32768, -32768, -32768, -32768,
			 -32768,  645, -32768, -32768,  644, -32768,  116, 4825, -32768, -32768,
			 -32768, -32768,  655, 4670, -32768, -32768, -32768, -32768,  665, 4825,
			 -32768, -32768, 4153, -32768,  236,  716,  640, -32768,  640,  666, yyDummy>>,
			1, 200, 600)
		end

	yypact_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			  679, -32768, -32768, -32768, -32768,  645, -32768, -32768, 1091,  690,
			 -32768,  660, -32768, -32768,  604,  619,  609, 4123,  164,  164,
			 -32768, -32768, -32768,  613, -32768,  537, -32768, -32768,  663,  661,
			 2424,  567,  686, -32768, -32768, -32768,  593, -32768, -32768, 2925,
			 -32768, 4670, -32768, -32768, -32768,   19, -32768,  637,  349, -32768,
			 4303,  592, -32768, -32768, -32768, -32768,  640, -32768,  145,  636,
			  927,  167,  118,  573,  531,  510,  631,  607, -32768,  890,
			 -32768, -32768, -32768, 2315, 2315, -32768,  655,  669,  108, -32768,
			  106,  821, -32768,  641,  658, -32768, -32768, -32768,  618, -32768,
			   99, -32768, -32768, 2550, -32768, -32768,  303, -32768, -32768, 3273,

			  246, -32768,  634, -32768,   19, -32768, -32768, -32768, -32768, -32768,
			  633, -32768,  614,  605, -32768, -32768, -32768, -32768,  605, -32768,
			 -32768,  506, -32768,  531, -32768,  510, -32768,  602, -32768, -32768,
			  573,  588,  296,  593, -32768, 4412, 3435,  530, -32768,  426,
			   40, 2315, 2315, 1029,  606, -32768, 2315, -32768, 2315, 2315,
			 2925,  601, 2315, -32768,  489, -32768, -32768,  603, -32768,  609,
			  595, -32768,  571, -32768,  587, -32768,  640,  586,  560, -32768,
			  582,  255, -32768,  449,  510,  568, -32768,  531, -32768,  252,
			  846,  846,  647, -32768, 2315,  294,  461, -32768,   90,  559,
			 -32768,  564, -32768,  699, -32768, -32768, 4825, 4825,  564,  699, yyDummy>>,
			1, 200, 800)
		end

	yypact_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 2315, 4825, 2315, 4825, 4825, -32768, 4825,  530,  151, 4670,
			 -32768,  537, 4303, -32768, -32768, -32768, -32768, -32768,  605, -32768,
			 -32768,  164,  506, -32768, -32768,  567, -32768,  544, -32768,  510,
			  605, -32768,  462, -32768, 1152, -32768, 1152,  296, -32768, 4503,
			  552, -32768, -32768, -32768, -32768,  254, -32768,  244, 2315,  498,
			 -32768, -32768,  564,  535, -32768,  564, -32768, -32768,  489, -32768,
			 -32768, -32768, -32768,  605, -32768,  605, -32768,  543, -32768, -32768,
			 -32768, -32768,  523,  533,  271, -32768,  492, -32768, 1034,  189,
			 -32768, -32768, -32768, -32768,  182, -32768,  497,  511,  814,  461,
			 -32768, -32768, -32768,  183,  313, 4117, 2315, -32768, -32768, -32768,

			  527,  526,  471,  277, -32768, -32768, -32768,  513, -32768, -32768,
			  517,  512, -32768,  116,  506, -32768, -32768,  462, -32768, -32768,
			 2315, -32768, -32768,  509,  493,  516,  501,  491,  434,  486,
			 1235, -32768, -32768,  421, -32768, -32768, 2315,  142, -32768, -32768,
			 4097,  295,  281, -32768,  411,  164, -32768,  605, -32768, -32768,
			  407, -32768, -32768,  657, -32768, -32768, -32768,  400,  860,  814,
			 1168, -32768,  814,  431,  429,  355, -32768,  391, 3126,  313,
			 -32768,  277, -32768, 2315, 2315,  277, -32768, -32768, -32768,  324,
			  105, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  409, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  865,  814, -32768, -32768, yyDummy>>,
			1, 200, 1000)
		end

	yypact_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 -32768, -32768, -32768, -32768, -32768, -32768,  239,  216, 4825, 4825,
			   54, -32768,   87, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  107,   75, -32768, yyDummy>>,
			1, 25, 1200)
		end

	yypgoto_template: SPECIAL [INTEGER]
			-- Template for `yypgoto'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 250)
			yypgoto_template_1 (an_array)
			yypgoto_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yypgoto_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yypgoto'.
		do
			yyarray_subcopy (an_array, <<
			  -35, -32768, -533, -32768, -32768,  555,  425,  617, -123, -32768,
			 -785, -862, -32768, -32768, -772,  724, -384, -32768, -32768, -435,
			 -32768, -32768, -32768, -32768, -32768,  -25,  340, -777, -167, -786,
			 -32768,  -84, -32768, -32768, -929, -32768,  487, -32768, -32768, -32768,
			  852, -32768, -32768, -32768, -32768, -32768, -790,  158,  476, -32768,
			 -32768, -32768, -32768, -32768, 1195, -32768, -32768, -32768, -32768, -32768,
			  885, -149, -324,    0,  812,  -42, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -958, -121, -150, -32768,  -36,
			  -69, -32768, -32768,  127, -32768, -32768, -32768,  688, -32768, -32768,
			 -32768, -32768, -825, -32768, -32768, -32768,  -95, -122, -32768,  -68,

			  -93, -32768, -32768, -32768, -32768, -537, -32768,  -37, -752,  -50,
			 -32768,  833, -32768, -32768, -32768, -32768,  723,   17, -750,   -6,
			 -759, 1062, -32768,   -3,  -47, -127, -32768,  311,  -58, -760,
			 -32768, -32768, -32768, -32768,  191, -586,   -7,  -15,  -39, -160,
			 -32768, -400,  499, -32768,   98,   29, -32768, -32768,  133, -32768,
			   -5, -32768,  480,  147,  290, -32768, -217,  505,   76,  -19,
			 -32768,   38, -753,   82,  656,   23,  128,  309,  203,  299,
			 -820,  297, -830, -32768,  327, -924,  -26, -543, -309,  643,
			 -498, -792,  405,  152,  -86,  408, -462,  304, -788,   30,
			  250,   89,  218, -247,  525, -32768,  257, -637,  414, -509, yyDummy>>,
			1, 200, 0)
		end

	yypgoto_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yypgoto'.
		do
			yyarray_subcopy (an_array, <<
			  502, -531, -338, -32768,  575, -32768, -32768,   55,  270, -32768,
			 -32768,    2,  954, -32768, -32768, -32768, -32768, -32768, -117,    6,
			  288, -32768,  436, -32768, -32768, -32768, -112, -32768, -32768, -616,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, yyDummy>>,
			1, 51, 200)
		end

	yytable_template: SPECIAL [INTEGER]
			-- Template for `yytable'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 4884)
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
			Result := yyfixed_array (an_array)
		end

	yytable_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   13,  367,  469,  313,  315,  225,  347,  164,   17,   18,
			  519,   22,  185,  173,  896,  163,  223,  619,  153,  156,
			  159,  686,  162,  480,  399,  474,  670,  239,  377,  636,
			  136,  812,  824,  822,  353,  346,  363,  552,  328,  618,
			  437,  639,  821,  586,  174,  386,  176,  900,  186,  888,
			  393,  164, 1035,  884,  184,  655, 1034, 1036, -165,  163,
			  222,  352,  883,  356,  232,  286,  238,  235,  915,  241,
			  638, -222,  342,  291,  294, 1224,  556, -222,  299,  301,
			  571,  233,  310,  312,  314,  403,   -5,  350,  355,  902,
			  824,  822, 1008,  313,  315,  975,  688,  570,  995,  685,

			  821,  535,  949,  974,  749,  916,  917, 1223,  919,  942,
			  428,  429, 1220,  329, -165,  954, -222,  290,  293,  357,
			  349,  304,  298,  300,  286,  896,  309,  303, 1221, -222,
			 1127,  341, -165,  658,  217,  569,  948,  319, -165,   63,
			  994,  728,  148,  941, 1027,  147,  164,  534, 1212, -165,
			  358,  732,  988,  332,  163,  625,  343, 1029,  900,  364,
			  888,  162,  569,  329,  884, -165, -222,   53,   88,  232,
			  276,  998,  378,  883,  391,  391,  -72,  468, 1016,  291,
			  294, -222,  771, -222,  380, 1151,  372,  527,  528,  233,
			 1152,  775, 1048,  667,  133,  132, 1102,  388,  776, 1072, yyDummy>>,
			1, 200, 0)
		end

	yytable_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 -336, 1191, 1194, -150, 1200,  752,  170,  171, -222,  175,
			  391,  -72,   12,   11,  531,  470,  -72, -336,  535,  -72,
			 1026, 1052, 1058,  290,  293, -154,    2, 1055,    1,  242,
			  243,   67,  245,  805,  802,  391,  391,  739, -150, 1127,
			 1059, 1135,  441, -150,  552,  443,  402,  -58,  446,  449,
			  451,  275,  824,  822,  557,  404,  405,  902, 1134,  455,
			  458,  460,  821, 1129,  534, -154,  133,  801,  837,  124,
			  123,  122,  219,  218, 1219,  -58,  804,  119,  951,  526,
			 1081,  431, 1082,  432, 1174,  849,  440,    6,    5,  442,
			    4,    3,  445,  448,  450,  717,  675, 1218, 1173,  -58,

			 1111,  -58, 1092,  454,  457,  459,  952,  674,  286,  706,
			  -56,  303, -343, -133,  716,   12,   11, 1110,  463, 1091,
			  465,  466,  347,  705,  478, -222,  347,  172,  953, -343,
			  715,  278,  287, 1187, 1192, 1195,  156, 1201,  -56,  505,
			  302,  124,  123,  122,  219,  218,  195, -222, -133,  119,
			  353,  346, 1043, -133,  353,  346, -133,  606,  981,  194,
			 -222, -222,  -56,  159,  -56,  325,  484, 1211,  980, 1042,
			 -556, -222, 1129,  495,  496,  324,  498,  352, -556,  356,
			  667,  352,  504,  356,  507,  327,  663,  322,  342, 1136,
			    6,    5,  342,    4,    3,  673,  908,  537,  673,  672, yyDummy>>,
			1, 200, 200)
		end

	yytable_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  539,  508,  364,  350,  355,  347,  542,  350,  355,  544,
			 -169,  482,  520,  406,  407,  408,  409,  410,  411,  412,
			  413,  414,  415,  416,  417,  418,  419,  420,  422,  423,
			  425,  426,  427,  353,  346,  357,  349,  283,  630,  357,
			  349,  536,  806,  280,  538,  361,  560,  341,  562, 1203,
			  541,  341,  540,  543,  741, 1202,   12,   11, 1184,  593,
			  352,  436,  356,  434,  803, 1181,  358,  518,  172, 1176,
			  358,  342,  553,  153,  239,  391,  553,  164,  990, 1166,
			  546, 1161,  391,  192,  191,  163,  350,  355,  329,  559,
			 1162, -136,  162,  779, -136, 1160,  190,  189,  164,  578,

			  580,  590,  255,   75,  585, 1159,  163, -136,  532,  250,
			  249, 1179, 1180,  238,  247,  246, 1024, 1144,  357,  349,
			 1158,  626,  436,  435,  483,  250,  870,  720,  631,  347,
			  341,    6,    5,  497,    4,    3,  434,  433,  744,  745,
			  286,  247, -136, 1077,  133,  132,  514, -136,  970,  358,
			 -136,  621,  248,  251, 1149,  553, 1146,  353,  346, 1148,
			 1143,  364, 1142, 1141,  484, 1044,  753,  754,  755, 1122,
			 1150, 1121,  677,  635,  579,  767,  629,  767,   19,  529,
			 1109, 1108,  530,  648,  352, 1206,  356,  634,  596, 1210,
			 1106,  438,  500, 1098,  681,  342,  533,  682,  905, 1085, yyDummy>>,
			1, 200, 400)
		end

	yytable_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 1096,  127, 1071,  769,  766,  769,  766, 1051,  859,  852,
			  350,  355,  329,  456, 1054,  519,  287, 1050,  471,  124,
			  123,  122,  219,  218,  861, 1020, 1028,  119, 1018, 1013,
			  768,  940,  768, 1017, 1014,   12,   11,  648, 1011,  848,
			  689,  727,  357,  349, 1010,  720,  730,  828,  364,  829,
			  999,  871,  575,  947,  341,  687,  646,  958,  492,  978,
			  976,  946,  584,  391,  391,  588,   57,  708, 1097,   55,
			  133, 1099,  963,  358,  858,  770,  945,  770,  750,  553,
			  961,  956,  177,  724,  809,  -15,  862,  860,  546,  928,
			  713,  590,  611,  612, -158,  907,  316,  469,   12,   11,

			  764,  778,  764,  -15,  844, -398,  854,  829, -320,  -15,
			    6,    5,  736,    4,    3,  -70,  846,  -15, -398,  -15,
			  -15,  632,  483,  302,  797,  -15,  622,  500, -398,   12,
			   11,  840,  773, -398,  641,  509,  -15,  772,  -70,  726,
			  725,    1,  814,  -70,  780,  124,  123,  122,  219,  218,
			  759,  990,  827,  119,  800,  659,  792, -398,  791, -398,
			  662,  798, -222,  555,  569,  862,  757,  -70,  746,  -70,
			  561,  312,  314,    6,    5,  156,    4,    3,  382,  861,
			 -222,  860,  159, 1056,  859, 1057, -222,  858,  742,  737,
			  581,  643,  816,  683, -222,  710,  857, -222,  709,  796, yyDummy>>,
			1, 200, 600)
		end

	yytable_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  691,  692,  329,  706,    6,    5,  835,    4,    3,  603,
			  839,  841,  705, -222,  700,  -72,  315,  829,  514,  -72,
			  698,  469,  850,  225,  695,  707, -566,  920,  -72,  -72,
			  666, 1124, 1123,  899,  223,  665,  664,  156,  -72,  890,
			  656,  -72,  661,  -72,   12,   11,   70,  517,   68,  286,
			  652,  133,  132,  195,  913,  588,  172,  649, 1066,  379,
			  913,  913,  918,  913,  921,  943,  642,  -72,  628,  -72,
			  220,  932,  468,  640,  964,  624,  -64,  -64,  222,  968,
			  620,  613, 1164, 1163,  605,  604,  660,  598,  970,  563,
			   12,   11,  777,  283,   68,   52,  602,  282,  164,  128,

			  274,  671,  172,  164,  789, -162,  163,  -64,  127,  566,
			  -64,  163,  679,  238,  545,  549,  966,  548,  238,    6,
			    5,  524,    4,    3,  525,  506,  124,  123,  122,  219,
			  218,  512,  693,  993,  119,  785,  984,  986,  347,  992,
			  697,   52,  499,  992,  899,  494,  482, 1000, -396, 1002,
			  890,  -64,  -64,  784,  -64,  -64,  476,  322,  475,  783,
			  712, -396,  714,  472,  452,    6,    5,  346,    4,    3,
			  782, -396, 1021,  461,  430,  913, -396,  395,  396, -171,
			 1030, 1032,  274,  274,  394, -124,  781,  274,  311,  387,
			 1070, 1074,  384,  992,  133,  132,  468, -416,  381,  992, yyDummy>>,
			1, 200, 800)
		end

	yytable_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 -396,  172, -396,  164, 1125,  376, -124,  373,  221,  347,
			  347,  163,  347,  220,  370,  164,  368,  321,  162,  350,
			 -124,  320,  278,  163,  964, -124,  968,  277, -124,  244,
			  238,  935,  936,  254,  252,  913,  253,  913,  346,  346,
			  240,  346,  128,  234,  217,  794, 1088,  347,  164, 1094,
			  164,  127,  349,  216,  274,  274,  163,  274,  163,   12,
			   11,   -7,  825,  238,  680,  238, 1214, 1062,  574,  124,
			  123,  122,  219,  218, 1185, 1189,  346,  119, 1198,  817,
			 1115,  990, 1130,  647, 1119,  711,  855,  274, 1126,  633,
			  350,  350,  -14,  350,  938, 1105,   12,   11, 1060,  996,

			  997,  911, 1005,  834, 1001,  738, 1003, 1004, 1074,  335,
			 1006, 1215,  362, 1125,  551,  -14,  311,   22,  856, 1177,
			  -14,  826,  371,  349,  349,  161,  349,   57,  350,  866,
			   55,  865,  164,  977,    6,    5,  730,    4,    3, 1061,
			  163,  864, 1039, 1156,  -14, 1104,  -14,  238,  568, -189,
			  463,  463, 1188, 1130, 1196, 1155, 1130,  929, 1186, 1190,
			 1193,  349, 1199, 1213, 1205,  704, -189, -189, -189, 1069,
			 1083,    6,    5,  735,    4,    3, 1178, -189,  723, 1049,
			 -189,  950,  -65,  -65,   22, 1124, 1123, 1132, -189,  813,
			  305, 1130,  944, -189, -189, -189,  959, 1126,   12,   11, yyDummy>>,
			1, 200, 1000)
		end

	yytable_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   70,  490,  558, 1113,   21,  601, 1095,  133,  132,  274,
			  172,  467,  479,  -65,  774,  842,  -65,  939,  274,  274,
			  274,  274,  274,  274,  274,  274,  274,  274,  274,  274,
			  274,  274,  274,  -23,  274,  274,  843,  274,  274,  274,
			  678,  600,  731,    0, 1009,    0,    0,    0,    0,   52,
			    0,  906, 1164, 1163, 1140,    0,    0,  -65,  -65, 1022,
			  -65,  -65,    0,  283,  127,    0,    0,  282,    0,  280,
			 1037,    0,    0,    6,    5,    0,    4,    3, 1039,    0,
			  937,    0,  124,  123,  122,  219,  218,  473,    0,  -23,
			  119,  -23,  -23,  -23, 1168,  274,    0,    0,  477,  133,

			  132,    0, 1063,  -23, -187, 1065,    0,  -23,    0,  274,
			    0,  -23,    0,  -23,    0,    0,    0,  481,    0,    0,
			    0,  -23, -187,  -23,  -23,    0,  274,    0, -187,  -23,
			    0, 1208, 1209, 1089,  182,   12,   11,    0,    0, -187,
			  -23,  274,  274,  989,    0,  274,    0,  172, -224,    0,
			    0,    0,  522,  523,  181, -187,  127,  180, 1007,    0,
			  179,    0,    0,    0,    0,    0,   57, 1117,  453,   55,
			    0,    0,    0, 1120,  124,  123,  122,  219,  218,    0,
			    0,    0,  119,    0,    0,    0,    0,  274,    0,    0,
			    0,    0, 1047,    0, 1145,    0,  274, 1147,    0, 1053, yyDummy>>,
			1, 200, 1200)
		end

	yytable_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  274,    0,    0,    0, -224,    0, -224,    0,    0,  -25,
			    6,    5,    0,    4,    3, -224,  259,  258,  257,  256,
			  255,   75, -224,  274,  274, 1169,    0,    0, -224,    0,
			    0,    0,    0,    0,  133,  132, -224, -224,    0, -224,
			  565, 1182,    0,    0,  274, -224,    0, 1087, -224, 1197,
			 -224, -224,    0,  274,  329, -224,    0,  582, -224,    0,
			 -224, -224,  -17,    0, 1103,  -25,    0,  -25,  -25,  -25,
			  599,  274,    0,    0,  274,    0,    0,    0,    0,  -25,
			  607,  608,  609,  -25,    0,  610,    0,  -25,    0,  -25,
			    0,  311,    0,    0,    0,    0, 1133,  -25,    0,  -25,

			  -25,  614,    0,  274,  274,  -25,  -19,    0,    0,  124,
			  123,  122,  219,  218,    0,    0,  -25,  119,  -17,  274,
			  -17,  -17,  -17,    0,    0,    0, 1157,    0,    0,    0,
			    0,    0,  -17,    0,    0,    0,  -17,  650,  651, 1167,
			  -17,    0,  -17,    0, 1171,  654,    0,    0, 1175,    0,
			  -17,    0,  -17,  -17,    0,    0,    0,    0,  -17,    0,
			    0,    0,  -19,    0,  -19,  -19,  -19,    0,    0,  -17,
			    0,    0,    0,    0,    0,    0,  -19, 1207,    0,    0,
			  -19,    0,    0,    0,  -19,    0,  -19,    0,    0,  274,
			  133,  132,    0,    0,  -19,    0,  -19,  -19,    0,  694, yyDummy>>,
			1, 200, 1400)
		end

	yytable_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,  274,  -19,    0,    0,  696,    0, 1216,    0, 1217,
			    0,    0,    0,  -19,    0,    0,   77,   76,  133,  132,
			    0,    0,    0,   75,   74,   73,   72,    0,   71,   12,
			   11,   70,   69,   68,   67,    0,    0,   66,   65,    0,
			    0,   64,    0,   63,    0,    0,    0,  127,  587,   62,
			   61,   60,    0,    0,   59,    0,   58,    0,    0,  447,
			   57,    0,   56,   55,   54,  124,  123,  122,  219,  218,
			    0,   53,    0,  119,    0,  127,    0,    0,    0,    0,
			   52,    0,   51,    0,    0,    0,    0,  444,    0,  133,
			  132,   50,    0,  124,  123,  122,  219,  218,    0,    0,

			    0,  119,    0,    0,   49,    5,    0,   48,    3,    0,
			    0,    0,  795,   47,   46,   45,   44,   43,   42,   41,
			   40,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,  261,  260,
			  259,  258,  257,  256,  255,   75,  127,  274,  274,    0,
			    0,    0,    0,    0,    0,    0,    0,  836,  308,    0,
			  838,    0,    0,    0,  124,  123,  122,  307,  306,    0,
			    0,    0,  119,    0,    0,    0,    0,  338,  337,    0,
			    0,    0,    0,    0,    0,    0,    0,  868,    0,    0,
			   12,   11,   70,   69,   68,    0,    0,    0,    0,    0, yyDummy>>,
			1, 200, 1600)
		end

	yytable_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,  172,    0,    0,  336,    0,    0,  274,  274,
			   62,   61,    0,  274,    0,  274,  274,    0,  274,    0,
			    0,    0,    0,    0,  933,    0,  273,  272,  271,  270,
			  269,  268,  267,  266,  265,  264,  263,  262,  261,  260,
			  259,  258,  257,  256,  255,   75,    0,    0,    0,    0,
			    0,  274,  133,  132,    0,  955,    0,  957,    0,    0,
			    0,    0,    0,  960,    0,    6,    5,    0,    4,    3,
			    0,    0,    0,    0,   47,   46,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,    0,

			    0,    0,    0,    0,    0,    0,    0,  274,    0,  127,
			    0,    0,    0,    0,    0,    0,    0,    0,    0, 1015,
			    0,  297,    0, 1019,  667,    0, 1023,  124,  123,  122,
			  296,  295,    0,    0,    0,  119,    0, 1038,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   12,   11,
			   77,   76,  274,    0,    0,    0,    0,   75,   74,   73,
			   72,    0,   71,   12,   11,   70,   69,   68,   67,    0,
			 1064,   66,   65,    0,    0,   64,    0,   63,  329,    0,
			  274,    0,    0,   62,   61,   60,    0,   10,   59,    0,
			   58,    0,    0,    0,   57, 1086,   56,   55,   54,    9, yyDummy>>,
			1, 200, 1800)
		end

	yytable_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 1090,    0,    0,    0,    8,   53,    7,    0,    0,    0,
			 1100, 1101,    0,    0,   52,    0,   51,    0,    0,    0,
			  274,  274, 1107,    6,    5,   50,    4,    3,    2, 1112,
			    1,    0,    0,    0, 1118,    0,    0,    0,   49,    5,
			    0,   48,    3,    0,    0,    0,    0,   47,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,  133,  132,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0, 1165,    0,    0,   77,   76,
			    0,    0, 1170,    0,    0,   75,   74,   73,   72,    0,

			   71,   12,   11,   70,   69,   68,   67,    0, 1183,   66,
			   65,    0,    0,   64,    0,   63,    0,    0,    0,    0,
			    0,   62,   61,   60,    0,    0,   59,    0,   58,  127,
			    0,    0,   57,    0,   56,   55,   54,    0,    0,    0,
			    0,  292,    0,   53,    0,    0,  424,  124,  123,  122,
			  219,  218,   52,    0,   51,  119,    0,    0,    0,    0,
			    0,    0,    0,   50,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   49,    5,    0,   48,
			    3,    0,    0,    0,    0,   47,   46,   45,   44,   43,
			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33, yyDummy>>,
			1, 200, 2000)
		end

	yytable_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   77,   76,  133,  132,    0,    0,    0,   75,   74,   73,
			   72,    0,   71,   12,   11,   70,   69,   68,   67,    0,
			    0,   66,   65,    0,    0,   64,    0,   63,    0,    0,
			    0,    0,    0,   62,   61,   60,    0,    0,   59,    0,
			   58,    0,    0,    0,   57,    0,   56,   55,   54,    0,
			    0,    0,    0,    0,    0,   53,    0,    0,    0,  127,
			    0,    0,    0,    0,   52,    0,   51,    0,    0,    0,
			    0,  289,    0,    0,    0,   50,    0,  124,  123,  122,
			  219,  218,    0,  421,    0,  119,    0,    0,   49,    5,

			    0,   48,    3,    0,    0,    0,    0,   47,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   77,   76,    0,    0,    0,    0,    0,   75,
			   74,   73,   72,    0,   71,   12,   11,   70,   69,   68,
			   67,    0,    0,   66,   65,    0,    0,   64,    0,   63,
			    0,    0,    0,    0,    0,   62,   61,   60,    0,    0,
			   59,    0,   58,    0,    0,    0,   57,    0,   56,   55,
			   54,   12,   11,    0,    0,    0,    0,   53,    0,    0,
			    0,    0,    0,    0,    0,    0,   52,    0,   51,    0, yyDummy>>,
			1, 200, 2200)
		end

	yytable_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,    0,  237,    0,    0,  236,   50,    0,    0,
			    0,    0,   57,    0,    0,   55,    0,    0,    0,    0,
			   49,    5,    0,   48,    3,    0,    0,    0,    0,   47,
			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   77,   76,    6,    5,    0,    4,
			    3,   75,   74,   73,   72,    0,   71,   12,   11,   70,
			   69,   68,   67,    0,    0,  513,   65,    0,    0,   64,
			    0,   63, -114,    0,    0,    0, -114,   62,   61,   60,
			    0,    0,   59,    0,   58, -114, -114,    0,   57,    0,

			   56,   55,   54,    0,    0, -114,    0,    0, -114,   53,
			 -114,    0,    0,    0,    0,    0,    0,    0,   52,    0,
			   51,    0,    0,    0,    0,    0,    0,    0,    0,   50,
			    0,    0,    0,    0, -114,    0, -114,    0,    0,    0,
			    0,    0,   49,    5,    0,   48,    3,    0,    0,    0,
			    0,   47,   46,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   77,   76,    0,    0,
			    0,    0,    0,   75,   74,   73,   72,    0,   71,   12,
			   11,  250,  249,   68,   67,    0,    0,   66,   65,    0, yyDummy>>,
			1, 200, 2400)
		end

	yytable_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,  172,    0,   63,    0,    0,    0,    0, -191,   62,
			   61,   60,    0,    0,   59,    0,   58,    0,    0,    0,
			   57,    0,   56,   55,   54, -191, -191, -191,    0,    0,
			    0,   53,    0,    0,    0,    0, -191,    0,    0, -191,
			   52,    0,   51,    0,    0,    0,    0, -191,    0,    0,
			    0,   50, -191, -191, -191,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   49,    5,    0,    4,    3,    0,
			    0,    0,    0,   47,   46,   45,   44,   43,   42,   41,
			   40,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   77,   76,

			    0,    0,    0,    0,    0,   75,   74,   73,   72,    0,
			   71,   12,   11,  247,  246,   68,   67,    0,    0,   66,
			   65,    0,    0,  172,    0,   63,    0,    0,    0,    0,
			    0,   62,   61,   60,    0,    0,   59,    0,   58,    0,
			    0,    0,   57,    0,   56,   55,   54,    0,    0,    0,
			    0,    0,    0,   53,    0,    0,    0,    0,    0,    0,
			    0,    0,   52,    0,   51,    0,    0,    0,    0,    0,
			    0,    0,    0,   50,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   49,    5,    0,    4,
			    3,    0,    0,    0,    0,   47,   46,   45,   44,   43, yyDummy>>,
			1, 200, 2600)
		end

	yytable_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   77,   76,    0,    0,    0,    0,    0,   75,   74,   73,
			   72,    0,   71,   12,   11,   70,   69,   68,   67,    0,
			    0,   66,   65,    0,    0,  169,    0,   63,    0,    0,
			    0,    0,    0,   62,   61,   60,    0,    0,   59,    0,
			   58,    0,    0,    0,   57,    0,   56,   55,   54,    0,
			  597,   12,   11,    0,    0,   53,    0,    0,    0,    0,
			    0,    0,    0,    0,   52,    0,   51,    0,    0,    0,
			    0,    0,    0,  237,    0,   50,  236,    0,    0,    0,

			    0,    0,   57,    0,    0,   55,    0,    0,   49,    5,
			    0,   48,    3,    0,    0,    0,    0,   47,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,  338,  337,    0,    0,    6,    5,    0,    4,
			    3,    0,    0,    0,   71,   12,   11,    0,    0,   68,
			   67,  -17,    0,  772,    0,    0,    0,  172,    0,  881,
			    0,    0,    0,    0,    0,   62,   61,  880,  879,  -17,
			   59,    0,    0,    0,    0,  -17,   57,    0,   56,   55,
			    0,    0,    0,  -17,  878,  -17,  -17,  877,  876,    0, yyDummy>>,
			1, 200, 2800)
		end

	yytable_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,  -17,    0,    0,    0,    0,   52,  875,  874,    0,
			  873,    0,  -17,    0,    0,    0,    0,   50,    0,    0,
			    0,    0,    0,    0,  872,    0,    0,    0,    0,    0,
			   49,    5,    0,    4,    3,    0,    0,    0,    0,   47,
			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,  338,  337,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   12,   11,   70,
			   69,   68,    0,    0,    0,    0,    0,    0,    0,  172,
			    0,    0,    0,  338,  337,    0,    0,   62,   61,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,   70,   69,
			  762,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   62,   61,    0,    0,
			  761,  273,  272,  271,  270,  269,  268,  267,  266,  265,
			  264,  263,  262,  261,  260,  259,  258,  257,  256,  255,
			   75,    0,    6,    5,    0,    4,    3,    0,    0,    0,
			    0,   47,   46,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,    2,    0,    1,    0,
			   47,   46,   45,   44,   43,   42,   41,   40,   39,   38, yyDummy>>,
			1, 200, 3000)
		end

	yytable_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,  338,  337,    0,    0,    0,
			    0,    0,    0,    0,    0,    0, 1204,    0,    0,    0,
			   70,   69,  762,    0,    0,    0,    0,    0,    0,    0,
			  285,  284,    0,    0,    0,    0,    0,    0,   62,   61,
			    0,  283,  761,    0,    0,  282,  281,  280,    0,    0,
			    0,    0,  279,    0,    0,  285,  284,    0,    0,    0,
			    0,    0,  653,    0,    0,    0,  283,    0,    0,    0,
			  282,  281,  280,    0,    0,    0,    0,  279,    0,    0,
			  285,  284,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,  283,    0,    0,    0,  282,  281,  280,    0,    0,
			    0,    0,   47,   46,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   47,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   47,   46,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   47,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35, yyDummy>>,
			1, 200, 3200)
		end

	yytable_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,  285,  284,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  282,  281,  280,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  273,  272,  271,  270,  269,  268,  267,  266,  265,  264,
			  263,  262,  261,  260,  259,  258,  257,  256,  255,   75,
			  273,  272,  271,  270,  269,  268,  267,  266,  265,  264,
			  263,  262,  261,  260,  259,  258,  257,  256,  255,   75,
			    0,  273,  272,  271,  270,  269,  268,  267,  266,  265,
			  264,  263,  262,  261,  260,  259,  258,  257,  256,  255,

			   75,    0,    0,    0,    0,    0,    0,    0,    0,   47,
			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23, -553,  987,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0, -553,    0,    0,    0,
			    0,    0,    0,    0,    0,  734,    0,    0,    0,    0,
			    0,    0,    0,    0,  133,  132,    0,    0,    0, -553,
			 -553,    0,    0,    0,    0, -553,  375, -553, -553, -553,
			    0, -553,    0,    0,    0,    0,    0,    0,    0,    0,
			 -553,    0, -553, -553,    0, -553,    0,    0, -553,    0, yyDummy>>,
			1, 200, 3400)
		end

	yytable_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0, -553,    0, -553,    0,
			    0,    0,    0,    0, -553, -553,    0,    0,    0, -554,
			 -553,  127, -553,    0, -553, -553,    0,    0,    0, -553,
			 -553, -554,    0,  292,    0,    0,    0,    0,    0,  124,
			  123,  122,  219,  218, -553, -553, -553,  119,    0,  133,
			  132,    0,    0,    0, -554, -554,    0,    0,    0,    0,
			 -554,    0, -554, -554, -554,    0, -554,    0,    0,    0,
			    0,    0,    0,    0,    0, -554,    0, -554, -554,    0,
			 -554,    0,    0, -554,    0,    0,    0,    0,    0,    0,
			    0, -554,    0, -554,    0,    0,    0,    0,    0, -554,

			 -554,    0,    0,    0, -549, -554,  127, -554,    0, -554,
			 -554,    0,    0,    0, -554, -554, -549,    0,  289,    0,
			    0,    0,    0,    0,  124,  123,  122,  219,  218, -554,
			 -554, -554,  119,    0, -549, -549,    0,    0,    0, -549,
			 -549,    0,    0,    0,    0, -549,    0, -549, -549, -549,
			    0, -549,    0,    0,    0,    0,    0,    0,    0,    0,
			 -549,    0, -549, -549,    0, -549,    0,    0, -549,    0,
			    0,    0,    0,    0,    0,    0, -549,    0, -549,    0,
			    0,    0,    0,    0, -549, -549,    0,    0,    0, -550,
			 -549,    0, -549,    0, -549, -549,    0,    0,    0, -549, yyDummy>>,
			1, 200, 3600)
		end

	yytable_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 -549, -550,    0,    0,    0,    0,    0,    0,    0, -549,
			 -549, -549, -549, -549, -549, -549, -549,    0,    0, -550,
			 -550,    0,    0,    0, -550, -550,    0,    0,    0,    0,
			 -550,    0, -550, -550, -550,    0, -550,    0,    0,    0,
			    0,    0,    0,    0,    0, -550,    0, -550, -550,    0,
			 -550,    0,    0, -550,    0,    0,    0,    0,    0,    0,
			    0, -550,    0, -550,    0,    0,    0,    0,    0, -550,
			 -550,    0,    0,    0, -551, -550,    0, -550,    0, -550,
			 -550,    0,    0,    0, -550, -550, -551,    0,    0,    0,
			    0,    0,    0,    0, -550, -550, -550, -550, -550, -550,

			 -550, -550,    0,    0, -551, -551,    0,    0,    0, -551,
			 -551,    0,    0,    0,    0, -551,    0, -551, -551, -551,
			    0, -551,    0,    0,    0,    0,    0,    0,    0,    0,
			 -551,    0, -551, -551,    0, -551,    0,    0, -551,    0,
			    0,    0,    0,    0,    0,    0, -551,    0, -551,    0,
			    0,    0,    0,    0, -551, -551,    0,    0,    0, -295,
			 -551,    0, -551,    0, -551, -551,    0,    0,    0, -551,
			 -551, -295,    0,    0,    0,    0,    0,    0,    0, -551,
			 -551, -551, -551, -551, -551, -551, -551,    0,    0, -295,
			 -295,    0,    0,    0,    0, -295,    0,    0,    0,    0, yyDummy>>,
			1, 200, 3800)
		end

	yytable_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 -295,    0, -295, -295, -295,  172, -295,    0,    0,    0,
			    0,    0,    0,    0,    0, -295,    0, -295, -295,    0,
			 -295,    0,    0, -295,    0,    0,    0,    0,    0,    0,
			    0, -295,    0, -295,    0,    0,    0,    0,    0, -295,
			 -295,    0,    0,    0,    0, -295,    0, -295,    0, -295,
			 -295,    0,    0,    0, -295, -295,    0,    0,    0,    0,
			    0,    0,    0,    0, -295, -295, -295, -295, -295, -295,
			 -295, -295,    0,    0,    0,    0,    0,   47,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,

			   24,   23,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  262,  261,  260,  259,  258,  257,  256,
			  255,   75,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  262,  261,  260,  259,  258,  257,  256,
			  255,   75,  616,  132,    0,    0,    0,    0,  615,    0,
			    0,    0,    0,  751,  132,    0,  131,    0,    0,    0,
			    0,  130,    0,    0,    0,    0,    0,  131,    0,    0,
			    0,  129,  130,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  129,  133,  132,    0, 1172,    0,    0,    0,
			  128,    0,    0,    0,    0,  820,    0,  819,    0,  127, yyDummy>>,
			1, 200, 4000)
		end

	yytable_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,  128,  818,    0,    0,    0, 1139,    0,    0,    0,
			  127,  126,  129,    0,    0,  125,    0,  124,  123,  122,
			  121,  120,  126,    0,    0,  119,  125,    0,  124,  123,
			  122,  121,  120,    0,  616,  132,  119,    0,    0,    0,
			  127,    0,    0,    0,    0,    0,    0,    0,  131,    0,
			    0,    0,  126,  130,    0,    0,  125,    0,  124,  123,
			  122,  121,  120,  129,    0,    0,  119,  133,  132,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  131,  128,    0,    0,    0,  130,    0,    0,    0,
			    0,  127,    0,    0,    0,    0,  129,    0,    0,    0,

			  231,  230,    0,  126,    0,    0,    0,  125,    0,  124,
			  123,  122,  121,  120,  131,  128,    0,  119,    0,  130,
			    0,    0,    0,    0,  127,    0,    0,    0,    0,  129,
			    0,    0,    0,  133,  132,    0,  126,    0,    0,    0,
			  125,    0,  124,  123,  122,  121,  120,  819,  128,    0,
			  119,    0,  818,    0,    0,    0,    0,  127,    0,    0,
			    0,    0,  129,    0,    0,    0,    0,    0,    0,  126,
			    0,    0,    0,  125,    0,  229,  228,  122,  227,  226,
			    0,    0,    0,  119,    0,    0,    0,    0,    0,    0,
			  127,    0,    0,    0,    0,    0,    0,    0,    0,    0, yyDummy>>,
			1, 200, 4200)
		end

	yytable_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,  126,    0,    0,    0,  125,    0,  124,  123,
			  122,  121,  120,    0,    0,    0,  119,  273,  272,  271,
			  270,  269,  268,  267,  266,  265,  264,  263,  262,  261,
			  260,  259,  258,  257,  256,  255,   75,  273,  272,  271,
			  270,  269,  268,  267,  266,  265,  264,  263,  262,  261,
			  260,  259,  258,  257,  256,  255,   75,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			 -341,  269,  268,  267,  266,  265,  264,  263,  262,  261,
			  260,  259,  258,  257,  256,  255,   75, -341,  272,  271,
			  270,  269,  268,  267,  266,  265,  264,  263,  262,  261,

			  260,  259,  258,  257,  256,  255,   75,  576,  273,  272,
			  271,  270,  269,  268,  267,  266,  265,  264,  263,  262,
			  261,  260,  259,  258,  257,  256,  255,   75,  273,  272,
			  271,  270,  269,  268,  267,  266,  265,  264,  263,  262,
			  261,  260,  259,  258,  257,  256,  255,   75,  273,  272,
			  271,  270,  269,  268,  267,  266,  265,  264,  263,  262,
			  261,  260,  259,  258,  257,  256,  255,   75,    0,    0,
			    0, 1084,  214,  213,  212,  211,  210,  209,  208,  207,
			  206,  205,  204,  203,  202,  201,  200,  199,  198,    0,
			  197,  374,    0,    0,    0,    0,    0,    0,    0,    0, yyDummy>>,
			1, 200, 4400)
		end

	yytable_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,  733,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  262,  261,  260,  259,  258,  257,  256,
			  255,   75,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  262,  261,  260,  259,  258,  257,  256,
			  255,   75,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  690,    0,    0,    0,    0,
			    0,    0,    0,    0,  521,  273,  272,  271,  270,  269,
			  268,  267,  266,  265,  264,  263,  262,  261,  260,  259,
			  258,  257,  256,  255,   75,  273,  272,  271,  270,  269,
			  268,  267,  266,  265,  264,  263,  262,  261,  260,  259,

			  258,  257,  256,  255,   75,  329,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  703,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  262,  261,  260,  259,  258,  257,  256,
			  255,   75,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  400,   47,
			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   47,    0,   45,    0,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32, yyDummy>>,
			1, 200, 4600)
		end

	yytable_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   31,   30,   29,   28,   27,   26,   25,   24,   23,  214,
			  213,  212,  211,  210,  209,  208,  207,  206,  205,  204,
			  203,  202,  201,  200,  199,  198,  489,  197,  488,  487,
			  273,  272,  271,  270,  269,  268,  267,  266,  265,  264,
			  263,  262,  261,  260,  259,  258,  257,  256,  255,   75,
			  271,  270,  269,  268,  267,  266,  265,  264,  263,  262,
			  261,  260,  259,  258,  257,  256,  255,   75,  270,  269,
			  268,  267,  266,  265,  264,  263,  262,  261,  260,  259,
			  258,  257,  256,  255,   75, yyDummy>>,
			1, 85, 4800)
		end

	yycheck_template: SPECIAL [INTEGER]
			-- Template for `yycheck'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 4884)
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
			Result := yyfixed_array (an_array)
		end

	yycheck_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			    0,  161,  326,  130,  131,   63,  156,   22,    2,    7,
			  394,    9,   54,   50,  839,   22,   63,  548,   16,   17,
			   18,  637,   22,  361,  241,  334,  612,   66,  177,  572,
			   13,  783,  792,  792,  156,  156,  159,  472,  150,  548,
			  287,  574,  792,  505,   50,  194,   52,  839,   54,  839,
			  217,   66,  981,  839,   54,  592,  980,  981,    0,   66,
			   63,  156,  839,  156,   64,  115,   66,   65,  856,   67,
			   46,    0,  156,  120,  121,    0,  476,   58,  125,  126,
			   29,   64,  129,  130,  131,  252,    0,  156,  156,  841,
			  850,  850,  954,  220,  221,  925,  639,   46,   58,  636,

			  850,   67,    3,  923,   36,  858,  859,    0,  861,    3,
			  277,  278,   58,   45,   56,  900,   97,  120,  121,  156,
			  156,  127,  125,  126,  174,  950,  129,  127,   41,   58,
			 1088,  156,   74,  595,   28,  111,   37,  135,   80,   44,
			  100,  684,   56,   37,  974,   59,  161,  113,   43,   91,
			  156,  688,  937,  153,  161,  555,  156,  977,  950,  159,
			  950,  161,  111,   45,  950,  107,   58,   72,   10,  169,
			   94,  943,  178,  950,  216,  217,   58,  326,  966,  226,
			  227,  110,  725,  112,  182, 1114,  169,  404,  405,  172,
			 1114,  728,  102,  103,   30,   31, 1058,  195,  731, 1029, yyDummy>>,
			1, 200, 0)
		end

	yycheck_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   58, 1159, 1160,   58, 1162,  714,   48,   49,  100,   51,
			  252,   93,   30,   31,  431,  327,   98,   75,   67,  101,
			  973,  993, 1007,  226,  227,   58,  110,  999,  112,   71,
			   72,   35,   74,  776,  771,  277,  278,  699,   93, 1197,
			   89,   58,  289,   98,  679,  292,  244,   58,  295,  296,
			  297,   93, 1012, 1012,   58,  253,  254, 1009,   75,  306,
			  307,  308, 1012, 1088,  113,   98,   30,  765,  805,  105,
			  106,  107,  108,  109,   58,   86,  774,  113,  894,  402,
			 1033,  279, 1035,  283,    3,  816,  289,  105,  106,  292,
			  108,  109,  295,  296,  297,   59,   36,   58,    3,  110,

			   29,  112,   58,  306,  307,  308,    3,   47,  358,   28,
			   58,  311,   58,   58,   78,   30,   31,   46,  316,   75,
			  320,  321,  472,   28,  359,   67,  476,   42,   82,   75,
			   94,   28,   86, 1158, 1159, 1160,  334, 1162,   86,  381,
			   55,  105,  106,  107,  108,  109,   29,   89,   93,  113,
			  472,  472,   58,   98,  476,  476,  101,  524,   62,   42,
			  102,  103,  110,  361,  112,   60,  366,   43,   72,   75,
			   35,  113, 1197,  373,  374,   70,  376,  472,   43,  472,
			  103,  476,  380,  476,  382,   78,  603,   80,  472,   76,
			  105,  106,  476,  108,  109,   46,   47,  444,   46,   47, yyDummy>>,
			1, 200, 200)
		end

	yycheck_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  447,  384,  402,  472,  472,  555,  453,  476,  476,  456,
			   46,   47,  395,  255,  256,  257,  258,  259,  260,  261,
			  262,  263,  264,  265,  266,  267,  268,  269,  270,  271,
			  272,  273,  274,  555,  555,  472,  472,   28,  561,  476,
			  476,  444,  780,   34,  447,  157,  481,  472,  483,   58,
			  453,  476,  452,  456,  701,  100,   30,   31,   58,  509,
			  555,   32,  555,   32,  773,   58,  472,  391,   42,   58,
			  476,  555,  472,  471,  513,  517,  476,  492,   52,   58,
			  463,   47,  524,  122,  123,  492,  555,  555,   45,   46,
			    4,   42,  492,  740,   45,    4,  135,  136,  513,  497,

			  500,  507,   23,   24,  504,    4,  513,   58,  432,   32,
			   33, 1148, 1149,  513,   32,   33,   67, 1103,  555,  555,
			    4,  556,   32,   33,  366,   32,  835,  676,  563,  679,
			  555,  105,  106,  375,  108,  109,   32,   33,  705,  706,
			  590,   32,   93,   81,   30,   31,  388,   98,   42,  555,
			  101,  549,   76,   77,   42,  555,   43,  679,  679,   42,
			   89,  561,   36,   36,  564,  104,  715,  716,  717,   58,
			 1113,   74,  622,  571,  498,  725,  559,  727,   86,  421,
			   47,   58,  424,  581,  679, 1171,  679,  570,  512, 1175,
			   47,  102,   28,   58,  629,  679,  438,  632,  845,   47, yyDummy>>,
			1, 200, 400)
		end

	yycheck_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  102,   87,   58,  725,  725,  727,  727,  991,   98,   72,
			  679,  679,   45,   99,  998,  999,   86,   58,  330,  105,
			  106,  107,  108,  109,   93,   43,   58,  113,   68,   58,
			  725,  878,  727,   47,   47,   30,   31,  635,   43,   30,
			  640,   12,  679,  679,   41,  794,   45,  796,  648,  798,
			   44,   58,  494,   35,  679,  638,  580,  904,  370,   71,
			   58,    3,  504,  705,  706,  507,   61,  667, 1052,   64,
			   30, 1055,   58,  679,  101,  725,   35,  727,  713,  679,
			   47,   47,   13,  683,   29,   56,   79,   95,  671,   58,
			  673,  697,  534,  535,   58,   58,   35, 1021,   30,   31,

			  725,  736,  727,   74,  100,   58,   43,  856,   95,   80,
			  105,  106,  695,  108,  109,   58,   97,   88,   71,   90,
			   91,  563,  564,   55,  759,   96,   66,   28,   81,   30,
			   31,   41,  726,   86,  576,   90,  107,   58,   81,  110,
			  111,  112,   77,   86,  742,  105,  106,  107,  108,  109,
			   84,   52,   36,  113,  110,  597,   48,  110,   47,  112,
			  602,  759,   56,  475,  111,   79,   47,  110,   46,  112,
			  482,  818,  819,  105,  106,  773,  108,  109,   29,   93,
			   74,   95,  780, 1000,   98, 1002,   80,  101,   88,   41,
			  502,   76,  790,  106,   88,   58,  831,   91,   58,   42, yyDummy>>,
			1, 200, 600)
		end

	yycheck_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  642,  643,   45,   28,  105,  106,  800,  108,  109,  521,
			  808,  809,   28,  107,   75,   58,  943,  966,  660,   62,
			   41, 1145,  820,  881,   46,  667,   75,  862,   71,   72,
			   40,   17,   18,  839,  881,   36,   36,  835,   81,  839,
			   96,   84,   41,   86,   30,   31,   32,   28,   34,  899,
			   47,   30,   31,   29,  852,  697,   42,   41, 1018,   41,
			  858,  859,  860,  861,  862,   44,   75,  110,   58,  112,
			   49,  869, 1021,   68,  913,   47,   30,   31,  881,  918,
			   36,   47,   17,   18,   36,   40,  598,   47,   42,   46,
			   30,   31,  734,   28,   34,   81,   43,   32,  913,   78,

			   88,  613,   42,  918,  746,   41,  913,   61,   87,   71,
			   64,  918,  624,  913,   36,   35,  914,   35,  918,  105,
			  106,   28,  108,  109,   41,   41,  105,  106,  107,  108,
			  109,   43,  644,  939,  113,   56,  934,  935, 1088,  939,
			  652,   81,   14,  943,  950,   43,   47,  945,   58,  947,
			  950,  105,  106,   74,  108,  109,   46,   80,   47,   80,
			  672,   71,  674,   46,   28,  105,  106, 1088,  108,  109,
			   91,   81,  970,   36,   40,  973,   86,   46,   43,   41,
			  978,  979,  170,  171,   44,   58,  107,  175,   87,   41,
			 1025, 1030,   46,  993,   30,   31, 1145,   28,   28,  999, yyDummy>>,
			1, 200, 800)
		end

	yycheck_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  110,   42,  112, 1018, 1088,   28,   79,   68,   44, 1159,
			 1160, 1018, 1162,   49,   47, 1030,   66,   28, 1018, 1088,
			   93,   28,   28, 1030, 1063,   98, 1065,   28,  101,   29,
			 1030,  873,  874,   35,   28, 1033,   35, 1035, 1159, 1160,
			   36, 1162,   78,   40,   28,  757, 1044, 1197, 1063, 1047,
			 1065,   87, 1088,   28,  242,  243, 1063,  245, 1065,   30,
			   31,    0,  792, 1063,  628, 1065, 1183, 1012,  493,  105,
			  106,  107,  108,  109, 1158, 1159, 1197,  113, 1162,  791,
			 1078,   52, 1088,  581, 1084,  671,  829,  275, 1088,  564,
			 1159, 1160,   58, 1162,  876, 1065,   30,   31, 1009,  941,

			  942,  851,  950,  799,  946,  697,  948,  949, 1147,  155,
			  952, 1197,  158, 1197,  471,   81,   87, 1115,  830, 1145,
			   86,  794,  168, 1159, 1160,   59, 1162,   61, 1197,  832,
			   64,  832, 1147,  930,  105,  106,   45,  108,  109, 1011,
			 1147,  832,  984, 1120,  110, 1063,  112, 1147,  492,   58,
			 1148, 1149, 1158, 1159, 1160, 1117, 1162,  867, 1158, 1159,
			 1160, 1197, 1162, 1182, 1169,  660,   75,   76,   77, 1022,
			 1037,  105,  106,  693,  108,  109, 1147,   86,  679,  988,
			   89,  893,   30,   31, 1182,   17,   18, 1089,   97,  784,
			  128, 1197,  881,  102,  103,  104,  908, 1197,   30,   31, yyDummy>>,
			1, 200, 1000)
		end

	yycheck_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   32,  368,  479, 1076,    9,  517, 1048,   30,   31,  397,
			   42,  326,  360,   61,  727,  810,   64,  877,  406,  407,
			  408,  409,  410,  411,  412,  413,  414,  415,  416,  417,
			  418,  419,  420,    0,  422,  423,  811,  425,  426,  427,
			  623,  517,  687,   -1,  956,   -1,   -1,   -1,   -1,   81,
			   -1,  846,   17,   18, 1096,   -1,   -1,  105,  106,  971,
			  108,  109,   -1,   28,   87,   -1,   -1,   32,   -1,   34,
			  982,   -1,   -1,  105,  106,   -1,  108,  109, 1120,   -1,
			  875,   -1,  105,  106,  107,  108,  109,  333,   -1,   56,
			  113,   58,   59,   60, 1136,  483,   -1,   -1,  344,   30,

			   31,   -1, 1014,   70,   56, 1017,   -1,   74,   -1,  497,
			   -1,   78,   -1,   80,   -1,   -1,   -1,  363,   -1,   -1,
			   -1,   88,   74,   90,   91,   -1,  514,   -1,   80,   96,
			   -1, 1173, 1174, 1045,   29,   30,   31,   -1,   -1,   91,
			  107,  529,  530,  938,   -1,  533,   -1,   42,    0,   -1,
			   -1,   -1,  398,  399,   49,  107,   87,   52,  953,   -1,
			   55,   -1,   -1,   -1,   -1,   -1,   61, 1079,   99,   64,
			   -1,   -1,   -1, 1085,  105,  106,  107,  108,  109,   -1,
			   -1,   -1,  113,   -1,   -1,   -1,   -1,  575,   -1,   -1,
			   -1,   -1,  987,   -1, 1106,   -1,  584, 1109,   -1,  994, yyDummy>>,
			1, 200, 1200)
		end

	yycheck_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  588,   -1,   -1,   -1,   56,   -1,   58,   -1,   -1,    0,
			  105,  106,   -1,  108,  109,   67,   19,   20,   21,   22,
			   23,   24,   74,  611,  612, 1137,   -1,   -1,   80,   -1,
			   -1,   -1,   -1,   -1,   30,   31,   88,   89,   -1,   91,
			  486, 1153,   -1,   -1,  632,   97,   -1, 1042,  100, 1161,
			  102,  103,   -1,  641,   45,  107,   -1,  503,  110,   -1,
			  112,  113,    0,   -1, 1059,   56,   -1,   58,   59,   60,
			  516,  659,   -1,   -1,  662,   -1,   -1,   -1,   -1,   70,
			  526,  527,  528,   74,   -1,  531,   -1,   78,   -1,   80,
			   -1,   87,   -1,   -1,   -1,   -1, 1091,   88,   -1,   90,

			   91,  547,   -1,  691,  692,   96,    0,   -1,   -1,  105,
			  106,  107,  108,  109,   -1,   -1,  107,  113,   56,  707,
			   58,   59,   60,   -1,   -1,   -1, 1121,   -1,   -1,   -1,
			   -1,   -1,   70,   -1,   -1,   -1,   74,  583,  584, 1134,
			   78,   -1,   80,   -1, 1139,  591,   -1,   -1, 1143,   -1,
			   88,   -1,   90,   91,   -1,   -1,   -1,   -1,   96,   -1,
			   -1,   -1,   56,   -1,   58,   59,   60,   -1,   -1,  107,
			   -1,   -1,   -1,   -1,   -1,   -1,   70, 1172,   -1,   -1,
			   74,   -1,   -1,   -1,   78,   -1,   80,   -1,   -1,  777,
			   30,   31,   -1,   -1,   88,   -1,   90,   91,   -1,  645, yyDummy>>,
			1, 200, 1400)
		end

	yycheck_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,  789,   96,   -1,   -1,  651,   -1, 1202,   -1, 1204,
			   -1,   -1,   -1,  107,   -1,   -1,   17,   18,   30,   31,
			   -1,   -1,   -1,   24,   25,   26,   27,   -1,   29,   30,
			   31,   32,   33,   34,   35,   -1,   -1,   38,   39,   -1,
			   -1,   42,   -1,   44,   -1,   -1,   -1,   87,   49,   50,
			   51,   52,   -1,   -1,   55,   -1,   57,   -1,   -1,   99,
			   61,   -1,   63,   64,   65,  105,  106,  107,  108,  109,
			   -1,   72,   -1,  113,   -1,   87,   -1,   -1,   -1,   -1,
			   81,   -1,   83,   -1,   -1,   -1,   -1,   99,   -1,   30,
			   31,   92,   -1,  105,  106,  107,  108,  109,   -1,   -1,

			   -1,  113,   -1,   -1,  105,  106,   -1,  108,  109,   -1,
			   -1,   -1,  758,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,  138,   17,   18,
			   19,   20,   21,   22,   23,   24,   87,  935,  936,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  803,   99,   -1,
			  806,   -1,   -1,   -1,  105,  106,  107,  108,  109,   -1,
			   -1,   -1,  113,   -1,   -1,   -1,   -1,   17,   18,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  833,   -1,   -1,
			   30,   31,   32,   33,   34,   -1,   -1,   -1,   -1,   -1, yyDummy>>,
			1, 200, 1600)
		end

	yycheck_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   42,   -1,   -1,   45,   -1,   -1,  996,  997,
			   50,   51,   -1, 1001,   -1, 1003, 1004,   -1, 1006,   -1,
			   -1,   -1,   -1,   -1,  870,   -1,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   22,   23,   24,   -1,   -1,   -1,   -1,
			   -1, 1039,   30,   31,   -1,  901,   -1,  903,   -1,   -1,
			   -1,   -1,   -1,  909,   -1,  105,  106,   -1,  108,  109,
			   -1,   -1,   -1,   -1,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,  137,  138,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1, 1095,   -1,   87,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  965,
			   -1,   99,   -1,  969,  103,   -1,  972,  105,  106,  107,
			  108,  109,   -1,   -1,   -1,  113,   -1,  983,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   30,   31,
			   17,   18, 1140,   -1,   -1,   -1,   -1,   24,   25,   26,
			   27,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			 1016,   38,   39,   -1,   -1,   42,   -1,   44,   45,   -1,
			 1168,   -1,   -1,   50,   51,   52,   -1,   69,   55,   -1,
			   57,   -1,   -1,   -1,   61, 1041,   63,   64,   65,   81, yyDummy>>,
			1, 200, 1800)
		end

	yycheck_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			 1046,   -1,   -1,   -1,   86,   72,   88,   -1,   -1,   -1,
			 1056, 1057,   -1,   -1,   81,   -1,   83,   -1,   -1,   -1,
			 1208, 1209, 1068,  105,  106,   92,  108,  109,  110, 1075,
			  112,   -1,   -1,   -1, 1080,   -1,   -1,   -1,  105,  106,
			   -1,  108,  109,   -1,   -1,   -1,   -1,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  137,  138,   30,   31,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1, 1131,   -1,   -1,   17,   18,
			   -1,   -1, 1138,   -1,   -1,   24,   25,   26,   27,   -1,

			   29,   30,   31,   32,   33,   34,   35,   -1, 1154,   38,
			   39,   -1,   -1,   42,   -1,   44,   -1,   -1,   -1,   -1,
			   -1,   50,   51,   52,   -1,   -1,   55,   -1,   57,   87,
			   -1,   -1,   61,   -1,   63,   64,   65,   -1,   -1,   -1,
			   -1,   99,   -1,   72,   -1,   -1,   75,  105,  106,  107,
			  108,  109,   81,   -1,   83,  113,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   92,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  105,  106,   -1,  108,
			  109,   -1,   -1,   -1,   -1,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128, yyDummy>>,
			1, 200, 2000)
		end

	yycheck_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  138,
			   17,   18,   30,   31,   -1,   -1,   -1,   24,   25,   26,
			   27,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			   -1,   38,   39,   -1,   -1,   42,   -1,   44,   -1,   -1,
			   -1,   -1,   -1,   50,   51,   52,   -1,   -1,   55,   -1,
			   57,   -1,   -1,   -1,   61,   -1,   63,   64,   65,   -1,
			   -1,   -1,   -1,   -1,   -1,   72,   -1,   -1,   -1,   87,
			   -1,   -1,   -1,   -1,   81,   -1,   83,   -1,   -1,   -1,
			   -1,   99,   -1,   -1,   -1,   92,   -1,  105,  106,  107,
			  108,  109,   -1,  100,   -1,  113,   -1,   -1,  105,  106,

			   -1,  108,  109,   -1,   -1,   -1,   -1,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  137,  138,   17,   18,   -1,   -1,   -1,   -1,   -1,   24,
			   25,   26,   27,   -1,   29,   30,   31,   32,   33,   34,
			   35,   -1,   -1,   38,   39,   -1,   -1,   42,   -1,   44,
			   -1,   -1,   -1,   -1,   -1,   50,   51,   52,   -1,   -1,
			   55,   -1,   57,   -1,   -1,   -1,   61,   -1,   63,   64,
			   65,   30,   31,   -1,   -1,   -1,   -1,   72,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   81,   -1,   83,   -1, yyDummy>>,
			1, 200, 2200)
		end

	yycheck_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   -1,   52,   -1,   -1,   55,   92,   -1,   -1,
			   -1,   -1,   61,   -1,   -1,   64,   -1,   -1,   -1,   -1,
			  105,  106,   -1,  108,  109,   -1,   -1,   -1,   -1,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  138,   17,   18,  105,  106,   -1,  108,
			  109,   24,   25,   26,   27,   -1,   29,   30,   31,   32,
			   33,   34,   35,   -1,   -1,   38,   39,   -1,   -1,   42,
			   -1,   44,   58,   -1,   -1,   -1,   62,   50,   51,   52,
			   -1,   -1,   55,   -1,   57,   71,   72,   -1,   61,   -1,

			   63,   64,   65,   -1,   -1,   81,   -1,   -1,   84,   72,
			   86,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   81,   -1,
			   83,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   92,
			   -1,   -1,   -1,   -1,  110,   -1,  112,   -1,   -1,   -1,
			   -1,   -1,  105,  106,   -1,  108,  109,   -1,   -1,   -1,
			   -1,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,  138,   17,   18,   -1,   -1,
			   -1,   -1,   -1,   24,   25,   26,   27,   -1,   29,   30,
			   31,   32,   33,   34,   35,   -1,   -1,   38,   39,   -1, yyDummy>>,
			1, 200, 2400)
		end

	yycheck_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   42,   -1,   44,   -1,   -1,   -1,   -1,   58,   50,
			   51,   52,   -1,   -1,   55,   -1,   57,   -1,   -1,   -1,
			   61,   -1,   63,   64,   65,   75,   76,   77,   -1,   -1,
			   -1,   72,   -1,   -1,   -1,   -1,   86,   -1,   -1,   89,
			   81,   -1,   83,   -1,   -1,   -1,   -1,   97,   -1,   -1,
			   -1,   92,  102,  103,  104,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  105,  106,   -1,  108,  109,   -1,
			   -1,   -1,   -1,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,  138,   17,   18,

			   -1,   -1,   -1,   -1,   -1,   24,   25,   26,   27,   -1,
			   29,   30,   31,   32,   33,   34,   35,   -1,   -1,   38,
			   39,   -1,   -1,   42,   -1,   44,   -1,   -1,   -1,   -1,
			   -1,   50,   51,   52,   -1,   -1,   55,   -1,   57,   -1,
			   -1,   -1,   61,   -1,   63,   64,   65,   -1,   -1,   -1,
			   -1,   -1,   -1,   72,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   81,   -1,   83,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   92,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  105,  106,   -1,  108,
			  109,   -1,   -1,   -1,   -1,  114,  115,  116,  117,  118, yyDummy>>,
			1, 200, 2600)
		end

	yycheck_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  138,
			   17,   18,   -1,   -1,   -1,   -1,   -1,   24,   25,   26,
			   27,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			   -1,   38,   39,   -1,   -1,   42,   -1,   44,   -1,   -1,
			   -1,   -1,   -1,   50,   51,   52,   -1,   -1,   55,   -1,
			   57,   -1,   -1,   -1,   61,   -1,   63,   64,   65,   -1,
			   29,   30,   31,   -1,   -1,   72,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   81,   -1,   83,   -1,   -1,   -1,
			   -1,   -1,   -1,   52,   -1,   92,   55,   -1,   -1,   -1,

			   -1,   -1,   61,   -1,   -1,   64,   -1,   -1,  105,  106,
			   -1,  108,  109,   -1,   -1,   -1,   -1,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  137,  138,   17,   18,   -1,   -1,  105,  106,   -1,  108,
			  109,   -1,   -1,   -1,   29,   30,   31,   -1,   -1,   34,
			   35,   56,   -1,   58,   -1,   -1,   -1,   42,   -1,   44,
			   -1,   -1,   -1,   -1,   -1,   50,   51,   52,   53,   74,
			   55,   -1,   -1,   -1,   -1,   80,   61,   -1,   63,   64,
			   -1,   -1,   -1,   88,   69,   90,   91,   72,   73,   -1, yyDummy>>,
			1, 200, 2800)
		end

	yycheck_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   96,   -1,   -1,   -1,   -1,   81,   82,   83,   -1,
			   85,   -1,  107,   -1,   -1,   -1,   -1,   92,   -1,   -1,
			   -1,   -1,   -1,   -1,   99,   -1,   -1,   -1,   -1,   -1,
			  105,  106,   -1,  108,  109,   -1,   -1,   -1,   -1,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  138,   17,   18,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   30,   31,   32,
			   33,   34,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   42,
			   -1,   -1,   -1,   17,   18,   -1,   -1,   50,   51,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   32,   33,
			   34,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   50,   51,   -1,   -1,
			   54,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   22,   23,
			   24,   -1,  105,  106,   -1,  108,  109,   -1,   -1,   -1,
			   -1,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,  138,  110,   -1,  112,   -1,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123, yyDummy>>,
			1, 200, 3000)
		end

	yycheck_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  137,  138,   17,   18,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  100,   -1,   -1,   -1,
			   32,   33,   34,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   17,   18,   -1,   -1,   -1,   -1,   -1,   -1,   50,   51,
			   -1,   28,   54,   -1,   -1,   32,   33,   34,   -1,   -1,
			   -1,   -1,   39,   -1,   -1,   17,   18,   -1,   -1,   -1,
			   -1,   -1,   49,   -1,   -1,   -1,   28,   -1,   -1,   -1,
			   32,   33,   34,   -1,   -1,   -1,   -1,   39,   -1,   -1,
			   17,   18,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   28,   -1,   -1,   -1,   32,   33,   34,   -1,   -1,
			   -1,   -1,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,  137,  138,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  137,  138,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,  137,  138,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126, yyDummy>>,
			1, 200, 3200)
		end

	yycheck_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  137,  138,   17,   18,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   32,   33,   34,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   -1,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   22,   23,

			   24,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  138,    0,  100,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   12,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  100,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   30,   31,   -1,   -1,   -1,   35,
			   36,   -1,   -1,   -1,   -1,   41,  100,   43,   44,   45,
			   -1,   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   56,   -1,   58,   59,   -1,   61,   -1,   -1,   64,   -1, yyDummy>>,
			1, 200, 3400)
		end

	yycheck_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   -1,   -1,   -1,   -1,   72,   -1,   74,   -1,
			   -1,   -1,   -1,   -1,   80,   81,   -1,   -1,   -1,    0,
			   86,   87,   88,   -1,   90,   91,   -1,   -1,   -1,   95,
			   96,   12,   -1,   99,   -1,   -1,   -1,   -1,   -1,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,   -1,   30,
			   31,   -1,   -1,   -1,   35,   36,   -1,   -1,   -1,   -1,
			   41,   -1,   43,   44,   45,   -1,   47,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   56,   -1,   58,   59,   -1,
			   61,   -1,   -1,   64,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   72,   -1,   74,   -1,   -1,   -1,   -1,   -1,   80,

			   81,   -1,   -1,   -1,    0,   86,   87,   88,   -1,   90,
			   91,   -1,   -1,   -1,   95,   96,   12,   -1,   99,   -1,
			   -1,   -1,   -1,   -1,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,   -1,   30,   31,   -1,   -1,   -1,   35,
			   36,   -1,   -1,   -1,   -1,   41,   -1,   43,   44,   45,
			   -1,   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   56,   -1,   58,   59,   -1,   61,   -1,   -1,   64,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   72,   -1,   74,   -1,
			   -1,   -1,   -1,   -1,   80,   81,   -1,   -1,   -1,    0,
			   86,   -1,   88,   -1,   90,   91,   -1,   -1,   -1,   95, yyDummy>>,
			1, 200, 3600)
		end

	yycheck_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   96,   12,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  105,
			  106,  107,  108,  109,  110,  111,  112,   -1,   -1,   30,
			   31,   -1,   -1,   -1,   35,   36,   -1,   -1,   -1,   -1,
			   41,   -1,   43,   44,   45,   -1,   47,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   56,   -1,   58,   59,   -1,
			   61,   -1,   -1,   64,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   72,   -1,   74,   -1,   -1,   -1,   -1,   -1,   80,
			   81,   -1,   -1,   -1,    0,   86,   -1,   88,   -1,   90,
			   91,   -1,   -1,   -1,   95,   96,   12,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  105,  106,  107,  108,  109,  110,

			  111,  112,   -1,   -1,   30,   31,   -1,   -1,   -1,   35,
			   36,   -1,   -1,   -1,   -1,   41,   -1,   43,   44,   45,
			   -1,   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   56,   -1,   58,   59,   -1,   61,   -1,   -1,   64,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   72,   -1,   74,   -1,
			   -1,   -1,   -1,   -1,   80,   81,   -1,   -1,   -1,    0,
			   86,   -1,   88,   -1,   90,   91,   -1,   -1,   -1,   95,
			   96,   12,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  105,
			  106,  107,  108,  109,  110,  111,  112,   -1,   -1,   30,
			   31,   -1,   -1,   -1,   -1,   36,   -1,   -1,   -1,   -1, yyDummy>>,
			1, 200, 3800)
		end

	yycheck_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   41,   -1,   43,   44,   45,   42,   47,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   56,   -1,   58,   59,   -1,
			   61,   -1,   -1,   64,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   72,   -1,   74,   -1,   -1,   -1,   -1,   -1,   80,
			   81,   -1,   -1,   -1,   -1,   86,   -1,   88,   -1,   90,
			   91,   -1,   -1,   -1,   95,   96,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  105,  106,  107,  108,  109,  110,
			  111,  112,   -1,   -1,   -1,   -1,   -1,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,

			  137,  138,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,   30,   31,   -1,   -1,   -1,   -1,   36,   -1,
			   -1,   -1,   -1,   30,   31,   -1,   44,   -1,   -1,   -1,
			   -1,   49,   -1,   -1,   -1,   -1,   -1,   44,   -1,   -1,
			   -1,   59,   49,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   59,   30,   31,   -1,   89,   -1,   -1,   -1,
			   78,   -1,   -1,   -1,   -1,   42,   -1,   44,   -1,   87, yyDummy>>,
			1, 200, 4000)
		end

	yycheck_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   78,   49,   -1,   -1,   -1,   89,   -1,   -1,   -1,
			   87,   99,   59,   -1,   -1,  103,   -1,  105,  106,  107,
			  108,  109,   99,   -1,   -1,  113,  103,   -1,  105,  106,
			  107,  108,  109,   -1,   30,   31,  113,   -1,   -1,   -1,
			   87,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   44,   -1,
			   -1,   -1,   99,   49,   -1,   -1,  103,   -1,  105,  106,
			  107,  108,  109,   59,   -1,   -1,  113,   30,   31,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   44,   78,   -1,   -1,   -1,   49,   -1,   -1,   -1,
			   -1,   87,   -1,   -1,   -1,   -1,   59,   -1,   -1,   -1,

			   30,   31,   -1,   99,   -1,   -1,   -1,  103,   -1,  105,
			  106,  107,  108,  109,   44,   78,   -1,  113,   -1,   49,
			   -1,   -1,   -1,   -1,   87,   -1,   -1,   -1,   -1,   59,
			   -1,   -1,   -1,   30,   31,   -1,   99,   -1,   -1,   -1,
			  103,   -1,  105,  106,  107,  108,  109,   44,   78,   -1,
			  113,   -1,   49,   -1,   -1,   -1,   -1,   87,   -1,   -1,
			   -1,   -1,   59,   -1,   -1,   -1,   -1,   -1,   -1,   99,
			   -1,   -1,   -1,  103,   -1,  105,  106,  107,  108,  109,
			   -1,   -1,   -1,  113,   -1,   -1,   -1,   -1,   -1,   -1,
			   87,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1, yyDummy>>,
			1, 200, 4200)
		end

	yycheck_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   99,   -1,   -1,   -1,  103,   -1,  105,  106,
			  107,  108,  109,   -1,   -1,   -1,  113,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   58,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,   75,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,

			   18,   19,   20,   21,   22,   23,   24,   75,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   22,   23,   24,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   22,   23,   24,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   22,   23,   24,   -1,   -1,
			   -1,   68,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,   -1,
			  136,   68,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1, yyDummy>>,
			1, 200, 4400)
		end

	yycheck_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   58,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   58,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   47,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   22,   23,   24,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,

			   20,   21,   22,   23,   24,   45,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   41,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   41,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  138,  114,   -1,  116,   -1,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129, yyDummy>>,
			1, 200, 4600)
		end

	yycheck_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  130,  131,  132,  133,  134,  135,  136,  137,  138,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  138,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   22,   23,   24,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   22,   23,   24, yyDummy>>,
			1, 85, 4800)
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

	yyvs5: SPECIAL [detachable BOOL_AS]
			-- Stack for semantic values of type detachable BOOL_AS

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [detachable BOOL_AS]
			-- Routines that ought to be in SPECIAL [detachable BOOL_AS]

	yyvs6: SPECIAL [detachable RESULT_AS]
			-- Stack for semantic values of type detachable RESULT_AS

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [detachable RESULT_AS]
			-- Routines that ought to be in SPECIAL [detachable RESULT_AS]

	yyvs7: SPECIAL [detachable RETRY_AS]
			-- Stack for semantic values of type detachable RETRY_AS

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [detachable RETRY_AS]
			-- Routines that ought to be in SPECIAL [detachable RETRY_AS]

	yyvs8: SPECIAL [detachable UNIQUE_AS]
			-- Stack for semantic values of type detachable UNIQUE_AS

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [detachable UNIQUE_AS]
			-- Routines that ought to be in SPECIAL [detachable UNIQUE_AS]

	yyvs9: SPECIAL [detachable CURRENT_AS]
			-- Stack for semantic values of type detachable CURRENT_AS

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [detachable CURRENT_AS]
			-- Routines that ought to be in SPECIAL [detachable CURRENT_AS]

	yyvs10: SPECIAL [detachable DEFERRED_AS]
			-- Stack for semantic values of type detachable DEFERRED_AS

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [detachable DEFERRED_AS]
			-- Routines that ought to be in SPECIAL [detachable DEFERRED_AS]

	yyvs11: SPECIAL [detachable VOID_AS]
			-- Stack for semantic values of type detachable VOID_AS

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: KL_SPECIAL_ROUTINES [detachable VOID_AS]
			-- Routines that ought to be in SPECIAL [detachable VOID_AS]

	yyvs12: SPECIAL [detachable KEYWORD_AS]
			-- Stack for semantic values of type detachable KEYWORD_AS

	yyvsc12: INTEGER
			-- Capacity of semantic value stack `yyvs12'

	yyvsp12: INTEGER
			-- Top of semantic value stack `yyvs12'

	yyspecial_routines12: KL_SPECIAL_ROUTINES [detachable KEYWORD_AS]
			-- Routines that ought to be in SPECIAL [detachable KEYWORD_AS]

	yyvs13: SPECIAL [detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: READABLE_STRING_GENERAL]]
			-- Stack for semantic values of type detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: READABLE_STRING_GENERAL]

	yyvsc13: INTEGER
			-- Capacity of semantic value stack `yyvs13'

	yyvsp13: INTEGER
			-- Top of semantic value stack `yyvs13'

	yyspecial_routines13: KL_SPECIAL_ROUTINES [detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: READABLE_STRING_GENERAL]]
			-- Routines that ought to be in SPECIAL [detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: READABLE_STRING_GENERAL]]

	yyvs14: SPECIAL [detachable STRING_AS]
			-- Stack for semantic values of type detachable STRING_AS

	yyvsc14: INTEGER
			-- Capacity of semantic value stack `yyvs14'

	yyvsp14: INTEGER
			-- Top of semantic value stack `yyvs14'

	yyspecial_routines14: KL_SPECIAL_ROUTINES [detachable STRING_AS]
			-- Routines that ought to be in SPECIAL [detachable STRING_AS]

	yyvs15: SPECIAL [detachable ALIAS_TRIPLE]
			-- Stack for semantic values of type detachable ALIAS_TRIPLE

	yyvsc15: INTEGER
			-- Capacity of semantic value stack `yyvs15'

	yyvsp15: INTEGER
			-- Top of semantic value stack `yyvs15'

	yyspecial_routines15: KL_SPECIAL_ROUTINES [detachable ALIAS_TRIPLE]
			-- Routines that ought to be in SPECIAL [detachable ALIAS_TRIPLE]

	yyvs16: SPECIAL [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]

	yyvsc16: INTEGER
			-- Capacity of semantic value stack `yyvs16'

	yyvsp16: INTEGER
			-- Top of semantic value stack `yyvs16'

	yyspecial_routines16: KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]]
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]]

	yyvs17: SPECIAL [detachable PAIR [KEYWORD_AS, ID_AS]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, ID_AS]

	yyvsc17: INTEGER
			-- Capacity of semantic value stack `yyvs17'

	yyvsp17: INTEGER
			-- Top of semantic value stack `yyvs17'

	yyspecial_routines17: KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, ID_AS]]
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, ID_AS]]

	yyvs18: SPECIAL [detachable PAIR [KEYWORD_AS, STRING_AS]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, STRING_AS]

	yyvsc18: INTEGER
			-- Capacity of semantic value stack `yyvs18'

	yyvsp18: INTEGER
			-- Top of semantic value stack `yyvs18'

	yyspecial_routines18: KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, STRING_AS]]
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, STRING_AS]]

	yyvs19: SPECIAL [detachable IDENTIFIER_LIST]
			-- Stack for semantic values of type detachable IDENTIFIER_LIST

	yyvsc19: INTEGER
			-- Capacity of semantic value stack `yyvs19'

	yyvsp19: INTEGER
			-- Top of semantic value stack `yyvs19'

	yyspecial_routines19: KL_SPECIAL_ROUTINES [detachable IDENTIFIER_LIST]
			-- Routines that ought to be in SPECIAL [detachable IDENTIFIER_LIST]

	yyvs20: SPECIAL [detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]

	yyvsc20: INTEGER
			-- Capacity of semantic value stack `yyvs20'

	yyvsp20: INTEGER
			-- Top of semantic value stack `yyvs20'

	yyspecial_routines20: KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]]
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]]

	yyvs21: SPECIAL [detachable PAIR [KEYWORD_AS, EXPR_AS]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, EXPR_AS]

	yyvsc21: INTEGER
			-- Capacity of semantic value stack `yyvs21'

	yyvsp21: INTEGER
			-- Top of semantic value stack `yyvs21'

	yyspecial_routines21: KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, EXPR_AS]]
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, EXPR_AS]]

	yyvs22: SPECIAL [detachable AGENT_TARGET_TRIPLE]
			-- Stack for semantic values of type detachable AGENT_TARGET_TRIPLE

	yyvsc22: INTEGER
			-- Capacity of semantic value stack `yyvs22'

	yyvsp22: INTEGER
			-- Top of semantic value stack `yyvs22'

	yyspecial_routines22: KL_SPECIAL_ROUTINES [detachable AGENT_TARGET_TRIPLE]
			-- Routines that ought to be in SPECIAL [detachable AGENT_TARGET_TRIPLE]

	yyvs23: SPECIAL [detachable ACCESS_AS]
			-- Stack for semantic values of type detachable ACCESS_AS

	yyvsc23: INTEGER
			-- Capacity of semantic value stack `yyvs23'

	yyvsp23: INTEGER
			-- Top of semantic value stack `yyvs23'

	yyspecial_routines23: KL_SPECIAL_ROUTINES [detachable ACCESS_AS]
			-- Routines that ought to be in SPECIAL [detachable ACCESS_AS]

	yyvs24: SPECIAL [detachable ACCESS_FEAT_AS]
			-- Stack for semantic values of type detachable ACCESS_FEAT_AS

	yyvsc24: INTEGER
			-- Capacity of semantic value stack `yyvs24'

	yyvsp24: INTEGER
			-- Top of semantic value stack `yyvs24'

	yyspecial_routines24: KL_SPECIAL_ROUTINES [detachable ACCESS_FEAT_AS]
			-- Routines that ought to be in SPECIAL [detachable ACCESS_FEAT_AS]

	yyvs25: SPECIAL [detachable ACCESS_INV_AS]
			-- Stack for semantic values of type detachable ACCESS_INV_AS

	yyvsc25: INTEGER
			-- Capacity of semantic value stack `yyvs25'

	yyvsp25: INTEGER
			-- Top of semantic value stack `yyvs25'

	yyspecial_routines25: KL_SPECIAL_ROUTINES [detachable ACCESS_INV_AS]
			-- Routines that ought to be in SPECIAL [detachable ACCESS_INV_AS]

	yyvs26: SPECIAL [detachable ARRAY_AS]
			-- Stack for semantic values of type detachable ARRAY_AS

	yyvsc26: INTEGER
			-- Capacity of semantic value stack `yyvs26'

	yyvsp26: INTEGER
			-- Top of semantic value stack `yyvs26'

	yyspecial_routines26: KL_SPECIAL_ROUTINES [detachable ARRAY_AS]
			-- Routines that ought to be in SPECIAL [detachable ARRAY_AS]

	yyvs27: SPECIAL [detachable ASSIGN_AS]
			-- Stack for semantic values of type detachable ASSIGN_AS

	yyvsc27: INTEGER
			-- Capacity of semantic value stack `yyvs27'

	yyvsp27: INTEGER
			-- Top of semantic value stack `yyvs27'

	yyspecial_routines27: KL_SPECIAL_ROUTINES [detachable ASSIGN_AS]
			-- Routines that ought to be in SPECIAL [detachable ASSIGN_AS]

	yyvs28: SPECIAL [detachable ATOMIC_AS]
			-- Stack for semantic values of type detachable ATOMIC_AS

	yyvsc28: INTEGER
			-- Capacity of semantic value stack `yyvs28'

	yyvsp28: INTEGER
			-- Top of semantic value stack `yyvs28'

	yyspecial_routines28: KL_SPECIAL_ROUTINES [detachable ATOMIC_AS]
			-- Routines that ought to be in SPECIAL [detachable ATOMIC_AS]

	yyvs29: SPECIAL [detachable BINARY_AS]
			-- Stack for semantic values of type detachable BINARY_AS

	yyvsc29: INTEGER
			-- Capacity of semantic value stack `yyvs29'

	yyvsp29: INTEGER
			-- Top of semantic value stack `yyvs29'

	yyspecial_routines29: KL_SPECIAL_ROUTINES [detachable BINARY_AS]
			-- Routines that ought to be in SPECIAL [detachable BINARY_AS]

	yyvs30: SPECIAL [detachable BODY_AS]
			-- Stack for semantic values of type detachable BODY_AS

	yyvsc30: INTEGER
			-- Capacity of semantic value stack `yyvs30'

	yyvsp30: INTEGER
			-- Top of semantic value stack `yyvs30'

	yyspecial_routines30: KL_SPECIAL_ROUTINES [detachable BODY_AS]
			-- Routines that ought to be in SPECIAL [detachable BODY_AS]

	yyvs31: SPECIAL [BOOLEAN]
			-- Stack for semantic values of type BOOLEAN

	yyvsc31: INTEGER
			-- Capacity of semantic value stack `yyvs31'

	yyvsp31: INTEGER
			-- Top of semantic value stack `yyvs31'

	yyspecial_routines31: KL_SPECIAL_ROUTINES [BOOLEAN]
			-- Routines that ought to be in SPECIAL [BOOLEAN]

	yyvs32: SPECIAL [detachable CALL_AS]
			-- Stack for semantic values of type detachable CALL_AS

	yyvsc32: INTEGER
			-- Capacity of semantic value stack `yyvs32'

	yyvsp32: INTEGER
			-- Top of semantic value stack `yyvs32'

	yyspecial_routines32: KL_SPECIAL_ROUTINES [detachable CALL_AS]
			-- Routines that ought to be in SPECIAL [detachable CALL_AS]

	yyvs33: SPECIAL [detachable CASE_AS]
			-- Stack for semantic values of type detachable CASE_AS

	yyvsc33: INTEGER
			-- Capacity of semantic value stack `yyvs33'

	yyvsp33: INTEGER
			-- Top of semantic value stack `yyvs33'

	yyspecial_routines33: KL_SPECIAL_ROUTINES [detachable CASE_AS]
			-- Routines that ought to be in SPECIAL [detachable CASE_AS]

	yyvs34: SPECIAL [detachable CHECK_AS]
			-- Stack for semantic values of type detachable CHECK_AS

	yyvsc34: INTEGER
			-- Capacity of semantic value stack `yyvs34'

	yyvsp34: INTEGER
			-- Top of semantic value stack `yyvs34'

	yyspecial_routines34: KL_SPECIAL_ROUTINES [detachable CHECK_AS]
			-- Routines that ought to be in SPECIAL [detachable CHECK_AS]

	yyvs35: SPECIAL [detachable CLIENT_AS]
			-- Stack for semantic values of type detachable CLIENT_AS

	yyvsc35: INTEGER
			-- Capacity of semantic value stack `yyvs35'

	yyvsp35: INTEGER
			-- Top of semantic value stack `yyvs35'

	yyspecial_routines35: KL_SPECIAL_ROUTINES [detachable CLIENT_AS]
			-- Routines that ought to be in SPECIAL [detachable CLIENT_AS]

	yyvs36: SPECIAL [detachable CONSTANT_AS]
			-- Stack for semantic values of type detachable CONSTANT_AS

	yyvsc36: INTEGER
			-- Capacity of semantic value stack `yyvs36'

	yyvsp36: INTEGER
			-- Top of semantic value stack `yyvs36'

	yyspecial_routines36: KL_SPECIAL_ROUTINES [detachable CONSTANT_AS]
			-- Routines that ought to be in SPECIAL [detachable CONSTANT_AS]

	yyvs37: SPECIAL [detachable CONVERT_FEAT_AS]
			-- Stack for semantic values of type detachable CONVERT_FEAT_AS

	yyvsc37: INTEGER
			-- Capacity of semantic value stack `yyvs37'

	yyvsp37: INTEGER
			-- Top of semantic value stack `yyvs37'

	yyspecial_routines37: KL_SPECIAL_ROUTINES [detachable CONVERT_FEAT_AS]
			-- Routines that ought to be in SPECIAL [detachable CONVERT_FEAT_AS]

	yyvs38: SPECIAL [detachable CREATE_AS]
			-- Stack for semantic values of type detachable CREATE_AS

	yyvsc38: INTEGER
			-- Capacity of semantic value stack `yyvs38'

	yyvsp38: INTEGER
			-- Top of semantic value stack `yyvs38'

	yyspecial_routines38: KL_SPECIAL_ROUTINES [detachable CREATE_AS]
			-- Routines that ought to be in SPECIAL [detachable CREATE_AS]

	yyvs39: SPECIAL [detachable CREATION_AS]
			-- Stack for semantic values of type detachable CREATION_AS

	yyvsc39: INTEGER
			-- Capacity of semantic value stack `yyvs39'

	yyvsp39: INTEGER
			-- Top of semantic value stack `yyvs39'

	yyspecial_routines39: KL_SPECIAL_ROUTINES [detachable CREATION_AS]
			-- Routines that ought to be in SPECIAL [detachable CREATION_AS]

	yyvs40: SPECIAL [detachable CREATION_EXPR_AS]
			-- Stack for semantic values of type detachable CREATION_EXPR_AS

	yyvsc40: INTEGER
			-- Capacity of semantic value stack `yyvs40'

	yyvsp40: INTEGER
			-- Top of semantic value stack `yyvs40'

	yyspecial_routines40: KL_SPECIAL_ROUTINES [detachable CREATION_EXPR_AS]
			-- Routines that ought to be in SPECIAL [detachable CREATION_EXPR_AS]

	yyvs41: SPECIAL [detachable DEBUG_AS]
			-- Stack for semantic values of type detachable DEBUG_AS

	yyvsc41: INTEGER
			-- Capacity of semantic value stack `yyvs41'

	yyvsp41: INTEGER
			-- Top of semantic value stack `yyvs41'

	yyspecial_routines41: KL_SPECIAL_ROUTINES [detachable DEBUG_AS]
			-- Routines that ought to be in SPECIAL [detachable DEBUG_AS]

	yyvs42: SPECIAL [detachable ELSIF_AS]
			-- Stack for semantic values of type detachable ELSIF_AS

	yyvsc42: INTEGER
			-- Capacity of semantic value stack `yyvs42'

	yyvsp42: INTEGER
			-- Top of semantic value stack `yyvs42'

	yyspecial_routines42: KL_SPECIAL_ROUTINES [detachable ELSIF_AS]
			-- Routines that ought to be in SPECIAL [detachable ELSIF_AS]

	yyvs43: SPECIAL [detachable ELSIF_EXPRESSION_AS]
			-- Stack for semantic values of type detachable ELSIF_EXPRESSION_AS

	yyvsc43: INTEGER
			-- Capacity of semantic value stack `yyvs43'

	yyvsp43: INTEGER
			-- Top of semantic value stack `yyvs43'

	yyspecial_routines43: KL_SPECIAL_ROUTINES [detachable ELSIF_EXPRESSION_AS]
			-- Routines that ought to be in SPECIAL [detachable ELSIF_EXPRESSION_AS]

	yyvs44: SPECIAL [detachable ENSURE_AS]
			-- Stack for semantic values of type detachable ENSURE_AS

	yyvsc44: INTEGER
			-- Capacity of semantic value stack `yyvs44'

	yyvsp44: INTEGER
			-- Top of semantic value stack `yyvs44'

	yyspecial_routines44: KL_SPECIAL_ROUTINES [detachable ENSURE_AS]
			-- Routines that ought to be in SPECIAL [detachable ENSURE_AS]

	yyvs45: SPECIAL [detachable EXPORT_ITEM_AS]
			-- Stack for semantic values of type detachable EXPORT_ITEM_AS

	yyvsc45: INTEGER
			-- Capacity of semantic value stack `yyvs45'

	yyvsp45: INTEGER
			-- Top of semantic value stack `yyvs45'

	yyspecial_routines45: KL_SPECIAL_ROUTINES [detachable EXPORT_ITEM_AS]
			-- Routines that ought to be in SPECIAL [detachable EXPORT_ITEM_AS]

	yyvs46: SPECIAL [detachable EXPR_AS]
			-- Stack for semantic values of type detachable EXPR_AS

	yyvsc46: INTEGER
			-- Capacity of semantic value stack `yyvs46'

	yyvsp46: INTEGER
			-- Top of semantic value stack `yyvs46'

	yyspecial_routines46: KL_SPECIAL_ROUTINES [detachable EXPR_AS]
			-- Routines that ought to be in SPECIAL [detachable EXPR_AS]

	yyvs47: SPECIAL [detachable EXTERNAL_AS]
			-- Stack for semantic values of type detachable EXTERNAL_AS

	yyvsc47: INTEGER
			-- Capacity of semantic value stack `yyvs47'

	yyvsp47: INTEGER
			-- Top of semantic value stack `yyvs47'

	yyspecial_routines47: KL_SPECIAL_ROUTINES [detachable EXTERNAL_AS]
			-- Routines that ought to be in SPECIAL [detachable EXTERNAL_AS]

	yyvs48: SPECIAL [detachable EXTERNAL_LANG_AS]
			-- Stack for semantic values of type detachable EXTERNAL_LANG_AS

	yyvsc48: INTEGER
			-- Capacity of semantic value stack `yyvs48'

	yyvsp48: INTEGER
			-- Top of semantic value stack `yyvs48'

	yyspecial_routines48: KL_SPECIAL_ROUTINES [detachable EXTERNAL_LANG_AS]
			-- Routines that ought to be in SPECIAL [detachable EXTERNAL_LANG_AS]

	yyvs49: SPECIAL [detachable FEATURE_AS]
			-- Stack for semantic values of type detachable FEATURE_AS

	yyvsc49: INTEGER
			-- Capacity of semantic value stack `yyvs49'

	yyvsp49: INTEGER
			-- Top of semantic value stack `yyvs49'

	yyspecial_routines49: KL_SPECIAL_ROUTINES [detachable FEATURE_AS]
			-- Routines that ought to be in SPECIAL [detachable FEATURE_AS]

	yyvs50: SPECIAL [detachable FEATURE_CLAUSE_AS]
			-- Stack for semantic values of type detachable FEATURE_CLAUSE_AS

	yyvsc50: INTEGER
			-- Capacity of semantic value stack `yyvs50'

	yyvsp50: INTEGER
			-- Top of semantic value stack `yyvs50'

	yyspecial_routines50: KL_SPECIAL_ROUTINES [detachable FEATURE_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable FEATURE_CLAUSE_AS]

	yyvs51: SPECIAL [detachable FEATURE_SET_AS]
			-- Stack for semantic values of type detachable FEATURE_SET_AS

	yyvsc51: INTEGER
			-- Capacity of semantic value stack `yyvs51'

	yyvsp51: INTEGER
			-- Top of semantic value stack `yyvs51'

	yyspecial_routines51: KL_SPECIAL_ROUTINES [detachable FEATURE_SET_AS]
			-- Routines that ought to be in SPECIAL [detachable FEATURE_SET_AS]

	yyvs52: SPECIAL [detachable FORMAL_AS]
			-- Stack for semantic values of type detachable FORMAL_AS

	yyvsc52: INTEGER
			-- Capacity of semantic value stack `yyvs52'

	yyvsp52: INTEGER
			-- Top of semantic value stack `yyvs52'

	yyspecial_routines52: KL_SPECIAL_ROUTINES [detachable FORMAL_AS]
			-- Routines that ought to be in SPECIAL [detachable FORMAL_AS]

	yyvs53: SPECIAL [detachable FORMAL_DEC_AS]
			-- Stack for semantic values of type detachable FORMAL_DEC_AS

	yyvsc53: INTEGER
			-- Capacity of semantic value stack `yyvs53'

	yyvsp53: INTEGER
			-- Top of semantic value stack `yyvs53'

	yyspecial_routines53: KL_SPECIAL_ROUTINES [detachable FORMAL_DEC_AS]
			-- Routines that ought to be in SPECIAL [detachable FORMAL_DEC_AS]

	yyvs54: SPECIAL [detachable GUARD_AS]
			-- Stack for semantic values of type detachable GUARD_AS

	yyvsc54: INTEGER
			-- Capacity of semantic value stack `yyvs54'

	yyvsp54: INTEGER
			-- Top of semantic value stack `yyvs54'

	yyspecial_routines54: KL_SPECIAL_ROUTINES [detachable GUARD_AS]
			-- Routines that ought to be in SPECIAL [detachable GUARD_AS]

	yyvs55: SPECIAL [detachable IF_AS]
			-- Stack for semantic values of type detachable IF_AS

	yyvsc55: INTEGER
			-- Capacity of semantic value stack `yyvs55'

	yyvsp55: INTEGER
			-- Top of semantic value stack `yyvs55'

	yyspecial_routines55: KL_SPECIAL_ROUTINES [detachable IF_AS]
			-- Routines that ought to be in SPECIAL [detachable IF_AS]

	yyvs56: SPECIAL [detachable IF_EXPRESSION_AS]
			-- Stack for semantic values of type detachable IF_EXPRESSION_AS

	yyvsc56: INTEGER
			-- Capacity of semantic value stack `yyvs56'

	yyvsp56: INTEGER
			-- Top of semantic value stack `yyvs56'

	yyspecial_routines56: KL_SPECIAL_ROUTINES [detachable IF_EXPRESSION_AS]
			-- Routines that ought to be in SPECIAL [detachable IF_EXPRESSION_AS]

	yyvs57: SPECIAL [detachable INDEX_AS]
			-- Stack for semantic values of type detachable INDEX_AS

	yyvsc57: INTEGER
			-- Capacity of semantic value stack `yyvs57'

	yyvsp57: INTEGER
			-- Top of semantic value stack `yyvs57'

	yyspecial_routines57: KL_SPECIAL_ROUTINES [detachable INDEX_AS]
			-- Routines that ought to be in SPECIAL [detachable INDEX_AS]

	yyvs58: SPECIAL [detachable INSPECT_AS]
			-- Stack for semantic values of type detachable INSPECT_AS

	yyvsc58: INTEGER
			-- Capacity of semantic value stack `yyvs58'

	yyvsp58: INTEGER
			-- Top of semantic value stack `yyvs58'

	yyspecial_routines58: KL_SPECIAL_ROUTINES [detachable INSPECT_AS]
			-- Routines that ought to be in SPECIAL [detachable INSPECT_AS]

	yyvs59: SPECIAL [detachable INSTRUCTION_AS]
			-- Stack for semantic values of type detachable INSTRUCTION_AS

	yyvsc59: INTEGER
			-- Capacity of semantic value stack `yyvs59'

	yyvsp59: INTEGER
			-- Top of semantic value stack `yyvs59'

	yyspecial_routines59: KL_SPECIAL_ROUTINES [detachable INSTRUCTION_AS]
			-- Routines that ought to be in SPECIAL [detachable INSTRUCTION_AS]

	yyvs60: SPECIAL [detachable INTEGER_AS]
			-- Stack for semantic values of type detachable INTEGER_AS

	yyvsc60: INTEGER
			-- Capacity of semantic value stack `yyvs60'

	yyvsp60: INTEGER
			-- Top of semantic value stack `yyvs60'

	yyspecial_routines60: KL_SPECIAL_ROUTINES [detachable INTEGER_AS]
			-- Routines that ought to be in SPECIAL [detachable INTEGER_AS]

	yyvs61: SPECIAL [detachable INTERNAL_AS]
			-- Stack for semantic values of type detachable INTERNAL_AS

	yyvsc61: INTEGER
			-- Capacity of semantic value stack `yyvs61'

	yyvsp61: INTEGER
			-- Top of semantic value stack `yyvs61'

	yyspecial_routines61: KL_SPECIAL_ROUTINES [detachable INTERNAL_AS]
			-- Routines that ought to be in SPECIAL [detachable INTERNAL_AS]

	yyvs62: SPECIAL [detachable INTERVAL_AS]
			-- Stack for semantic values of type detachable INTERVAL_AS

	yyvsc62: INTEGER
			-- Capacity of semantic value stack `yyvs62'

	yyvsp62: INTEGER
			-- Top of semantic value stack `yyvs62'

	yyspecial_routines62: KL_SPECIAL_ROUTINES [detachable INTERVAL_AS]
			-- Routines that ought to be in SPECIAL [detachable INTERVAL_AS]

	yyvs63: SPECIAL [detachable INVARIANT_AS]
			-- Stack for semantic values of type detachable INVARIANT_AS

	yyvsc63: INTEGER
			-- Capacity of semantic value stack `yyvs63'

	yyvsp63: INTEGER
			-- Top of semantic value stack `yyvs63'

	yyspecial_routines63: KL_SPECIAL_ROUTINES [detachable INVARIANT_AS]
			-- Routines that ought to be in SPECIAL [detachable INVARIANT_AS]

	yyvs64: SPECIAL [detachable LOOP_EXPR_AS]
			-- Stack for semantic values of type detachable LOOP_EXPR_AS

	yyvsc64: INTEGER
			-- Capacity of semantic value stack `yyvs64'

	yyvsp64: INTEGER
			-- Top of semantic value stack `yyvs64'

	yyspecial_routines64: KL_SPECIAL_ROUTINES [detachable LOOP_EXPR_AS]
			-- Routines that ought to be in SPECIAL [detachable LOOP_EXPR_AS]

	yyvs65: SPECIAL [detachable LOOP_AS]
			-- Stack for semantic values of type detachable LOOP_AS

	yyvsc65: INTEGER
			-- Capacity of semantic value stack `yyvs65'

	yyvsp65: INTEGER
			-- Top of semantic value stack `yyvs65'

	yyspecial_routines65: KL_SPECIAL_ROUTINES [detachable LOOP_AS]
			-- Routines that ought to be in SPECIAL [detachable LOOP_AS]

	yyvs66: SPECIAL [detachable NAMED_EXPRESSION_AS]
			-- Stack for semantic values of type detachable NAMED_EXPRESSION_AS

	yyvsc66: INTEGER
			-- Capacity of semantic value stack `yyvs66'

	yyvsp66: INTEGER
			-- Top of semantic value stack `yyvs66'

	yyspecial_routines66: KL_SPECIAL_ROUTINES [detachable NAMED_EXPRESSION_AS]
			-- Routines that ought to be in SPECIAL [detachable NAMED_EXPRESSION_AS]

	yyvs67: SPECIAL [detachable NESTED_AS]
			-- Stack for semantic values of type detachable NESTED_AS

	yyvsc67: INTEGER
			-- Capacity of semantic value stack `yyvs67'

	yyvsp67: INTEGER
			-- Top of semantic value stack `yyvs67'

	yyspecial_routines67: KL_SPECIAL_ROUTINES [detachable NESTED_AS]
			-- Routines that ought to be in SPECIAL [detachable NESTED_AS]

	yyvs68: SPECIAL [detachable OPERAND_AS]
			-- Stack for semantic values of type detachable OPERAND_AS

	yyvsc68: INTEGER
			-- Capacity of semantic value stack `yyvs68'

	yyvsp68: INTEGER
			-- Top of semantic value stack `yyvs68'

	yyspecial_routines68: KL_SPECIAL_ROUTINES [detachable OPERAND_AS]
			-- Routines that ought to be in SPECIAL [detachable OPERAND_AS]

	yyvs69: SPECIAL [detachable PARENT_AS]
			-- Stack for semantic values of type detachable PARENT_AS

	yyvsc69: INTEGER
			-- Capacity of semantic value stack `yyvs69'

	yyvsp69: INTEGER
			-- Top of semantic value stack `yyvs69'

	yyspecial_routines69: KL_SPECIAL_ROUTINES [detachable PARENT_AS]
			-- Routines that ought to be in SPECIAL [detachable PARENT_AS]

	yyvs70: SPECIAL [detachable PRECURSOR_AS]
			-- Stack for semantic values of type detachable PRECURSOR_AS

	yyvsc70: INTEGER
			-- Capacity of semantic value stack `yyvs70'

	yyvsp70: INTEGER
			-- Top of semantic value stack `yyvs70'

	yyspecial_routines70: KL_SPECIAL_ROUTINES [detachable PRECURSOR_AS]
			-- Routines that ought to be in SPECIAL [detachable PRECURSOR_AS]

	yyvs71: SPECIAL [detachable STATIC_ACCESS_AS]
			-- Stack for semantic values of type detachable STATIC_ACCESS_AS

	yyvsc71: INTEGER
			-- Capacity of semantic value stack `yyvs71'

	yyvsp71: INTEGER
			-- Top of semantic value stack `yyvs71'

	yyspecial_routines71: KL_SPECIAL_ROUTINES [detachable STATIC_ACCESS_AS]
			-- Routines that ought to be in SPECIAL [detachable STATIC_ACCESS_AS]

	yyvs72: SPECIAL [detachable REAL_AS]
			-- Stack for semantic values of type detachable REAL_AS

	yyvsc72: INTEGER
			-- Capacity of semantic value stack `yyvs72'

	yyvsp72: INTEGER
			-- Top of semantic value stack `yyvs72'

	yyspecial_routines72: KL_SPECIAL_ROUTINES [detachable REAL_AS]
			-- Routines that ought to be in SPECIAL [detachable REAL_AS]

	yyvs73: SPECIAL [detachable RENAME_AS]
			-- Stack for semantic values of type detachable RENAME_AS

	yyvsc73: INTEGER
			-- Capacity of semantic value stack `yyvs73'

	yyvsp73: INTEGER
			-- Top of semantic value stack `yyvs73'

	yyspecial_routines73: KL_SPECIAL_ROUTINES [detachable RENAME_AS]
			-- Routines that ought to be in SPECIAL [detachable RENAME_AS]

	yyvs74: SPECIAL [detachable REQUIRE_AS]
			-- Stack for semantic values of type detachable REQUIRE_AS

	yyvsc74: INTEGER
			-- Capacity of semantic value stack `yyvs74'

	yyvsp74: INTEGER
			-- Top of semantic value stack `yyvs74'

	yyspecial_routines74: KL_SPECIAL_ROUTINES [detachable REQUIRE_AS]
			-- Routines that ought to be in SPECIAL [detachable REQUIRE_AS]

	yyvs75: SPECIAL [detachable REVERSE_AS]
			-- Stack for semantic values of type detachable REVERSE_AS

	yyvsc75: INTEGER
			-- Capacity of semantic value stack `yyvs75'

	yyvsp75: INTEGER
			-- Top of semantic value stack `yyvs75'

	yyspecial_routines75: KL_SPECIAL_ROUTINES [detachable REVERSE_AS]
			-- Routines that ought to be in SPECIAL [detachable REVERSE_AS]

	yyvs76: SPECIAL [detachable ROUT_BODY_AS]
			-- Stack for semantic values of type detachable ROUT_BODY_AS

	yyvsc76: INTEGER
			-- Capacity of semantic value stack `yyvs76'

	yyvsp76: INTEGER
			-- Top of semantic value stack `yyvs76'

	yyspecial_routines76: KL_SPECIAL_ROUTINES [detachable ROUT_BODY_AS]
			-- Routines that ought to be in SPECIAL [detachable ROUT_BODY_AS]

	yyvs77: SPECIAL [detachable ROUTINE_AS]
			-- Stack for semantic values of type detachable ROUTINE_AS

	yyvsc77: INTEGER
			-- Capacity of semantic value stack `yyvs77'

	yyvsp77: INTEGER
			-- Top of semantic value stack `yyvs77'

	yyspecial_routines77: KL_SPECIAL_ROUTINES [detachable ROUTINE_AS]
			-- Routines that ought to be in SPECIAL [detachable ROUTINE_AS]

	yyvs78: SPECIAL [detachable ROUTINE_CREATION_AS]
			-- Stack for semantic values of type detachable ROUTINE_CREATION_AS

	yyvsc78: INTEGER
			-- Capacity of semantic value stack `yyvs78'

	yyvsp78: INTEGER
			-- Top of semantic value stack `yyvs78'

	yyspecial_routines78: KL_SPECIAL_ROUTINES [detachable ROUTINE_CREATION_AS]
			-- Routines that ought to be in SPECIAL [detachable ROUTINE_CREATION_AS]

	yyvs79: SPECIAL [detachable SEPARATE_INSTRUCTION_AS]
			-- Stack for semantic values of type detachable SEPARATE_INSTRUCTION_AS

	yyvsc79: INTEGER
			-- Capacity of semantic value stack `yyvs79'

	yyvsp79: INTEGER
			-- Top of semantic value stack `yyvs79'

	yyspecial_routines79: KL_SPECIAL_ROUTINES [detachable SEPARATE_INSTRUCTION_AS]
			-- Routines that ought to be in SPECIAL [detachable SEPARATE_INSTRUCTION_AS]

	yyvs80: SPECIAL [detachable TAGGED_AS]
			-- Stack for semantic values of type detachable TAGGED_AS

	yyvsc80: INTEGER
			-- Capacity of semantic value stack `yyvs80'

	yyvsp80: INTEGER
			-- Top of semantic value stack `yyvs80'

	yyspecial_routines80: KL_SPECIAL_ROUTINES [detachable TAGGED_AS]
			-- Routines that ought to be in SPECIAL [detachable TAGGED_AS]

	yyvs81: SPECIAL [detachable TUPLE_AS]
			-- Stack for semantic values of type detachable TUPLE_AS

	yyvsc81: INTEGER
			-- Capacity of semantic value stack `yyvs81'

	yyvsp81: INTEGER
			-- Top of semantic value stack `yyvs81'

	yyspecial_routines81: KL_SPECIAL_ROUTINES [detachable TUPLE_AS]
			-- Routines that ought to be in SPECIAL [detachable TUPLE_AS]

	yyvs82: SPECIAL [detachable TYPE_AS]
			-- Stack for semantic values of type detachable TYPE_AS

	yyvsc82: INTEGER
			-- Capacity of semantic value stack `yyvs82'

	yyvsp82: INTEGER
			-- Top of semantic value stack `yyvs82'

	yyspecial_routines82: KL_SPECIAL_ROUTINES [detachable TYPE_AS]
			-- Routines that ought to be in SPECIAL [detachable TYPE_AS]

	yyvs83: SPECIAL [detachable QUALIFIED_ANCHORED_TYPE_AS]
			-- Stack for semantic values of type detachable QUALIFIED_ANCHORED_TYPE_AS

	yyvsc83: INTEGER
			-- Capacity of semantic value stack `yyvs83'

	yyvsp83: INTEGER
			-- Top of semantic value stack `yyvs83'

	yyspecial_routines83: KL_SPECIAL_ROUTINES [detachable QUALIFIED_ANCHORED_TYPE_AS]
			-- Routines that ought to be in SPECIAL [detachable QUALIFIED_ANCHORED_TYPE_AS]

	yyvs84: SPECIAL [detachable CLASS_TYPE_AS]
			-- Stack for semantic values of type detachable CLASS_TYPE_AS

	yyvsc84: INTEGER
			-- Capacity of semantic value stack `yyvs84'

	yyvsp84: INTEGER
			-- Top of semantic value stack `yyvs84'

	yyspecial_routines84: KL_SPECIAL_ROUTINES [detachable CLASS_TYPE_AS]
			-- Routines that ought to be in SPECIAL [detachable CLASS_TYPE_AS]

	yyvs85: SPECIAL [detachable TYPE_DEC_AS]
			-- Stack for semantic values of type detachable TYPE_DEC_AS

	yyvsc85: INTEGER
			-- Capacity of semantic value stack `yyvs85'

	yyvsp85: INTEGER
			-- Top of semantic value stack `yyvs85'

	yyspecial_routines85: KL_SPECIAL_ROUTINES [detachable TYPE_DEC_AS]
			-- Routines that ought to be in SPECIAL [detachable TYPE_DEC_AS]

	yyvs86: SPECIAL [detachable LIST_DEC_AS]
			-- Stack for semantic values of type detachable LIST_DEC_AS

	yyvsc86: INTEGER
			-- Capacity of semantic value stack `yyvs86'

	yyvsp86: INTEGER
			-- Top of semantic value stack `yyvs86'

	yyspecial_routines86: KL_SPECIAL_ROUTINES [detachable LIST_DEC_AS]
			-- Routines that ought to be in SPECIAL [detachable LIST_DEC_AS]

	yyvs87: SPECIAL [detachable VARIANT_AS]
			-- Stack for semantic values of type detachable VARIANT_AS

	yyvsc87: INTEGER
			-- Capacity of semantic value stack `yyvs87'

	yyvsp87: INTEGER
			-- Top of semantic value stack `yyvs87'

	yyspecial_routines87: KL_SPECIAL_ROUTINES [detachable VARIANT_AS]
			-- Routines that ought to be in SPECIAL [detachable VARIANT_AS]

	yyvs88: SPECIAL [detachable FEATURE_NAME]
			-- Stack for semantic values of type detachable FEATURE_NAME

	yyvsc88: INTEGER
			-- Capacity of semantic value stack `yyvs88'

	yyvsp88: INTEGER
			-- Top of semantic value stack `yyvs88'

	yyspecial_routines88: KL_SPECIAL_ROUTINES [detachable FEATURE_NAME]
			-- Routines that ought to be in SPECIAL [detachable FEATURE_NAME]

	yyvs89: SPECIAL [detachable EIFFEL_LIST [ATOMIC_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [ATOMIC_AS]

	yyvsc89: INTEGER
			-- Capacity of semantic value stack `yyvs89'

	yyvsp89: INTEGER
			-- Top of semantic value stack `yyvs89'

	yyspecial_routines89: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [ATOMIC_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [ATOMIC_AS]]

	yyvs90: SPECIAL [detachable EIFFEL_LIST [CASE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [CASE_AS]

	yyvsc90: INTEGER
			-- Capacity of semantic value stack `yyvs90'

	yyvsp90: INTEGER
			-- Top of semantic value stack `yyvs90'

	yyspecial_routines90: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [CASE_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [CASE_AS]]

	yyvs91: SPECIAL [detachable CONVERT_FEAT_LIST_AS]
			-- Stack for semantic values of type detachable CONVERT_FEAT_LIST_AS

	yyvsc91: INTEGER
			-- Capacity of semantic value stack `yyvs91'

	yyvsp91: INTEGER
			-- Top of semantic value stack `yyvs91'

	yyspecial_routines91: KL_SPECIAL_ROUTINES [detachable CONVERT_FEAT_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable CONVERT_FEAT_LIST_AS]

	yyvs92: SPECIAL [detachable EIFFEL_LIST [CREATE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [CREATE_AS]

	yyvsc92: INTEGER
			-- Capacity of semantic value stack `yyvs92'

	yyvsp92: INTEGER
			-- Top of semantic value stack `yyvs92'

	yyspecial_routines92: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [CREATE_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [CREATE_AS]]

	yyvs93: SPECIAL [detachable EIFFEL_LIST [ELSIF_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [ELSIF_AS]

	yyvsc93: INTEGER
			-- Capacity of semantic value stack `yyvs93'

	yyvsp93: INTEGER
			-- Top of semantic value stack `yyvs93'

	yyspecial_routines93: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [ELSIF_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [ELSIF_AS]]

	yyvs94: SPECIAL [detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]

	yyvsc94: INTEGER
			-- Capacity of semantic value stack `yyvs94'

	yyvsp94: INTEGER
			-- Top of semantic value stack `yyvs94'

	yyspecial_routines94: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]]

	yyvs95: SPECIAL [detachable EIFFEL_LIST [EXPORT_ITEM_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [EXPORT_ITEM_AS]

	yyvsc95: INTEGER
			-- Capacity of semantic value stack `yyvs95'

	yyvsp95: INTEGER
			-- Top of semantic value stack `yyvs95'

	yyspecial_routines95: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [EXPORT_ITEM_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [EXPORT_ITEM_AS]]

	yyvs96: SPECIAL [detachable EXPORT_CLAUSE_AS]
			-- Stack for semantic values of type detachable EXPORT_CLAUSE_AS

	yyvsc96: INTEGER
			-- Capacity of semantic value stack `yyvs96'

	yyvsp96: INTEGER
			-- Top of semantic value stack `yyvs96'

	yyspecial_routines96: KL_SPECIAL_ROUTINES [detachable EXPORT_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable EXPORT_CLAUSE_AS]

	yyvs97: SPECIAL [detachable EIFFEL_LIST [EXPR_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [EXPR_AS]

	yyvsc97: INTEGER
			-- Capacity of semantic value stack `yyvs97'

	yyvsp97: INTEGER
			-- Top of semantic value stack `yyvs97'

	yyspecial_routines97: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [EXPR_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [EXPR_AS]]

	yyvs98: SPECIAL [detachable PARAMETER_LIST_AS]
			-- Stack for semantic values of type detachable PARAMETER_LIST_AS

	yyvsc98: INTEGER
			-- Capacity of semantic value stack `yyvs98'

	yyvsp98: INTEGER
			-- Top of semantic value stack `yyvs98'

	yyspecial_routines98: KL_SPECIAL_ROUTINES [detachable PARAMETER_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable PARAMETER_LIST_AS]

	yyvs99: SPECIAL [detachable EIFFEL_LIST [FEATURE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [FEATURE_AS]

	yyvsc99: INTEGER
			-- Capacity of semantic value stack `yyvs99'

	yyvsp99: INTEGER
			-- Top of semantic value stack `yyvs99'

	yyspecial_routines99: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [FEATURE_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [FEATURE_AS]]

	yyvs100: SPECIAL [detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]

	yyvsc100: INTEGER
			-- Capacity of semantic value stack `yyvs100'

	yyvsp100: INTEGER
			-- Top of semantic value stack `yyvs100'

	yyspecial_routines100: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]]

	yyvs101: SPECIAL [detachable EIFFEL_LIST [FEATURE_NAME]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [FEATURE_NAME]

	yyvsc101: INTEGER
			-- Capacity of semantic value stack `yyvs101'

	yyvsp101: INTEGER
			-- Top of semantic value stack `yyvs101'

	yyspecial_routines101: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [FEATURE_NAME]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [FEATURE_NAME]]

	yyvs102: SPECIAL [detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]

	yyvsc102: INTEGER
			-- Capacity of semantic value stack `yyvs102'

	yyvsp102: INTEGER
			-- Top of semantic value stack `yyvs102'

	yyspecial_routines102: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]]

	yyvs103: SPECIAL [detachable CREATION_CONSTRAIN_TRIPLE]
			-- Stack for semantic values of type detachable CREATION_CONSTRAIN_TRIPLE

	yyvsc103: INTEGER
			-- Capacity of semantic value stack `yyvs103'

	yyvsp103: INTEGER
			-- Top of semantic value stack `yyvs103'

	yyspecial_routines103: KL_SPECIAL_ROUTINES [detachable CREATION_CONSTRAIN_TRIPLE]
			-- Routines that ought to be in SPECIAL [detachable CREATION_CONSTRAIN_TRIPLE]

	yyvs104: SPECIAL [detachable UNDEFINE_CLAUSE_AS]
			-- Stack for semantic values of type detachable UNDEFINE_CLAUSE_AS

	yyvsc104: INTEGER
			-- Capacity of semantic value stack `yyvs104'

	yyvsp104: INTEGER
			-- Top of semantic value stack `yyvs104'

	yyspecial_routines104: KL_SPECIAL_ROUTINES [detachable UNDEFINE_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable UNDEFINE_CLAUSE_AS]

	yyvs105: SPECIAL [detachable REDEFINE_CLAUSE_AS]
			-- Stack for semantic values of type detachable REDEFINE_CLAUSE_AS

	yyvsc105: INTEGER
			-- Capacity of semantic value stack `yyvs105'

	yyvsp105: INTEGER
			-- Top of semantic value stack `yyvs105'

	yyspecial_routines105: KL_SPECIAL_ROUTINES [detachable REDEFINE_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable REDEFINE_CLAUSE_AS]

	yyvs106: SPECIAL [detachable SELECT_CLAUSE_AS]
			-- Stack for semantic values of type detachable SELECT_CLAUSE_AS

	yyvsc106: INTEGER
			-- Capacity of semantic value stack `yyvs106'

	yyvsp106: INTEGER
			-- Top of semantic value stack `yyvs106'

	yyspecial_routines106: KL_SPECIAL_ROUTINES [detachable SELECT_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable SELECT_CLAUSE_AS]

	yyvs107: SPECIAL [detachable FORMAL_GENERIC_LIST_AS]
			-- Stack for semantic values of type detachable FORMAL_GENERIC_LIST_AS

	yyvsc107: INTEGER
			-- Capacity of semantic value stack `yyvs107'

	yyvsp107: INTEGER
			-- Top of semantic value stack `yyvs107'

	yyspecial_routines107: KL_SPECIAL_ROUTINES [detachable FORMAL_GENERIC_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable FORMAL_GENERIC_LIST_AS]

	yyvs108: SPECIAL [detachable CLASS_LIST_AS]
			-- Stack for semantic values of type detachable CLASS_LIST_AS

	yyvsc108: INTEGER
			-- Capacity of semantic value stack `yyvs108'

	yyvsp108: INTEGER
			-- Top of semantic value stack `yyvs108'

	yyspecial_routines108: KL_SPECIAL_ROUTINES [detachable CLASS_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable CLASS_LIST_AS]

	yyvs109: SPECIAL [detachable INDEXING_CLAUSE_AS]
			-- Stack for semantic values of type detachable INDEXING_CLAUSE_AS

	yyvsc109: INTEGER
			-- Capacity of semantic value stack `yyvs109'

	yyvsp109: INTEGER
			-- Top of semantic value stack `yyvs109'

	yyspecial_routines109: KL_SPECIAL_ROUTINES [detachable INDEXING_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable INDEXING_CLAUSE_AS]

	yyvs110: SPECIAL [detachable ITERATION_AS]
			-- Stack for semantic values of type detachable ITERATION_AS

	yyvsc110: INTEGER
			-- Capacity of semantic value stack `yyvs110'

	yyvsp110: INTEGER
			-- Top of semantic value stack `yyvs110'

	yyspecial_routines110: KL_SPECIAL_ROUTINES [detachable ITERATION_AS]
			-- Routines that ought to be in SPECIAL [detachable ITERATION_AS]

	yyvs111: SPECIAL [detachable EIFFEL_LIST [INSTRUCTION_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [INSTRUCTION_AS]

	yyvsc111: INTEGER
			-- Capacity of semantic value stack `yyvs111'

	yyvsp111: INTEGER
			-- Top of semantic value stack `yyvs111'

	yyspecial_routines111: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [INSTRUCTION_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [INSTRUCTION_AS]]

	yyvs112: SPECIAL [detachable EIFFEL_LIST [INTERVAL_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [INTERVAL_AS]

	yyvsc112: INTEGER
			-- Capacity of semantic value stack `yyvs112'

	yyvsp112: INTEGER
			-- Top of semantic value stack `yyvs112'

	yyspecial_routines112: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [INTERVAL_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [INTERVAL_AS]]

	yyvs113: SPECIAL [detachable EIFFEL_LIST [OPERAND_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [OPERAND_AS]

	yyvsc113: INTEGER
			-- Capacity of semantic value stack `yyvs113'

	yyvsp113: INTEGER
			-- Top of semantic value stack `yyvs113'

	yyspecial_routines113: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [OPERAND_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [OPERAND_AS]]

	yyvs114: SPECIAL [detachable DELAYED_ACTUAL_LIST_AS]
			-- Stack for semantic values of type detachable DELAYED_ACTUAL_LIST_AS

	yyvsc114: INTEGER
			-- Capacity of semantic value stack `yyvs114'

	yyvsp114: INTEGER
			-- Top of semantic value stack `yyvs114'

	yyspecial_routines114: KL_SPECIAL_ROUTINES [detachable DELAYED_ACTUAL_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable DELAYED_ACTUAL_LIST_AS]

	yyvs115: SPECIAL [detachable PARENT_LIST_AS]
			-- Stack for semantic values of type detachable PARENT_LIST_AS

	yyvsc115: INTEGER
			-- Capacity of semantic value stack `yyvs115'

	yyvsp115: INTEGER
			-- Top of semantic value stack `yyvs115'

	yyspecial_routines115: KL_SPECIAL_ROUTINES [detachable PARENT_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable PARENT_LIST_AS]

	yyvs116: SPECIAL [detachable EIFFEL_LIST [RENAME_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [RENAME_AS]

	yyvsc116: INTEGER
			-- Capacity of semantic value stack `yyvs116'

	yyvsp116: INTEGER
			-- Top of semantic value stack `yyvs116'

	yyspecial_routines116: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [RENAME_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [RENAME_AS]]

	yyvs117: SPECIAL [detachable RENAME_CLAUSE_AS]
			-- Stack for semantic values of type detachable RENAME_CLAUSE_AS

	yyvsc117: INTEGER
			-- Capacity of semantic value stack `yyvs117'

	yyvsp117: INTEGER
			-- Top of semantic value stack `yyvs117'

	yyspecial_routines117: KL_SPECIAL_ROUTINES [detachable RENAME_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [detachable RENAME_CLAUSE_AS]

	yyvs118: SPECIAL [detachable EIFFEL_LIST [STRING_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [STRING_AS]

	yyvsc118: INTEGER
			-- Capacity of semantic value stack `yyvs118'

	yyvsp118: INTEGER
			-- Top of semantic value stack `yyvs118'

	yyspecial_routines118: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [STRING_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [STRING_AS]]

	yyvs119: SPECIAL [detachable KEY_LIST_AS]
			-- Stack for semantic values of type detachable KEY_LIST_AS

	yyvsc119: INTEGER
			-- Capacity of semantic value stack `yyvs119'

	yyvsp119: INTEGER
			-- Top of semantic value stack `yyvs119'

	yyspecial_routines119: KL_SPECIAL_ROUTINES [detachable KEY_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable KEY_LIST_AS]

	yyvs120: SPECIAL [detachable EIFFEL_LIST [TAGGED_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [TAGGED_AS]

	yyvsc120: INTEGER
			-- Capacity of semantic value stack `yyvs120'

	yyvsp120: INTEGER
			-- Top of semantic value stack `yyvs120'

	yyspecial_routines120: KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [TAGGED_AS]]
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [TAGGED_AS]]

	yyvs121: SPECIAL [detachable TYPE_LIST_AS]
			-- Stack for semantic values of type detachable TYPE_LIST_AS

	yyvsc121: INTEGER
			-- Capacity of semantic value stack `yyvs121'

	yyvsp121: INTEGER
			-- Top of semantic value stack `yyvs121'

	yyspecial_routines121: KL_SPECIAL_ROUTINES [detachable TYPE_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable TYPE_LIST_AS]

	yyvs122: SPECIAL [detachable TYPE_DEC_LIST_AS]
			-- Stack for semantic values of type detachable TYPE_DEC_LIST_AS

	yyvsc122: INTEGER
			-- Capacity of semantic value stack `yyvs122'

	yyvsp122: INTEGER
			-- Top of semantic value stack `yyvs122'

	yyspecial_routines122: KL_SPECIAL_ROUTINES [detachable TYPE_DEC_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable TYPE_DEC_LIST_AS]

	yyvs123: SPECIAL [detachable LIST_DEC_LIST_AS]
			-- Stack for semantic values of type detachable LIST_DEC_LIST_AS

	yyvsc123: INTEGER
			-- Capacity of semantic value stack `yyvs123'

	yyvsp123: INTEGER
			-- Top of semantic value stack `yyvs123'

	yyspecial_routines123: KL_SPECIAL_ROUTINES [detachable LIST_DEC_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable LIST_DEC_LIST_AS]

	yyvs124: SPECIAL [detachable LOCAL_DEC_LIST_AS]
			-- Stack for semantic values of type detachable LOCAL_DEC_LIST_AS

	yyvsc124: INTEGER
			-- Capacity of semantic value stack `yyvs124'

	yyvsp124: INTEGER
			-- Top of semantic value stack `yyvs124'

	yyspecial_routines124: KL_SPECIAL_ROUTINES [detachable LOCAL_DEC_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable LOCAL_DEC_LIST_AS]

	yyvs125: SPECIAL [detachable FORMAL_ARGU_DEC_LIST_AS]
			-- Stack for semantic values of type detachable FORMAL_ARGU_DEC_LIST_AS

	yyvsc125: INTEGER
			-- Capacity of semantic value stack `yyvs125'

	yyvsp125: INTEGER
			-- Top of semantic value stack `yyvs125'

	yyspecial_routines125: KL_SPECIAL_ROUTINES [detachable FORMAL_ARGU_DEC_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable FORMAL_ARGU_DEC_LIST_AS]

	yyvs126: SPECIAL [detachable CONSTRAINT_TRIPLE]
			-- Stack for semantic values of type detachable CONSTRAINT_TRIPLE

	yyvsc126: INTEGER
			-- Capacity of semantic value stack `yyvs126'

	yyvsp126: INTEGER
			-- Top of semantic value stack `yyvs126'

	yyspecial_routines126: KL_SPECIAL_ROUTINES [detachable CONSTRAINT_TRIPLE]
			-- Routines that ought to be in SPECIAL [detachable CONSTRAINT_TRIPLE]

	yyvs127: SPECIAL [detachable CONSTRAINT_LIST_AS]
			-- Stack for semantic values of type detachable CONSTRAINT_LIST_AS

	yyvsc127: INTEGER
			-- Capacity of semantic value stack `yyvs127'

	yyvsp127: INTEGER
			-- Top of semantic value stack `yyvs127'

	yyspecial_routines127: KL_SPECIAL_ROUTINES [detachable CONSTRAINT_LIST_AS]
			-- Routines that ought to be in SPECIAL [detachable CONSTRAINT_LIST_AS]

	yyvs128: SPECIAL [detachable CONSTRAINING_TYPE_AS]
			-- Stack for semantic values of type detachable CONSTRAINING_TYPE_AS

	yyvsc128: INTEGER
			-- Capacity of semantic value stack `yyvs128'

	yyvsp128: INTEGER
			-- Top of semantic value stack `yyvs128'

	yyspecial_routines128: KL_SPECIAL_ROUTINES [detachable CONSTRAINING_TYPE_AS]
			-- Routines that ought to be in SPECIAL [detachable CONSTRAINING_TYPE_AS]

feature {NONE} -- Constants

	yyFinal: INTEGER = 1224
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 139
			-- Number of tokens

	yyLast: INTEGER = 4884
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 393
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 390
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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

end -- class EIFFEL_PARSER

