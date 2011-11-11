note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "It is dangerous to be right when the government is wrong. - Voltaire"

deferred class
	STANDARD_CURVES

inherit
	EC_CONSTANTS

feature -- SEC p112r1
	sec_p112r1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("0000DB7C 2ABF62E3 5E668076 BEAD208B")
		end

	sec_p112r1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("0000DB7C 2ABF62E3 5E7628DF AC6561C5")
		end

	sec_p112r1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("0000DB7C 2ABF62E3 5E668076 BEAD2088")
		end

	sec_p112r1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("0000659E F8BA0439 16EEDE89 11702B22")
		end

	sec_p112r1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("00000948 7239995A 5EE76B55 F9C2F098")
		end

	sec_p112r1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("0000A89C E5AF8724 C0A23E0E 0FF77500")
		end

	sec_p112r1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p112r2
	sec_p112r2_p: INTEGER_X
		do
			create Result.make_from_hex_string ("0000DB7C 2ABF62E3 5E668076 BEAD208B")
		end

	sec_p112r2_r: INTEGER_X
		do
			create Result.make_from_hex_string ("000036DF 0AAFD8B8 D7597CA1 0520D04B")
		end

	sec_p112r2_a: INTEGER_X
		do
			create Result.make_from_hex_string ("00006127 C24C05F3 8A0AAAF6 5C0EF02C")
		end

	sec_p112r2_b: INTEGER_X
		do
			create Result.make_from_hex_string ("000051DE F1815DB5 ED74FCC3 4C85D709")
		end

	sec_p112r2_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("00004BA3 0AB5E892 B4E1649D D0928643")
		end

	sec_p112r2_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("0000ADCD 46F5882E 3747DEF3 6E956E97")
		end

	sec_p112r2_h: INTEGER_X
		do
			result := four
		end

feature -- SEC p128r1
	sec_p128r1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFD FFFFFFFF FFFFFFFF FFFFFFFF")
		end

	sec_p128r1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFE 00000000 75A30D1B 9038A115")
		end

	sec_p128r1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFD FFFFFFFF FFFFFFFF FFFFFFFC")
		end

	sec_p128r1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("E87579C1 1079F43D D824993C 2CEE5ED3")
		end

	sec_p128r1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("161FF752 8B899B2D 0C28607C A52C5B86")
		end

	sec_p128r1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("CF5AC839 5BAFEB13 C02DA292 DDED7A83")
		end

	sec_p128r1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p128r2
	sec_p128r2_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFD FFFFFFFF FFFFFFFF FFFFFFFF")
		end

	sec_p128r2_r: INTEGER_X
		do
			create Result.make_from_hex_string ("3FFFFFFF 7FFFFFFF BE002472 0613B5A3")
		end

	sec_p128r2_a: INTEGER_X
		do
			create Result.make_from_hex_string ("D6031998 D1B3BBFE BF59CC9B BFF9AEE1")
		end

	sec_p128r2_b: INTEGER_X
		do
			create Result.make_from_hex_string ("5EEEFCA3 80D02919 DC2C6558 BB6D8A5D")
		end

	sec_p128r2_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("7B6AA5D8 5E572983 E6FB32A7 CDEBC140")
		end

	sec_p128r2_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("27B6916A 894D3AEE 7106FE80 5FC34B44")
		end

	sec_p128r2_h: INTEGER_X
		do
			result := four
		end

