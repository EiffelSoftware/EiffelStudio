@rem system:     "'gepp' preprocessor"
@rem compiler:   "SmallEiffel -0.78"
@rem author:     "Eric Bezault <ericb@gobosoft.com>"
@rem copyright:  "Copyright (c) 1999, Eric Bezault and others"
@rem license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
@rem date:       "$Date$"
@rem revision:   "$Revision$"


@echo ${GOBO}\src\gepp\>				loadpath.se
@echo ${GOBO}\library\loadpath.se>>		loadpath.se

set options= -boost -no_split -no_style_warning -no_gc
compile %options% GEPP execute
