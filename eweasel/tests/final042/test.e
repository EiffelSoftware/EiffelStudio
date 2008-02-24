
class TEST
create
	make

feature {NONE} -- Creation

	make
		local
			keys: ARRAY [STRING]
		do
			keys := environment.current_keys
		end

	environment: HASH_TABLE [STRING, STRING]

end