feature -- SEC p160k1
	sec_p160k1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE FFFFAC73")
		end

	sec_p160k1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("01 00000000 00000000 0001B8FA 16DFAB9A CA16B6B3")
		end

	sec_p160k1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000")
		end

	sec_p160k1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000007")
		end

	sec_p160k1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("3B4C382C E37AA192 A4019E76 3036F4F5 DD4D7EBB")
		end

	sec_p160k1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("938CF935 318FDCED 6BC28286 531733C3 F03C4FEE")
		end

	sec_p160k1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p160r1
	sec_p160r1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF 7FFFFFFF")
		end

	sec_p160r1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("01 00000000 00000000 0001F4C8 F927AED3 CA752257")
		end

	sec_p160r1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF 7FFFFFFC")
		end

	sec_p160r1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("1C97BEFC 54BD7A8B 65ACF89F 81D4D4AD C565FA45")
		end

	sec_p160r1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("4A96B568 8EF57328 46646989 68C38BB9 13CBFC82")
		end

	sec_p160r1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("23A62855 3168947D 59DCC912 04235137 7AC5FB32")
		end

	sec_p160r1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p160r2
	sec_p160r2_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE FFFFAC73")
		end

	sec_p160r2_r: INTEGER_X
		do
			create Result.make_from_hex_string ("01 00000000 00000000 0000351E E786A818 F3A1A16B")
		end

	sec_p160r2_a: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE FFFFAC70")
		end

	sec_p160r2_b: INTEGER_X
		do
			create Result.make_from_hex_string ("B4E134D3 FB59EB8B AB572749 04664D5A F50388BA")
		end

	sec_p160r2_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("52DCB034 293A117E 1F4FF11B 30F7199D 3144CE6D")
		end

	sec_p160r2_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("FEAFFEF2 E331F296 E071FA0D F9982CFE A7D43F2E")
		end

	sec_p160r2_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p192k1
	sec_p192k1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE FFFFEE37")
		end

	sec_p192k1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFE 26F2FC17 0F69466A 74DEFD8D")
		end

	sec_p192k1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000")
		end

	sec_p192k1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000003")
		end

	sec_p192k1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("DB4FF10E C057E9AE 26B07D02 80B7F434 1DA5D1B1 EAE06C7D")
		end

	sec_p192k1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("9B2F2F6D 9C5628A7 844163D0 15BE8634 4082AA88 D95E2F9D")
		end

	sec_p192k1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p192r1
	sec_p192r1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE FFFFFFFF FFFFFFFF")
		end

	sec_p192r1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF 99DEF836 146BC9B1 B4D22831")
		end

	sec_p192r1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE FFFFFFFF FFFFFFFC")
		end

	sec_p192r1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("64210519 E59C80E7 0FA7E9AB 72243049 FEB8DEEC C146B9B1")
		end

	sec_p192r1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("188DA80E B03090F6 7CBF20EB 43A18800 F4FF0AFD 82FF1012")
		end

	sec_p192r1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("07192B95 FFC8DA78 631011ED 6B24CDD5 73F977A1 1E794811")
		end

	sec_p192r1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p224k1
	sec_p224k1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE FFFFE56D")
		end

	sec_p224k1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("01 00000000 00000000 00000000 0001DCE8 D2EC6184 CAF0A971 769FB1F7")
		end

	sec_p224k1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000")
		end

	sec_p224k1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000005")
		end

	sec_p224k1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("A1455B33 4DF099DF 30FC28A1 69A467E9 E47075A9 0F7E650E B6B7A45C")
		end

	sec_p224k1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("7E089FED 7FBA3442 82CAFBD6 F7E319F7 C0B0BD59 E2CA4BDB 556D61A5")
		end

	sec_p224k1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p224r1
	sec_p224r1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF 00000000 00000000 00000001")
		end

	sec_p224r1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFF16A2 E0B8F03E 13DD2945 5C5C2A3D")
		end

	sec_p224r1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE FFFFFFFF FFFFFFFF FFFFFFFE")
		end

	sec_p224r1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("B4050A85 0C04B3AB F5413256 5044B0B7 D7BFD8BA 270B3943 2355FFB4")
		end

	sec_p224r1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("B70E0CBD 6BB4BF7F 321390B9 4A03C1D3 56C21122 343280D6 115C1D21")
		end

	sec_p224r1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("BD376388 B5F723FB 4C22DFE6 CD4375A0 5A074764 44D58199 85007E34")
		end

	sec_p224r1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p256k1
	sec_p256k1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE FFFFFC2F")
		end

	sec_p256k1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE BAAEDCE6 AF48A03B BFD25E8C D0364141")
		end

	sec_p256k1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000")
		end

	sec_p256k1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000007")
		end

	sec_p256k1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("79BE667E F9DCBBAC 55A06295 CE870B07 029BFCDB 2DCE28D9 59F2815B 16F81798")
		end

	sec_p256k1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("483ADA77 26A3C465 5DA4FBFC 0E1108A8 FD17B448 A6855419 9C47D08F FB10D4B8")
		end

	sec_p256k1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p256r1
	sec_p256r1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF 00000001 00000000 00000000 00000000 FFFFFFFF FFFFFFFF FFFFFFFF")
		end

	sec_p256r1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF 00000000 FFFFFFFF FFFFFFFF BCE6FAAD A7179E84 F3B9CAC2 FC632551")
		end

	sec_p256r1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF 00000001 00000000 00000000 00000000 FFFFFFFF FFFFFFFF FFFFFFFC")
		end

	sec_p256r1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("5AC635D8 AA3A93E7 B3EBBD55 769886BC 651D06B0 CC53B0F6 3BCE3C3E 27D2604B")
		end

	sec_p256r1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("6B17D1F2 E12C4247 F8BCE6E5 63A440F2 77037D81 2DEB33A0 F4A13945 D898C296")
		end

	sec_p256r1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("4FE342E2 FE1A7F9B 8EE7EB4A 7C0F9E16 2BCE3357 6B315ECE CBB64068 37BF51F5")
		end

	sec_p256r1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p384r1
	sec_p384r1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE FFFFFFFF 00000000 00000000 FFFFFFFF")
		end

	sec_p384r1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF C7634D81 F4372DDF 581A0DB2 48B0A77A ECEC196A CCC52973")
		end

	sec_p384r1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE FFFFFFFF 00000000 00000000 FFFFFFFC")
		end

	sec_p384r1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("B3312FA7 E23EE7E4 988E056B E3F82D19 181D9C6E FE814112 0314088F 5013875A C656398D 8A2ED19D 2A85C8ED D3EC2AEF")
		end

	sec_p384r1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("AA87CA22 BE8B0537 8EB1C71E F320AD74 6E1D3B62 8BA79B98 59F741E0 82542A38 5502F25D BF55296C 3A545E38 72760AB7")
		end

	sec_p384r1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("3617DE4A 96262C6F 5D9E98BF 9292DC29 F8F41DBD 289A147C E9DA3113 B5F0B8C0 0A60B1CE 1D7E819D 7A431D7C 90EA0E5F")
		end

	sec_p384r1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC p521r1
	sec_p521r1_p: INTEGER_X
		do
			create Result.make_from_hex_string ("000001FF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF")
		end

	sec_p521r1_r: INTEGER_X
		do
			create Result.make_from_hex_string ("000001FF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFA 51868783 BF2F966B 7FCC0148 F709A5D0 3BB5C9B8 899C47AE BB6FB71E 91386409")
		end

	sec_p521r1_a: INTEGER_X
		do
			create Result.make_from_hex_string ("000001FF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFC")
		end

	sec_p521r1_b: INTEGER_X
		do
			create Result.make_from_hex_string ("00000051 953EB961 8E1C9A1F 929A21A0 B68540EE A2DA725B 99B315F3 B8B48991 8EF109E1 56194951 EC7A937B 1652C0BD 3BB1BF07 3573DF88 3D2C34F1 EF451FD4 6B503F00")
		end

	sec_p521r1_gx: INTEGER_X
		do
			create Result.make_from_hex_string ("000000C6 858E06B7 0404E9CD 9E3ECB66 2395B442 9C648139 053FB521 F828AF60 6B4D3DBA A14B5E77 EFE75928 FE1DC127 A2FFA8DE 3348B3C1 856A429B F97E7E31 C2E5BD66")
		end

	sec_p521r1_gy: INTEGER_X
		do
			create Result.make_from_hex_string ("00000118 39296A78 9A3BC004 5C8A5FB4 2C7D1BD9 98F54449 579B4468 17AFBD17 273E662C 97EE7299 5EF42640 C550B901 3FAD0761 353C7086 A272C240 88BE9476 9FD16650")
		end

	sec_p521r1_h: INTEGER_X
		do
			result := one
		end

