note
	description: "[
			Enter class description here!
		]"

class
	DEMO_CUSTOM_SERIALIZATION

inherit
	OUTPUT_UTILITIES

create
	make

feature {NONE} -- Initialization

	make
		local
			fac: JSON_SERIALIZATION_FACTORY
			conv: JSON_SERIALIZATION
			p,p2: PERSON
			t: TEAM
			s: STRING
		do
			p := person_john_smith

			create conv
				-- When converting to JSON, use pretty indented JSON formatting.
			conv.set_pretty_printing

				 -- for PERSON_DETAILS, we could use a custom serialization,
				 -- but let's use the "reflector" one.
				 -- An annoyance is the "$TYPE" attribute in the JSON,
				 -- if this is an issue, you can disable it via
				 -- 	`conv.context.serializer_context.set_is_type_name_included (False)`
				 -- or build a custom serialization for this type PERSON_DETAILS
			conv.register_default (create {JSON_REFLECTOR_SERIALIZATION})

				-- For PERSON and TEAM, let's use custom serializtion
				-- i.e serializer and deserializer know the model interfaces,
				-- and know how to generate or use the JSON text.
			conv.register (create {PERSON_JSON_SERIALIZATION}, {detachable PERSON})

			s := conv.to_json_string (p)
			print (s)
			print ("%N")

			if attached {PERSON} conv.from_json_string (s, {PERSON}) as l_person then
				print (l_person)
			end

				--| Now let's introduce a new class TEAM

				-- And let's also use a custom serialization
				-- i.e serializer and deserializer know the model interfaces,
				-- and know how to generate or use the JSON text.
			conv.register (create {TEAM_JSON_SERIALIZATION}, {detachable TEAM})

				-- New team "The testers"
			create t.make ("The testers")
			p2 := person_gustave_eiffel
			t.put (p)
			t.put (p2)
			p.add_co_worker (p2)
			print (t)

				-- Generate the JSON string from this instance of TEAM.
			s := conv.to_json_string (t)
			print (s)
			print ("%N")

				-- Check the roundtrip solution, and build a new TEAM object from the JSON string.
			if attached {TEAM} conv.from_json_string (s, {TEAM}) as l_team then
					-- It should have the same content.
				print (l_team)
				if s.same_string (conv.to_json_string (l_team)) then
					print ("Deserialization completed successfully.%N")
				else
					print ("Data lost during deserialization!%N")
				end
			end
		end

feature -- Object factory		

	person_john_smith: PERSON
		do
			create Result.make ("John", "Smith")
			Result.set_details (create {PERSON_DETAILS}.make (10001, "New York", "USA"))
		end

	person_gustave_eiffel: PERSON
		do
			create Result.make ("Gustave", "Eiffel")
			Result.set_details (create {PERSON_DETAILS}.make (75007, "Paris", "France"))
		end

end
