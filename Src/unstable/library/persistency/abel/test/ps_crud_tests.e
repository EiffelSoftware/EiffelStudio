note
	description: "Provides tests for the CRUD (Create, Read, Update, Delete) operations"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CRUD_TESTS

inherit

	PS_TEST_PROVIDER

create
	make

feature {PS_REPOSITORY_TESTS} -- References

	all_references_tests
			-- All tests that work on REFERENCE_CLASS_1
		do
			test_insert_void_reference
			test_insert_one_reference
			test_insert_reference_cycle
			test_crud_reference_cycle
			test_crud_update_on_reference

			--test_ref_new
		end

	test_ref_new
		do
			test_read_write_cycle (test_data.reference_cycle, Void)
			test_read_write_cycle_with_root (test_data.reference_cycle, Void)
		end

	test_insert_void_reference
			-- Test inserting an object with a Void reference
		local
			test: PS_GENERIC_CRUD_TEST [REFERENCE_CLASS_1]
		do
			create test.make (repository)
			test.test_insert (test_data.void_reference)
			repository.wipe_out
		end

	test_insert_one_reference
			-- Test inserting an object that references another object
		local
			test: PS_GENERIC_CRUD_TEST [REFERENCE_CLASS_1]
		do
			create test.make (repository)
			test.test_insert (test_data.reference_to_single_other)
			assert ("The result does not have exactly two items", test.count_results = 2)
			repository.wipe_out
		end

	test_insert_reference_cycle
			-- Test inserting some objects that reference each other, forming a reference cycle
		local
			test: PS_GENERIC_CRUD_TEST [REFERENCE_CLASS_1]
		do
			create test.make (repository)
			test.test_insert (test_data.reference_cycle)
			assert ("The wrong number of items has been inserted", test.count_results = 3)
			repository.wipe_out
		end

	test_crud_reference_cycle
			-- Test the CRUD operations on objects with a reference cycle
		local
			test: PS_GENERIC_CRUD_TEST [REFERENCE_CLASS_1]
		do
			create test.make (repository)
			test.test_crud_operations (test_data.reference_cycle, agent {REFERENCE_CLASS_1}.update)
			repository.wipe_out
		end

	test_crud_update_on_reference
			-- Test an update operation on a referenced object
		local
			test: PS_GENERIC_CRUD_TEST [REFERENCE_CLASS_1]
		do
			create test.make (repository)
			test.test_crud_operations (test_data.reference_to_single_other, agent update_reference)
		end

feature {PS_REPOSITORY_TESTS} -- Flat objects

	all_flat_object_tests
			-- All tests that use FLAT_CLASS_1
		do
			repository.wipe_out
			test_empty_object
			test_flat_class_store
			test_flat_class_all_crud
		end

	test_empty_object
			-- Test if an object that contains no attributes (e.g. an instance of ANY), is stored as well
		local
			test: PS_GENERIC_CRUD_TEST [ANY]
			obj: ANY
		do
			create test.make (repository)
			create obj
			test.test_crud_operations (obj, agent {ANY}.do_nothing)
			repository.wipe_out
		end

	test_flat_class_store
			-- Test if a simple store-and-retrieve returns the same result
		local
			test: PS_GENERIC_CRUD_TEST [FLAT_CLASS_1]
		do
			create test.make (repository)
			test.test_insert (test_data.flat_class)
			repository.wipe_out
		end

	test_flat_class_all_crud
			-- Test all CRUD operations on a flat class
		local
			test: PS_GENERIC_CRUD_TEST [FLAT_CLASS_1]
		do
			create test.make (repository)
			test.test_crud_operations (test_data.flat_class, agent {FLAT_CLASS_1}.update)
			repository.wipe_out
		end


feature {PS_REPOSITORY_TESTS} -- Basic and expanded types

	all_basic_type_tests
		do
			test_integer
			test_string
			test_immediate_expanded
			test_referenced_expanded
		    test_embedded_expanded
