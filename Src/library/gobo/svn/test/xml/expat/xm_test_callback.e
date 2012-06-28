indexing

	description:

		"Test Expat callbacks through well-known XML file"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Berend de Boer and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_TEST_CALLBACK

inherit

	TS_TEST_CASE
		rename
			name as test_name
		redefine
			make_test, set_up
		end

	XM_EXPAT_PARSER 
		-- Note regular clients MUST NOT inherit from the parser
		-- but should use callback classes instead.
		rename
			make as make_expat
		export
			{ANY} all
		redefine
			on_element_declaration,
			on_attribute_declaration,
			on_xml_declaration,
			on_entity_declaration,
			on_start_tag,
			on_end_tag,
			on_content,
			on_processing_instruction,
			on_comment,
			on_doctype,
			on_end_doctype,
			on_notation_declaration,
			on_not_standalone
		end

	KL_IMPORTED_STRING_ROUTINES
	KL_SHARED_OPERATING_SYSTEM

create

	make_default

feature {NONE} -- Initialization

	make_test (an_id: INTEGER; a_variables: like variables) is
			-- Create a new test case with id `an_id'.
		do
			precursor (an_id, a_variables)
			make_expat
		end

feature -- Execution

	set_up is
			-- Setup for a test.
		do
			make_expat
		end

feature -- Tests

	test_callback is
		do
			if not operating_system.is_dotnet then
				do_test_callback
			end
		end

feature {NONE} -- Test

	do_test_callback is
		local
			a_file: KL_TEXT_INPUT_FILE
		do
				-- report version
			assert ("Expat version", version /= Void)

			create a_file.make ("test.xml")
			a_file.open_read
			assert ("a_file_is_open_read", a_file.is_open_read)
			parse_from_stream (a_file)
			assert ("parsing is correct.", is_correct)

				-- report results
			assert ("on_xml_declaration called.", on_xml_declaration_called)
			assert ("on_xml_declaration matches input.", on_xml_declaration_matches)

			assert ("on_doctype called.", on_doctype_called)
			assert ("on_doctype matches input.", on_doctype_matches)
			assert ("on_end_doctype not called.", on_end_doctype_called)

			assert ("on_not_standalone should not be called.", not on_not_standalone_called)

			assert ("on_element_declaration called.", on_element_declaration_called)
			assert ("on_element_declaration matches input.", on_element_declaration_matches)

			assert ("on_attribute_declaration called.",  on_attribute_declaration_called)
			assert ("on_attribute_declaration matches input.", on_attribute_declaration_matches)

			assert ("on_entity_declaration called.", on_entity_declaration_called)
			assert ("on_entity_declaration matches input.", on_entity_declaration_matches)

			assert ("on_notation_declaration called.", on_notation_declaration_called)
			assert ("on_notation_declaration did match input.", on_notation_declaration_matches)

			assert ("on_processing_instruction called.", on_processing_instruction_called)
			assert ("on_processing_instruction matches input.", on_processing_instruction_matches)

			assert ("on_comment called.", on_comment_called)
			assert ("on_comment matches input.", on_comment_matches)

			assert ("on_start_tag called.",  on_start_tag_called)
			assert ("on_start_tag did see the <root> tag.", on_start_tag_matches)

			assert ("on_end_tag called.", on_end_tag_called)
			assert ("on_end_tag did see the </root> tag.",  on_end_tag_matches)

			assert ("on_content called.",  on_content_called)
			assert ("on_content did match input.",  on_content_matches)
		end

feature -- State

	on_xml_declaration_called,
	on_xml_declaration_matches: BOOLEAN

	on_doctype_called,
	on_end_doctype_called,
	on_doctype_matches: BOOLEAN

	on_not_standalone_called: BOOLEAN

	on_element_declaration_called,
	on_element_declaration_matches: BOOLEAN

	on_attribute_declaration_called,
	on_attribute_declaration_matches: BOOLEAN

	on_entity_declaration_called,
	on_entity_declaration_matches: BOOLEAN

	on_notation_declaration_called,
	on_notation_declaration_matches: BOOLEAN

	on_processing_instruction_called,
	on_processing_instruction_matches: BOOLEAN

	on_comment_called,
	on_comment_matches: BOOLEAN

	on_start_tag_called,
	on_start_tag_matches: BOOLEAN

	on_end_tag_called,
	on_end_tag_matches: BOOLEAN

	on_content_called,
	on_content_matches: BOOLEAN

	Version10: UC_STRING is
		once
			create Result.make_from_string ("1.0")
		end

	ISO_8859_1: UC_STRING is
		once
			create Result.make_from_string ("ISO-8859-1")
		end

	TestDTD: UC_STRING is
		once
			create Result.make_from_string ("test.dtd")
		end

	EntityName: UC_STRING is
		once
			create Result.make_from_string ("filename")
		end

	Entity_notation: UC_STRING is
		once
			create Result.make_from_string ("gif")
		end

	Gimp: UC_STRING is
		once
			create Result.make_from_string ("gimp")
		end

	MyInstruction: UC_STRING is
		once
			create Result.make_from_string ("myinstruction")
		end

	MyData: UC_STRING is
		once
			create Result.make_from_string ("mydata")
		end

	XMLSchema: UC_STRING is
		once
			create Result.make_from_string ("http://www.w3.org/2000/10/XMLSchema-instance")
		end

	Root: UC_STRING is
		once
			create Result.make_from_string ("root")
		end

	HelloWorld: UC_STRING is
		once
			create Result.make_from_string ("Hello World!")
		end

	Comment: UC_STRING is
		once
			create Result.make_from_string (" yes, this is XML ")
		end

feature -- Handlers

	on_element_declaration (a_name: STRING; a_model: XM_DTD_ELEMENT_CONTENT) is
		do
			on_element_declaration_called := True
			if on_element_declaration_matches then
				-- declaration for other
				assert ("expected other", STRING_.same_string (a_name, "other"))
				assert ("expected sequence", a_model.is_sequence)
				assert ("expected 4 children", a_model.items.count = 4)
				assert ("repeat <a> just once", a_model.items.item (1).is_one)
				assert ("repeat <b> zero or one", a_model.items.item (2).is_zero_or_one)
				assert ("repeat <c> zero or more", a_model.items.item (3).is_zero_or_more)
				assert ("repeat <d> one or more", a_model.items.item (4).is_one_or_more)
			else
				on_element_declaration_matches :=
					STRING_.same_string (a_name, Root) and
					a_model.is_content_empty
			end
		end

	on_attribute_declaration (an_element_name, a_name: STRING; a_model: XM_DTD_ATTRIBUTE_CONTENT) is
		do
			on_attribute_declaration_called := True
			on_attribute_declaration_matches :=
				STRING_.same_string (an_element_name, Root)
		end

	on_xml_declaration (xml_version, encoding: STRING; is_standalone: BOOLEAN) is
		do
			-- we need everything for this debug class
			register_all_callbacks
			on_xml_declaration_called := True
			on_xml_declaration_matches :=
				STRING_.same_string (xml_version, Version10) and
				STRING_.same_string (encoding, ISO_8859_1) and
				not is_standalone
		end

	on_entity_declaration (
			entity_name: STRING;
			is_parameter_entity: BOOLEAN;
			value: STRING;
			an_id: XM_DTD_EXTERNAL_ID;
			notation_name: STRING) is
		do
			on_entity_declaration_called := True
			on_entity_declaration_matches :=
				STRING_.same_string (entity_name, EntityName) and
				STRING_.same_string (notation_name, Entity_notation)
		end

	on_start_tag (a_namespace, a_prefix, a_local_part: STRING) is
		do
			on_start_tag_called := True
			on_start_tag_matches := STRING_.same_string (a_local_part, Root)
		end

	on_end_tag (a_namespace, a_prefix, a_local_part: STRING) is
			-- called whenever the parser findes an end element
		do
			on_end_tag_called := True
			on_end_tag_matches := STRING_.same_string (a_local_part, Root)
		end

	on_content (chr_data: STRING) is
		do
			on_content_called := True
			on_content_matches := STRING_.same_string (chr_data, HelloWorld)
		end

	on_processing_instruction (target, data: STRING) is
		do
			on_processing_instruction_called := True
			on_processing_instruction_matches :=
				STRING_.same_string (target, MyInstruction) and
				STRING_.same_string (data, MyData)
		end

	on_comment (com: STRING) is
		do
			on_comment_called := True
			on_comment_matches := STRING_.same_string (com, Comment)
		end

	on_doctype (name: STRING; an_id: XM_DTD_EXTERNAL_ID; has_internal_subset: BOOLEAN) is
		do
			Precursor (name, an_id, has_internal_subset)
			on_doctype_called := True
			on_doctype_matches :=
				STRING_.same_string (name, Root) and
				an_id.system_id = Void and an_id.public_id = Void and
				has_internal_subset
		end

	on_end_doctype is
		do
			on_end_doctype_called := True
		end

	on_notation_declaration (notation_name: STRING; an_id: XM_DTD_EXTERNAL_ID) is
		do
			on_notation_declaration_called := True
			on_notation_declaration_matches :=
				STRING_.same_string (notation_name, Entity_notation) and
				STRING_.same_string (an_id.system_id, Gimp)
		end

	on_not_standalone: BOOLEAN is
		do
			-- error is no problem for this test
			on_not_standalone_called := True
			Result := True
		end

end
