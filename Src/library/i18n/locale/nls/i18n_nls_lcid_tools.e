note
	description: "Constants and conversion functions for NLS LCIDS"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_NLS_LCID_TOOLS

inherit
	I18N_NLS_GETLOCALEINFO

create
	initialize_locales

feature --Access

	is_supported_locale (lcid: INTEGER): BOOLEAN
			-- Is the given LCID supported _and_ installed?
		do
				-- Possible flags, from winnls.h :
				--#define LCID_INSTALLED            0x00000001  // installed locale ids
				--#define LCID_SUPPORTED            0x00000002  // supported locale ids
			Result := is_valid_locale (lcid, 2)
		end

	supported_locales: ARRAYED_LIST [I18N_LOCALE_ID]
			--  List all installed locales
		do
			create Result.make (locales.count)
			across locales as l_locale loop
				if is_supported_locale (l_locale.lcid) then
					Result.extend (lcid_to_locale_id (l_locale.lcid))
				end
			end
		end

	lcid_to_locale_id (lcid: INTEGER): I18N_LOCALE_ID
			-- Only Windows Vista can manage to give you the correct identifier in one query.
			-- Everyone else needs to take a crash course on how these identifiers are composed:
			-- Typically we have: ll-RR where ll is a lowercase language code from ISO 639-1 (or 639-2/T)
			-- and RR is an uppercase region code from ISO 3166-1.
			-- In older Windows versions (actually current when I am typing this) we need to get each one
			-- and glue them together.
			-- We still need to refer to a table to find out if there is a script, sadly
		local
			iso639: STRING_32
			iso3166: STRING_32
			script: detachable STRING
			i: INTEGER
		do
			iso639 := extract_locale_string (lcid, nls_constants.locale_siso639langname)
			iso3166 := extract_locale_string (lcid, nls_constants.locale_siso3166ctryname)
				-- We can get away with this because we know scripts is a small array
			from
				i := 1
			until
				i > scripts.upper
			loop
				if scripts.item (i).lcid = lcid then
					script := scripts.item (i).script
					i := scripts.upper
				end
				i := i + 1
			end
			create Result.make (iso639, iso3166, script)
		end

	locale_id_to_lcid (id: I18N_LOCALE_ID): INTEGER
			-- takes an locale id and returns corresponding LCID
			-- if it returns 0 Something Is Wrong
		require
			argument_not_void: id /= Void
		local
			name: STRING_32
		do
			create name.make_from_string (id.language)
			if (attached id.script as l_script) and then not l_script.is_equal (("euro").as_string_32) then
				name.append_character ('-')
				name.append (l_script)
			end
			name.append_character ('-')
			name.append (id.region)

			if attached locales.item (name) as l_info then
				Result := l_info.lcid
			end
		end

feature {NONE} -- LCIDS

