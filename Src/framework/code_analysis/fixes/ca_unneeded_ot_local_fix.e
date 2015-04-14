note
	description: "Fixes violations of rule #5 ('Unneeded object test local')."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CA_UNNEEDED_OT_LOCAL_FIX

inherit
	CA_FIX
		redefine
			process_object_test_as,
			process_if_as,
			process_id_as
		end

create
	make_with_ot

feature {NONE} -- Initialization

	make_with_ot (a_class: attached CLASS_C; a_ot: attached OBJECT_TEST_AS)
			-- Initializes `Current' with class `a_class' and affected object test `a_ot'.
		do
			make (ca_names.unneeded_ot_local_fix + a_ot.name.name_32 + "'", a_class)
			ot := a_ot
		end

feature {NONE} -- Implementation

	ot: OBJECT_TEST_AS
			-- The affected object test.

	ot_local: INTEGER
			-- The object test local that is not needed.

	tested_expression: STRING_32
			-- The expression the object test tests.

	within_ot: BOOLEAN
			-- Might the AST visitor be within the scope of the object test
			-- local?

feature {NONE} -- Visitor

	process_object_test_as (a_ot: OBJECT_TEST_AS)
			-- Remove the object test local from `a_ot'.
		local
			l_new_ot: like a_ot
			l_printer: CA_PRETTY_PRINTER
			l_new_string: STRING_32
		do
			if ot.is_equivalent (a_ot) then
				ot_local := a_ot.name.name_id
				tested_expression := a_ot.expression.text_32 (matchlist)
					-- Let the visitor process all IDs until we have reached the end of the
					-- current if block.
				within_ot := True
					-- Getting rid of the name. Create another object test node without the
					-- object test local.
				create l_new_string.make_empty
				create l_new_ot.make (a_ot.attached_keyword (matchlist), a_ot.type, a_ot.expression, Void, Void)
				create l_printer.make (create {PRETTY_PRINTER_OUTPUT_STREAM}.make_string (l_new_string), parsed_class, matchlist)
				l_printer.process_object_test_as (l_new_ot)

				a_ot.replace_text (l_new_string, matchlist)
			end
		end

	process_if_as (a_if: IF_AS)
			-- Process the AST if node `a_if' (with a possible object test
			-- as condition). Then mark the object test local as out of scope.
		do
			Precursor (a_if)
				-- The object test local is now out of scope.
			within_ot := False
		end

	process_id_as (a_id: ID_AS)
			-- If we are within the scope of the object test then replace
			-- `a_id' by the object test expression if `a_id' is the object
			-- test local.
		do
			if within_ot and then a_id.name_id = ot_local then
					-- Replace the object test local by the expression from the object test.
				a_id.replace_text (tested_expression, matchlist)
			end
		end

end
