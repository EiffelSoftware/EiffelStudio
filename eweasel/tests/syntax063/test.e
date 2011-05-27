
class TEST
inherit ANY
inherit {NONE}
	ANY
		rename
			default as weasel,
			do_nothing as marten
		select
			$SELECTED_FEATURES
		end
create
	make

feature
	make
		do
		end
end

