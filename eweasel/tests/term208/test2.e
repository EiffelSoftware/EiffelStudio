
class TEST2
feature
	creatable_directories: ARRAYED_LIST [STRING]
		do
		ensure
			result_contains: Result.for_all (agent (a_item: STRING_8): BOOLEAN do Result := not a_item.is_empty end)
		end

end