-- Explanation: Windows identifies each locale with a number called an LCID
-- (actually they designate locale+sort order, but that's what things use in windows-land)
-- You can go from LCID to locale name without much problem.
-- You can't go the other way (except by installing an optional addon nobody has heard of)
-- unless you have "Windows Vista or later". So we do it by hand with this thing.
-- full_name isn't used but is potentially useful.

	locales: STRING_TABLE [TUPLE [full_name: STRING_8; lcid: INTEGER]]
			-- Table indexed by ISO code giving the full name and the Windows LCID.

	scripts: ARRAY [TUPLE [script: STRING_8; lcid: INTEGER]]

feature {NONE} -- Initialization

	initialize_locales
			-- Populate locales array and scripts array.
		do
			create locales.make_caseless (250)
			locales.put (["Afrikaans (South Africa)", 0x0436], "af-ZA")
			locales.put (["Amharic (Ethiopia)", 0x045e], "am-ET")
			locales.put (["Arabic (U.A.E.)", 0x3801], "ar-AE")
			locales.put (["Arabic (Bahrain)", 0x3c01], "ar-BH")
			locales.put (["Arabic (Algeria)", 0x1401], "ar-DZ")
			locales.put (["Arabic (Egypt)", 0x0c01], "ar-EG")
			locales.put (["Arabic (Iraq)", 0x0801], "ar-IQ")
			locales.put (["Arabic (Jordan)", 0x2c01], "ar-JO")
			locales.put (["Arabic (Kuwait)", 0x3401], "ar-KW")
			locales.put (["Arabic (Lebanon)", 0x3001], "ar-LB")
			locales.put (["Arabic (Libya)", 0x1001], "ar-LY")
			locales.put (["Arabic (Morocco)", 0x1801], "ar-MA")
			locales.put (["Arabic (Oman)", 0x2001], "ar-OM")
			locales.put (["Arabic (Qatar)", 0x4001], "ar-QA")
			locales.put (["Arabic (Saudi Arabia)", 0x0401], "ar-SA")
			locales.put (["Arabic (Syria)", 0x2801], "ar-SY")
			locales.put (["Arabic (Tunisia)", 0x1c01], "ar-TN")
			locales.put (["Arabic (Yemen)", 0x2401], "ar-YE")
			locales.put (["Mapudungun (Chile)", 0x047a], "arn-CL")
			locales.put (["Assamese (India)", 0x044d], "as-IN")
			locales.put (["Azeri (Azerbaijan, Cyrillic)", 0x082c], "az-Cyrl-AZ")
			locales.put (["Azeri (Azerbaijan, Latin)", 0x042c], "az-Latn-AZ")
			locales.put (["Bashkir (Russia)", 0x046d], "ba-RU")
			locales.put (["Belarusian (Belarus)", 0x0423], "be-BY")
			locales.put (["Bulgarian (Bulgaria)", 0x0402], "bg-BG")
			locales.put (["Bengali (India)", 0x0445], "bn-IN")
			locales.put (["Tibetan (Bhutan)", 0x0851], "bo-BT")
			locales.put (["Tibetan (PRC)", 0x0451], "bo-CN")
			locales.put (["Breton (France)", 0x047e], "br-FR")
			locales.put (["Bosnian (Bosnia and Herzegovina, Cyrillic)", 0x201a], "bs-Cyrl-BA")
			locales.put (["Bosnian (Bosnia and Herzegovina, Latin)", 0x141a], "bs-Latn-BA")
			locales.put (["Catalan (Catalan)", 0x0403], "ca-ES")
			locales.put (["Corsican (France)", 0x0000], "co-FR") -- Note: Corsican is in the msdn table, but has no LCID - maybe in future releases it will get one (corsican nationalists might threaten to blow up Microsoft HQ)
			locales.put (["Czech (Czech Republic)", 0x0405], "cs-CZ")
			locales.put (["Welsh (United Kingdom)", 0x0452], "cy-GB")
			locales.put (["Danish (Denmark)", 0x0406], "da-DK")
			locales.put (["German (Austria)", 0x0c07], "de-AT")
			locales.put (["German (Switzerland)", 0x0807], "de-CH")
			locales.put (["German (Germany)", 0x0407], "de-DE")
			locales.put (["German (Liechtenstein)", 0x1407], "de-LI")
			locales.put (["German (Luxembourg)", 0x1007], "de-LU")
			locales.put (["Lower Sorbian (Germany)", 0x082e], "dsb-DE")
			locales.put (["Divehi (Maldives)", 0x0465], "dv-MV")
			locales.put (["Greek (Greece)", 0x0408], "el-GR")
			locales.put (["English (Caribbean)", 0x2409], "en-029")
			locales.put (["English (Australia)", 0x0c09], "en-AU")
			locales.put (["English (Belize)", 0x2809], "en-BZ")
			locales.put (["English (Canada)", 0x1009], "en-CA")
			locales.put (["English (United Kingdom)", 0x0809], "en-GB")
			locales.put (["English (Ireland)", 0x1809], "en-IE")
			locales.put (["English (India)", 0x4009], "en-IN")
			locales.put (["English (Jamaica)", 0x2009], "en-JM")
			locales.put (["English (Malaysia)", 0x4409], "en-MY")
			locales.put (["English (New Zealand)", 0x1409], "en-NZ")
			locales.put (["English (Philippines)", 0x3409], "en-PH")
			locales.put (["English (Singapore)", 0x4809], "en-SG")
			locales.put (["English (Trinidad and Tobago)", 0x2c09], "en-TT")
			locales.put (["English (United States)", 0x0409], "en-US")
			locales.put (["English (South Africa)", 0x1c09], "en-ZA")
			locales.put (["English (Zimbabwe)", 0x3009], "en-ZW")
			locales.put (["Spanish (Argentina)", 0x2c0a], "es-AR")
			locales.put (["Spanish (Bolivia)", 0x400a], "es-BO")
			locales.put (["Spanish (Chile)", 0x340a], "es-CL")
			locales.put (["Spanish (Colombia)", 0x240a], "es-CO")
			locales.put (["Spanish (Costa Rica)", 0x140a], "es-CR")
			locales.put (["Spanish (Dominican Republic)", 0x1c0a], "es-DO")
			locales.put (["Spanish (Ecuador)", 0x300a], "es-EC")
			locales.put (["Spanish (Spain)", 0x0c0a], "es-ES")
			locales.put (["Spanish (Guatemala)", 0x100a], "es-GT")
			locales.put (["Spanish (Honduras)", 0x480a], "es-HN")
			locales.put (["Spanish (Mexico)", 0x080a], "es-MX")
			locales.put (["Spanish (Nicaragua)", 0x4c0a], "es-NI")
			locales.put (["Spanish (Panama)", 0x180a], "es-PA")
			locales.put (["Spanish (Peru)", 0x280a], "es-PE")
			locales.put (["Spanish (Puerto Rico)", 0x500a], "es-PR")
			locales.put (["Spanish (Paraguay)", 0x3c0a], "es-PY")
			locales.put (["Spanish (El Salvador)", 0x440a], "es-SV")
			locales.put (["Spanish (United States)", 0x540a], "es-US")
			locales.put (["Spanish (Uruguay)", 0x380a], "es-UY")
			locales.put (["Spanish (Venezuela)", 0x200a], "es-VE")
			locales.put (["Estonian (Estonia)", 0x0425], "et-EE")
			locales.put (["Basque (Basque)", 0x042d], "eu-ES")
			locales.put (["Persian (Iran)", 0x0429], "fa-IR")
			locales.put (["Finnish (Finland)", 0x040b], "fi-FI")
			locales.put (["Filipino (Philippines)", 0x0464], "fil-PH")
			locales.put (["Faroese (Faroe Islands)", 0x0438], "fo-FO")
			locales.put (["French (Belgium)", 0x080c], "fr-BE")
			locales.put (["French (Canada)", 0x0c0c], "fr-CA")
			locales.put (["French (Switzerland)", 0x100c], "fr-CH")
			locales.put (["French (France)", 0x040c], "fr-FR")
			locales.put (["French (Luxembourg)", 0x140c], "fr-LU")
			locales.put (["French (Monaco)", 0x180c], "fr-MC")
			locales.put (["Frisian (Netherlands)", 0x0462], "fy-NL")
			locales.put (["Irish (Ireland)", 0x083c], "ga-IE")
			locales.put (["Dari (Afghanistan)", 0x048c], "gbz-AF")
			locales.put (["Galician (Spain)", 0x0456], "gl-ES")
			locales.put (["Alsatian (France)", 0x0484], "gsw-FR")
			locales.put (["Gujarati (India)", 0x0447], "gu-IN")
			locales.put (["Hausa (Nigeria, Latin)", 0x0468], "ha-Latn-NG")
			locales.put (["Hebrew (Israel)", 0x040d], "he-IL")
			locales.put (["Hindi (India)", 0x0439], "hi-IN")
			locales.put (["Croatian (Bosnia and Herzegovina, Latin)", 0x101a], "hr-BA")
			locales.put (["Croatian (Croatia)", 0x041a], "hr-HR")
			locales.put (["Hungarian (Hungary)", 0x040e], "hu-HU")
			locales.put (["Armenian (Armenia)", 0x042b], "hy-AM")
			locales.put (["Indonesian (Indonesia)", 0x0421], "id-ID")
			locales.put (["Igbo (Nigeria)", 0x0470], "ig-NG")
			locales.put (["Yi (PRC)", 0x0478], "ii-CN")
			locales.put (["Icelandic (Iceland)", 0x040f], "is-IS")
			locales.put (["Italian (Switzerland)", 0x0810], "it-CH")
			locales.put (["Italian (Italy)", 0x0410], "it-IT")
			locales.put (["Inuktitut (Canada, Syllabics)", 0x045d], "iu-Cans-CA")
			locales.put (["Inuktitut (Canada, Latin)", 0x085d], "iu-Latn-CA")
			locales.put (["Japanese (Japan)", 0x0411], "ja-JP")
			locales.put (["Georgian (Georgia)", 0x0437], "ka-GE")
			locales.put (["Khmer (Cambodia)", 0x0453], "kh-KH")
			locales.put (["Kazakh (Kazakhstan)", 0x043f], "kk-KZ")
			locales.put (["Greenlandic (Greenland)", 0x046f], "kl-GL")
			locales.put (["Kannada (India)", 0x044b], "kn-IN")
			locales.put (["Korean (Korea)", 0x0412], "ko-KR")
			locales.put (["Konkani (India)", 0x0457], "kok-IN")
			locales.put (["Kyrgyz (Kyrgyzstan)", 0x0440], "ky-KG")
			locales.put (["Luxembourgish (Luxembourg)", 0x046e], "lb-LU")
			locales.put (["Lao (Lao PDR)", 0x0454], "lo-LA")
			locales.put (["Lithuanian (Lithuania)", 0x0427], "lt-LT")
			locales.put (["Latvian (Latvia)", 0x0426], "lv-LV")
			locales.put (["Maori (New Zealand)", 0x0481], "mi-NZ")
			locales.put (["Macedonian (Macedonia, FYROM)", 0x042f], "mk-MK")
			locales.put (["Malayalam (India)", 0x044c], "ml-IN")
			locales.put (["Mongolian (Mongolia)", 0x0450], "mn-Cyrl-MN")
			locales.put (["Mongolian (PRC)", 0x0850], "mn-Mong-CN")
			locales.put (["Mohawk (Canada)", 0x047c], "moh-CA")
			locales.put (["Marathi (India)", 0x044e], "mr-IN")
			locales.put (["Malay (Brunei Darussalam)", 0x083e], "ms-BN")
			locales.put (["Malay (Malaysia)", 0x043e], "ms-MY")
			locales.put (["Maltese (Malta)", 0x043a], "mt-MT")
			locales.put (["Norwegian (Bokmål, Norway)", 0x0414], "nb-NO")
			locales.put (["Nepali (India)", 0x0000], "ne-IN") --also missing
			locales.put (["Nepali (Nepal)", 0x0461], "ne-NP")
			locales.put (["Dutch (Belgium)", 0x0813], "nl-BE")
			locales.put (["Dutch (Netherlands)", 0x0413], "nl-NL")
			locales.put (["Norwegian (Nynorsk, Norway)", 0x0814], "nn-NO")
			locales.put (["Sesotho sa Leboa/Northern Sotho (South Africa)", 0x046c], "ns-ZA")
			locales.put (["Occitan (France)", 0x0482], "oc-FR")
			locales.put (["Oriya (India)", 0x0448], "or-IN")
			locales.put (["Punjabi (India)", 0x0446], "pa-IN")
			locales.put (["Polish (Poland)", 0x0415], "pl-PL")
			locales.put (["Pashto (Afghanistan)", 0x0463], "ps-AF")
			locales.put (["Portuguese (Brazil)", 0x0416], "pt-BR")
			locales.put (["Portuguese (Portugal)", 0x0816], "pt-PT")
			locales.put (["K'iche (Guatemala)", 0x0486], "qut-GT")
			locales.put (["Quechua (Bolivia)", 0x046b], "quz-BO")
			locales.put (["Quechua (Ecuador)", 0x086b], "quz-EC")
			locales.put (["Quechua (Peru)", 0x0c6b], "quz-PE")
			locales.put (["Romansh (Switzerland)", 0x0417], "rm-CH")
			locales.put (["Romanian (Romania)", 0x0418], "ro-RO")
			locales.put (["Russian (Russia)", 0x0419], "ru-RU")
			locales.put (["Kinyarwanda (Rwanda)", 0x0487], "rw-RW")
			locales.put (["Sanskrit (India)", 0x044f], "sa-IN")
			locales.put (["Yakut (Russia)", 0x0485], "sah-RU")
			locales.put (["Sami (Northern, Finland)", 0x0c3b], "se-FI")
			locales.put (["Sami (Northern, Norway)", 0x043b], "se-NO")
			locales.put (["Sami (Northern, Sweden)", 0x083b], "se-SE")
			locales.put (["Sinhala (Sri Lanka)", 0x045b], "si-LK")
			locales.put (["Slovak (Slovakia)", 0x041b], "sk-SK")
			locales.put (["Slovenian (Slovenia)", 0x0424], "sl-SI")
			locales.put (["Sami (Southern, Norway)", 0x183b], "sma-NO")
			locales.put (["Sami (Southern, Sweden)", 0x1c3b], "sma-SE")
			locales.put (["Sami (Lule, Norway)", 0x103b], "smj-NO")
			locales.put (["Sami (Lule, Sweden)", 0x143b], "smj-SE")
			locales.put (["Sami (Inari, Finland)", 0x243b], "smn-FI")
			locales.put (["Sami (Skolt, Finland)", 0x203b], "sms-FI")
			locales.put (["Albanian (Albania)", 0x041c], "sq-AL")
			locales.put (["Serbian (Bosnia and Herzegovina, Cyrillic)", 0x1c1a], "sr-Cyrl-BA")
			locales.put (["Serbian (Serbia and Montenegro, Cyrillic)", 0x0c1a], "sr-Cyrl-CS")
			locales.put (["Serbian (Bosnia and Herzegovina, Latin)", 0x181a], "sr-Latn-BA")
			locales.put (["Serbian (Serbia and Montenegro, Latin)", 0x081a], "sr-Latn-CS")
			locales.put (["Swedish (Finland)", 0x081d], "sv-FI")
			locales.put (["Swedish (Sweden)", 0x041d], "sv-SE")
			locales.put (["Swahili (Kenya)", 0x0441], "sw-KE")
			locales.put (["Syriac (Syria)", 0x045a], "syr-SY")
			locales.put (["Tamil (India)", 0x0449], "ta-IN")
			locales.put (["Telugu (India)", 0x044a], "te-IN")
			locales.put (["Tajik (Tajikistan)", 0x0428], "tg-Cyrl-TJ")
			locales.put (["Thai (Thailand)", 0x041e], "th-TH")
			locales.put (["Turkmen (Turkmenistan)", 0x0442], "tk-TM")
			locales.put (["Tamazight (Algeria, Latin)", 0x085f], "tmz-Latn-DZ")
			locales.put (["Setswana/Tswana (South Africa)", 0x0432], "tn-ZA")
			locales.put (["Urdu (India)", 0x0820], "tr-IN")
			locales.put (["Turkish (Turkey)", 0x041f], "tr-TR")
			locales.put (["Tatar (Russia)", 0x0444], "tt-RU")
			locales.put (["Uighur (PRC)", 0x0480], "ug-CN")
			locales.put (["Ukrainian (Ukraine)", 0x0422], "uk-UA")
			locales.put (["Urdu (Pakistan)", 0x0420], "ur-PK")
			locales.put (["Uzbek (Uzbekistan, Cyrillic)", 0x0843], "uz-Cyrl-UZ")
			locales.put (["Uzbek (Uzbekistan, Latin)", 0x0443], "uz-Latn-UZ")
			locales.put (["Vietnamese (Vietnam)", 0x042a], "vi-VN")
			locales.put (["Upper Sorbian (Germany)", 0x042e], "wen-DE")
			locales.put (["Wolof (Senegal)", 0x0488], "wo-SN")
			locales.put (["Xhosa/isiXhosa (South Africa)", 0x0434], "xh-ZA")
			locales.put (["Yoruba (Nigeria)", 0x046a], "yo-NG")
			locales.put (["Chinese (PRC)", 0x0804], "zh-CN")
			locales.put (["Chinese (Hong Kong SAR, PRC)", 0x0c04], "zh-HK")
			locales.put (["Chinese (Macao SAR)", 0x1404], "zh-MO")
			locales.put (["Chinese (Singapore)", 0x1004], "zh-SG")
			locales.put (["Chinese (Taiwan)", 0x0404], "zh-TW")
			locales.put (["Zulu/isiZulu (South Africa)", 0x0435], "zu-ZA")

			scripts := <<
					["Cyrl", 0x0428],
					["Latn", 0x042c],
					["Latn", 0x0443],
					["Cyrl", 0x0450],
					["Cans", 0x045d],
					["Latn", 0x0468],
					["Latn", 0x081a],
					["Cyrl", 0x082c],
					["Cyrl", 0x0843],
					["Mong", 0x0850],
					["Latn", 0x085d],
					["Latn", 0x085f],
					["Cyrl", 0x0c1a],
					["Latn", 0x141a],
					["Latn", 0x181a],
					["Cyrl", 0x1c1a],
					["Cyrl", 0x201a]
				>>
		end

feature {NONE} -- C functions

	is_valid_locale (lcid: INTEGER; flags: INTEGER): BOOLEAN
			-- encapsulation of IsValidLocaleName
		external
			"C signature (LCID, DWORD): BOOL use <windows.h>"
		alias
			"IsValidLocale"
		end

invariant
	attached locales

note
	ca_ignore: "CA032", "CA032: too long feature"
	library: "Internationalization library"
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
