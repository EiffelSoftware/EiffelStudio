note
	description: "Task to translate a chunk of Eiffel to an IV AST."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TRANSLATE_CHUNK_TASK

inherit

	ROTA_TASK_I

	E2B_SHARED_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_translator_input: E2B_TRANSLATOR_INPUT; a_boogie_universe: IV_UNIVERSE)
			-- Initialize task.
		do
			create translator.make (a_boogie_universe)
			translator.add_input (a_translator_input)

			has_next_step := True
		end

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature {ROTA_S, ROTA_TASK_I} -- Basic operations

	started: BOOLEAN

	step
			-- <Precursor>
		local
			l_end_tick: NATURAL
			l_untranslated: INTEGER
			l_total: INTEGER
		do
				-- Translate features for some milliseconds
			from
				l_end_tick := end_tick_for_duration (100)
			until
				clock_ticks > l_end_tick or not translator.has_next_step
			loop
				translator.step
			end
			has_next_step := translator.has_next_step

			l_untranslated := translation_pool.untranslated_elements.count
			l_total := l_untranslated + translation_pool.translated_elements.count
			set_status (messages.status_translating (l_untranslated, l_total))
		end

	cancel
			-- <Precursor>
		do
			has_next_step := False
		end

feature {E2B_VERIFY_TASK} -- Implementation

	translator: E2B_TRANSLATOR
			-- Translator to generate Boogie code.

	clock_ticks: NATURAL
			-- Elapsed clock ticks since start of program.
		external "C inline use <time.h>"
		alias
			"return clock();"
		end

	end_tick_for_duration (a_milliseconds: REAL): NATURAL
			-- Tick count for `a_milliseconds' in future.
		external "C inline use <time.h>"
		alias
			"return clock() + ($a_milliseconds * (CLOCKS_PER_SEC / 1000));"
		end

end
