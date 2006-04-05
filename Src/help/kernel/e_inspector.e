indexing
	description: "Generates the search database."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel"

class
	E_INSPECTOR

inherit
	STORABLE

creation
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			create keys.make(0)
		end

	create_from_topic(topic: E_TOPIC) is
			-- Create the database from (the root-) topic.
		require
			not_void: topic /= Void
		do
			process_topic(topic)
			if topic.contains_subtopics then
				from
					topic.subtopics.start
				until
					topic.subtopics.after
				loop
					create_from_topic(topic.subtopics.item)
					topic.subtopics.forth
				end
			end
		end

	process_topic(topic: E_TOPIC) is
			-- Look through a topic for important tags.
		require
			not_void: topic /= Void
		local
			parts: LINKED_LIST[E_TEXT_PART]
		do
			if topic.contains_text then
				process_text(topic.head, topic.id)
				from
					topic.paragraphs.start
				until
					topic.paragraphs.after
				loop
					check
						exists: topic.paragraphs.item.text_parts /= Void
					end
					parts := topic.paragraphs.item.text_parts
					from
						parts.start
					until
						parts.after
					loop
						if parts.item.important then
							process_text(parts.item.text, topic.id)
						end
						parts.forth
					end
					topic.paragraphs.forth
				end
			end
		end

	process_text(text, topic_id:STRING) is
			-- Add every word of a sentence to the database.
		require
			possible: text /= Void and then topic_id /= Void and then not topic_id.empty 
		local
			words:STRING
			index: INTEGER
		do
			from
				words := clone(text)
			until
				not words.has(' ')
			loop
				index := words.index_of(' ', 1)
				check
					possible: index >0
				end
				if index >1 then
					add_keyword(words.substring(1,index-1), topic_id)
				end
				words.tail(words.count-index)
			end
			if not words.empty then
				add_keyword(words, topic_id)
			end
		end

	add_keyword(word, topic_id:STRING) is
			-- Add a topic to a certain keyword.
			-- Adds the word if if was not already there.
		require
			possible: topic_id /= Void and then word /= Void and then not word.empty
		local
			stwl: SORTED_TWO_WAY_LIST[STRING]
		do
			word.to_upper
			if keys.has(word) then
				keys.item(word).extend(topic_id)
			else
				create stwl.make
				stwl.extend(topic_id)
				keys.extend(stwl, word)
			end
		end

feature -- Status report

	get_topics(word:STRING):SORTED_TWO_WAY_LIST[STRING] is
			-- Get sorted list of topics for keyword 'word'.
		require
			not_void: word /= Void
		do
			word.to_upper
			if keys.has(word) then
				Result := keys.item(word)
				Result.sort
			else
				create Result.make
			end
		ensure
			not_void: Result /= Void
		end

feature -- Implementation

	keys: HASH_TABLE[ SORTED_TWO_WAY_LIST[STRING], STRING ]
		-- Lookup table of topic id's by keyword.

invariant
	keys_not_void: keys /= Void

indexing
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
end -- class E_INSPECTOR
