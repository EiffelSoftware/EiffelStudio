note
	description: "Translates Eiffel to IV AST nodes."

class
	E2B_TRANSLATOR

inherit

	SHARED_WORKBENCH

	E2B_SHARED_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_boogie_universe: IV_UNIVERSE)
			-- Initialize translator.
		do
			translation_pool.reset
				-- Add types and features used by every system
			if attached helper.set_any_type as t then
				translation_pool.add_type (t)
			end
		end

feature -- Status report

	has_next_step: BOOLEAN
			-- Is there another step in the translation?
		do
			Result := translation_pool.has_untranslated_elements
		end

feature -- Element change

	add_input (a_input: E2B_TRANSLATOR_INPUT)
			-- Add all classes and featurse from `a_input' to be translated.
		do
			across a_input.class_list as i loop
				add_class (i)
			end
			across a_input.feature_list as i loop
				add_feature (i)
			end
			across a_input.feature_of_type_list as i loop
				add_feature_of_type (i.f, i.t)
			end
			across a_input.class_check_list as i loop
				translation_pool.add_class_check (i)
			end
		end

	add_class (a_class: CLASS_C)
			-- Add `a_class' to be translated.
		local
			l_feature: FEATURE_I
			c: CURSOR
		do
			if not helper.is_class_logical (a_class) then
				translation_pool.add_class_check (helper.constraint_type (a_class))
			end
			if a_class.has_feature_table then
				from
					a_class.feature_table.start
				until
					a_class.feature_table.after
				loop
					l_feature := a_class.feature_table.item_for_iteration
					if helper.verify_feature_in_class (l_feature, a_class) then
							-- Record current position because it can change after adding the feature.
						c := a_class.feature_table.cursor
							-- Add the feature.
						add_feature_of_type (l_feature, a_class.actual_type)
							-- Restore the current position to continue iteration.
						a_class.feature_table.go_to (c)
					end
					a_class.feature_table.forth
				end
			end
		end

	add_feature (a_feature: FEATURE_I)
			-- Add `a_feature' to be translated.
		require
			a_feature_attached: attached a_feature
		do
			add_feature_of_type (a_feature, system.class_of_id (a_feature.written_in).actual_type)
		end

	add_feature_of_type (a_feature: FEATURE_I; a_context_type: CL_TYPE_A)
			-- Add `a_feature' in context of type `a_context_type' to be translated.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		do
			translation_pool.add_feature (a_feature, helper.constraint_type (a_context_type.base_class))
		end

feature -- Basic operations

	step
			-- Do one step of the translation.
		require
			has_next_step: has_next_step
		local
			l_unit: E2B_TRANSLATION_UNIT
			l_failed: BOOLEAN
			l_error: E2B_AUTOPROOF_ERROR
		do
			if l_failed then
				if l_unit /= Void then
					translation_pool.mark_translated (l_unit)
					create l_error
					l_error.set_type ("Internal Error")
					if attached {E2B_TU_CLASS} l_unit as x then
						l_error.set_class (x.class_type.base_class)
					elseif attached {E2B_TU_FEATURE} l_unit as x then
						l_error.set_class (x.type.base_class)
						l_error.set_feature (x.feat)
					end
					l_error.set_message (messages.internal_translation_error (l_unit.id.to_string_32))
					autoproof_errors.extend (l_error)
				end
			else
				check translation_pool.has_untranslated_elements end
				l_unit := translation_pool.next_untranslated_element
				l_unit.translate
				translation_pool.mark_translated (l_unit)
			end
		rescue
			l_failed := True
			retry
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2010-2015 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