--		    test_evil_object
		end

	test_integer
		local
			test: PS_GENERIC_CRUD_TEST [INTEGER]
		do
			repository.wipe_out
			create test.make (repository)
			test.test_insert (42)
		end

	test_string
		local
			test: PS_GENERIC_CRUD_TEST [STRING]
		do
			repository.wipe_out
			create test.make (repository)
			test.test_insert ("a_string")
		end

	test_embedded_expanded
		local
			test: PS_GENERIC_CRUD_TEST [EXPANDED_PERSON_CONTAINER]
			container: EXPANDED_PERSON_CONTAINER
		do

			repository.wipe_out
			create test.make (repository)
			create container.set_item ("a_string")
			test.test_insert (container)
		end

	test_referenced_expanded
		local
			test: PS_GENERIC_CRUD_TEST [ANY_BOX]
			person: EXPANDED_PERSON
			anybox: ANY_BOX
		do
			repository.wipe_out
			create test.make (repository)
			create anybox.set_item (person)
			test.test_insert (anybox)
			test.test_crud_operations (anybox, agent (a:ANY_BOX) do check attached {EXPANDED_PERSON} a.item as p then p.add_item end end)
		end

	test_immediate_expanded
		local
			test: PS_GENERIC_CRUD_TEST [EXPANDED_PERSON]
			person: EXPANDED_PERSON
		do
			repository.wipe_out
			create test.make (repository)
			test.test_insert (person)
			test.test_crud_operations (person, agent {EXPANDED_PERSON}.add_item)
		end

--	test_evil_object
--		local
--			test: PS_GENERIC_CRUD_TEST [GENERIC_BOX [
--				GENERIC_BOX [REFERENCE_CLASS_1, detachable ANY],
--				EXPANDED_GENERIC_BOX [detachable SPECIAL [ANY], detachable SPECIAL [EXPANDED_PERSON]]]]
--		do
--			repository.clean_db_for_testing
--			create test.make (repository)
--			test.test_insert (test_data.evil_object)
--		end

feature {PS_REPOSITORY_TESTS} -- Collections

	all_easy_collection_tests
			-- All collection tests
		do
			repository.wipe_out
			test_referenced_collection_store
			test_referenced_collection_update_known_object
			test_referenced_collection_new_object
			test_direct_collection_store
			test_direct_collection_update_known_object
			test_direct_collection_new_object
			test_collection_basic_type_store
			test_shared_special
			
			test_collection_shrink

