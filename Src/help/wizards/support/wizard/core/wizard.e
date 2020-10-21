note
	description: "Summary description for {WIZARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD

feature {NONE} -- Initialization

	make (app: WIZARD_APPLICATION)
		do
			application := app
		end

feature {WIZARD_GENERATOR} -- Access		

	application: WIZARD_APPLICATION

feature -- Access

	title: STRING_32
		deferred
		end

feature -- Factory

	wizard_generator : WIZARD_GENERATOR
		deferred
		end

	new_page (a_page_id: READABLE_STRING_8): WIZARD_PAGE
		do
			Result := application.new_page (a_page_id)
		end

	next_page (a_current_page: detachable WIZARD_PAGE): WIZARD_PAGE
		deferred
		end

	notfound_page: WIZARD_PAGE
		once
			Result := new_page ("notfound")
			Result.set_title ("Page Not Found")
			Result.set_subtitle ("Internal error in the wizard state machine.")

--			if Result.previous_page /= Void then
--				Result.set_back_action (agent on_back)
--			end
--			Result.set_cancel_action (agent on_cancel)
		end

feature -- Pages

	first_page: WIZARD_PAGE
		deferred
		end

	final_page: WIZARD_PAGE
		deferred
		end

feature -- Events

	on_back
		do
			application.on_back
		end

	on_cancel
		do
			application.on_cancel
		end

	on_next
		do
			application.on_next
		end

	on_finish
		do
			application.on_finish
		end

feature {NONE} -- Initialization

	formatted_title_value_items (lst: ITERABLE [TUPLE [title: READABLE_STRING_GENERAL; value: READABLE_STRING_GENERAL]]): STRING_32
		local
			t: STRING_32
			m: INTEGER
		do
			across
				lst as ic
			loop
				m := m.max (ic.item.title.count)
			end
			m := m + 1

			create Result.make_empty
			across
				lst as ic
			loop
				create t.make_from_string_general (ic.item.title)
				t.append (create {STRING_32}.make_filled (' ', m - t.count))
				t.append_character (':')
				t.append_character (' ')
				t.append_string_general (ic.item.value)
				t.append_character ('%N')

				Result.append (t)
			end
		end

end
