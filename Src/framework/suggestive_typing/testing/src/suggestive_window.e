note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	SUGGESTIVE_WINDOW

inherit
	EV_TITLED_WINDOW

	EV_SUGGESTION_ACCESS
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_with_title ("Suggestion ...")
			build_interface
			set_size (400, 400)
		end

	build_interface
		local
			vb: EV_VERTICAL_BOX
			tf: EV_SUGGESTION_TEXT_FIELD
			l_settings: EV_SUGGESTION_SETTINGS
			lab: EV_LABEL
			tf_folder, tf_fruit: EV_SUGGESTION_TEXT_FIELD
			tf_fruits: EV_MULTIPLE_SUGGESTION_TEXT_FIELD
			cwd: READABLE_STRING_GENERAL
			w: EV_WIDGET

			text: EV_SUGGESTION_TEXT
		do
			create vb
			extend (vb)
			vb.set_border_width (5)
			vb.set_padding_width (5)

			-- Normal text field
			create lab.make_with_text ("Normal text field (without suggestion_")
			vb.extend (lab)
			vb.disable_item_expand (lab)
			vb.extend (create {EV_TEXT_FIELD}.make_with_text ("this is a normal text field"))
			vb.disable_item_expand (vb.last)

			-- Fruit with automatic suggestion
			create l_settings.make
			l_settings.set_matcher (create {CASE_INSENSITIVE_SUBSTRING_SUGGESTION_MATCHER})
			l_settings.set_is_suggesting_as_typing (True)

			w := new_title ("Select a fruit (auto suggestion)", l_settings)
			vb.extend (w)
			vb.disable_item_expand (w)


			create tf.make_with_settings (create {ITERABLE_SUGGESTION_PROVIDER [READABLE_STRING_8]}.make (available_fruits), l_settings)
			tf.set_tooltip ("Select a fruit, use Ctrl+Space to get suggestion...")
			tf_fruit := tf


			vb.extend (tf_fruit)
			vb.disable_item_expand (tf_fruit)

			-- Fruit with activator # and @
			create l_settings.make
			l_settings.set_matcher (create {CASE_INSENSITIVE_SUBSTRING_SUGGESTION_MATCHER})
			l_settings.register_suggestion_activator_character ('@', True)
			l_settings.register_suggestion_activator_character ('#', False)

			w := new_title ("Select a fruit (with key activators..)", l_settings)
			vb.extend (w)
			vb.disable_item_expand (w)


			create tf.make_with_settings (create {ITERABLE_SUGGESTION_PROVIDER [READABLE_STRING_8]}.make (available_fruits), l_settings)
			tf.set_tooltip ("Select a fruit, use Ctrl+Space, or @ or #  to get suggestion...")
			tf_fruit := tf


			vb.extend (tf_fruit)
			vb.disable_item_expand (tf_fruit)

			-- Fruits
--			create lab.make_with_text ("Select several fruits")
--			vb.extend (lab)
--			vb.disable_item_expand (lab)

			create l_settings.make
			l_settings.register_suggestion_activator_character ('@', True)
			l_settings.register_suggestion_activator_character ('#', False)
			l_settings.set_matcher (create {CASE_INSENSITIVE_SUBSTRING_SUGGESTION_MATCHER})
			l_settings.set_searched_text_agent (agent (s: STRING_32): STRING_32
					do
						Result := s.string
						Result.left_adjust
					end)

			w := new_title ("Select several fruits", l_settings)
			vb.extend (w)
			vb.disable_item_expand (w)

			create tf_fruits.make_with_settings (create {ITERABLE_SUGGESTION_PROVIDER [READABLE_STRING_8]}.make (available_fruits), l_settings)

			tf_fruits.set_is_searched_text_separator_agent (agent (c: CHARACTER_32): BOOLEAN
					do
						Result := c.is_space or c = ','
					end)
			tf_fruits.set_tooltip ("Select several fruits, use Ctrl+Space, or @ or #  to get suggestion...")


			vb.extend (tf_fruits)
			vb.disable_item_expand (tf_fruits)


			-- Browse
			cwd := (create {EXECUTION_ENVIRONMENT}).current_working_path.name
