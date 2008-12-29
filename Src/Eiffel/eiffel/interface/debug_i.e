note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	DEBUG_I

feature -- Access

	has_unnamed: BOOLEAN
			-- Are unnamed debug clauses enabled?

	is_debug (tag: STRING): BOOLEAN
			-- Is the debug compatible with tag `tag' ?
		do
			Result := tags /= Void and then tags.has (tag)
		end

	generate_keys (buffer: GENERATION_BUFFER; id: INTEGER)
			-- Generate keys C array
		require
			good_argument: buffer /= Void;
		local
			l: SORTED_TWO_WAY_LIST [STRING];
		do
			if tags /= Void then
				buffer.put_string ("static char *keys");
				buffer.put_integer (id);
				buffer.put_string ("[] = {");
				from
					l := tags;
					l.start
				until
					l.after
				loop
					buffer.put_character ('"');
					buffer.put_escaped_string (l.item)
					buffer.put_string ("%", ");
					l.forth;
				end;
				buffer.put_string ("};%N%N");
			end
		end;

	generate (buffer: GENERATION_BUFFER; id: INTEGER)
			-- Generate assertion value in `buffer'.
		require
			good_argument: buffer /= Void;
		do
			if has_unnamed then
				buffer.put_string ("{OPT_ALL | OPT_UNNAMED, (int16) ");
			else
				buffer.put_string ("{OPT_ALL, (int16) ");
			end
			if tags /= Void then
				buffer.put_integer (tags.count);
				buffer.put_string (", keys");
				buffer.put_integer (id);
				buffer.put_string ("}");
			else
				buffer.put_string ("0, (char **) 0}")
			end
		end

	make_byte_code (ba: BYTE_ARRAY)
			-- Generate byte code for current debug level
		local
			l: SORTED_TWO_WAY_LIST [STRING];
		do
			if not has_unnamed and tags = Void then
				ba.append ({DB_CONST}.Db_no)
			else
				if has_unnamed then
					ba.append ({DB_CONST}.Db_unnamed);
				else
					ba.append ({DB_CONST}.Db_tag);
				end
				if tags /= Void then
					from
						ba.append_short_integer (tags.count);
						l := tags;
						l.start
					until
						l.after
					loop
						ba.append_string (l.item);
						l.forth;
					end;
				else
					ba.append_short_integer (0)
				end
			end
		end

feature {CLASS_I} -- Update

	enable_unnamed
			-- Enable unnamed debug clauses.
		do
			has_unnamed := True
		ensure
			has_unnamed: has_unnamed
		end

	enable_tag (a_tag: STRING)
			-- Enable debug clauses with `a_tag'.
		require
			a_tag_ok: a_tag /= Void and then not a_tag.is_empty
		do
			if tags = Void then
				create tags.make
				tags.compare_objects
			end
			tags.extend (a_tag)
		end

feature {NONE} -- Implementation

	tags: TWO_WAY_SORTED_SET [STRING];
			-- Debug tags

invariant
	tags_not_empty: tags /= Void implies not tags.is_empty

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