feature -- SEC t113r1
	sec_t113r1_m: INTEGER_32 = 113

	sec_t113r1_k1: INTEGER_32 = 9

	sec_t113r1_k2: INTEGER_32 = 0

	sec_t113r1_k3: INTEGER_32 = 0

	sec_t113r1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00003088 250CA6E7 C7FE649C E85820F7")
		end

	sec_t113r1_b: INTEGER_X
		do
			create result.make_from_hex_string ("0000E8BE E4D3E226 0744188B E0E9C723")
		end

	sec_t113r1_r: INTEGER_X
		do
			create result.make_from_hex_string ("00010000 00000000 00D9CCEC 8A39E56F")
		end

	sec_t113r1_h: INTEGER_X
		do
			result := two
		end

	sec_t113r1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("00009D73 616F35F4 AB1407D7 3562C10F")
		end

	sec_t113r1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("0000A528 30277958 EE84D131 5ED31886")
		end

feature -- SEC t113r2
	sec_t113r2_m: INTEGER_32 = 113

	sec_t113r2_k1: INTEGER_32 = 9

	sec_t113r2_k2: INTEGER_32 = 0

	sec_t113r2_k3: INTEGER_32 = 0

	sec_t113r2_a: INTEGER_X
		do
			create result.make_from_hex_string ("00006899 18DBEC7E 5A0DD6DF C0AA55C7")
		end

	sec_t113r2_b: INTEGER_X
		do
			create result.make_from_hex_string ("000095E9 A9EC9B29 7BD4BF36 E059184F")
		end

	sec_t113r2_r: INTEGER_X
		do
			create result.make_from_hex_string ("00010000 00000000 0108789B 2496AF93")
		end

	sec_t113r2_h: INTEGER_X
		do
			result := two
		end

	sec_t113r2_gx: INTEGER_X
		do
			create result.make_from_hex_string ("0001A57A 6A7B26CA 5EF52FCD B8164797")
		end

	sec_t113r2_gy: INTEGER_X
		do
			create result.make_from_hex_string ("0000B3AD C94ED1FE 674C06E6 95BABA1D")
		end

feature -- SEC t131r1
	sec_t131r1_m: INTEGER_32 = 131

	sec_t131r1_k1: INTEGER_32 = 2

	sec_t131r1_k2: INTEGER_32 = 3

	sec_t131r1_k3: INTEGER_32 = 8

	sec_t131r1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000007 A11B09A7 6B562144 418FF3FF 8C2570B8")
		end

	sec_t131r1_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000002 17C05610 884B63B9 C6C72916 78F9D341")
		end

	sec_t131r1_r: INTEGER_X
		do
			create result.make_from_hex_string ("00000004 00000000 00000002 3123953A 9464B54D")
		end

	sec_t131r1_h: INTEGER_X
		do
			result := two
		end

	sec_t131r1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 81BAF91F DF9833C4 0F9C1813 43638399")
		end

	sec_t131r1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("00000007 8C6E7EA3 8C001F73 C8134B1B 4EF9E150")
		end

feature -- SEC t131r2
	sec_t131r2_m: INTEGER_32 = 131

	sec_t131r2_k1: INTEGER_32 = 2

	sec_t131r2_k2: INTEGER_32 = 3

	sec_t131r2_k3: INTEGER_32 = 8

	sec_t131r2_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000003 E5A88919 D7CAFCBF 415F07C2 176573B2")
		end

	sec_t131r2_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000004 B8266A46 C55657AC 734CE38F 018F2192")
		end

	sec_t131r2_r: INTEGER_X
		do
			create result.make_from_hex_string ("00000004 00000000 00000001 6954A233 049BA98F")
		end

	sec_t131r2_h: INTEGER_X
		do
			result := two
		end

	sec_t131r2_gx: INTEGER_X
		do
			create result.make_from_hex_string ("00000003 56DCD8F2 F95031AD 652D2395 1BB366A8")
		end

	sec_t131r2_gy: INTEGER_X
		do
			create result.make_from_hex_string ("00000006 48F06D86 7940A536 6D9E265D E9EB240F")
		end

feature --SEC t163k1
	sec_t163k1_m: INTEGER_32 = 163

	sec_t163k1_k1: INTEGER_32 = 3

	sec_t163k1_k2: INTEGER_32 = 6

	sec_t163k1_k3: INTEGER_32 = 7

	sec_t163k1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t163k1_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t163k1_r: INTEGER_X
		do
			create result.make_from_hex_string ("00000004 00000000 00000000 00020108 A2E0CC0D 99F8A5EF")
		end

	sec_t163k1_h: INTEGER_X
		do
			result := two
		end

	sec_t163k1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("00000002 FE13C053 7BBC11AC AA07D793 DE4E6D5E 5C94EEE8")
		end

	sec_t163k1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("00000002 89070FB0 5D38FF58 321F2E80 0536D538 CCDAA3D9")
		end

feature --SEC t163r1
	sec_t163r1_m: INTEGER_32 = 163

	sec_t163r1_k1: INTEGER_32 = 3

	sec_t163r1_k2: INTEGER_32 = 6

	sec_t163r1_k3: INTEGER_32 = 7

	sec_t163r1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000007 B6882CAA EFA84F95 54FF8428 BD88E246 D2782AE2")
		end

	sec_t163r1_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000007 13612DCD DCB40AAB 946BDA29 CA91F73A F958AFD9")
		end

	sec_t163r1_r: INTEGER_X
		do
			create result.make_from_hex_string ("00000003 FFFFFFFF FFFFFFFF FFFF48AA B689C29C A710279B")
		end

	sec_t163r1_h: INTEGER_X
		do
			result := two
		end

	sec_t163r1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("00000003 69979697 AB438977 89566789 567F787A 7876A654")
		end

	sec_t163r1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 435EDB42 EFAFB298 9D51FEFC E3C80988 F41FF883")
		end

