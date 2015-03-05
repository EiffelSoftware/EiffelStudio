note
	description: "Summary description for {WIZARD_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_GENERATOR

feature {NONE} -- Initialization

	make (a_wizard: WIZARD)
		do
			wizard := a_wizard
			initialize
		end

	initialize
		do
			create variables.make_caseless (0)
		end

feature -- Access		

	wizard: WIZARD

	application: WIZARD_APPLICATION
		do
			Result := wizard.application
		end

feature -- Access

	variables: STRING_TABLE [READABLE_STRING_8]
			-- Variables used for template and file name resolved string.
			--| i.e to expand ${varname} in file name or file content.
			--| could be used for other purpose.

feature -- Execution

	execute (a_collection: WIZARD_DATA)
		deferred
		end

feature -- Response	

	send_response (res: WIZARD_RESPONSE)
		do
			application.send_response (res)
		end

feature -- Factory

	new_uuid: STRING_8
		local
			gen: UUID_GENERATOR
		do
			create gen
			Result := gen.generate_uuid.out
		end

feature -- Operations

	copy_file (a_src, a_target: PATH)
		local
			f,t: RAW_FILE
		do
			create f.make_with_path (a_src)
			if f.exists and f.is_readable then
				create t.make_with_path (a_target)
				if not t.exists or else t.is_writable then
					f.open_read
					t.open_write
					f.copy_to (t)
					t.close
					f.close
				end
			end
		end

feature -- Resources

	copy_resource (a_res: READABLE_STRING_8; a_target: PATH)
		do
			copy_file (application.layout.resource_location (a_res), a_target)
		end

	copy_resource_template (a_res: READABLE_STRING_GENERAL; a_target: PATH)
		do
			copy_template (application.layout.resource_location (a_res), a_target)
		end

feature -- Templates		

	is_template_file (f: PATH): BOOLEAN
			-- Is file at location `p' potentially a template?
		deferred
		end

	recursive_copy_templates (a_src: PATH; a_target: PATH)
		local
			d,td, subdir: DIRECTORY
			p, ip, tp: PATH
		do
			create d.make_with_path (a_src)
			if d.exists and then d.is_readable then
				create td.make_with_path (a_target)
				td.recursive_create_dir
				across
					d.entries as ic
				loop
					p := ic.item
					if p.is_parent_symbol or p.is_current_symbol then
					else
						ip := a_src.extended_path (p)
						create subdir.make_with_path (ip)
						tp := a_target.extended_path (resolved_path_name (p))
						if subdir.exists then
							recursive_copy_templates (ip, tp)
						else
							if is_template_file (ip) then
								copy_template (ip, tp)
							else
								copy_file (ip, tp)
							end
						end
					end
				end
			end
		end

	copy_template (a_src: PATH; a_target: PATH)
		require
			a_src_is_a_template_file: is_template_file (a_src)
		local
			f,t: PLAIN_TEXT_FILE
			line: READABLE_STRING_8
		do
			create f.make_with_path (a_src)
			if f.exists and f.is_readable then
				create t.make_with_path (a_target)
				if not t.exists or else t.is_writable then
					f.open_read
					t.create_read_write
					from
						f.read_line
					until
						f.exhausted
					loop
						line := f.last_string
						t.put_string (resolved_string_8 (line))
						t.put_new_line
						f.read_line
					end
					t.close
					f.close
				end
			end
		end

feature -- Resolvers		

	resolved_string_8 (a_text: READABLE_STRING_8): READABLE_STRING_8
		local
			s: detachable STRING_8
		do
			create s.make (a_text.count)
			append_resolved_string_to (a_text, s)
			Result := s
		end

	append_resolved_string_to (s: READABLE_STRING_GENERAL; a_output: STRING_GENERAL)
			-- Resolved name for `a_path'.
		local
			i,n,p,q: INTEGER
			k: READABLE_STRING_GENERAL
		do
			from
				i := 1
				n := s.count
				q := 0
			until
				i > n
			loop
				p := s.substring_index ("${", i)
				if p > 0 and (p > 1 implies s [p - 1] /= '$') then -- not escaped
					if p > i then
						a_output.append (s.substring (i, p - 1))
					end
					i := p
					q := s.index_of ('}', i + 2)
					if q > 0 then
						k := s.substring (p + 2, q - 1)
						if attached variables.item (k) as v then
							a_output.append (v.as_lower)
						else
							a_output.append (s.substring (p, q))
						end
						i := q + 1
					else
						a_output.append (s.substring (i, n))
						i := n + 1
					end
				else
					a_output.append (s.substring (i, n))
					i := n + 1
				end
			end
		end

	resolved_string (s: READABLE_STRING_32): READABLE_STRING_32
			-- Resolved string for `s'.
		local
			t: STRING_32
		do
			create t.make (s.count)
			append_resolved_string_to (s, t)
			Result := t
		end

	resolved_path_name (a_path: PATH): PATH
			-- Resolved name for `a_path'.
		local
			n,s: READABLE_STRING_32
		do
			n := a_path.name
			s := resolved_string (n)
			if s.same_string (n) then
				Result := a_path
			else
				create Result.make_from_string (s)
			end
		end

end
