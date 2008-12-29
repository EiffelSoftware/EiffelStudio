note
	description: "Grid item for metric path criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_PATH_CRITERION_GRID_ITEM

inherit
	EB_METRIC_CRITERION_GRID_ITEM [EB_METRIC_PATH_CRITERION]
		undefine
			default_create,
			is_equal,
			copy
		end

	STRING_PROPERTY
		rename
			make as old_make
		end

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize.
		do
			old_make ("")
			set_tooltip (metric_names.f_insert_text_here)
			set_value ("")
		end

feature -- Access

	grid_item: EV_GRID_ITEM
			-- Grid item for Current property
		do
			Result := Current
		end

feature -- Setting

	load_criterion (a_criterion: EB_METRIC_PATH_CRITERION)
			-- Load `a_criterion' into Current.
		do
			set_value (a_criterion.path.as_string_32)
		end

	store_criterion (a_criterion: EB_METRIC_PATH_CRITERION)
			-- Store Current in `a_criterion'.
		local
			l_value: like value
		do
			l_value := value
			if l_value = Void then
				l_value := ("").as_string_32
			end
			a_criterion.set_path (l_value.as_string_8)
		end

end