feature --SEC t163r2
	sec_t163r2_m: INTEGER_32 = 163

	sec_t163r2_k1: INTEGER_32 = 3

	sec_t163r2_k2: INTEGER_32 = 6

	sec_t163r2_k3: INTEGER_32 = 7

	sec_t163r2_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t163r2_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000002 0A601907 B8C953CA 1481EB10 512F7874 4A3205FD")
		end

	sec_t163r2_r: INTEGER_X
		do
			create result.make_from_hex_string ("00000004 00000000 00000000 000292FE 77E70C12 A4234C33")
		end

	sec_t163r2_h: INTEGER_X
		do
			result := two
		end

	sec_t163r2_gx: INTEGER_X
		do
			create result.make_from_hex_string ("00000003 F0EBA162 86A2D57E A0991168 D4994637 E8343E36")
		end

	sec_t163r2_gy: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 D51FBC6C 71A0094F A2CDD545 B11C5C0C 797324F1")
		end

feature --SEC t193r1
	sec_t193r1_m: INTEGER_32 = 193

	sec_t193r1_k1: INTEGER_32 = 15

	sec_t193r1_k2: INTEGER_32 = 0

	sec_t193r1_k3: INTEGER_32 = 0

	sec_t193r1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 17858FEB 7A989751 69E171F7 7B4087DE 098AC8A9 11DF7B01")
		end

	sec_t193r1_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 FDFB49BF E6C3A89F ACADAA7A 1E5BBC7C C1C2E5D8 31478814")
		end

	sec_t193r1_r: INTEGER_X
		do
			create result.make_from_hex_string ("00000001 00000000 00000000 00000000 C7F34A77 8F443ACC 920EBA49")
		end

	sec_t193r1_h: INTEGER_X
		do
			result := two
		end

	sec_t193r1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("00000001 F481BC5F 0FF84A74 AD6CDF6F DEF4BF61 79625372 D8C0C5E1")
		end

	sec_t193r1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 25E399F2 903712CC F3EA9E3A 1AD17FB0 B3201B6A F7CE1B05")
		end

feature --SEC t193r2
	sec_t193r2_m: INTEGER_32 = 193

	sec_t193r2_k1: INTEGER_32 = 15

	sec_t193r2_k2: INTEGER_32 = 0

	sec_t193r2_k3: INTEGER_32 = 0

	sec_t193r2_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000001 63F35A51 37C2CE3E A6ED8667 190B0BC4 3ECD6997 7702709B")
		end

	sec_t193r2_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 C9BB9E89 27D4D64C 377E2AB2 856A5B16 E3EFB7F6 1D4316AE")
		end

	sec_t193r2_r: INTEGER_X
		do
			create result.make_from_hex_string ("00000001 00000000 00000000 00000001 5AAB561B 005413CC D4EE99D5")
		end

	sec_t193r2_h: INTEGER_X
		do
			result := two
		end

	sec_t193r2_gx: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 D9B67D19 2E0367C8 03F39E1A 7E82CA14 A651350A AE617E8F")
		end

	sec_t193r2_gy: INTEGER_X
		do
			create result.make_from_hex_string ("00000001 CE943356 07C304AC 29E7DEFB D9CA01F5 96F92722 4CDECF6C")
		end

feature --SEC t233k1
	sec_t233k1_m: INTEGER_32 = 233

	sec_t233k1_k1: INTEGER_32 = 74

	sec_t233k1_k2: INTEGER_32 = 0

	sec_t233k1_k3: INTEGER_32 = 0

	sec_t233k1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000")
		end

	sec_t233k1_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t233k1_r: INTEGER_X
		do
			create result.make_from_hex_string ("00000080 00000000 00000000 00000000 00069D5B B915BCD4 6EFB1AD5 F173ABDF")
		end

	sec_t233k1_h: INTEGER_X
		do
			result := two
		end

	sec_t233k1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("00000172 32BA853A 7E731AF1 29F22FF4 149563A4 19C26BF5 0A4C9D6E EFAD6126")
		end

	sec_t233k1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("0000001D B537DECE 819B7F70 F555A67C 427A8CD9 BF18AEB9 B56E0C11 056FAE6A3")
		end

feature --SEC t233r1
	sec_t233r1_m: INTEGER_32 = 233

	sec_t233r1_k1: INTEGER_32 = 74

	sec_t233r1_k2: INTEGER_32 = 0

	sec_t233r1_k3: INTEGER_32 = 0

	sec_t233r1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t233r1_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000066 647EDE6C 332C7F8C 0923BB58 213B333B 20E9CE42 81FE115F 7D8F90AD")
		end

	sec_t233r1_r: INTEGER_X
		do
			create result.make_from_hex_string ("00000100 00000000 00000000 00000000 0013E974 E72F8A69 22031D26 03CFE0D7")
		end

	sec_t233r1_h: INTEGER_X
		do
			result := two
		end

	sec_t233r1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("000000FA C9DFCBAC 8313BB21 39F1BB75 5FEF65BC 391F8B36 F8F8EB73 71FD558B")
		end

	sec_t233r1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("00000100 6A08A419 03350678 E58528BE BF8A0BEF F867A7CA 36716F7E 01F81052")
		end

feature --SEC t239k1
	sec_t239k1_m: INTEGER_32 = 239

	sec_t239k1_k1: INTEGER_32 = 158

	sec_t239k1_k2: INTEGER_32 = 0

	sec_t239k1_k3: INTEGER_32 = 0

	sec_t239k1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000")
		end

	sec_t239k1_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t239k1_r: INTEGER_X
		do
			create result.make_from_hex_string ("00002000 00000000 00000000 00000000 005A79FE C67CB6E9 1F1C1DA8 00E478A5")
		end

	sec_t239k1_h: INTEGER_X
		do
			result := two
		end

	sec_t239k1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("000029A0 B6A887A9 83E97309 88A68727 A8B2D126 C44CC2CC 7B2A6555 193035DC")
		end

	sec_t239k1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("00007631 0804F12E 549BDB01 1C103089 E73510AC B275FC31 2A5DC6B7 6553F0CA")
		end

feature --SEC t283k1
	sec_t283k1_m: INTEGER_32 = 283

	sec_t283k1_k1: INTEGER_32 = 5

	sec_t283k1_k2: INTEGER_32 = 7

	sec_t283k1_k3: INTEGER_32 = 12

	sec_t283k1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000")
		end

	sec_t283k1_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t283k1_r: INTEGER_X
		do
			create result.make_from_hex_string ("01FFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFE9AE 2ED07577 265DFF7F 94451E06 1E163C61")
		end

	sec_t283k1_h: INTEGER_X
		do
			result := two
		end

	sec_t283k1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("0503213F 78CA4488 3F1A3B81 62F188E5 53CD265F 23C1567A 16876913 B0C2AC24 58492836")
		end

	sec_t283k1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("01CCDA38 0F1C9E31 8D90F95D 07E5426F E87E45C0 E8184698 E4596236 4E341161 77DD2259")
		end