--			takes too long, but should work.
--			test_data_structures_store
--			test_update_on_reference
		end

	all_tricky_collection_tests
		do
			test_tuple
			test_hash_table
		end

	test_referenced_collection_store
			-- Test if a SPECIAL collection, that is referenced by an ARRAY object, gets stored correctly
		local
			test: PS_GENERIC_CRUD_TEST [ARRAY [TEST_PERSON]]
		do
			create test.make (repository)
			test.test_insert (test_data.array_of_persons)
			repository.wipe_out
		end

	test_referenced_collection_update_known_object
			-- Test if a reference change to a known object is correctly adjusted.
		local
			test: PS_GENERIC_CRUD_TEST [ARRAY [TEST_PERSON]]
		do
			create test.make (repository)
			test.test_crud_operations (test_data.array_of_persons, agent {ARRAY [TEST_PERSON]}.put (test_data.array_of_persons.item (1), 2))
			repository.wipe_out
		end

	test_referenced_collection_new_object
			-- Test if a newly inserted collection item gets correctly inserted
		local
			test: PS_GENERIC_CRUD_TEST [ARRAY [TEST_PERSON]]
			new: TEST_PERSON
		do
			create new.make ("some", "new_guy", 20)
			create test.make (repository)
			test.test_crud_operations (test_data.array_of_persons, agent {ARRAY [TEST_PERSON]}.force (new, 5))
			repository.wipe_out
		end

	test_direct_collection_store
			-- Test if a direct collection store is supported
		local
			test: PS_GENERIC_CRUD_TEST [SPECIAL [TEST_PERSON]]
		do
			create test.make (repository)
			test.test_insert (test_data.special_of_persons)
			repository.wipe_out
		end

	test_collection_shrink
			-- Test if shrinking an object works.
		local
			obj: SPECIAL [TEST_PERSON]
		do
			obj := test_data.special_of_persons.deep_twin
			test_read_write_cycle_with_root (obj, agent {SPECIAL [TEST_PERSON]}.keep_head (2))
			repository.wipe_out
		end

	test_direct_collection_update_known_object
			-- Test if a reference change to a known object is correctly adjusted.
		local
			test: PS_GENERIC_CRUD_TEST [SPECIAL [TEST_PERSON]]
		do
			create test.make (repository)
			test.test_crud_operations (test_data.special_of_persons, agent {SPECIAL [TEST_PERSON]}.put (test_data.special_of_persons.item (0), 1))
			repository.wipe_out
		end

	test_direct_collection_new_object
			-- Test if a newly inserted collection item gets correctly inserted
		local
			test: PS_GENERIC_CRUD_TEST [SPECIAL [TEST_PERSON]]
			new: TEST_PERSON
		do
			create new.make ("some", "new_guy", 20)
			create test.make (repository)
			test.test_crud_operations (test_data.special_of_persons, agent {SPECIAL [TEST_PERSON]}.extend (new))
			repository.wipe_out
		end

	test_collection_basic_type_store
			-- Test if a collection can store basic types
		local
			test: PS_GENERIC_CRUD_TEST [ARRAY [INTEGER]]
		do
			create test.make (repository)
				--			print ("adsf")
				--			test.test_insert (test_data.array_of_integers)
			test.test_crud_operations (test_data.array_of_integers, agent {ARRAY [INTEGER]}.put (20, 10))
		end

	test_data_structures_store
			-- Test if a simple store-and-retrieve returns the same result
		local
			test: PS_GENERIC_CRUD_TEST [DATA_STRUCTURES_CLASS_1]
		do
			create test.make (repository)
			test.test_insert (test_data.data_structures_1)
				-- TODO: They are probably not equal, as DATA_STRUCTURES uses FLAT_CLASS, which uses REALs that have a rounding error.
			repository.wipe_out
		end

	test_update_on_reference
			-- test if an update on a referenced object works
		local

			test: PS_GENERIC_CRUD_TEST [DATA_STRUCTURES_CLASS_1]
		do
			repository.wipe_out

			create test.make (repository)
			test.test_crud_operations (
				test_data.data_structures_1,
				agent (retrieved_obj: DATA_STRUCTURES_CLASS_1)
					do
						retrieved_obj.array_1 [1].update
					end
			)
			repository.wipe_out
		end

	test_shared_special
			-- test if an update on a shared special instance works
		local
			a,b: SHARED_SPECIAL
			special: SPECIAL [INTEGER]
			query: PS_QUERY [SHARED_SPECIAL]
			transaction: PS_TRANSACTION
		do
			repository.wipe_out
			create special.make_filled (0, 2)
			create a.make (special)
			create b.make (special)

			transaction := repository.new_transaction

			transaction.insert (a)
			transaction.insert (b)
			--executor.execute_insert (a)
			--executor.execute_insert (b)

			special [0] := 1

			transaction.update (special)
--			executor.execute_update (special)

			create query.make

			--executor.execute_query (query)
			transaction.execute_query (query)

			assert ("no result", not query.new_cursor.after)
			across query as c loop
				assert ("not void", attached c.item.special)
				assert ("equal", c.item.is_deep_equal (a) and c.item.is_deep_equal (b))
			end

			query.close
			transaction.commit
		end

		test_tuple
				-- Test a tuple store
			local
				box: ANY_BOX
				test: PS_GENERIC_CRUD_TEST [ANY_BOX]
			do
				repository.wipe_out
				create box.set_item ([create {FLAT_CLASS_1}.make, 42, "abc"])
				create test.make (repository)
				test.test_crud_operations (box,
					agent (b: ANY_BOX)
					do
						check attached {TUPLE} b.item as t and then attached {FLAT_CLASS_1} t [1] as fc then
							fc.update
						end
					end )
			end

		test_hash_table
				-- Test a tuple store
			local
				box: ANY_BOX
				hash: HASH_TABLE [FLAT_CLASS_1, STRING]
				test: PS_GENERIC_CRUD_TEST [ANY_BOX]
			do
				repository.wipe_out
				create hash.make (10)
				hash.extend (test_data.flat_class.twin, "something")
				create box.set_item (hash)
				create test.make (repository)
				test.test_crud_operations (box,
					agent (b: ANY_BOX)
					do
						check attached {HASH_TABLE [FLAT_CLASS_1, STRING]} b.item as h and then attached {FLAT_CLASS_1} h ["something"] as fc then
							fc.update
						end
					end )
			end


