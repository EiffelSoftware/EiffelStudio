note
	description: "A factory class for generating different STRING objects."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_FACTORY

feature -- Access

	all_strings: ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- A collection of different strings.
		obsolete
			"This feature calls that obsolete feature `file_name` to test the obsoleete class FILE_NAME. [2019-11-30]"
		do
			create Result.make (50)

				-- STRING_8
			Result.extend (string_8_empty)
			Result.extend (string_8_small)
			Result.extend (string_8_medium)
			Result.extend (string_8_big)

				-- STRING_32
			Result.extend (string_32_empty)
			Result.extend (string_32_small)
			Result.extend (string_32_medium)
			Result.extend (string_32_big)
			Result.extend (string_32_chinese)

				-- IMMUTABLE_STRING_8
			Result.extend (immutable_string_8_empty)
			Result.extend (immutable_string_8_small)
			Result.extend (immutable_string_8_medium)
			Result.extend (immutable_string_8_big)


				-- IMMUTABLE_STRING_32
			Result.extend (immutable_string_32_empty)
			Result.extend (immutable_string_32_small)
			Result.extend (immutable_string_32_medium)
			Result.extend (immutable_string_32_big)
			Result.extend (immutable_string_32_chinese)

				-- FILE_NAME
			Result.extend (file_name)

		end

feature -- Access: STRING_8

	string_8_empty: STRING_8
			-- An empty STRING_8.
		do
			create Result.make_empty
		end

	string_8_small: STRING_8
			-- A small STRING_8.
		do
			Result := "string_8"
		end

	string_8_medium: STRING_8
			-- A medium-sized STRING_8 with 1024 characters.
		local
			i: INTEGER
		do
			Result := "16char count str"
			from
				i := 1
			until
				i > 6
			loop
				Result := Result + Result
				i := i + 1
			variant
				7 - i
			end
		ensure
			correct_count: Result.count = 1024
		end

	string_8_big: STRING_8
			-- A big-sized STRING_8 with more than a million characters.
		local
			i: INTEGER
		do
			Result := string_8_medium
			from
				i := 1
			until
				i > 10
			loop
				Result := Result + Result
				i := i + 1
			variant
				11 - i
			end
		ensure
			correct_count: Result.count = (2^20)
		end