feature --SEC t283r1
	sec_t283r1_m: INTEGER_32 = 283

	sec_t283r1_k1: INTEGER_32 = 5

	sec_t283r1_k2: INTEGER_32 = 7

	sec_t283r1_k3: INTEGER_32 = 12

	sec_t283r1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t283r1_b: INTEGER_X
		do
			create result.make_from_hex_string ("027B680A C8B8596D A5A4AF8A 19A0303F CA97FD76 45309FA2 A581485A F6263E31 3B79A2F5")
		end

	sec_t283r1_r: INTEGER_X
		do
			create result.make_from_hex_string ("03FFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFEF90 399660FC 938A9016 5B042A7C EFADB307")
		end

	sec_t283r1_h: INTEGER_X
		do
			result := two
		end

	sec_t283r1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("05F93925 8DB7DD90 E1934F8C 70B0DFEC 2EED25B8 557EAC9C 80E2E198 F8CDBECD 86B12053")
		end

	sec_t283r1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("03676854 FE24141C B98FE6D4 B20D02B4 516FF702 350EDDB0 826779C8 13F0DF45 BE8112F4")
		end

feature --SEC t409k1
	sec_t409k1_m: INTEGER_32 = 409

	sec_t409k1_k1: INTEGER_32 = 87

	sec_t409k1_k2: INTEGER_32 = 0

	sec_t409k1_k3: INTEGER_32 = 0

	sec_t409k1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000")
		end

	sec_t409k1_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t409k1_r: INTEGER_X
		do
			create result.make_from_hex_string ("007FFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFE5F 83B2D4EA 20400EC4 557D5ED3 E3E7CA5B 4B5C83B8 E01E5FCF")
		end

	sec_t409k1_h: INTEGER_X
		do
			result := two
		end

	sec_t409k1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("0060F05F 658F49C1 AD3AB189 0F718421 0EFD0987 E307C84C 27ACCFB8 F9F67CC2 C460189E B5AAAA62 EE222EB1 B35540CF E9023746")
		end

	sec_t409k1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("01E36905 0B7C4E42 ACBA1DAC BF04299C 3460782F 918EA427 E6325165 E9EA10E3 DA5F6C42 E9C55215 AA9CA27A 5863EC48 D8E0286B")
		end

feature --SEC t409r1
	sec_t409r1_m: INTEGER_32 = 409

	sec_t409r1_k1: INTEGER_32 = 87

	sec_t409r1_k2: INTEGER_32 = 0

	sec_t409r1_k3: INTEGER_32 = 0

	sec_t409r1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t409r1_b: INTEGER_X
		do
			create result.make_from_hex_string ("0021A5C2 C8EE9FEB 5C4B9A75 3B7B476B 7FD6422E F1F3DD67 4761FA99 D6AC27C8 A9A197B2 72822F6C D57A55AA 4F50AE31 7B13545F")
		end

	sec_t409r1_r: INTEGER_X
		do
			create result.make_from_hex_string ("01000000 00000000 00000000 00000000 00000000 00000000 000001E2 AAD6A612 F33307BE 5FA47C3C 9E052F83 8164CD37 D9A21173")
		end

	sec_t409r1_h: INTEGER_X
		do
			result := two
		end

	sec_t409r1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("015D4860 D088DDB3 496B0C60 64756260 441CDE4A F1771D4D B01FFE5B 34E59703 DC255A86 8A118051 5603AEAB 60794E54 BB7996A7")
		end

	sec_t409r1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("0061B1CF AB6BE5F3 2BBFA783 24ED106A 7636B9C5 A7BD198D 0158AA4F 5488D08F 38514F1F DF4B4F40 D2181B36 81C364BA 0273C706")
		end

feature --SEC t571k1
	sec_t571k1_m: INTEGER_32 = 571

	sec_t571k1_k1: INTEGER_32 = 2

	sec_t571k1_k2: INTEGER_32 = 5

	sec_t571k1_k3: INTEGER_32 = 10

	sec_t571k1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000")
		end

	sec_t571k1_b: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t571k1_r: INTEGER_X
		do
			create result.make_from_hex_string ("02000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 131850E1 F19A63E4 B391A8DB 917F4138 B630D84B E5D63938 1E91DEB4 5CFE778F 637C1001")
		end

	sec_t571k1_h: INTEGER_X
		do
			result := two
		end

	sec_t571k1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("026EB7A8 59923FBC 82189631 F8103FE4 AC9CA297 0012D5D4 60248048 01841CA4 43709584 93B205E6 47DA304D B4CEB08C BBD1BA39 494776FB 988B4717 4DCA88C7 E2945283 A01C8972")
		end

	sec_t571k1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("0349DC80 7F4FBF37 4F4AEADE 3BCA9531 4DD58CEC 9F307A54 FFC61EFC 006D8A2C 9D4979C0 AC44AEA7 4FBEBBB9 F772AEDC B620B01A 7BA7AF1B 320430C8 591984F6 01CD4C14 3EF1C7A3")
		end

