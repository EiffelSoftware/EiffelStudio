indexing
	description: "Generates the search database."
	author: "Vincent Brendel"

class
	E_INSPECTOR

creation
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			create keys.make(0)
		end

	create_from_topic(topic: E_TOPIC) is
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
			add_keyword(words, topic_id)
		end

	add_keyword(word, topic_id:STRING) is
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

	get_topics(word:STRING):SORTED_TWO_WAY_LIST[STRING] is
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

	load_from_file is
		do
		end

	save_to_file is
		do
		end

	keys: HASH_TABLE[ SORTED_TWO_WAY_LIST[STRING], STRING ]
		-- Lookup table of topic id's by keyword.

invariant
	keys_not_void: keys /= Void

end -- class E_INSPECTOR
