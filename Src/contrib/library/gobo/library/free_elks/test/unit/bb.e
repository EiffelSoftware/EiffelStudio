class BB [G]

feature

	item: detachable G

	set_item (v: G)
		do
			item := v
		ensure
			item_set: item = v
		end

end
