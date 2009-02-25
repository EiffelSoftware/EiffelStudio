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

	is_supported_locale(lcid:INTEGER):BOOLEAN
			-- Is the given LCID supported _and_ installed?
		do
				-- Possible flags, from winnls.h :
				--#define LCID_INSTALLED            0x00000001  // installed locale ids
				--#define LCID_SUPPORTED            0x00000002  // supported locale ids
			Result := is_valid_locale(lcid, 2)
		end

	supported_locales: LIST[I18N_LOCALE_ID]
			--  List all installed locales
		local
			i: INTEGER
		do
			create {LINKED_LIST[I18N_LOCALE_ID]} Result.make
			from
				i := 1
			until
				i > locales.upper
			loop
				if is_supported_locale (locales.item (i).lcid) then
					Result.extend (lcid_to_locale_id (locales.item (i).lcid))
				end
				i := i + 1
			end
		end

	lcid_to_locale_id(lcid: INTEGER):I18N_LOCALE_ID
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
			script: STRING_32
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

	locale_id_to_lcid(id: I18N_LOCALE_ID):INTEGER
			-- takes an locale id and returns corresponding LCID
			-- if it returns 0 Something Is Wrong
		require
			argument_not_void: id /= Void
		local
			left, right, middle: INTEGER
			found: BOOLEAN
			name, t_string: STRING_32
		do

			create name.make_from_string(id.language)
			if (id.script /= Void and then not id.script.is_equal ("euro")) then
				name.append ("-"+id.script)
			end
			name.append ("-"+id.region)
				-- locales is sorted by iso_code, so we can use etienne's well-contracted binary search

			from
				left := locales.lower
				right := locales.upper
			invariant
				right < locales.upper
						implies locales.item(right + 1).iso_code <= locales.item(locales.upper).iso_code
				left <= locales.upper and left > locales.lower
						implies locales.item(left - 1).iso_code <= locales.item(locales.upper).iso_code
			variant
				right - left + 1
			until
				left > right or found
			loop
				middle := ((left + right).as_natural_32 |>> 1).as_integer_32
				t_string := locales.item(middle).iso_code
				if name < t_string then
					right := middle - 1
				elseif name > t_string then
					left := middle + 1
				else
						-- Found
					found := True
					Result := locales.item (middle).lcid
					left := left + 1 -- not nice but required to decrease variant
				end
			end
		end

feature {NONE}  -- LCIDS