feature {PS_REPOSITORY_TESTS} -- Polymorphism

	all_polymorphism_tests
		do
			test_no_polymorphism
			test_basic_polymorphism
			test_expanded_object
			test_generic_object
			test_referenced_list
			test_subtype_of_string
			test_chinese_strings
		end

	test_no_polymorphism
			-- A normal test with ANY_BOX not involving polymorphism
		local
			link: ANY_BOX
			test: PS_GENERIC_CRUD_TEST [ANY_BOX]
		do
			create link.set_item (create {ANY}.default_create)
			create test.make (repository)
			test.test_insert (link)
			repository.wipe_out
		end


	test_basic_polymorphism
			-- A test with an ANY_BOX, and a PERSON attached at runtime
		local
			link: ANY_BOX
			test: PS_GENERIC_CRUD_TEST [ANY_BOX]
		do
			create link.set_item (test_data.people.first)
			create test.make (repository)
			test.test_insert (link)
			repository.wipe_out
		end

	test_expanded_object
			-- A test with ANY_BOX and an INTEGER attached at runtime
		local
			link: ANY_BOX
			test: PS_GENERIC_CRUD_TEST [ANY_BOX]
		do
			create link.set_item (3)
			create test.make (repository)
			test.test_insert (link)
			repository.wipe_out
		end

	test_generic_object
			-- Test a store with a generic object
		local
			list: LINKED_LIST [ANY]
			test: PS_GENERIC_CRUD_TEST [LINKED_LIST [ANY]]
		do
			create list.make
			list.fill (test_data.people)
			create test.make (repository)
			test.test_insert (list) -- BUG: the elements don't get loaded.
			repository.wipe_out
		end

	test_referenced_list
			-- Test when an attribute has declared type LINKED_LIST [ANY] but dynamic type LINKED_LIST [PERSON]
		local
			box: ANY_LIST_BOX
			list: LINKED_LIST [TEST_PERSON]
			test: PS_GENERIC_CRUD_TEST [ANY_LIST_BOX]
		do
			create list.make
			list.fill (test_data.people)
			create box.set_items (list)
			create test.make (repository)
			-- Regression test: the list within box got initialized as LINKED_LIST [ANY], and the list was empty.
			test.test_insert (box)
			repository.wipe_out
		end

	test_subtype_of_string
			-- Check if the correct runtime type gets generated
		local
			first, last: FILE_NAME
			person: TEST_PERSON
			test: PS_GENERIC_CRUD_TEST [TEST_PERSON]
		do
			create first.make_from_string ("some")
			create last.make_from_string ("string")
			create person.make (first, last, 0)
			create test.make (repository)
			-- Regression test: instead of creating FILE_NAME objects, a STRING object was created.
			test.test_insert (person)
			repository.wipe_out
			create test.make (repository)
			test.test_crud_operations (person, agent (p:TEST_PERSON) do p.add_item end)
			repository.wipe_out
		end


	test_chinese_strings
		local
			container: ANY_BOX
			string: STRING_32
			test: PS_GENERIC_CRUD_TEST [ANY_BOX]
			conv: UTF_CONVERTER
		do
			create test.make (repository)
			string := {STRING_32} "[
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


			create container.set_item (string)
			create conv
--			print (string)
--			print (conv.string_32_to_utf_8_string_8 (string))
			test.test_insert (container)
		end



feature {NONE} -- Update agents

	update_reference (obj: REFERENCE_CLASS_1)
			-- An update on a reference in `obj'
		do
			if attached obj.refer as ref_obj then
				ref_obj.update
			end
		end

end
