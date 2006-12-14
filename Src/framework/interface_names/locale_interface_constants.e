indexing
	description: "Mapping between locale ids and names"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOCALE_INTERFACE_CONSTANTS

inherit
	SHARED_LOCALE

feature -- Access

	locales: HASH_TABLE [STRING_GENERAL, STRING] is
		once
			create Result.make (300)
			Result.force (locale.translate ("Afrikaans (South Africa)"), "af-ZA")
			Result.force (locale.translate ("Amharic (Ethiopia)"), "am-ET")
			Result.force (locale.translate ("Arabic (U.A.E.)"), "ar-AE")
			Result.force (locale.translate ("Arabic (Bahrain)"), "ar-BH")
			Result.force (locale.translate ("Arabic (Algeria)"), "ar-DZ")
			Result.force (locale.translate ("Arabic (Egypt)"), "ar-EG")
			Result.force (locale.translate ("Arabic (Iraq)"), "ar-IQ")
			Result.force (locale.translate ("Arabic (Jordan)"), "ar-JO")
			Result.force (locale.translate ("Arabic (Kuwait)"), "ar-KW")
			Result.force (locale.translate ("Arabic (Lebanon)"), "ar-LB")
			Result.force (locale.translate ("Arabic (Libya)"), "ar-LY")
			Result.force (locale.translate ("Arabic (Morocco)"), "ar-MA")
			Result.force (locale.translate ("Arabic (Oman)"), "ar-OM")
			Result.force (locale.translate ("Arabic (Qatar)"), "ar-QA")
			Result.force (locale.translate ("Arabic (Saudi Arabia)"), "ar-SA")
			Result.force (locale.translate ("Arabic (Syria)"), "ar-SY")
			Result.force (locale.translate ("Arabic (Tunisia)"), "ar-TN")
			Result.force (locale.translate ("Arabic (Yemen)"), "ar-YE")
			Result.force (locale.translate ("Mapudungun (Chile)"), "arn-CL")
			Result.force (locale.translate ("Assamese (India)"), "as-IN")
			Result.force (locale.translate ("Azeri (Azerbaijan, Cyrillic)"), "az-Cyrl-AZ")
			Result.force (locale.translate ("Azeri (Azerbaijan, Latin)"), "az-Latn-AZ")
			Result.force (locale.translate ("Bashkir (Russia)"), "ba-RU")
			Result.force (locale.translate ("Belarusian (Belarus)"), "be-BY")
			Result.force (locale.translate ("Bulgarian (Bulgaria)"), "bg-BG")
			Result.force (locale.translate ("Bengali (India)"), "bn-IN")
			Result.force (locale.translate ("Tibetan (Bhutan)"), "bo-BT")
			Result.force (locale.translate ("Tibetan (PRC)"), "bo-CN")
			Result.force (locale.translate ("Breton (France)"), "br-FR")
			Result.force (locale.translate ("Bosnian (Bosnia and Herzegovina, Cyrillic)"), "bs-Cyrl-BA")
			Result.force (locale.translate ("Bosnian (Bosnia and Herzegovina, Latin)"), "bs-Latn-BA")
			Result.force (locale.translate ("Catalan (Catalan)"), "ca-ES")
			Result.force (locale.translate ("Corsican (France)"), "co-FR")
			Result.force (locale.translate ("Czech (Czech Republic)"), "cs-CZ")
			Result.force (locale.translate ("Welsh (United Kingdom)"), "cy-GB")
			Result.force (locale.translate ("Danish (Denmark)"), "da-DK")
			Result.force (locale.translate ("German (Austria)"), "de-AT")
			Result.force (locale.translate ("German (Switzerland)"), "de-CH")
			Result.force (locale.translate ("German (Germany)"), "de-DE")
			Result.force (locale.translate ("German (Liechtenstein)"), "de-LI")
			Result.force (locale.translate ("German (Luxembourg)"), "de-LU")
			Result.force (locale.translate ("Lower Sorbian (Germany)"), "dsb-DE")
			Result.force (locale.translate ("Divehi (Maldives)"), "dv-MV")
			Result.force (locale.translate ("Greek (Greece)"), "el-GR")
			Result.force (locale.translate ("English (Caribbean)"), "en-029")
			Result.force (locale.translate ("English (Australia)"), "en-AU")
			Result.force (locale.translate ("English (Belize)"), "en-BZ")
			Result.force (locale.translate ("English (Canada)"), "en-CA")
			Result.force (locale.translate ("English (United Kingdom)"), "en-GB")
			Result.force (locale.translate ("English (Ireland)"), "en-IE")
			Result.force (locale.translate ("English (India)"), "en-IN")
			Result.force (locale.translate ("English (Jamaica)"), "en-JM")
			Result.force (locale.translate ("English (Malaysia)"), "en-MY")
			Result.force (locale.translate ("English (New Zealand)"), "en-NZ")
			Result.force (locale.translate ("English (Philippines)"), "en-PH")
			Result.force (locale.translate ("English (Singapore)"), "en-SG")
			Result.force (locale.translate ("English (Trinidad and Tobago)"), "en-TT")
			Result.force (locale.translate ("English (United States)"), "en-US")
			Result.force (locale.translate ("English (South Africa)"), "en-ZA")
			Result.force (locale.translate ("English (Zimbabwe)"), "en-ZW")
			Result.force (locale.translate ("Spanish (Argentina)"), "es-AR")
			Result.force (locale.translate ("Spanish (Bolivia)"), "es-BO")
			Result.force (locale.translate ("Spanish (Chile)"), "es-CL")
			Result.force (locale.translate ("Spanish (Colombia)"), "es-CO")
			Result.force (locale.translate ("Spanish (Costa Rica)"), "es-CR")
			Result.force (locale.translate ("Spanish (Dominican Republic)"), "es-DO")
			Result.force (locale.translate ("Spanish (Ecuador)"), "es-EC")
			Result.force (locale.translate ("Spanish (Spain)"), "es-ES")
			Result.force (locale.translate ("Spanish (Guatemala)"), "es-GT")
			Result.force (locale.translate ("Spanish (Honduras)"), "es-HN")
			Result.force (locale.translate ("Spanish (Mexico)"), "es-MX")
			Result.force (locale.translate ("Spanish (Nicaragua)"), "es-NI")
			Result.force (locale.translate ("Spanish (Panama)"), "es-PA")
			Result.force (locale.translate ("Spanish (Peru)"), "es-PE")
			Result.force (locale.translate ("Spanish (Puerto Rico)"), "es-PR")
			Result.force (locale.translate ("Spanish (Paraguay)"), "es-PY")
			Result.force (locale.translate ("Spanish (El Salvador)"), "es-SV")
			Result.force (locale.translate ("Spanish (United States)"), "es-US")
			Result.force (locale.translate ("Spanish (Uruguay)"), "es-UY")
			Result.force (locale.translate ("Spanish (Venezuela)"), "es-VE")
			Result.force (locale.translate ("Estonian (Estonia)"), "et-EE")
			Result.force (locale.translate ("Basque (Basque)"), "eu-ES")
			Result.force (locale.translate ("Persian (Iran)"), "fa-IR")
			Result.force (locale.translate ("Finnish (Finland)"), "fi-FI")
			Result.force (locale.translate ("Filipino (Philippines)"), "fil-PH")
			Result.force (locale.translate ("Faroese (Faroe Islands)"), "fo-FO")
			Result.force (locale.translate ("French (Belgium)"), "fr-BE")
			Result.force (locale.translate ("French (Canada)"), "fr-CA")
			Result.force (locale.translate ("French (Switzerland)"), "fr-CH")
			Result.force (locale.translate ("French (France)"), "fr-FR")
			Result.force (locale.translate ("French (Luxembourg)"), "fr-LU")
			Result.force (locale.translate ("French (Monaco)"), "fr-MC")
			Result.force (locale.translate ("Frisian (Netherlands)"), "fy-NL")
			Result.force (locale.translate ("Irish (Ireland)"), "ga-IE")
			Result.force (locale.translate ("Dari (Afghanistan)"), "gbz-AF")
			Result.force (locale.translate ("Galician (Spain)"), "gl-ES")
			Result.force (locale.translate ("Alsatian (France)"), "gsw-FR")
			Result.force (locale.translate ("Gujarati (India)"), "gu-IN")
			Result.force (locale.translate ("Hausa (Nigeria, Latin)"), "ha-Latn-NG")
			Result.force (locale.translate ("Hebrew (Israel)"), "he-IL")
			Result.force (locale.translate ("Hindi (India)"), "hi-IN")
			Result.force (locale.translate ("Croatian (Bosnia and Herzegovina, Latin)"), "hr-BA")
			Result.force (locale.translate ("Croatian (Croatia)"), "hr-HR")
			Result.force (locale.translate ("Hungarian (Hungary)"), "hu-HU")
			Result.force (locale.translate ("Armenian (Armenia)"), "hy-AM")
			Result.force (locale.translate ("Indonesian (Indonesia)"), "id-ID")
			Result.force (locale.translate ("Igbo (Nigeria)"), "ig-NG")
			Result.force (locale.translate ("Yi (PRC)"), "ii-CN")
			Result.force (locale.translate ("Icelandic (Iceland)"), "is-IS")
			Result.force (locale.translate ("Italian (Switzerland)"), "it-CH")
			Result.force (locale.translate ("Italian (Italy)"), "it-IT")
			Result.force (locale.translate ("Inuktitut (Canada, Syllabics)"), "iu-Cans-CA")
			Result.force (locale.translate ("Inuktitut (Canada, Latin)"), "iu-Latn-CA")
			Result.force (locale.translate ("Japanese (Japan)"), "ja-JP")
			Result.force (locale.translate ("Georgian (Georgia)"), "ka-GE")
			Result.force (locale.translate ("Khmer (Cambodia)"), "kh-KH")
			Result.force (locale.translate ("Kazakh (Kazakhstan)"), "kk-KZ")
			Result.force (locale.translate ("Greenlandic (Greenland)"), "kl-GL")
			Result.force (locale.translate ("Kannada (India)"), "kn-IN")
			Result.force (locale.translate ("Korean (Korea)"), "ko-KR")
			Result.force (locale.translate ("Konkani (India)"), "kok-IN")
			Result.force (locale.translate ("Kyrgyz (Kyrgyzstan)"), "ky-KG")
			Result.force (locale.translate ("Luxembourgish (Luxembourg)"), "lb-LU")
			Result.force (locale.translate ("Lao (Lao PDR)"), "lo-LA")
			Result.force (locale.translate ("Lithuanian (Lithuania)"), "lt-LT")
			Result.force (locale.translate ("Latvian (Latvia)"), "lv-LV")
			Result.force (locale.translate ("Maori (New Zealand)"), "mi-NZ")
			Result.force (locale.translate ("Macedonian (Macedonia, FYROM)"), "mk-MK")
			Result.force (locale.translate ("Malayalam (India)"), "ml-IN")
			Result.force (locale.translate ("Mongolian (Mongolia)"), "mn-Cyrl-MN")
			Result.force (locale.translate ("Mongolian (PRC)"), "mn-Mong-CN")
			Result.force (locale.translate ("Mohawk (Canada)"), "moh-CA")
			Result.force (locale.translate ("Marathi (India)"), "mr-IN")
			Result.force (locale.translate ("Malay (Brunei Darussalam)"), "ms-BN")
			Result.force (locale.translate ("Malay (Malaysia)"), "ms-MY")
			Result.force (locale.translate ("Maltese (Malta)"), "mt-MT")
			Result.force (locale.translate ("Norwegian (Bokmål, Norway)"), "nb-NO")
			Result.force (locale.translate ("Nepali (India)"), "ne-IN")
			Result.force (locale.translate ("Nepali (Nepal)"), "ne-NP")
			Result.force (locale.translate ("Dutch (Belgium)"), "nl-BE")
			Result.force (locale.translate ("Dutch (Netherlands)"), "nl-NL")
			Result.force (locale.translate ("Norwegian (Nynorsk, Norway)"), "nn-NO")
			Result.force (locale.translate ("Sesotho sa Leboa/Northern Sotho (South Africa)"), "ns-ZA")
			Result.force (locale.translate ("Occitan (France)"), "oc-FR")
			Result.force (locale.translate ("Oriya (India)"), "or-IN")
			Result.force (locale.translate ("Punjabi (India)"), "pa-IN")
			Result.force (locale.translate ("Polish (Poland)"), "pl-PL")
			Result.force (locale.translate ("Pashto (Afghanistan)"), "ps-AF")
			Result.force (locale.translate ("Portuguese (Brazil)"), "pt-BR")
			Result.force (locale.translate ("Portuguese (Portugal)"), "pt-PT")
			Result.force (locale.translate ("K'iche (Guatemala)"), "qut-GT")
			Result.force (locale.translate ("Quechua (Bolivia)"), "quz-BO")
			Result.force (locale.translate ("Quechua (Ecuador)"), "quz-EC")
			Result.force (locale.translate ("Quechua (Peru)"), "quz-PE")
			Result.force (locale.translate ("Romansh (Switzerland)"), "rm-CH")
			Result.force (locale.translate ("Romanian (Romania)"), "ro-RO")
			Result.force (locale.translate ("Russian (Russia)"), "ru-RU")
			Result.force (locale.translate ("Kinyarwanda (Rwanda)"), "rw-RW")
			Result.force (locale.translate ("Sanskrit (India)"), "sa-IN")
			Result.force (locale.translate ("Yakut (Russia)"), "sah-RU")
			Result.force (locale.translate ("Sami (Northern, Finland)"), "se-FI")
			Result.force (locale.translate ("Sami (Northern, Norway)"), "se-NO")
			Result.force (locale.translate ("Sami (Northern, Sweden)"), "se-SE")
			Result.force (locale.translate ("Sinhala (Sri Lanka)"), "si-LK")
			Result.force (locale.translate ("Slovak (Slovakia)"), "sk-SK")
			Result.force (locale.translate ("Slovenian (Slovenia)"), "sl-SI")
			Result.force (locale.translate ("Sami (Southern, Norway)"), "sma-NO")
			Result.force (locale.translate ("Sami (Southern, Sweden)"), "sma-SE")
			Result.force (locale.translate ("Sami (Lule, Norway)"), "smj-NO")
			Result.force (locale.translate ("Sami (Lule, Sweden)"), "smj-SE")
			Result.force (locale.translate ("Sami (Inari, Finland)"), "smn-FI")
			Result.force (locale.translate ("Sami (Skolt, Finland)"), "sms-FI")
			Result.force (locale.translate ("Albanian (Albania)"), "sq-AL")
			Result.force (locale.translate ("Serbian (Bosnia and Herzegovina, Cyrillic)"), "sr-Cyrl-BA")
			Result.force (locale.translate ("Serbian (Serbia and Montenegro, Cyrillic)"), "sr-Cyrl-CS")
			Result.force (locale.translate ("Serbian (Bosnia and Herzegovina, Latin)"), "sr-Latn-BA")
			Result.force (locale.translate ("Serbian (Serbia and Montenegro, Latin)"), "sr-Latn-CS")
			Result.force (locale.translate ("Swedish (Finland)"), "sv-FI")
			Result.force (locale.translate ("Swedish (Sweden)"), "sv-SE")
			Result.force (locale.translate ("Swahili (Kenya)"), "sw-KE")
			Result.force (locale.translate ("Syriac (Syria)"), "syr-SY")
			Result.force (locale.translate ("Tamil (India)"), "ta-IN")
			Result.force (locale.translate ("Telugu (India)"), "te-IN")
			Result.force (locale.translate ("Tajik (Tajikistan)"), "tg-Cyrl-TJ")
			Result.force (locale.translate ("Thai (Thailand)"), "th-TH")
			Result.force (locale.translate ("Turkmen (Turkmenistan)"), "tk-TM")
			Result.force (locale.translate ("Tamazight (Algeria, Latin)"), "tmz-Latn-DZ")
			Result.force (locale.translate ("Setswana/Tswana (South Africa)"), "tn-ZA")
			Result.force (locale.translate ("Urdu (India)"), "tr-IN")
			Result.force (locale.translate ("Turkish (Turkey)"), "tr-TR")
			Result.force (locale.translate ("Tatar (Russia)"), "tt-RU")
			Result.force (locale.translate ("Uighur (PRC)"), "ug-CN")
			Result.force (locale.translate ("Ukrainian (Ukraine)"), "uk-UA")
			Result.force (locale.translate ("Urdu (Pakistan)"), "ur-PK")
			Result.force (locale.translate ("Uzbek (Uzbekistan, Cyrillic)"), "uz-Cyrl-UZ")
			Result.force (locale.translate ("Uzbek (Uzbekistan, Latin)"), "uz-Latn-UZ")
			Result.force (locale.translate ("Vietnamese (Vietnam)"), "vi-VN")
			Result.force (locale.translate ("Upper Sorbian (Germany)"), "wen-DE")
			Result.force (locale.translate ("Wolof (Senegal)"), "wo-SN")
			Result.force (locale.translate ("Xhosa/isiXhosa (South Africa)"), "xh-ZA")
			Result.force (locale.translate ("Yoruba (Nigeria)"), "yo-NG")
			Result.force (locale.translate ("Chinese (PRC)"), "zh-CN")
			Result.force (locale.translate ("Chinese (Hong Kong SAR, PRC)"), "zh-HK")
			Result.force (locale.translate ("Chinese (Macao SAR)"), "zh-MO")
			Result.force (locale.translate ("Chinese (Singapore)"), "zh-SG")
			Result.force (locale.translate ("Chinese (Taiwan)"), "zh-TW")
			Result.force (locale.translate ("Zulu/isiZulu (South Africa)"), "zu-ZA")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