feature -- Access: STRING_32

	string_32_empty: STRING_32
			-- An empty STRING_32.
		do
			create Result.make_empty
		end

	string_32_small: STRING_32
			-- A small STRING_32.
		do
			Result := "string_32"
		end

	string_32_medium: STRING_32
			-- A medium-sized STRING_32 with 1024 characters.
		local
			i: INTEGER
		do
			Result := "16char count str"
			from
				i := 1
			until
				i > 6
			loop
				Result := Result + Result
				i := i + 1
			variant
				7 - i
			end
		ensure
			correct_count: Result.count = 1024
		end

	string_32_big: STRING_32
			-- A big-sized STRING_32 with more than a million characters.
		local
			i: INTEGER
		do
			Result := string_32_medium
			from
				i := 1
			until
				i > 10
			loop
				Result := Result + Result
				i := i + 1
			variant
				11 - i
			end
		ensure
			correct_count: Result.count = (2^20)
		end

	string_32_chinese: STRING_32
			-- A STRING_32 with chinese (non-ASCII) symbols.
		do
			Result := {STRING_32} "[
				嗢 镺陯 鬎鯪鯠 梴棆棎 瞵瞷矰 擙樲橚 濍燂犝 衒袟 榱, 愄揎揇 棦殔湝 跣 駇僾 瘭瘱 檹瀔濼 轞騹鼚 壾 靮傿 藽轚酁 闟顣飁 毼

				嘽 蒠蓔蜳 梜淊淭 熤熡磎 檹瀔, 樧槧樈 獫瘯皻 麷劻穋 鳼 抩枎 箹糈 鵁麍儱 寁崏庲 熩熝犚 觢 鐩闤鞿 檹瀔濼 觢 凘墈, 珿祪 腶 稘稒稕 蒠蓔蜳 鍌鍗鍷 漊煻獌 灡蠵讔 穊 訬軗

				撱 曏樴橉 蛣袹跜 飣偓, 蕷薎薍 濞濢燨 裍裚詷 獂猺 鄜 踄鄜 齞齝囃 邆錉霋 檹瀔濼 禠, 踣踙 踙 溹溦滜 樧槧樈 僄塓塕 窨箌 槄 袀豇貣 鞂駇僾 浞浧浵, 顤鰩鷎 捘栒毤 殔湝 蒏 栒毤 蜸 儋圚墝 咶垞姳, 壿嫷嬃 濷瓂癚 煔 蚙迻

				犆犅 髬 嬏嶟樀 糋罶羬, 颾鬋 氉燡磼 鶊鵱鶆 槏 魦魵 桏毢涒 濍燂犝 髬, 圛嬖 薠薞薘 巘斖蘱 厊圪妀 踣, 忕汌 鳼鳹鴅 薉蕺薂 檹瀔濼 鳱 槏 熥獘 黐曮禷 禒箈箑, 澂漀潫 莃荶衒 駺駹鮚 蔰 鮥鴮, 筩 撖撱暲 姎岵帔 慡戫 筡絼綒 媶媐尳 惵揯 殟, 慛 塥搒楦 誁趏跮 鮚鴸, 鉌 髟偛 黈龠懱 皵碡碙 戫摴撦 筡 騔鯬 灉礭蘠 釢髟偛 浘涀缹 鷜鷙 諃 榶榩榿 鬋鯫鯚

				钃麷 跣 鮛鮥鴮 嗛嗕塨 鄻鎟霣, 梴棆 煔 柦柋牬 鸙讟钃, 婂崥崣 煘煓瑐 珖珝 觢 嬼懫 幓 誙賗跿 齹鑶鸓 柦柋牬, 墆 懥斶 溿煔煃 譺鐼霺 榃痯痻 潧潣瑽 鵹鵿 摲, 獧瞝瞣 鍌鍗鍷 躨钀钁 墏 阹侺 鶆鵵 葝 鍆錌雔 搋朠楟 崸嵀惉 摲摓 滆 娞弳弰 譾躒鑅, 頏飹 銈 壾嵷幓 輑鄟銆 蝪蝩覤 侺咥垵 蹸蹪鏂 豅鑢鑗 摲 緟蔤, 撖 韰頯餩 馻噈嫶 櫅檷

				磑禠 輠 胾臷菨 薠薞薘 屼汆冹, 摲 瀁瀎瀊 鬐鶤鶐 葎萻萶 孻憵 銈 黫鼱 岋巠帎 梴棆棎 烺焆琀, 埱娵 輘輠輗 醙醠鍖 楋 聧蔩 慖 畟痄笊 觶譈譀, 檑燲 摲 誙賗跿 鍌鍗鍷 濷瓂癚 嶵嶯幯 縸縩薋 錖霒 壾

				膣 蠿饡驦 鸙讟钃 蠛趯, 綧緁緅 鶟儹巏 咥垵 潫 靮傿 髬 嬔嬚嬞 沀皯竻, 瘵瘲 僣 譋轐鏕 砫粍紞 蚔趵郚 蟷蠉蟼 忀瀸 痯, 潧潣瑽 珋疧眅 輲輹輴 祣筇 歅 蔰蝯蝺 箄縴儳 鶀嚵 榯, 鮛鮥鴮 榬榼榳 鶊鵱鶆 嘽 齠齞 齹鑶鸓 櫞氌瀙 驐鷑鷩 蜸 灡蠵, 羳蟪 塛嫆嫊 籿紁羑 鷖鼳鼲 嵥, 踄 圩芰敔 萆覕貹 鏙闛颾 蝩覤

				哸娗 褌 齴讘麡 柦柋牬 噾噿嚁, 僣 捘栒毤 縓罃蔾 汫汭沎 戣椵, 咍垀坽 飹勫嫢 銇 艭蠸 跣 熤熡 馺骱魡 蔏蔍蓪 蠬襱覾, 鑤仜伒 袀豇貣 僄塓塕 镺陯 跿 摮 髽鮛 鶭黮齥 桏毢涒 葠蜄蛖, 滈溔滆 廅愮揫 磩磟窱 憉 哤垽, 耇胇赲 鄻鎟霣 脬舑莕 墆 俶倗 圛嬖嬨 笓粊紒 騩鰒 橀

				鶟儹巏 鍹餳駷 獫瘯皻 眅眊 鋑, 譖貚趪 鞈頨頧 闟顣飁 餀 濞濢 蓌蓖 歅 筡絼綒 峷敊浭, 鏊鏎顜 樧槧樈 瞂 鵛嚪 箄縴 惝掭掝 姴怤昢 痯, 氉燡磼 莔莋莥 浞浧浵 褅褌 硾 緳 憱撏 忣抏旲 寱懤擨, 骱 漀潫 堔埧娾 騔鯬鶄 蛣袹跜

				殠 蒛蜙 鍆錌雔 烺焆琀 藒襓謥 殍涾烰 鵵鵹鵿 觢 嵀惉, 甂睮 摮 禖穊稯 忁曨曣 佹侁刵, 蹪鏂 彃慔慛 蔝蓶蓨 瞵瞷矰 嫀 顃餭 禠 鱙鷭黂 軹軦軵 椸楢楩, 褌 螷蟞 竀篴臌 桏毢涒 疿疶砳 馺骱魡 戫摴撦 羭聧蔩 緷緦 緦, 峬峿峹 璻甔礔 蜸 薢蟌, 綌綄罨 犈犆犅 糋罶羬 啅婰 溿 溔 鼳鼲 謺貙蹖 鶊鵱鶆 鑴鱱爧, 嬼懫 餀 釂鱞鸄 賌輈鄍, 肒芅 璈皞緪 螾褾賹 烳牼翐 嵥

			]"
		end

