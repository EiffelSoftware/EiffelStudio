note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	CLI_STRING_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_cli_string
			-- New test routine
		note
			testing:  "covers/{CLI_STRING}"
		local
			str: STRING_32
			cstr: CLI_STRING
		do
			str := {STRING_32} "abc"
			create cstr.make (str)

			assert ("same plain text string", cstr.string_32.same_string (str))

			str := {STRING_32} "abc%U"
			create cstr.make (str)
			assert ("same plain text ending with null string", cstr.string_32.same_string (str))

			str := {STRING_32} ""
			create cstr.make (str)
			assert ("same empty string", cstr.string_32.same_string (str))

			str := {STRING_32} "%U"
			create cstr.make (str)
			assert ("same null char string", cstr.string_32.same_string (str))

			str := {STRING_32} "binary[%/0c000/%/0c001/%/0c002/%/0c003/%/0c004/%/0c005/]"
			create cstr.make (str)
			assert ("same binary string", cstr.string_32.same_string (str))

			str := {STRING_32} "%/0c000/%/0c001/%/0c002/%/0c003/%/0c004/%/0c005/%/0c006/%/0c007/%/0c010/%/0c011/%/0c012/%/0c013/%/0c014/%/0c015/%/0c016/%/0c017/%
				%%/0c020/%/0c021/%/0c022/%/0c023/%/0c024/%/0c025/%/0c026/%/0c027/%/0c030/%/0c031/%/0c032/%/0c033/%/0c034/%/0c035/%/0c036/%/0c037/%
				% !%"#$%%&'()*+,-./0123456789:;<=>?%
				%@abcdefghijklmnopqrstuvwxyz[\]^_%
				%`abcdefghijklmnopqrstuvwxyz{|}~%/0c177/%
				%%/0c200/%/0c201/%/0c202/%/0c203/%/0c204/%/0c205/%/0c206/%/0c207/%/0c210/%/0c211/%/0c212/%/0c213/%/0c214/%/0c215/%/0c216/%/0c217/%
				%%/0c220/%/0c221/%/0c222/%/0c223/%/0c224/%/0c225/%/0c226/%/0c227/%/0c230/%/0c231/%/0c232/%/0c233/%/0c234/%/0c235/%/0c236/%/0c237/%
				%%/0c240/%/0c241/%/0c242/%/0c243/%/0c244/%/0c245/%/0c246/%/0c247/%/0c250/%/0c251/%/0c252/%/0c253/%/0c254/%/0c255/%/0c256/%/0c257/%
				%%/0c260/%/0c261/%/0c262/%/0c263/%/0c264/%/0c265/%/0c266/%/0c267/%/0c270/%/0c271/%/0c272/%/0c273/%/0c274/%/0c275/%/0c276/%/0c277/%
				%%/0c340/%/0c341/%/0c342/%/0c343/%/0c344/%/0c345/%/0c346/%/0c347/%/0c350/%/0c351/%/0c352/%/0c353/%/0c354/%/0c355/%/0c356/%/0c357/%
				%%/0c360/%/0c361/%/0c362/%/0c363/%/0c364/%/0c365/%/0c366/%/0c327/%/0c370/%/0c371/%/0c372/%/0c373/%/0c374/%/0c375/%/0c376/%/0c337/%
				%%/0c340/%/0c341/%/0c342/%/0c343/%/0c344/%/0c345/%/0c346/%/0c347/%/0c350/%/0c351/%/0c352/%/0c353/%/0c354/%/0c355/%/0c356/%/0c357/%
				%%/0c360/%/0c361/%/0c362/%/0c363/%/0c364/%/0c365/%/0c366/%/0c367/%/0c370/%/0c371/%/0c372/%/0c373/%/0c374/%/0c375/%/0c376/%/0c377/"
			create cstr.make (str)
			assert ("same big binary string", cstr.string_32.same_string (str))
		end

end


