
class TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_cfg, l_cfg1: CFG_FACTORY
			l_cfg2, l_cfg21: CFG_FACTORY_2
		do
			create l_cfg.make
			create l_cfg1.make

			check
				diff_value: l_cfg.b /= l_cfg1.b
			end

			create l_cfg2.make
			create l_cfg21.make

			check
				same_value: l_cfg2.b /= l_cfg21.b
			end
		end

end