feature -- Access: IMMUTABLE_STRING_8

	immutable_string_8_empty: IMMUTABLE_STRING_8
			-- An empty IMMUTABLE_STRING_8.
		do
			create Result.make_from_string (string_8_empty)
		end

	immutable_string_8_small: IMMUTABLE_STRING_8
			-- A small IMMUTABLE_STRING_8.
		do
			create Result.make_from_string (string_8_small)
		end

	immutable_string_8_medium: IMMUTABLE_STRING_8
			-- A medium-sized IMMUTABLE_STRING_8 with 1024 characters.
		do
			create Result.make_from_string (string_8_medium)
		end

	immutable_string_8_big: IMMUTABLE_STRING_8
			-- A big-sized IMMUTABLE_STRING_8 with more than a million characters.
		do
			create Result.make_from_string (string_8_big)
		end

feature -- Access: IMMUTABLE_STRING_32

	immutable_string_32_empty: IMMUTABLE_STRING_32
			-- An empty IMMUTABLE_STRING_32.
		do
			create Result.make_from_string (string_32_empty)
		end

	immutable_string_32_small: IMMUTABLE_STRING_32
			-- A small IMMUTABLE_STRING_32.
		do
			create Result.make_from_string (string_32_small)
		end

	immutable_string_32_medium: IMMUTABLE_STRING_32
			-- A medium-sized IMMUTABLE_STRING_32 with 1024 characters.
		do
			create Result.make_from_string (string_32_medium)
		end

	immutable_string_32_big: IMMUTABLE_STRING_32
			-- A big-sized IMMUTABLE_STRING_32 with more than a million characters.
		do
			create Result.make_from_string (string_32_big)
		end

	immutable_string_32_chinese: IMMUTABLE_STRING_32
			-- A STRING_32 with chinese (non-ASCII) symbols.
		do
			create Result.make_from_string (string_32_chinese)
		end

feature -- Access: FILE_NAME

	file_name: FILE_NAME
			-- Test a file name (subtype of STRING_8).
		obsolete
			"This feature is used to test the obsolete class FILE_NAME. [2019-11-30]"
		do
			create Result.make_from_string ("a_file_name")
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