feature --SEC t571r1
	sec_t571r1_m: INTEGER_32 = 571

	sec_t571r1_k1: INTEGER_32 = 2

	sec_t571r1_k2: INTEGER_32 = 5

	sec_t571r1_k3: INTEGER_32 = 10

	sec_t571r1_a: INTEGER_X
		do
			create result.make_from_hex_string ("00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001")
		end

	sec_t571r1_b: INTEGER_X
		do
			create result.make_from_hex_string ("02F40E7E 2221F295 DE297117 B7F3D62F 5C6A97FF CB8CEFF1 CD6BA8CE 4A9A18AD 84FFABBD 8EFA5933 2BE7AD67 56A66E29 4AFD185A 78FF12AA 520E4DE7 39BACA0C 7FFEFF7F 2955727A")
		end

	sec_t571r1_r: INTEGER_X
		do
			create result.make_from_hex_string ("03FFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF E661CE18 FF559873 08059B18 6823851E C7DD9CA1 161DE93D 5174D66E 8382E9BB 2FE84E47")
		end

	sec_t571r1_h: INTEGER_X
		do
			result := two
		end

	sec_t571r1_gx: INTEGER_X
		do
			create result.make_from_hex_string ("0303001D 34B85629 6C16C0D4 0D3CD775 0A93D1D2 955FA80A A5F40FC8 DB7B2ABD BDE53950 F4C0D293 CDD711A3 5B67FB14 99AE6003 8614F139 4ABFA3B4 C850D927 E1E7769C 8EEC2D19")
		end

	sec_t571r1_gy: INTEGER_X
		do
			create result.make_from_hex_string ("037BF273 42DA639B 6DCCFFFE B73D69D7 8C6C27A6 009CBBCA 1980F853 3921E8A6 84423E43 BAB08A57 6291AF8F 461BB2A8 B3531D2F 0485C19B 16E2F151 6E23DD3C 1A4827AF 1B8AC15B")
		end

--SEC uses different names than FIPS
--FIPS p is called q
--FIPS s is called seed and is the input to the SHA-1 hash algorithm
--FIPS c is the output of the SHA-1 hash algorithm
--FIPS a is lcrypto_q - lcrypto_a
--FIPS Gx is x
--FIPS Gy is y
--FIPS f, which is always 1, is h
--FIPS r is n

feature -- FIPS P-192
	p192_p: INTEGER_X
		do
			create result.make_from_hex_string ("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFF")
		end

	p192_r: INTEGER_X
		do
			create result.make_from_hex_string ("FFFFFFFFFFFFFFFFFFFFFFFF99DEF836146BC9B1B4D22831")
		end

	p192_a: INTEGER_X
		do
			create result.make_from_hex_string ("fffffffffffffffffffffffffffffffefffffffffffffffc")
		end

	p192_b: INTEGER_X
		do
			create result.make_from_hex_string ("64210519e59c80e70fa7e9ab72243049feb8deecc146b9b1")
		end

	p192_gx: INTEGER_X
		do
			create result.make_from_hex_string ("188da80eb03090f67cbf20eb43a18800f4ff0afd82ff1012")
		end

	p192_gy: INTEGER_X
		do
			create result.make_from_hex_string ("07192b95ffc8da78631011ed6b24cdd573f977a11e794811")
		end

	p192_h: INTEGER_X
		do
			result := one
		end

feature -- FIPS P-224
	p224_p: INTEGER_X
		do
			create result.make_from_hex_string ("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000001")
		end

	p224_r: INTEGER_X
		do
			create result.make_from_hex_string ("FFFFFFFFFFFFFFFFFFFFFFFFFFFF16A2E0B8F03E13DD29455C5C2A3D")
		end

	p224_a: INTEGER_X
		do
			create result.make_from_hex_string ("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFE")
		end

	p224_b: INTEGER_X
		do
			create result.make_from_hex_string ("b4050a850c04b3abf54132565044b0b7d7bfd8ba270b39432355ffb4")
		end

	p224_gx: INTEGER_X
		do
			create result.make_from_hex_string ("b70e0cbd6bb4bf7f321390b94a03c1d356c21122343280d6115c1d21")
		end

	p224_gy: INTEGER_X
		do
			create result.make_from_hex_string ("bd376388b5f723fb4c22dfe6cd4375a05a07476444d5819985007e34")
		end

	p224_h: INTEGER_X
		do
			result := one
		end

feature -- FIPS P-256
	p256_p: INTEGER_X
		do
			create result.make_from_hex_string ("FFFFFFFF00000001000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF")
		end

	p256_r: INTEGER_X
		do
			create result.make_from_hex_string ("ffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551")
		end

	p256_a: INTEGER_X
		do
			create result.make_from_hex_string ("FFFFFFFF00000001000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFC")
		ensure
			result ~ (p256_p - create {INTEGER_X}.make_from_integer (3))
		end

	p256_b: INTEGER_X
		do
			create result.make_from_hex_string ("5ac635d8aa3a93e7b3ebbd55769886bc651d06b0cc53b0f63bce3c3e27d2604b")
		end

	p256_gx: INTEGER_X
		do
			create result.make_from_hex_string ("6b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c296")
		end

	p256_gy: INTEGER_X
		do
			create result.make_from_hex_string ("4fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5")
		end

	p256_h: INTEGER_X
		do
			result := one
		end

feature -- FIPS p-384
	p384_p: INTEGER_X
		do
			create result.make_from_hex_string ("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFF0000000000000000FFFFFFFF")
		end

	p384_r: INTEGER_X
		do
			create result.make_from_hex_string ("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7634D81F4372DDF581A0DB248B0A77AECEC196ACCC52973")
		end

	p384_a: INTEGER_X
		do
			create result.make_from_hex_string ("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFF0000000000000000FFFFFFFC")
		end

	p384_b: INTEGER_X
		do
			create result.make_from_hex_string ("B3312FA7E23EE7E4988E056BE3F82D19181D9C6EFE8141120314088F5013875AC656398D8A2ED19D2A85C8EDD3EC2AEF")
		end

	p384_gx: INTEGER_X
		do
			create result.make_from_hex_string ("AA87CA22BE8B05378EB1C71EF320AD746E1D3B628BA79B9859F741E082542A385502F25DBF55296C3A545E3872760AB7")
		end

	p384_gy: INTEGER_X
		do
			create result.make_from_hex_string ("3617DE4A96262C6F5D9E98BF9292DC29F8F41DBD289A147CE9DA3113B5F0B8C00A60B1CE1D7E819D7A431D7C90EA0E5F")
		end

	p384_h: INTEGER_X
		do
			result := one
		end