-- Explanation: Windows identifies each locale with a number called an LCID
-- (actually they designate locale+sort order, but that's what things use in windows-land)
-- You can go from LCID to locale name without much problem.
-- You can't go the other way (except by installing an optional addon nobody has heard of)
-- unless you have "Windows Vista or later". So we do it by hand with this thing.
-- full_name isn't used but is potentially useful.

	locales: ARRAY[TUPLE[full_name:STRING_8; iso_code:STRING_8; lcid:INTEGER]]
	scripts: ARRAY[TUPLE[script: STRING_8; lcid:INTEGER]]

feature -- Initialisation

	initialize_locales
			-- populate locales array and scripts array
		do
			locales := <<
				["Afrikaans (South Africa)",	"af-ZA",	0x0436],
				["Amharic (Ethiopia)",		"am-ET",	0x045e],
				["Arabic (U.A.E.)",		"ar-AE",	0x3801],
				["Arabic (Bahrain)",		"ar-BH",	0x3c01],
				["Arabic (Algeria)",		"ar-DZ",	0x1401],
				["Arabic (Egypt)",		"ar-EG",	0x0c01],
				["Arabic (Iraq)",		"ar-IQ",	0x0801],
				["Arabic (Jordan)",		"ar-JO",	0x2c01],
				["Arabic (Kuwait)",		"ar-KW",	0x3401],
				["Arabic (Lebanon)",		"ar-LB",	0x3001],
				["Arabic (Libya)",		"ar-LY",	0x1001],
				["Arabic (Morocco)",		"ar-MA",	0x1801],
				["Arabic (Oman)",		"ar-OM",	0x2001],
				["Arabic (Qatar)",		"ar-QA",	0x4001],
				["Arabic (Saudi Arabia)",	"ar-SA",	0x0401],
				["Arabic (Syria)",		"ar-SY",	0x2801],
				["Arabic (Tunisia)",		"ar-TN",	0x1c01],
				["Arabic (Yemen)",		"ar-YE",	0x2401],
				["Mapudungun (Chile)",		"arn-CL",	0x047a],
				["Assamese (India)",		"as-IN",	0x044d],
				["Azeri (Azerbaijan, Cyrillic)",	"az-Cyrl-AZ",	0x082c],
				["Azeri (Azerbaijan, Latin)",		"az-Latn-AZ",	0x042c],
				["Bashkir (Russia)",		"ba-RU",	0x046d],
				["Belarusian (Belarus)",	"be-BY",	0x0423],
				["Bulgarian (Bulgaria)",	"bg-BG",	0x0402],
				["Bengali (India)",		"bn-IN",	0x0445],
				["Tibetan (Bhutan)",		"bo-BT", 	0x0851],
				["Tibetan (PRC)", 		"bo-CN",	0x0451],
				["Breton (France)", 		"br-FR",	0x047e],
				["Bosnian (Bosnia and Herzegovina, Cyrillic)",	"bs-Cyrl-BA",	0x201a],
				["Bosnian (Bosnia and Herzegovina, Latin)",	"bs-Latn-BA",	0x141a],
				["Catalan (Catalan)", 		"ca-ES",	0x0403],
				["Corsican (France)", 		"co-FR",	0x0000], -- Note: Corsican is in the msdn table, but has no LCID - maybe in future releases it will get one (corsican nationalists might threaten to blow up Microsoft HQ)
				["Czech (Czech Republic)",	"cs-CZ",	0x0405],
				["Welsh (United Kingdom)",	"cy-GB",	0x0452],
				["Danish (Denmark)", 		"da-DK",	0x0406],
				["German (Austria)", 		"de-AT",	0x0c07],
				["German (Switzerland)", 	"de-CH",	0x0807],
				["German (Germany)",		"de-DE",	0x0407],
				["German (Liechtenstein)",	"de-LI",	0x1407],
				["German (Luxembourg)",		"de-LU",	0x1007],
				["Lower Sorbian (Germany)",	"dsb-DE",	0x082e],
				["Divehi (Maldives)",		"dv-MV",	0x0465],
				["Greek (Greece)",		"el-GR",	0x0408],
				["English (Caribbean)",		"en-029",	0x2409],
				["English (Australia)",		"en-AU",	0x0c09],
				["English (Belize)",		"en-BZ",	0x2809],
				["English (Canada)",		"en-CA",	0x1009],
				["English (United Kingdom)","en-GB",	0x0809],
				["English (Ireland)",		"en-IE",	0x1809],
				["English (India)",		"en-IN",	0x4009],
				["English (Jamaica)",		"en-JM",	0x2009],
				["English (Malaysia)",		"en-MY",	0x4409],
				["English (New Zealand)",	"en-NZ",	0x1409],
				["English (Philippines)",	"en-PH",	0x3409],
				["English (Singapore)",		"en-SG",	0x4809],
				["English (Trinidad and Tobago)",	"en-TT",	0x2c09],
				["English (United States)",	"en-US",	0x0409],
				["English (South Africa)",	"en-ZA",	0x1c09],
				["English (Zimbabwe)",		"en-ZW",	0x3009],
				["Spanish (Argentina)",		"es-AR",	0x2c0a],
				["Spanish (Bolivia)",		"es-BO",	0x400a],
				["Spanish (Chile)",			"es-CL",	0x340a],
				["Spanish (Colombia)",		"es-CO",	0x240a],
				["Spanish (Costa Rica)",	"es-CR",	0x140a],
				["Spanish (Dominican Republic)",	"es-DO",	0x1c0a],
				["Spanish (Ecuador)", 		"es-EC",	0x300a],
				["Spanish (Spain)",			"es-ES",	0x0c0a],
				["Spanish (Guatemala)",		"es-GT",	0x100a],
				["Spanish (Honduras)",		"es-HN",	0x480a],
				["Spanish (Mexico)",		"es-MX",	0x080a],
				["Spanish (Nicaragua)",		"es-NI",	0x4c0a],
				["Spanish (Panama)",		"es-PA",	0x180a],
				["Spanish (Peru)",			"es-PE",	0x280a],
				["Spanish (Puerto Rico)",	"es-PR",	0x500a],
				["Spanish (Paraguay)",		"es-PY",	0x3c0a],
				["Spanish (El Salvador)",	"es-SV",	0x440a],
				["Spanish (United States)",	"es-US",	0x540a],
				["Spanish (Uruguay)",		"es-UY",	0x380a],
				["Spanish (Venezuela)",		"es-VE",	0x200a],
				["Estonian (Estonia)",		"et-EE",	0x0425],
				["Basque (Basque)",			"eu-ES",	0x042d],
				["Persian (Iran)",			"fa-IR",	0x0429],
				["Finnish (Finland)",		"fi-FI",	0x040b],
				["Filipino (Philippines)",	"fil-PH",	0x0464],
				["Faroese (Faroe Islands)",	"fo-FO",	0x0438],
				["French (Belgium)",		"fr-BE",	0x080c],
				["French (Canada)",			"fr-CA",	0x0c0c],
				["French (Switzerland)",	"fr-CH",	0x100c],
				["French (France)",			"fr-FR",	0x040c],
				["French (Luxembourg)",		"fr-LU",	0x140c],
				["French (Monaco)",			"fr-MC",	0x180c],
				["Frisian (Netherlands)",	"fy-NL",	0x0462],
				["Irish (Ireland)",			"ga-IE",	0x083c],
				["Dari (Afghanistan)",		"gbz-AF",	0x048c],
				["Galician (Spain)",		"gl-ES",	0x0456],
				["Alsatian (France)",		"gsw-FR",	0x0484],
				["Gujarati (India)",		"gu-IN",	0x0447],
				["Hausa (Nigeria, Latin)",	"ha-Latn-NG",	0x0468],
				["Hebrew (Israel)",			"he-IL",	0x040d],
				["Hindi (India)",			"hi-IN",	0x0439],
				["Croatian (Bosnia and Herzegovina, Latin)",	"hr-BA",	0x101a],
				["Croatian (Croatia)",		"hr-HR",	0x041a],
				["Hungarian (Hungary)",		"hu-HU",	0x040e],
				["Armenian (Armenia)",		"hy-AM",	0x042b],
				["Indonesian (Indonesia)",	"id-ID",	0x0421],
				["Igbo (Nigeria)",			"ig-NG",	0x0470],
				["Yi (PRC)",				"ii-CN",	0x0478],
				["Icelandic (Iceland)",		"is-IS",	0x040f],
				["Italian (Switzerland)",	"it-CH",	0x0810],
				["Italian (Italy)",			"it-IT",	0x0410],
				["Inuktitut (Canada, Syllabics)",	"iu-Cans-CA",	0x045d],
				["Inuktitut (Canada, Latin)",		"iu-Latn-CA",	0x085d],
				["Japanese (Japan)",		"ja-JP",	0x0411],
				["Georgian (Georgia)",		"ka-GE",	0x0437],
				["Khmer (Cambodia)",		"kh-KH",	0x0453],
				["Kazakh (Kazakhstan)",		"kk-KZ",	0x043f],
				["Greenlandic (Greenland)",	"kl-GL",	0x046f],
				["Kannada (India)",			"kn-IN",	0x044b],
				["Korean (Korea)",			"ko-KR",	0x0412],
				["Konkani (India)",			"kok-IN",	0x0457],
				["Kyrgyz (Kyrgyzstan)",		"ky-KG",	0x0440],
				["Luxembourgish (Luxembourg)",		"lb-LU",	0x046e],
				["Lao (Lao PDR)",			"lo-LA",	0x0454],
				["Lithuanian (Lithuania)",	"lt-LT",	0x0427],
				["Latvian (Latvia)",		"lv-LV",	0x0426],
				["Maori (New Zealand)",		"mi-NZ",	0x0481],
				["Macedonian (Macedonia, FYROM)",	"mk-MK",	0x042f],
				["Malayalam (India)",		"ml-IN",	0x044c],
				["Mongolian (Mongolia)",	"mn-Cyrl-MN",	0x0450],
				["Mongolian (PRC)",			"mn-Mong-CN",	0x0850],
				["Mohawk (Canada)",			"moh-CA",	0x047c],
				["Marathi (India)",			"mr-IN",	0x044e],
				["Malay (Brunei Darussalam)",		"ms-BN",	0x083e],
				["Malay (Malaysia)",		"ms-MY",	0x043e],
				["Maltese (Malta)",			"mt-MT",	0x043a],
				["Norwegian (Bokmål, Norway)",		"nb-NO",	0x0414],
				["Nepali (India)",			"ne-IN",	0x0000], --also missing	
				["Nepali (Nepal)",			"ne-NP",	0x0461],
				["Dutch (Belgium)",			"nl-BE",	0x0813],
				["Dutch (Netherlands)",		"nl-NL",	0x0413],
				["Norwegian (Nynorsk, Norway)",		"nn-NO",	0x0814],
				["Sesotho sa Leboa/Northern Sotho (South Africa)",		"ns-ZA",	0x046c],
				["Occitan (France)",		"oc-FR",	0x0482],
				["Oriya (India)",			"or-IN",	0x0448],
				["Punjabi (India)",			"pa-IN",	0x0446],
				["Polish (Poland)",			"pl-PL",	0x0415],
				["Pashto (Afghanistan)",	"ps-AF",	0x0463],
				["Portuguese (Brazil)",		"pt-BR",	0x0416],
				["Portuguese (Portugal)",	"pt-PT",	0x0816],
				["K'iche (Guatemala)",		"qut-GT",	0x0486],
				["Quechua (Bolivia)",		"quz-BO",	0x046b],
				["Quechua (Ecuador)",		"quz-EC",	0x086b],
				["Quechua (Peru)",			"quz-PE",	0x0c6b],
				["Romansh (Switzerland)",	"rm-CH",	0x0417],
				["Romanian (Romania)",		"ro-RO",	0x0418],
				["Russian (Russia)",		"ru-RU",	0x0419],
				["Kinyarwanda (Rwanda)",	"rw-RW",	0x0487],
				["Sanskrit (India)",		"sa-IN",	0x044f],
				["Yakut (Russia)",			"sah-RU",	0x0485],
				["Sami (Northern, Finland)","se-FI",	0x0c3b],
				["Sami (Northern, Norway)",	"se-NO",	0x043b],
				["Sami (Northern, Sweden)",	"se-SE",	0x083b],
				["Sinhala (Sri Lanka)",		"si-LK",	0x045b],
				["Slovak (Slovakia)",		"sk-SK",	0x041b],
				["Slovenian (Slovenia)",	"sl-SI",	0x0424],
				["Sami (Southern, Norway)",	"sma-NO",	0x183b],
				["Sami (Southern, Sweden)",	"sma-SE",	0x1c3b],
				["Sami (Lule, Norway)",		"smj-NO",	0x103b],
				["Sami (Lule, Sweden)",		"smj-SE",	0x143b],
				["Sami (Inari, Finland)",	"smn-FI",	0x243b],
				["Sami (Skolt, Finland)",	"sms-FI",	0x203b],
				["Albanian (Albania)",		"sq-AL",	0x041c],
				["Serbian (Bosnia and Herzegovina, Cyrillic)",	"sr-Cyrl-BA",	0x1c1a],
				["Serbian (Serbia and Montenegro, Cyrillic)",	"sr-Cyrl-CS",	0x0c1a],
				["Serbian (Bosnia and Herzegovina, Latin)",		"sr-Latn-BA",	0x181a],
				["Serbian (Serbia and Montenegro, Latin)",		"sr-Latn-CS",	0x081a],
				["Swedish (Finland)",		"sv-FI",	0x081d],
				["Swedish (Sweden)",		"sv-SE",	0x041d],
				["Swahili (Kenya)",			"sw-KE",	0x0441],
				["Syriac (Syria)",			"syr-SY",	0x045a],
				["Tamil (India)",			"ta-IN",	0x0449],
				["Telugu (India)",			"te-IN",	0x044a],
				["Tajik (Tajikistan)",		"tg-Cyrl-TJ",	0x0428],
				["Thai (Thailand)",			"th-TH",	0x041e],
				["Turkmen (Turkmenistan)",	"tk-TM",	0x0442],
				["Tamazight (Algeria, Latin)",		"tmz-Latn-DZ",	0x085f],
				["Setswana/Tswana (South Africa)",	"tn-ZA",	0x0432],
				["Urdu (India)",			"tr-IN",	0x0820],
				["Turkish (Turkey)",		"tr-TR",	0x041f],
				["Tatar (Russia)",			"tt-RU",	0x0444],
				["Uighur (PRC)",			"ug-CN",	0x0480],
				["Ukrainian (Ukraine)",		"uk-UA",	0x0422],
				["Urdu (Pakistan)",			"ur-PK",	0x0420],
				["Uzbek (Uzbekistan, Cyrillic)",	"uz-Cyrl-UZ",	0x0843],
				["Uzbek (Uzbekistan, Latin)",		"uz-Latn-UZ",	0x0443],
				["Vietnamese (Vietnam)",	"vi-VN",	0x042a],
				["Upper Sorbian (Germany)",	"wen-DE",	0x042e],
				["Wolof (Senegal)",			"wo-SN",	0x0488],
				["Xhosa/isiXhosa (South Africa)",	"xh-ZA",	0x0434],
				["Yoruba (Nigeria)",				"yo-NG",	0x046a],
				["Chinese (PRC)",			"zh-CN",	0x0804],
				["Chinese (Hong Kong SAR, PRC)",	"zh-HK",	0x0c04],
				["Chinese (Macao SAR)",		"zh-MO",	0x1404],
				["Chinese (Singapore)",		"zh-SG",	0x1004],
				["Chinese (Taiwan)",		"zh-TW",	0x0404],
				["Zulu/isiZulu (South Africa)",		"zu-ZA",	0x0435]
			>>
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


	is_valid_locale(lcid:INTEGER; flags:INTEGER):BOOLEAN
			-- encapsulation of IsValidLocaleName
		external
			"C signature (LCID, DWORD): BOOL use <windows.h>"
		alias
			"IsValidLocale"
		end

invariant
	locales /= Void

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
