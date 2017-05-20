note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEMPLATE_FILE

inherit
	TEMPLATE_COMMON

create
	make_from_file

feature {NONE} -- Initialization

	make_from_file (fn: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		require
			fn /= Void
		local
			p: PATH
		do
			create p.make_from_string (fn)
			if p.is_absolute then
				file_name := p
			else
				if attached template_context.template_folder as d then
					p := d.extended_path (p)
					file_name := p
				else
					file_name := p
				end
			end
			create values.make (10)
		end

feature -- Reset

	clear_values
		do
			values.wipe_out
			if attached template_text as tt then
				tt.clear_values
			end
		end

	clear
		do
			clear_values
			text := Void
			template_text := Void
		end

feature -- Values

	values: STRING_TABLE [detachable ANY]

	add_value (aval: detachable ANY; aname: READABLE_STRING_GENERAL)
		do
			values.force (aval, aname)
		end

feature -- Properties

	file_name: PATH

	text: detachable STRING

	template_text: detachable TEMPLATE_TEXT

feature -- Get	

	analyze
		do
			get_structure
		end

	has_template_text: BOOLEAN
		do
			Result:= template_text /= Void
		end

	has_structure: BOOLEAN
		do
			Result:= attached template_text as tt and then tt.structure_item /= Void
		end

	has_text: BOOLEAN
		do
			Result:= text /= Void
		end

	get_text
		local
			c: INTEGER
			f: PLAIN_TEXT_FILE
			s: STRING
			done: BOOLEAN
		do
			create f.make_with_path (file_name)
			c := f.count
			if c > 0 and then f.exists and then f.is_access_readable then
				f.open_read
				from
					create s.make (c)
	--				done := False
				until
					done
				loop
					f.read_stream (1_024)
					s.append (f.last_string)
					done := f.last_string.count < 1_024 or f.exhausted
				end
				f.close
			else
				s := ""
			end

			text := s
		end

	get_structure
		local
			tt: like template_text
		do
			if
				Template_context.Files.has (file_name.name) and then
				attached Template_context.Files.item (file_name.name) as tf and then
				attached tf.template_text as tf_tt
			then
				tt := tf_tt.twin
				tt.clear_values
				template_text := tt
			else
				if not has_text then
					get_text
				end
				if attached text as l_text then
					create tt.make_from_text (l_text)
					template_text := tt
					tt.get_structure
					debug ("template")
						if attached tt.structure_item as it then
							print_structure (it, 0)
						end
					end
				end
			end
		end

	print_structure (s: TEMPLATE_STRUCTURE_ITEM; alevel: INTEGER)
		do
			if attached template_text as tt then
				tt.print_structure (s, 0)
			end
		end

feature -- Access

	output: detachable STRING

	get_output
		require
			has_template_text: has_template_text
			has_structure: has_structure
		do
			if attached template_text as tt then
				tt.set_values (values)
				tt.get_output
				output := tt.output
			else
				check has_template_text: False end
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