feature -- FIPS p-521
	p521_p: INTEGER_X
		do
			create result.make_from_string ("6864797660130609714981900799081393217269435300143305409394463459185543183397656052122559640661454554977296311391480858037121987999716643812574028291115057151")
		end

	p521_r: INTEGER_X
		do
			create result.make_from_hex_string ("01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA51868783BF2F966B7FCC0148F709A5D03BB5C9B8899C47AEBB6FB71E91386409")
		end

	p521_a: INTEGER_X
		do
			create result.make_from_string ("6864797660130609714981900799081393217269435300143305409394463459185543183397656052122559640661454554977296311391480858037121987999716643812574028291115057148")
		end

	p521_b: INTEGER_X
		do
			create result.make_from_hex_string ("051953eb9618e1c9a1f929a21a0b68540eea2da725b99b315f3b8b489918ef109e156193951ec7e937b1652c0bd3bb1bf073573df883d2c34f1ef451fd46b503f00")
		end

	p521_gx: INTEGER_X
		do
			create result.make_from_hex_string ("c6858e06b70404e9cd9e3ecb662395b4429c648139053fb521f828af606b4d3dbaa14b5e77efe75928fe1dc127a2ffa8de3348b3c1856a429bf97e7e31c2e5bd66")
		end

	p521_gy: INTEGER_X
		do
			create result.make_from_hex_string ("11839296a789a3bc0045c8a5fb42c7d1bd998f54449579b446817afbd17273e662c97ee72995ef42640c550b9013fad0761353c7086a272c24088be94769fd16650")
		end

	p521_h: INTEGER_X
		do
			result := one
		end

feature -- FIPS K-163
	k163_m: INTEGER = 163
	k163_k1: INTEGER = 3
	k163_k2: INTEGER = 6
	k163_k3: INTEGER = 7

	k163_a: INTEGER_X
		do
			result := one
		end

	k163_b: INTEGER_X
		do
			result := one
		end

	k163_r: INTEGER_X
		do
			create result.make_from_hex_string ("5846006549323611672814741753598448348329118574063")
		end

	k163_h: INTEGER_X
		do
			result := two
		end

	k163_gx: INTEGER_X
		do
			create result.make_from_hex_string ("00000002 FE13C053 7BBC11AC AA07D793 DE4E6D5E 5C94EEE8")
		end

	k163_gy: INTEGER_X
		do
			create result.make_from_hex_string ("00000002 89070FB0 5D38FF58 321F2E80 0536D538 CCDAA3D9")
		end

feature -- FIPS K-233
	k233_m: INTEGER = 233
	k233_k1: INTEGER = 0
	k233_k2: INTEGER = 0
	k233_k3: INTEGER = 71

	k233_a: INTEGER_X
		do
			result := zero
		end

	k233_b: INTEGER_X
		do
			result := one
		end

	k233_r: INTEGER_X
		do
			create result.make_from_hex_string ("8000000000000000000000000000069D5BB915BCD46EFB1AD5F173ABDF")
		end

	k233_h: INTEGER_X
		do
			result := four
		end

	k233_gx: INTEGER_X
		do
			create result.make_from_hex_string ("17232ba853a7e731af129f22ff4149563a419c26bf50a4c9d6eefad6126")
		end

	k233_gy: INTEGER_X
		do
			create result.make_from_hex_string ("1db537dece819b7f70f555a67c427a8cd9bf18aeb9b56e0c11056fae6a3")
		end

feature -- FIPS K-283
	k283_m: INTEGER = 283
	k283_k1: INTEGER = 5
	k283_k2: INTEGER = 7
	k283_k3: INTEGER = 12

	k283_a: INTEGER_X
		do
			result := zero
		end

	k283_b: INTEGER_X
		do
			result := one
		end

	k283_r: INTEGER_X
		do
			create result.make_from_hex_string ("01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9AE2ED07577265DFF7F94451E061E163C61")
		end

	k283_h: INTEGER_X
		do
			result := four
		end

	k283_gx: INTEGER_X
		do
			create result.make_from_hex_string ("503213f78ca44883f1a3b8162f188e553cd265f23c1567a16876913b0c2ac2458492836")
		end

	k283_gy: INTEGER_X
		do
			create result.make_from_hex_string ("1ccda380f1c9e318d90f95d07e5426fe87e45c0e8184698e45962364e34116177dd2259")
		end

feature -- FIPS K-409
	k409_m: INTEGER = 409
	k409_k1: INTEGER = 0
	k409_k2: INTEGER = 0
	k409_k3: INTEGER = 87

	k409_a: INTEGER_X
		do
			result := zero
		end

	k409_b: INTEGER_X
		do
			result := one
		end

	k409_r: INTEGER_X
		do
			create result.make_from_hex_string ("7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5F83B2D4EA20400EC4557D5ED3E3E7CA5B4B5C83B8E01E5FCF")
		end

	k409_h: INTEGER_X
		do
			result := four
		end

	k409_gx: INTEGER_X
		do
			create result.make_from_hex_string ("0060F05F658F49C1AD3AB1890F7184210EFD0987E307C84C27ACCFB8F9F67CC2C460189EB5AAAA62EE222EB1B35540CFE9023746")
		end

	k409_gy: INTEGER_X
		do
			create result.make_from_hex_string ("01E369050B7C4E42ACBA1DACBF04299C3460782F918EA427E6325165E9EA10E3DA5F6C42E9C55215AA9CA27A5863EC48D8E0286B")
		end

feature -- FIPS K-571
	k571_m: INTEGER = 571
	k571_k1: INTEGER = 2
	k571_k2: INTEGER = 5
	k571_k3: INTEGER = 10

	k571_a: INTEGER_X
		do
			result := zero
		end

	k571_b: INTEGER_X
		do
			result := one
		end

	k571_r: INTEGER_X
		do
			create result.make_from_hex_string ("020000000000000000000000000000000000000000000000000000000000000000000000131850E1F19A63E4B391A8DB917F4138B630D84BE5D639381E91DEB45CFE778F637C1001")
		end

	k571_h: INTEGER_X
		do
			result := four
		end

	k571_gx: INTEGER_X
		do
			create result.make_from_hex_string ("026EB7A859923FBC82189631F8103FE4AC9CA2970012D5D46024804801841CA44370958493B205E647DA304DB4CEB08CBBD1BA39494776FB988B47174DCA88C7E2945283A01C8972")
		end

	k571_gy: INTEGER_X
		do
			create result.make_from_hex_string ("0349DC807F4FBF374F4AEADE3BCA95314DD58CEC9F307A54FFC61EFC006D8A2C9D4979C0AC44AEA74FBEBBB9F772AEDCB620B01A7BA7AF1B320430C8591984F601CD4C143EF1C7A3")
		end

