note
	description: "A Mersenne twister RNG"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "A censor is a man who knows more than he thinks you ought to. -  Granville Hicks (1901-1982)"

class
	MERSENNE_TWISTER_RNG

inherit
	RANDOM_NUMBER_GENERATOR
	INTEGER_X_ARITHMETIC
		rename
			cmp as cmp_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		end
	INTEGER_X_DIVISION
		rename
			cmp as cmp_special,
			mod as mod_integer_x,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		end
	INTEGER_X_COMPARISON
	INTEGER_X_LOGIC
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special
		end

create
	make

feature
	make
		do
			create mt.make_filled (0, n)
			randinit_mt_noseed
		end

feature

	randinit_mt_noseed
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i >= n
			loop
				mt [i] := default_state (i)
				i := i + 1
			end
			mti := warm_up \\ n
		end

	mangle_seed (r: READABLE_INTEGER_X; b_orig: READABLE_INTEGER_X)
		local
			t: INTEGER_X
			b: INTEGER_X
			e: NATURAL_32
			bit_l: NATURAL_32
			sign: INTEGER
			reduce: BOOLEAN
		do
			e := 0x40118124
			bit_l := 0x20000000
			create t
			create b.make_set (b_orig)
			r.copy (b)
			from
			until
				bit_l = 0
			loop
				from
					reduce := True
				until
					not reduce
				loop
					from
						sign := 1
					until
						sign = 0
					loop
						tdiv_q_2exp (t, r, 0x19937)
						sign := t.sign
						if sign /= 0 then
							tdiv_r_2exp (r, r, 0x19937)
							addmul_ui (r, r, 0x20023)
						end
					end
					if e.bit_and (bit_l) /= 0 then
						e := e.bit_and (bit_l.bit_not)
						mul (r, r, b)
					else
						reduce := False
					end
				end
				bit_l := bit_l |>> 1
			end
		end

	randseed (seed: READABLE_INTEGER_X)
		local
			i: INTEGER
			count: INTEGER
			mod: INTEGER_X
			seed1: INTEGER_X
		do
			create mod.make_from_natural (0)
			create seed1
			bit_set (mod, 19937)
			sub_ui (mod, mod, 20027)
			mod_integer_x (seed1, seed, mod)
			add_ui (seed1, seed1, 2)
			mangle_seed (seed1, seed1)
			if bit_test (seed1, 19936) then
				mt [0] := 0x80000000
			else
				mt [0] := 0x0
			end
			bit_clear (seed1, 19936)
			mt.copy_data (seed1.item, 0, 1, seed1.count)
			count := count + 1
			from
			until
				count >= n
			loop
				mt [count] := 0
				count := count + 1
			end
			if warm_up /= 0 then
				from
					i := 0
				until
					i >= warm_up // n
				loop
					recalc_buffer
					i := i + 1
				end
			end
			mti := warm_up \\ n
		end

	recalc_buffer
		local
			y: NATURAL_32
			kk: INTEGER
		do
			from
				kk := 0
			until
				kk >= n - m
			loop
				y := mt [kk].bit_and (0x80000000).bit_or (mt [kk + 1].bit_and (0x7fffffff))
				if y.bit_test (0) then
					mt [kk] := mt [kk + m].bit_xor (y |>> 1).bit_xor (matrix_a)
				else
					mt [kk] := mt [kk + m].bit_xor (y |>> 1)
				end
				kk := kk + 1
			end
			from
			until
				kk >= n - 1
			loop
				y := mt [kk].bit_and (0x80000000).bit_or (mt [kk + 1].bit_and (0x7fffffff))
				if y.bit_test (0) then
					mt [kk] := mt [kk - (n - m)].bit_xor (y |>> 1).bit_xor (matrix_a)
				else
					mt [kk] := mt [kk - (n - m)].bit_xor (y |>> 1)
				end
				kk := kk + 1
			end
			y := mt [n - 1].bit_and (0x80000000).bit_or (mt [0].bit_and (0x7fffffff))
			if y.bit_test (0) then
				mt [n - 1] := mt [m - 1].bit_xor (y |>> 1).bit_xor (matrix_a)
			else
				mt [n - 1] := mt [m - 1].bit_xor (y |>> 1)
			end
		end

	next_random (y: CELL [NATURAL_32])
		do
			if mti >= n then
				recalc_buffer
				mti := 0
			end
			y.put (mt [mti])
			mti := mti + 1
			y.put (y.item.bit_xor (y.item |>> 11))
			y.put (y.item.bit_xor ((y.item |<< 7).bit_and (mask_1)))
			y.put (y.item.bit_xor ((y.item |<< 15).bit_and (mask_2)))
			y.put (y.item.bit_xor (y.item |>> 18))
		end

	randget (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; count: INTEGER_32)
		local
			y: CELL [NATURAL_32]
			rbits: INTEGER
			i: INTEGER
			nlimbs: INTEGER
		do
			create y.put (0)
			nlimbs := count // 32
			rbits := count \\ 32
			from
				i := 0
			until
				i >= nlimbs
			loop
				next_random (y)
				target [target_offset + i] := y.item
				i := i + 1
			end
			if rbits /= 0 then
				next_random (y)
				target [target_offset + nlimbs] := y.item.bit_and (((0xffffffff).to_natural_32 |<< rbits).bit_not)
			end
		end

	mti: INTEGER
	mt: SPECIAL [NATURAL_32]
	n: INTEGER = 624
	m: INTEGER = 397
	matrix_a: NATURAL_32 = 0x9908b0df
	warm_up: INTEGER = 2000
	default_seed: INTEGER = 5489
	mask_1: NATURAL_32 = 0x9d2c5680
	mask_2: NATURAL_32 = 0xefc60000

	default_state (i: INTEGER): NATURAL_32
		do
			inspect
				i
			when 0 then
				Result := 0xD247B233
			when 1 then
				Result := 0x9E5AA8F1
			when 2 then
				Result := 0x0FFA981B
			when 3 then
				Result := 0x9DCB0980
			when 4 then
				Result := 0x74200F2B
			when 5 then
				Result := 0xA576D044
			when 6 then
				Result := 0xE9F05ADF
			when 7 then
				Result := 0x1538BFF5
			when 8 then
				Result := 0x59818BBF
			when 9 then
				Result := 0xCF9E58D8
			when 10 then
				Result := 0x09FCE032
			when 11 then
				Result := 0x6A1C663F
			when 12 then
				Result := 0x5116E78A
			when 13 then
				Result := 0x69B3E0FA
			when 14 then
				Result := 0x6D92D665
			when 15 then
				Result := 0xD0A8BE98
			when 16 then
				Result := 0xF669B734
			when 17 then
				Result := 0x41AC1B68
			when 18 then
				Result := 0x630423F1
			when 19 then
				Result := 0x4B8D6B8A
			when 20 then
				Result := 0xC2C46DD7
			when 21 then
				Result := 0x5680747D
			when 22 then
				Result := 0x43703E8F
			when 23 then
				Result := 0x3B6103D2
			when 24 then
				Result := 0x49E5EB3F
			when 25 then
				Result := 0xCBDAB4C1
			when 26 then
				Result := 0x9C988E23
			when 27 then
				Result := 0x747BEE0B
			when 28 then
				Result := 0x9111E329
			when 29 then
				Result := 0x9F031B5A
			when 30 then
				Result := 0xECCA71B9
			when 31 then
				Result := 0x2AFE4EF8
			when 32 then
				Result := 0x8421C7ED
			when 33 then
				Result := 0xAC89AFF1
			when 34 then
				Result := 0xAED90DF3
			when 35 then
				Result := 0x2DD74F01
			when 36 then
				Result := 0x14906A13
			when 37 then
				Result := 0x75873FA9
			when 38 then
				Result := 0xFF83F877
			when 39 then
				Result := 0x5028A0C9
			when 40 then
				Result := 0x11B4C41D
			when 41 then
				Result := 0x7CAEDBC4
			when 42 then
				Result := 0x8672D0A7
			when 43 then
				Result := 0x48A7C109
			when 44 then
				Result := 0x8320E59F
			when 45 then
				Result := 0xBC0B3D5F
			when 46 then
				Result := 0x75A30886
			when 47 then
				Result := 0xF9E0D128
			when 48 then
				Result := 0x41AF7580
			when 49 then
				Result := 0x239BB94D
			when 50 then
				Result := 0xC67A3C81
			when 51 then
				Result := 0x74EEBD6E
			when 52 then
				Result := 0xBC02B53C
			when 53 then
				Result := 0x727EA449
			when 54 then
				Result := 0x6B8A2806
			when 55 then
				Result := 0x5853B0DA
			when 56 then
				Result := 0xBDE032F4
			when 57 then
				Result := 0xCE234885
			when 58 then
				Result := 0x320D6145
			when 59 then
				Result := 0x48CC053F
			when 60 then
				Result := 0x00DBC4D2
			when 61 then
				Result := 0xD55A2397
			when 62 then
				Result := 0xE1059B6F
			when 63 then
				Result := 0x1C3E05D1
			when 64 then
				Result := 0x09657C64
			when 65 then
				Result := 0xD07CB661
			when 66 then
				Result := 0x6E982E34
			when 67 then
				Result := 0x6DD1D777
			when 68 then
				Result := 0xEDED1071
			when 69 then
				Result := 0xD79DFD65
			when 70 then
				Result := 0xF816DDCE
			when 71 then
				Result := 0xB6FAF1E4
			when 72 then
				Result := 0x1C771074
			when 73 then
				Result := 0x311835BD
			when 74 then
				Result := 0x18F952F7
			when 75 then
				Result := 0xF8F40350
			when 76 then
				Result := 0x4ECED354
			when 77 then
				Result := 0x7C8AC12B
			when 78 then
				Result := 0x31A9994D
			when 79 then
				Result := 0x4FD47747
			when 80 then
				Result := 0xDC227A23
			when 81 then
				Result := 0x6DFAFDDF
			when 82 then
				Result := 0x6796E748
			when 83 then
				Result := 0x0C6F634F
			when 84 then
				Result := 0xF992FA1D
			when 85 then
				Result := 0x4CF670C9
			when 86 then
				Result := 0x067DFD31
			when 87 then
				Result := 0xA7A3E1A5
			when 88 then
				Result := 0x8CD7D9DF
			when 89 then
				Result := 0x972CCB34
			when 90 then
				Result := 0x67C82156
			when 91 then
				Result := 0xD548F6A8
			when 92 then
				Result := 0x045CEC21
			when 93 then
				Result := 0xF3240BFB
			when 94 then
				Result := 0xDEF656A7
			when 95 then
				Result := 0x43DE08C5
			when 96 then
				Result := 0xDAD1F92F
			when 97 then
				Result := 0x3726C56B
			when 98 then
				Result := 0x1409F19A
			when 99 then
				Result := 0x942FD147
			when 100 then
				Result := 0xB926749C
			when 101 then
				Result := 0xADDC31B8
			when 102 then
				Result := 0x53D0D869
			when 103 then
				Result := 0xD1BA52FE
			when 104 then
				Result := 0x6722DF8C
			when 105 then
				Result := 0x22D95A74
			when 106 then
				Result := 0x7DC1B52A
			when 107 then
				Result := 0x1DEC6FD5
			when 108 then
				Result := 0x7262874D
			when 109 then
				Result := 0x0A725DC9
			when 110 then
				Result := 0xE6A8193D
			when 111 then
				Result := 0xA052835A
			when 112 then
				Result := 0xDC9AD928
			when 113 then
				Result := 0xE59EBB90
			when 114 then
				Result := 0x70DBA9FF
			when 115 then
				Result := 0xD612749D
			when 116 then
				Result := 0x5A5A638C
			when 117 then
				Result := 0x6086EC37
			when 118 then
				Result := 0x2A579709
			when 119 then
				Result := 0x1449EA3A
			when 120 then
				Result := 0xBC8E3C06
			when 121 then
				Result := 0x2F900666
			when 122 then
				Result := 0xFBE74FD1
			when 123 then
				Result := 0x6B35B911
			when 124 then
				Result := 0xF8335008
			when 125 then
				Result := 0xEF1E979D
			when 126 then
				Result := 0x738AB29D
			when 127 then
				Result := 0xA2DC0FDC
			when 128 then
				Result := 0x7696305D
			when 129 then
				Result := 0xF5429DAC
			when 130 then
				Result := 0x8C41813B
			when 131 then
				Result := 0x8073E02E
			when 132 then
				Result := 0xBEF83CCD
			when 133 then
				Result := 0x7B50A95A
			when 134 then
				Result := 0x05EE5862
			when 135 then
				Result := 0x00829ECE
			when 136 then
				Result := 0x8CA1958C
			when 137 then
				Result := 0xBE4EA2E2
			when 138 then
				Result := 0x4293BB73
			when 139 then
				Result := 0x656F7B23
			when 140 then
				Result := 0x417316D8
			when 141 then
				Result := 0x4467D7CF
			when 142 then
				Result := 0x2200E63B
			when 143 then
				Result := 0x109050C8
			when 144 then
				Result := 0x814CBE47
			when 145 then
				Result := 0x36B1D4A8
			when 146 then
				Result := 0x36AF9305
			when 147 then
				Result := 0x308327B3
			when 148 then
				Result := 0xEBCD7344
			when 149 then
				Result := 0xA738DE27
			when 150 then
				Result := 0x5A10C399
			when 151 then
				Result := 0x4142371D
			when 152 then
				Result := 0x64A18528
			when 153 then
				Result := 0x0B31E8B2
			when 154 then
				Result := 0x641057B9
			when 155 then
				Result := 0x6AFC363B
			when 156 then
				Result := 0x108AD953
			when 157 then
				Result := 0x9D4DA234
			when 158 then
				Result := 0x0C2D9159
			when 159 then
				Result := 0x1C8A1A1F
			when 160 then
				Result := 0x310C66BA
			when 161 then
				Result := 0x87AA1070
			when 162 then
				Result := 0xDAC832FF
			when 163 then
				Result := 0x0A433422
			when 164 then
				Result := 0x7AF15812
			when 165 then
				Result := 0x2D8D9BD0
			when 166 then
				Result := 0x995A25E9
			when 167 then
				Result := 0x25326CAC
			when 168 then
				Result := 0xA34384DB
			when 169 then
				Result := 0x4C8421CC
			when 170 then
				Result := 0x4F0315EC
			when 171 then
				Result := 0x29E8649E
			when 172 then
				Result := 0xA7732D6F
			when 173 then
				Result := 0x2E94D3E3
			when 174 then
				Result := 0x7D98A340
			when 175 then
				Result := 0x397C4D74
			when 176 then
				Result := 0x659DB4DE
			when 177 then
				Result := 0x747D4E9A
			when 178 then
				Result := 0xD9DB8435
			when 179 then
				Result := 0x4659DBE9
			when 180 then
				Result := 0x313E6DC5
			when 181 then
				Result := 0x29D104DC
			when 182 then
				Result := 0x9F226CBA
			when 183 then
				Result := 0x452F18B0
			when 184 then
				Result := 0xD0BC5068
			when 185 then
				Result := 0x844CA299
			when 186 then
				Result := 0x782B294E
			when 187 then
				Result := 0x4AE2EB7B
			when 188 then
				Result := 0xA4C475F8
			when 189 then
				Result := 0x70A81311
			when 190 then
				Result := 0x4B3E8BCC
			when 191 then
				Result := 0x7E20D4BA
			when 192 then
				Result := 0xABCA33C9
			when 193 then
				Result := 0x57BE2960
			when 194 then
				Result := 0x44F9B419
			when 195 then
				Result := 0x2E567746
			when 196 then
				Result := 0x72EB757A
			when 197 then
				Result := 0x102CC0E8
			when 198 then
				Result := 0xB07F32B9
			when 199 then
				Result := 0xD0DABD59
			when 200 then
				Result := 0xBA85AD6B
			when 201 then
				Result := 0xF3E20667
			when 202 then
				Result := 0x98D77D81
			when 203 then
				Result := 0x197AFA47
			when 204 then
				Result := 0x518EE9AC
			when 205 then
				Result := 0xE10CE5A2
			when 206 then
				Result := 0x01CF2C2A
			when 207 then
				Result := 0xD3A3AF3D
			when 208 then
				Result := 0x16DDFD65
			when 209 then
				Result := 0x669232F8
			when 210 then
				Result := 0x1C50A301
			when 211 then
				Result := 0xB93D9151
			when 212 then
				Result := 0x9354D3F4
			when 213 then
				Result := 0x847D79D0
			when 214 then
				Result := 0xD5FE2EC6
			when 215 then
				Result := 0x1F7B0610
			when 216 then
				Result := 0xFA6B90A5
			when 217 then
				Result := 0xC5879041
			when 218 then
				Result := 0x2E7DC05E
			when 219 then
				Result := 0x423F1F32
			when 220 then
				Result := 0xEF623DDB
			when 221 then
				Result := 0x49C13280
			when 222 then
				Result := 0x98714E92
			when 223 then
				Result := 0xC7B6E4AD
			when 224 then
				Result := 0xC4318466
			when 225 then
				Result := 0x0737F312
			when 226 then
				Result := 0x4D3C003F
			when 227 then
				Result := 0x9ACC1F1F
			when 228 then
				Result := 0x5F1C926D
			when 229 then
				Result := 0x085FA771
			when 230 then
				Result := 0x185A83A2
			when 231 then
				Result := 0xF9AA159D
			when 232 then
				Result := 0x0B0B0132
			when 233 then
				Result := 0xF98E7A43
			when 234 then
				Result := 0xCD9EBDBE
			when 235 then
				Result := 0x0190CB29
			when 236 then
				Result := 0x10D93FB6
			when 237 then
				Result := 0x3B8A4D97
			when 238 then
				Result := 0x66A65A41
			when 239 then
				Result := 0xE43E766F
			when 240 then
				Result := 0x77BE3C41
			when 241 then
				Result := 0xB9686364
			when 242 then
				Result := 0xCB36994D
			when 243 then
				Result := 0x6846A287
			when 244 then
				Result := 0x567E77F7
			when 245 then
				Result := 0x36178DD8
			when 246 then
				Result := 0xBDE6B1F2
			when 247 then
				Result := 0xB6EFDC64
			when 248 then
				Result := 0x82950324
			when 249 then
				Result := 0x42053F47
			when 250 then
				Result := 0xC09BE51C
			when 251 then
				Result := 0x0942D762
			when 252 then
				Result := 0x35F92C7F
			when 253 then
				Result := 0x367DEC61
			when 254 then
				Result := 0x6EE3D983
			when 255 then
				Result := 0xDBAAF78A
			when 256 then
				Result := 0x265D2C47
			when 257 then
				Result := 0x8EB4BF5C
			when 258 then
				Result := 0x33B232D7
			when 259 then
				Result := 0xB0137E77
			when 260 then
				Result := 0x373C39A7
			when 261 then
				Result := 0x8D2B2E76
			when 262 then
				Result := 0xC7510F01
			when 263 then
				Result := 0x50F9E032
			when 264 then
				Result := 0x7B1FDDDB
			when 265 then
				Result := 0x724C2AAE
			when 266 then
				Result := 0xB10ECB31
			when 267 then
				Result := 0xCCA3D1B8
			when 268 then
				Result := 0x7F0BCF10
			when 269 then
				Result := 0x4254BBBD
			when 270 then
				Result := 0xE3F93B97
			when 271 then
				Result := 0x2305039B
			when 272 then
				Result := 0x53120E22
			when 273 then
				Result := 0x1A2F3B9A
			when 274 then
				Result := 0x0FDDBD97
			when 275 then
				Result := 0x0118561E
			when 276 then
				Result := 0x0A798E13
			when 277 then
				Result := 0x9E0B3ACD
			when 278 then
				Result := 0xDB6C9F15
			when 279 then
				Result := 0xF512D0A2
			when 280 then
				Result := 0x9E8C3A28
			when 281 then
				Result := 0xEE2184AE
			when 282 then
				Result := 0x0051EC2F
			when 283 then
				Result := 0x2432F74F
			when 284 then
				Result := 0xB0AA66EA
			when 285 then
				Result := 0x55128D88
			when 286 then
				Result := 0xF7D83A38
			when 287 then
				Result := 0x4DAE8E82
			when 288 then
				Result := 0x3FDC98D6
			when 289 then
				Result := 0x5F0BD341
			when 290 then
				Result := 0x7244BE1D
			when 291 then
				Result := 0xC7B48E78
			when 292 then
				Result := 0x2D473053
			when 293 then
				Result := 0x43892E20
			when 294 then
				Result := 0xBA0F1F2A
			when 295 then
				Result := 0x524D4895
			when 296 then
				Result := 0x2E10BCB1
			when 297 then
				Result := 0x4C372D81
			when 298 then
				Result := 0x5C3E50CD
			when 299 then
				Result := 0xCF61CC2E
			when 300 then
				Result := 0x931709AB
			when 301 then
				Result := 0x81B3AEFC
			when 302 then
				Result := 0x39E9405E
			when 303 then
				Result := 0x7FFE108C
			when 304 then
				Result := 0x4FBB3FF8
			when 305 then
				Result := 0x06ABE450
			when 306 then
				Result := 0x7F5BF51E
			when 307 then
				Result := 0xA4E3CDFD
			when 308 then
				Result := 0xDB0F6C6F
			when 309 then
				Result := 0x159A1227
			when 310 then
				Result := 0x3B9FED55
			when 311 then
				Result := 0xD20B6F7F
			when 312 then
				Result := 0xFBE9CC83
			when 313 then
				Result := 0x64856619
			when 314 then
				Result := 0xBF52B8AF
			when 315 then
				Result := 0x9D7006B0
			when 316 then
				Result := 0x71165BC6
			when 317 then
				Result := 0xAE324AEE
			when 318 then
				Result := 0x29D27F2C
			when 319 then
				Result := 0x794C2086
			when 320 then
				Result := 0x74445CE2
			when 321 then
				Result := 0x782915CC
			when 322 then
				Result := 0xD4CE6886
			when 323 then
				Result := 0x3289AE7C
			when 324 then
				Result := 0x53DEF297
			when 325 then
				Result := 0x4185F7ED
			when 326 then
				Result := 0x88B72400
			when 327 then
				Result := 0x3C09DC11
			when 328 then
				Result := 0xBCE3AAB6
			when 329 then
				Result := 0x6A75934A
			when 330 then
				Result := 0xB267E399
			when 331 then
				Result := 0x000DF1BF
			when 332 then
				Result := 0x193BA5E2
			when 333 then
				Result := 0xFA3E1977
			when 334 then
				Result := 0x179E14F6
			when 335 then
				Result := 0x1EEDE298
			when 336 then
				Result := 0x691F0B06
			when 337 then
				Result := 0xB84F78AC
			when 338 then
				Result := 0xC1C15316
			when 339 then
				Result := 0xFFFF3AD6
			when 340 then
				Result := 0x0B457383
			when 341 then
				Result := 0x518CD612
			when 342 then
				Result := 0x05A00F3E
			when 343 then
				Result := 0xD5B7D275
			when 344 then
				Result := 0x4C5ECCD7
			when 345 then
				Result := 0xE02CD0BE
			when 346 then
				Result := 0x5558E9F2
			when 347 then
				Result := 0x0C89BBF0
			when 348 then
				Result := 0xA3D96227
			when 349 then
				Result := 0x2832D2B2
			when 350 then
				Result := 0xF667B897
			when 351 then
				Result := 0xD4556554
			when 352 then
				Result := 0xF9D2F01F
			when 353 then
				Result := 0xFA1E3FAE
			when 354 then
				Result := 0x52C2E1EE
			when 355 then
				Result := 0xE5451F31
			when 356 then
				Result := 0x7E849729
			when 357 then
				Result := 0xDABDB67A
			when 358 then
				Result := 0x54BF5E7E
			when 359 then
				Result := 0xF831C271
			when 360 then
				Result := 0x5F1A17E3
			when 361 then
				Result := 0x9D140AFE
			when 362 then
				Result := 0x92741C47
			when 363 then
				Result := 0x48CFABCE
			when 364 then
				Result := 0x9CBBE477
			when 365 then
				Result := 0x9C3EE57F
			when 366 then
				Result := 0xB07D4C39
			when 367 then
				Result := 0xCC21BCE2
			when 368 then
				Result := 0x697708B1
			when 369 then
				Result := 0x58DA2A6B
			when 370 then
				Result := 0x2370DB16
			when 371 then
				Result := 0x6E641948
			when 372 then
				Result := 0xACC5BD52
			when 373 then
				Result := 0x868F24CC
			when 374 then
				Result := 0xCA1DB0F5
			when 375 then
				Result := 0x4CADA492
			when 376 then
				Result := 0x3F443E54
			when 377 then
				Result := 0xC4A4D5E9
			when 378 then
				Result := 0xF00AD670
			when 379 then
				Result := 0xE93C86E0
			when 380 then
				Result := 0xFE90651A
			when 381 then
				Result := 0xDDE532A3
			when 382 then
				Result := 0xA66458DF
			when 383 then
				Result := 0xAB7D7151
			when 384 then
				Result := 0x0E2E775F
			when 385 then
				Result := 0xC9109F99
			when 386 then
				Result := 0x8D96D59F
			when 387 then
				Result := 0x73CEF14C
			when 388 then
				Result := 0xC74E88E9
			when 389 then
				Result := 0x02712DC0
			when 390 then
				Result := 0x04F41735
			when 391 then
				Result := 0x2E5914A2
			when 392 then
				Result := 0x59F4B2FB
			when 393 then
				Result := 0x0287FC83
			when 394 then
				Result := 0x80BC0343
			when 395 then
				Result := 0xF6B32559
			when 396 then
				Result := 0xC74178D4
			when 397 then
				Result := 0xF1D99123
			when 398 then
				Result := 0x383CCC07
			when 399 then
				Result := 0xACC0637D
			when 400 then
				Result := 0x0863A548
			when 401 then
				Result := 0xA6FCAC85
			when 402 then
				Result := 0x2A13EFF0
			when 403 then
				Result := 0xAF2EEDB1
			when 404 then
				Result := 0x41E72750
			when 405 then
				Result := 0xE0C6B342
			when 406 then
				Result := 0x5DA22B46
			when 407 then
				Result := 0x635559E0
			when 408 then
				Result := 0xD2EA40AC
			when 409 then
				Result := 0x10AA98C0
			when 410 then
				Result := 0x19096497
			when 411 then
				Result := 0x112C542B
			when 412 then
				Result := 0x2C85040C
			when 413 then
				Result := 0xA868E7D0
			when 414 then
				Result := 0x6E260188
			when 415 then
				Result := 0xF596D390
			when 416 then
				Result := 0xC3BB5D7A
			when 417 then
				Result := 0x7A2AA937
			when 418 then
				Result := 0xDFD15032
			when 419 then
				Result := 0x6780AE3B
			when 420 then
				Result := 0xDB5F9CD8
			when 421 then
				Result := 0x8BD266B0
			when 422 then
				Result := 0x7744AF12
			when 423 then
				Result := 0xB463B1B0
			when 424 then
				Result := 0x589629C9
			when 425 then
				Result := 0xE30DBC6E
			when 426 then
				Result := 0x880F5569
			when 427 then
				Result := 0x209E6E16
			when 428 then
				Result := 0x9DECA50C
			when 429 then
				Result := 0x02987A57
			when 430 then
				Result := 0xBED3EA57
			when 431 then
				Result := 0xD3A678AA
			when 432 then
				Result := 0x70DD030D
			when 433 then
				Result := 0x0CFD9C5D
			when 434 then
				Result := 0x92A18E99
			when 435 then
				Result := 0xF5740619
			when 436 then
				Result := 0x7F6F0A7D
			when 437 then
				Result := 0x134CAF9A
			when 438 then
				Result := 0x70F5BAE4
			when 439 then
				Result := 0x23DCA7B5
			when 440 then
				Result := 0x4D788FCD
			when 441 then
				Result := 0xC7F07847
			when 442 then
				Result := 0xBCF77DA1
			when 443 then
				Result := 0x9071D568
			when 444 then
				Result := 0xFC627EA1
			when 445 then
				Result := 0xAE004B77
			when 446 then
				Result := 0x66B54BCB
			when 447 then
				Result := 0x7EF2DAAC
			when 448 then
				Result := 0xDCD5AC30
			when 449 then
				Result := 0xB9BDF730
			when 450 then
				Result := 0x505A97A7
			when 451 then
				Result := 0x9D881FD3
			when 452 then
				Result := 0xADB796CC
			when 453 then
				Result := 0x94A1D202
			when 454 then
				Result := 0x97535D7F
			when 455 then
				Result := 0x31EC20C0
			when 456 then
				Result := 0xB1887A98
			when 457 then
				Result := 0xC1475069
			when 458 then
				Result := 0xA6F73AF3
			when 459 then
				Result := 0x71E4E067
			when 460 then
				Result := 0x46A569DE
			when 461 then
				Result := 0xD2ADE430
			when 462 then
				Result := 0x6F0762C7
			when 463 then
				Result := 0xF50876F4
			when 464 then
				Result := 0x53510542
			when 465 then
				Result := 0x03741C3E
			when 466 then
				Result := 0x53502224
			when 467 then
				Result := 0xD8E54D60
			when 468 then
				Result := 0x3C44AB1A
			when 469 then
				Result := 0x34972B46
			when 470 then
				Result := 0x74BFA89D
			when 471 then
				Result := 0xD7D768E0
			when 472 then
				Result := 0x37E605DC
			when 473 then
				Result := 0xE13D1BDF
			when 474 then
				Result := 0x5051C421
			when 475 then
				Result := 0xB9E057BE
			when 476 then
				Result := 0xB717A14C
			when 477 then
				Result := 0xA1730C43
			when 478 then
				Result := 0xB99638BE
			when 479 then
				Result := 0xB5D5F36D
			when 480 then
				Result := 0xE960D9EA
			when 481 then
				Result := 0x6B1388D3
			when 482 then
				Result := 0xECB6D3B6
			when 483 then
				Result := 0xBDBE8B83
			when 484 then
				Result := 0x2E29AFC5
			when 485 then
				Result := 0x764D71EC
			when 486 then
				Result := 0x4B8F4F43
			when 487 then
				Result := 0xC21DDC00
			when 488 then
				Result := 0xA63F657F
			when 489 then
				Result := 0x82678130
			when 490 then
				Result := 0xDBF535AC
			when 491 then
				Result := 0xA594FC58
			when 492 then
				Result := 0x942686BC
			when 493 then
				Result := 0xBD9B657B
			when 494 then
				Result := 0x4A0F9B61
			when 495 then
				Result := 0x44FF184F
			when 496 then
				Result := 0x38E10A2F
			when 497 then
				Result := 0x61910626
			when 498 then
				Result := 0x5E247636
			when 499 then
				Result := 0x7106D137
			when 500 then
				Result := 0xC62802F0
			when 501 then
				Result := 0xBD1D1F00
			when 502 then
				Result := 0x7CC0DCB2
			when 503 then
				Result := 0xED634909
			when 504 then
				Result := 0xDC13B24E
			when 505 then
				Result := 0x9799C499
			when 506 then
				Result := 0xD77E3D6A
			when 507 then
				Result := 0x14773B68
			when 508 then
				Result := 0x967A4FB7
			when 509 then
				Result := 0x35EECFB1
			when 510 then
				Result := 0x2A5110B8
			when 511 then
				Result := 0xE2F0AF94
			when 512 then
				Result := 0x9D09DEA5
			when 513 then
				Result := 0x20255D27
			when 514 then
				Result := 0x5771D34B
			when 515 then
				Result := 0xE1089EE4
			when 516 then
				Result := 0x246F330B
			when 517 then
				Result := 0x8F7CAEE5
			when 518 then
				Result := 0xD3064712
			when 519 then
				Result := 0x75CAFBEE
			when 520 then
				Result := 0xB94F7028
			when 521 then
				Result := 0xED953666
			when 522 then
				Result := 0x5D1975B4
			when 523 then
				Result := 0x5AF81271
			when 524 then
				Result := 0x13BE2025
			when 525 then
				Result := 0x85194659
			when 526 then
				Result := 0x30805331
			when 527 then
				Result := 0xEC9D46C0
			when 528 then
				Result := 0xBC027C36
			when 529 then
				Result := 0x2AF84188
			when 530 then
				Result := 0xC2141B80
			when 531 then
				Result := 0xC02B1E4A
			when 532 then
				Result := 0x04D36177
			when 533 then
				Result := 0xFC50E9D7
			when 534 then
				Result := 0x39CE79DA
			when 535 then
				Result := 0x917E0A00
			when 536 then
				Result := 0xEF7A0BF4
			when 537 then
				Result := 0xA98BD8D1
			when 538 then
				Result := 0x19424DD2
			when 539 then
				Result := 0x9439DF1F
			when 540 then
				Result := 0xC42AF746
			when 541 then
				Result := 0xADDBE83E
			when 542 then
				Result := 0x85221F0D
			when 543 then
				Result := 0x45563E90
			when 544 then
				Result := 0x9095EC52
			when 545 then
				Result := 0x77887B25
			when 546 then
				Result := 0x8AE46064
			when 547 then
				Result := 0xBD43B71A
			when 548 then
				Result := 0xBB541956
			when 549 then
				Result := 0x7366CF9D
			when 550 then
				Result := 0xEE8E1737
			when 551 then
				Result := 0xB5A727C9
			when 552 then
				Result := 0x5076B3E7
			when 553 then
				Result := 0xFC70BACA
			when 554 then
				Result := 0xCE135B75
			when 555 then
				Result := 0xC4E91AA3
			when 556 then
				Result := 0xF0341911
			when 557 then
				Result := 0x53430C3F
			when 558 then
				Result := 0x886B0824
			when 559 then
				Result := 0x6BB5B8B7
			when 560 then
				Result := 0x33E21254
			when 561 then
				Result := 0xF193B456
			when 562 then
				Result := 0x5B09617F
			when 563 then
				Result := 0x215FFF50
			when 564 then
				Result := 0x48D97EF1
			when 565 then
				Result := 0x356479AB
			when 566 then
				Result := 0x6EA9DDC4
			when 567 then
				Result := 0x0D352746
			when 568 then
				Result := 0xA2F5CE43
			when 569 then
				Result := 0xB226A1B3
			when 570 then
				Result := 0x1329EA3C
			when 571 then
				Result := 0x7A337CC2
			when 572 then
				Result := 0xB5CCE13D
			when 573 then
				Result := 0x563E3B5B
			when 574 then
				Result := 0x534E8E8F
			when 575 then
				Result := 0x561399C9
			when 576 then
				Result := 0xE1596392
			when 577 then
				Result := 0xB0F03125
			when 578 then
				Result := 0x4586645B
			when 579 then
				Result := 0x1F371847
			when 580 then
				Result := 0x94EAABD1
			when 581 then
				Result := 0x41F97EDD
			when 582 then
				Result := 0xE3E5A39B
			when 583 then
				Result := 0x71C774E2
			when 584 then
				Result := 0x507296F4
			when 585 then
				Result := 0x5960133B
			when 586 then
				Result := 0x7852C494
			when 587 then
				Result := 0x3F5B2691
			when 588 then
				Result := 0xA3F87774
			when 589 then
				Result := 0x5A7AF89E
			when 590 then
				Result := 0x17DA3F28
			when 591 then
				Result := 0xE9D9516D
			when 592 then
				Result := 0xFCC1C1D5
			when 593 then
				Result := 0xE4618628
			when 594 then
				Result := 0x04081047
			when 595 then
				Result := 0xD8E4DB5F
			when 596 then
				Result := 0xDC380416
			when 597 then
				Result := 0x8C4933E2
			when 598 then
				Result := 0x95074D53
			when 599 then
				Result := 0xB1B0032D
			when 600 then
				Result := 0xCC8102EA
			when 601 then
				Result := 0x71641243
			when 602 then
				Result := 0x98D6EB6A
			when 603 then
				Result := 0x90FEC945
			when 604 then
				Result := 0xA0914345
			when 605 then
				Result := 0x6FAB037D
			when 606 then
				Result := 0x70F49C4D
			when 607 then
				Result := 0x05BF5B0E
			when 608 then
				Result := 0x927AAF7F
			when 609 then
				Result := 0xA1940F61
			when 610 then
				Result := 0xFEE0756F
			when 611 then
				Result := 0xF815369F
			when 612 then
				Result := 0x5C00253B
			when 613 then
				Result := 0xF2B9762F
			when 614 then
				Result := 0x4AEB3CCC
			when 615 then
				Result := 0x1069F386
			when 616 then
				Result := 0xFBA4E7B9
			when 617 then
				Result := 0x70332665
			when 618 then
				Result := 0x6BCA810E
			when 619 then
				Result := 0x85AB8058
			when 620 then
				Result := 0xAE4B2B2F
			when 621 then
				Result := 0x9D120712
			when 622 then
				Result := 0xBEE8EACB
			when 623 then
				Result := 0x776A1112
			end
		end
end