--			create lab.make_with_text ({STRING_32} "Select file under " + cwd)
--			vb.extend (lab)
--			vb.disable_item_expand (lab)

			create l_settings.make
			l_settings.set_matcher (create {CASE_INSENSITIVE_STRING_STARTS_WITH_SUGGESTION_MATCHER})
			l_settings.set_is_suggesting_as_typing (True)
--			l_settings.register_suggestion_activator_character ({OPERATING_ENVIRONMENT}.directory_separator, True)

			w := new_title ({STRING_32} "Select file under " + cwd, l_settings)
			vb.extend (w)
			vb.disable_item_expand (w)


			create tf.make_with_settings (create {FILE_SUGGESTION_PROVIDER}.make (cwd), l_settings)
			tf.set_tooltip (lab.text)
			tf_folder := tf
			vb.extend (tf)
			vb.disable_item_expand (tf)

			-- Inside an EV_TEXT ... ?

			create l_settings.make
			l_settings.set_matcher (create {CASE_INSENSITIVE_SUBSTRING_SUGGESTION_MATCHER})
			l_settings.set_is_suggesting_as_typing (True)

--			l_settings.*set
			create text.make_with_settings (create {ITERABLE_SUGGESTION_PROVIDER [READABLE_STRING_8]}.make (available_fruits), l_settings)
--			text.set_is_searched_text_separator_agent (agent (c: CHARACTER_32): BOOLEAN
--					do
--						Result := c.is_space or c = ','
--					end)
			vb.extend (text)
			text.set_text ("Inline suggesting typing demo")
		end

	new_title (a_text: READABLE_STRING_GENERAL; a_settings: EV_SUGGESTION_SETTINGS): EV_WIDGET
	--a_activators: detachable ITERABLE [TUPLE [char: CHARACTER_32; is_included: BOOLEAN]]; a_auto: BOOLEAN): EV_WIDGET
		local
			s: STRING_32
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
			cb: EV_CHECK_BUTTON
		do
			create hb
			create lab.make_with_text (a_text)
			hb.extend (lab)
			hb.disable_item_expand (lab)
			hb.extend (create {EV_CELL})


			create cb.make_with_text ("auto")
			cb.set_tooltip ("Suggestions appears as typing")
			if a_settings.is_suggesting_as_typing then
				cb.enable_select
			end
			hb.extend (cb)
			cb.select_actions.extend (agent (i_cb: EV_CHECK_BUTTON; i_settings: EV_SUGGESTION_SETTINGS)
					do
						i_settings.set_is_suggesting_as_typing (i_cb.is_selected)
					end(cb, a_settings)
				)

			hb.disable_item_expand (cb)
			if attached a_settings.suggestion_activator_characters as l_activators then
				across
					l_activators as ic
				loop
					create s.make_filled (ic.key, 1)
					create cb.make_with_text (s)
					cb.set_tooltip ({STRING_32} "Suggestions appears when '"+ s +"' as typed")
					cb.enable_select
					if not ic.item then
						cb.set_tooltip (cb.tooltip + ".%N The character will be removed.")
					end
					hb.extend (cb)
					hb.disable_item_expand (cb)
					cb.select_actions.extend (agent (i_cb: EV_CHECK_BUTTON; d: TUPLE [char: CHARACTER_32; is_included: BOOLEAN]; i_settings: EV_SUGGESTION_SETTINGS)
							do
								if i_cb.is_selected then
									i_settings.register_suggestion_activator_character (d.char, d.is_included)
								else
									i_settings.unregister_suggestion_activator_character (d.char)
								end
							end(cb, [ic.key, ic.item], a_settings)
						)
				end
			end
			Result := hb
		end

feature -- Access

	available_fruits: ARRAY [READABLE_STRING_8]
		do
			Result := <<"Orange", "Pineapple", "Apple", "Ananas", "Banana", "Peach", "Pear", "Kiwi", "Watermelon", "Lemon", "Lime", "Blueberry", "Blackberry", "Raspberry">>
		end

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True

end