feature -- FIPS B-163
	b163_m: INTEGER = 163
	b163_k1: INTEGER = 3
	b163_k2: INTEGER = 6
	b163_k3: INTEGER = 7

	b163_a: INTEGER_X
		do
			result := one
		end

	b163_b: INTEGER_X
		do
			create result.make_from_hex_string ("020A601907B8C953CA1481EB10512F78744A3205FD")
		end

	b163_r: INTEGER_X
		do
			create result.make_from_hex_string ("040000000000000000000292FE77E70C12A4234C33")
		end

	b163_h: INTEGER_X
		do
			result := two
		end

	b163_gx: INTEGER_X
		do
			create result.make_from_hex_string ("03F0EBA16286A2D57EA0991168D4994637E8343E36")
		end

	b163_gy: INTEGER_X
		do
			create result.make_from_hex_string ("00D51FBC6C71A0094FA2CDD545B11C5C0C797324F1")
		end

feature -- FIPS B-233
	b233_m: INTEGER = 233
	b233_k1: INTEGER = 0
	b233_k2: INTEGER = 0
	b233_k3: INTEGER = 71

	b233_a: INTEGER_X
		do
			result := one
		end

	b233_b: INTEGER_X
		do
			create result.make_from_hex_string ("0066647EDE6C332C7F8C0923BB58213B333B20E9CE4281FE115F7D8F90AD")
		end

	b233_r: INTEGER_X
		do
			create result.make_from_hex_string ("01000000000000000000000000000013E974E72F8A6922031D2603CFE0D7")
		end

	b233_h: INTEGER_X
		do
			result := two
		end

	b233_gx: INTEGER_X
		do
			create result.make_from_hex_string ("00FAC9DFCBAC8313BB2139F1BB755FEF65BC391F8B36F8F8EB7371FD558B")
		end

	b233_gy: INTEGER_X
		do
			create result.make_from_hex_string ("01006A08A41903350678E58528BEBF8A0BEFF867A7CA36716F7E01F81052")
		end

feature -- FIPS B-283
	b283_m: INTEGER = 283
	b283_k1: INTEGER = 5
	b283_k2: INTEGER = 7
	b283_k3: INTEGER = 12

	b283_a: INTEGER_X
		do
			result := one
		end

	b283_b: INTEGER_X
		do
			result := one
		end

	b283_r: INTEGER_X
		do
			create result.make_from_hex_string ("03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF90399660FC938A90165B042A7CEFADB307")
		end

	b283_h: INTEGER_X
		do
			result := two
		end

	b283_gx: INTEGER_X
		do
			create result.make_from_hex_string ("05F939258DB7DD90E1934F8C70B0DFEC2EED25B8557EAC9C80E2E198F8CDBECD86B12053")
		end

	b283_gy: INTEGER_X
		do
			create result.make_from_hex_string ("03676854FE24141CB98FE6D4B20D02B4516FF702350EDDB0826779C813F0DF45BE8112F4")
		end

feature -- FIPS B-409
	b409_m: INTEGER = 409
	b409_k1: INTEGER = 0
	b409_k2: INTEGER = 0
	b409_k3: INTEGER = 87

	b409_a: INTEGER_X
		do
			result := one
		end

	b409_b: INTEGER_X
		do
			create result.make_from_hex_string ("0021A5C2C8EE9FEB5C4B9A753B7B476B7FD6422EF1F3DD674761FA99D6AC27C8A9A197B272822F6CD57A55AA4F50AE317B13545F")
		end

	b409_r: INTEGER_X
		do
			create result.make_from_hex_string ("010000000000000000000000000000000000000000000000000001E2AAD6A612F33307BE5FA47C3C9E052F838164CD37D9A21173")
		end

	b409_h: INTEGER_X
		do
			result := two
		end

	b409_gx: INTEGER_X
		do
			create result.make_from_hex_string ("015D4860D088DDB3496B0C6064756260441CDE4AF1771D4DB01FFE5B34E59703DC255A868A1180515603AEAB60794E54BB7996A7")
		end

	b409_gy: INTEGER_X
		do
			create result.make_from_hex_string ("0061B1CFAB6BE5F32BBFA78324ED106A7636B9C5A7BD198D0158AA4F5488D08F38514F1FDF4B4F40D2181B3681C364BA0273C706")
		end

feature -- FIPS B-571
	b571_m: INTEGER = 571
	b571_k1: INTEGER = 2
	b571_k2: INTEGER = 5
	b571_k3: INTEGER = 10

	b571_a: INTEGER_X
		do
			result := one
		end

	b571_b: INTEGER_X
		do
			create result.make_from_hex_string ("2f40e7e2221f295de297117b7f3d62f5c6a97ffcb8ceff1cd6ba8ce4a9a18ad84ffabbd8efa59332be7ad6756a66e294afd185a78ff12aa520e4de739baca0c7ffeff7f2955727a")
		end

	b571_r: INTEGER_X
		do
			create result.make_from_hex_string ("03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE661CE18FF55987308059B186823851EC7DD9CA1161DE93D5174D66E8382E9BB2FE84E47")
		end

	b571_h: INTEGER_X
		do
			result := two
		end

	b571_gx: INTEGER_X
		do
			create result.make_from_hex_string ("303001d34b856296c16c0d40d3cd7750a93d1d2955fa80aa5f40fc8db7b2abdbde53950f4c0d293cdd711a35b67fb1499ae60038614f1394abfa3b4c850d927e1e7769c8eec2d19")
		end

	b571_gy: INTEGER_X
		do
			create result.make_from_hex_string ("037BF27342DA639B6DCCFFFEB73D69D78C6C27A6009CBBCA1980F8533921E8A684423E43BAB08A576291AF8F461BB2A8B3531D2F0485C19B16E2F1516E23DD3C1A4827AF1B8AC15B")
		end
end
