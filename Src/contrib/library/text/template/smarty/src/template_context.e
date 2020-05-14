note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_CONTEXT

create
	make

feature

	make
		do
			create runtime_values.make (10)
			create archives.make (10)
			create template_custom_action_items.make (3)
			template_custom_action_items.compare_objects
		end

	clear_values
		do
			runtime_values.wipe_out
		end

	clear
		do
			current_template_text := Void
		end

	runtime_values: STRING_TABLE [detachable ANY]

	current_template_text: detachable TEMPLATE_TEXT

	current_template_string: detachable READABLE_STRING_8
		do
			if attached current_template_text as ct then
				Result := ct.text
			end
		end

	values: STRING_TABLE [detachable ANY]
		require
			current_template_text /= Void
		do
			if attached current_template_text as ctt then
				Result := ctt.values
			else
				check has_current_template_text: False end
				create Result.make (0)
			end
		end

	template_folder: detachable PATH

	template_file (fn: READABLE_STRING_GENERAL): PATH
		do
			create Result.make_from_string (fn)
			if Result.is_absolute then
					-- Ok
			elseif attached template_folder as l_folder then
				Result := l_folder.extended_path (Result)
			end
		end

feature -- Backup

	backup
		do
			archives.force ([current_template_text, runtime_values])
			runtime_values := runtime_values.deep_twin
		end

	restore
		require
			has_archive: not archives.is_empty
		local
			b: TUPLE [tpl_text: like current_template_text; rt_values: like runtime_values]
		do
			b := archives.last
			current_template_text := b.tpl_text
			runtime_values := b.rt_values
			archives.finish
			archives.remove
		end

	archives: ARRAYED_LIST [TUPLE [like current_template_text, like runtime_values]]

feature -- Change

	set_template_folder (v: like template_folder)
		do
			template_folder := v
		end

	set_current_template_text (v: like current_template_text)
		do
			current_template_text := v
		end

	add_runtime_value (va: detachable ANY; ks: STRING)
		do
			runtime_values.force (va, ks)
		end

	remove_runtime_value (ks: STRING)
		do
			runtime_values.remove (ks)
		end

	add_value (va: detachable ANY; ks: READABLE_STRING_GENERAL)
		require
			current_template_text /= Void
		do
			values.force (va, ks)
		end

	remove_value (ks: READABLE_STRING_GENERAL)
		require
			current_template_text /= Void
		do
			values.remove (ks)
		end

	append_values (v: like values)
		require
			current_template_text /= Void
		do
			across
				v as c
			loop
				add_value (c.item, c.key)
			end
		end

feature -- Specific custom actions

	template_custom_action_items: HASH_TABLE [like template_custom_action_by_id, STRING]

	template_custom_action_by_id (a_id: STRING): detachable TEMPLATE_CUSTOM_ACTION
			-- `fct (a_text, a_parameters): generated string`
		require
			a_id /= Void
		do
			Result := template_custom_action_items.item (a_id)
		end

	add_template_custom_action (act: TEMPLATE_CUSTOM_ACTION; a_id: STRING)
		do
			template_custom_action_items.force (act, a_id)
		end

	add_template_custom_function_action (fct: FUNCTION [STRING, STRING_TABLE [STRING], STRING]; a_id: STRING)
		do
			add_template_custom_action (create {TEMPLATE_CUSTOM_FUNCTION_ACTION}.make (fct), a_id)
		end

	is_valid_template_custom_action_id (a_id: STRING): BOOLEAN
		require
			a_id /= Void
		do
			Result := template_custom_action_items.has (a_id)
		end

feature -- Option

	enable_verbose
		do
			verbose := True
		end

	disable_verbose
		do
			verbose := False
		end

	verbose: BOOLEAN

	expression_error_report_function: detachable FUNCTION [TUPLE [obj: detachable ANY; mesg: STRING_8], detachable ANY]
			-- Function handling expression `mesg` on object `obj`, when an error occurs,
			-- by returning a specific value for the expected result.
			-- useful to return either a blank string, or an error message 
			--     (such as missing field, or Call on Void target).
			-- Default: Void.

	set_expression_error_report_function (fct: like expression_error_report_function)
		do
			expression_error_report_function := fct
		end

feature -- Caching

	Files: STRING_TABLE [TEMPLATE_FILE]
		once
			create Result.make (10)
		end


note
	copyright: "2011-2017, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end -- class TEMPLATE_CONTEXT
