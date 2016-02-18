note
	description: "[
			Testing suite for CONFIG_READER .
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CONFIG_READER_SET

inherit
	EQA_TEST_SET

feature -- Test

	test_ini
		local
			cfg: CONFIG_READER
		do
			create {INI_CONFIG} cfg.make_from_string ("[
				foo = bar
				
				collection[] = a
				collection[] = b
				collection[] = c
				collection[] = 1
				collection[] = 2
				collection[] = 3
				
				table[a] = 1
				table[b] = 2
				table[c] = 3
				table[d] = test
				
				[first]
				abc = 1
				def = and so on
				ghi = "path"
				
				[ second ] 
				this = 1
				is = 2
				the = 3
				end = 4

			]")

			assert ("is valid", not cfg.has_error)
			assert ("has_item (foo)", cfg.has_item ("foo"))
			assert ("has_item (abc)", cfg.has_item ("abc"))
			assert ("has_item (def)", cfg.has_item ("def"))
			assert ("has_item (ghi)", cfg.has_item ("ghi"))
			assert ("has_item (this)", cfg.has_item ("this"))
			assert ("has_item (is)", cfg.has_item ("is"))
			assert ("has_item (the)", cfg.has_item ("the"))
			assert ("has_item (end)", cfg.has_item ("end"))

			assert ("item (foo)",  attached cfg.text_item ("foo")  as v and then v.same_string_general ("bar"))
			assert ("item (abc)",  attached cfg.text_item ("abc")  as v and then v.same_string_general ("1"))
			assert ("item (def)",  attached cfg.text_item ("def")  as v and then v.same_string_general ("and so on"))
			assert ("item (ghi)",  attached cfg.text_item ("ghi")  as v and then v.same_string_general ("%"path%""))
			assert ("item (this)", attached cfg.text_item ("this") as v and then v.same_string_general ("1"))
			assert ("item (is)",   attached cfg.text_item ("is")   as v and then v.same_string_general ("2"))
			assert ("item (the)",  attached cfg.text_item ("the")  as v and then v.same_string_general ("3"))
			assert ("item (end)",  attached cfg.text_item ("end")  as v and then v.same_string_general ("4"))

			assert ("has_item (first.abc)", cfg.has_item ("first.abc"))
			assert ("item (first.abc)",  attached cfg.text_item ("first.abc")  as v and then v.same_string_general ("1"))
			assert ("has_item (second.is)", cfg.has_item ("second.is"))
			assert ("item (second.is)",  attached cfg.text_item ("second.is")  as v and then v.same_string_general ("2"))

			assert ("has_item (collection)", cfg.has_item ("collection"))
			assert ("item (collection)",  attached cfg.text_list_item ("collection") as lst and then (
							lst.has ("a") and lst.has ("b") and lst.has ("c") and lst.has ("1") and lst.has ("2") and lst.has ("3")
						)
					)

			assert ("has_item (table)", cfg.has_item ("table"))
			assert ("item (table)",  attached cfg.text_table_item ("table") as tb and then (
							tb.item ("a") ~ {STRING_32} "1" and
							tb.item ("b") ~ {STRING_32} "2" and
							tb.item ("c") ~ {STRING_32} "3" and
							tb.item ("d") ~ {STRING_32} "test"
						)
					)

			assert ("keys of (table)",  attached cfg.table_keys ("table") as tb and then (
							tb.i_th (1) ~ {STRING_32} "a" and
							tb.i_th (2) ~ {STRING_32} "b" and
							tb.i_th (3) ~ {STRING_32} "c" and
							tb.i_th (4) ~ {STRING_32} "d"
						)
					)

			if attached cfg.sub_config ("second") as cfg_second then
				assert ("has_item (is)", cfg_second.has_item ("is"))
				assert ("item (is)",  attached cfg_second.text_item ("is")  as v and then v.same_string_general ("2"))

			else
				assert ("has second", False)
			end

		end

	test_resolver_ini
		local
			cfg: CONFIG_READER
		do
			create {INI_CONFIG} cfg.make_from_string ("[
				foo = bar
				
				[extra]
				a.b.c = abc
				
				[expression]
				text = ${foo}/${a.b.c}
			]")

			assert ("is valid", not cfg.has_error)
			assert ("has_item (extra.a.b.c)", cfg.has_item ("extra.a.b.c"))
			assert ("has_item (extra.a.b.c)", cfg.has_item ("extra.a.b.c"))
			assert ("has_item (expression.text)", cfg.has_item ("expression.text"))
			assert ("item (expression.text)", attached cfg.resolved_text_item ("expression.text") as s and then s.same_string_general ("bar/abc"))
		end

	test_deep_ini
		local
			cfg: CONFIG_READER
			f: RAW_FILE
		do

			create f.make_with_name ("test_deep.ini")
			f.create_read_write
			f.put_string ("[
					test = extra
					[new]
					enabled = true
				]"
			)
			f.close
			create {INI_CONFIG} cfg.make_from_string ("[
				foo = bar
				
				[extra]
				a.b.c = abc
							
				[outside]
				before = include
				@include=test_deep.ini

			]")
			f.delete

			assert ("is valid", not cfg.has_error)
			assert ("has_item (extra.a.b.c)", cfg.has_item ("extra.a.b.c"))
			assert ("has_item (extra.a.b.c)", cfg.has_item ("extra.a.b.c"))
			assert ("has_item (outside.new.enabled)", cfg.has_item ("outside.new.enabled"))
		end


	test_json
		local
			cfg: CONFIG_READER
		do
			create {JSON_CONFIG} cfg.make_from_string ("[
				{
					"foo": "bar",
					"first": {
						"abc": 1,
						"def": "and so on",
						"ghi": "\"path\""
					},
					"second": {
						"this": 1,
						"is": 2,
						"the": 3,
						"end": 4
					},
					"collection": ["a", "b", "c", 1, 2, 3],
					"table": { "a": 1, "b": 2, "c": 3, "d" : "test" }
				}
			]")

			assert ("is valid", not cfg.has_error)
			assert ("has_item (foo)", cfg.has_item ("foo"))
			assert ("has_item (first.abc)", cfg.has_item ("first.abc"))
			assert ("has_item (first.def)", cfg.has_item ("first.def"))
			assert ("has_item (first.ghi)", cfg.has_item ("first.ghi"))
			assert ("has_item (second.this)", cfg.has_item ("second.this"))
			assert ("has_item (second.is)", cfg.has_item ("second.is"))
			assert ("has_item (second.the)", cfg.has_item ("second.the"))
			assert ("has_item (second.end)", cfg.has_item ("second.end"))

			assert ("item (foo)",  attached cfg.text_item ("foo")  as v and then v.same_string_general ("bar"))
			assert ("item (first.abc)",  attached cfg.text_item ("first.abc")  as v and then v.same_string_general ("1"))
			assert ("item (first.def)",  attached cfg.text_item ("first.def")  as v and then v.same_string_general ("and so on"))
			assert ("item (first.ghi)",  attached cfg.text_item ("first.ghi")  as v and then v.same_string_general ("%"path%""))
			assert ("item (second.this)", attached cfg.text_item ("second.this") as v and then v.same_string_general ("1"))
			assert ("item (second.is)",   attached cfg.text_item ("second.is")   as v and then v.same_string_general ("2"))
			assert ("item (second.the)",  attached cfg.text_item ("second.the")  as v and then v.same_string_general ("3"))
			assert ("item (second.end)",  attached cfg.text_item ("second.end")  as v and then v.same_string_general ("4"))

			assert ("has_item (collection)", cfg.has_item ("collection"))
			assert ("item (collection)",  attached cfg.text_list_item ("collection") as lst and then (
							lst.has ("a") and lst.has ("b") and lst.has ("c") and lst.has ("1") and lst.has ("2") and lst.has ("3")
						)
					)

			assert ("has_item (table)", cfg.has_item ("table"))
			assert ("item (table)",  attached cfg.text_table_item ("table") as tb and then (
							tb.item ("a") ~ {STRING_32} "1" and
							tb.item ("b") ~ {STRING_32} "2" and
							tb.item ("c") ~ {STRING_32} "3" and
							tb.item ("d") ~ {STRING_32} "test"
						)
					)

			assert ("keys of (table)",  attached cfg.table_keys ("table") as tb and then (
							tb.i_th (1) ~ {STRING_32} "a" and
							tb.i_th (2) ~ {STRING_32} "b" and
							tb.i_th (3) ~ {STRING_32} "c" and
							tb.i_th (4) ~ {STRING_32} "d"
						)
					)

			if attached cfg.sub_config ("second") as cfg_second then
				assert ("has_item (is)", cfg_second.has_item ("is"))
				assert ("item (is)",  attached cfg_second.text_item ("is")  as v and then v.same_string_general ("2"))

			else
				assert ("has second", False)
			end
		end


end
