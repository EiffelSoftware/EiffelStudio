indexing
	description: "Mapping between locale ids and names"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOCALE_NAMES

inherit
	SHARED_LOCALE

feature -- Access

	languages: HASH_TABLE [STRING_32, STRING] is
		once
			create Result.make (130)
			Result.force (locale.translation ("Afrikaans"), "af")
			Result.force (locale.translation ("Amharic"), "am")
			Result.force (locale.translation ("Arabic"), "ar")
			Result.force (locale.translation ("Mapudungun"), "arn")
			Result.force (locale.translation ("Assamese"), "as")
			Result.force (locale.translation ("Azeri"), "az")
			Result.force (locale.translation ("Bashkir"), "ba")
			Result.force (locale.translation ("Belarusian"), "be")
			Result.force (locale.translation ("Bulgarian"), "bg")
			Result.force (locale.translation ("Bengali"), "bn")
			Result.force (locale.translation ("Tibetan"), "bo")
			Result.force (locale.translation ("Breton"), "br")
			Result.force (locale.translation ("Bosnian"), "bs")
			Result.force (locale.translation ("Catalan"), "ca")
			Result.force (locale.translation ("Corsican"), "co")
			Result.force (locale.translation ("Czech"), "cs")
			Result.force (locale.translation ("Welsh"), "cy")
			Result.force (locale.translation ("Danish"), "da")
			Result.force (locale.translation ("German"), "de")
			Result.force (locale.translation ("Lower Sorbian"), "dsb")
			Result.force (locale.translation ("Divehi"), "dv")
			Result.force (locale.translation ("Greek"), "el")
			Result.force (locale.translation ("English"), "en")
			Result.force (locale.translation ("Spanish"), "es")
			Result.force (locale.translation ("Estonian"), "et")
			Result.force (locale.translation ("Basque"), "eu")
			Result.force (locale.translation ("Persian"), "fa")
			Result.force (locale.translation ("Finnish"), "fi")
			Result.force (locale.translation ("Filipino"), "fil")
			Result.force (locale.translation ("Faroese"), "fo-FO")
			Result.force (locale.translation ("French"), "fr")
			Result.force (locale.translation ("Frisian"), "fy")
			Result.force (locale.translation ("Irish"), "ga")
			Result.force (locale.translation ("Dari"), "gbz")
			Result.force (locale.translation ("Galician"), "gl")
			Result.force (locale.translation ("Alsatian"), "gsw")
			Result.force (locale.translation ("Gujarati"), "gu")
			Result.force (locale.translation ("Hausa"), "ha")
			Result.force (locale.translation ("Hebrew"), "he")
			Result.force (locale.translation ("Hindi"), "hi")
			Result.force (locale.translation ("Croatian"), "hr")
			Result.force (locale.translation ("Hungarian"), "hu")
			Result.force (locale.translation ("Armenian"), "hy")
			Result.force (locale.translation ("Indonesian"), "id")
			Result.force (locale.translation ("Igbo"), "ig")
			Result.force (locale.translation ("Yi"), "ii")
			Result.force (locale.translation ("Icelandic"), "is")
			Result.force (locale.translation ("Italian"), "it")
			Result.force (locale.translation ("Inuktitut"), "iu")
			Result.force (locale.translation ("Japanese"), "ja")
			Result.force (locale.translation ("Georgian"), "ka")
			Result.force (locale.translation ("Khmer"), "kh")
			Result.force (locale.translation ("Kazakh"), "kk")
			Result.force (locale.translation ("Greenlandic"), "kl")
			Result.force (locale.translation ("Kannada"), "kn")
			Result.force (locale.translation ("Korean"), "ko")
			Result.force (locale.translation ("Konkani"), "kok")
			Result.force (locale.translation ("Kyrgyz"), "ky")
			Result.force (locale.translation ("Luxembourgish"), "lb")
			Result.force (locale.translation ("Lao"), "lo")
			Result.force (locale.translation ("Lithuanian"), "lt")
			Result.force (locale.translation ("Latvian"), "lv")
			Result.force (locale.translation ("Maori"), "mi")
			Result.force (locale.translation ("Macedonian"), "mk")
			Result.force (locale.translation ("Malayalam"), "ml")
			Result.force (locale.translation ("Mongolian"), "mn")
			Result.force (locale.translation ("Mohawk"), "moh")
			Result.force (locale.translation ("Marathi"), "mr")
			Result.force (locale.translation ("Malay"), "ms")
			Result.force (locale.translation ("Maltese"), "mt")
			Result.force (locale.translation ("Norwegian"), "nb")
			Result.force (locale.translation ("Nepali"), "ne")
			Result.force (locale.translation ("Dutch"), "nl")
			Result.force (locale.translation ("Norwegian"), "nn")
			Result.force (locale.translation ("Sesotho sa Leboa/Northern Sotho"), "ns")
			Result.force (locale.translation ("Occitan"), "oc")
			Result.force (locale.translation ("Oriya"), "or")
			Result.force (locale.translation ("Punjabi"), "pa")
			Result.force (locale.translation ("Polish"), "pl")
			Result.force (locale.translation ("Pashto"), "ps")
			Result.force (locale.translation ("Portuguese"), "pt")
			Result.force (locale.translation ("K'iche"), "qut")
			Result.force (locale.translation ("Quechua"), "quz")
			Result.force (locale.translation ("Romansh"), "rm")
			Result.force (locale.translation ("Romanian"), "ro")
			Result.force (locale.translation ("Russian"), "ru")
			Result.force (locale.translation ("Kinyarwanda"), "rw")
			Result.force (locale.translation ("Sanskrit"), "sa")
			Result.force (locale.translation ("Yakut"), "sah")
			Result.force (locale.translation ("Sami"), "se")
			Result.force (locale.translation ("Sinhala"), "si")
			Result.force (locale.translation ("Slovak"), "sk")
			Result.force (locale.translation ("Slovenian"), "sl")
			Result.force (locale.translation ("Sami"), "sma")
			Result.force (locale.translation ("Albanian"), "sq")
			Result.force (locale.translation ("Serbian"), "sr")
			Result.force (locale.translation ("Swedish"), "sv")
			Result.force (locale.translation ("Swahili"), "sw")
			Result.force (locale.translation ("Syriac"), "syr")
			Result.force (locale.translation ("Tamil"), "ta")
			Result.force (locale.translation ("Telugu"), "te")
			Result.force (locale.translation ("Tajik"), "tg")
			Result.force (locale.translation ("Thai"), "th")
			Result.force (locale.translation ("Turkmen"), "tk")
			Result.force (locale.translation ("Tamazight"), "tmz")
			Result.force (locale.translation ("Setswana/Tswana"), "tn")
			Result.force (locale.translation ("Urdu"), "tr")
			Result.force (locale.translation ("Turkish"), "tr")
			Result.force (locale.translation ("Tatar"), "tt")
			Result.force (locale.translation ("Uighur"), "ug")
			Result.force (locale.translation ("Ukrainian"), "uk")
			Result.force (locale.translation ("Urdu"), "ur")
			Result.force (locale.translation ("Uzbek"), "uz")
			Result.force (locale.translation ("Vietnamese"), "vi")
			Result.force (locale.translation ("Upper Sorbian"), "wen")
			Result.force (locale.translation ("Wolof"), "wo")
			Result.force (locale.translation ("Xhosa/isiXhosa"), "xh")
			Result.force (locale.translation ("Yoruba"), "yo")
			Result.force (locale.translation ("Chinese"), "zh")
			Result.force (locale.translation ("Zulu/isiZulu"), "zu")
		end

	locales: HASH_TABLE [STRING_32, STRING] is
		once
			create Result.make (300)
			Result.force (locale.translation ("Afrikaans (South Africa)"), "af_za")
			Result.force (locale.translation ("Amharic (Ethiopia)"), "am_et")
			Result.force (locale.translation ("Arabic (U.A.E.)"), "ar_ae")
			Result.force (locale.translation ("Arabic (Bahrain)"), "ar_bh")
			Result.force (locale.translation ("Arabic (Algeria)"), "ar_dz")
			Result.force (locale.translation ("Arabic (Egypt)"), "ar_eg")
			Result.force (locale.translation ("Arabic (Iraq)"), "ar_iq")
			Result.force (locale.translation ("Arabic (Jordan)"), "ar_jo")
			Result.force (locale.translation ("Arabic (Kuwait)"), "ar_kw")
			Result.force (locale.translation ("Arabic (Lebanon)"), "ar_lb")
			Result.force (locale.translation ("Arabic (Libya)"), "ar_ly")
			Result.force (locale.translation ("Arabic (Morocco)"), "ar_ma")
			Result.force (locale.translation ("Arabic (Oman)"), "ar_om")
			Result.force (locale.translation ("Arabic (Qatar)"), "ar_qa")
			Result.force (locale.translation ("Arabic (Saudi Arabia)"), "ar_sa")
			Result.force (locale.translation ("Arabic (Syria)"), "ar_sy")
			Result.force (locale.translation ("Arabic (Tunisia)"), "ar_tn")
			Result.force (locale.translation ("Arabic (Yemen)"), "ar_ye")
			Result.force (locale.translation ("Mapudungun (Chile)"), "arn_cl")
			Result.force (locale.translation ("Assamese (India)"), "as_in")
			Result.force (locale.translation ("Azeri (Azerbaijan, Cyrillic)"), "az_cyrl_az")
			Result.force (locale.translation ("Azeri (Azerbaijan, Latin)"), "az_latn_az")
			Result.force (locale.translation ("Bashkir (Russia)"), "ba_ru")
			Result.force (locale.translation ("Belarusian (Belarus)"), "be_by")
			Result.force (locale.translation ("Bulgarian (Bulgaria)"), "bg_bg")
			Result.force (locale.translation ("Bengali (India)"), "bn_in")
			Result.force (locale.translation ("Tibetan (Bhutan)"), "bo_bt")
			Result.force (locale.translation ("Tibetan (PRC)"), "bo_cn")
			Result.force (locale.translation ("Breton (France)"), "br_fr")
			Result.force (locale.translation ("Bosnian (Bosnia and Herzegovina, Cyrillic)"), "bs_cyrl_ba")
			Result.force (locale.translation ("Bosnian (Bosnia and Herzegovina, Latin)"), "bs_latn_ba")
			Result.force (locale.translation ("Catalan (Catalan)"), "ca_es")
			Result.force (locale.translation ("Corsican (France)"), "co_fr")
			Result.force (locale.translation ("Czech (Czech Republic)"), "cs_cz")
			Result.force (locale.translation ("Welsh (United Kingdom)"), "cy_gb")
			Result.force (locale.translation ("Danish (Denmark)"), "da_dk")
			Result.force (locale.translation ("German (Austria)"), "de_at")
			Result.force (locale.translation ("German (Switzerland)"), "de_ch")
			Result.force (locale.translation ("German (Germany)"), "de_de")
			Result.force (locale.translation ("German (Liechtenstein)"), "de_li")
			Result.force (locale.translation ("German (Luxembourg)"), "de_lu")
			Result.force (locale.translation ("Lower Sorbian (Germany)"), "dsb_de")
			Result.force (locale.translation ("Divehi (Maldives)"), "dv_mv")
			Result.force (locale.translation ("Greek (Greece)"), "el_gr")
			Result.force (locale.translation ("English (Caribbean)"), "en_029")
			Result.force (locale.translation ("English (Australia)"), "en_au")
			Result.force (locale.translation ("English (Belize)"), "en_bz")
			Result.force (locale.translation ("English (Canada)"), "en_ca")
			Result.force (locale.translation ("English (Caribbean)"), "en_cb")
			Result.force (locale.translation ("English (United Kingdom)"), "en_gb")
			Result.force (locale.translation ("English (Ireland)"), "en_ie")
			Result.force (locale.translation ("English (India)"), "en_in")
			Result.force (locale.translation ("English (Jamaica)"), "en_jm")
			Result.force (locale.translation ("English (Malaysia)"), "en_my")
			Result.force (locale.translation ("English (New Zealand)"), "en_nz")
			Result.force (locale.translation ("English (Philippines)"), "en_ph")
			Result.force (locale.translation ("English (Singapore)"), "en_sg")
			Result.force (locale.translation ("English (Trinidad and Tobago)"), "en_tt")
			Result.force (locale.translation ("English (United States)"), "en_us")
			Result.force (locale.translation ("English (South Africa)"), "en_za")
			Result.force (locale.translation ("English (Zimbabwe)"), "en_zw")
			Result.force (locale.translation ("Spanish (Argentina)"), "es_ar")
			Result.force (locale.translation ("Spanish (Bolivia)"), "es_bo")
			Result.force (locale.translation ("Spanish (Chile)"), "es_cl")
			Result.force (locale.translation ("Spanish (Colombia)"), "es_co")
			Result.force (locale.translation ("Spanish (Costa Rica)"), "es_cr")
			Result.force (locale.translation ("Spanish (Dominican Republic)"), "es_do")
			Result.force (locale.translation ("Spanish (Ecuador)"), "es_ec")
			Result.force (locale.translation ("Spanish (Spain)"), "es_es")
			Result.force (locale.translation ("Spanish (Guatemala)"), "es_gt")
			Result.force (locale.translation ("Spanish (Honduras)"), "es_hn")
			Result.force (locale.translation ("Spanish (Mexico)"), "es_mx")
			Result.force (locale.translation ("Spanish (Nicaragua)"), "es_ni")
			Result.force (locale.translation ("Spanish (Panama)"), "es_pa")
			Result.force (locale.translation ("Spanish (Peru)"), "es_pe")
			Result.force (locale.translation ("Spanish (Puerto Rico)"), "es_pr")
			Result.force (locale.translation ("Spanish (Paraguay)"), "es_py")
			Result.force (locale.translation ("Spanish (El Salvador)"), "es_sv")
			Result.force (locale.translation ("Spanish (United States)"), "es_us")
			Result.force (locale.translation ("Spanish (Uruguay)"), "es_uy")
			Result.force (locale.translation ("Spanish (Venezuela)"), "es_ve")
			Result.force (locale.translation ("Estonian (Estonia)"), "et_ee")
			Result.force (locale.translation ("Basque (Basque)"), "eu_es")
			Result.force (locale.translation ("Persian (Iran)"), "fa_ir")
			Result.force (locale.translation ("Finnish (Finland)"), "fi_fi")
			Result.force (locale.translation ("Filipino (Philippines)"), "fil_ph")
			Result.force (locale.translation ("Faroese (Faroe Islands)"), "fo_fo")
			Result.force (locale.translation ("French (Belgium)"), "fr_be")
			Result.force (locale.translation ("French (Canada)"), "fr_ca")
			Result.force (locale.translation ("French (Switzerland)"), "fr_ch")
			Result.force (locale.translation ("French (France)"), "fr_fr")
			Result.force (locale.translation ("French (Luxembourg)"), "fr_lu")
			Result.force (locale.translation ("French (Monaco)"), "fr_mc")
			Result.force (locale.translation ("Frisian (Netherlands)"), "fy_nl")
			Result.force (locale.translation ("Irish (Ireland)"), "ga_ie")
			Result.force (locale.translation ("Dari (Afghanistan)"), "gbz_af")
			Result.force (locale.translation ("Galician (Spain)"), "gl_es")
			Result.force (locale.translation ("Alsatian (France)"), "gsw_fr")
			Result.force (locale.translation ("Gujarati (India)"), "gu_in")
			Result.force (locale.translation ("Hausa (Nigeria, Latin)"), "ha_latn_ng")
			Result.force (locale.translation ("Hebrew (Israel)"), "he_il")
			Result.force (locale.translation ("Hindi (India)"), "hi_in")
			Result.force (locale.translation ("Croatian (Bosnia and Herzegovina, Latin)"), "hr_ba")
			Result.force (locale.translation ("Croatian (Croatia)"), "hr_hr")
			Result.force (locale.translation ("Hungarian (Hungary)"), "hu_hu")
			Result.force (locale.translation ("Armenian (Armenia)"), "hy_am")
			Result.force (locale.translation ("Indonesian (Indonesia)"), "id_id")
			Result.force (locale.translation ("Igbo (Nigeria)"), "ig_ng")
			Result.force (locale.translation ("Yi (PRC)"), "ii_cn")
			Result.force (locale.translation ("Icelandic (Iceland)"), "is_is")
			Result.force (locale.translation ("Italian (Switzerland)"), "it_ch")
			Result.force (locale.translation ("Italian (Italy)"), "it_it")
			Result.force (locale.translation ("Inuktitut (Canada, Syllabics)"), "iu_cans_ca")
			Result.force (locale.translation ("Inuktitut (Canada, Latin)"), "iu_latn_ca")
			Result.force (locale.translation ("Japanese (Japan)"), "ja_jp")
			Result.force (locale.translation ("Georgian (Georgia)"), "ka_ge")
			Result.force (locale.translation ("Khmer (Cambodia)"), "kh_kh")
			Result.force (locale.translation ("Kazakh (Kazakhstan)"), "kk_kz")
			Result.force (locale.translation ("Greenlandic (Greenland)"), "kl_gl")
			Result.force (locale.translation ("Kannada (India)"), "kn_in")
			Result.force (locale.translation ("Korean (Korea)"), "ko_kr")
			Result.force (locale.translation ("Konkani (India)"), "kok_in")
			Result.force (locale.translation ("Kyrgyz (Kyrgyzstan)"), "ky_kg")
			Result.force (locale.translation ("Luxembourgish (Luxembourg)"), "lb_lu")
			Result.force (locale.translation ("Lao (Lao PDR)"), "lo_la")
			Result.force (locale.translation ("Lithuanian (Lithuania)"), "lt_lt")
			Result.force (locale.translation ("Latvian (Latvia)"), "lv_lv")
			Result.force (locale.translation ("Maori (New Zealand)"), "mi_nz")
			Result.force (locale.translation ("Macedonian (Macedonia, FYROM)"), "mk_mk")
			Result.force (locale.translation ("Malayalam (India)"), "ml_in")
			Result.force (locale.translation ("Mongolian (Mongolia)"), "mn_cyrl_mn")
			Result.force (locale.translation ("Mongolian (PRC)"), "mn_mong_cn")
			Result.force (locale.translation ("Mohawk (Canada)"), "moh_ca")
			Result.force (locale.translation ("Marathi (India)"), "mr_in")
			Result.force (locale.translation ("Malay (Brunei Darussalam)"), "ms_bn")
			Result.force (locale.translation ("Malay (Malaysia)"), "ms_my")
			Result.force (locale.translation ("Maltese (Malta)"), "mt_mt")
			Result.force (locale.translation ("Norwegian (Bokmål, Norway)"), "nb_no")
			Result.force (locale.translation ("Nepali (India)"), "ne_in")
			Result.force (locale.translation ("Nepali (Nepal)"), "ne_np")
			Result.force (locale.translation ("Dutch (Belgium)"), "nl_be")
			Result.force (locale.translation ("Dutch (Netherlands)"), "nl_nl")
			Result.force (locale.translation ("Norwegian (Nynorsk, Norway)"), "nn_no")
			Result.force (locale.translation ("Sesotho sa Leboa/Northern Sotho (South Africa)"), "ns_za")
			Result.force (locale.translation ("Occitan (France)"), "oc_fr")
			Result.force (locale.translation ("Oriya (India)"), "or_in")
			Result.force (locale.translation ("Punjabi (India)"), "pa_in")
			Result.force (locale.translation ("Polish (Poland)"), "pl_pl")
			Result.force (locale.translation ("Pashto (Afghanistan)"), "ps_af")
			Result.force (locale.translation ("Portuguese (Brazil)"), "pt_br")
			Result.force (locale.translation ("Portuguese (Portugal)"), "pt_pt")
			Result.force (locale.translation ("K'iche (Guatemala)"), "qut_gt")
			Result.force (locale.translation ("Quechua (Bolivia)"), "quz_bo")
			Result.force (locale.translation ("Quechua (Ecuador)"), "quz_ec")
			Result.force (locale.translation ("Quechua (Peru)"), "quz_pe")
			Result.force (locale.translation ("Romansh (Switzerland)"), "rm_ch")
			Result.force (locale.translation ("Romanian (Romania)"), "ro_ro")
			Result.force (locale.translation ("Russian (Russia)"), "ru_ru")
			Result.force (locale.translation ("Kinyarwanda (Rwanda)"), "rw_rw")
			Result.force (locale.translation ("Sanskrit (India)"), "sa_in")
			Result.force (locale.translation ("Yakut (Russia)"), "sah_ru")
			Result.force (locale.translation ("Sami (Northern, Finland)"), "se_fi")
			Result.force (locale.translation ("Sami (Northern, Norway)"), "se_no")
			Result.force (locale.translation ("Sami (Northern, Sweden)"), "se_se")
			Result.force (locale.translation ("Sinhala (Sri Lanka)"), "si_lk")
			Result.force (locale.translation ("Slovak (Slovakia)"), "sk_sk")
			Result.force (locale.translation ("Slovenian (Slovenia)"), "sl_si")
			Result.force (locale.translation ("Sami (Southern, Norway)"), "sma_no")
			Result.force (locale.translation ("Sami (Southern, Sweden)"), "sma_se")
			Result.force (locale.translation ("Sami (Lule, Norway)"), "smj_no")
			Result.force (locale.translation ("Sami (Lule, Sweden)"), "smj_se")
			Result.force (locale.translation ("Sami (Inari, Finland)"), "smn_fi")
			Result.force (locale.translation ("Sami (Skolt, Finland)"), "sms_fi")
			Result.force (locale.translation ("Albanian (Albania)"), "sq_AL")
			Result.force (locale.translation ("Serbian (Bosnia and Herzegovina, Cyrillic)"), "sr_cyrl_ba")
			Result.force (locale.translation ("Serbian (Serbia and Montenegro, Cyrillic)"), "sr_cyrl_cs")
			Result.force (locale.translation ("Serbian (Bosnia and Herzegovina, Latin)"), "sr_latn_ba")
			Result.force (locale.translation ("Serbian (Serbia and Montenegro, Latin)"), "sr_latn_cs")
			Result.force (locale.translation ("Swedish (Finland)"), "sv_fi")
			Result.force (locale.translation ("Swedish (Sweden)"), "sv_se")
			Result.force (locale.translation ("Swahili (Kenya)"), "sw_ke")
			Result.force (locale.translation ("Syriac (Syria)"), "syr_sy")
			Result.force (locale.translation ("Tamil (India)"), "ta_in")
			Result.force (locale.translation ("Telugu (India)"), "te_in")
			Result.force (locale.translation ("Tajik (Tajikistan)"), "tg_cyrl_tj")
			Result.force (locale.translation ("Thai (Thailand)"), "th_th")
			Result.force (locale.translation ("Turkmen (Turkmenistan)"), "tk_tm")
			Result.force (locale.translation ("Tamazight (Algeria, Latin)"), "tmz_latn_dz")
			Result.force (locale.translation ("Setswana/Tswana (South Africa)"), "tn_za")
			Result.force (locale.translation ("Urdu (India)"), "tr_in")
			Result.force (locale.translation ("Turkish (Turkey)"), "tr_tr")
			Result.force (locale.translation ("Tatar (Russia)"), "tt_ru")
			Result.force (locale.translation ("Uighur (PRC)"), "ug_cn")
			Result.force (locale.translation ("Ukrainian (Ukraine)"), "uk_ua")
			Result.force (locale.translation ("Urdu (Pakistan)"), "ur_pk")
			Result.force (locale.translation ("Uzbek (Uzbekistan, Cyrillic)"), "uz_cyrl_uz")
			Result.force (locale.translation ("Uzbek (Uzbekistan, Latin)"), "uz_latn_uz")
			Result.force (locale.translation ("Vietnamese (Vietnam)"), "vi_vn")
			Result.force (locale.translation ("Upper Sorbian (Germany)"), "wen_de")
			Result.force (locale.translation ("Wolof (Senegal)"), "wo_sn")
			Result.force (locale.translation ("Xhosa/isiXhosa (South Africa)"), "xh_za")
			Result.force (locale.translation ("Yoruba (Nigeria)"), "yo_ng")
			Result.force (locale.translation ("Chinese (PRC)"), "zh_cn")
			Result.force (locale.translation ("Chinese (Hong Kong SAR, PRC)"), "zh_hk")
			Result.force (locale.translation ("Chinese (Macao SAR)"), "zh_mo")
			Result.force (locale.translation ("Chinese (Singapore)"), "zh_sg")
			Result.force (locale.translation ("Chinese (Taiwan)"), "zh_tw")
			Result.force (locale.translation ("Zulu/isiZulu (South Africa)"), "zu_za")
		end

	locales_from_array (a_array_of_id: ARRAY [STRING]): like locales is
			-- Locale pairs of names and locale ids.
			-- Names have been translated according to current selected locale.
		require
			a_array_of_id_not_void: a_array_of_id /= Void
		local
			l_array: like a_array_of_id
			i: INTEGER
			l_displayed_name: STRING_GENERAL
			l_langs, l_locales: HASH_TABLE [STRING_32, STRING]
			l_value: STRING
		do
			create Result.make (a_array_of_id.count)
			l_langs := languages
			l_locales := locales
			l_array := a_array_of_id
			from
				i := l_array.lower
			until
				i > l_array.upper
			loop
				l_value := l_array.item (i).as_lower
				if l_locales.has_key (l_value) then
					l_displayed_name := l_locales.found_item
				elseif l_langs.has_key (l_value) then
					l_displayed_name := l_langs.found_item
				else
					l_displayed_name := l_array.item (i)
				end
				Result.force (l_displayed_name, l_array.item (i))
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
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
